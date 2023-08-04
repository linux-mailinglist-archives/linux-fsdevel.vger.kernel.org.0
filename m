Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902FD76FC01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjHDI2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjHDI2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:28:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3C2D54;
        Fri,  4 Aug 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691137661; x=1691742461; i=quwenruo.btrfs@gmx.com;
 bh=8weZwKAv4gCqFhxW1gRMSXIrMTzSQSbPDZ4BX8IWfEQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=h9GvVxFatjM0s54qin1f2rN6XfUCzh9nUQ3UZzabdQIB0VmUvaEUJ9BHU8GgFyboybm/iy9
 mZyLP9h9TJ9fgy9f4Xnr/qaIpVRJjSgNyZC1i0eki4c2SXIilinP6NGPR+mMZg3blJKjC7QwV
 vdkh19qGHED90UHRLYqTMlDHMdYAJAjSGjYKlq1puKWUa/D+S2gMOixQh5aU17LS7Pp5xRsih
 +J4RFNfu+i9BaP1rcm7UQqk+ZAyd27LMH8wjhGd8XmDL+Sy6imC5XpwT14Hh9VpVItudYuNuV
 bigXyGKqBZduyhDNCAPG89OJOPoPfhrRKmnGqfeXIgHqYghiGdaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1pYmf62wrQ-00t8Tn; Fri, 04
 Aug 2023 10:27:41 +0200
Message-ID: <58a425ca-f7e8-b7e2-eb04-d83bb952b382@gmx.com>
Date:   Fri, 4 Aug 2023 16:27:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230803154453.1488248-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ps1lpspXQ2rJ9gbJ4HkVbi0l+xXvjgPhKx5Dq28Na6gIbjGQToz
 r8uA1SxNE5h+O9OQ21zBYMlthaSEVpkYGuAxk6vM7GOx6nnnts9bUg0gG1ayHxp5BVgtXTC
 C6hFK5buHtsJ+ocy1weNuBLs2Gb2mPSlbpwIfEbKhzuGCZLVekDKOAyfh37C9ApfroH1pCt
 AlxWRPg784EmSbJXPscbA==
UI-OutboundReport: notjunk:1;M01:P0:y1R7CqPpmXU=;WQWDIY8aAgS/6TTyE4s70khy/Rc
 WVmmUxFJ+jNPf6griw228EBNE/eHBzyib3aEpgUUE+ydru4pdJEfa8vwYz75pgo9L0OpWi4Bf
 Yay1xP2sYJmZtyHcBMvi1dMyslQ2tl3+1Oo1tF+uLXLRkxItsMF/aR0jogrgJmOwKHe1bWa9a
 +x4Ism1oGnMGL2KtxW90naXof9L0MSvC8XmO4W41dHD1fL9rgcc9VJyBlCLza55YeQ3ek281G
 qlgiFh6+VqSb1stcUpZpNpcdVujbkYtkjfV5E3amUl96V9fZIIevSRydK1w0pePkjcLBYYMQF
 PsZproibxv/jSYOfx8fakh3mzT7EysLzadUtD7i4swfWxKY0jvxyB1F4GJ2pwdZ9yTrgja+IN
 7bBGzaXnirWAfJ3Gw+03IXPjq4Lu29fu2kb8b5R1OLVPq0XVPU0+SFq/wkliVpU83YJMph920
 J2HlVZYUCTrCyvUBp5zzM3ZItfeOfmJthbJ9Epa0PyYYpoTy5CyHwJDYMxYn64+rm7MPP8KYj
 x1y1gb45pWIaP5saaU+pb4G0n4sMbfdfhpjmfOlZu8QmMMmv8q5ZYLE7NLBADVLZ/JfvL/7Dp
 DhssUICyEx/lKyj1IdJd4P0r0xL2kfmf4Ho6scIdZl3pVfaUkOhslNGYEg++mtmvqM01Ay2Hp
 4g+F+FdygtT+nAGbfTzc42agiJUMBtoGePcNkoMeb2ISdI4nruLWBEPS4y1pzka4HvsRK5l8+
 DaoUn4qZoJKHuQnWf2n4q/monAZqgnjHIawHH8ou15Ug/a0DL5PtjHNo/7R7H+0SDH2YaTSCy
 PxWic1vG+XZal152gQf+Ck9mZyaxwfEUPSrf6hdsgSOU2dvrcYT6su+1tKSI47/cJiAyr2Q4l
 z5v4ltMG2BzFeXu9bzkQ45RPae45bWV/cDwi0s6xFY68zDzAYsr8ZAFbNZvtF7y/bb3gSJUOh
 iuMzN4SoIGp0Vn1ukPS3e+9jC6I=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/8/3 23:43, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is used as a unique identifier in the driver.
> This case is supported though in some other common filesystems, like
> ext4; one of the reasons for which is not trivial supporting this case
> on btrfs is due to its multi-device filesystem nature, native RAID, etc.
>
> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> for example. Without this support, it's not safe for users to keep the
> same "image version" in both A and B partitions, a setup that is quite
> common for development, for example. Also, as a big bonus, it allows fs
> integrity check based on block devices for RO devices (whereas currently
> it is required that both have different fsid, breaking the block device
> hash comparison).
>
> Such same-fsid mounting is hereby added through the usage of the
> filesystem feature "single-dev" - when such feature is used, btrfs
> generates a random fsid for the filesystem and leverages the long-term
> present metadata_uuid infrastructure to enable the usage of this
> secondary virtual fsid, effectively requiring few non-invasive changes
> to the code and no new potential corner cases.

My concern is still about the "virtual" fsid part.

If we go virtual fsid, there can be some unexpected problems.

E.g. the /sys/fs/btrfs/<uuid>/ entry would be the new virtual one.

And there may be some other problems like user space UUID detection of
mounted fs, thus I'm not 100% sure if this is a good idea.

However I don't have any better solution either, so this may be the
least worst solution for now.

Thanks,
Qu
>
> In order to prevent more code complexity and corner cases, given
> the nature of this mechanism (single-devices), the single-dev feature
> is not allowed when the metadata_uuid flag is already present on the
> fs, or if the device is on fsid-change state. Device removal/replace
> is also disabled for devices presenting the single-dev feature.
>
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>   fs/btrfs/disk-io.c         | 19 +++++++-
>   fs/btrfs/fs.h              |  3 +-
>   fs/btrfs/ioctl.c           | 18 +++++++
>   fs/btrfs/super.c           |  8 ++--
>   fs/btrfs/volumes.c         | 97 ++++++++++++++++++++++++++++++--------
>   fs/btrfs/volumes.h         |  3 +-
>   include/uapi/linux/btrfs.h |  7 +++
>   7 files changed, 127 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 669b10355091..455fa4949c98 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -320,7 +320,7 @@ static bool check_tree_block_fsid(struct extent_buff=
er *eb)
>   	/*
>   	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
>   	 * metadata_uuid is unset in the superblock, including for a seed dev=
ice.
> -	 * So, we can use fs_devices->metadata_uuid.
> +	 * So, we can use fs_devices->metadata_uuid; same for SINGLE_DEV devic=
es.
>   	 */
>   	if (!memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE=
))
>   		return false;
> @@ -2288,6 +2288,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_=
info,
>   {
>   	u64 nodesize =3D btrfs_super_nodesize(sb);
>   	u64 sectorsize =3D btrfs_super_sectorsize(sb);
> +	u8 *fsid;
>   	int ret =3D 0;
>
>   	if (btrfs_super_magic(sb) !=3D BTRFS_MAGIC) {
> @@ -2368,7 +2369,21 @@ int btrfs_validate_super(struct btrfs_fs_info *fs=
_info,
>   		ret =3D -EINVAL;
>   	}
>
> -	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {
> +	/*
> +	 * For SINGLE_DEV devices, btrfs creates a random fsid and makes
> +	 * use of the metadata_uuid infrastructure in order to allow, for
> +	 * example, two devices with same fsid getting mounted at the same
> +	 * time. But notice no changes happen at the disk level, so the
> +	 * random generated fsid is a driver abstraction, not to be written
> +	 * in the disk. That's the reason we're required here to compare the
> +	 * fsid with the metadata_uuid for such devices.
> +	 */
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
> +		fsid =3D fs_info->fs_devices->metadata_uuid;
> +	else
> +		fsid =3D fs_info->fs_devices->fsid;
> +
> +	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE)) {
>   		btrfs_err(fs_info,
>   		"superblock fsid doesn't match fsid of fs_devices: %pU !=3D %pU",
>   			  sb->fsid, fs_info->fs_devices->fsid);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..c6d124973361 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -200,7 +200,8 @@ enum {
>   	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
>   	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
>   	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
> -	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
> +	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
>
>   #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
>   #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..56703d87def9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2678,6 +2678,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *fi=
le, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>   	vol_args =3D memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -2744,6 +2750,12 @@ static long btrfs_ioctl_rm_dev(struct file *file,=
 void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>   	vol_args =3D memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -3268,6 +3280,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_=
fs_info *fs_info,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>   	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>   		btrfs_err(fs_info, "device replace not supported on extent tree v2 y=
et");
>   		return -EINVAL;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f1dd172d8d5b..ee87189b1ccd 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -883,7 +883,7 @@ static int btrfs_parse_device_options(const char *op=
tions, blk_mode_t flags)
>   				error =3D -ENOMEM;
>   				goto out;
>   			}
> -			device =3D btrfs_scan_one_device(device_name, flags);
> +			device =3D btrfs_scan_one_device(device_name, flags, true);
>   			kfree(device_name);
>   			if (IS_ERR(device)) {
>   				error =3D PTR_ERR(device);
> @@ -1478,7 +1478,7 @@ static struct dentry *btrfs_mount_root(struct file=
_system_type *fs_type,
>   		goto error_fs_info;
>   	}
>
> -	device =3D btrfs_scan_one_device(device_name, mode);
> +	device =3D btrfs_scan_one_device(device_name, mode, true);
>   	if (IS_ERR(device)) {
>   		mutex_unlock(&uuid_mutex);
>   		error =3D PTR_ERR(device);
> @@ -2190,7 +2190,7 @@ static long btrfs_control_ioctl(struct file *file,=
 unsigned int cmd,
>   	switch (cmd) {
>   	case BTRFS_IOC_SCAN_DEV:
>   		mutex_lock(&uuid_mutex);
> -		device =3D btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device =3D btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		ret =3D PTR_ERR_OR_ZERO(device);
>   		mutex_unlock(&uuid_mutex);
>   		break;
> @@ -2204,7 +2204,7 @@ static long btrfs_control_ioctl(struct file *file,=
 unsigned int cmd,
>   		break;
>   	case BTRFS_IOC_DEVICES_READY:
>   		mutex_lock(&uuid_mutex);
> -		device =3D btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device =3D btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		if (IS_ERR(device)) {
>   			mutex_unlock(&uuid_mutex);
>   			ret =3D PTR_ERR(device);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 73753dae111a..433a490f2de8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -681,12 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_d=
evices *fs_devices,
>   	return -EINVAL;
>   }
>
> -static u8 *btrfs_sb_metadata_uuid_or_null(struct btrfs_super_block *sb)
> +static u8 *btrfs_sb_metadata_uuid_single_dev(struct btrfs_super_block *=
sb,
> +					     bool has_metadata_uuid,
> +					     bool single_dev)
>   {
> -	bool has_metadata_uuid =3D (btrfs_super_incompat_flags(sb) &
> -				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> +	if (has_metadata_uuid || single_dev)
> +		return sb->metadata_uuid;
>
> -	return has_metadata_uuid ? sb->metadata_uuid : NULL;
> +	return NULL;
>   }
>
>   u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
> @@ -775,8 +777,36 @@ static struct btrfs_fs_devices *find_fsid_reverted_=
metadata(
>
>   	return NULL;
>   }
> +
> +static void prepare_virtual_fsid(struct btrfs_super_block *disk_super,
> +				 const char *path)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +	u8 vfsid[BTRFS_FSID_SIZE];
> +	bool dup_fsid =3D true;
> +
> +	while (dup_fsid) {
> +		dup_fsid =3D false;
> +		generate_random_uuid(vfsid);
> +
> +		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
> +			    !memcmp(vfsid, fs_devices->metadata_uuid,
> +				    BTRFS_FSID_SIZE))
> +				dup_fsid =3D true;
> +		}
> +	}
> +
> +	memcpy(disk_super->metadata_uuid, disk_super->fsid, BTRFS_FSID_SIZE);
> +	memcpy(disk_super->fsid, vfsid, BTRFS_FSID_SIZE);
> +
> +	pr_info("BTRFS: virtual fsid (%pU) set for SINGLE_DEV device %s (real =
fsid %pU)\n",
> +		disk_super->fsid, path, disk_super->metadata_uuid);
> +}
> +
>   /*
> - * Add new device to list of registered devices
> + * Add new device to list of registered devices, or in case of a SINGLE=
_DEV
> + * device, also creates a virtual fsid to cope with same-fsid cases.
>    *
>    * Returns:
>    * device pointer which was just added or updated when successful
> @@ -784,7 +814,7 @@ static struct btrfs_fs_devices *find_fsid_reverted_m=
etadata(
>    */
>   static noinline struct btrfs_device *device_list_add(const char *path,
>   			   struct btrfs_super_block *disk_super,
> -			   bool *new_device_added)
> +			   bool *new_device_added, bool single_dev)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *fs_devices =3D NULL;
> @@ -805,23 +835,32 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
>   		return ERR_PTR(error);
>   	}
>
> -	if (fsid_change_in_progress) {
> -		if (!has_metadata_uuid)
> -			fs_devices =3D find_fsid_inprogress(disk_super);
> -		else
> -			fs_devices =3D find_fsid_changed(disk_super);
> -	} else if (has_metadata_uuid) {
> -		fs_devices =3D find_fsid_with_metadata_uuid(disk_super);
> +	if (single_dev) {
> +		if (has_metadata_uuid || fsid_change_in_progress) {
> +			btrfs_err(NULL,
> +		"SINGLE_DEV devices don't support the metadata_uuid feature\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		prepare_virtual_fsid(disk_super, path);
>   	} else {
> -		fs_devices =3D find_fsid_reverted_metadata(disk_super);
> -		if (!fs_devices)
> -			fs_devices =3D find_fsid(disk_super->fsid, NULL);
> +		if (fsid_change_in_progress) {
> +			if (!has_metadata_uuid)
> +				fs_devices =3D find_fsid_inprogress(disk_super);
> +			else
> +				fs_devices =3D find_fsid_changed(disk_super);
> +		} else if (has_metadata_uuid) {
> +			fs_devices =3D find_fsid_with_metadata_uuid(disk_super);
> +		} else {
> +			fs_devices =3D find_fsid_reverted_metadata(disk_super);
> +			if (!fs_devices)
> +				fs_devices =3D find_fsid(disk_super->fsid, NULL);
> +		}
>   	}
>
> -
>   	if (!fs_devices) {
>   		fs_devices =3D alloc_fs_devices(disk_super->fsid,
> -				btrfs_sb_metadata_uuid_or_null(disk_super));
> +				btrfs_sb_metadata_uuid_single_dev(disk_super,
> +							has_metadata_uuid, single_dev));
>   		if (IS_ERR(fs_devices))
>   			return ERR_CAST(fs_devices);
>
> @@ -1365,13 +1404,15 @@ int btrfs_forget_devices(dev_t devt)
>    * and we are not allowed to call set_blocksize during the scan. The s=
uperblock
>    * is read via pagecache
>    */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t=
 flags)
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t=
 flags,
> +					   bool mounting)
>   {
>   	struct btrfs_super_block *disk_super;
>   	bool new_device_added =3D false;
>   	struct btrfs_device *device =3D NULL;
>   	struct block_device *bdev;
>   	u64 bytenr, bytenr_orig;
> +	bool single_dev;
>   	int ret;
>
>   	lockdep_assert_held(&uuid_mutex);
> @@ -1410,7 +1451,17 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags)
>   		goto error_bdev_put;
>   	}
>
> -	device =3D device_list_add(path, disk_super, &new_device_added);
> +	single_dev =3D btrfs_super_compat_ro_flags(disk_super) &
> +			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
> +
> +	if (!mounting && single_dev) {
> +		pr_info("BTRFS: skipped non-mount scan on SINGLE_DEV device %s\n",
> +			path);
> +		btrfs_release_disk_super(disk_super);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	device =3D device_list_add(path, disk_super, &new_device_added, single=
_dev);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>
> @@ -2406,6 +2457,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_=
info *fs_info,
>
>   	args->devid =3D btrfs_stack_device_id(&disk_super->dev_item);
>   	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
> +
> +	/*
> +	 * Note that SINGLE_DEV devices are not handled in a special way here;
> +	 * device removal/replace is instead forbidden when such feature is
> +	 * present, this note is for future users/readers of this function.
> +	 */
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
>   		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   	else
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 0f87057bb575..b9856c801567 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -611,7 +611,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct =
btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       blk_mode_t flags, void *holder);
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t=
 flags);
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t=
 flags,
> +					   bool mounting);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>   void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dbb8b96da50d..cb7a7cfe1ea9 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -313,6 +313,13 @@ struct btrfs_ioctl_fs_info_args {
>    */
>   #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
>
> +/*
> + * Single devices (as flagged by the corresponding compat_ro flag) only
> + * gets scanned during mount time; also, a random fsid is generated for
> + * them, in order to cope with same-fsid filesystem mounts.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV		(1ULL << 4)
> +
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
>   #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
