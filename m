Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F97A59BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 08:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjISGKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 02:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjISGKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:10:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC410F;
        Mon, 18 Sep 2023 23:10:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C2DC433C8;
        Tue, 19 Sep 2023 06:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695103809;
        bh=GYsVDmtHjmD65ngtLU+uLhnkIlgKs4QonM8BFIhxiCs=;
        h=From:To:Cc:Subject:Date:From;
        b=lxB72gGaRP2wmuRVuuNK9qFo6kITeDoPhJiAnjI/hw+Jgc58f1cW5JTLPm3xd1u47
         1WoZq+d6hMh04mEeqm1Hn/l2Ct5I1SDvGDVeu00SDVNuT3xDmD7+oBC/Hb4oFsPzw1
         JhQqS96gt2taNd88KSH5Nbdf2h92SvqYLWp/fB/ilUZaRT3xL+RB7XVx2J1fiVv3PB
         odKqDfrev5Wh4t+tbOMD/JNPDNckPL/neEtbaAcH5yKGdgphYMb1aPfTdDIS0nfHaW
         p1Nez6CW1NOm0yGPsLJfmrHpStvQwqBaCqG1s6QH76iuP0fvhCjRykeXALu1VEo1D7
         4vakumPJq5QiA==
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     chandanbabu@kernel.org
Cc:     bodonnel@redhat.com, david@fromorbit.com, dchinner@redhat.com,
        djwong@kernel.org, harshit.m.mogalapalli@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        lukas.bulwahn@gmail.com, peterz@infradead.org,
        ritesh.list@gmail.com, sandeen@sandeen.net,
        srikanth.c.s@oracle.com, sshegde@linux.vnet.ibm.com,
        tglx@linutronix.de, wangjc136@midea.com, wen.gang.wang@oracle.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 8b010acb3154
Date:   Tue, 19 Sep 2023 11:35:10 +0530
Message-ID: <878r92k81t.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

8b010acb3154 xfs: use roundup_pow_of_two instead of ffs during xlog_find_tail

24 new commits:

Chandan Babu R (8):
      [da6f8410e73e] Merge tag 'fix-fsmap-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [0a229c935a8a] Merge tag 'fix-percpu-lists-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [f41d7d70b0f2] Merge tag 'fix-ro-mounts-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [b6c2b6378d64] Merge tag 'fix-efi-recovery-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [fffcdcc31fa1] Merge tag 'fix-iunlink-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [abf7c8194f23] Merge tag 'fix-iunlink-list-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [6ebb6500e546] Merge tag 'fix-larp-requirements-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      [1155b12edbb5] Merge tag 'fix-scrub-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA

Darrick J. Wong (14):
      [ecd49f7a36fb] xfs: fix per-cpu CIL structure aggregation racing with dying cpus
      [cfa2df68b7ce] xfs: fix an agbno overflow in __xfs_getfsmap_datadev
      [62334fab4762] xfs: use per-mount cpumask to track nonempty percpu inodegc lists
      [f5bfa695f02e] xfs: remove the all-mounts list
      [ef7d9593390a] xfs: remove CPU hotplug infrastructure
      [f12b96683d69] xfs: use i_prev_unlinked to distinguish inodes that are not on the unlinked list
      [76e589013fec] xfs: allow inode inactivation during a ro mount log recovery
      [83771c50e42b] xfs: reload entire unlinked bucket lists
      [74ad4693b647] xfs: fix log recovery when unknown rocompat bits are set
      [3c919b091090] xfs: reserve less log space when recovering log intent items
      [68b957f64fca] xfs: load uncached unlinked inodes into memory on demand
      [49813a21ed57] xfs: make inode unlinked bucket recovery work with quotacheck
      [34389616a963] xfs: require a relatively recent V5 filesystem for LARP mode
      [e03192820002] xfs: only call xchk_stats_merge after validating scrub inputs

Lukas Bulwahn (1):
      [57c0f4a8ea3a] xfs: fix select in config XFS_ONLINE_SCRUB_STATS

Wang Jianchao (1):
      [8b010acb3154] xfs: use roundup_pow_of_two instead of ffs during xlog_find_tail

Code Diffstat:

 fs/xfs/Kconfig                  |   2 +-
 fs/xfs/libxfs/xfs_log_recover.h |  22 +++++
 fs/xfs/libxfs/xfs_sb.c          |   3 +-
 fs/xfs/scrub/scrub.c            |   4 +-
 fs/xfs/scrub/stats.c            |   5 +-
 fs/xfs/xfs_attr_inactive.c      |   1 -
 fs/xfs/xfs_attr_item.c          |   7 +-
 fs/xfs/xfs_bmap_item.c          |   4 +-
 fs/xfs/xfs_export.c             |   6 ++
 fs/xfs/xfs_extfree_item.c       |   4 +-
 fs/xfs/xfs_fsmap.c              |  25 +++--
 fs/xfs/xfs_icache.c             |  80 ++++++---------
 fs/xfs/xfs_icache.h             |   1 -
 fs/xfs/xfs_inode.c              | 209 +++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_inode.h              |  34 ++++++-
 fs/xfs/xfs_itable.c             |   9 ++
 fs/xfs/xfs_log.c                |  17 ----
 fs/xfs/xfs_log_cil.c            |  52 +++-------
 fs/xfs/xfs_log_priv.h           |  14 ++-
 fs/xfs/xfs_log_recover.c        |   4 +-
 fs/xfs/xfs_mount.h              |  17 +++-
 fs/xfs/xfs_qm.c                 |   7 ++
 fs/xfs/xfs_refcount_item.c      |   6 +-
 fs/xfs/xfs_rmap_item.c          |   6 +-
 fs/xfs/xfs_super.c              |  86 +----------------
 fs/xfs/xfs_trace.h              |  45 +++++++++
 fs/xfs/xfs_xattr.c              |  11 +++
 include/linux/cpuhotplug.h      |   1 -
 28 files changed, 441 insertions(+), 241 deletions(-)
