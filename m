Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936255DA47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiF1JrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbiF1Jqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21225C5A;
        Tue, 28 Jun 2022 02:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7257BB81D8E;
        Tue, 28 Jun 2022 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAC3C3411D;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=sTi4x9ZoZpkbQr4+xjPIIlVa/suTKm/0lLP05XVf1f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Roh2K2uEouhV7ax8h2Vhchn+12/YTfUUS2F/Uz48hFp0Tr1yfOXCYbtIMoY+R2VbR
         hc6oX+g3EgDon6XPqm8DKQFGi1kn0bfZcEMkv4iSGTu71abraXin7rwX+hprHq8sQF
         TO6rLghyUh0UGj6iXohFEdC0Bjc0z/DmawhKH1jHN4EROLOWbatoJejD236ecrWvEV
         PjN2wCmDgMal/iycvRUWV1H4x9nDj4Jy2HKBl8jZTGQb4vyrZhfMlUdVY/6kPpMOSK
         RAClAg2j9sYe1JOdj6hdnZtvLDw0oxrGEWxC7A3kAYk9NndT+TmlDAk5nCM31wLLrM
         iooErJJYiRWQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HF1-Nz;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] fs: attr: update vfs uid/gid parameters at kernel-doc
Date:   Tue, 28 Jun 2022 10:46:10 +0100
Message-Id: <cd2746e9496731e559dc8129c6bade369be25c4b.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vfs uid/gid parameters have a different name at the function
prototype causing kernel-doc warnings. Update them for the parameters
to match, fixing those warnings:

	fs/attr.c:36: warning: Function parameter or member 'ia_vfsuid' not described in 'chown_ok'
	fs/attr.c:36: warning: Excess function parameter 'uid' description in 'chown_ok'
	fs/attr.c:63: warning: Function parameter or member 'ia_vfsgid' not described in 'chgrp_ok'
	fs/attr.c:63: warning: Excess function parameter 'gid' description in 'chgrp_ok'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 fs/attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 1ba7ddef537f..b5b8835ddf15 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -22,7 +22,7 @@
  * chown_ok - verify permissions to chown inode
  * @mnt_userns:	user namespace of the mount @inode was found from
  * @inode:	inode to check permissions on
- * @uid:	uid to chown @inode to
+ * @ia_vfsuid:	uid to chown @inode to
  *
  * If the inode has been found through an idmapped mount the user namespace of
  * the vfsmount must be passed through @mnt_userns. This function will then
@@ -49,7 +49,7 @@ static bool chown_ok(struct user_namespace *mnt_userns,
  * chgrp_ok - verify permissions to chgrp inode
  * @mnt_userns:	user namespace of the mount @inode was found from
  * @inode:	inode to check permissions on
- * @gid:	gid to chown @inode to
+ * @ia_vfsgid:	gid to chown @inode to
  *
  * If the inode has been found through an idmapped mount the user namespace of
  * the vfsmount must be passed through @mnt_userns. This function will then
-- 
2.36.1

