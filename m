Return-Path: <linux-fsdevel+bounces-438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F157CAF29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B467228169D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76D30F90;
	Mon, 16 Oct 2023 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI3ZRLWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B027EFB;
	Mon, 16 Oct 2023 16:27:15 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05862702;
	Mon, 16 Oct 2023 09:27:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1271860f8f.0;
        Mon, 16 Oct 2023 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697473627; x=1698078427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMYUQ2LS/1q5+Qfwe+X4lk99RPotlvjWnMGp/QgUzgQ=;
        b=bI3ZRLWyiIbeCWzm9aIJlt5qFGaHQu2iSHs817EErRgYQeM7oUW6UxHkAZMqX5BtRR
         qqgjnBruifgjl77WNDNjwjrNbMCNLxyTlN0C4Z5yP3AxLS8snUG0DLIUV29XIimqYz8a
         dOndkALntceUqHv8AWMzpVbrp/NycAbfKAYfUDFsdSFcTxkI/PfvSOj6IDuJGscqWJ/J
         uZISZzNLRrOTZfvATSt/P7CLHvLpCdooKAEg2CsJdivbtVQge7SphpCP4KARfJ/maoPG
         6nYlBecBriPWDXBRYjbDK/5m7Y64e5v2g9z7em5pPEs2y6OUz7XyMU/WIeuRql1FwYOi
         yjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697473627; x=1698078427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMYUQ2LS/1q5+Qfwe+X4lk99RPotlvjWnMGp/QgUzgQ=;
        b=sJZoKc/cZEd39LDLQx63t45NmA21rehE04JxaregzMEow1jz7PtjheWa4cNw/4rRd+
         JwVppUjX8vRwOyuzafwdkofn8AIOwQcikRmdawBQFKRrsdRNRqeRVjGZ/+pXzPyw6vMl
         eb4wH06C62/6Z/QH3EVIaA4SlF7IhFfDPE/2Nq1coleEuphmIg8RP9MUCGYlT+YIs6oE
         LxSUXX5XN/bndiYLwBl0jFBpswlwBm338y3PplP5rM/hTD+sSD/ufgK9jlh9WCzEq0SP
         Q6FcJ0yAHkC373300w24usTPt0PhEOA874NveUlXFnkmOiXMgro5dV5FNVix7XjJbNA8
         7VdQ==
X-Gm-Message-State: AOJu0YysZWoU2veiGmng9d5earCjfXVJ9wBH5r4rhdZ64VjFa/kqzZwd
	4a9nNbzDoeZBC8wtDXUsqkA=
X-Google-Smtp-Source: AGHT+IGZbYa0CCoiFXxwCOjLMGFV+q0rjVMSOl7t/xlR4Yh18QMRi2gEGD/dpfEILIzP2v7wvi5ucw==
X-Received: by 2002:adf:f1c5:0:b0:32d:bf1c:ce65 with SMTP id z5-20020adff1c5000000b0032dbf1cce65mr724254wro.22.1697473626397;
        Mon, 16 Oct 2023 09:27:06 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm27415367wrw.104.2023.10.16.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:27:05 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:27:04 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org
Subject: Re: [PATCH v4 3/3] mm: perform the mapping_map_writable() check
 after call_mmap()
Message-ID: <c9eb4cc6-7db4-4c2b-838d-43a0b319a4f0@lucifer.local>
References: <cover.1697116581.git.lstoakes@gmail.com>
 <55e413d20678a1bb4c7cce889062bbb07b0df892.1697116581.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e413d20678a1bb4c7cce889062bbb07b0df892.1697116581.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 06:04:30PM +0100, Lorenzo Stoakes wrote:
> In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap()
> handler to do so. We would otherwise fail the mapping_map_writable() check
> before we had the opportunity to avoid it.
>
> This patch moves this check after the call_mmap() invocation. Only memfd
> actively denies write access causing a potential failure here (in
> memfd_add_seals()), so there should be no impact on non-memfd cases.
>
> This patch makes the userland-visible change that MAP_SHARED, PROT_READ
> mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.
>
> There is a delicate situation with cleanup paths assuming that a writable
> mapping must have occurred in circumstances where it may now not have. In
> order to ensure we do not accidentally mark a writable file unwritable by
> mistake, we explicitly track whether we have a writable mapping and
> unmap only if we do.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
[snip]

Andrew, could you apply the following -fix patch to this? As a bug was
detected in the implementation [0] - I was being over-zealous in setting
the writable_file_mapping flag and had falsely assumed vma->vm_file == file
in all instances of the cleanup. The fix is to only set it in one place.

[0]: https://lore.kernel.org/all/CA+G9fYtL7wK-dE-Tnz4t-GWmQb50EPYa=TWGjpgYU2Z=oeAO_w@mail.gmail.com/

----8<----
From 7feea6faada5b10a872c24755cc630220cba619a Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Mon, 16 Oct 2023 17:17:13 +0100
Subject: [PATCH] mm: perform the mapping_map_writable() check after
 call_mmap()

Do not set writable_file_mapping in an instance where it is not appropriate
to do so.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7f45a08e7973..8b57e42fd980 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2923,10 +2923,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	mm->map_count++;
 	if (vma->vm_file) {
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-		if (vma_is_shared_maywrite(vma)) {
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
-			writable_file_mapping = true;
-		}
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
 		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-- 
2.42.0


