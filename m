Return-Path: <linux-fsdevel+bounces-7986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FD82E01A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7C41F223E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9918E0D;
	Mon, 15 Jan 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWFanYlo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C918E0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbed0713422so7030454276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705343921; x=1705948721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h71RO1NDquEnr4gtDmmeh0KDfuRnGTvN/5LqJWciXao=;
        b=PWFanYloImSYzyDoqoTyA69nj7jbjEpC6UyPJdXM6KZvqfEvuQYJGsgGyxRkmvLDmP
         HGMGLjvb0eD1Dps13pQEcAEU/J5JOGKYT3Ic+abp7Tff/RoDLrF2N7SUNO6vwuY017OA
         wmMKxssPsj/Ic3P8PQTq6zbaJlhCxGnehTQcs/fMp/eMvaiRCRR1Pn/mcQTsyoAUK6F5
         QVpq1v/PlYWNHDPDXOSBH9f6LzS/mryaqRQgJ17LbnsVTEmTbqHoTfMxjLss26TqMGWf
         mEdI8B281lEW+/IxLMMva/jFGcBObMN7P2HK3xfN/yDRX8aXfY7+EEyClt+xV1INvmZi
         MfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705343921; x=1705948721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h71RO1NDquEnr4gtDmmeh0KDfuRnGTvN/5LqJWciXao=;
        b=pfXAEuueKU+nBJFT9rU9MoguxCEmQxPIcrCylzCjnHDR22BD3Lj/6T7/JgB3mVB4GJ
         O2yjn5erWgiMt56kfLwetp+VtgTVZoyow7zv96AeBCRwvnxglyHaM92FbIHUwrLPGudh
         J3GvTfNUeHxkXq2wriRftNKpHD6yj1RxVvCr9dulvWoQQ3SjrM0Sps8GzlxMc7SFpXFU
         yYTibOIdISzLqI4Qzr4yJ/XOxbeplC+4o/9INnFoh1zxFePfP01n9F16ipkr96GTGGUT
         RIy/00FP3v519Ls2Or2L5jqJiUf2lpv/z8zHk9vDIiahlErnwIods8j83hLyyyxpZM1Q
         g1OA==
X-Gm-Message-State: AOJu0Yx3EwdGTV2qKu3PLe/FXFPyKVNsJJY9Xxl8qm3x2HbM9/CGXypY
	Btt5pezFITZjUmlH9mKWKBA53TN5wVDqZdl+2Q==
X-Google-Smtp-Source: AGHT+IEasZ8zke0C8rGvXIloFTS/ZxsYcfACcxs//8QPDynbwpqTjoH00TTO/N1uZn7b+i3uXt1z2YeGMvw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3af2:e48e:2785:270])
 (user=surenb job=sendgmr) by 2002:a05:6902:2490:b0:dbe:f1e8:ae66 with SMTP id
 ds16-20020a056902249000b00dbef1e8ae66mr231824ybb.5.1705343920890; Mon, 15 Jan
 2024 10:38:40 -0800 (PST)
Date: Mon, 15 Jan 2024 10:38:33 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240115183837.205694-1-surenb@google.com>
Subject: [RFC 0/3] reading proc/pid/maps under RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

The issue this patchset is trying to address is mmap_lock contention when
a low priority task (monitoring, data collecting, etc.) blocks a higher
priority task from making updated to the address space. The contention is
due to the mmap_lock being held for read when reading proc/pid/maps.
With maple_tree introduction, VMA tree traversals are RCU-safe and per-vma
locks make VMA access RCU-safe. this provides an opportunity for lock-less
reading of proc/pid/maps. We still need to overcome a couple obstacles:
1. Make all VMA pointer fields used for proc/pid/maps content generation
RCU-safe;
2. Ensure that proc/pid/maps data tearing, which is currently possible at
page boundaries only, does not get worse.

The patchset deals with these issues but there is a downside which I would
like to get input on:
This change introduces unfairness towards the reader of proc/pid/maps,
which can be blocked by an overly active/malicious address space modifyer.
A couple of ways I though we can address this issue are:
1. After several lock-less retries (or some time limit) to fall back to
taking mmap_lock.
2. Employ lock-less reading only if the reader has low priority,
indicating that blocking it is not critical.
3. Introducing a separate procfs file which publishes the same data in
lock-less manner.

I imagine a combination of these approaches can also be employed.
I would like to get feedback on this from the Linux community.

Note: mmap_read_lock/mmap_read_unlock sequence inside validate_map()
can be replaced with more efficiend rwsem_wait() proposed by Matthew
in [1].

[1] https://lore.kernel.org/all/ZZ1+ZicgN8dZ3zj3@casper.infradead.org/

Suren Baghdasaryan (3):
  mm: make vm_area_struct anon_name field RCU-safe
  seq_file: add validate() operation to seq_operations
  mm/maps: read proc/pid/maps under RCU

 fs/proc/internal.h        |   3 +
 fs/proc/task_mmu.c        | 130 ++++++++++++++++++++++++++++++++++----
 fs/seq_file.c             |  24 ++++++-
 include/linux/mm_inline.h |  10 ++-
 include/linux/mm_types.h  |   3 +-
 include/linux/seq_file.h  |   1 +
 mm/madvise.c              |  30 +++++++--
 7 files changed, 181 insertions(+), 20 deletions(-)

-- 
2.43.0.381.gb435a96ce8-goog


