Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F0107670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVRaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 12:30:10 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:4964 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:30:10 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 12:30:09 EST
X-EEMSG-check-017: 53842443|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="53842443"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 17:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574443379; x=1605979379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKlSdP/LOu+DmbnoASttB4IvJMUEPjGIctfmhdX+mhY=;
  b=Oduyf4OkLLQe9pAUTnFBowKutD/6MCreUZ2uc8QliWxB39uv4Kwg3A2N
   y3L3JqykXSe2jpbhv7vTTAe0m0hsiWFze+Dbji9xhvEM4aub1b3fzvJFG
   PnfDkV0fL+nAomuyRY1SCBwrOQ12zsd2ENCn15qy6X26gNAWf69XGGbim
   FbzGn4bTGRbiND0MUUvgsIPc0Pv1VFYYV9i+ztpyqOzRZycY5GVIbH0mw
   reLXQff7tZRPC2TjZ7McktBAv9tdnTdZfI1V6Hf5oj6pfqQZRJ8zUD0NE
   WgyL6t7IxUTRvYtNGB6KIdmjwrTCy9ULKPK9dhuT5FCyyyIY/TAnYfwKL
   A==;
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="30419208"
IronPort-PHdr: =?us-ascii?q?9a23=3AIJBeHxR3zN0j6y9iw53lv4/OcNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZReEt8tkgFKBZ4jH8fUM07OQ7/m7HzVdvd3Q4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIttJ6o+zh?=
 =?us-ascii?q?bEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfR6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZAo2ycZYBAeQCM+hfoIbzqEADoQe9CAS2GO/i0CNEimPw0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4EtwTrHTbss31NKcMXuCz0aLG0DDDYOlS2Tf59ofJcg0qrPaXXb?=
 =?us-ascii?q?1tasrc0lUvFgPZgVWQrozpJTWV1v8XvGSB4OpgUvyvhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?TGi48a0FzJ9Th1zJwrKdC3VkJ3e8OoHZ1NvC+ALYR2WNktQ2RwtSY/zb0JpI?=
 =?us-ascii?q?C0cTARyJQi2x7fc/uHc5WU4h77VOaePzN4hHV9dbKjnRmy60mgyvDnVsWu0V?=
 =?us-ascii?q?ZKqCRFkt7Xtn8TyxPf8NSHS/th8Ueh3jaDzQbT5f1fIU8oj6bbLp8hwroomp?=
 =?us-ascii?q?oSt0TMADP2lV3rgKKZeUgo4Oil5/n9brn4qZKQKZV4hhzmPqQrgMO/AOA4Mg?=
 =?us-ascii?q?YUX2ic/OSxzKbj8lDiQLhRkv03krXWsJDdJcgBoK65GBVa3pws6xa4ETeqyM?=
 =?us-ascii?q?4YkmUfLFJZZBKHiJDkO1XPIPD+EPe+jE2gkCx1yP/aI73hGJTNLmTDkbv4eL?=
 =?us-ascii?q?Z97FNTyBc3zd9B/J9UFL4BL+zpWkPrt9zXEAU5MwqqzObjEtl90ZkeWW2XCK?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUYI8VuTD9K+Uq5vL3g385gkIScre33ZQJbHC1BepmI0?=
 =?us-ascii?q?qHbnr2mNsBEnkFvhA4TOP0jF2OSzlTZ2y9X6gk/DE0FJqmDZvfRoCqmLGB2j?=
 =?us-ascii?q?m0HpxSZm9dEV2MCmrod56aVPsWdS2dPNdrkiYYWri5V48hyRauuRfky7pmNO?=
 =?us-ascii?q?rU/TYVtJP929hz5u3Tiws+9Th1D8SbzmGMQHt4nmQSRz85xqx/vE99wE+Z0a?=
 =?us-ascii?q?dkm/xYCcBT5/RRXwY0NJ7cy+h6BsvxWg3fZNeJTkipQtG8DTE2VNIxzMcEY1?=
 =?us-ascii?q?xhFNW6khDDwy2qDqcNl7ORGZw09rnR32DrKMZgz3bKzawhj14hQstVK2KqnL?=
 =?us-ascii?q?Jw9w/WB4TRiUWWi76qdbgA3C7K7GqD1nSBvEVZUA52TKXEUmsSZlXZrdvn/E?=
 =?us-ascii?q?POVbyuBqo9MgtH18GCLrFGatrzjVVJF7/fP4HFbmawnXqgLQiHy6nKb4fwfW?=
 =?us-ascii?q?gZmiLHBxsqiQcWqE2aOBA+CyHpmGfXCDhjBBq7eE/32fVvo3O8CEkvxkeFaF?=
 =?us-ascii?q?M3hOn9wQIcmfHJE6Bb5bkDoip07m4lEQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DHAgAYGdhd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IFtIBIqjS2GUwaLHpFDCQEBAQEBAQEBARscAQGEQIJQOBMCEAEBAQQBAQEBA?=
 =?us-ascii?q?QUDAQFshUOCOymDGwsBRoFRgmM/glMlsFQziQuBSIE2hz2Ec3iBB4RhijMEl?=
 =?us-ascii?q?yWXC4I1gjeTDQwbmhgtqjgigVgrCAIYCCEPgydQERSGVBcVjiwjAzCRRQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 17:22:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMHMlUk099086;
        Fri, 22 Nov 2019 12:22:48 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: revert "stop passing MAY_NOT_BLOCK to the AVC upon follow_link"
Date:   Fri, 22 Nov 2019 12:22:44 -0500
Message-Id: <20191122172245.7875-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reverts commit e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK
to the AVC upon follow_link"). The correct fix is to instead fall
back to ref-walk if audit is required irrespective of the specific
audit data type.  This is done in the next commit.

Fixes: e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link")
Reported-by: Will Deacon <will@kernel.org>
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

