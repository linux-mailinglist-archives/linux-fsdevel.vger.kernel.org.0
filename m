Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D641509821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385427AbiDUG61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385489AbiDUG5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:57:06 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6E15A2C;
        Wed, 20 Apr 2022 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650524052; i=@fujitsu.com;
        bh=Tzs2F8+0DEjTwEaGrFc3SQdIHq8vdHXoRQd3UlmB4t8=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Kk+2svfqG4dXOjjngB0W6PWR4WlqURmkUJEFsCS4vOmhsPBv7cFk3r2yv1pCyTjIh
         UA7GlzboV/wwU+WicaIbnqbCzA+jORyrl1byk4lFJ6l8lbpvzTi9tnshjeq7o+MmRO
         61gqLBCta4zuU78RURI0vol6fPej+hmO1uWe32+lQ/qtF2zYUbSIeOcgqPrbjwAm6H
         oOWpLoFpCRsgNyHLNzTYTLzFyhMq87TBTR19Cc0/aLk1qZKF6kIyOfwz+gWtHaLnjQ
         bmrsZuOdatlF9tSB84YmEuz9ZF4/NbwpAP8X/CRmGBqjYEdBc2CLcZwsSTIvcCO457
         1oYRkNR3sq9aw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8MxSXfy/4Q
  kg6Z3MhavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1kszv89zmrx+8ccNgcOj1OLJDw2
  r9Dy2LSqk83j8yY5j01P3jIFsEaxZuYl5VcksGa0nlnPXHCEs2LFoX8sDYz72LsYuTiEBLYwS
  rTsWMkI4Sxgkrh58iELhLOHUeLQvI1ADicHm4CmxLPOBcwgtoiAo8SL9hlgcWaBzYwSyx6Hdz
  FycAgLBEus/lgDEmYRUJWYf3o9I4jNK+Ah8brtM1irhICCxJSH78FsTgFPia2fOllBbCGgmtu
  bjjFB1AtKnJz5BGq8hMTBFy+gehUlLnV8Y4SwKyRmzWpjgrDVJK6e28Q8gVFwFpL2WUjaFzAy
  rWK0SirKTM8oyU3MzNE1NDDQNTQ01TXUNTI010us0k3USy3VLU8tLtE11EssL9ZLLS7WK67MT
  c5J0ctLLdnECIyVlGLGmzsYW/t+6h1ilORgUhLlvfgrIUmILyk/pTIjsTgjvqg0J7X4EKMMB4
  eSBG/vZ6CcYFFqempFWmYOMG5h0hIcPEoivMr/gNK8xQWJucWZ6RCpU4yKUuK8ViAJAZBERmk
  eXBssVVxilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMx74y/QFJ7MvBK46a+AFjMBLa6eEguy
  uCQRISXVwCTGoLM6j1NCovjWglmJ238f7bt26PiS8jxje5XaF9XGodlci7nU5Jc0TFBh3+b3w
  uUkr4r0tADFuwENWlNYSgxj5Di89L5ydwdujfO7tGazr3PapKxTPF2ffYT3bn2ZlpwtkrayTN
  qHc6Jb2afdv4pvT6xmsy/43zCx43fJAdaaozzvYx+GPNVg1tm9bvpdHevv+fHnlb/ZvAqZb8H
  3YcKH5X/zJmre/Liec/23mffN7T/59T5fsVWLLX7PT4upB28FdUU9PXVWNFlCuGZll+qS28+z
  O/b/2iqhvmj5ObEeZ8WtwuuOcaV+O1RfrFJim2ihEX5vzeMbZhOmfZPsWzVX63BaUE/68drwF
  S+NpiixFGckGmoxFxUnAgDVLxvtkAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-587.messagelabs.com!1650524051!11495!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24026 invoked from network); 21 Apr 2022 06:54:11 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-3.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Apr 2022 06:54:11 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id F22A410045E;
        Thu, 21 Apr 2022 07:54:10 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E167E100478;
        Thu, 21 Apr 2022 07:54:10 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 21 Apr 2022 07:53:57 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v5 4/4] ceph: Remove S_ISGID clear code in ceph_finish_async_create
Date:   Thu, 21 Apr 2022 15:54:18 +0800
Message-ID: <1650527658-2218-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since vfs has stripped S_ISGID in the previous patch, the calltrace
as below:

vfs:	lookup_open
	...
	  if (open_flag & O_CREAT) {
                if (open_flag & O_EXCL)
                        open_flag &= ~O_TRUNC;
                mode = prepare_mode(mnt_userns, dir->d_inode, mode);
	...
	   dir_inode->i_op->atomic_open

ceph:	ceph_atomic_open
	...
	      if (flags & O_CREAT)
            		ceph_finish_async_create

We have stripped sgid in prepare_mode, so remove this useless clear
code directly.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ceph/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6c9e837aa1d3..8e3b99853333 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -651,10 +651,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		/* Directories always inherit the setgid bit. */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(dir->i_gid) &&
-			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
 	} else {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
 	}
-- 
2.27.0

