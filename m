Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1246F7DB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjEEHWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjEEHWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 03:22:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9414199E;
        Fri,  5 May 2023 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683271307; i=quwenruo.btrfs@gmx.com;
        bh=Ua8WC2BUxUqAgMT78unISm2tSaKdJS+g9wIqWnr3kFA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=TENCoJ+7Fvi7T13Z4h6twUin8NjOuqtA3ZRXDkbV6xRzq1/Hl+DMl2L19je44mEvi
         5BO3703DLzoOjzcNornqtx0b1g/N8g5RQGiJcHh/AMmIR1OdPl5+ro3w24D/08PgxV
         Zed1o9bOZRed80IKo/ao3hpn6TAg1591IMwuuZ8Up0rUsh/IsHgR1EUbwU14FxkJD/
         WvH+3ORcHZMsL7S3qaerZGpbLvZiSttbU86qQoNLEMlwY0hCETL4wkzBzNqvyoTeiX
         p8z+vxy8ZfBf5exJ0oWTOsQ36cVeKR8SADcJ3vvNGYyheiIk+nzROh3TWOF7ArR0if
         9z0hwGw8NLKIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1pgaB40avM-00VyFf; Fri, 05
 May 2023 09:21:47 +0200
Message-ID: <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
Date:   Fri, 5 May 2023 15:21:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
In-Reply-To: <20230504170708.787361-2-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9xTdaomyO0Jw/wo39CUWdErI60iVx8UFof29upDninErc6RnKq
 aTv32V4Ggjp6TJTFrj76dcjkjBq2ZDJBfBJL0upbsGoXHJy0F03rX7FiYbM3sI91TgpOMuB
 y0+u5Ttlvy0DUO2FM2TWAjZrmZOtVHLtieQsj1jfUiDqjWH7TyTlxQRTaUmW8cIy9h9jV2S
 8CgsqZpVtweLjKzBjlqjg==
UI-OutboundReport: notjunk:1;M01:P0:YEZhlCEFX7c=;PbS0DviQmqFLYiUiVvQ91HMRiRW
 wCS1xJEz2sVTqckudcZTC4dFk8+wU08JeHUANTVPkE/8oIa5MYjBOBsaCC+4BmnyBOIgYdvxZ
 3wGrIM+MBbiFQ8/PLXV5gs+8NqIEresXezl5P/EmeJvZtGMNV/weZ1zYSbvFZwbO7V3GN9P3y
 aV2V09gTas0hyJbLKAXDkbJJ0K5uWCXusnrEMyDV9IxXeJ/x/OOnxy2c62+FH8rpEj/cllVDJ
 gInBI0IidjcjTIHDXXmsW+7L3myZDITC17mMF0B8ttQoARG6vEzNGt63xBiQnP9nvMz6JZlf6
 AFaeRlAWhibVQin4UkJSmZj2TPjpdyQF1BnlpvJOt3LwG2ZV0S/1hR1zNWH/LQ5WAO9NHMoTv
 SkUju6yYTJULMqsp9OUPXGSl5m+zCxxAMQMeH/agLeanR6Rmsg4DjJzXQIFcl9lx7/LSjZR9X
 L9b9pZ5HpzfQjIZ8/xQ/V+vM8m8bPZ9/eDucCGa8UVDYd5skVvjBKACIJNTV5+MjfBdceD6Y9
 tyCRTpNqSJok8kp7CryRmBMx1OcZOn+tIR0UD2NkbxbgxYPnlbD0ZlgWJyhk2onboY5LHeuk4
 58/PGhIFp3V1PpLY1g4UvkrqN3dDGKXwu6WmgPAA8YG9gPXtJVqchdQWR5GIR4Q4d+XyMynyp
 101TO9q2dkImxgdWtXe9g/Lc/8jUsXMNmyzUs0QEVCfEci1oDSd8f7FDnxHpu9KemUCHvaGgG
 ARTeRHlR+SCvmK/Xbs8YzQdRT0N2T46WLBaX+25D11wf8ym1OeDA85DEs1Iw+mqAOy33k3eRF
 7Q69lKtOpSa2/ILAS2lgQr7LCtZOTfjdH4ETbUHAL12UjHfUIkHi3Yw3b0A9tk1Hh8vsJu9iN
 9dVXG7nOci9RFvR0SW69BWmUSy6MDNBgvW0FWVLXRx//1vMgPXwGVsgY0r/8pu+zti12xx0nu
 iP/W3ZkMso7d+nxoT7ba0ZvaiG4=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/5 01:07, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is used as a unique identifier in the driver.
> This case is supported though in some other common filesystems, like
> ext4; one of the reasons for which is not trivial supporting this case
> on btrfs is due to its multi-device filesystem nature, native RAID, etc.

Exactly, the biggest problem is the multi-device support.

Btrfs needs to search and assemble all devices of a multi-device
filesystem, which is normally handled by things like LVM/DMraid, thus
other traditional fses won't need to bother that.

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
> mount option "virtual_fsid" - when such option is used, btrfs generates
> a random fsid for the filesystem and leverages the metadata_uuid
> infrastructure (introduced by [0]) to enable the usage of this secondary
> virtual fsid. But differently from the regular metadata_uuid flag, this
> is not written into the disk superblock - effectively, this is a spoofed
> fsid approach that enables the same filesystem in different devices to
> appear as different filesystems to btrfs on runtime.

I would prefer a much simpler but more explicit method.

Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.

By this, we can avoid multiple meanings of the same super member, nor
need any special mount option.
Remember, mount option is never a good way to enable/disable a new feature=
.

The better method to enable/disable a feature should be mkfs and btrfstune=
.

Then go mostly the same of your patch, but maybe with something extra:

- Disbale multi-dev code
   Include device add/replace/removal, this is already done in your
   patch.

- Completely skip device scanning
   I see no reason to keep btrfs with SINGLE_DEV feature to be added to
   the device list at all.
   It only needs to be scanned at mount time, and never be kept in the
   in-memory device list.

Thanks,
Qu

>
> In order to prevent more code complexity and potential corner cases,
> given the usage is aimed to single-devices / partitions, virtual_fsid
> is not allowed when the metadata_uuid flag is already present on the fs,
> or if the device is on fsid-change state. Device removal/replace is also
> disabled for devices mounted with the virtual_fsid option.
>
> [0] 7239ff4b2be8 ("btrfs: Introduce support for FSID change without meta=
data rewrite)
>
> Cc: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>
> ---
>
> Hi folks, first of all thanks in advance for reviews / suggestions!
> Some design choices that worth a discussion:
>
> (1) The first choice was for the random fsid versus user-passed id.
> Initially we considered that the flag could be "virtual_fsid=3D%s", henc=
e
> userspace would be responsible to generate the fsid. But seems the
> collision probability of fsids in near zero, also the random code
> hereby proposed checks if any other fsid/metadata_uuid present in
> the btrfs structures is a match, and if so, new random uuids are
> created until they prove the unique within btrfs.
>
> (2) About disabling device removal/replace: these cases could be
> handled I guess, but with increased code complexity. If there is a
> need for that, we could implement. Also worth mentioning that any
> advice is appreciated with regards to potential incompatibilities
> between "virtual_fsid" and any other btrfs feature / mount option.
>
> (3) There is no proposed documentation about the "virtual_fsid" here;
> seems the kernel docs points to a wiki page, so appreciate suggestions
> on how to edit such wiki and how to coordinate this with the patch
> development cycle.
>
>
>   fs/btrfs/disk-io.c | 22 ++++++++++--
>   fs/btrfs/ioctl.c   | 18 ++++++++++
>   fs/btrfs/super.c   | 32 +++++++++++------
>   fs/btrfs/volumes.c | 86 +++++++++++++++++++++++++++++++++++++++-------
>   fs/btrfs/volumes.h |  8 ++++-
>   5 files changed, 139 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9e1596bb208d..66c2bac343b8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -468,7 +468,8 @@ static int check_tree_block_fsid(struct extent_buffe=
r *eb)
>   	 * seed devices it's forbidden to have their uuid changed so reading
>   	 * ->fsid in this case is fine
>   	 */
> -	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
> +	if (btrfs_fs_incompat(fs_info, METADATA_UUID) ||
> +	    fs_devices->virtual_fsid)
>   		metadata_uuid =3D fs_devices->metadata_uuid;
>   	else
>   		metadata_uuid =3D fs_devices->fsid;
> @@ -2539,6 +2540,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_=
info,
>   {
>   	u64 nodesize =3D btrfs_super_nodesize(sb);
>   	u64 sectorsize =3D btrfs_super_sectorsize(sb);
> +	u8 *fsid;
>   	int ret =3D 0;
>
>   	if (btrfs_super_magic(sb) !=3D BTRFS_MAGIC) {
> @@ -2619,8 +2621,22 @@ int btrfs_validate_super(struct btrfs_fs_info *fs=
_info,
>   		ret =3D -EINVAL;
>   	}
>
> -	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
> -		   BTRFS_FSID_SIZE)) {
> +	/*
> +	 * When the virtual_fsid flag is passed at mount time, btrfs
> +	 * creates a random fsid and makes use of the metadata_uuid
> +	 * infrastructure in order to allow, for example, two devices
> +	 * with same fsid getting mounted at the same time. But notice
> +	 * no changes happen at the disk level, so the random fsid is a
> +	 * driver abstraction for that single mount, not to be written
> +	 * in the disk. That's the reason we're required here to compare
> +	 * the fsid with the metadata_uuid if virtual_fsid was set.
> +	 */
> +	if (fs_info->fs_devices->virtual_fsid)
> +		fsid =3D fs_info->fs_devices->metadata_uuid;
> +	else
> +		fsid =3D fs_info->fs_devices->fsid;
> +
> +	if (memcmp(fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE)) {
>   		btrfs_err(fs_info,
>   		"superblock fsid doesn't match fsid of fs_devices: %pU !=3D %pU",
>   			fs_info->super_copy->fsid, fs_info->fs_devices->fsid);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ba769a1eb87a..35e3a23f8c83 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2677,6 +2677,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *fi=
le, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> +	if (fs_info->fs_devices->virtual_fsid) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on devices mounted with virtual fsi=
d\n");
> +		return -EINVAL;
> +	}
> +
>   	vol_args =3D memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -2743,6 +2749,12 @@ static long btrfs_ioctl_rm_dev(struct file *file,=
 void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> +	if (fs_info->fs_devices->virtual_fsid) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on devices mounted with virtual fsi=
d\n");
> +		return -EINVAL;
> +	}
> +
>   	vol_args =3D memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -3261,6 +3273,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_=
fs_info *fs_info,
>   		return -EINVAL;
>   	}
>
> +	if (fs_info->fs_devices->virtual_fsid) {
> +		btrfs_err(fs_info,
> +			  "device replace is unsupported on devices mounted with virtual fsi=
d\n");
> +		return -EINVAL;
> +	}
> +
>   	p =3D memdup_user(arg, sizeof(*p));
>   	if (IS_ERR(p))
>   		return PTR_ERR(p);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 366fb4cde145..8d9df169107a 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -115,6 +115,7 @@ enum {
>   	Opt_thread_pool,
>   	Opt_treelog, Opt_notreelog,
>   	Opt_user_subvol_rm_allowed,
> +	Opt_virtual_fsid,
>
>   	/* Rescue options */
>   	Opt_rescue,
> @@ -188,6 +189,7 @@ static const match_table_t tokens =3D {
>   	{Opt_treelog, "treelog"},
>   	{Opt_notreelog, "notreelog"},
>   	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
> +	{Opt_virtual_fsid, "virtual_fsid"},
>
>   	/* Rescue options */
>   	{Opt_rescue, "rescue=3D%s"},
> @@ -352,9 +354,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info,=
 char *options,
>   		case Opt_subvol_empty:
>   		case Opt_subvolid:
>   		case Opt_device:
> +		case Opt_virtual_fsid:
>   			/*
>   			 * These are parsed by btrfs_parse_subvol_options or
> -			 * btrfs_parse_device_options and can be ignored here.
> +			 * btrfs_parse_early_options and can be ignored here.
>   			 */
>   			break;
>   		case Opt_nodatasum:
> @@ -845,9 +848,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info,=
 char *options,
>    * All other options will be parsed on much later in the mount process=
 and
>    * only when we need to allocate a new super block.
>    */
> -static int btrfs_parse_device_options(const char *options, fmode_t flag=
s,
> -				      void *holder)
> +static int btrfs_parse_early_options(const char *options, fmode_t flags=
,
> +				    bool *virtual_fsid, void *holder)
>   {
> +	struct btrfs_scan_info info =3D { .vfsid =3D false };
>   	substring_t args[MAX_OPT_ARGS];
>   	char *device_name, *opts, *orig, *p;
>   	struct btrfs_device *device =3D NULL;
> @@ -874,14 +878,18 @@ static int btrfs_parse_device_options(const char *=
options, fmode_t flags,
>   			continue;
>
>   		token =3D match_token(p, tokens, args);
> +
> +		if (token =3D=3D Opt_virtual_fsid)
> +			(*virtual_fsid) =3D true;
> +
>   		if (token =3D=3D Opt_device) {
>   			device_name =3D match_strdup(&args[0]);
>   			if (!device_name) {
>   				error =3D -ENOMEM;
>   				goto out;
>   			}
> -			device =3D btrfs_scan_one_device(device_name, flags,
> -					holder);
> +			info.path =3D device_name;
> +			device =3D btrfs_scan_one_device(&info, flags, holder);
>   			kfree(device_name);
>   			if (IS_ERR(device)) {
>   				error =3D PTR_ERR(device);
> @@ -913,7 +921,7 @@ static int btrfs_parse_subvol_options(const char *op=
tions, char **subvol_name,
>
>   	/*
>   	 * strsep changes the string, duplicate it because
> -	 * btrfs_parse_device_options gets called later
> +	 * btrfs_parse_early_options gets called later
>   	 */
>   	opts =3D kstrdup(options, GFP_KERNEL);
>   	if (!opts)
> @@ -1431,6 +1439,7 @@ static struct dentry *mount_subvol(const char *sub=
vol_name, u64 subvol_objectid,
>   static struct dentry *btrfs_mount_root(struct file_system_type *fs_typ=
e,
>   		int flags, const char *device_name, void *data)
>   {
> +	struct btrfs_scan_info info =3D { .path =3D NULL, .vfsid =3D false};
>   	struct block_device *bdev =3D NULL;
>   	struct super_block *s;
>   	struct btrfs_device *device =3D NULL;
> @@ -1472,13 +1481,14 @@ static struct dentry *btrfs_mount_root(struct fi=
le_system_type *fs_type,
>   	}
>
>   	mutex_lock(&uuid_mutex);
> -	error =3D btrfs_parse_device_options(data, mode, fs_type);
> +	error =3D btrfs_parse_early_options(data, mode, &info.vfsid, fs_type);
>   	if (error) {
>   		mutex_unlock(&uuid_mutex);
>   		goto error_fs_info;
>   	}
>
> -	device =3D btrfs_scan_one_device(device_name, mode, fs_type);
> +	info.path =3D device_name;
> +	device =3D btrfs_scan_one_device(&info, mode, fs_type);
>   	if (IS_ERR(device)) {
>   		mutex_unlock(&uuid_mutex);
>   		error =3D PTR_ERR(device);
> @@ -2169,6 +2179,7 @@ static int btrfs_control_open(struct inode *inode,=
 struct file *file)
>   static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   				unsigned long arg)
>   {
> +	struct btrfs_scan_info info =3D { .vfsid =3D false };
>   	struct btrfs_ioctl_vol_args *vol;
>   	struct btrfs_device *device =3D NULL;
>   	dev_t devt =3D 0;
> @@ -2182,10 +2193,11 @@ static long btrfs_control_ioctl(struct file *fil=
e, unsigned int cmd,
>   		return PTR_ERR(vol);
>   	vol->name[BTRFS_PATH_NAME_MAX] =3D '\0';
>
> +	info.path =3D vol->name;
>   	switch (cmd) {
>   	case BTRFS_IOC_SCAN_DEV:
>   		mutex_lock(&uuid_mutex);
> -		device =3D btrfs_scan_one_device(vol->name, FMODE_READ,
> +		device =3D btrfs_scan_one_device(&info, FMODE_READ,
>   					       &btrfs_root_fs_type);
>   		ret =3D PTR_ERR_OR_ZERO(device);
>   		mutex_unlock(&uuid_mutex);
> @@ -2200,7 +2212,7 @@ static long btrfs_control_ioctl(struct file *file,=
 unsigned int cmd,
>   		break;
>   	case BTRFS_IOC_DEVICES_READY:
>   		mutex_lock(&uuid_mutex);
> -		device =3D btrfs_scan_one_device(vol->name, FMODE_READ,
> +		device =3D btrfs_scan_one_device(&info, FMODE_READ,
>   					       &btrfs_root_fs_type);
>   		if (IS_ERR(device)) {
>   			mutex_unlock(&uuid_mutex);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c6d592870400..5a38b3482ec5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -745,6 +745,33 @@ static struct btrfs_fs_devices *find_fsid_reverted_=
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
> +	pr_info("BTRFS: virtual fsid (%pU) set for device %s (real fsid %pU)\n=
",
> +		disk_super->fsid, path, disk_super->metadata_uuid);
> +}
> +
>   /*
>    * Add new device to list of registered devices
>    *
> @@ -752,12 +779,15 @@ static struct btrfs_fs_devices *find_fsid_reverted=
_metadata(
>    * device pointer which was just added or updated when successful
>    * error pointer when failed
>    */
> -static noinline struct btrfs_device *device_list_add(const char *path,
> -			   struct btrfs_super_block *disk_super,
> -			   bool *new_device_added)
> +static noinline
> +struct btrfs_device *device_list_add(const struct btrfs_scan_info *info=
,
> +				     struct btrfs_super_block *disk_super,
> +				     bool *new_device_added)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *fs_devices =3D NULL;
> +	const char *path =3D info->path;
> +	const bool virtual_fsid =3D info->vfsid;
>   	struct rcu_string *name;
>   	u64 found_transid =3D btrfs_super_generation(disk_super);
>   	u64 devid =3D btrfs_stack_device_id(&disk_super->dev_item);
> @@ -775,12 +805,25 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
>   		return ERR_PTR(error);
>   	}
>
> +	if (virtual_fsid) {
> +		if (has_metadata_uuid || fsid_change_in_progress) {
> +			btrfs_err(NULL,
> +			  "failed to add device %s with virtual fsid (%s)\n",
> +				  path, (has_metadata_uuid ?
> +					 "the fs already has a metadata_uuid" :
> +					 "fsid change in progress"));
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		prepare_virtual_fsid(disk_super, path);
> +	}
> +
>   	if (fsid_change_in_progress) {
>   		if (!has_metadata_uuid)
>   			fs_devices =3D find_fsid_inprogress(disk_super);
>   		else
>   			fs_devices =3D find_fsid_changed(disk_super);
> -	} else if (has_metadata_uuid) {
> +	} else if (has_metadata_uuid || virtual_fsid) {
>   		fs_devices =3D find_fsid_with_metadata_uuid(disk_super);
>   	} else {
>   		fs_devices =3D find_fsid_reverted_metadata(disk_super);
> @@ -790,7 +833,7 @@ static noinline struct btrfs_device *device_list_add=
(const char *path,
>
>
>   	if (!fs_devices) {
> -		if (has_metadata_uuid)
> +		if (has_metadata_uuid || virtual_fsid)
>   			fs_devices =3D alloc_fs_devices(disk_super->fsid,
>   						      disk_super->metadata_uuid);
>   		else
> @@ -799,6 +842,7 @@ static noinline struct btrfs_device *device_list_add=
(const char *path,
>   		if (IS_ERR(fs_devices))
>   			return ERR_CAST(fs_devices);
>
> +		fs_devices->virtual_fsid =3D virtual_fsid;
>   		fs_devices->fsid_change =3D fsid_change_in_progress;
>
>   		mutex_lock(&fs_devices->device_list_mutex);
> @@ -870,11 +914,21 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
>   	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)=
\n",
>   				disk_super->label, devid, found_transid, path,
>   				current->comm, task_pid_nr(current));
> -		else
> -			pr_info(
> +		else {
> +			if (virtual_fsid)
> +				pr_info(
> +"BTRFS: device with virtual fsid %pU (real fsid %pU) devid %llu transid=
 %llu %s scanned by %s (%d)\n",
> +					disk_super->fsid,
> +					disk_super->metadata_uuid, devid,
> +					found_transid, path, current->comm,
> +					task_pid_nr(current));
> +			else
> +				pr_info(
>   	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)=
\n",
> -				disk_super->fsid, devid, found_transid, path,
> -				current->comm, task_pid_nr(current));
> +					disk_super->fsid, devid, found_transid,
> +					path, current->comm,
> +					task_pid_nr(current));
> +		}
>
>   	} else if (!device->name || strcmp(device->name->str, path)) {
>   		/*
> @@ -1348,8 +1402,8 @@ int btrfs_forget_devices(dev_t devt)
>    * and we are not allowed to call set_blocksize during the scan. The s=
uperblock
>    * is read via pagecache
>    */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t fl=
ags,
> -					   void *holder)
> +struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info=
 *info,
> +					   fmode_t flags, void *holder)
>   {
>   	struct btrfs_super_block *disk_super;
>   	bool new_device_added =3D false;
> @@ -1377,7 +1431,7 @@ struct btrfs_device *btrfs_scan_one_device(const c=
har *path, fmode_t flags,
>   	 * values temporarily, as the device paths of the fsid are the only
>   	 * required information for assembling the volume.
>   	 */
> -	bdev =3D blkdev_get_by_path(path, flags, holder);
> +	bdev =3D blkdev_get_by_path(info->path, flags, holder);
>   	if (IS_ERR(bdev))
>   		return ERR_CAST(bdev);
>
> @@ -1394,7 +1448,7 @@ struct btrfs_device *btrfs_scan_one_device(const c=
har *path, fmode_t flags,
>   		goto error_bdev_put;
>   	}
>
> -	device =3D device_list_add(path, disk_super, &new_device_added);
> +	device =3D device_list_add(info, disk_super, &new_device_added);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>
> @@ -2390,6 +2444,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_=
info *fs_info,
>
>   	args->devid =3D btrfs_stack_device_id(&disk_super->dev_item);
>   	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
> +
> +	/*
> +	 * Notice that the virtual_fsid feature is not handled here; device
> +	 * removal/replace is instead forbidden when such feature is in-use,
> +	 * but this note is for future users of btrfs_get_dev_args_from_path()=
.
> +	 */
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
>   		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   	else
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 7e51f2238f72..f2354e8288f9 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -73,6 +73,11 @@ enum btrfs_raid_types {
>   #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>   #define BTRFS_DEV_STATE_NO_READA	(5)
>
> +struct btrfs_scan_info {
> +	const char *path;
> +	bool vfsid;
> +};
> +
>   struct btrfs_zoned_device_info;
>
>   struct btrfs_device {
> @@ -278,6 +283,7 @@ struct btrfs_fs_devices {
>   	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
>   	bool fsid_change;
> +	bool virtual_fsid;
>   	struct list_head fs_list;
>
>   	/*
> @@ -537,7 +543,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct =
btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       fmode_t flags, void *holder);
> -struct btrfs_device *btrfs_scan_one_device(const char *path,
> +struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info=
 *info,
>   					   fmode_t flags, void *holder);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
