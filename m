Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C814B507EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358979AbiDTCiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358975AbiDTCir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13637A20
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422160; x=1681958160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MoW4keeTJoG5XMrbAbZKZtFk4s/YH4Llwemr0DH8+xQ=;
  b=RfbvC1rkvZRI2s3IP5FV/ygkAKdp2/nKlQmn04DBjGvZeBMFC84pPkiQ
   hzwibp1m/S8+a3fmDKnpwK/ukrmvo8C3fWweYjmlICsi6fScz9rp9kA/F
   1kEi81GgGc7JYr98T73IkEIqu3mrWJCJqpN5BbvSriTfEBOeCp1OICy+l
   9VAdRCBGBT3vfUdbn8algCrdzsYzJGilkJfJR5K0tFAU/ATfaCf5KTDXT
   HyHtHHdEC7xHqiJEFYgIdMDfT1TpXrdzYrb6nbEjRy7BxXgW48uQGd+Z+
   XgSavhC8m5ZFbFBWptQdxJNIt3/QVH19HpCF4YKVgJFRLEChaaXbyMr9r
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="310291663"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:51 +0800
IronPort-SDR: sCBUyTOO3Y8cAVVu+yI1JRsxGt1lk29v3/SMqQn+96X1pShK7LKy0Mwym5G9oB8zMN4tN65B8m
 6s5IoGKrYt1M0A33bRCVUkEetQ4UvS417CsFSMKw5FB/6lZn/8RGguusrmmm6NKQwfTAqgBps0
 RwJihkPHb9vAeFkJWOEbHIl+UtSIilrznOngG9D0hH5DVdo0NdaR3ausgISoq8Cw3qTxKQyIpU
 dQ9ixp2XkGiR2F9/YMtPPar6dvj+3fsVRNZDHvwf52aje1aKGvaajfn0S08ESgrt/eJchPw2Q1
 s05XUmpZMWivEhQ4Wbb7U2pn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:10 -0700
IronPort-SDR: vnOhzXtHWD3DHWHQafpMv6tkYPEIP+7SMprS2JKxLZhlOMRHJE8NdLipvqAjAj8STyzi+OF9TI
 G/dYTsimG4+InW9OD25LOfw0dAm4tLRKPtL3Y+jS2Ytvp618fGkx5+AlhwDycgvicrE8jqnf5z
 Q9QayfMb55ohbeuAwSe0pN4PQm+RW0GHmn/fNjGq8WKx0vs6+btgrI2hlAkflVNPiDJMf9v+yM
 V5/fT+3efSwZyvE7qtMYigZgJdjB0gysXjdPx01/lqtuqTBPfmQfR8e7YNtz8SN2gAEDHDr0lq
 8G4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCV3z6Zz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422150; x=1653014151; bh=MoW4keeTJoG5XMrbAb
        ZKZtFk4s/YH4Llwemr0DH8+xQ=; b=IKkcoVh0mxWhZkV8/s0Dt10ZfAKaQ7Mt+e
        y2V8YDEt2zmPCtt7MnhTlPcGhGJOA8Cw4a+FaUpMIhEAfOdV8HnJBoCYCijwwBAB
        hv2Y+8pxO5YR+PGTElqn0ev5H31BkBmQYAM69gGEUJSi390KrjPEMBnWvy4D22g+
        9SE32gTSAbWG/Tdp5dicVRjS9RPJeco/y1W1OD2Npr73YxWjwEKax8uBwRuw1vMf
        dANDjs6FHv7FMPzdWI0SyZnwyKm9BBMDn0lpO915xt8KGMMNfRi3gKFKeB3V9xlo
        UXxm3YTEl/CeHRJfjvrWxNJmkPiz2A/SDXv+B1Uc3MRXCpxq+Ldw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GZzuDKtExygt for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:50 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCT51J5z1Rwrw;
        Tue, 19 Apr 2022 19:35:49 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/8] zonefs: Always do seq file write open accounting
Date:   Wed, 20 Apr 2022 11:35:41 +0900
Message-Id: <20220420023545.3814998-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

