Return-Path: <linux-fsdevel+bounces-59934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBBB3F4B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C9D173E31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537982E1749;
	Tue,  2 Sep 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WWal+LLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0641E5B71
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791882; cv=none; b=L8Qt5j0cgkVkbzwLxldBUALuOySxwslBZAbb+nilrZsVHQlPYboUIqLv0KNeW/1CiXUvHzoxzxwF0xIYVfzaeq0R/KO2xl6dH2vLQszE6XdKZ3pSFBi32bwHqYXykxuu8o/lZB1Op3cAocETb96cHsEjEkeI6SC0x6glu1RqKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791882; c=relaxed/simple;
	bh=kReW8+vlowvQuNUNtCkvGfwRgH4bJjMGtbP3iw6ytYw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=dPyiqGEXbDpRdTEdWv7Z2T9izmCeOFV6HZxqmhlb1jTrufnOVjV5RvYGDExhwjA3s7VQcUmiZcNg1w8VWyNEFww7Ip6WtQohtgsjyXjL3Nx8IQeAFSgYpWKTxrpWNh3QzKoJT1dHjOlwNNLOUdtoipshTSSz8K41LLb5Prmxjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WWal+LLy; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250902054437epoutp047018afca8e9ae83b9212830d9356e52c~hYOex7qYf0292102921epoutp04o
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 05:44:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250902054437epoutp047018afca8e9ae83b9212830d9356e52c~hYOex7qYf0292102921epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756791877;
	bh=61yoeEEkUHQGyMAppsO7aMM35CSfOq9H04h90+v+208=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=WWal+LLyijUWaVeyoAVvh2FutjZqTIko1k6zODDNJgaGf8mNOwGcRh0y3f+P2Yj+5
	 mrbQbj64UBn+vOAKXn1GurGnUqE0g6iS4imkcJU2r5uA04w/CetGv4qV/hbe5w3126
	 clzzaWyyTrKvN4q33jjr8mk0o3Mt1OlELZ98Ef2g=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20250902054437epcas1p11b9bb6c7032e00f7cee850aa7a9b7ad4~hYOeVQlN-2008320083epcas1p1z;
	Tue,  2 Sep 2025 05:44:37 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.249]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGF786rrRz3hhTL; Tue,  2 Sep
	2025 05:44:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20250902054436epcas1p39750ecfebd5abff3d74fab591153d1b2~hYOdWMjlj2944829448epcas1p3U;
	Tue,  2 Sep 2025 05:44:36 +0000 (GMT)
Received: from [172.25.92.0] (unknown [10.253.99.103]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250902054436epsmtip2e3292f7b85db5120c78dbf43d0eaf2b6~hYOdPwtFP3242032420epsmtip2Z;
	Tue,  2 Sep 2025 05:44:36 +0000 (GMT)
Message-ID: <4bacbb26-01b4-4d42-b59b-36fc6ff8fc75@samsung.com>
Date: Tue, 2 Sep 2025 14:44:36 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: [PATCH v4 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: cpgs@samsung.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuezhang.mo@sony.com, Sungjong Seo
	<sj1557.seo@samsung.com>
Content-Language: en-US
In-Reply-To: <20250901180201.509218-1-ethan.ferguson@zetier.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250902054436epcas1p39750ecfebd5abff3d74fab591153d1b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250901180210epcas1p2545fc89d9d2e3d4fec12c5684c70ad9b
References: <000001dc1a5c$aaac6350$000529f0$@samsung.com>
	<CGME20250901180210epcas1p2545fc89d9d2e3d4fec12c5684c70ad9b@epcas1p2.samsung.com>
	<20250901180201.509218-1-ethan.ferguson@zetier.com>



On 25. 9. 2. 03:02, Ethan Ferguson wrote:
> On 8/31/25 05:50, Sungjong Seo wrote:
>> Hi,
>>> Add support for reading / writing to the exfat volume label from the
>>> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
>>>
>>> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
>>> ---
>>>  fs/exfat/exfat_fs.h  |   5 +
>>>  fs/exfat/exfat_raw.h |   6 ++
>>>  fs/exfat/file.c      |  88 +++++++++++++++++
>>>  fs/exfat/super.c     | 224 +++++++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 323 insertions(+)
>>>
>>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>>> index f8ead4d47ef0..ed4b5ecb952b 100644
>>> --- a/fs/exfat/exfat_fs.h
>>> +++ b/fs/exfat/exfat_fs.h
>>> @@ -267,6 +267,7 @@ struct exfat_sb_info {
>>>  	struct buffer_head **vol_amap; /* allocation bitmap */
>>>
>>>  	unsigned short *vol_utbl; /* upcase table */
>>> +	unsigned short *volume_label; /* volume name */
>> Why is it necessary to allocate and cache it? I didn't find where to reuse
>> it.
>> Is there a reason why uniname is not used directly as an argument?
>> Is there something I missed?
>>
> I thought it might be prudent to store it in the sbi, in case other
> patches in the future might want to use the volume label. However, since
> this is not necessary, I can remove it if needed.
> 
> I chose not to use a uniname, as that would require allocating lots of
> data, when the maximum amount of bytes present in a volume label is 22.
> 

What I meant was that since uniname is already assigned within the new
ioctl, I think we can use it right away. Anyway, this variable in
sbi right now seems unnecessary.

>>>
>>>  	unsigned int clu_srch_ptr; /* cluster search pointer */
>>>  	unsigned int used_clusters; /* number of used clusters */
>>> @@ -431,6 +432,10 @@ static inline loff_t exfat_ondisk_size(const struct
>>> inode *inode)
[snip[
>>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
>>> index 538d2b6ac2ec..970e3ee57c43 100644
>>> --- a/fs/exfat/file.c
>>> +++ b/fs/exfat/file.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/security.h>
>>>  #include <linux/msdos_fs.h>
>>>  #include <linux/writeback.h>
>>> +#include "../nls/nls_ucs2_utils.h"
>>>
>>>  #include "exfat_raw.h"
>>>  #include "exfat_fs.h"
>>> @@ -486,10 +487,93 @@ static int exfat_ioctl_shutdown(struct super_block
>>> *sb, unsigned long arg)
>>>  	return exfat_force_shutdown(sb, flags);
>>>  }
>>>
>>> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned
>>> long arg)
>>> +{
>>> +	int ret;
>>> +	char utf8[FSLABEL_MAX] = {0};
>>> +	struct exfat_uni_name *uniname;
>>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>>> +
>>> +	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
>>> +	if (!uniname)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = exfat_read_volume_label(sb);
>>> +	if (ret < 0)
>>> +		goto cleanup;
>>> +
>>> +	memcpy(uniname->name, sbi->volume_label,
>>> +	       EXFAT_VOLUME_LABEL_LEN * sizeof(short));
>>> +	uniname->name[EXFAT_VOLUME_LABEL_LEN] = 0x0000;
>>> +	uniname->name_len = UniStrnlen(uniname->name,
>>> EXFAT_VOLUME_LABEL_LEN);
>> The volume label length is stored on-disk. It makes sense to retrieve
>> it directly. This way, there is no need to unnecessarily include the 
>> NLS utility header file.
>>
> That's true, given I'll be removing the volume_label field from the
> superblock info struct, I can rework this function to output to a
> uniname struct.
>>> +
>>> +	ret = exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);
>>> +	if (ret < 0)
>>> +		goto cleanup;
>>> +
>>> +	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {
>>> +		ret = -EFAULT;
>>> +		goto cleanup;
>>> +	}
>>> +
>>> +	ret = 0;
>>> +
>>> +cleanup:
>>> +	kfree(uniname);
>>> +	return ret;
>>> +}
>>> +
>>> +static int exfat_ioctl_set_volume_label(struct super_block *sb,
>>> +					unsigned long arg,
>>> +					struct inode *root_inode)
>>> +{
>>> +	int ret, lossy;
>>> +	char utf8[FSLABEL_MAX];
>>> +	struct exfat_uni_name *uniname;
>>> +
>>> +	if (!capable(CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>> +
>>> +	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
>>> +	if (!uniname)
>>> +		return -ENOMEM;
>>> +
>>> +	if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {
>>> +		ret = -EFAULT;
>>> +		goto cleanup;
>>> +	}
>>> +
>>> +	if (utf8[0]) {
>>> +		ret = exfat_nls_to_utf16(sb, utf8, strnlen(utf8,
>>> FSLABEL_MAX),
>>> +					 uniname, &lossy);
>>> +		if (ret < 0)
>>> +			goto cleanup;
>>> +		else if (lossy & NLS_NAME_LOSSY) {
>>> +			ret = -EINVAL;
>>> +			goto cleanup;
>>> +		}
>>> +	} else {
>>> +		uniname->name[0] = 0x0000;
>>> +		uniname->name_len = 0;
>>> +	}
>>> +
>>> +	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
>>> +		exfat_info(sb, "Volume label length too long, truncating");
>>> +		uniname->name_len = EXFAT_VOLUME_LABEL_LEN;
>>> +	}
>>> +
>>> +	ret = exfat_write_volume_label(sb, uniname, root_inode);
>>> +
>>> +cleanup:
>>> +	kfree(uniname);
>>> +	return ret;
>>> +}
>>> +
>>>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>  {
>>>  	struct inode *inode = file_inode(filp);
>>>  	u32 __user *user_attr = (u32 __user *)arg;
>>> +	struct inode *root_inode = filp->f_path.mnt->mnt_root->d_inode;
>> From this point, there is no need to pass root_inode. The root_inode can be
>> obtained directly from sb->s_root->d_inode within the function.
>>
> Must have missed that, thank you!
>>>
>>>  	switch (cmd) {
>>>  	case FAT_IOCTL_GET_ATTRIBUTES:
>>> @@ -500,6 +584,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd,
>>> unsigned long arg)
>>>  		return exfat_ioctl_shutdown(inode->i_sb, arg);
>>>  	case FITRIM:
>>>  		return exfat_ioctl_fitrim(inode, arg);
>>> +	case FS_IOC_GETFSLABEL:
>>> +		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
>>> +	case FS_IOC_SETFSLABEL:
>>> +		return exfat_ioctl_set_volume_label(inode->i_sb, arg,
>>> root_inode);
>>>  	default:
>>>  		return -ENOTTY;
>>>  	}
>>> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
>>> index 8926e63f5bb7..7931cdb4a1d1 100644
>>> --- a/fs/exfat/super.c
>>> +++ b/fs/exfat/super.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/nls.h>
>>>  #include <linux/buffer_head.h>
>>>  #include <linux/magic.h>
>>> +#include "../nls/nls_ucs2_utils.h"
>>>
>>>  #include "exfat_raw.h"
>>>  #include "exfat_fs.h"
>>> @@ -573,6 +574,228 @@ static int exfat_verify_boot_region(struct
>>> super_block *sb)
>>>  	return 0;
>>>  }
>>>
>>> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
>>> +				       struct buffer_head **out_bh,
>>> +				       struct exfat_dentry **out_dentry,
>>> +				       struct inode *root_inode)
>> Instead of passing root_inode, it seems more helpful to pass the
>> need_create condition to better understand the function's behavior.
>> As mentioned earlier, the root_inode can be found directly from
>> sb->s_root->d_inode.
>>
> Given I can now obtain the root inode due to your above suggestion, I
> can use need_create from my previous patch (v3).
>>> +{
>>> +	int i, ret;
>>> +	unsigned int type, old_clu;
>>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>>> +	struct exfat_chain clu;
>>> +	struct exfat_dentry *ep, *deleted_ep = NULL;
>>> +	struct buffer_head *bh, *deleted_bh;
>>> +
>>> +	clu.dir = sbi->root_dir;
>>> +	clu.flags = ALLOC_FAT_CHAIN;
>>> +
>>> +	while (clu.dir != EXFAT_EOF_CLUSTER) {
>>> +		for (i = 0; i < sbi->dentries_per_clu; i++) {
>>> +			ep = exfat_get_dentry(sb, &clu, i, &bh);
>>> +
>>> +			if (!ep) {
>>> +				ret = -EIO;
>>> +				goto end;
>>> +			}
>>> +
>>> +			type = exfat_get_entry_type(ep);
>>> +			if (type == TYPE_DELETED && !deleted_ep &&
>> root_inode)
>>> {
>>> +				deleted_ep = ep;
>>> +				deleted_bh = bh;
>>> +				continue;
>>> +			}
>>> +
>>> +			if (type == TYPE_UNUSED) {
>>> +				if (!root_inode) {
>>> +					brelse(bh);
>>> +					ret = -ENOENT;
>>> +					goto end;
>>> +				}
>> Too many unnecessary operations are being performed here.
>> 1. Since the VOLUME_LABEL entry requires only one empty entry, if a DELETED
>>     or UNUSED entry is found, it can be used directly.
>> 2. According to the exFAT specification, all entries after UNUSED are
>>     guaranteed to be UNUSED.
>>
>> Therefore, there is no need to allocate additional clusters or
>> mark the next entry as UNUSED here.
>>
>> In the case of need_create(as of now, root_inode is not null),
>> if the next cluster is EOF and TYPE_VOLUME, TYPE_DELETED, or TYPE_UNUSED
>> entries are not found, then a new cluster should be allocated.
>>
>> Lastly, if a new VOLUME_LABEL entry is created, initialization of
>> hint_femp is required.
>>
> Just so I'm sure, if the last dentry in a cluster is TYPE_UNUSED, we can
> safely overwrite that with the volume label (assuming no other
> TYPE_VOLUME or TYPE_DELETED have been found previously), and we don't
> have to allocate a new cluster? And we would only have to allocate a
> new cluster if there are no TYPE_UNUSED, TYPE_VOLUME, or TYPE_DELETED
> anywhere in the chain?
Yes, that's right. If the root directory has an empty entry to use as
a volume label, no additional cluster is required at this point.

> 
> As for hint_femp, should I set the root_inode's hint_femp field to
> EXFAT_HINT_NONE?
I think so.

> Thanks you for the sugestions,
> Ethan Ferguson

Thanks!

