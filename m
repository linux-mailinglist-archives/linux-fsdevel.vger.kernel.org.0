Return-Path: <linux-fsdevel+bounces-74215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA54FD38555
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CED83091BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1C43933FE;
	Fri, 16 Jan 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="sJD0JJrS";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KNh9pI3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a48-179.smtp-out.amazonses.com (a48-179.smtp-out.amazonses.com [54.240.48.179])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF191EB9F2;
	Fri, 16 Jan 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590301; cv=none; b=eCGOUyht8v4CIGzQSVzUXbpFT1532ZmmusqPyvLpUx1fbQcBewC8d5gvS4qrEMEV2AV3gjwJrT+5t+lcABKyZOSiCtBFPlcL+3puDGhegNs3WfKwtvoFpbyA7c3oFGgsNauUW0bX0A7Siw+PG7a4uy/P1/abMt5kxFawZWXc7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590301; c=relaxed/simple;
	bh=TqS5eFD1jbq9dGEFSNc0hedcPUqlsiWxA5QSUUddTqs=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=RPKN8tWkM8XEE5/TD8duxp4Ln7g1YuVKF/JcHQZivJwuK5tA0QLOJZIKO1VxHRwk7tjxlnM+Ty7FaianITJM8qe3nHZnETSKpiBB+e0uLvYu6uKSWzyFA0ZQyppPOjXiyjioz/FknxXhUQC5Zx4/yKGiO64SbfGIF1k8KkC/8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=sJD0JJrS; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=KNh9pI3k; arc=none smtp.client-ip=54.240.48.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590298;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=TqS5eFD1jbq9dGEFSNc0hedcPUqlsiWxA5QSUUddTqs=;
	b=sJD0JJrS4Qkxu//VxbL5AZn8rfy47cJHm3WDbH6ro7RaDBzjFf5fWPqYAjNaurlo
	kEMwRLOc/2XNJBXVA3J2lOI78jibWctNwQ0G/rOgAIL203t9vmayGpMey1EJpDLQbC6
	UwM2n/X+JpXIWSyw6VfS5USz1nbIky+DglYsZCoU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590298;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=TqS5eFD1jbq9dGEFSNc0hedcPUqlsiWxA5QSUUddTqs=;
	b=KNh9pI3k3/IMl/I9gJnRmYb/QxOkBmWXDa+0zh2IMAd2LojQ99SR7RoqYMPVZuj8
	Mfu1Z13HWxXBrOzbY3g8Nk5WddlJPN9Ce09tCef0uJb+P+gsu3IOnMEU/Yg61KX5X6e
	d4330hLPma5N5LsT2GUvxcUHov29ZoVIqpviZcdw=
Subject: [PATCH V5 10/19] famfs_fuse: Update macro
 s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:04:58 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260116185911.1005-1-john@jagalactic.com>
References: <20260116125831.953.compound@groves.net> 
 <20260116185911.1005-1-john@jagalactic.com> 
 <20260116185911.1005-11-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAA4wzI=
Thread-Topic: [PATCH V5 10/19] famfs_fuse: Update macro
 s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
X-Wm-Sent-Timestamp: 1768590297
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc8324ce1-16c8c570-2816-4d09-b87c-53e9cbcfb741-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.48.179

From: John Groves <john@groves.net>=0D=0A=0D=0AVirtio_fs now needs to det=
ermine if an inode is DAX && not famfs.=0D=0AThis relaces the FUSE_IS_DAX=
() macro with FUSE_IS_VIRTIO_DAX(),=0D=0Ain preparation for famfs in late=
r commits. The dummy=0D=0Afuse_file_famfs() macro will be replaced with a=
 working=0D=0Afunction.=0D=0A=0D=0AReviewed-by: Joanne Koong <joannelkoon=
g@gmail.com>=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=
=0A fs/fuse/dir.c    |  2 +-=0D=0A fs/fuse/file.c   | 13 ++++++++-----=0D=
=0A fs/fuse/fuse_i.h |  9 ++++++++-=0D=0A fs/fuse/inode.c  |  4 ++--=0D=0A=
 fs/fuse/iomode.c |  2 +-=0D=0A 5 files changed, 20 insertions(+), 10 del=
etions(-)=0D=0A=0D=0Adiff --git a/fs/fuse/dir.c b/fs/fuse/dir.c=0D=0Ainde=
x 4b6b3d2758ff..1400c9d733ba 100644=0D=0A--- a/fs/fuse/dir.c=0D=0A+++ b/f=
s/fuse/dir.c=0D=0A@@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_id=
map *idmap, struct dentry *dentry,=0D=0A =09=09is_truncate =3D true;=0D=0A=
 =09}=0D=0A=20=0D=0A-=09if (FUSE_IS_DAX(inode) && is_truncate) {=0D=0A+=09=
if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {=0D=0A =09=09filemap_invalida=
te_lock(mapping);=0D=0A =09=09fault_blocked =3D true;=0D=0A =09=09err =3D=
 fuse_dax_break_layouts(inode, 0, -1);=0D=0Adiff --git a/fs/fuse/file.c b=
/fs/fuse/file.c=0D=0Aindex 01bc894e9c2b..093569033ed1 100644=0D=0A--- a/f=
s/fuse/file.c=0D=0A+++ b/fs/fuse/file.c=0D=0A@@ -252,7 +252,7 @@ static i=
nt fuse_open(struct inode *inode, struct file *file)=0D=0A =09int err;=0D=
=0A =09bool is_truncate =3D (file->f_flags & O_TRUNC) && fc->atomic_o_tru=
nc;=0D=0A =09bool is_wb_truncate =3D is_truncate && fc->writeback_cache;=0D=
=0A-=09bool dax_truncate =3D is_truncate && FUSE_IS_DAX(inode);=0D=0A+=09=
bool dax_truncate =3D is_truncate && FUSE_IS_VIRTIO_DAX(fi);=0D=0A=20=0D=0A=
 =09if (fuse_is_bad(inode))=0D=0A =09=09return -EIO;=0D=0A@@ -1812,11 +18=
12,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct io=
v_iter *to)=0D=0A =09struct file *file =3D iocb->ki_filp;=0D=0A =09struct=
 fuse_file *ff =3D file->private_data;=0D=0A =09struct inode *inode =3D f=
ile_inode(file);=0D=0A+=09struct fuse_inode *fi =3D get_fuse_inode(inode)=
;=0D=0A=20=0D=0A =09if (fuse_is_bad(inode))=0D=0A =09=09return -EIO;=0D=0A=
=20=0D=0A-=09if (FUSE_IS_DAX(inode))=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi))=
=0D=0A =09=09return fuse_dax_read_iter(iocb, to);=0D=0A=20=0D=0A =09/* FO=
PEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */=0D=0A@@ -1833,11 +1834,12 @@=
 static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter =
*from)=0D=0A =09struct file *file =3D iocb->ki_filp;=0D=0A =09struct fuse=
_file *ff =3D file->private_data;=0D=0A =09struct inode *inode =3D file_i=
node(file);=0D=0A+=09struct fuse_inode *fi =3D get_fuse_inode(inode);=0D=0A=
=20=0D=0A =09if (fuse_is_bad(inode))=0D=0A =09=09return -EIO;=0D=0A=20=0D=
=0A-=09if (FUSE_IS_DAX(inode))=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi))=0D=0A=
 =09=09return fuse_dax_write_iter(iocb, from);=0D=0A=20=0D=0A =09/* FOPEN=
_DIRECT_IO overrides FOPEN_PASSTHROUGH */=0D=0A@@ -2370,10 +2372,11 @@ st=
atic int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)=0D=
=0A =09struct fuse_file *ff =3D file->private_data;=0D=0A =09struct fuse_=
conn *fc =3D ff->fm->fc;=0D=0A =09struct inode *inode =3D file_inode(file=
);=0D=0A+=09struct fuse_inode *fi =3D get_fuse_inode(inode);=0D=0A =09int=
 rc;=0D=0A=20=0D=0A =09/* DAX mmap is superior to direct_io mmap */=0D=0A=
-=09if (FUSE_IS_DAX(inode))=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi))=0D=0A =09=
=09return fuse_dax_mmap(file, vma);=0D=0A=20=0D=0A =09/*=0D=0A@@ -2934,7 =
+2937,7 @@ static long fuse_file_fallocate(struct file *file, int mode, l=
off_t offset,=0D=0A =09=09.mode =3D mode=0D=0A =09};=0D=0A =09int err;=0D=
=0A-=09bool block_faults =3D FUSE_IS_DAX(inode) &&=0D=0A+=09bool block_fa=
ults =3D FUSE_IS_VIRTIO_DAX(fi) &&=0D=0A =09=09(!(mode & FALLOC_FL_KEEP_S=
IZE) ||=0D=0A =09=09 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE=
)));=0D=0A=20=0D=0Adiff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h=0D=0A=
index 7f16049387d1..45e108dec771 100644=0D=0A--- a/fs/fuse/fuse_i.h=0D=0A=
+++ b/fs/fuse/fuse_i.h=0D=0A@@ -1508,7 +1508,14 @@ void fuse_free_conn(st=
ruct fuse_conn *fc);=0D=0A=20=0D=0A /* dax.c */=0D=0A=20=0D=0A-#define FU=
SE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))=0D=0A+sta=
tic inline bool fuse_file_famfs(struct fuse_inode *fuse_inode) /* Will be=
 superseded */=0D=0A+{=0D=0A+=09(void)fuse_inode;=0D=0A+=09return false;=0D=
=0A+}=0D=0A+#define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUS=
E_DAX)=09\=0D=0A+=09=09=09=09=09&& IS_DAX(&fuse_inode->inode)  \=0D=0A+=09=
=09=09=09=09&& !fuse_file_famfs(fuse_inode))=0D=0A=20=0D=0A ssize_t fuse_=
dax_read_iter(struct kiocb *iocb, struct iov_iter *to);=0D=0A ssize_t fus=
e_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);=0D=0Adiff --=
git a/fs/fuse/inode.c b/fs/fuse/inode.c=0D=0Aindex 819e50d66622..ed667920=
997f 100644=0D=0A--- a/fs/fuse/inode.c=0D=0A+++ b/fs/fuse/inode.c=0D=0A@@=
 -162,7 +162,7 @@ static void fuse_evict_inode(struct inode *inode)=0D=0A=
 =09/* Will write inode on close/munmap and in all other dirtiers */=0D=0A=
 =09WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);=0D=0A=20=0D=0A=
-=09if (FUSE_IS_DAX(inode))=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi))=0D=0A =09=
=09dax_break_layout_final(inode);=0D=0A=20=0D=0A =09truncate_inode_pages_=
final(&inode->i_data);=0D=0A@@ -170,7 +170,7 @@ static void fuse_evict_in=
ode(struct inode *inode)=0D=0A =09if (inode->i_sb->s_flags & SB_ACTIVE) {=
=0D=0A =09=09struct fuse_conn *fc =3D get_fuse_conn(inode);=0D=0A=20=0D=0A=
-=09=09if (FUSE_IS_DAX(inode))=0D=0A+=09=09if (FUSE_IS_VIRTIO_DAX(fi))=0D=
=0A =09=09=09fuse_dax_inode_cleanup(inode);=0D=0A =09=09if (fi->nlookup) =
{=0D=0A =09=09=09fuse_queue_forget(fc, fi->forget, fi->nodeid,=0D=0Adiff =
--git a/fs/fuse/iomode.c b/fs/fuse/iomode.c=0D=0Aindex 3728933188f3..31ee=
7f3304c6 100644=0D=0A--- a/fs/fuse/iomode.c=0D=0A+++ b/fs/fuse/iomode.c=0D=
=0A@@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct in=
ode *inode)=0D=0A =09 * io modes are not relevant with DAX and with serve=
r that does not=0D=0A =09 * implement open.=0D=0A =09 */=0D=0A-=09if (FUS=
E_IS_DAX(inode) || !ff->args)=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi) || !ff-=
>args)=0D=0A =09=09return 0;=0D=0A=20=0D=0A =09/*=0D=0A--=20=0D=0A2.52.0=0D=
=0A=0D=0A

