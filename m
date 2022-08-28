Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98D75A3BE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiH1FEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1FEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:04:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280F7653;
        Sat, 27 Aug 2022 22:04:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x23so5082512pll.7;
        Sat, 27 Aug 2022 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=2qmKRYBhQjgkcIS8sasbXGpzW8nAyEQHZ39uMxMKHbk=;
        b=jAkuqc+p6XX0Pnay2G5BThyJ9wdNgIBJtWs5tznVFuUGxtleN1cst5g0ZM7jcuvRPv
         H+n18KPuT0PjAd6cvXkJsZUPKqzJtdlfgSh7sSlAD3riGZiWmAGcGDze5UTmATh0HyKR
         v1cxQQYIYbXV3g1F0H2mPffc3yA5aVAqSRtscwQoXgZ5IejLztmpSwLxNU6N0HyeygRW
         MiKyIVHyEqlat/0w8XP2Xy3ykgx7llhjBH6BPExIpP8H10lG5KcEoZrrzxj8DZVOzzrB
         a3yNh6lH/dfcUorBAud2ExFFi9GiMGjtIm/TbnO8soMy315BfEjHIg3zH1Gs7CD7jGm/
         RIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=2qmKRYBhQjgkcIS8sasbXGpzW8nAyEQHZ39uMxMKHbk=;
        b=NdW8IbvrrW7jVmPU3AKvKveVZRGB/zzTaxfd5gZeveNs2uRo/VV6ECS3VLsSVd/VZN
         3OUqJPYiRtyqWN16f7XfNfyjeBAIk20+Sih2SLXkN8Ro9MtdfZrLM2wKmVEPcw87Bgna
         lwkEXok/d2oJhB8BFiPeVVkP2YYHpqcOUnp6ry8nJB30mgR3YjCYWJfBOxFOSv6lHqj3
         QHm9iy8NeMmc2/hhhy02rnNI/h3DerWrlmZdjq7YgGr90ItJRcJzST2prZLR+c7rhSf9
         Vzj4gLvGvTtlgPsWlwu1n4ArrWJmLPHmEDuUEQJOrAJ6u6M0cfFRvBRuK8hDYX74oCm1
         jp5w==
X-Gm-Message-State: ACgBeo3m3UyViv05JeVUI9XnZK8+5t8qkP6zAtgMr6Kf4EUTnxVecqjm
        UVchOmvGtmW3g2ORHzjlaZ+BsAbWu4g=
X-Google-Smtp-Source: AA6agR6CUaYnfnddXTPSTMr5jYboLtSq3JKHhyvcKweRXU3D5g8y62j6wBw3FFszi4pWQSVEeeQ15w==
X-Received: by 2002:a17:903:11c9:b0:172:6ea1:b727 with SMTP id q9-20020a17090311c900b001726ea1b727mr10729202plh.78.1661663091030;
        Sat, 27 Aug 2022 22:04:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id mh3-20020a17090b4ac300b001fdb6ef8e2esm307890pjb.10.2022.08.27.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:04:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
Subject: [PATCHSET v2 for-6.1] kernfs, cgroup: implement kernfs_show() and cgroup_file_show()
Date:   Sat, 27 Aug 2022 19:04:31 -1000
Message-Id: <20220828050440.734579-1-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Greg: If this looks good to you, can you apply 0001-0008 to your tree? I'll
likely have more cgroup updates on top, so I think it'd be better if I pull
your tree and then handle the cgroup part in cgroup tree.

Currently, deactivated kernfs nodes are used for two purposes - during
removal to kill and drain nodes and during creation to make multiple
kernfs_nodes creations to succeed or fail as a group.

This patchset implements kernfs_show() which can dynamically show and hide
kernfs_nodes using the [de]activation mechanisms, and, on top, implements
cgroup_file_show() which allows toggling cgroup file visiblity.

This is for the following pending patchset to allow disabling PSI on
per-cgroup basis:

 https://lore.kernel.org/all/20220808110341.15799-1-zhouchengming@bytedance.com/t/#u

which requires hiding the corresponding cgroup interface files while
disabled.

This patchset contains the following nine patches.

 0001-kernfs-Simply-by-replacing-kernfs_deref_open_node-wi.patch
 0002-kernfs-Drop-unnecessary-mutex-local-variable-initial.patch
 0003-kernfs-Refactor-kernfs_get_open_node.patch
 0004-kernfs-Skip-kernfs_drain_open_files-more-aggressivel.patch
 0005-kernfs-Improve-kernfs_drain-and-always-call-on-remov.patch
 0006-kernfs-Add-KERNFS_REMOVING-flags.patch
 0007-kernfs-Factor-out-kernfs_activate_one.patch
 0008-kernfs-Implement-kernfs_show.patch
 0009-cgroup-Implement-cgroup_file_show.patch

0001-0003 are misc prep patches. 0004-0008 implement kernsf_deactivate().
0009 implements cgroup_file_show() on top. The patches are also available in
the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-show

The main difference from the previous version[1] is that while show/hide
still use the same mechanism as [de]activation, their states are tracked
separately so that e.g. an unrelated kernfs_activate() higher up in the tree
doesn't interfere with hidden nodes in the subtree.

diffstat follows. Thanks.

 fs/kernfs/dir.c             |  102 +++++++++++++++++++++++++++++++----------------
 fs/kernfs/file.c            |  151 +++++++++++++++++++++++++++++++++-------------------------------------
 fs/kernfs/kernfs-internal.h |    1
 include/linux/cgroup.h      |    1
 include/linux/kernfs.h      |    3 +
 kernel/cgroup/cgroup.c      |   20 +++++++++
 6 files changed, 166 insertions(+), 112 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20220820000550.367085-1-tj@kernel.org

