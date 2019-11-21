Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78C01054F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKUPAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:00:05 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:46914 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfKUPAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:00:05 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 10:00:05 EST
X-EEMSG-check-017: 28892406|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="28892406"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Nov 2019 14:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574347975; x=1605883975;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lbTlVgtbWT2SqCD5ezZSdGjFU3X0qbqiNGxy8Lm/8fw=;
  b=pdmxTQzCMONPSN2IO5n3bSN3Ipyaoq4R3uF74UnLTjg9tINHwl/vZvW3
   KtfznE1EOVj+uapa0i14193vI7n2oLZbLZ1pa3nKzYqP+kvIKd9Eldbly
   y0U6PTcsybZlRdw4A0358z5Mn6/e6364NJoCIhwfjGD5HtJ3vDlx0Pftz
   vMXdCVmX7YOkpAqJWDn8Pqzqm7QoNUECUSbzkXc95FLpR0qf5kYI6qqyB
   ShaZ7doA/yf3xwqQyFwW1SkuQxnHTVXocJg7eGrsEhXq34w/Sn/NsNXwI
   FK8J9clbsJpK95+lhgNEUiUe94I7au3mHk+rV312iN4lvQ6x/95shptBW
   g==;
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="35831864"
IronPort-PHdr: =?us-ascii?q?9a23=3ABAznLR8Ayd2JDf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+gRIJqq85mqBkHD//Il1AaPAdyArasZ0aGI6ejJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRWooQnet8Qan5ZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxDmkicHMyMy/n/RhMJ+kalXpAutqhx7zoLRZoyeKfhwcb7Hfd4CRW?=
 =?us-ascii?q?RPQNtfWSJCDI27YIQBAPEMMfpbooTnu1cDtweyCRWqCejyyjFInHj23agi3u?=
 =?us-ascii?q?o8DQHJwhQgH9IQv3TSsd77KaISXvqxzKnM0zrCb+5d1DDm6IfVaRAsuu2MXL?=
 =?us-ascii?q?JsfsrRzkkjDQXFjk6KpoD/MDOV0foNvnGd4uF9Vuyvk3Yqpxx+rzWg3Mship?=
 =?us-ascii?q?TFipgLxl3L6yl12ps5KNulQ0Bhe9GkCoFftySCOotzRcMtXn9ntT4hyr0DpZ?=
 =?us-ascii?q?67ZC8KyIk7xxLHa/yIbYyI4hX7WeaNOzh4nnNleK+khxqo7UihyvHzVsmz0F?=
 =?us-ascii?q?pQqCpKjsLMuWwX2xzW68iHTuNx/kan2TmRywDe8vxILE87mKbBK5Mt36Q8mo?=
 =?us-ascii?q?QcvEjdBCP6hV36jKqMeUUl/uio5f7nYrLjppKELI97lxr+P78yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eSnzrLv50L5QLJUjvEuiKnWrIjaJdgHpq6+GwJV1ocj6xCiDzapyd?=
 =?us-ascii?q?gYk2IHI09bdxKZkYfpP0rDIO73DfihmVSgijRryO7cPr3nHJrNKmLPkLD7fb?=
 =?us-ascii?q?Zy80Rc0hY8zchD55JIDbEMOPTzVVHwtNzcFRA0KBe0w/v8CNpjzI8RRHyACL?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8LuTb9Mf8l6uXvjHAnn18dfLep0YETaHC5GPRmPk?=
 =?us-ascii?q?qYbWDrgtcbHmcGpBc+TO/ygl2YTTFTf2qyX7475jwjBoOmDIPDRoS2jbyCwi?=
 =?us-ascii?q?i7BJtWaX5CClyWFnfobYqEUe8WaC2OOs9hjiAEVb+5Ro85zx6uqQv6xqF/Lu?=
 =?us-ascii?q?XO5y0YsYvv1N1y5+3UjxE96yZ4ANia02GIV2t0hH8HRycq3KBjpkxw0kyD3r?=
 =?us-ascii?q?Z8g/xZE9xT+vxIXxwkNZ7T0eN6Ecr+WgHfcdeTTlapXNGmDSs2TtIrzN9dK3?=
 =?us-ascii?q?p6Ts6vihHFwjqCHbAYjfqICYYy/6aa2GL+dOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T8IX0?=
X-IPAS-Result: =?us-ascii?q?A2DzAgBeodZd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CyBQTIqlAAGix6RQwkBAQEBAQEBAQEbGQECAQGEQIIqJDgTAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIVDgjspgxsLAUaBUYJjP4JTJa87M4kHgUiBNoc9hFkaeIEHhGGKM?=
 =?us-ascii?q?wSNI4oClwuCNYI3kw0MG5oYLao4IoFYKwgCGAghD4MnUBEUhlQXFY4sIwMwg?=
 =?us-ascii?q?QUBAZA+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Nov 2019 14:52:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xALEqqJQ015567;
        Thu, 21 Nov 2019 09:52:52 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 1/2] selinux: revert "stop passing MAY_NOT_BLOCK to the AVC upon follow_link"
Date:   Thu, 21 Nov 2019 09:52:44 -0500
Message-Id: <20191121145245.8637-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reverts commit e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK
to the AVC upon follow_link"). The correct fix is to instead adjust
the test within slow_avc_audit() to handle LSM_AUDIT_DATA_DENTRY as
well as LSM_AUDIT_DATA_INODE.  This will be done by the next commit.

Fixes: e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c         | 24 ++++++++++++++++++++++--
 security/selinux/hooks.c       |  5 +++--
 security/selinux/include/avc.h |  5 +++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ecd3829996aa..74c43ebe34bb 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -862,8 +862,9 @@ static int avc_update_node(struct selinux_avc *avc,
 	 * permissive mode that only appear when in enforcing mode.
 	 *
 	 * See the corresponding handling in slow_avc_audit(), and the
-	 * logic in selinux_inode_permission for the MAY_NOT_BLOCK flag,
-	 * which is transliterated into AVC_NONBLOCKING.
+	 * logic in selinux_inode_follow_link and selinux_inode_permission
+	 * for the VFS MAY_NOT_BLOCK flag, which is transliterated into
+	 * AVC_NONBLOCKING for avc_has_perm_noaudit().
 	 */
 	if (flags & AVC_NONBLOCKING)
 		return 0;
@@ -1205,6 +1206,25 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 	return rc;
 }
 
+int avc_has_perm_flags(struct selinux_state *state,
+		       u32 ssid, u32 tsid, u16 tclass, u32 requested,
+		       struct common_audit_data *auditdata,
+		       int flags)
+{
+	struct av_decision avd;
+	int rc, rc2;
+
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
+				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
+				  &avd);
+
+	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
+			auditdata, flags);
+	if (rc2)
+		return rc2;
+	return rc;
+}
+
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 36e531b91df2..3eaa3b419463 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3008,8 +3008,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm(&selinux_state,
-			    sid, isec->sid, isec->sclass, FILE__READ, &ad);
+	return avc_has_perm_flags(&selinux_state,
+				  sid, isec->sid, isec->sclass, FILE__READ, &ad,
+				  rcu ? MAY_NOT_BLOCK : 0);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 7be0e1e90e8b..74ea50977c20 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -153,6 +153,11 @@ int avc_has_perm(struct selinux_state *state,
 		 u32 ssid, u32 tsid,
 		 u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
+int avc_has_perm_flags(struct selinux_state *state,
+		       u32 ssid, u32 tsid,
+		       u16 tclass, u32 requested,
+		       struct common_audit_data *auditdata,
+		       int flags);
 
 int avc_has_extended_perms(struct selinux_state *state,
 			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
-- 
2.23.0

