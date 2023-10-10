Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573997BFA61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjJJLwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 07:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjJJLwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:52:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF2A4;
        Tue, 10 Oct 2023 04:52:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EE1C433C8;
        Tue, 10 Oct 2023 11:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696938748;
        bh=lS6j666yQyoqSWNnJzvLxKDEG6aA7JaskJUk41LjEXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiEk4CH0tcflNyGjG7ZTG2xo4gmxTrebyMOCAKM/H9Yr6bkz/c88nKgStSnN0jpSx
         Bg+gFqtkEkmiWdSYu/rw1fzgy/lwH1MxwHxtyaqXphULb9ywuoiGrn4UZ+5sopnAIy
         Enxj834wq1Ug16wWZvuwwWYAd5T35D+kxhVa2Yflrpw1EqWolMtwzc/l8OBAUe37yi
         Hw1R9gsx24+KTRXSKLVT9xYyZ/BThYTL2hYrGrOKtssp0PUIdYvXCOpDCIS+lrfwJb
         eOO4dicGiN1ZVEDSNLgzZaKkrJ7Gg1hFIZMdXhwMoKM0ZpdG1GyxUhp1a2MLK81qCT
         HCO91tVJegkTg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Reduce impact of overlayfs backing files fake path
Date:   Tue, 10 Oct 2023 13:52:09 +0200
Message-Id: <20231010-lohnen-botanik-7bf974a5cecd@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009153712.1566422-1-amir73il@gmail.com>
References: <20231009153712.1566422-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=brauner@kernel.org; h=from:subject:message-id; bh=lS6j666yQyoqSWNnJzvLxKDEG6aA7JaskJUk41LjEXs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSqWj0RW27+IHNtNc+h6B4hm3VMFRl7+3L+7amr2nuh/N3N Ys35HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5JMLwV1wgSujt+5k83WdfTjcw/S ic8jtytvD87y8d0jZO2pW1vJXhn/r6hUt2vPkq47fIhae1rkfU489Olind0hwdBcK/2fc08QAA
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

On Mon, 09 Oct 2023 18:37:09 +0300, Amir Goldstein wrote:
> Following v3 addresses Al's review comments on v2.
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/3] fs: get mnt_writers count for an open backing file's real path
      https://git.kernel.org/vfs/vfs/c/90e168d5fa01
[2/3] fs: create helper file_user_path() for user displayed mapped file path
      https://git.kernel.org/vfs/vfs/c/842b845c7657
[3/3] fs: store real path instead of fake path in backing file f_path
      https://git.kernel.org/vfs/vfs/c/6b9503cf48c9
