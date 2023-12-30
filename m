Return-Path: <linux-fsdevel+bounces-7031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF768820369
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930E81F2151D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389D10FF;
	Sat, 30 Dec 2023 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uN10LrAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC82569
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe47a05516so2409657276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 18:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703905001; x=1704509801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uWd3JqiAE2BBpQa8flrDjVspwGJTFaM7DQZsv7IndQE=;
        b=uN10LrAVWk/f6UnLmZdJyiNxfWgTP2OUTj3v1ZbfS18VvpKR2kZlER08qeI+D1hmhG
         yJgWJOswHp/bDCDGqEmYWhF9w3jGl0yIIlirnNea2I64ImIBRF7BbMDatD+RlUoG+IeZ
         mes1HFUaWYAjgznC9ayoFY/zQO50ZJLMH/Yx0qBP1/lKz91IICTEMi3G/c/Qj5qqn/dA
         d3nhfBnh0Aw+4B9EjuF+AJi2B74O7k2l8k8lZqotzztTontejQPk2IdcxTOo6ggvgz06
         w3eeL+ET2vsRds4zKWs8H02B/2VGmJC1O0DA9V4KbHS5RssUwoqVsomvCdzkPdFRLnyd
         bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703905001; x=1704509801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWd3JqiAE2BBpQa8flrDjVspwGJTFaM7DQZsv7IndQE=;
        b=e0jCpR9W6T664JUFmMN8SOnUEQn+A+FXxfWL1JmKuZ0AEzns8ApiDNYt0nb3WsvJy8
         VZUMD1LqxQfYabZ04E3wRY8ODO/vP4xjmdOBrYc5HnHxAR3KQYmtDNQFi4OVB+YsQRHz
         55xprZ2axlYFzdIeW1ec+Blmvn88Kdz/8XYi2vYCzS/oCwrKYYXBT1zYyhfovC1mw6lQ
         wyHPjm7LnuSqnyB+6jrbj3Bvi4+o1Wxv6ERr4vQ+5f2KJuodx8746oSyubYoNzRvWXD/
         iP2BxCsZAD8aIJSXct8GGSJGAg0Y/1HuC/mAuFj3RFCcvQf714WY6tYjivg1LN5L6Z1P
         tAHg==
X-Gm-Message-State: AOJu0YzcaV1rAJQqXQN5PxKmqrkSeYv4FGHQROEq2+/wJ6mL84nbHlIp
	I1EbdYfil7RqCEjftzPnfi8LQxEM94ynEKwVxw==
X-Google-Smtp-Source: AGHT+IHRb6MDmtyBRGquDuap6l4J0StnX2Ra/8WXL9DSsV83HHhUqhEmdZo6j2U3K5QEkTzvL3vHZ9ujVYM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:aa12:a8e:81ce:b04d])
 (user=surenb job=sendgmr) by 2002:a05:6902:561:b0:dbd:b59f:217c with SMTP id
 a1-20020a056902056100b00dbdb59f217cmr4894826ybt.6.1703905001158; Fri, 29 Dec
 2023 18:56:41 -0800 (PST)
Date: Fri, 29 Dec 2023 18:56:36 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231230025636.2477429-1-surenb@google.com>
Subject: [PATCH 1/2] selftests/mm: add separate UFFDIO_MOVE test for PMD splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a test for UFFDIO_MOVE ioctl operating on a hugepage which has to
be split because destination is marked with MADV_NOHUGEPAGE. With this
we cover all 3 cases: normal page move, hugepage move, hugepage splitting
before move.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Patch applies over mm-unstable.

 tools/testing/selftests/mm/uffd-unit-tests.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index d8091523c2df..cce90a10515a 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1199,6 +1199,16 @@ static void uffd_move_test(uffd_test_args_t *targs)
 
 static void uffd_move_pmd_test(uffd_test_args_t *targs)
 {
+	if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
+		err("madvise(MADV_HUGEPAGE) failure");
+	uffd_move_test_common(targs, read_pmd_pagesize(),
+			      uffd_move_pmd_handle_fault);
+}
+
+static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
+{
+	if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
+		err("madvise(MADV_NOHUGEPAGE) failure");
 	uffd_move_test_common(targs, read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
@@ -1330,6 +1340,13 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_feature_required = UFFD_FEATURE_MOVE,
 		.test_case_ops = &uffd_move_test_pmd_case_ops,
 	},
+	{
+		.name = "move-pmd-split",
+		.uffd_fn = uffd_move_pmd_split_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_pmd_case_ops,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.34.1


