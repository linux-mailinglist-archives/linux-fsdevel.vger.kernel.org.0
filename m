Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57056C8A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGIKHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jul 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGIKHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDD4B0FA;
        Sat,  9 Jul 2022 03:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE7D60DE9;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F58FC341CE;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=dqYqnXuzEPE0mXihhCJPYUpFXM9zwpfA8rk6kSTuBCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKfzx3SqXsJGBAjpsgDp6mypn1L5oUbOzKatAFWraRL49e9nq1dnhRUIYWNjmdkCm
         ImzGorGOPul0XG+ZwWHru7Y4g2RqB/EBU18NdDa+7xUaTcju3MlMnoYnvDLhginzxn
         +WZ8YDUZtfzmJzYXBCzAsz+YsHbZZssFwR99l9Drs3XtOqSwxuJH5RhyHck9B+h5L4
         Zk6yJRNPQKKap1ztitDAo47wA3Fi9ANOjwFY0nDxrNlj/pPyePAF34n8/tO07SOD4u
         38DnHUEk76GYExc6lDMX/ymd43tkqJFmbaF5bPJPclBSU1yYX7mdS8a6hM8SpK9X4U
         H8lxc9/OPfztA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGo-HT;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/21] fs: namei: address some kernel-doc issues
Date:   Sat,  9 Jul 2022 11:07:21 +0100
Message-Id: <c6e79b4e972c7c1890c22c15e5391dbef0e2f619.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are couple of symbols missing documentation:

	fs/namei.c:649: warning: Function parameter or member 'mnt' not described in 'path_connected'
	fs/namei.c:649: warning: Function parameter or member 'dentry' not described in 'path_connected'
	fs/namei.c:1089: warning: Function parameter or member 'inode' not described in 'may_follow_link'

Document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 fs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..a8079d6250bc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -640,6 +640,8 @@ static bool nd_alloc_stack(struct nameidata *nd)
 
 /**
  * path_connected - Verify that a dentry is below mnt.mnt_root
+ * @mnt: pointer to vfs mount
+ * @dentry:  pointer to dentry to verify
  *
  * Rename can sometimes move a file or directory outside of a bind
  * mount, path_connected allows those cases to be detected.
@@ -1072,6 +1074,7 @@ fs_initcall(init_fs_namei_sysctls);
 /**
  * may_follow_link - Check symlink following for unsafe situations
  * @nd: nameidata pathwalk data
+ * @inode: inode to check
  *
  * In the case of the sysctl_protected_symlinks sysctl being enabled,
  * CAP_DAC_OVERRIDE needs to be specifically ignored if the symlink is
-- 
2.36.1

