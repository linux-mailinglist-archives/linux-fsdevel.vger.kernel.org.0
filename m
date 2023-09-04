Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233C791C82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353466AbjIDSLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353426AbjIDSLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86573197;
        Mon,  4 Sep 2023 11:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9A8C7CE0E24;
        Mon,  4 Sep 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9A2DC433C8;
        Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851068;
        bh=KWuluqFF5yFV+lOCkFnoct0phRXw96Jca/CuZaTU2kY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K3gkbkhJRwgpsacHeBsq0A7kucjUSGo8OzMP1ouPw/XPyf9sD5QK/Sf142+usc7ZE
         C827H7oMTO9xQURopm4EWqGoFioLBjSEY4gmbRDnvHI4L+ywXrxJRVy5ldQmRaAtfj
         1pffFi8IArgTV4dPuYUPdlhMXVuT7Hb/6kEuD4lj+4NJdrul8tjUb9OXjEUjpGn+jT
         2ndFdt5oPLx5wHtLQ20DiaB9Xl09djxp9OA/4zW9QgSOHR3JDKxABg9kMIgFr5Ox62
         wqlEdaiOf1aM8ubxkjKV3yvjnRyA83mc2npN6NfYoiPdtaZLbxGvWm4TgDkfWkglX8
         L2qkw/qB1Voxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2BE4C04E26;
        Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v7 00/13] fs: implement multigrain timestamps
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106866.19669.14483196627780303129.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:08 +0000
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, ericvh@kernel.org,
        lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com,
        dhowells@redhat.com, marc.dionne@auristor.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, xiubli@redhat.com,
        idryomov@gmail.com, jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        code@tyhicks.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com,
        gregkh@linuxfoundation.org, tj@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        hubcap@omnibond.com, martin@omnibond.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, sfrench@samba.org,
        pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com,
        tom@talpey.com, senozhatsky@chromium.org, richard@nod.at,
        hdegoede@redhat.com, hughd@google.com, akpm@linux-foundation.org,
        amir73il@gmail.com, djwong@kernel.org, bcodding@redhat.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, codalist@coda.cs.cmu.edu,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org, ecryptfs@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, v9fs@lists.linux.dev,
        samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Mon, 07 Aug 2023 15:38:31 -0400 you wrote:
> The VFS always uses coarse-grained timestamps when updating the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this coarseness has always been an issue when we're
> exporting via NFSv3, which relies on timestamps to validate caches. A
> lot of changes can happen in a jiffy, so timestamps aren't sufficient to
> help the client decide to invalidate the cache.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7,01/13] fs: remove silly warning from current_time
    https://git.kernel.org/jaegeuk/f2fs/c/b3030e4f2344
  - [f2fs-dev,v7,02/13] fs: pass the request_mask to generic_fillattr
    https://git.kernel.org/jaegeuk/f2fs/c/0d72b92883c6
  - [f2fs-dev,v7,03/13] fs: drop the timespec64 arg from generic_update_time
    https://git.kernel.org/jaegeuk/f2fs/c/541d4c798a59
  - [f2fs-dev,v7,04/13] btrfs: have it use inode_update_timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/bb7cc0a62e47
  - [f2fs-dev,v7,05/13] fat: make fat_update_time get its own timestamp
    (no matching commit)
  - [f2fs-dev,v7,06/13] ubifs: have ubifs_update_time use inode_update_timestamps
    (no matching commit)
  - [f2fs-dev,v7,07/13] xfs: have xfs_vn_update_time gets its own timestamp
    (no matching commit)
  - [f2fs-dev,v7,08/13] fs: drop the timespec64 argument from update_time
    (no matching commit)
  - [f2fs-dev,v7,09/13] fs: add infrastructure for multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/ffb6cf19e063
  - [f2fs-dev,v7,10/13] tmpfs: add support for multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/d48c33972916
  - [f2fs-dev,v7,11/13] xfs: switch to multigrain timestamps
    (no matching commit)
  - [f2fs-dev,v7,12/13] ext4: switch to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/0269b585868e
  - [f2fs-dev,v7,13/13] btrfs: convert to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/50e9ceef1d4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


