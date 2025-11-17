Return-Path: <linux-fsdevel+bounces-68640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF29C62C95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 08:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1C4EC71B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2C31A046;
	Mon, 17 Nov 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VR8ideB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255830F55E;
	Mon, 17 Nov 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365322; cv=none; b=iJT7nfvZ1YrFY17kxY2Hisds+Vzpw3PXLie8oaFOAHfRrz9IQuKVpaeQ31xBzFekxN7Gk8GDUOq8OdUtCMdodfEI3jdM5blIb5rvWoD3QHZIlywGbXQZyFkYWoj0/g01j0zARiu3INSpu2yA67MV2owZ8pgrdhHUw20xeJswf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365322; c=relaxed/simple;
	bh=hBtAE75wxG2EX84bt0+ogBvoH2ru0c76LVrBsf3TsQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Awlpas+YTJPUnzk1XUOW36wZYye4teEzi8Eg+zvj0FMvJMmSAGSHQOAuaWCTHIdG6kEnZkh1w412BgCCrkeDLtsjWxHceGsyFBDx5FBQD/fsWIK5NSAfkUdf+lfEp7AGxRUgWfdvrh4naCx6gUmRDNkmgfA//0rqF5toBrDeo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VR8ideB7; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gGtZe6aUNhI/+lLCQkV3ulj8qdpXHe/N2oVbKgeo9F4=;
	b=VR8ideB7WJpp6R/VqhF/68ghpS4DJgDdVfQmUGL6gwVChmwlsrIYsyj+BEViYDYLcaXN33O3q
	xmTsrB8SA0aBmz9eA9n3lqLHkYW7bu2FyiYREFyor3D40AP+ireedZTFPgqx0zp8TYsE1GvF63x
	g3/0gT/ST1XpMNoKfo2L3Ts=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d905j6WTkz1T4Fq;
	Mon, 17 Nov 2025 15:40:25 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 11352180B6B;
	Mon, 17 Nov 2025 15:41:56 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 15:41:55 +0800
Message-ID: <df86044f-b192-492a-99f2-bad019570f9d@huawei.com>
Date: Mon, 17 Nov 2025 15:41:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] erofs: support user-defined fingerprint name
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-5-lihongbo22@huawei.com>
 <a3b0bac9-d08f-44dc-8adb-7cc85cae7b13@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <a3b0bac9-d08f-44dc-8adb-7cc85cae7b13@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi Xiang,

On 2025/11/17 10:54, Gao Xiang wrote:
> 
> 
> On 2025/11/14 17:55, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> When creating the EROFS image, users can specify the fingerprint name.
>> This is to prepare for the upcoming inode page cache share.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/Kconfig    |  9 +++++++++
>>   fs/erofs/erofs_fs.h |  6 ++++--
>>   fs/erofs/internal.h |  6 ++++++
>>   fs/erofs/super.c    |  5 ++++-
>>   fs/erofs/xattr.c    | 26 ++++++++++++++++++++++++++
>>   fs/erofs/xattr.h    |  6 ++++++
>>   6 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index d81f3318417d..1b5c0cd99203 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>>         at higher priority.
>>         If unsure, say N.
>> +
>> +config EROFS_FS_INODE_SHARE
>> +    bool "EROFS inode page cache share support (experimental)"
>> +    depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
>> +    help
>> +      This permits EROFS to share page cache for files with same
>> +      fingerprints.
> 
> I tend to use "EROFS_FS_PAGE_CACHE_SHARE" since it's closer to
> user impact definition (inode sharing is ambiguious), but we
> could leave "ishare.c" since it's closer to the implementation
> details.
> 
> And how about:
> 
> config EROFS_FS_PAGE_CACHE_SHARE
>      bool "EROFS page cache share support (experimental)"
>      depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
>      help
>        This enables page cache sharing among inodes with identical
>        content fingerprints on the same device.
> 
>        If unsure, say N.
> 
>> +
>> +      If unsure, say N.
>> \ No newline at end of file
> 
> "\ No newline at end of file" should be fixed.
> 
>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>> index 3d5738f80072..104518cd161d 100644
>> --- a/fs/erofs/erofs_fs.h
>> +++ b/fs/erofs/erofs_fs.h
>> @@ -35,8 +35,9 @@
>>   #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES    0x00000040
>>   #define EROFS_FEATURE_INCOMPAT_48BIT        0x00000080
>>   #define EROFS_FEATURE_INCOMPAT_METABOX        0x00000100
>> +#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY    0x00000200
> 
> I do think it should be a compatible feature since images can be
> mounted in the old kernels without any issue, and it should be
> renamed as
> 
> EROFS_FEATURE_COMPAT_ISHARE_XATTRS
> 
>>   #define EROFS_ALL_FEATURE_INCOMPAT        \
>> -    ((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
>> +    ((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
>>   #define EROFS_SB_EXTSLOT_SIZE    16
>> @@ -83,7 +84,8 @@ struct erofs_super_block {
>>       __le32 xattr_prefix_start;    /* start of long xattr prefixes */
>>       __le64 packed_nid;    /* nid of the special packed inode */
>>       __u8 xattr_filter_reserved; /* reserved for xattr name filter */
>> -    __u8 reserved[3];
>> +    __u8 ishare_key_start;    /* start of ishare key */
> 
> ishare_xattr_prefix_id; ?
> 
>> +    __u8 reserved[2];
>>       __le32 build_time;    /* seconds added to epoch for mkfs time */
>>       __le64 rootnid_8b;    /* (48BIT on) nid of root directory */
>>       __le64 reserved2;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index e80b35db18e4..3ebbb7c5d085 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -167,6 +167,11 @@ struct erofs_sb_info {
>>       struct erofs_domain *domain;
>>       char *fsid;
>>       char *domain_id;
>> +
>> +    /* inode page cache share support */
>> +    u8 ishare_key_start;
> 
>      u8 ishare_xattr_pfx;
> 
>> +    u8 ishare_key_idx;
> 
> why need this, considering we could just use
> 
> sbi->xattr_prefixes[sbi->ishare_xattr_pfx]
> 
> to get this.
> 
>> +    char *ishare_key;
>>   };
>>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
>> @@ -236,6 +241,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, 
>> INCOMPAT_DEDUPE)
>>   EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>>   EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
>>   EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
>> +EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
>>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, 
>> COMPAT_SHARED_EA_IN_METABOX)
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 0d88c04684b9..3561473cb789 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -339,7 +339,7 @@ static int erofs_read_superblock(struct 
>> super_block *sb)
>>               return -EFSCORRUPTED;    /* self-loop detection */
>>       }
>>       sbi->inos = le64_to_cpu(dsb->inos);
>> -
>> +    sbi->ishare_key_start = dsb->ishare_key_start;
>>       sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
>>       sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>>       super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>> @@ -738,6 +738,9 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       if (err)
>>           return err;
>> +    err = erofs_xattr_set_ishare_key(sb);
> 
> I don't think it's necessary to duplicate the copy, just use
> "sbi->xattr_prefixes[sbi->ishare_xattr_pfx]" directly.
> 

Thanks for review, but here we should pass the char * to erofs_getxattr 
to obtain the xattr length and value. And xattr_prefixes packed all 
entries together so we cannot tranform 
sbi->xattr_prefixes[sbi->ishare_xattr_pfx] into char * directly.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>> +    if (err)
>> +        return err;
>>       erofs_set_sysfs_name(sb);
>>       err = erofs_register_sysfs(sb);
>>       if (err)
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 396536d9a862..3c99091f39a5 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -564,3 +564,29 @@ struct posix_acl *erofs_get_acl(struct inode 
>> *inode, int type, bool rcu)
>>       return acl;
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
>> +int erofs_xattr_set_ishare_key(struct super_block *sb)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +    struct erofs_xattr_prefix_item *pf;
>> +    char *ishare_key;
>> +
>> +    if (!sbi->xattr_prefixes ||
>> +        !(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX))
>> +        return 0;
>> +
>> +    pf = sbi->xattr_prefixes +
>> +        (sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX_MASK);
>> +    if (!pf || pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
>> +        return 0;
>> +    ishare_key = kmalloc(pf->infix_len + 1, GFP_KERNEL);
>> +    if (!ishare_key)
>> +        return -ENOMEM;
>> +    memcpy(ishare_key, pf->prefix->infix, pf->infix_len);
>> +    ishare_key[pf->infix_len] = '\0';
>> +    sbi->ishare_key = ishare_key;
>> +    sbi->ishare_key_idx = pf->prefix->base_index;
>> +    return 0;
>> +}
>> +#endif
>> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
>> index 6317caa8413e..21684359662c 100644
>> --- a/fs/erofs/xattr.h
>> +++ b/fs/erofs/xattr.h
>> @@ -67,4 +67,10 @@ struct posix_acl *erofs_get_acl(struct inode 
>> *inode, int type, bool rcu);
>>   #define erofs_get_acl    (NULL)
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
>> +int erofs_xattr_set_ishare_key(struct super_block *sb);
>> +#else
>> +static inline int erofs_xattr_set_ishare_key(struct super_block *sb) 
>> { return 0; }
>> +#endif
>> +
>>   #endif
> 

