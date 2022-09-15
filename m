Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11375B9252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 03:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIOBss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 21:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiIOBsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:48:46 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A58E4C4;
        Wed, 14 Sep 2022 18:48:44 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JAL00038;
        Thu, 15 Sep 2022 09:48:38 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.12; Thu, 15 Sep 2022 09:48:38 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] acl: fix the comments of posix_acl_xattr_set
Date:   Wed, 14 Sep 2022 21:48:30 -0400
Message-ID: <20220915014830.1671-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202291509483862b65ce9929ae927b401b4472fcad13c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

remove the double world of 'in'.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4e69cce6bd2a..74dc0f571dc9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1177,7 +1177,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		 * ACL_{GROUP,USER} have already been mapped according to the
 		 * caller's idmapping. The vfs_set_acl_prepare() helper will
 		 * recover them and take idmapped mounts into account. The
-		 * filesystem will receive the POSIX ACLs in in the correct
+		 * filesystem will receive the POSIX ACLs in the correct
 		 * format ready to be cached or written to the backing store
 		 * taking the filesystem idmapping into account.
 		 */
-- 
2.27.0

