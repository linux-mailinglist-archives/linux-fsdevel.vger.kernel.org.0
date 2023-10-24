Return-Path: <linux-fsdevel+bounces-1041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3F7D5240
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216F5B211DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202492B75A;
	Tue, 24 Oct 2023 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvFNewWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803692B5E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:46:52 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3636010A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso1012318276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155206; x=1698760006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fObhDXE+DfK48fbfXMStFHtHAmn90M4M91A2l4CxzLM=;
        b=fvFNewWrJ6myhtkKXKjtJz8cIzAVhMdqhSo1R8XR3dG9lbaEcu40daF7zkrLWvYyQC
         Q2mL5UdAfr3rTWRWlr7tfdubTPhnHuVlp5zfkMCb4p6DfWKYLDBpBxDlbioDo5ZTgZRX
         euVcheUfciQ/xmzBww2SzGQeOg/W9/euwxB82yYhQc374RWE0GnNoLePR3bCXEmQF965
         czbTs9HHTypXYJ2KkiNNw3L6nBcF2t1cFnXO3xI713cVEfoux04p9ykMWFJOpeasDkxe
         oENd442Qp97odp3mOJiUNzAJ2X+NUsAxZWMiaMCRtwsD93S0RYHH/4mfaXmqRw/S4P2K
         tOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155206; x=1698760006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fObhDXE+DfK48fbfXMStFHtHAmn90M4M91A2l4CxzLM=;
        b=svAcf+4YsMwQ348trnnDRV/blL4ytuqYZ1P1aqg9rmcZKR1P+HwkQK/WbLvd3kjN1E
         Me7FppTfGCS22KyVvQX8oWdF18XorkwTuUvYgjsqMHbAYHG/1X5rzJDhv8JvflFXNmEv
         aLM/nHscUnUHfPWaJx3KFztCvN5RmEJszVw9LYrg4L4iaaLPnaPax2YXmkuis3qSi7lG
         VlMEg6canUAeB/GVxK3Dj0Qtia8hsIynhlLIN7zNR9RAEfIaIMLOxg7q7PbUt/rCvHG5
         qr0dbth/+pce+ocf3VCkUX4KqRpjMdiGUsVSJiPEYpTLQjy1j9qjLB0uzRnIGiZSB+cV
         L/9w==
X-Gm-Message-State: AOJu0YxAkemCjVsiH2ZcbcF/hfn0GcQ+YaIdv/NSJFaIYNcWhAV5lzyU
	PINbZ1H9vEy5J83FenulU/9ZGs/JHD4=
X-Google-Smtp-Source: AGHT+IGzqDmmVKWAX0qOLCG4zSSOu2XUUgzUKaIXDvA8+3j+t9o+p5RCbsfa+aQ1r6gMSAIrcYIsUr6/0f0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:5008:0:b0:da0:2b01:7215 with SMTP id
 e8-20020a255008000000b00da02b017215mr55818ybb.10.1698155205957; Tue, 24 Oct
 2023 06:46:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:45:59 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-3-surenb@google.com>
Subject: [PATCH v2 02/39] scripts/kallysms: Always include __start and __stop symbols
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..47978efe4797 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -204,6 +204,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -211,6 +216,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.42.0.758.gaed0368e0e-goog


