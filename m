Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3BB1054F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKUPAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:00:06 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:46914 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKUPAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:00:06 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 10:00:05 EST
X-EEMSG-check-017: 28892412|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="28892412"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Nov 2019 14:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574347976; x=1605883976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tcKnvQLgqBXv7HLv3hHK9qIGEuQsTJADxqlEnP3ZuKA=;
  b=GXy/YbawVYhMtiAIoDb3yzz6cW8RZP8S2/RieYAhzT1S5kC35R2llbmP
   Ybi20OGfs753XyKHdfi9OY+Tk0BGlBswzu5n1Z5s/+An7ncybMwtSnhMr
   LDnEE+aAQmxTGGrd+8LqVmpi6u9IwpqpErSLwKvsuhAhSlmd5TNevso7E
   Sr5sZa0EQrwHAg6kvYD//dKfEfjq/OF8NHVsDPXpMlUmeO9t7EZyw0v/Z
   kFLyCPzhKZC8X1bbS1eNwJqYbxwCQ7jZVmDnAstf+qWN983kst+/A8q8u
   627GeAmv0J3GxGfC+c2IxXHDU1TYav7NWteDhcp0ma/ksK90W/Sl024mO
   g==;
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="35831872"
IronPort-PHdr: =?us-ascii?q?9a23=3AKreBqx07kNQ7upt6smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKf3xwZ3uMQTl6Ol3ixeRBMOHsqkC0reM+P66EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7rRvdusYXjId8N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhykdNz497WrZlMp+gqxGqx6lvhByw4rZbISTOfFjfK3SYMkaSH?=
 =?us-ascii?q?JBUMhPSiJPDICyYYwNAOoPMulWoJLwq0cNoBakGQWhHv/jxiNOi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QI9A9IBrmzUrNXrO6cUTOu70azIwi/Hb/NSxzj86JXDfxc6of6RRr?=
 =?us-ascii?q?J9atbRyEkzGAPFiVWcs4rlPyiP2egXvGib6PRgWPuphmU6qA9xuiCiytojh4?=
 =?us-ascii?q?TGnI4Yyk3I+T9nzIs6O9G0UlN3bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJ5Yr2/nRey8VW7yuHmSsm10E?=
 =?us-ascii?q?pFripCktXWsHACywfT5dSdRvt4/0eh3S6D1wHV6u5aPUA5jbfXJpEuz7Iqlp?=
 =?us-ascii?q?cfrF7PEjH5lUnolqOaa10o+u2y5OTmZrXmqIWcN4hxigzmKaQhh9e/DP8kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/U3iWrpGlPI2kq7HsJzCP8QUura5AxNJ0oYk8xu/Czam0N?=
 =?us-ascii?q?IFnXgINV5FdgmHgJX3NFHQPv/4Ceyyg0qjkDh13fDKJL7hDYvXLnjFjrjhea?=
 =?us-ascii?q?xx60lGyAo81dpf/Y5bCqkdIPLvXU/8rNrYAQE4Mwyw2OnqE8591p4FWW2RGK?=
 =?us-ascii?q?OWLb3du0eS5u0zO+mMeJMVuDHlJvg75v7ul3g5lEQcfKa325sXaW64Eu5iI0?=
 =?us-ascii?q?WYZ3rsn9gAHX0NvgokQ+zmkkCCUT1LbXaoQ608/i07CJ6hDYrbSIGtgbiB3C?=
 =?us-ascii?q?OgE51VeG9GEFaMHmnsd4meXPcMci2SKNd7kjMYTbihV5Mh1Ra2uQ/i0bVnM+?=
 =?us-ascii?q?7U9zYAtZ35ydh14/TflRQ19TxzFcSSzXuBQH1znmMNXzU2xrxwoVRhylef1q?=
 =?us-ascii?q?h1m+dYGsJX5/NIVAc6KJHdwvdkC9D9RA3BZM2FSFW4TdW8BzE+UNYxz8UJY0?=
 =?us-ascii?q?ZnFNXxxizEijGnB74TiqyjGpM56OTf0mL3KsI7zGzJh4c7iFxzeddCLW2rgO?=
 =?us-ascii?q?ZE8gHXA4PY2xGCm72CabUX3CmL8nyKi2WJohcLA0ZLTazZUCVHNQPtptPj6x?=
 =?us-ascii?q?aHEu6j?=
X-IPAS-Result: =?us-ascii?q?A2D3AgBeodZd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CyBQTIqlAAGix6KH4ckCQEBAQEBAQEBARsZAQIBAYRAAoIoJDgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspgm4GJwsBRhBRVxmCYz+CUyWvOzOJB4FIgTaHPYRZG?=
 =?us-ascii?q?niBB4RhhA6BBIUhBI0digh0lheCNYI3kw0MG5oYLao4IoFYKwgCGAghD4MnU?=
 =?us-ascii?q?BEUlSwjAzCBBQEBjX6CQAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Nov 2019 14:52:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xALEqqJR015567;
        Thu, 21 Nov 2019 09:52:55 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 2/2] selinux: fall back to ref-walk upon LSM_AUDIT_DATA_DENTRY too
Date:   Thu, 21 Nov 2019 09:52:45 -0500
Message-Id: <20191121145245.8637-2-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121145245.8637-1-sds@tycho.nsa.gov>
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
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
Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
LSM_AUDIT_DATA_INODE only requires this handling due to the fact
that dump_common_audit_data() calls d_find_alias() and collects the
dname from the result if any.
Other cases that might require similar treatment in the future are
LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
a path or file is called under RCU-walk.

Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 74c43ebe34bb..f1fa1072230c 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
 	 * during retry. However this is logically just as if the operation
 	 * happened a little later.
 	 */
-	if ((a->type == LSM_AUDIT_DATA_INODE) &&
+	if ((a->type == LSM_AUDIT_DATA_INODE ||
+	     a->type == LSM_AUDIT_DATA_DENTRY) &&
 	    (flags & MAY_NOT_BLOCK))
 		return -ECHILD;
 
-- 
2.23.0

