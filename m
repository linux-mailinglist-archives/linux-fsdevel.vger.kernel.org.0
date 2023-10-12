Return-Path: <linux-fsdevel+bounces-187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38D7C73A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149791C211F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEE3399B;
	Thu, 12 Oct 2023 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0R5J90V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6F2943D;
	Thu, 12 Oct 2023 17:04:36 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F8DB7;
	Thu, 12 Oct 2023 10:04:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so12732125e9.3;
        Thu, 12 Oct 2023 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697130273; x=1697735073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxblbh/t0mrVonJh8ZCDwMUCuDrP2ztYXAQn+IoFI4M=;
        b=V0R5J90V2xW9UU8bVpqDEWEAHq/6sUOWubdxEFqDkOurzjiFFw44FhN9yhKp6AZeke
         GcpwhpfXUt2gtCaZ/em+TNdC3se4z+C+sf3CJlaCZuuqPk0F+bLm7txaHrrzpK5gH30b
         yc3sugmu8G4qu15oerjq+zA36w83seU9EI/Lrgt7OqJ50Eeyj+kC2rMxizniZfPWnvM9
         R0EgQclCZOVi79FLHXKVVTq5BjrHe6Q1+/h3jr0bhSBlPqUTcq8TI8Z+uC0DZBhrYPzW
         ZNNUf0uEAfqi9R9gBPupdCJfMjbvtyO0YPauR8oypNSoPtEIYUlGjGdZtD1rjpqpaz1P
         mj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130273; x=1697735073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxblbh/t0mrVonJh8ZCDwMUCuDrP2ztYXAQn+IoFI4M=;
        b=U+KcVmz+em6ZfSzCGW7k4VTemiOqJgU7QUEL44EWNm3KiOT15ZEJ4yiY2g7upmB/pC
         waIotTromMulIthPpItoOi0cYhgdrrfEGlqX24aUsxAodqKGIN1z5ZXem3AUOuRRRJ19
         RM3adjTtHIfwtEmHtxdU40E6RaD/mmn6TGuj6kSyBdpJetugqrq+PGAyRToSRwiNDtLh
         7JH6X2r68UUyciD5tl7P+X/9qdCY1ZlG6dUCxarWI6l08cHWJJyVyhMHkADORR2WXiLB
         F8Pn+6SorveBUCs+WgX1JXTN3e9ON7QYp+kjvfdyN4L7e0ryg8S83ztUSyA9gJjFCd+V
         TGvg==
X-Gm-Message-State: AOJu0Yy9dn+/RYzaT3dbNh1wGBpvsM9ilSeOE2rCM3/U/d0sk1oXtvMg
	INrsaihaz0qKNIErpuOw7qY=
X-Google-Smtp-Source: AGHT+IGvK0IbNKRWQIhKPbCMMuEMig/luZu/oW3qen35wW7u6BbnRgrpYxNQs0mm4SkyvjOQHZ5slw==
X-Received: by 2002:a05:6000:186:b0:324:8353:940e with SMTP id p6-20020a056000018600b003248353940emr21204555wrx.34.1697130273071;
        Thu, 12 Oct 2023 10:04:33 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffd50000000b003197869bcd7sm18875418wrs.13.2023.10.12.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:04:32 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 0/3] permit write-sealed memfd read-only shared mappings
Date: Thu, 12 Oct 2023 18:04:27 +0100
Message-ID: <cover.1697116581.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The man page for fcntl() describing memfd file seals states the following
about F_SEAL_WRITE:-

    Furthermore, trying to create new shared, writable memory-mappings via
    mmap(2) will also fail with EPERM.

With emphasis on 'writable'. In turns out in fact that currently the kernel
simply disallows all new shared memory mappings for a memfd with
F_SEAL_WRITE applied, rendering this documentation inaccurate.

This matters because users are therefore unable to obtain a shared mapping
to a memfd after write sealing altogether, which limits their
usefulness. This was reported in the discussion thread [1] originating from
a bug report [2].

This is a product of both using the struct address_space->i_mmap_writable
atomic counter to determine whether writing may be permitted, and the
kernel adjusting this counter when any VM_SHARED mapping is performed and
more generally implicitly assuming VM_SHARED implies writable.

It seems sensible that we should only update this mapping if VM_MAYWRITE is
specified, i.e. whether it is possible that this mapping could at any point
be written to.

If we do so then all we need to do to permit write seals to function as
documented is to clear VM_MAYWRITE when mapping read-only. It turns out
this functionality already exists for F_SEAL_FUTURE_WRITE - we can
therefore simply adapt this logic to do the same for F_SEAL_WRITE.

We then hit a chicken and egg situation in mmap_region() where the check
for VM_MAYWRITE occurs before we are able to clear this flag. To work
around this, perform this check after we invoke call_mmap(), with careful
consideration of error paths.

Thanks to Andy Lutomirski for the suggestion!

[1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
[2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238

v4:
- Revert to performing the writable check _after_ the call_mmap()
  invocation, as the only impact should be internal mm checks, rather than
  call_mmap(), as suggested by Jan Kara.
- Additionally, fixup error handling paths, which resulted in an i915 test
  failure previously erroneously double-decrement the i_mmap_writable
  counter. We do this by tracking whether we have in fact marked the mapping
  writable. This is based on Jan's feedback also.

v3:
- Don't defer the writable check until after call_mmap() in case this
  breaks f_ops->mmap() callbacks which assume this has been done
  first. Instead, separate the check and enforcement of it across the call,
  allowing for it to change vma->vm_flags in the meanwhile.
- Improve/correct commit messages and comments throughout.
https://lore.kernel.org/all/cover.1696709413.git.lstoakes@gmail.com

v2:
- Removed RFC tag.
- Correct incorrect goto pointed out by Jan.
- Reworded cover letter as suggested by Jan.
https://lore.kernel.org/all/cover.1682890156.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1680560277.git.lstoakes@gmail.com/

Lorenzo Stoakes (3):
  mm: drop the assumption that VM_SHARED always implies writable
  mm: update memfd seal write check to include F_SEAL_WRITE
  mm: perform the mapping_map_writable() check after call_mmap()

 fs/hugetlbfs/inode.c |  2 +-
 include/linux/fs.h   |  4 ++--
 include/linux/mm.h   | 26 +++++++++++++++++++-------
 kernel/fork.c        |  2 +-
 mm/filemap.c         |  2 +-
 mm/madvise.c         |  2 +-
 mm/mmap.c            | 27 ++++++++++++++++-----------
 mm/shmem.c           |  2 +-
 8 files changed, 42 insertions(+), 25 deletions(-)

--
2.42.0

