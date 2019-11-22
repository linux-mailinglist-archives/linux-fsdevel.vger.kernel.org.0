Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D535B107672
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 18:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVRaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 12:30:11 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:4964 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:30:11 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 12:30:09 EST
X-EEMSG-check-017: 53842449|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="53842449"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 17:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574443380; x=1605979380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXBbc/svmcsnGs3eWp8lTAV7Z/+Ww1EYI2DNJkgS/1U=;
  b=OgX2mWphqEXpQNgFrT+cmpbPbtSm/Exkzubbi7+p/tS4sRax7PLO0yFr
   t0pcFg6wzHFux6RyEQNGubDpKtyhzkZbHTJ4OSRpMV/xOGsxyKPvHwDqq
   lmg9Hyx2AcW6LKAT91pAwP7SvtD8N6TmIPk719/w9MzH3AlVK1jBCVlHo
   KKYWsz/N114iqK/kcXEI6I7bjDC3Hw122Io137sUGH+kV5SpaDkCV+U/X
   lpqsDKmHpfKTns8eHhQPmQMe3K8BYeD2V/wB2Ik41DCQeoeXP72IT0qH4
   8ijbJ61uE2gtoaYARNuE4hK9MY9AgSlqcPBORveZKjWgnsIZtdEHk12E3
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="30419210"
IronPort-PHdr: =?us-ascii?q?9a23=3AfQo4whY4vd9rRWYCUK0hVOz/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps25Yx7h7PlgxGXEQZ/co6odzbaP6Oa5BDBLsMbJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusQWjoZuJaI8xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU2/nvXishth6xFphyvqQF0z4rNbI2LMPdye6XQds4YS2?=
 =?us-ascii?q?VcRMZcTyxPDJ2hYYUBDOQPOuRXr4fyqFUBthayGQqhCfnzxjJSmnP6was32P?=
 =?us-ascii?q?khHwHc2wwgGsoDvmnIrNrrLKcSUf66zK/VxjveavNZwzP96IzWfREhvPqBWq?=
 =?us-ascii?q?lwftfKyUQ0CwPEjkmfqYziPz+P0OQNqHKU4/BvVeKolW4qsgd8qSWsyMc0ko?=
 =?us-ascii?q?TFm40Yx1/e+Sh53Yo5P8O0RUFlbdK+DZddsTyROZFsTcM4WW5ovT43yrgBuZ?=
 =?us-ascii?q?GmYicH0I8nxxvDa/yfdIiI/w7jWP6RIThmgHJlf6qyhwqo/ki6y+38S9K03E?=
 =?us-ascii?q?xLripDnNnMsWsN2ALP5cSdVvt8/luu2TaI1wzJ7OFLPVs0mrbBJ54kw74wko?=
 =?us-ascii?q?IfsUXFHiDohEX7lLKae0or9+Sy6+nrf6/qqoGTOoNqkA3yL7wimsmlDuQ5Ng?=
 =?us-ascii?q?gOUXKb+eO51LD75k32Xa5Kg+YqkqjZrJ/aJcMbqrS/Aw9OyIkv8Rm/DzC40N?=
 =?us-ascii?q?gAh3kIMEpFeA6bj4juI1zOJPH4DfGig1WjiTtr3O7JMaH8ApXXL3jDjLfgca?=
 =?us-ascii?q?94605b1QUz0NRf6IxPB7EfL/L8RFXxuMbbDhAnKQy0xfjoCNFn2oMZQ2KPDb?=
 =?us-ascii?q?eTMLnOvl+Q+uIvP+6MaZcRuDb8Lfgl+vHvgWY3mV8GYKamw4UXZ268Hvl9PU?=
 =?us-ascii?q?WZbmTjgs0bHWcJoAU+Vurqh0OGUTJJYHayRa087CkhCI26FYfDWpytgLuZ0S?=
 =?us-ascii?q?e9AJJWZ2RGBUuXHHfzaoWEQOkDZDiPLcB/ijYET6SuS5c91RGysw/306RnLu?=
 =?us-ascii?q?vO+i0frp/i1cZ65+vSlREs7zB0C8Wd02eQT2B7hG8IQCU23K9lrUxgyVeJyb?=
 =?us-ascii?q?J4jOBAFdxP+/NJVR83NJDdz+x+D9D/QQHBccmTSFagXNqmBSs9TtUrw98Be0?=
 =?us-ascii?q?x9Acmtjgjf3yq2BL8Yj6SLC4Yp8qLYxHXxP9xyy2vC1KU4ilkmRcxPNXe4ia?=
 =?us-ascii?q?Jl6wfTAIvJmV2Dl6m2baQcwDLN9GCbwGqVok5YVA9wUaPYXXEQfUbWs9v56V?=
 =?us-ascii?q?3YT7O0CrQoLBFBycicJatOcNHpik9GRPiwcOjZNnm8n2a2GAag2LyBdszpdn?=
 =?us-ascii?q?8b0SGbD1ILwC4J+nPTDhQzHiespSrlCTVqEV/+Kxf3/fJWtGKwTkhyyRqDKU?=
 =?us-ascii?q?JmyezmqVYumfWARqZLjfo/syA7pmAxRgew?=
X-IPAS-Result: =?us-ascii?q?A2DrAAAYGdhd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqNLYZTBosekUMJAQEBAQEBAQEBGxwBAYRAAoJOOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOymCbgYnCwFGEFFXGYJjP4JTJbBUM4kLgUiBNoc9h?=
 =?us-ascii?q?HN4gQeEYYozBI0SCwqJfnSWF4I1gjeTDQwbmhiqZSKBWCsIAhgIIQ+DJ1ARF?=
 =?us-ascii?q?IZUF45BIwMwkUUBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 17:22:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMHMlUl099086;
        Fri, 22 Nov 2019 12:22:50 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] selinux: fall back to ref-walk if audit is required
Date:   Fri, 22 Nov 2019 12:22:45 -0500
Message-Id: <20191122172245.7875-2-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122172245.7875-1-sds@tycho.nsa.gov>
References: <20191122172245.7875-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
passed down the rcu flag to the SELinux AVC, but failed to adjust the
test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
Previously, we only returned -ECHILD if generating an audit record with
LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
Move the handling of MAY_NOT_BLOCK to avc_audit() and its inlined
equivalent in selinux_inode_permission() immediately after we determine
that audit is required, and always fall back to ref-walk in this case.

Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
Reported-by: Will Deacon <will@kernel.org>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c         | 24 +++++-------------------
 security/selinux/hooks.c       | 11 +++++++----
 security/selinux/include/avc.h |  8 +++++---
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 74c43ebe34bb..23dc888ae305 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -424,7 +424,7 @@ static inline int avc_xperms_audit(struct selinux_state *state,
 	if (likely(!audited))
 		return 0;
 	return slow_avc_audit(state, ssid, tsid, tclass, requested,
-			audited, denied, result, ad, 0);
+			audited, denied, result, ad);
 }
 
 static void avc_node_free(struct rcu_head *rhead)
@@ -758,8 +758,7 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 noinline int slow_avc_audit(struct selinux_state *state,
 			    u32 ssid, u32 tsid, u16 tclass,
 			    u32 requested, u32 audited, u32 denied, int result,
-			    struct common_audit_data *a,
-			    unsigned int flags)
+			    struct common_audit_data *a)
 {
 	struct common_audit_data stack_data;
 	struct selinux_audit_data sad;
@@ -772,17 +771,6 @@ noinline int slow_avc_audit(struct selinux_state *state,
 		a->type = LSM_AUDIT_DATA_NONE;
 	}
 
-	/*
-	 * When in a RCU walk do the audit on the RCU retry.  This is because
-	 * the collection of the dname in an inode audit message is not RCU
-	 * safe.  Note this may drop some audits when the situation changes
-	 * during retry. However this is logically just as if the operation
-	 * happened a little later.
-	 */
-	if ((a->type == LSM_AUDIT_DATA_INODE) &&
-	    (flags & MAY_NOT_BLOCK))
-		return -ECHILD;
-
 	sad.tclass = tclass;
 	sad.requested = requested;
 	sad.ssid = ssid;
@@ -855,16 +843,14 @@ static int avc_update_node(struct selinux_avc *avc,
 	/*
 	 * If we are in a non-blocking code path, e.g. VFS RCU walk,
 	 * then we must not add permissions to a cache entry
-	 * because we cannot safely audit the denial.  Otherwise,
+	 * because we will not audit the denial.  Otherwise,
 	 * during the subsequent blocking retry (e.g. VFS ref walk), we
 	 * will find the permissions already granted in the cache entry
 	 * and won't audit anything at all, leading to silent denials in
 	 * permissive mode that only appear when in enforcing mode.
 	 *
-	 * See the corresponding handling in slow_avc_audit(), and the
-	 * logic in selinux_inode_follow_link and selinux_inode_permission
-	 * for the VFS MAY_NOT_BLOCK flag, which is transliterated into
-	 * AVC_NONBLOCKING for avc_has_perm_noaudit().
+	 * See the corresponding handling of MAY_NOT_BLOCK in avc_audit()
+	 * and selinux_inode_permission().
 	 */
 	if (flags & AVC_NONBLOCKING)
 		return 0;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3eaa3b419463..fd34e25c016f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3015,8 +3015,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 
 static noinline int audit_inode_permission(struct inode *inode,
 					   u32 perms, u32 audited, u32 denied,
-					   int result,
-					   unsigned flags)
+					   int result)
 {
 	struct common_audit_data ad;
 	struct inode_security_struct *isec = selinux_inode(inode);
@@ -3027,7 +3026,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 
 	rc = slow_avc_audit(&selinux_state,
 			    current_sid(), isec->sid, isec->sclass, perms,
-			    audited, denied, result, &ad, flags);
+			    audited, denied, result, &ad);
 	if (rc)
 		return rc;
 	return 0;
@@ -3074,7 +3073,11 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (likely(!audited))
 		return rc;
 
-	rc2 = audit_inode_permission(inode, perms, audited, denied, rc, flags);
+	/* fall back to ref-walk if we have to generate audit */
+	if (flags & MAY_NOT_BLOCK)
+		return -ECHILD;
+
+	rc2 = audit_inode_permission(inode, perms, audited, denied, rc);
 	if (rc2)
 		return rc2;
 	return rc;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 74ea50977c20..cf4cc3ef959b 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -100,8 +100,7 @@ static inline u32 avc_audit_required(u32 requested,
 int slow_avc_audit(struct selinux_state *state,
 		   u32 ssid, u32 tsid, u16 tclass,
 		   u32 requested, u32 audited, u32 denied, int result,
-		   struct common_audit_data *a,
-		   unsigned flags);
+		   struct common_audit_data *a);
 
 /**
  * avc_audit - Audit the granting or denial of permissions.
@@ -135,9 +134,12 @@ static inline int avc_audit(struct selinux_state *state,
 	audited = avc_audit_required(requested, avd, result, 0, &denied);
 	if (likely(!audited))
 		return 0;
+	/* fall back to ref-walk if we have to generate audit */
+	if (flags & MAY_NOT_BLOCK)
+		return -ECHILD;
 	return slow_avc_audit(state, ssid, tsid, tclass,
 			      requested, audited, denied, result,
-			      a, flags);
+			      a);
 }
 
 #define AVC_STRICT 1 /* Ignore permissive mode. */
-- 
2.23.0

