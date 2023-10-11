Return-Path: <linux-fsdevel+bounces-97-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3C7C59F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918AD1C20F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161639929;
	Wed, 11 Oct 2023 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b75XYnCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D339922
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:04:39 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468CDD;
	Wed, 11 Oct 2023 10:04:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405524e6768so1196885e9.2;
        Wed, 11 Oct 2023 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043875; x=1697648675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/MEM2vJvwV4uJcosJuPLdVvwtT2Ba54U+cdzG9D8R5Q=;
        b=b75XYnCNCMUZOJIeo4EWbPKdh7Fvh6kOAUFB/PrkpvbelQLN3p5nm8cpnsf6g4fdvz
         12nl94j1xx+yV5hSU17iBCqJj71C9blWcl6DIJ1VN9Edm3JEYprcPfjQ0bNCg86Fq/6E
         6NFjGVSlEF9Td30oComOS2yHC/k2WV1Z521yh5OQWae4DBBCQUCU5rea627SKkoln7Q0
         c4A22atnX2J9Wo/V/xadZb/JJTpKM3feiWJrmr/KVm5g6Hisd8QaO5FK8eCjqOUUTkDD
         WYCRCoTNfF1EWIYjnBAxmcqopcdYN4YcAFmcy8tlpPUBbYdOPV8L7aziZmnB3H0MX51Y
         fj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043875; x=1697648675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MEM2vJvwV4uJcosJuPLdVvwtT2Ba54U+cdzG9D8R5Q=;
        b=prUAMSTdNsTIbt6pgsTSHohXKGBp3cOmdsLUobeB83p9MURh8nMxUrCt0KfGdXLCo6
         h76DrqRUGjG7FJ+3NaLaD56gNhHvABp9KJQl6YNcEtS7g/SYNY3e+40cY61Ux5C9KL1k
         aiEQe4O7D0ca+mCQSf2X3j0xEeipumalSmrV/un0zIYxvyzWJvJbhK38PCCHAIolvXNI
         ZHDACLJX1kunUAZnBYgYyyiK7k4L6Z/YredWCnbjZeAK3T3K+TIwEXPO6BQXJ4N/9vBu
         Gugez1Vw6UWXo2q/030dXO5csPoE2L3YfkLGJB5cylsdb18P2x7OJZQh6tQv92yHofm3
         vAmw==
X-Gm-Message-State: AOJu0YyFtp85RRnSnvN6t9rB1wIKWP9a4sivijwl3S3c5p9+2hhAxK80
	wYQ54bXoJb/ZqAWDAg82Wrw=
X-Google-Smtp-Source: AGHT+IGbXjrJzkJ87J02ncABOsWtecsmidXq2EtYOCOUy2qPIw2XclV4pUxW9L3MXWYJIXDVAtXYwA==
X-Received: by 2002:a05:600c:2946:b0:405:4daa:6e3d with SMTP id n6-20020a05600c294600b004054daa6e3dmr18874865wmd.39.1697043874487;
        Wed, 11 Oct 2023 10:04:34 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm3834495wmm.6.2023.10.11.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:33 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 0/5] Abstract vma_merge() and split_vma()
Date: Wed, 11 Oct 2023 18:04:26 +0100
Message-ID: <cover.1697043508.git.lstoakes@gmail.com>
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

The vma_merge() interface is very confusing and its implementation has led
to numerous bugs as a result of that confusion.

In addition there is duplication both in invocation of vma_merge(), but
also in the common mprotect()-style pattern of attempting a merge, then if
this fails, splitting the portion of a VMA about to have its attributes
changed.

This pattern has been copy/pasted around the kernel in each instance where
such an operation has been required, each very slightly modified from the
last to make it even harder to decipher what is going on.

Simplify the whole thing by dividing the actual uses of vma_merge() and
split_vma() into specific and abstracted functions and de-duplicate the
vma_merge()/split_vma() pattern altogether.

Doing so also opens the door to changing how vma_merge() is implemented -
by knowing precisely what cases a caller is invoking rather than having a
central interface where anything might happen we can untangle the brittle
and confusing vma_merge() implementation into something more workable.

For mprotect()-like cases we introduce vma_modify() which performs the
vma_merge()/split_vma() pattern, returning a pointer to either the merged
or split VMA or an ERR_PTR(err) if the splits fail.

We provide a number of inline helper functions to make things even clearer:-

* vma_modify_flags()      - Prepare to modify the VMA's flags.
* vma_modify_flags_name() - Prepare to modify the VMA's flags/anon_vma_name
* vma_modify_policy()     - Prepare to modify the VMA's mempolicy.
* vma_modify_flags_uffd() - Prepare to modify the VMA's flags/uffd context.

For cases where a new VMA is attempted to be merged with adjacent VMAs we
add:-

* vma_merge_new_vma() - Prepare to merge a new VMA.
* vma_merge_extend()  - Prepare to extend the end of a new VMA.

v4:
* Correct bug where PTR_ERR() was accidentally pased prev rather than VMA,
  as suggested by Vlastimil.
* Updated comment and styling, and moved from using pgoff in
  vma_merge_new_vma() to vma->vm_pgoff in case driver changes it, as
  suggested by Liam.

v3:
* Drop unnecessary VM_WARN_ON().
* Implement excellent suggestion from Vlastimil to simply have vma_modify()
  return the vma if merge fails (and no error occurs on split), as all
  callers really only need to deal with either the merged VMA or the
  original one if split. This simplifies things even further.
https://lore.kernel.org/all/cover.1696929425.git.lstoakes@gmail.com/

v2:
* Correct mistake where error cases would have been treated as success as
  pointed out by Vlastimil.
* Move vma_policy() define to mm_types.h.
* Move anon_vma_name(), anon_vma_name_alloc() and anon_vma_name_free() to
  mm_types.h from mm_inline.h.
* These moves make it possible to implement the vma_modify_*() helpers as
  static inline declarations, so do so.
* Spelling corrections and clarifications.
https://lore.kernel.org/all/cover.1696884493.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1696795837.git.lstoakes@gmail.com/

Lorenzo Stoakes (5):
  mm: move vma_policy() and anon_vma_name() decls to mm_types.h
  mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
  mm: make vma_merge() and split_vma() internal
  mm: abstract merge for new VMAs into vma_merge_new_vma()
  mm: abstract VMA merge and extend into vma_merge_extend() helper

 fs/userfaultfd.c          |  70 ++++++------------------
 include/linux/mempolicy.h |   4 --
 include/linux/mm.h        |  69 ++++++++++++++++++++---
 include/linux/mm_inline.h |  20 +------
 include/linux/mm_types.h  |  27 +++++++++
 mm/internal.h             |   7 +++
 mm/madvise.c              |  26 ++-------
 mm/mempolicy.c            |  26 +--------
 mm/mlock.c                |  25 ++-------
 mm/mmap.c                 | 112 ++++++++++++++++++++++++++++++++------
 mm/mprotect.c             |  29 ++--------
 mm/mremap.c               |  30 +++++-----
 mm/nommu.c                |   4 +-
 13 files changed, 237 insertions(+), 212 deletions(-)

--
2.42.0

