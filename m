Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E714EB4AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 22:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiC2U0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiC2U0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:26:06 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DE41300
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 13:24:22 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id k7so15323407qvc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCQPxxCUBjc+Q0W/obK89wZ6Ie7/l9cxoeCtCl57CNE=;
        b=TgZQc2MDTXHAIzOypLSquXctdgeKKA/HfTbBuycWLLxr1rVIVt3r6XlghfMs9/KuoI
         8M6fGevogtpJwqOz+tejTBNYGKev9B935G5fnOex6Y/dluAuVHBDYv/uMXKJ6V8q6hjn
         sbZDDzitg8eDfHKdXKSf13obmov8lIJyxWt0/fvbSFRVx6IZ8BmJNSO+bOKoIf3UObjN
         meZy8AQ2wH3C+BVe393TTLA3OJBwoacvQ8fpe7vawKcLrCgMXVY7DnoSDbJOZFP5EIRB
         fs6uGsuDohLqfpnfxmkGTRU3b9HhP50j57Cvh3A9+KbY77g3aJUBLq0DLnvHYAa8yJUB
         jSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCQPxxCUBjc+Q0W/obK89wZ6Ie7/l9cxoeCtCl57CNE=;
        b=ZLjxS2HPokUrOp9iQBHHurrZj0KRx+rp0DB/cWn3yDTUr26xlrXUcAhU/nMQsWyOPZ
         uBvetmxp4fQq6Uiema5OmTUPw1UI+bBYnSCSqX6C070Y1I+iJRquA6RRVydDKl6V7y8x
         CZLZvtGndrGBhyph6+YPrLzGTvNNY56h4Yv9Xae7ZeQ2Y8dagzAmIkGyN611zKuUYMSq
         riwu72uUnCVJ5Uwn4df4E6x51j6HGrtUyirDERdRqRKQBIbkgSdBPQM/fhZplHLp7HWY
         vdA9UnRFbmujZrbMNHrtqY9yaB1NTrd23GmvQguwqqFVWweuCLBVx9TbH8Qoy8LudkxU
         V3hg==
X-Gm-Message-State: AOAM531t3uhJIVZrYpaSFyvwv+6rQ01MrQOVYqG7PnVGFYAN8FzinnCX
        FD2cmzo0q0BoARIRyp2i3J//c8ayXaqH6xLqyhQ=
X-Google-Smtp-Source: ABdhPJxEGhO3FNJZfxWdQGMERD2ukmx/EwKbydNtUm4wT9ualt2BtnaUOs5bL5vbQAgCQpCSAv8oiIO14ezN4LEu09c=
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id
 fv9-20020a056214240900b00432bf34362fmr28586269qvb.66.1648585462028; Tue, 29
 Mar 2022 13:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com> <YieG8rZkgnfwygyu@mit.edu>
In-Reply-To: <YieG8rZkgnfwygyu@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 29 Mar 2022 23:24:10 +0300
Message-ID: <CAOQ4uxjvwKRAWZRZy53PW2H_BrC1ufThX4ps0HOHYZ4xgXjPrA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 8, 2022 at 6:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Mar 08, 2022 at 11:08:48AM +0100, Greg KH wrote:
> > > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> > > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
> >
> > That's up to the xfs maintainers to discuss.
> >
> > > Which makes me wonder: how do the distro kernel maintainers keep up
> > > with xfs fixes?
> >
> > Who knows, ask the distro maintainers that use xfs.  What do they do?
>
> This is something which is being worked, so I'm not sure we'll need to
> discuss the specifics of the xfs stable backports at LSF/MM.  I'm
> hopeful that by May, we'll have come to some kind of resolution of
> that topic.
>
> One of my team members has been working with Darrick to set up a set
> of xfs configs[1] recommended by Darrick, and she's stood up an
> automated test spinner using gce-xfstests which can watch a git branch
> and automatically kick off a set of tests whenever it is updated.
> Sasha has also provided her with a copy of his scripts so we can do
> automated cherry picks of commits with Fixes tags.  So the idea is
> that we can, hopefully in a mostly completely automated fashion,

Here is a little gadget I have been working on in my spare time,
that might be able to assist us in the process of selecting stable
patch candidates.

Many times, the relevant information for considering a patch for
stable tree is in the cover letter of the patch series. It is also a lot
more efficient to skim over 23 cover letter subjects than it is to skim
over 103 commits of the xfs pull request for 5.15 [2].

I've added the command "b4 rn" [1] to produce a list of lore links
to patch series from a PULL request to Linus.

This gadget could be improved to interactively select the patch
series from within a PR to be saved into an mbox.

In any case, I do intend to start surveying the xfs patches that got
merged since v5.10 and stage a branch with my own selections, so we
will be able to compare my selections to Shasha's AUTOSEL selections.

Thanks,
Amir.

P.S. The tool sometimes produces links to two different revisions of
the same patch series (e.g. "xfs: feature flag rework" and
"[v3] xfs: rework feature flags"). It didn't bother me enough to check why.

[1] https://github.com/amir73il/b4/commits/release-notes
[2] For example:

PR=164817214223.9489.12483808836905609419.pr-tracker-bot@kernel.org
b4 pr -e -o xfs-5.18.mbx $PR
PR=163060423908.29568.14182828511329643634.pr-tracker-bot@kernel.org
b4 pr -e -o xfs-5.15.mbx $PR
b4 rn -m xfs-5.18.mbx 2>/dev/null
---
Changes in [GIT PULL] xfs: new code for 5.18:
  [https://lore.kernel.org/r/20220323164821.GP8224@magnolia]

- [PATCH] xfs: add missing cmap->br_state = XFS_EXT_NORM update
  [https://lore.kernel.org/r/20220217095542.68085-1-hsiangkao@linux.alibaba.com]

- [PATCH RESEND] xfs: don't generate selinux audit messages for
capability testing
  [https://lore.kernel.org/r/20220301025052.GF117732@magnolia]

- [PATCHSET 0/2] xfs: use setattr_copy to set VFS file attributes
  [https://lore.kernel.org/r/164685372611.495833.8601145506549093582.stgit@magnolia]

- [PATCHSET v3 0/2] xfs: make quota reservations for directory changes
  [https://lore.kernel.org/r/164694920783.1119636.13401244964062260779.stgit@magnolia]

- [PATCHSET v2 0/2] xfs: constify dotdot global variable
  [https://lore.kernel.org/r/164694922267.1119724.17942999738634110525.stgit@magnolia]

- [PATCH 0/7 v4] xfs: log recovery fixes
  [https://lore.kernel.org/r/20220317053907.164160-1-david@fromorbit.com]

---
b4 rn -m xfs-5.15.mbx 2>/dev/null
---
Changes in [GIT PULL] xfs: new code for 5.15:
  [https://lore.kernel.org/r/20210831211847.GC9959@magnolia]

- don't allow disabling quota accounting on a mounted file system v2
  [https://lore.kernel.org/r/20210809065938.1199181-1-hch@lst.de]

- [PATCHSET v9 00/14] xfs: deferred inode inactivation
  [https://lore.kernel.org/r/162812918259.2589546.16599271324044986858.stgit@magnolia]

- [PATCHSET v8 00/20] xfs: deferred inode inactivation
  [https://lore.kernel.org/r/162758423315.332903.16799817941903734904.stgit@magnolia]

- [PATCHSET 0/5] xfs: other stuff for 5.15
  [https://lore.kernel.org/r/162814684332.2777088.14593133806068529811.stgit@magnolia]

- [PATCH] xfs: drop experimental warnings for bigtime and inobtcount
  [https://lore.kernel.org/r/20210707002313.GG11588@locust]

- [PATCH 0/3 v3] xfs, mm: memory allocation improvements
  [https://lore.kernel.org/r/20210714023440.2608690-1-david@fromorbit.com]

- [PATCH v25 00/14] Log Attribute Replay
  [https://lore.kernel.org/r/20211117041613.3050252-1-allison.henderson@oracle.com]

- [PATCH] fs:xfs: cleanup __FUNCTION__ usage
  [https://lore.kernel.org/r/20210711085153.95856-1-dwaipayanray1@gmail.com]

- [PATCH 0/9 v3] xfs: shutdown is a racy mess
  [https://lore.kernel.org/r/20210810051825.40715-1-david@fromorbit.com]

- [PATCH 0/5 v3] xfs: strictly order log start records
  [https://lore.kernel.org/r/20210810052120.41019-1-david@fromorbit.com]

- [PATCH 0/3 v7] xfs: make CIL pipelining work
  [https://lore.kernel.org/r/20210810052257.41308-1-david@fromorbit.com]

- [RFC PATCH 00/16] xfs: Block size > PAGE_SIZE support
  [https://lore.kernel.org/r/20181107063127.3902-1-david@fromorbit.com]

- [PATCHSET 0/3] xfs: fix various bugs in fsmap
  [https://lore.kernel.org/r/162872991654.1220643.136984377220187940.stgit@magnolia]

- [PATCHSET 0/2] xfs: more random tweaks
  [https://lore.kernel.org/r/162872993519.1220748.15526308019664551101.stgit@magnolia]

- [PATCHSET 00/10] xfs: constify btree operations
  [https://lore.kernel.org/r/162881108307.1695493.3416792932772498160.stgit@magnolia]

- [PATCH] xfs: remove support for untagged lookups in xfs_icwalk*
  [https://lore.kernel.org/r/20210813081623.83323-1-hch@lst.de]

- [PATCHSET 00/15] xfs: clean up ftrace field tags and formats
  [https://lore.kernel.org/r/162924373176.761813.10896002154570305865.stgit@magnolia]

- [PATCH 00/16 v3] xfs: rework feature flags
  [https://lore.kernel.org/r/20210818235935.149431-1-david@fromorbit.com]

- [PATCH 0/10] xfs: feature flag rework
  [https://lore.kernel.org/r/20180820044851.414-1-david@fromorbit.com]

- [PATCH 0/3] xfs: clean up buffer cache disk addressing
  [https://lore.kernel.org/r/20210810052851.42312-1-david@fromorbit.com]

- [PATCH] xfs: fix perag structure refcounting error when scrub fails
  [https://lore.kernel.org/r/20210820050647.GW12640@magnolia]

- [RFC PATCH] generic: regression test for a FALLOC_FL_UNSHARE bug in XFS
  [https://lore.kernel.org/r/20210824003835.GD12640@magnolia]

- [RFC PATCH] xfs: test DONTCACHE behavior with the inode cache
  [https://lore.kernel.org/r/20210825230703.GH12640@magnolia]

---
