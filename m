Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607B664144
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbjAJNI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjAJNIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA461473
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356121; x=1704892121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RAQ42OBblACZiv/cY+vF9lWhCTyk4ijreuppslEUvCw=;
  b=VtQFjzBMDb5LinFQ1gyRobntBtjDOjMwYGwCPoxSnspF+eAP+F9T9byF
   QQgL5xdicObIAYZm8yg9thpaPA8cfsRfWfUWlNMu1dJxhxxGHLYdj51Iq
   WwMOTebPz0Ne2jL4QTkjOSdswXZSAHdzYjXzqtCQo8WbsGz6E3ZiH209n
   ngDmXhFoRmHG/srogE4cA7wlMHHfAYiI8izPYn5N9iFl5rYdbcdEW36hp
   LYvJUfm9wp53XEWIpE8Ewjrb3JUdjUIbo4ZH9dLc3pMo9d3rK6rbutYiW
   52mwDtgOF7az9PjyaBW+J7h0s9aWhE+/Z1EyocNWQ0EIW54al6HGE6VDr
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740567"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:41 +0800
IronPort-SDR: ZkY3d8qTGbq0SQyKXFpZB3tP9CKCzClag/70M+FFL/oPy4O4ZbwMaHeOreCum4pemoyIoxhDpv
 EXUtx0JkvjIspRef1KX5OK4li1Y7R1KM7ly/wjBI4Ye6iqRbhsCEzWOnDcawZawCvHLNgqCh6r
 KnncgRcrgav0FNZKHG2tz6siy/ZnUrK6SjZBEQ2OQY0OfWqyPJjToeLaveY1jYSyLhgKvAgwRp
 puztF6L1l/CqTX01luW3RB5xLcBHcu+mH9IZ/J0EinRZEJURqOA+jVD1t+qZwIc5xlJ7fESHy/
 XDk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:47 -0800
IronPort-SDR: zaKBsasgmpDRHjZ28AZDOUetw561F921IU3/Cf0mljvKC0n30ItbjHVXO2Z/FZf7T8iownGhKL
 WK+vLOudyPnCTtpI/JRjnuP+opRSJlT3PmYKcB7/AC6zEEAVlhOQGaPvde/kzO/Efi4iXp6Z93
 0y+ltS+jl9ouaIW4sBZBEvd2qQDaQ1gwzJMEXrQsDZ7EMK9uwhcpm3TE8T972nM8scRz0ULGTN
 Dd0BdjpVC0eVrm6LoZ+3L3veyYCubj/PwuALMLXaO1W00nbga7q/TkI0mfRgstjgdAHYIjhBNs
 Syw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjP3dDRz1RvLy
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356119; x=1675948120; bh=RAQ42OBblACZiv/cY+
        vF9lWhCTyk4ijreuppslEUvCw=; b=X2Q4g0ptHOS/cfH3JK7j/2EeSQP+S8SQKR
        cL1dFJwteBaChW1dDCbBrHGWbmVy0YVJIIuZTjKPgWelzZJCP2YRF39/3W853PyP
        X8mIwdJWKTjF9NAmPXQ8kO1fyOEHS1aibjPqeXJus+w6XSyGZq9CRdagZkJ0Im3V
        hz/X015ch9jBD7QW83ARWsorIThJbbsxUgS96YCAumTAnFpdecBkb8T99ly5LvG4
        1scTnUvPNw539lzyxMDPoM+PD/YAH6LFA3aX22H8dUmGzCVm19rp7jgRnS9lpogL
        Z0ES91Kx3TlkmxFIeMwFhEzPGSrgGdaLH+oFzxo0CGy0Gnfj0gUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dYobVLCpSVOj for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:39 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjL5kY4z1RvTr;
        Tue, 10 Jan 2023 05:08:38 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 6/7] zonefs: Dynamically create file inodes when needed
Date:   Tue, 10 Jan 2023 22:08:29 +0900
Message-Id: <20230110130830.246019-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allocating and initializing all inodes and dentries for all files
results in a very large memory usage with high capacity zoned block
devices. For instance, with a 26 TB SMR HDD with over 96000 zones,
mounting the disk with zonefs results in about 130 MB of memory used,
the vast majority of this space being used for vfs inodes and dentries.

However, since a user will rarely access all zones at the same time,
dynamically creating file inodes and dentries on demand, similarly to
regular file systems, can significantly reduce memory usage.

This patch modifies mount processing to not create the inodes and
dentries for zone files. Instead, the directory inode operation
zonefs_lookup() and directory file operation zonefs_readdir() are
introduced to allocate and initialize inodes on-demand using the helper
functions zonefs_get_dir_inode() and zonefs_get_zgroup_inode().

Implementation of these functions is simple, relying on the static
nature of zonefs directories and files. Directoy inodes are linked to
the volume zone groups (struct zonefs_zone_group) they represent by
using the directory inode i_private field. This simplifies the
implementation of the lookup and readdir operations.

Unreferenced zone file inodes can be evicted from the inode cache at any
time. In such case, the only inode information that cannot be recreated
from the zone information that is saved in the zone group data
structures attached to the volume super block is the inode uid, gid and
access rights. These values may have been changed by the user. To keep
these attributes for the life time of the mount, as before, the inode
mode, uid and gid are saved in the inode zone information and the saved
values are used to initialize regular file inodes when an inode lookup
happens. The zone information mode, uid and gid are initialized in
zonefs_init_zgroup() using the default values.

With these changes, the static minimal memory usage of a zonefs volume
is mostly reduced to the array of zone information for each zone group.
For the 26 TB SMR hard-disk mentioned above, the memory usage after
mount becomes about 5.4 MB, a reduction by a factor of 24 from the
initial 130 MB memory use.

Co-developed-by: Jorgen Hansen <Jorgen.Hansen@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c  | 347 ++++++++++++++++++++++++++++++++-------------
 fs/zonefs/zonefs.h |   9 ++
 2 files changed, 257 insertions(+), 99 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 270ded209dde..7d70c327883e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -243,6 +243,7 @@ static void zonefs_inode_update_mode(struct inode *in=
ode)
 	}
=20
 	z->z_flags &=3D ~ZONEFS_ZONE_INIT_MODE;
+	z->z_mode =3D inode->i_mode;
 }
=20
 struct zonefs_ioerr_data {
@@ -578,144 +579,283 @@ static int zonefs_inode_setattr(struct user_names=
pace *mnt_userns,
=20
 	setattr_copy(&init_user_ns, inode, iattr);
=20
+	if (S_ISREG(inode->i_mode)) {
+		struct zonefs_zone *z =3D zonefs_inode_zone(inode);
+
+		z->z_mode =3D inode->i_mode;
+		z->z_uid =3D inode->i_uid;
+		z->z_gid =3D inode->i_gid;
+	}
+
 	return 0;
 }
=20
-static const struct inode_operations zonefs_dir_inode_operations =3D {
-	.lookup		=3D simple_lookup,
+static const struct inode_operations zonefs_file_inode_operations =3D {
 	.setattr	=3D zonefs_inode_setattr,
 };
=20
-static void zonefs_init_dir_inode(struct inode *parent, struct inode *in=
ode,
-				  enum zonefs_ztype ztype)
+static long zonefs_fname_to_fno(const struct qstr *fname)
 {
-	struct super_block *sb =3D parent->i_sb;
+	const char *name =3D fname->name;
+	unsigned int len =3D fname->len;
+	long fno =3D 0, shift =3D 1;
+	const char *rname;
+	char c =3D *name;
+	unsigned int i;
=20
-	inode->i_ino =3D bdev_nr_zones(sb->s_bdev) + ztype + 1;
-	inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
-	inode->i_op =3D &zonefs_dir_inode_operations;
-	inode->i_fop =3D &simple_dir_operations;
-	set_nlink(inode, 2);
-	inc_nlink(parent);
-}
+	/*
+	 * File names are always a base-10 number string without any
+	 * leading 0s.
+	 */
+	if (!isdigit(c))
+		return -ENOENT;
=20
-static const struct inode_operations zonefs_file_inode_operations =3D {
-	.setattr	=3D zonefs_inode_setattr,
-};
+	if (len > 1 && c =3D=3D '0')
+		return -ENOENT;
=20
-static void zonefs_init_file_inode(struct inode *inode,
-				   struct zonefs_zone *z)
+	if (len =3D=3D 1)
+		return c - '0';
+
+	for (i =3D 0, rname =3D name + len - 1; i < len; i++, rname--) {
+		c =3D *rname;
+		if (!isdigit(c))
+			return -ENOENT;
+		fno +=3D (c - '0') * shift;
+		shift *=3D 10;
+	}
+
+	return fno;
+}
+
+static struct inode *zonefs_get_file_inode(struct inode *dir,
+					   struct dentry *dentry)
 {
-	struct super_block *sb =3D inode->i_sb;
+	struct zonefs_zone_group *zgroup =3D dir->i_private;
+	struct super_block *sb =3D dir->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	struct zonefs_zone *z;
+	struct inode *inode;
+	ino_t ino;
+	long fno;
=20
-	inode->i_private =3D z;
+	/* Get the file number from the file name */
+	fno =3D zonefs_fname_to_fno(&dentry->d_name);
+	if (fno < 0)
+		return ERR_PTR(fno);
+
+	if (!zgroup->g_nr_zones || fno >=3D zgroup->g_nr_zones)
+		return ERR_PTR(-ENOENT);
=20
-	inode->i_ino =3D z->z_sector >> sbi->s_zone_sectors_shift;
-	inode->i_mode =3D S_IFREG | sbi->s_perm;
-	inode->i_uid =3D sbi->s_uid;
-	inode->i_gid =3D sbi->s_gid;
+	z =3D &zgroup->g_zones[fno];
+	ino =3D z->z_sector >> sbi->s_zone_sectors_shift;
+	inode =3D iget_locked(sb, ino);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	if (!(inode->i_state & I_NEW)) {
+		WARN_ON_ONCE(inode->i_private !=3D z);
+		return inode;
+	}
+
+	inode->i_ino =3D ino;
+	inode->i_mode =3D z->z_mode;
+	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime;
+	inode->i_uid =3D z->z_uid;
+	inode->i_gid =3D z->z_gid;
 	inode->i_size =3D z->z_wpoffset;
 	inode->i_blocks =3D z->z_capacity >> SECTOR_SHIFT;
+	inode->i_private =3D z;
=20
 	inode->i_op =3D &zonefs_file_inode_operations;
 	inode->i_fop =3D &zonefs_file_operations;
 	inode->i_mapping->a_ops =3D &zonefs_file_aops;
=20
 	/* Update the inode access rights depending on the zone condition */
-	z->z_flags |=3D ZONEFS_ZONE_INIT_MODE;
 	zonefs_inode_update_mode(inode);
+
+	unlock_new_inode(inode);
+
+	return inode;
 }
=20
-static struct dentry *zonefs_create_inode(struct dentry *parent,
-					  const char *name,
-					  struct zonefs_zone *z,
-					  enum zonefs_ztype ztype)
+static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
+					     enum zonefs_ztype ztype)
 {
-	struct inode *dir =3D d_inode(parent);
-	struct dentry *dentry;
+	struct inode *root =3D d_inode(sb->s_root);
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	struct inode *inode;
-	int ret =3D -ENOMEM;
+	ino_t ino =3D bdev_nr_zones(sb->s_bdev) + ztype + 1;
=20
-	dentry =3D d_alloc_name(parent, name);
-	if (!dentry)
-		return ERR_PTR(ret);
-
-	inode =3D new_inode(parent->d_sb);
+	inode =3D iget_locked(sb, ino);
 	if (!inode)
-		goto dput;
+		return ERR_PTR(-ENOMEM);
+	if (!(inode->i_state & I_NEW))
+		return inode;
+
+	inode->i_ino =3D ino;
+	inode_init_owner(&init_user_ns, inode, root, S_IFDIR | 0555);
+	inode->i_size =3D sbi->s_zgroup[ztype].g_nr_zones;
+	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D root->i_ctime;
+	inode->i_private =3D &sbi->s_zgroup[ztype];
+	set_nlink(inode, 2);
=20
-	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime;
-	if (z)
-		zonefs_init_file_inode(inode, z);
-	else
-		zonefs_init_dir_inode(dir, inode, ztype);
+	inode->i_op =3D &zonefs_dir_inode_operations;
+	inode->i_fop =3D &zonefs_dir_operations;
+
+	unlock_new_inode(inode);
=20
-	d_add(dentry, inode);
-	dir->i_size++;
+	return inode;
+}
=20
-	return dentry;
=20
-dput:
-	dput(dentry);
+static struct inode *zonefs_get_dir_inode(struct inode *dir,
+					  struct dentry *dentry)
+{
+	struct super_block *sb =3D dir->i_sb;
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	const char *name =3D dentry->d_name.name;
+	enum zonefs_ztype ztype;
+
+	/*
+	 * We only need to check for the "seq" directory and
+	 * the "cnv" directory if we have conventional zones.
+	 */
+	if (dentry->d_name.len !=3D 3)
+		return ERR_PTR(-ENOENT);
+
+	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+		if (sbi->s_zgroup[ztype].g_nr_zones &&
+		    memcmp(name, zonefs_zgroup_name(ztype), 3) =3D=3D 0)
+			break;
+	}
+	if (ztype =3D=3D ZONEFS_ZTYPE_MAX)
+		return ERR_PTR(-ENOENT);
=20
-	return ERR_PTR(ret);
+	return zonefs_get_zgroup_inode(sb, ztype);
 }
=20
-struct zonefs_zone_data {
-	struct super_block	*sb;
-	unsigned int		nr_zones[ZONEFS_ZTYPE_MAX];
-	sector_t		cnv_zone_start;
-	struct blk_zone		*zones;
-};
+static struct dentry *zonefs_lookup(struct inode *dir, struct dentry *de=
ntry,
+				    unsigned int flags)
+{
+	struct inode *inode;
=20
-/*
- * Create the inodes for a zone group.
- */
-static int zonefs_create_zgroup_inodes(struct super_block *sb,
-				       enum zonefs_ztype ztype)
+	if (dentry->d_name.len > ZONEFS_NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	if (dir =3D=3D d_inode(dir->i_sb->s_root))
+		inode =3D zonefs_get_dir_inode(dir, dentry);
+	else
+		inode =3D zonefs_get_file_inode(dir, dentry);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	return d_splice_alias(inode, dentry);
+}
+
+static int zonefs_readdir_root(struct file *file, struct dir_context *ct=
x)
 {
+	struct inode *inode =3D file_inode(file);
+	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
-	struct zonefs_zone_group *zgroup =3D &sbi->s_zgroup[ztype];
-	struct dentry *dir, *dent;
-	char *file_name;
-	int i, ret =3D 0;
+	enum zonefs_ztype ztype =3D ZONEFS_ZTYPE_CNV;
+	ino_t base_ino =3D bdev_nr_zones(sb->s_bdev) + 1;
=20
-	if (!zgroup)
-		return -ENOMEM;
+	if (ctx->pos >=3D inode->i_size)
+		return 0;
=20
-	/* If the group is empty, there is nothing to do */
-	if (!zgroup->g_nr_zones)
+	if (!dir_emit_dots(file, ctx))
 		return 0;
=20
-	file_name =3D kmalloc(ZONEFS_NAME_MAX, GFP_KERNEL);
-	if (!file_name)
-		return -ENOMEM;
+	if (ctx->pos =3D=3D 2) {
+		if (!sbi->s_zgroup[ZONEFS_ZTYPE_CNV].g_nr_zones)
+			ztype =3D ZONEFS_ZTYPE_SEQ;
=20
-	dir =3D zonefs_create_inode(sb->s_root, zonefs_zgroup_name(ztype),
-				  NULL, ztype);
-	if (IS_ERR(dir)) {
-		ret =3D PTR_ERR(dir);
-		goto free;
+		if (!dir_emit(ctx, zonefs_zgroup_name(ztype), 3,
+			      base_ino + ztype, DT_DIR))
+			return 0;
+		ctx->pos++;
 	}
=20
-	for (i =3D 0; i < zgroup->g_nr_zones; i++) {
-		/* Use the zone number within its group as the file name */
-		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", i);
-		dent =3D zonefs_create_inode(dir, file_name,
-					   &zgroup->g_zones[i], ztype);
-		if (IS_ERR(dent)) {
-			ret =3D PTR_ERR(dent);
+	if (ctx->pos =3D=3D 3 && ztype !=3D ZONEFS_ZTYPE_SEQ) {
+		ztype =3D ZONEFS_ZTYPE_SEQ;
+		if (!dir_emit(ctx, zonefs_zgroup_name(ztype), 3,
+			      base_ino + ztype, DT_DIR))
+			return 0;
+		ctx->pos++;
+	}
+
+	return 0;
+}
+
+static int zonefs_readdir_zgroup(struct file *file,
+				 struct dir_context *ctx)
+{
+	struct inode *inode =3D file_inode(file);
+	struct zonefs_zone_group *zgroup =3D inode->i_private;
+	struct super_block *sb =3D inode->i_sb;
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	struct zonefs_zone *z;
+	int fname_len;
+	char *fname;
+	ino_t ino;
+	int f;
+
+	/*
+	 * The size of zone group directories is equal to the number
+	 * of zone files in the group and does note include the "." and
+	 * ".." entries. Hence the "+ 2" here.
+	 */
+	if (ctx->pos >=3D inode->i_size + 2)
+		return 0;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	fname =3D kmalloc(ZONEFS_NAME_MAX, GFP_KERNEL);
+	if (!fname)
+		return -ENOMEM;
+
+	for (f =3D ctx->pos - 2; f < zgroup->g_nr_zones; f++) {
+		z =3D &zgroup->g_zones[f];
+		ino =3D z->z_sector >> sbi->s_zone_sectors_shift;
+		fname_len =3D snprintf(fname, ZONEFS_NAME_MAX - 1, "%u", f);
+		if (!dir_emit(ctx, fname, fname_len, ino, DT_REG))
 			break;
-		}
+		ctx->pos++;
 	}
=20
-free:
-	kfree(file_name);
+	kfree(fname);
=20
-	return ret;
+	return 0;
 }
=20
+static int zonefs_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct inode *inode =3D file_inode(file);
+
+	if (inode =3D=3D d_inode(inode->i_sb->s_root))
+		return zonefs_readdir_root(file, ctx);
+
+	return zonefs_readdir_zgroup(file, ctx);
+}
+
+const struct inode_operations zonefs_dir_inode_operations =3D {
+	.lookup		=3D zonefs_lookup,
+	.setattr	=3D zonefs_inode_setattr,
+};
+
+const struct file_operations zonefs_dir_operations =3D {
+	.llseek		=3D generic_file_llseek,
+	.read		=3D generic_read_dir,
+	.iterate_shared	=3D zonefs_readdir,
+};
+
+struct zonefs_zone_data {
+	struct super_block	*sb;
+	unsigned int		nr_zones[ZONEFS_ZTYPE_MAX];
+	sector_t		cnv_zone_start;
+	struct blk_zone		*zones;
+};
+
 static int zonefs_get_zone_info_cb(struct blk_zone *zone, unsigned int i=
dx,
 				   void *data)
 {
@@ -875,6 +1015,17 @@ static int zonefs_init_zgroup(struct super_block *s=
b,
 				      zone->capacity << SECTOR_SHIFT);
 		z->z_wpoffset =3D zonefs_check_zone_condition(sb, z, zone);
=20
+		z->z_mode =3D S_IFREG | sbi->s_perm;
+		z->z_uid =3D sbi->s_uid;
+		z->z_gid =3D sbi->s_gid;
+
+		/*
+		 * Let zonefs_inode_update_mode() know that we will need
+		 * special initialization of the inode mode the first time
+		 * it is accessed.
+		 */
+		z->z_flags |=3D ZONEFS_ZONE_INIT_MODE;
+
 		sb->s_maxbytes =3D max(z->z_capacity, sb->s_maxbytes);
 		sbi->s_blocks +=3D z->z_capacity >> sb->s_blocksize_bits;
 		sbi->s_used_blocks +=3D z->z_wpoffset >> sb->s_blocksize_bits;
@@ -1057,7 +1208,7 @@ static int zonefs_fill_super(struct super_block *sb=
, void *data, int silent)
 {
 	struct zonefs_sb_info *sbi;
 	struct inode *inode;
-	enum zonefs_ztype t;
+	enum zonefs_ztype ztype;
 	int ret;
=20
 	if (!bdev_is_zoned(sb->s_bdev)) {
@@ -1122,7 +1273,7 @@ static int zonefs_fill_super(struct super_block *sb=
, void *data, int silent)
 	if (ret)
 		goto cleanup;
=20
-	/* Create root directory inode */
+	/* Create the root directory inode */
 	ret =3D -ENOMEM;
 	inode =3D new_inode(sb);
 	if (!inode)
@@ -1132,20 +1283,20 @@ static int zonefs_fill_super(struct super_block *=
sb, void *data, int silent)
 	inode->i_mode =3D S_IFDIR | 0555;
 	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D current_time(i=
node);
 	inode->i_op =3D &zonefs_dir_inode_operations;
-	inode->i_fop =3D &simple_dir_operations;
+	inode->i_fop =3D &zonefs_dir_operations;
+	inode->i_size =3D 2;
 	set_nlink(inode, 2);
+	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+		if (sbi->s_zgroup[ztype].g_nr_zones) {
+			inc_nlink(inode);
+			inode->i_size++;
+		}
+	}
=20
 	sb->s_root =3D d_make_root(inode);
 	if (!sb->s_root)
 		goto cleanup;
=20
-	/* Create and populate files in zone groups directories */
-	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {
-		ret =3D zonefs_create_zgroup_inodes(sb, t);
-		if (ret)
-			goto cleanup;
-	}
-
 	ret =3D zonefs_sysfs_register(sb);
 	if (ret)
 		goto cleanup;
@@ -1168,12 +1319,10 @@ static void zonefs_kill_super(struct super_block =
*sb)
 {
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
=20
-	if (sb->s_root)
-		d_genocide(sb->s_root);
+	kill_block_super(sb);
=20
 	zonefs_sysfs_unregister(sb);
 	zonefs_free_zgroups(sb);
-	kill_block_super(sb);
 	kfree(sbi);
 }
=20
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 2d626e18b141..f88466a4158b 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -64,6 +64,11 @@ struct zonefs_zone {
=20
 	/* Write pointer offset in the zone (sequential zones only, bytes) */
 	loff_t			z_wpoffset;
+
+	/* Saved inode uid, gid and access rights */
+	umode_t			z_mode;
+	kuid_t			z_uid;
+	kgid_t			z_gid;
 };
=20
 /*
@@ -265,6 +270,10 @@ static inline void zonefs_io_error(struct inode *ino=
de, bool write)
 	mutex_unlock(&zi->i_truncate_mutex);
 }
=20
+/* In super.c */
+extern const struct inode_operations zonefs_dir_inode_operations;
+extern const struct file_operations zonefs_dir_operations;
+
 /* In file.c */
 extern const struct address_space_operations zonefs_file_aops;
 extern const struct file_operations zonefs_file_operations;
--=20
2.39.0

