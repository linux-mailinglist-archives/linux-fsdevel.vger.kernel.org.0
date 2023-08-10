Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAC777361
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjHJIxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjHJIx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE72107;
        Thu, 10 Aug 2023 01:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11009653DD;
        Thu, 10 Aug 2023 08:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DCCC433C7;
        Thu, 10 Aug 2023 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691657608;
        bh=BtL1CW/BIRsOpqWpjUouz4XhudPj2+tb6Ydw0pipp8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rn6dFD2s8fas8mQMZfpd8BxPHu0IvFQux9ZykFzC2nO0nqOXoIO7icG247IwWkauW
         MesT9/KdwgoOvqQLTDwjz00V6y7L8bJ1QR8noDuVY0uukV5swgzjFyoe+4IUt0lhHB
         2ORWZaiX9P6B707DLm1Y5japtsynGQRTka95D9SztX2DF5qGz7yeySx32bzukUWhQj
         2fhTKfzZ1ib39Zh4CTBoe7pUNmnB3m/DyXDRMYMgNeQzwS3cTz+SQLJO6BzjenwfBA
         1WLIvkDDQCanhfibs0C5OvUYYxBXW7NxsS6pMFk0Vad6yJ9vFjHHPGjcurGSMTSD18
         mmE/IXFIzdA2Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 01/13] xfs: reformat the xfs_fs_free prototype
Date:   Thu, 10 Aug 2023 10:53:21 +0200
Message-Id: <20230810-unmerklich-grandios-281ae311e396@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809220545.1308228-2-hch@lst.de>
References: <20230809220545.1308228-1-hch@lst.de> <20230809220545.1308228-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=brauner@kernel.org; h=from:subject:message-id; bh=gfnX+yUmCtz6SA8c5/vj+4alYEm7L/Rv30+a/Btecrg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRcWXLyd+edQ5Kf/hsb1T3dt1BdOv/tgsv/z9k+ZjJv+s14 77JjZkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEhJoZGTqORHf9MZrHbT3VhV/0Ok Pv1V8b5ZlvvCtgucJ1ZPUS+SCG/xEHNdn25/9/xytyrs/ijQu/Ydun7TITcs3q+jY1+Gqc4AcA
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

On Wed, 09 Aug 2023 15:05:33 -0700, Christoph Hellwig wrote:
> The xfs_fs_free prototype formatting is a weird mix of the classic XFS
> style and the Linux style.  Fix it up to be consistent.
> 
> 

I've completely reshuffled that branch now:

(1) bd_super removal
(2) ->kill_sb() fixes
(3) setup_bdev_super() work (open devices after sb creation)
(4) fs_holder_ops rework
(5) exclusive sb creation

I think that's the most natural order. That involved quite a bit of
massaging, so please make sure that everything's in proper order. The
most sensitive and error prone part of the reordering is that before the
switch from fs_type to sb as holder took place prior to this series.
Whereas due to the reordering the switch now takes place after this
series. This is good though because we can't use setup_bdev_super()
correctly anyway before we have the ->kill_sb() changes done.

git rebase -i v6.5-rc1 -x "make fs/"

builds cleanly. Please double check!

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[01/13] xfs: reformat the xfs_fs_free prototype
        https://git.kernel.org/vfs/vfs/c/183f60c58f51
[02/13] xfs: remove a superfluous s_fs_info NULL check in xfs_fs_put_super
        https://git.kernel.org/vfs/vfs/c/94d1bb71d395
[03/13] xfs: free the xfs_mount in ->kill_sb
        https://git.kernel.org/vfs/vfs/c/b92fea73ce6a
[04/13] xfs: remove xfs_blkdev_put
        https://git.kernel.org/vfs/vfs/c/3b6c117834c2
[05/13] xfs: close the RT and log block devices in xfs_free_buftarg
        https://git.kernel.org/vfs/vfs/c/6d4e81f94e80
[06/13] xfs: close the external block devices in xfs_mount_free
        https://git.kernel.org/vfs/vfs/c/bfeb8750e6fe
[07/13] xfs: document the invalidate_bdev call in invalidate_bdev
        https://git.kernel.org/vfs/vfs/c/e4676171bad6
[08/13] ext4: close the external journal device in ->kill_sb
        https://git.kernel.org/vfs/vfs/c/e1a1b0fba97b
[09/13] exfat: don't RCU-free the sbi
        https://git.kernel.org/vfs/vfs/c/6a3f5dee46f6
[10/13] exfat: free the sbi and iocharset in ->kill_sb
        https://git.kernel.org/vfs/vfs/c/cc0313e8135e
[11/13] ntfs3: rename put_ntfs ntfs3_free_sbi
        https://git.kernel.org/vfs/vfs/c/34371bb44afc
[12/13] ntfs3: don't call sync_blockdev in ntfs_put_super
        https://git.kernel.org/vfs/vfs/c/91952e99005b
[13/13] ntfs3: free the sbi in ->kill_sb
        https://git.kernel.org/vfs/vfs/c/5fb25fde7dee
