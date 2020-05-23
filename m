Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1052E1DF4EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 07:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgEWFNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 01:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgEWFNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 01:13:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D8C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 22:13:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci21so5897662pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZAspQf7TM/M02K0B+p3YEM0X6lS3/JZ71GqSbfax5/k=;
        b=uufsQ0ESVkF6yv6Vc23XswtFuKezeifYKwKehcYCRFjMTigrMM/MqLlr3j05UNJA3b
         I9EibMWMrnmM3g+uzfCf6h9o33N/GqHjiYP1R5xzA9PNS9tdzGx3IYJRADeY7e8ao9oA
         JjVtsaYPcmfUFYGX6t0LUNQ07Dq8qsddOeuNrhyZFmWj8syDldPGOyySug4YoHp+r1As
         u6v79AGTWpLLxhh5pMYuHxJr2ZN8WxGdyZwyPf/rDOnL+liSxxFWOiaE+Gz6wnK/LxTU
         lvYeH9NDu5o9EUuaJUzyrPrljNNPSvIMlrzegkUeP2RiKKHNCXqRf90ncrsQ0lfk+oPt
         OMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZAspQf7TM/M02K0B+p3YEM0X6lS3/JZ71GqSbfax5/k=;
        b=CGpAtxRd4xzrKMikY71Hg3Iqz6mOzzf4aQ2yrZcljuNsecHWST+PeryMIG7ie9crj7
         XhLVVGw7dVdWvN0l7oLNcMiQ0iWek1g4lcn5m5+q5V131v3Yum6MfCjeQGw7cApdmDwO
         aM0C20y5KhT6moK1LRc5wIlfudG/kfXgAM9H2FgPxDTK0U8C277t+FQ7Xv95L09lda/K
         MSJULA1zRf9uJBUl2n/9TxuEJSGNOKnu02tcdO95NRfRJaEduSkssFUgRx2gFW+Wzhvv
         OaKESxEmkW+ayxZC6kR9182DuqlsyOPjAdF0wFzh9of/0KiNDW//jYYiG5xJSQqPZzUe
         Abog==
X-Gm-Message-State: AOAM5322sWlCApzHjs9AiFI7RViOiTMRCMXScpn64JoO4fY08R3eJ0V0
        Zvn7jS/OzVj45xyDmfoDQGRDmQ==
X-Google-Smtp-Source: ABdhPJzKlxEMs9umPqk6EJ8eDdYBxJLlG4weeXG8K6c07uZt5fwjqCgDr/qdJxOdxIK9BRnM97irIQ==
X-Received: by 2002:a17:90a:ca94:: with SMTP id y20mr8084782pjt.97.1590210823757;
        Fri, 22 May 2020 22:13:43 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y5sm8117974pff.150.2020.05.22.22.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 22:13:42 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F23FF70E-F94D-481C-8A85-32B4CE50B63E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EA940E7B-23BE-40EB-888E-1A45D84AE90C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V4 7/8] fs/ext4: Introduce DAX inode flag
Date:   Fri, 22 May 2020 23:13:41 -0600
In-Reply-To: <20200521191313.261929-8-ira.weiny@intel.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     ira.weiny@intel.com
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-8-ira.weiny@intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_EA940E7B-23BE-40EB-888E-1A45D84AE90C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 21, 2020, at 1:13 PM, ira.weiny@intel.com wrote:
>=20
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
>=20
> Set the flag to be user visible and changeable.  Set the flag to be
> inherited.  Allow applications to change the flag at any time with the
> exception of if VERITY or ENCRYPT is set.
>=20
> Disallow setting VERITY or ENCRYPT if DAX is set.
>=20
> Finally, on regular files, flag the inode to not be cached to =
facilitate
> changing S_DAX on the next creation of the inode.
>=20
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> ---
> Changes from V3:
> 	Move bit to bit25 per Andreas
>=20
> Change from V2:
> 	Add in making verity and DAX exclusive.
> 	'Squash' in making encryption and DAX exclusive.
> 	Add in EXT4_INODE_DAX flag definition to be compatible with
> 		ext4_[set|test]_inode_flag() bit operations
> 	Use ext4_[set|test]_inode_flag() bit operations to be consistent
> 		with other code.
>=20
> Change from V0:
> 	Add FS_DAX_FL to include/uapi/linux/fs.h
> 		to be consistent
> 	Move ext4_dax_dontcache() to ext4_ioctl_setflags()
> 		This ensures that it is only set when the flags are =
going to be
> 		set and not if there is an error
> 		Also this sets don't cache in the FS_IOC_SETFLAGS case
>=20
> Change from RFC:
> 	use new d_mark_dontcache()
> 	Allow caching if ALWAYS/NEVER is set
> 	Rebased to latest Linus master
> 	Change flag to unused 0x01000000
> 	update ext4_should_enable_dax()
> ---
> fs/ext4/ext4.h          | 14 ++++++++++----
> fs/ext4/inode.c         |  2 +-
> fs/ext4/ioctl.c         | 34 +++++++++++++++++++++++++++++++++-
> fs/ext4/super.c         |  3 +++
> fs/ext4/verity.c        |  2 +-
> include/uapi/linux/fs.h |  1 +
> 6 files changed, 49 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 65ffb831b2b9..09b8906568d2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -415,13 +415,16 @@ struct flex_groups {
> #define EXT4_VERITY_FL			0x00100000 /* Verity =
protected inode */
> #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for =
large EA */
> /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
> +
> +#define EXT4_DAX_FL			0x02000000 /* Inode is DAX */
> +
> #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline =
data. */
> #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with =
parents projid */
> #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
> #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 =
lib */
>=20
> -#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags =
*/
> -#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User =
modifiable flags */
> +#define EXT4_FL_USER_VISIBLE		0x725BDFFF /* User visible flags =
*/
> +#define EXT4_FL_USER_MODIFIABLE		0x624BC0FF /* User =
modifiable flags */
>=20
> /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
> #define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
> @@ -429,14 +432,16 @@ struct flex_groups {
> 					 EXT4_APPEND_FL | \
> 					 EXT4_NODUMP_FL | \
> 					 EXT4_NOATIME_FL | \
> -					 EXT4_PROJINHERIT_FL)
> +					 EXT4_PROJINHERIT_FL | \
> +					 EXT4_DAX_FL)
>=20
> /* Flags that should be inherited by new inodes from their parent. */
> #define EXT4_FL_INHERITED (EXT4_SECRM_FL | EXT4_UNRM_FL | =
EXT4_COMPR_FL |\
> 			   EXT4_SYNC_FL | EXT4_NODUMP_FL | =
EXT4_NOATIME_FL |\
> 			   EXT4_NOCOMPR_FL | EXT4_JOURNAL_DATA_FL |\
> 			   EXT4_NOTAIL_FL | EXT4_DIRSYNC_FL |\
> -			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
> +			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL |\
> +			   EXT4_DAX_FL)
>=20
> /* Flags that are appropriate for regular files (all but dir-specific =
ones). */
> #define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | =
EXT4_CASEFOLD_FL |\
> @@ -488,6 +493,7 @@ enum {
> 	EXT4_INODE_VERITY	=3D 20,	/* Verity protected inode */
> 	EXT4_INODE_EA_INODE	=3D 21,	/* Inode used for large EA */
> /* 22 was formerly EXT4_INODE_EOFBLOCKS */
> +	EXT4_INODE_DAX		=3D 25,	/* Inode is DAX */
> 	EXT4_INODE_INLINE_DATA	=3D 28,	/* Data in inode. */
> 	EXT4_INODE_PROJINHERIT	=3D 29,	/* Create with parents projid */
> 	EXT4_INODE_RESERVED	=3D 31,	/* reserved for ext4 lib */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 68fac9289109..778b0dbe3da6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4419,7 +4419,7 @@ static bool ext4_should_enable_dax(struct inode =
*inode)
> 	if (test_opt(inode->i_sb, DAX_ALWAYS))
> 		return true;
>=20
> -	return false;
> +	return ext4_test_inode_flag(inode, EXT4_INODE_DAX);
> }
>=20
> void ext4_set_inode_flags(struct inode *inode, bool init)
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 145083e8cd1e..668b8c17d6eb 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -292,6 +292,21 @@ static int ext4_ioctl_check_immutable(struct =
inode *inode, __u32 new_projid,
> 	return 0;
> }
>=20
> +static void ext4_dax_dontcache(struct inode *inode, unsigned int =
flags)
> +{
> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
> +
> +	if (S_ISDIR(inode->i_mode))
> +		return;
> +
> +	if (test_opt2(inode->i_sb, DAX_NEVER) ||
> +	    test_opt(inode->i_sb, DAX_ALWAYS))
> +		return;
> +
> +	if ((ei->i_flags ^ flags) & EXT4_DAX_FL)
> +		d_mark_dontcache(inode);
> +}
> +
> static int ext4_ioctl_setflags(struct inode *inode,
> 			       unsigned int flags)
> {
> @@ -303,6 +318,16 @@ static int ext4_ioctl_setflags(struct inode =
*inode,
> 	unsigned int jflag;
> 	struct super_block *sb =3D inode->i_sb;
>=20
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX)) {
> +		if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY) ||
> +		    ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT) ||
> +		    ext4_test_inode_state(inode,
> +					  =
EXT4_STATE_VERITY_IN_PROGRESS)) {
> +			err =3D -EOPNOTSUPP;
> +			goto flags_out;
> +		}
> +	}
> +
> 	/* Is it quota file? Do not allow user to mess with it */
> 	if (ext4_is_quota_file(inode))
> 		goto flags_out;
> @@ -369,6 +394,8 @@ static int ext4_ioctl_setflags(struct inode =
*inode,
> 	if (err)
> 		goto flags_err;
>=20
> +	ext4_dax_dontcache(inode, flags);
> +
> 	for (i =3D 0, mask =3D 1; i < 32; i++, mask <<=3D 1) {
> 		if (!(mask & EXT4_FL_USER_MODIFIABLE))
> 			continue;
> @@ -528,12 +555,15 @@ static inline __u32 =
ext4_iflags_to_xflags(unsigned long iflags)
> 		xflags |=3D FS_XFLAG_NOATIME;
> 	if (iflags & EXT4_PROJINHERIT_FL)
> 		xflags |=3D FS_XFLAG_PROJINHERIT;
> +	if (iflags & EXT4_DAX_FL)
> +		xflags |=3D FS_XFLAG_DAX;
> 	return xflags;
> }
>=20
> #define EXT4_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | =
\
> 				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
> -				  FS_XFLAG_NOATIME | =
FS_XFLAG_PROJINHERIT)
> +				  FS_XFLAG_NOATIME | =
FS_XFLAG_PROJINHERIT | \
> +				  FS_XFLAG_DAX)
>=20
> /* Transfer xflags flags to internal */
> static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
> @@ -552,6 +582,8 @@ static inline unsigned long =
ext4_xflags_to_iflags(__u32 xflags)
> 		iflags |=3D EXT4_NOATIME_FL;
> 	if (xflags & FS_XFLAG_PROJINHERIT)
> 		iflags |=3D EXT4_PROJINHERIT_FL;
> +	if (xflags & FS_XFLAG_DAX)
> +		iflags |=3D EXT4_DAX_FL;
>=20
> 	return iflags;
> }
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5e056aa20ce9..3658e3016999 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1323,6 +1323,9 @@ static int ext4_set_context(struct inode *inode, =
const void *ctx, size_t len,
> 	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
> 		return -EINVAL;
>=20
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
> +		return -EOPNOTSUPP;
> +
> 	res =3D ext4_convert_inline_data(inode);
> 	if (res)
> 		return res;
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 89a155ece323..4fecb3e4e338 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -113,7 +113,7 @@ static int ext4_begin_enable_verity(struct file =
*filp)
> 	handle_t *handle;
> 	int err;
>=20
> -	if (IS_DAX(inode))
> +	if (IS_DAX(inode) || ext4_test_inode_flag(inode, =
EXT4_INODE_DAX))
> 		return -EINVAL;
>=20
> 	if (ext4_verity_in_progress(inode))
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 379a612f8f1d..f44eb0a04afd 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -262,6 +262,7 @@ struct fsxattr {
> #define FS_EA_INODE_FL			0x00200000 /* Inode used =
for large EA */
> #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved =
for ext4 */
> #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
> #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 =
*/
> #define FS_PROJINHERIT_FL		0x20000000 /* Create with =
parents projid */
> #define FS_CASEFOLD_FL			0x40000000 /* Folder is =
case insensitive */
> --
> 2.25.1
>=20


Cheers, Andreas






--Apple-Mail=_EA940E7B-23BE-40EB-888E-1A45D84AE90C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7IsQUACgkQcqXauRfM
H+AZ0RAAtwfgf5s1Lxk/3cQkf4+C7aJK/Z7GapQwbrKpIUt9+AMV/tg51I/jqbYg
RjhH+y9lhegPRuXq+MnuydevKEQ29Bua6X7DWA/FEkbaUVf9tEam32D5lri5SAeq
2pXy5tNvmFljZMrZJEvIjuPY+5vAeQik8FqYWk60m0VdUhEfpxr+3TL2EKFMvfRr
04ZO5wwuDUrrEFycmpLFU1RO+JeqCthsNnOckW9rJ55W2PhWxwbJiPemwzROgnVZ
XHP7evLVXu0Uq8I/wsT2qOyJrCJKbmYn5ygq8BcU7vqIEePAT+VtwF4cjcjx+flh
Vo5Qy44RvDne6w4cziBJEw8y77EJvaIuZ5lkcAmHxrj4SR3YyoKBfing2Qso0rcS
yfxoWWCwXx0iUcAY9DEe034NrUz9rWTpV/WzMS8LtWyy5+0xQIOtZtgm+AxO+lqI
andWp5o/4yRCWZXq9UkFN4JUBDdk54ihCz/6Ef1OCXwcqbVg3F/7DRF9KoLdKlfr
eBZSOnplz4R63dkkrYOzg6eajSOcGdVjwvPB1h5xb07BsjNN2csbhaIE/1B9Nxq9
aWrSX+kYL3twAtD88dyMfV+79mJ8CJbHeroOszIUdxiU9d2zCiavss59RPXbKPD2
GvQtNwOjavD330Ucdu1COYq/ajrgSOcRtX9HgPzxquhFqN3T55Y=
=V0lu
-----END PGP SIGNATURE-----

--Apple-Mail=_EA940E7B-23BE-40EB-888E-1A45D84AE90C--
