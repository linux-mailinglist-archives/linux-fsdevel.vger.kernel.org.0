Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA6504A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiDRBO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiDRBOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3A12AE1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244334; x=1681780334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwHoord5lhk4MsFJLwnYoyFeLZXN5oFbLCkvfS1Zqko=;
  b=VPt2upMRvOSTTjSz6kiEmuDEWlvYkxiR3k40BnZr9Uq24TF6XcdTvxI3
   hGOLvj2/nMtQ3BZKTr7WNpUH2EvNoKyGPWkafttf73VJQPZTeXn/lKKaD
   EkUdc5oZStXiXMLsrxWEsMfXT6JZJG7XZAzGqaRmKl+olqWs+nEvP+zfo
   TGtWobL9bsd0Aak1zfZ7B/cGOQalk/hJRM86Zv4lTVYC0B56xNZIb0mQA
   3VvWpnQUXqIK6b3/nFkj3w7P/vEakpz8BfhwrVl7hCkd3xf9Oge7jlcU/
   v1F6VkyEAfC6sn/K/6zrb4OD2AbrLSS9ifZYeneQzLAM4iH56OfBWwYu4
   g==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313769"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:13 +0800
IronPort-SDR: QmjLZyJSWv2eLx+d4cIhs7NYgrGSyXZmWF0P/mAg/SgucKHm8lD3HkBWKG2ASHq6idQbBxd1TS
 2VLTyenX1sVpmftB8Ctd2XWOQRRuO+hDybfTJV7HYtBXoeuO8tFgNdp0E4ECvo8HA3W5V8EVQ7
 PyLZ6rNWzmR6tT0xV6Erk/+XFRI/kHVVC/dxwO/itrweJnNjPa0tqxv+A7RqVQPx+Subbf3gKl
 o7LTCKVicmH32FSwJDmg6ytHL7Bhzp5eD+MmMmKMIvWyVpLZ2JX8HtesyVtuETRN30BYD+yLTd
 DPC2ZVbMN2ocscYev212G8Xc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:34 -0700
IronPort-SDR: Oq+/ftqg1I905qXMu1luopHvhGDDvrT0xuATB0ELoGl/bh6CijSe56HnqfZWAVl63yVFrLIQ3d
 IioJF+4bpnNWc0QVV94nQuKBxYUdvjAVmtyxLpd1WbO9zTNh0jbcmpCtVclbbqt5HIH4trsnNI
 OHR4nNib4JhrCpNIQIcWS5UOZq6o46pLPQjrkx2e25IxtfsqOAex2TwS4rgzm/XWmQAJ90MRHz
 z5/qVqxX6CofcXw8TN1bovysx/s5iUGnDZSpbBxFPwOwltccBzGw2cstN8uFVIZymRfmae9Q6e
 WPg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTRx2ZSBz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650244332; x=1652836333; bh=wwHoord5lhk4MsFJLw
        nYoyFeLZXN5oFbLCkvfS1Zqko=; b=sQkQkd3TohuUmvltEyMDlk0kaUVn/mrt2e
        MOeEHl2uFdLVaKCvpDOMcVZ27ZTIcIL08UgbBhulIBpwnKMhZDX2LQIn2gpaW6k5
        zGFOS4AOQtpqLIAiWKrnt3NUOQp5zCmJ6TsabYD1w92aUBQJb1o0RBrtYFEDn4w8
        dbbXWdrJZVt4oBaOw4qn2f9BhiakRfHEjFlexwbOtXhT4QbYnyua/hNNydY3kV5Q
        wx6vOq+F6lwedDDKAzrpicp3kOYNfOzxAcsYeBtxTW3V+77mSdv/K75LxEgB+3gV
        EJquZfnkOUFQ5TOrMCb0HkNxH5aThvcYGJI45kvPMb9fwc+AJPEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uRoV5NDwou9I for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:12 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRw3Pymz1Rvlx;
        Sun, 17 Apr 2022 18:12:12 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/8] zonefs: Always do seq file write open accounting
Date:   Mon, 18 Apr 2022 10:12:03 +0900
Message-Id: <20220418011207.2385416-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The explicit_open mount option forces an explicitly open of the zone of
sequential files that are open for writing to ensure that the open file
can be written without the device failing write operations due to open
zone resources limit being exceeded. To implement this, zonefs accounts
all write open seq file when this mount option is used.

This accounting however can be easily performed even when the
explicit_open mount option is not used, thus allowing applications to
control zone resources on their own, without relying on open() system
call failures from zonefs.

To implement this, the helper zonefs_file_use_exp_open() is removed and
replaced with the helper zonefs_seq_file_need_wro() which test if a file
is a sequential file being open with write access. zonefs_open_zone()
and zonefs_close_zone() are renamed respectively to
zonefs_seq_file_write_open() and zonefs_seq_file_write_close() and
modified to update the s_wro_seq_files counter regardless of the
explicit_open mount option use.

If the explicit_open mount option is used, zonefs_seq_file_write_open()
execute an explicit zone open operation for a sequential file open for
writing for the first time, as before.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 80 +++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index dafacde65659..02dbdec32b2f 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1009,13 +1009,13 @@ static ssize_t zonefs_file_read_iter(struct kiocb=
 *iocb, struct iov_iter *to)
 	return ret;
 }
=20
-static inline bool zonefs_file_use_exp_open(struct inode *inode, struct =
file *file)
+/*
+ * Write open accounting is done only for sequential files.
+ */
+static inline bool zonefs_seq_file_need_wro(struct inode *inode,
+					    struct file *file)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
-
-	if (!(sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN))
-		return false;
=20
 	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
 		return false;
@@ -1026,30 +1026,33 @@ static inline bool zonefs_file_use_exp_open(struc=
t inode *inode, struct file *fi
 	return true;
 }
=20
-static int zonefs_open_zone(struct inode *inode)
+static int zonefs_seq_file_write_open(struct inode *inode)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
 	int ret =3D 0;
=20
 	mutex_lock(&zi->i_truncate_mutex);
=20
 	if (!zi->i_wr_refcnt) {
+		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
 		unsigned int wro =3D atomic_inc_return(&sbi->s_wro_seq_files);
=20
-		if (wro > sbi->s_max_wro_seq_files) {
-			atomic_dec(&sbi->s_wro_seq_files);
-			ret =3D -EBUSY;
-			goto unlock;
-		}
+		if (sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
=20
-		if (i_size_read(inode) < zi->i_max_size) {
-			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
-			if (ret) {
+			if (wro > sbi->s_max_wro_seq_files) {
 				atomic_dec(&sbi->s_wro_seq_files);
+				ret =3D -EBUSY;
 				goto unlock;
 			}
-			zi->i_flags |=3D ZONEFS_ZONE_OPEN;
+
+			if (i_size_read(inode) < zi->i_max_size) {
+				ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+				if (ret) {
+					atomic_dec(&sbi->s_wro_seq_files);
+					goto unlock;
+				}
+				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
+			}
 		}
 	}
=20
@@ -1069,30 +1072,31 @@ static int zonefs_file_open(struct inode *inode, =
struct file *file)
 	if (ret)
 		return ret;
=20
-	if (zonefs_file_use_exp_open(inode, file))
-		return zonefs_open_zone(inode);
+	if (zonefs_seq_file_need_wro(inode, file))
+		return zonefs_seq_file_write_open(inode);
=20
 	return 0;
 }
=20
-static void zonefs_close_zone(struct inode *inode)
+static void zonefs_seq_file_write_close(struct inode *inode)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	int ret =3D 0;
=20
 	mutex_lock(&zi->i_truncate_mutex);
-	zi->i_wr_refcnt--;
-	if (!zi->i_wr_refcnt) {
-		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
-		struct super_block *sb =3D inode->i_sb;
=20
-		/*
-		 * If the file zone is full, it is not open anymore and we only
-		 * need to decrement the open count.
-		 */
-		if (!(zi->i_flags & ZONEFS_ZONE_OPEN))
-			goto dec;
+	zi->i_wr_refcnt--;
+	if (zi->i_wr_refcnt)
+		goto unlock;
=20
+	/*
+	 * The file zone may not be open anymore (e.g. the file was truncated t=
o
+	 * its maximum size or it was fully written). For this case, we only
+	 * need to decrement the write open count.
+	 */
+	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
 		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
 		if (ret) {
 			__zonefs_io_error(inode, false);
@@ -1104,14 +1108,22 @@ static void zonefs_close_zone(struct inode *inode=
)
 			 */
 			if (zi->i_flags & ZONEFS_ZONE_OPEN &&
 			    !(sb->s_flags & SB_RDONLY)) {
-				zonefs_warn(sb, "closing zone failed, remounting filesystem read-onl=
y\n");
+				zonefs_warn(sb,
+					"closing zone at %llu failed %d\n",
+					zi->i_zsector, ret);
+				zonefs_warn(sb,
+					"remounting filesystem read-only\n");
 				sb->s_flags |=3D SB_RDONLY;
 			}
+			goto unlock;
 		}
+
 		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
-dec:
-		atomic_dec(&sbi->s_wro_seq_files);
 	}
+
+	atomic_dec(&sbi->s_wro_seq_files);
+
+unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
 }
=20
@@ -1123,8 +1135,8 @@ static int zonefs_file_release(struct inode *inode,=
 struct file *file)
 	 * the zone has gone offline or read-only). Make sure we don't fail the
 	 * close(2) for user-space.
 	 */
-	if (zonefs_file_use_exp_open(inode, file))
-		zonefs_close_zone(inode);
+	if (zonefs_seq_file_need_wro(inode, file))
+		zonefs_seq_file_write_close(inode);
=20
 	return 0;
 }
--=20
2.35.1

