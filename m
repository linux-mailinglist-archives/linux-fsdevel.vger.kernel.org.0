Return-Path: <linux-fsdevel+bounces-35862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDDB9D8F41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D03B24C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7B196D9A;
	Mon, 25 Nov 2024 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fP8Jt5/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D743189F20;
	Mon, 25 Nov 2024 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578146; cv=none; b=ZVQcffh60TaS3malLc7khT2FUqenUqiRk2Qvy4J8Qvlll1AL5Ay2ThySgKxZoB4C13bbjDgYrjdNssLvore+Ur52gHmOMG3NbJDAqPiwuHlrWKEXjM1uZuTFTrapO8mtiMOykSdWZx7LLy5VpwVXDi2bHszA4eOr7tvUeXRs51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578146; c=relaxed/simple;
	bh=4AW3HXF8Zss5Wgx8tbWXkPrXII0o3lYa5kk1FEwbCSo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ReWeeYOHKPrVp7dCL1xGEtmZj6hz54sPpYn0jDvjTpDJJ9iDA6koUuAsM0mwnL8JsjXBYXUK/bEIlGRZeoyrLFJEOPukfAh4O3pS0P+RxlkEIkORlcR6zpJl3s1k+UT46M9+Tuk84q+p1Z6oOE92KngfBKPCeeD8SoNmQCQDj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fP8Jt5/E; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732578130; bh=/KxuIDjoowTbqWmLpQV6jdh8esNO7ZyBc3NaxAGU4Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fP8Jt5/Ewe0q/fhG5A2iHcp2hxYy2QbO+/XjOtRA4A/C47IpzojIudXYCzPneBz/A
	 mOTNDgEbKTFkD7suGCes77w5lr753mpBhuaSLt7M2xTkM3Xo8mQHICsYztqJqjTV/p
	 /ghfE3UiKJYRFfQGPQsyQOtDoRp6pRHNm2TeZhJo=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id A88B2EE5; Tue, 26 Nov 2024 07:42:08 +0800
X-QQ-mid: xmsmtpt1732578128tfoslh9fx
Message-ID: <tencent_4D663A3CE9374A970636084B0C75E3768D09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8kfHQIj0j0buKXojWz+l7bwFvNjd7cBCyCODjlDN/FpPnLQeo9e
	 ciFokYuteH6Kh9rR7DgaPmxfHhnrPqWfPmSXABKfEviMOBmJdqVfV+0nGnNULc5IfMyikKc1TYJW
	 4sFxcyahsDOkDyqr7YDRbB5H4lNTjrnZrxoCogKrDckASdC/wyYArITCA/Afvxw6tjjkDc/66WtW
	 eobyR/tZ+deQwKqGV/AmV29rqUECbjvRUCBMaiQgGwoOOat6D4UNwE/nV1Ws74Y83Rh01fcKx5nM
	 MH021A7TU3kfJ9xyZCZ9+Lk7wc1ongITfyDUHrmJCWYKzvfb7H7ewtOFMZbhOGFx9LKawgTnTcBw
	 7E9Fp9OAcmcTOGLvvfAvIVplPUoyzYuHq8cz3uq2Ydg5ZTFERzXGuhX32aC+mxJZtU37Vfuvy38x
	 xbM5DoYEpARE4byT6rs2Sop53UI1Sk1eQBiGx7y0Ihae6nQBBfE8Tg1SiSeXigaineRttFNUrS4h
	 gb42GBR1IeC/UHSXIw/xSpbJX5YCw5VDufizlLsy29ZpQY3WxyDJABTwVZSAPEwvrJXRibS0d8Wz
	 2EiukS8YC9MXOWp+CAZGEN0RzVSL5Oe08rwyGgyn3rWWDTAj54cXHQjut75VK9aXfMaYUxUUKiN1
	 J2mgiM0eYa7x0iipBDMWRnkWk6ShbdZo6V0VUxQry33u28gPGX0HhifD3Zl5ynf0PE89Nf9Df/Sc
	 /E3yRG8SKogTC0PXQGgwM3jXa2ZCjLp4m78hbG+1NMV5z9BnTjyaR8h5Hc0EloZVFBq3utBw4c4F
	 9cCxng2q5B6nnDL/HIi5ZzfQTVS44cHE/xsncNA5adhtIpFX8XA5ZPWPxKjVvUo2qioH6qW4Il4v
	 S1EgReIDREwiQ+jUDsId7GxRiYAZDxkw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+028180f480a74961919c@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: restore i_nlink and flags when rename_cat fails
Date: Tue, 26 Nov 2024 07:42:09 +0800
X-OQ-MSGID: <20241125234208.3901871-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674305a3.050a0220.1cc393.003b.GAE@google.com>
References: <674305a3.050a0220.1cc393.003b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the rename syscall fails, the unlink syscall triggers a warning in
drop_nlink() because the i_nlink value is 0.

When unlink succeeds but rename_cat fails in rename, the i_nlink and flags
values of the inode of the new dentry should be restored.

Reported-and-tested-by: syzbot+028180f480a74961919c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=028180f480a74961919c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/dir.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..b489d22409e7 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -534,7 +534,7 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
-	int res;
+	int res, unlinked_new = 0;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -543,8 +543,10 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 	if (d_really_is_positive(new_dentry)) {
 		if (d_is_dir(new_dentry))
 			res = hfsplus_rmdir(new_dir, new_dentry);
-		else
+		else {
 			res = hfsplus_unlink(new_dir, new_dentry);
+			unlinked_new = res == 0 && d_inode(new_dentry)->i_flags & S_DEAD;
+		}
 		if (res)
 			return res;
 	}
@@ -554,6 +556,12 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 				 new_dir, &new_dentry->d_name);
 	if (!res)
 		new_dentry->d_fsdata = old_dentry->d_fsdata;
+	else if (unlinked_new) {
+		struct inode *inode = d_inode(new_dentry);
+		set_nlink(inode, inode->i_nlink + 1);
+		inode->i_flags &= ~S_DEAD;
+	}
+
 	return res;
 }
 
-- 
2.43.0


