Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3334FFA9EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 07:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKMGAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 01:00:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45103 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfKMGAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:00:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so1089263ljg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 22:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uORn80acVS0xvS2xTg8M3MbneXQszQ1xmPbEQnzYqDc=;
        b=mbMrbNmNc+FEmZpWH5DJAoictHkYrtYorHLi+RtL9wr6NNpRravI/NQ82eiVNVFzFy
         R/i+ScD8wohEDSwJuYo0PCdVKUb28VCZ6tGasKGBjF5mCI+db9uAKppqWbcJthGXpSmF
         ZmYu/UiTdFDSgNhSmH/xX6K1dVmrnzv4X8XfY7rjGzn/7fmoOiyJe169O/RVh94w0s3+
         0gsPqclKwum/y5dJXMY0ZFtBobPlByiO8Tx+jBV9BuRiSuxxn1kiyqRv+3jqF2ajScLq
         kAqdxacZDeM1Byl/v7yKkS543y/q5s5JZkewRJwnUh+h+3aftQw4vpD2U9FszTh2veaN
         SNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uORn80acVS0xvS2xTg8M3MbneXQszQ1xmPbEQnzYqDc=;
        b=RbybUaCKd06mNayW81M3JAi8QLlA8HkzrgyZSd1JBS9cR52YPKWVOpxjGM7vGiV6CB
         oHbS1NqJKYqWsGcxiVc622ETEmmQYkndpxT19mcLjG2zVFIMX9AoeTmuxVhcGyjhJwAx
         zYZaKBaoGkHBNzIy1yUOnVTr1D5SpUstaZ3JTgPWDGa8FpDkcUXdE/f7f1N0Wevbjrfb
         ufVPGRFcYl2FwYYdVuCyghPOUV2NWasO2D4mbBqTajcpMJmPRgwmAikq70zvQoPWCNn4
         yAdH8Cf6VbvoHYvNstYo4XDsSAC/gaM6g55CvQzs+KiAUtVUrXlew7U2TAZNsJj6nJrg
         AwLg==
X-Gm-Message-State: APjAAAVzl8zEk6XcFO/FZnrcqmcndpeRT3ulUGZ0aVq9yyt0fcORv+zE
        N45Ukq56Nl5sFOMLPF+gpNinOA==
X-Google-Smtp-Source: APXvYqyEfWzBnezqyV8E1AuFZnunPIYn+lfxabHyTp8E5Crs/1JcUyIczPGSxchgcQ74Gz/XObS1mQ==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr1125841ljk.101.1573624801007;
        Tue, 12 Nov 2019 22:00:01 -0800 (PST)
Received: from ?IPv6:2a00:1370:812c:3592:c978:3583:27b6:cdc5? ([2a00:1370:812c:3592:c978:3583:27b6:cdc5])
        by smtp.gmail.com with ESMTPSA id y189sm552055lfc.9.2019.11.12.22.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 22:00:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH 13/16] hfs/hfsplus: use 64-bit inode timestamps
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20191108213257.3097633-14-arnd@arndb.de>
Date:   Wed, 13 Nov 2019 08:59:58 +0300
Cc:     y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?IkVybmVzdG8gQS4gRmVybsOhbmRleiI=?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2520E708-4636-4CA8-B953-0F46F8E7454A@dubeyko.com>
References: <20191108213257.3097633-1-arnd@arndb.de>
 <20191108213257.3097633-14-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 9, 2019, at 12:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> The interpretation of on-disk timestamps in HFS and HFS+ differs
> between 32-bit and 64-bit kernels at the moment. Use 64-bit timestamps
> consistently so apply the current 64-bit behavior everyhere.
>=20
> According to the official documentation for HFS+ [1], inode timestamps
> are supposed to cover the time range from 1904 to 2040 as originally
> used in classic MacOS.
>=20
> The traditional Linux usage is to convert the timestamps into an =
unsigned
> 32-bit number based on the Unix epoch and from there to a time_t. On
> 32-bit systems, that wraps the time from 2038 to 1902, so the last
> two years of the valid time range become garbled. On 64-bit systems,
> all times before 1970 get turned into timestamps between 2038 and =
2106,
> which is more convenient but also different from the documented =
behavior.
>=20
> Looking at the Darwin sources [2], it seems that MacOS is inconsistent =
in
> yet another way: all timestamps are wrapped around to a 32-bit =
unsigned
> number when written to the disk, but when read back, all numeric =
values
> lower than 2082844800U are assumed to be invalid, so we cannot =
represent
> the times before 1970 or the times after 2040.
>=20
> While all implementations seem to agree on the interpretation of =
values
> between 1970 and 2038, they often differ on the exact range they =
support
> when reading back values outside of the common range:
>=20
> MacOS (traditional):		1904-2040
> Apple Documentation:		1904-2040
> MacOS X source comments:	1970-2040
> MacOS X source code:		1970-2038
> 32-bit Linux:			1902-2038
> 64-bit Linux:			1970-2106
> hfsfuse:			1970-2040
> hfsutils (32 bit, old libc)	1902-2038
> hfsutils (32 bit, new libc)	1970-2106
> hfsutils (64 bit)		1904-2040
> hfsplus-utils			1904-2040
> hfsexplorer			1904-2040
> 7-zip				1904-2040
>=20
> Out of the above, the range from 1970 to 2106 seems to be the most =
useful,
> as it allows using HFS and HFS+ beyond year 2038, and this matches the
> behavior that most users would see today on Linux, as few people run
> 32-bit kernels any more.
>=20
> Link: [1] =
https://developer.apple.com/library/archive/technotes/tn/tn1150.html
> Link: [2] =
https://opensource.apple.com/source/hfs/hfs-407.30.1/core/MacOSStubs.c.aut=
o.html
> Link: =
https://lore.kernel.org/lkml/20180711224625.airwna6gzyatoowe@eaf/
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
> Suggested-by: "Ernesto A. Fern=C3=A1ndez" =
<ernesto.mnd.fernandez@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: revert back to 1970-2106 time range
>    fix bugs found in review
>    merge both patches into one
>    drop cc:stable tag
> v2: treat pre-1970 dates as invalid following MacOS X behavior,
>    reword and expand changelog text
> ---
> fs/hfs/hfs_fs.h         | 26 ++++++++++++++++++++------
> fs/hfs/inode.c          |  4 ++--
> fs/hfsplus/hfsplus_fs.h | 26 +++++++++++++++++++++-----
> fs/hfsplus/inode.c      | 12 ++++++------
> 4 files changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 6d0783e2e276..26733051ee50 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -242,19 +242,33 @@ extern void hfs_mark_mdb_dirty(struct =
super_block *sb);
> /*
>  * There are two time systems.  Both are based on seconds since
>  * a particular time/date.
> - *	Unix:	unsigned lil-endian since 00:00 GMT, Jan. 1, 1970
> + *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
>  *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
>  *
> + * HFS implementations are highly inconsistent, this one matches the
> + * traditional behavior of 64-bit Linux, giving the most useful
> + * time range between 1970 and 2106, by treating any on-disk =
timestamp
> + * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
>  */
> -#define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - =
sys_tz.tz_minuteswest * 60)
> -#define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  =
+ sys_tz.tz_minuteswest * 60)

I believe it makes sense to introduce some constant instead of hardcoded =
value (2082844800U and 60).
It will be easier to understand the code without necessity to take a =
look into the comments.
What do you think?

> +static inline time64_t __hfs_m_to_utime(__be32 mt)
> +{
> +	time64_t ut =3D (u32)(be32_to_cpu(mt) - 2082844800U);

Ditto.

> +
> +	return ut + sys_tz.tz_minuteswest * 60;
> +}
>=20
> +static inline __be32 __hfs_u_to_mtime(time64_t ut)
> +{
> +	ut -=3D sys_tz.tz_minuteswest * 60;
> +
> +	return cpu_to_be32(lower_32_bits(ut) + 2082844800U);

Ditto.

> +}
> #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, =
vfs_inode))
> #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
>=20
> -#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec =3D =
__hfs_m_to_utime(time) }
> -#define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
> -#define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
> +#define hfs_m_to_utime(time)   (struct timespec64){ .tv_sec =3D =
__hfs_m_to_utime(time) }
> +#define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)
> +#define hfs_mtime()		=
__hfs_u_to_mtime(ktime_get_real_seconds())
>=20
> static inline const char *hfs_mdb_name(struct super_block *sb)
> {
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index da243c84e93b..2f224b98ee94 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode, =
void *data)
> 		inode->i_mode &=3D ~hsb->s_file_umask;
> 		inode->i_mode |=3D S_IFREG;
> 		inode->i_ctime =3D inode->i_atime =3D inode->i_mtime =3D
> -				=
timespec_to_timespec64(hfs_m_to_utime(rec->file.MdDat));
> +				hfs_m_to_utime(rec->file.MdDat);
> 		inode->i_op =3D &hfs_file_inode_operations;
> 		inode->i_fop =3D &hfs_file_operations;
> 		inode->i_mapping->a_ops =3D &hfs_aops;
> @@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode, =
void *data)
> 		HFS_I(inode)->fs_blocks =3D 0;
> 		inode->i_mode =3D S_IFDIR | (S_IRWXUGO & =
~hsb->s_dir_umask);
> 		inode->i_ctime =3D inode->i_atime =3D inode->i_mtime =3D
> -				=
timespec_to_timespec64(hfs_m_to_utime(rec->dir.MdDat));
> +				hfs_m_to_utime(rec->dir.MdDat);
> 		inode->i_op =3D &hfs_dir_inode_operations;
> 		inode->i_fop =3D &hfs_dir_operations;
> 		break;
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index b8471bf05def..22d0a22c41a3 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -533,13 +533,29 @@ int hfsplus_submit_bio(struct super_block *sb, =
sector_t sector, void *buf,
> 		       void **data, int op, int op_flags);
> int hfsplus_read_wrapper(struct super_block *sb);
>=20
> -/* time macros */
> -#define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
> -#define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))

Ditto.

> +/*
> + * time helpers: convert between 1904-base and 1970-base timestamps
> + *
> + * HFS+ implementations are highly inconsistent, this one matches the
> + * traditional behavior of 64-bit Linux, giving the most useful
> + * time range between 1970 and 2106, by treating any on-disk =
timestamp
> + * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
> + */
> +static inline time64_t __hfsp_mt2ut(__be32 mt)
> +{
> +	time64_t ut =3D (u32)(be32_to_cpu(mt) - 2082844800U);

Ditto.

> +
> +	return ut;
> +}
> +
> +static inline __be32 __hfsp_ut2mt(time64_t ut)
> +{
> +	return cpu_to_be32(lower_32_bits(ut) + 2082844800U);

Ditto.

> +}
>=20
> /* compatibility */
> -#define hfsp_mt2ut(t)		(struct timespec){ .tv_sec =3D =
__hfsp_mt2ut(t) }
> +#define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec =3D =
__hfsp_mt2ut(t) }
> #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
> -#define hfsp_now2mt()		__hfsp_ut2mt(get_seconds())
> +#define hfsp_now2mt()		=
__hfsp_ut2mt(ktime_get_real_seconds())
>=20
> #endif
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index d131c8ea7eb6..94bd83b36644 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -504,9 +504,9 @@ int hfsplus_cat_read_inode(struct inode *inode, =
struct hfs_find_data *fd)
> 		hfsplus_get_perms(inode, &folder->permissions, 1);
> 		set_nlink(inode, 1);
> 		inode->i_size =3D 2 + be32_to_cpu(folder->valence);
> -		inode->i_atime =3D =
timespec_to_timespec64(hfsp_mt2ut(folder->access_date));
> -		inode->i_mtime =3D =
timespec_to_timespec64(hfsp_mt2ut(folder->content_mod_date));
> -		inode->i_ctime =3D =
timespec_to_timespec64(hfsp_mt2ut(folder->attribute_mod_date));
> +		inode->i_atime =3D hfsp_mt2ut(folder->access_date);
> +		inode->i_mtime =3D hfsp_mt2ut(folder->content_mod_date);
> +		inode->i_ctime =3D =
hfsp_mt2ut(folder->attribute_mod_date);
> 		HFSPLUS_I(inode)->create_date =3D folder->create_date;
> 		HFSPLUS_I(inode)->fs_blocks =3D 0;
> 		if (folder->flags & =
cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
> @@ -542,9 +542,9 @@ int hfsplus_cat_read_inode(struct inode *inode, =
struct hfs_find_data *fd)
> 			init_special_inode(inode, inode->i_mode,
> 					   =
be32_to_cpu(file->permissions.dev));
> 		}
> -		inode->i_atime =3D =
timespec_to_timespec64(hfsp_mt2ut(file->access_date));
> -		inode->i_mtime =3D =
timespec_to_timespec64(hfsp_mt2ut(file->content_mod_date));
> -		inode->i_ctime =3D =
timespec_to_timespec64(hfsp_mt2ut(file->attribute_mod_date));
> +		inode->i_atime =3D hfsp_mt2ut(file->access_date);
> +		inode->i_mtime =3D hfsp_mt2ut(file->content_mod_date);
> +		inode->i_ctime =3D hfsp_mt2ut(file->attribute_mod_date);
> 		HFSPLUS_I(inode)->create_date =3D file->create_date;
> 	} else {
> 		pr_err("bad catalog entry used to create inode\n");
> =E2=80=94=20
> 2.20.0
>=20

The patch looks pretty clean and good.

Thanks,
Viacheslav Dubeyko.

