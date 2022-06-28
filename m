Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE855CDC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbiF1JrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbiF1Jqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8029325C6D;
        Tue, 28 Jun 2022 02:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C534B81D92;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC66C341D1;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=Ms5JmO/YVveA71jHzxf9CpKV8ph43B9gY0cCetOz/GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGbAXWP1HHRzM4gQTAP86HupxxsnRqE9d3ydeGxprJnSkY/sSmWQgtQ8sEycyHc0H
         uRiYeU5QlC8R+gAGkTcRt8n2AfW+U6aqcWbHihVnlqmxT+zMP2o3AmOwwtH+lFKNxi
         LJ2u8Ur9VNgD4FO60fsoBnS5HCZUQIzJuuTJSA/y8ZdAnmmWYtMqZ0Cyic7wfN2RDM
         nOckaHhh6deQxudn90MfQIE2onYO9nWcgnUuYAe2hkVnQ6jumUX94cOUjNKDCuBjxN
         eKEIIAaiiGW2ddu4nxHB1oW7a2W/43mlgn48DCri+kOE6KsB53TwSoGW3UBo/vCJK/
         dGqAnm+qHEwHA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HF4-Oc;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/22] fs: namei: address some kernel-doc issues
Date:   Tue, 28 Jun 2022 10:46:11 +0100
Message-Id: <4a1bbfb71afc91ab643a74c5d3b16c4f506b35a1.1656409369.git.mchehab@kernel.org>
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

There are couple of symbols missing documentation:

	fs/namei.c:649: warning: Function parameter or member 'mnt' not described in 'path_connected'
	fs/namei.c:649: warning: Function parameter or member 'dentry' not described in 'path_connected'
	fs/namei.c:1089: warning: Function parameter or member 'inode' not described in 'may_follow_link'

Document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

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

