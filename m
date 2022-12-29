Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E746592AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 23:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiL2WvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 17:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiL2WvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:51:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069EE5F42;
        Thu, 29 Dec 2022 14:51:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j17so13112527wrr.7;
        Thu, 29 Dec 2022 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1kTDfDbdGzxzxKcFlRaz4TUXKoZJIp/DtZyI055C2Q=;
        b=SXrjN3e/orengjIInjXGbZiTrVHaVyK8AqbmWcyCLDqy2uVqrXEyCNw4hSCBEqC6M9
         SFJ3PWtx76NNVnf+Ix7sPPYheR93NJ4WoNgyxS7D5JYTEzlsYo9bbbpxMTzP+9Fx3DmJ
         4VRtOcHZEBdEcDoRBDyOcwuhAalNDi225HYbwP7Ghs/HtWjpkBF5U7CpO6AjLQzhwJgR
         pmaKAhKeZJac4Rc3zu3iy/xu+5GN0tvOG7NHvVSmWBlgQycEcK7uWAQct9YT9YeUWr5t
         dL9fp/MarpajWYJt/oejj7+S3jkZm8KpJvtxNqZ7cKOZX+giwV0YbRArwACvEVZJJi3O
         V+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1kTDfDbdGzxzxKcFlRaz4TUXKoZJIp/DtZyI055C2Q=;
        b=U3NYtEGVMphgK0f21UqtrPMMpVdIk/DhyKCVmSAt2dKRcrScR5baQMe4/gF2p3vol2
         HswCqjpHN0YwweLoYbJytEKeIZPdnThdpmqSjmv/Z4GgUhMpN1GfCWkgALU536GH/prj
         15TQL9ZbpK20PDqxS8LXLe7Bytei3YsHLHervqb3Rut2eCdXixvw/idmgEuOpUVj2dSw
         hdiesKj8e9scfAuRMsbbEGb9pi+XIfge9Gqd24ts+n+CqhNSsokR2VbZhXEvhpVtVYtN
         Qwx3sb8YwRhI2GQERaB5cvHNNi5Qx9ckiIZ3VogLT1+Zkh1yVofHK3HIrde74GHMy5Wn
         ufgg==
X-Gm-Message-State: AFqh2ko2YT/4GGYm+cAbhJ+LYgadfnz2w0pBU1Ldye7AFuvvw9jU95YI
        qxJzkIPgbkYlsouqlWEeRfI=
X-Google-Smtp-Source: AMrXdXuiYr8UmPJdwvKaIVgA/kZxX9AZzRKeMQCFA1jd6pQU5uQK82lhM0R/riUY++wKC2hpc0lXwQ==
X-Received: by 2002:a5d:6541:0:b0:28e:f7a:9fe9 with SMTP id z1-20020a5d6541000000b0028e0f7a9fe9mr1066766wrv.5.1672354264425;
        Thu, 29 Dec 2022 14:51:04 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id p3-20020adfcc83000000b0027a57c1a6fbsm13493312wrj.22.2022.12.29.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:51:03 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 0/4] fs/ufs: Replace kmap() with kmap_local_page 
Date:   Thu, 29 Dec 2022 23:50:56 +0100
Message-Id: <20221229225100.22141-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page().

This series could have not been ever made because nothing prevented the
previous patch from working properly but Al Viro made a long series of
very appreciated comments about how many unnecessary and redundant lines
of code I could have removed. He could see things I was entirely unable
to notice. Furthermore, he also provided solutions and details about how
I could decompose a single patch into a small series of three
independent units.[1][2][3]

I want to thank him so much for the patience, kindness and the time he
decided to spend to provide those analysis and write three messages full
of interesting insights.[1][2][3]

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Changes from v1:
	1/3: No changes.
	2/3: Restore the return of "err" that was mistakenly deleted
	     together with the removal of the "out" label in
	     ufs_add_link(). Thanks to Al Viro.[4]
	     Return the address of the kmap()'ed page instead of a
	     pointer to a pointer to the mapped page; a page_address()
	     had been overlooked in ufs_get_page(). Thanks to Al
	     Viro.[5]
	3/3: Return the kernel virtual address got from the call to
	     kmap_local_page() after conversion from kmap(). Again
	     thanks to Al Viro.[6]

Changes from v2:
	1/3: No changes.
	2/3: Rework ufs_get_page() because the previous version had two
	     errors: (1) It could return an invalid pages with the out
	     argument "page" and (2) it could return "page_address(page)"
	     also in cases where read_mapping_page() returned an error
	     and the page is never kmap()'ed. Thanks to Al Viro.[7]
	3/3: Rework ufs_get_page() after conversion to
	     kmap_local_page(), in accordance to the last changes in 2/3.

Changes from v3:
	1/3: No changes.
	2/3: No changes.
	3/3: Replace kunmap() with kunmap_local().

Changes from v4:
	1/4: It was 1/3.
	2/4: Move the declaration of a page into an inner loop. Add Ira
	     Weiny's "Reviewed-by" tag (thanks!).
	3/4: Add this patch to use ufs_put_page() to replace three kunmap()
	     and put_page() in namei.c. Thanks to Ira Weiny who noticed that
	     I had overlooked their presence.
	4/4: Remove an unnecessary masking that is already carried out by
	     kunmap_local() via kunmap_local_indexed(). Add a comment to
	     clarify that a ufs_dir_entry passed to ufs_delete_entry()
	     points in the same page we need the address of. Suggested by
	     Ira Weiny.

[1] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/#t
[2] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/#t
[3] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/#t
[4] https://lore.kernel.org/lkml/Y5Zc0qZ3+zsI74OZ@ZenIV/#t
[5] https://lore.kernel.org/lkml/Y5ZZy23FFAnQDR3C@ZenIV/#t
[6] https://lore.kernel.org/lkml/Y5ZcMPzPG9h6C9eh@ZenIV/#t
[7] https://lore.kernel.org/lkml/Y5glgpD7fFifC4Fi@ZenIV/#t

The cover letter of the v1 series is at
https://lore.kernel.org/lkml/20221211213111.30085-1-fmdefrancesco@gmail.com/
The cover letter of the v2 series is at
https://lore.kernel.org/lkml/20221212231906.19424-1-fmdefrancesco@gmail.com/
The cover letter of the v3 series is at
https://lore.kernel.org/lkml/20221217184749.968-1-fmdefrancesco@gmail.com/
The cover letter of the v4 series is at
https://lore.kernel.org/lkml/20221221172802.18743-1-fmdefrancesco@gmail.com/

Fabio M. De Francesco (4):
  fs/ufs: Use the offset_in_page() helper
  fs/ufs: Change the signature of ufs_get_page()
  fs/ufs: Use ufs_put_page() in ufs_rename()
  fs/ufs: Replace kmap() with kmap_local_page()

 fs/ufs/dir.c   | 131 +++++++++++++++++++++++++++----------------------
 fs/ufs/namei.c |  11 ++---
 fs/ufs/ufs.h   |   1 +
 3 files changed, 78 insertions(+), 65 deletions(-)

-- 
2.39.0

