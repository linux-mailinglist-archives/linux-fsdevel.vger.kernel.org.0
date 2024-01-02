Return-Path: <linux-fsdevel+bounces-7088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E0821BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AFA1C21F46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCDAFBFE;
	Tue,  2 Jan 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p5Ru6ZUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227AFBF0;
	Tue,  2 Jan 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704199013; bh=KccDZNyBw07ctq/DN3VElW8F3A1ia8xExihctND/oh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p5Ru6ZUzBdYcgAA/DvsG1qV+UwFHpVhC425WNXaVRjEB7bjlSWzJuSFfOqKovE6AU
	 sxWNT+b/YY3bDE0VsX/qthI0XeFtJT6+/qevhbgXswmwchMG0b1OxKalQplqKGoXUM
	 DcQI+u/SwjokXggvgUP57hbbab6wrAt0G+62F+Nk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 93334A1C; Tue, 02 Jan 2024 20:36:51 +0800
X-QQ-mid: xmsmtpt1704199011tmjb9ifyq
Message-ID: <tencent_8C1ACE487B4E6C302EE56D8C95C0E8E2EF0A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujvVtpMWdxaTVHmbrXzaCl4eDQp1ppMvKr1B3sZmiP2rPKkpDVT2
	 Wx22gtapO0SWIPeDdMHzM/pDsl7mOzDQP48b0kIWc35lT2+9r8zpfTFP+HKYPUWHHLByu0/s4Ae0
	 x2ApYkcNEvsVXDZKfqJgLcAJayxcTN+XUyts0x5OPOhqCceFUC12mZy6McngXf/2DnTK2mJyqfHZ
	 l4H37h5XXIRzXAclsR/47rr3lL7/VuUJ6P8siruJeUdyXbUcAiNoLnHGViUaJ6/3dTelzTVjJ7hB
	 NYTEMxUu3l3pBaqkXHKRstFYz4tgRIIdBOWlePjNYSSTqHKnWlI39YU1FY1yFPopiTLtrK2vmg+t
	 vfcpNz5u0lmRkF7vfwfPjxx5+t25QGqtcgwXuPRFxLLD5xpXmyoV8zwqMhpsoeGblOFxun5x8Ce+
	 btmdSKb2dNRV9GLxSZp/csIEVUlDim/DeIg8fJeVS1CV4EVn7Us8wR/7z7Yyjry2sk2tbSOKk/d0
	 fxG9ock9UqKE62M9ivXdHKIuIecQlcLBzO4xkgn3bUHCTAsmhS0VZ40mfCFKSCw5aNQ68M6PTCWt
	 ZnRmLqFfNPSN4HHf/OF208uflBXEP6+3EYF8nGxWTfvL6OjPtcqlXPIZCtbcnMDs4JOdgrpmlXTW
	 HPvnyHjAkVnBD6G/FofN95KWRnoadgUqQxN1yU5NjG8Iy5emIANXUeUhPrM7AvvzrwDhXky7Awnk
	 DB7S8uapn1593i1VneE+x5cFU7zZa3A8nknRZ/OU02fTEoZ4gP2Fnpacypdcda/WpR0yk3YpdM6Z
	 LHR6yjY+sqSrSkJt8p7VRL7YTgbVGLJ487OwXJ6++h9QKYOBgF4ca++/iIvq7Hu7fyKgVbdFzY2n
	 0Uz9Uk3y5OkUo1Uy4d+p+9cZ6V8ZsGwSr/H/58X2mmXGGANpazBfPYieixh0XEAbrHW4iiYF/zhK
	 zH6adJif8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	willy@infradead.org
Subject: [PATCH] hfs: fix deadlock in hfs_extend_file
Date: Tue,  2 Jan 2024 20:36:51 +0800
X-OQ-MSGID: <20240102123651.1582577-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004efa57060def87be@google.com>
References: <0000000000004efa57060def87be@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syz report]
syz-executor279/5059 is trying to acquire lock:
ffff888079c100f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397

but task is already holding lock:
ffff888079c10778 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&HFS_I(tree->inode)->extents_lock);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***
[Analysis] 
 hfs_extend_file()->
   hfs_ext_read_extent()->
     __hfs_ext_cache_extent()->
       __hfs_ext_write_extent()->
         hfs_bmap_reserve()->
           hfs_extend_file()->

When an inode has both the HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW flags, it will
enter the above loop and trigger a deadlock.

[Fix]
In hfs_ext_read_extent(), check if the above two flags exist simultaneously, 
and exit the subsequent process when the conditions are met.

Reported-and-tested-by: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfs/extent.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 6d1878b99b30..1b02c7b6a10c 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -197,6 +197,10 @@ static int hfs_ext_read_extent(struct inode *inode, u16 block)
 	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
 		return 0;
 
+	if (HFS_I(inode)->flags & HFS_FLG_EXT_DIRTY && 
+	    HFS_I(inode)->flags & HFS_FLG_EXT_NEW) 
+		return -ENOENT;
+
 	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
 	if (!res) {
 		res = __hfs_ext_cache_extent(&fd, inode, block);
-- 
2.43.0


