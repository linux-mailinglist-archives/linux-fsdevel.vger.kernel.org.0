Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66257753AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHIHKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIHKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806021715;
        Wed,  9 Aug 2023 00:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C4C362FC2;
        Wed,  9 Aug 2023 07:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803F7C433C7;
        Wed,  9 Aug 2023 07:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691565012;
        bh=+3Y6neJgMvW5vfedbEeRcP7JJepyGcWsyiFSr/HW990=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggBjfw6PiXZGX2pQ0PAP5cLTD5E0rfqWCYvfni6XgMaAu/qe1HDhVULCR34YpT5YS
         BKgPskzZUrQN/q0pADH7E3rJp+efq+TJqLpTcE7dWusL6zUTz83z7W2kEcL4C6I9Pl
         ufDj5BPqocIYlc8GG9bv5prUaOSZXY+wJG0igl2mx/MjAwyCvyPRsvUpSYuoG9hC3v
         Cpu7fhDWB2xklEWatdaUMtlv7AEsl0+OXnaMFZ2BdukJjZL1AZSUnY8BUua+nFhXag
         gAEez8RHLWI4JAU/88U4SJjdJFFBI98gXxi6sXBvp3qvswqNnsMmS0Eecbc3TwTHzz
         J9jzLmchFW2kQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH v7 00/13] fs: implement multigrain timestamps
Date:   Wed,  9 Aug 2023 09:09:49 +0200
Message-Id: <20230809-neuigkeit-lahmgelegt-ec0ab744a2be@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=brauner@kernel.org; h=from:subject:message-id; bh=+3Y6neJgMvW5vfedbEeRcP7JJepyGcWsyiFSr/HW990=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRctt58ofGmdrjT46zKic8e+j/qO6J62PGCzlmNRn/PL+ca DhW87ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIjiMjw77ybes4w5Z37p3j9lpveq 1v7yzNZOVwx1cX83f9exixeQ8jw5qJVSkpYSKnLt8M6dl09qHqq/xjLU9j3pdUzg+b1x8izQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 07 Aug 2023 15:38:31 -0400, Jeff Layton wrote:
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

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[01/13] fs: remove silly warning from current_time
        https://git.kernel.org/vfs/vfs/c/562bcab11bf4
[02/13] fs: pass the request_mask to generic_fillattr
        https://git.kernel.org/vfs/vfs/c/3592165f4378
[03/13] fs: drop the timespec64 arg from generic_update_time
        https://git.kernel.org/vfs/vfs/c/32586bb50943
[04/13] btrfs: have it use inode_update_timestamps
        https://git.kernel.org/vfs/vfs/c/51fc38e7c7d1
[05/13] fat: make fat_update_time get its own timestamp
        https://git.kernel.org/vfs/vfs/c/d6e7faae82dc
[06/13] ubifs: have ubifs_update_time use inode_update_timestamps
        https://git.kernel.org/vfs/vfs/c/853ff59b434a
[07/13] xfs: have xfs_vn_update_time gets its own timestamp
        https://git.kernel.org/vfs/vfs/c/7ad056c2cf36
[08/13] fs: drop the timespec64 argument from update_time
        https://git.kernel.org/vfs/vfs/c/3beae086b71f
[09/13] fs: add infrastructure for multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/b16956ed812f
[10/13] tmpfs: add support for multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/bd21ec574f16
[11/13] xfs: switch to multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/fb9812d2c39e
[12/13] ext4: switch to multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/7fdf02299f5d
[13/13] btrfs: convert to multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/2ebbf04988b9
