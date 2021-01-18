Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B212F9D15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbhARKrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 05:47:06 -0500
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:57393 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388951AbhARJgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:36:18 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 04BDD82074;
        Mon, 18 Jan 2021 12:35:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1610962506;
        bh=0uRs6X/nEb5Hp6vrw8vJZxCQ51MaQnJYk7+aDEmyQyw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=hKurjRgOKVVaidFj2rFVhkTbU9x+Ym9j86GJ2tzIot3mOVLdiycIMgQ+qoVO3xj/t
         dM/KbgjO3+6fA9+7er4P42rd8BgxFw8uzh4+Q2fV00x7IGDZJxmUZQDeKvV3BvY7l7
         32dL3Ob9/h7BK8xizqzTTAy0kDmtcZ02ojIjuCHo=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 18 Jan 2021 12:35:05 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Mon, 18 Jan 2021 12:35:05 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: RE: [PATCH v17 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v17 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AQHW34lDSM77DZhIDU+vJCA3qNRrR6oWIfSAgBcXH+A=
Date:   Mon, 18 Jan 2021 09:35:05 +0000
Message-ID: <750a0cef33f34c0989cacfb0bcd4ac5e@paragon-software.com>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
 <20210103195017.fim2msuzj3kup6rq@kari-VirtualBox>
In-Reply-To: <20210103195017.fim2msuzj3kup6rq@kari-VirtualBox>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kari Argillander <kari.argillander@gmail.com>
Sent: Sunday, January 3, 2021 10:50 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de; ebiggers@kernel.org;
> andy.lavr@gmail.com
> Subject: Re: [PATCH v17 02/10] fs/ntfs3: Add initialization of super bloc=
k
>=20
> On Thu, Dec 31, 2020 at 06:23:53PM +0300, Konstantin Komarov wrote:
>=20
> > diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
>=20
> > +int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info=
 *sbi)
> > +{
> > +	int err =3D 0;
> > +	struct super_block *sb =3D sbi->sb;
> > +	struct inode *inode =3D &ni->vfs_inode;
> > +	struct MFT_REF ref;
> > +
> > +	/* Check for 4GB */
> > +	if (inode->i_size >=3D 0x100000000ull) {
> > +		ntfs_err(sb, "$LogFile is too big");
> > +		err =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	sbi->flags |=3D NTFS_FLAGS_LOG_REPLAYING;
> > +
> > +	ref.low =3D cpu_to_le32(MFT_REC_MFT);
> > +	ref.high =3D 0;
> > +	ref.seq =3D cpu_to_le16(1);
> > +
> > +	inode =3D ntfs_iget5(sb, &ref, NULL);
> > +
> > +	if (IS_ERR(inode))
> > +		inode =3D NULL;
> > +
> > +	if (!inode) {
> > +		/* Try to use mft copy */
> > +		u64 t64 =3D sbi->mft.lbo;
> > +
> > +		sbi->mft.lbo =3D sbi->mft.lbo2;
> > +		inode =3D ntfs_iget5(sb, &ref, NULL);
> > +		sbi->mft.lbo =3D t64;
> > +		if (IS_ERR(inode))
> > +			inode =3D NULL;
> > +	}
> > +
> > +	if (!inode) {
> > +		err =3D -EINVAL;
> > +		ntfs_err(sb, "Failed to load $MFT.");
> > +		goto out;
> > +	}
> > +
> > +	sbi->mft.ni =3D ntfs_i(inode);
> > +
> > +	err =3D ni_load_all_mi(sbi->mft.ni);
> > +	if (!err)
> > +		err =3D log_replay(ni);
>=20
> We only get error from log_replay if
>=20
> > +
> > +	iput(inode);
> > +	sbi->mft.ni =3D NULL;
> > +
> > +	sync_blockdev(sb->s_bdev);
> > +	invalidate_bdev(sb->s_bdev);
> > +
> > +	/* reinit MFT */
> > +	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
> > +		err =3D 0;
> > +		goto out;
> > +	}
> > +
> > +	if (sb_rdonly(sb))
> > +		goto out;
>=20
> we get here. Is this a intentional? Probably but I'm just checking.
>=20

Hi Kari! Thanks for your attention on our patches.
This may be indeed quite entangled, here are the cases needed to be
covered:
1) !err && !(sbi->flags & NTFS_FLAGS_NEED_REPLAY) - ok
2) err && !(sbi->flags & NTFS_FLAGS_NEED_REPLAY) - no memory,
  io error, etc on prepare to replay stage
3) !err && (sbi->flags & NTFS_FLAGS_NEED_REPLAY) -
  journal is not empty, storage is readonly or unsupported log version
4) err && (sbi->flags & NTFS_FLAGS_NEED_REPLAY) - no memory, io error,
  etc while replaying
Distinction is that, cases 2/3 lead to mount error every time, while
case 4 permits read-only mount.

> > diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
>=20
> > +int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
> > +		      const struct cpu_str *uni, umode_t mode, dev_t dev,
> > +		      const char *symname, u32 size, int excl,
> > +		      struct ntfs_fnd *fnd, struct inode **new_inode)
> > +{
>=20
> > +#ifdef CONFIG_NTFS3_FS_POSIX_ACL
>=20
> In Kconfig this is NTFS3_POSIX_ACL. This repeat every file.
>=20

This is OK. You may refer to similar parts of ext4/btrfs sources as a
reference:
fs/ext4/Kconfig or fs/btrfs/Kconfig

> > +int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
> > +{
> > +	int err;
> > +	struct super_block *sb =3D dir->i_sb;
> > +	struct ntfs_sb_info *sbi =3D sb->s_fs_info;
> > +	struct inode *inode =3D d_inode(dentry);
> > +	struct ntfs_inode *ni =3D ntfs_i(inode);
> > +	const struct qstr *name =3D &dentry->d_name;
> > +	struct ntfs_inode *dir_ni =3D ntfs_i(dir);
> > +	struct ntfs_index *indx =3D &dir_ni->dir;
> > +	struct cpu_str *uni =3D NULL;
> > +	struct ATTR_FILE_NAME *fname;
> > +	u8 name_type;
> > +	struct ATTR_LIST_ENTRY *le;
> > +	struct MFT_REF ref;
> > +	bool is_dir =3D S_ISDIR(inode->i_mode);
> > +	struct INDEX_ROOT *dir_root;
> > +
> > +	dir_root =3D indx_get_root(indx, dir_ni, NULL, NULL);
> > +	if (!dir_root)
> > +		return -EINVAL;
> > +
> > +	ni_lock(ni);
> > +
> > +	if (is_dir && !dir_is_empty(inode)) {
> > +		err =3D -ENOTEMPTY;
> > +		goto out1;
> > +	}
> > +
> > +	if (ntfs_is_meta_file(sbi, inode->i_ino)) {
> > +		err =3D -EINVAL;
> > +		goto out1;
> > +	}
> > +
> > +	/* allocate PATH_MAX bytes */
> > +	uni =3D __getname();
> > +	if (!uni) {
> > +		err =3D -ENOMEM;
> > +		goto out1;
> > +	}
> > +
> > +	/* Convert input string to unicode */
> > +	err =3D ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_=
LEN,
> > +				UTF16_HOST_ENDIAN);
> > +	if (err < 0)
> > +		goto out4;
> > +
> > +	le =3D NULL;
>=20
> Little bit random place for this. Do we even need to NULL le.
>=20

Thanks. Inititialization is moved to to the place where ni_fname_name
is being called.
> > +
> > +	/*mark rw ntfs as dirty. it will be cleared at umount*/
> > +	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
> > +
> > +	/* find name in record */
> > +#ifdef NTFS3_64BIT_CLUSTER
> > +	ref.low =3D cpu_to_le32(dir->i_ino & 0xffffffff);
> > +	ref.high =3D cpu_to_le16(dir->i_ino >> 32);
> > +#else
> > +	ref.low =3D cpu_to_le32(dir->i_ino & 0xffffffff);
> > +	ref.high =3D 0;
> > +#endif
> > +	ref.seq =3D dir_ni->mi.mrec->seq;
> > +
> > +	fname =3D ni_fname_name(ni, uni, &ref, &le);
>=20
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
>=20
> > +#ifdef CONFIG_PRINTK
> > +/*
> > + * Trace warnings/notices/errors
> > + * Thanks Joe Perches <joe@perches.com> for implementation
> > + */
> > +void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +	int level;
> > +	struct ntfs_sb_info *sbi =3D sb->s_fs_info;
> > +
> > +	/*should we use different ratelimits for warnings/notices/errors? */
> > +	if (!___ratelimit(&sbi->msg_ratelimit, "ntfs3"))
> > +		return;
> > +
> > +	va_start(args, fmt);
> > +
> > +	level =3D printk_get_level(fmt);
> > +	vaf.fmt =3D printk_skip_level(fmt);
> > +	vaf.va =3D &args;
> > +	printk("%c%cntfs3: %s: %pV\n", KERN_SOH_ASCII, level, sb->s_id, &vaf)=
;
> > +
> > +	va_end(args);
> > +}
> > +
> > +static char s_name_buf[512];
> > +static atomic_t s_name_buf_cnt =3D ATOMIC_INIT(1); // 1 means 'free s_=
name_buf'
> > +
> > +/* print warnings/notices/errors about inode using name or inode numbe=
r */
> > +void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
> > +{
> > +	struct super_block *sb =3D inode->i_sb;
> > +	struct ntfs_sb_info *sbi =3D sb->s_fs_info;
> > +	char *name;
> > +	va_list args;
> > +	struct va_format vaf;
> > +	int level;
> > +
> > +	if (!___ratelimit(&sbi->msg_ratelimit, "ntfs3"))
> > +		return;
> > +
> > +	if (atomic_dec_and_test(&s_name_buf_cnt)) {
> > +		/* use static allocated buffer */
> > +		name =3D s_name_buf;
> > +	} else {
> > +		name =3D kmalloc(sizeof(s_name_buf), GFP_NOFS);
> > +	}
> > +
> > +	if (name) {
> > +		struct dentry *dentry =3D d_find_alias(inode);
> > +		const u32 name_len =3D ARRAY_SIZE(s_name_buf) - 1;
> > +
> > +		if (dentry) {
> > +			spin_lock(&dentry->d_lock);
> > +			snprintf(name, name_len, "%s", dentry->d_name.name);
> > +			spin_unlock(&dentry->d_lock);
> > +			dput(dentry);
> > +			name[name_len] =3D 0; /* to be sure*/
> > +		} else {
> > +			name[0] =3D 0;
> > +		}
> > +	}
> > +
> > +	va_start(args, fmt);
> > +
> > +	level =3D printk_get_level(fmt);
> > +	vaf.fmt =3D printk_skip_level(fmt);
> > +	vaf.va =3D &args;
> > +
> > +	printk("%c%cntfs3: %s: ino=3D%lx, \"%s\" %pV\n", KERN_SOH_ASCII, leve=
l,
> > +	       sb->s_id, inode->i_ino, name ? name : "", &vaf);
> > +
> > +	va_end(args);
> > +
> > +	atomic_inc(&s_name_buf_cnt);
> > +	if (name !=3D s_name_buf)
> > +		kfree(name);
> > +}
> > +#endif
>=20
> Should these be in debug.c or something? Atleast I do not see point why
> they are in super.c.
>=20
Overall, the problem file name may be omitted, but it seems to be useful fo=
r
debug purposes. This code is placed into super.c because ntfs_printk is des=
cribed there.

> > +static int __init init_ntfs_fs(void)
> > +{
> > +	int err;
> > +
> > +#ifdef NTFS3_INDEX_BINARY_SEARCH
> > +	pr_notice("ntfs3: +index binary search\n");
> > +#endif
> > +
> > +#ifdef NTFS3_CHECK_FREE_CLST
> > +	pr_notice("ntfs3: +check free clusters\n");
> > +#endif
> > +
> > +#if NTFS_LINK_MAX < 0xffff
> > +	pr_notice("ntfs3: max link count %u\n", NTFS_LINK_MAX);
> > +#endif
> > +
> > +#ifdef NTFS3_64BIT_CLUSTER
> > +	pr_notice("ntfs3: 64 bits per cluster\n");
> > +#else
> > +	pr_notice("ntfs3: 32 bits per cluster\n");
> > +#endif
> > +#ifdef CONFIG_NTFS3_LZX_XPRESS
> > +	pr_notice("ntfs3: read-only lzx/xpress compression included\n");
> > +#endif
> > +
> > +	ntfs_inode_cachep =3D kmem_cache_create(
> > +		"ntfs_inode_cache", sizeof(struct ntfs_inode), 0,
> > +		(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> > +		init_once);
> > +	if (!ntfs_inode_cachep) {
> > +		err =3D -ENOMEM;
> > +		goto failed;
> > +	}
> > +
> > +	err =3D register_filesystem(&ntfs_fs_type);
> > +	if (!err)
> > +		return 0;
>=20
> Do we need kmem_cache_destroy() here if err?
>=20
Thanks, this will be fixed in v18.
> > +
> > +failed:
> > +	return err;
> > +}
