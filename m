Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2023D5027DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352100AbiDOKFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352075AbiDOKFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:05:13 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E99BB096;
        Fri, 15 Apr 2022 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650016963; i=@fujitsu.com;
        bh=P+f9EIyUEbljZpZHlSR64Os55fmb75i3xES1pwHH2Mo=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=f52fZ/6Q6Q8vmwWotVd+qslURKbGpSCXzOhJANQu8rxIQMzdvxk9HzflJV56l/PV1
         t3vF2CzJp7XUVagcojTNFs2ltCcgkwxHsqhFFb52LaltnrnNorChf4fiHoNEojZF/c
         oPC7cnrsdjAH1G2oXltBgKuwhixO7wEGyo8nEjbmKPTrhWhGxw6TpQwLCnDjoEYT60
         mdzXdUbNevzRTGpK7Rt2RWdUsu9EQgOKNY7+c/FtWBbSoK/aWbj9IXdS3fYVL1mg3s
         A86KC53AsjmmqUecFr0vqSPv3ODcX0YBjptBtn/UZc0/apQJwd2J29dyR/txVf3WG0
         UR8oqOVIrSqUQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleJIrShJLcpLzFFi42Kxs+FI1D3sFJl
  k8OQUo8Xrw58YLT7cnMRkseXYPUaLy0/4LH4uW8VusWfvSRaLCwdOs1rs+rOD3eL83+OsDpwe
  pxZJeGxa1cnm8XmTnMemJ2+ZAliiWDPzkvIrElgzJratZS/4y1Wx+mp4A+NCzi5GTg4hgS2ME
  t92eUHYC5gkuv/bdjFyAdl7GCX+bTrBApJgE9CUeNa5gBnEFhFwkVg4YT0jSBGzwBVGievtc8
  ASwgKJEhc3LwRrYBFQlWh7+IsVxOYV8JRoa1jMBGJLCChITHn4Hqieg4NTwEvi/9laiMWeElM
  nXWaDKBeUODnzCdgYZgEJiYMvXjBDtCpKXOr4xghhV0jMmtUGNVJN4uq5TcwTGAVnIWmfhaR9
  ASPTKkarpKLM9IyS3MTMHF1DAwNdQ0NTXWNLXVMjvcQq3US91FLd8tTiEl0gt7xYL7W4WK+4M
  jc5J0UvL7VkEyMwUlKK1U12MHav/Kl3iFGSg0lJlPetaGSSEF9SfkplRmJxRnxRaU5q8SFGGQ
  4OJQnev/ZAOcGi1PTUirTMHGDUwqQlOHiURHhDrYHSvMUFibnFmekQqVOMuhxrGw7sZRZiycv
  PS5US5xUGpgAhAZCijNI8uBGwBHKJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjCvMcgUnsy8
  ErhNr4COYAI64tuqUJAjShIRUlINTFmfN1ys2lKjp1iRLRh9J2C9Uiez6KfZR3/uvf5ty9GLH
  IJ5RzM+l4bOzDn3xD5bZPnerrci8iUxjsGLmMv0F/xYJvSx435F7quzc1zdHDjPzW0KkZY89r
  hkdYjJzYeJB55Iyy3e57nLeJaJTPKNyH/ZpxWjO2Wrs6vaJX8r/503Zb++DH/L4YU6O1ccXXH
  7ztZDVv/kthx87fs4m/Hb5Sldz3X+iX4x90hl677C+nLeyhWht9Um/51wsXnGBN+U6cYckwPF
  9/zzvxe7Z6e3zROJKo/cLO/bzDqPG7vvxWz7PjGydV6XtIzF8ql/lC61NEZbh3SaGK56fq/bt
  q01VkA6Me+p0DR7+1y2T1fzE5VYijMSDbWYi4oTAcw7kSmbAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-548.messagelabs.com!1650016962!59551!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31119 invoked from network); 15 Apr 2022 10:02:43 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-10.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:02:43 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 94DA21001A2;
        Fri, 15 Apr 2022 11:02:42 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 86E7310004E;
        Fri, 15 Apr 2022 11:02:42 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:02:17 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 3/7] xfs: Only do posix acl setup/release operation under CONFIG_XFS_POSIX_ACL
Date:   Fri, 15 Apr 2022 19:02:19 +0800
Message-ID: <1650020543-24908-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Usually, filesystem will use a function named as fs_init_acl function that belong
to acl.c and this function is externed in acl.h by using CONFIG_FS_POSIX_ACL.

If filesystem disable this switch, we should not call xfs_set_acl also not call
posix_acl_create/posix_acl_release because it is useless(We have do umask
strip in vfs).

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/xfs/xfs_iops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index b34e8e4344a8..9487e68bdd3d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -146,10 +146,12 @@ xfs_create_need_xattr(
 	struct posix_acl *default_acl,
 	struct posix_acl *acl)
 {
+#ifdef CONFIG_XFS_POSIX_ACL
 	if (acl)
 		return true;
 	if (default_acl)
 		return true;
+#endif
 #if IS_ENABLED(CONFIG_SECURITY)
 	if (dir->i_sb->s_security)
 		return true;
@@ -184,9 +186,11 @@ xfs_generic_create(
 		rdev = 0;
 	}
 
+#ifdef CONFIG_XFS_POSIX_ACL
 	error = posix_acl_create(dir, &mode, &default_acl, &acl);
 	if (error)
 		return error;
+#endif
 
 	/* Verify mode is valid also for tmpfile case */
 	error = xfs_dentry_mode_to_name(&name, dentry, mode);
@@ -241,8 +245,10 @@ xfs_generic_create(
 	xfs_finish_inode_setup(ip);
 
  out_free_acl:
+#ifdef CONFIG_XFS_POSIX_ACL
 	posix_acl_release(default_acl);
 	posix_acl_release(acl);
+#endif
 	return error;
 
  out_cleanup_inode:
-- 
2.27.0

