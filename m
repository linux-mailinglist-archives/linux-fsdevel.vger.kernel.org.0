Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1897251103
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgHYE51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 00:57:27 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:33416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728043AbgHYE50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 72EF6181D337B;
        Tue, 25 Aug 2020 04:57:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3868:4321:5007:6261:8603:10004:10848:11026:11658:11914:12296:12297:12555:12895:13069:13311:13357:13894:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: bed18_451327127059
X-Filterd-Recvd-Size: 2137
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:24 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] fuse: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:20 -0700
Message-Id: <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/fuse/dir.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..ecb6eed832a0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1362,14 +1362,22 @@ static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
 {
 	unsigned ivalid = iattr->ia_valid;
 
-	if (ivalid & ATTR_MODE)
-		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
-	if (ivalid & ATTR_SIZE)
-		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
+	if (ivalid & ATTR_MODE) {
+		arg->valid |= FATTR_MODE;
+		arg->mode = iattr->ia_mode;
+	}
+	if (ivalid & ATTR_UID) {
+		arg->valid |= FATTR_UID;
+		arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
+	}
+	if (ivalid & ATTR_GID) {
+		arg->valid |= FATTR_GID;
+		arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+	}
+	if (ivalid & ATTR_SIZE) {
+		arg->valid |= FATTR_SIZE;
+		arg->size = iattr->ia_size;
+	}
 	if (ivalid & ATTR_ATIME) {
 		arg->valid |= FATTR_ATIME;
 		arg->atime = iattr->ia_atime.tv_sec;
-- 
2.26.0

