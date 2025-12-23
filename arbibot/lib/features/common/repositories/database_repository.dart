import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:arbibot/core/services/supabase_service.dart';

final databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return DatabaseRepository(supabase);
});

class DatabaseRepository {
  final SupabaseClient _supabase;

  DatabaseRepository(this._supabase);

  // --- Profiles ---
  Future<void> createProfile({
    required String id,
    required String email,
    String? fullName,
    String? avatarUrl,
  }) async {
    await _supabase.from('profiles').upsert({
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
    return response;
  }

  // --- Chats ---
  Future<String> createChat(String userId, String title) async {
    final response = await _supabase.from('chats').insert({
      'user_id': userId,
      'title': title,
    }).select().single();
    return response['id'];
  }

  Future<List<Map<String, dynamic>>> getChats(String userId) async {
    final response = await _supabase
        .from('chats')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> saveMessage({
    required String chatId,
    required String role, // 'user' or 'ai'
    required String content,
  }) async {
    await _supabase.from('chat_messages').insert({
      'chat_id': chatId,
      'role': role,
      'content': content,
    });
  }

  Stream<List<Map<String, dynamic>>> getMessagesStream(String chatId) {
    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);
  }

  // --- Documents ---
  Future<void> saveDocument({
    required String userId,
    required String title,
    required String content,
    required String type, // 'draft', 'upload'
  }) async {
    await _supabase.from('documents').insert({
      'user_id': userId,
      'title': title,
      'content': content,
      'type': type,
    });
  }

  Future<List<Map<String, dynamic>>> getDocuments(String userId) async {
    final response = await _supabase
        .from('documents')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
