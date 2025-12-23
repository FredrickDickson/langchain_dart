# ArbiBot – Complete Product Requirements Document (PRD)

> **Version:** 1.0 (Consolidated)
> **Status:** Build‑ready
> **Audience:** Engineering, Product, Partners, Auditors

---

## 1. Product Overview

**Product Name:** ArbiBot
**Category:** Legal AI / ADR Intelligence Platform
**Primary Market:** Ghana (future ECOWAS expansion)

**Target Users**

* Arbitrators & mediators
* Legal practitioners
* Law students & researchers
* ADR institutions (e.g. CIMA)

**Product Summary**
ArbiBot is a **multi‑agent, retrieval‑grounded AI assistant** for Ghanaian law and ADR practice. It provides **legal research, draft document preparation, CV building, and professional discovery**, while enforcing strict legal, ethical, and security guardrails.

ArbiBot **does not give legal advice**. All outputs are **draft‑only**, citation‑based, and subject to **human review**.

---

## 2. Problem Statement

* Ghanaian legal research is fragmented and largely non‑semantic
* Access to statutes and case law is limited
* Existing AI tools hallucinate legal authority
* ADR professionals lack affordable drafting and research support

**ArbiBot addresses this by:**

* Grounding answers in verified Ghanaian legal sources
* Using controlled backend‑only RAG ingestion
* Enforcing review gates and disclaimers

---

## 3. Product Principles

1. Trust > Speed
2. Drafts, not decisions
3. Citations or silence
4. Jurisdiction‑first (Ghana)
5. Human‑in‑the‑loop always

---

## 4. Feature Roadmap

### 4.1 MVP (Phase 1) – Trustworthy Legal Assistant

#### Core AI Chat

* LangGraph multi‑agent chat
* Modes:

  * Legal Research
  * Document Drafting
  * CV Builder
* Persistent chat history
* Explicit disclaimers

#### Ghanaian Statutory Research

* Backend‑ingested statutes (e.g. Act 798)
* Section‑level retrieval
* Citation‑grounded responses only
* "No authoritative source found" fallback

#### Document Drafting (Draft‑Only)

* Statement of Case
* Legal Opinion
* Submissions
* Auto‑formatting
* Mandatory approval step

#### CV Builder

* Structured profile input
* Auto‑generated CV draft
* Export PDF / DOCX

#### Security (MVP)

* Supabase Auth
* Full Row Level Security (RLS)
* User‑scoped data & embeddings

---

### 4.2 Phase 2 – Legal Intelligence Platform

* Ghanaian case law database
* Semantic case search
* Headnote extraction
* Case‑to‑statute linking
* Job discovery for arbitrators
* Document comparison & clause extraction
* Collaboration & shared workspaces

---

### 4.3 Phase 3 – Institution‑Grade Platform

* Case trend analysis (non‑predictive)
* Arbitration workflow automation
* Institutional integrations
* Multilingual summaries
* Public API & licensing

---

## 5. Mobile App Screens (MVP)

### Onboarding & Access

1. Splash
2. Welcome / Value slides
3. Login / Signup / Forgot password

### Core Navigation

4. Home Dashboard
5. Bottom Navigation (Home, Chats, Documents, Profile)

### Chat & AI

6. Chat List
7. Chat Screen
8. Source Viewer (modal)

### Legal Research

9. Research Mode Selector
10. Research Results

### Drafting

11. Draft Type Selection
12. Draft Input
13. Draft Preview
14. Approval Confirmation

### Documents & Profile

15. Documents Library
16. Document Viewer
17. CV Profile
18. CV Preview
19. Profile & Settings

---

## 6. System Architecture

Frontend (Mobile / Web)
→ Backend API (FastAPI / Node)
→ LangGraph (multi‑agent orchestration)
→ Supabase (Postgres + pgvector)
→ Supabase Storage (private)

---

## 7. Tech Stack

### Frontend

* Flutter (mobile)
* Next.js (web)

### Backend

* FastAPI (Python) or Node.js
* Supabase Auth (JWT)

### AI Layer

* LangGraph
* LLM (OpenAI or local)
* Embeddings (1536‑dim)

### Database

* Supabase Postgres
* pgvector

---

## 8. RAG & Multimodal Retrieval (Backend‑Only)

### Ingestion Model

* No frontend uploads for RAG sources
* Admin / backend ingestion only
* Verified, versioned legal documents

### Supported Sources

* Statutes
* Institutional ADR documents
* Case law (Phase 2)

### Pipeline

Upload → OCR/Text Extraction → Legal Normalization → Chunking → Embeddings → pgvector → LangGraph Retrieval

### Chunking Rules

* 500–800 tokens
* 100 token overlap
* Section‑aware boundaries

---

## 9. LangGraph Agent Design

### Core Nodes

* Router Node
* Query Parser Node
* Legal Retriever Node
* Legal Ranker Node
* Draft Generator Node
* Review Gate Node
* Citation Builder Node

---

## 10. API Endpoints (Summary)

* POST /api/chat/start
* POST /api/chat/message
* POST /api/documents/generate
* POST /api/documents/approve
* POST /api/cv/generate
* GET /api/jobs/search (Phase 2)

---

## 11. Database Schema (Supabase + pgvector)

### Core Tables

* profiles
* chats
* chat_messages
* documents
* cv_profiles

### RAG Tables

* document_sources
* document_chunks
* document_embeddings

### Phase 2 Tables

* case_law
* case_law_embeddings

---

## 12. Security & Compliance

* Supabase RLS on all tables
* Backend‑only ingestion for RAG
* User‑scoped embeddings
* Encryption at rest & in transit
* Ghana Data Protection Act (Act 843)

### Legal Safeguards

* Not legal advice disclaimers
* Draft‑only outputs
* Mandatory user approval
* No filing or representation

---

## 13. Non‑Functional Requirements

* ≥90% citation accuracy
* Zero hallucinated authority
* Scalable vector search
* Audit‑ready logs

---

## 14. Out of Scope (All Phases)

* Court filing
* Legal representation
* Binding legal advice
* Autonomous job applications

---

## 15. Delivery Plan (MVP)

Week 1: Auth, DB, base LangGraph
Week 2: RAG ingestion & retrieval
Week 3: Drafting & CV flows
Week 4: Security, QA, pilot

---

## 16. Final Positioning

**ArbiBot is legal infrastructure, not a lawyer.**
Built for trust, designed for Ghana, scalable for Africa.
