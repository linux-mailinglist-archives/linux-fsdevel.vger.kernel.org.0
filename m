Return-Path: <linux-fsdevel+bounces-68816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA3C66FF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB6CC4E4FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08692320CA2;
	Tue, 18 Nov 2025 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="02wRYQ+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC72248A4;
	Tue, 18 Nov 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432195; cv=none; b=cofmnVjPn23C+QcFopaqhYNUFCOYZdNpIkPvDh0Kb+72GA5zWm5v+wT9wf75UdKSP9o2EZijj2sd9320RsUwRRZZZh8PGjiKAec1ByPWNkpUaQ/as1Fu/I8dUWfVLcCu9VJTg/ELkWRnUckiKTbobW4dn0+PxqXTFAhXBMg4pE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432195; c=relaxed/simple;
	bh=4fnFf49JbyHTFIofzu+EfWnD1hfl/Wab4udUlb2tAUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g89fppe3aQv5IevUCHgTnNmu9gxUQ/F7EcDuZTDtDPUHBaJnwni/uUpsuWyE8HYhX2yuMwCR3w5sMvxBsfMp1vY7uFKa0Y/EwDQTTGEuM53Zu1sxUOUu1XJnE9reMOsxeUMF6kN97eD7624EZQ0mkaPU4MxbVHk8db2P4a/9GFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=02wRYQ+r; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qS5MI6qPUZ2JIu0cYMTIULh33XEMtn5kq2euSgtpbvA=;
	b=02wRYQ+rQitdrf6Sa+LntPs7+QoOBlmxQj9Jtppr7m3DRacmV4tspatvwAT4niXrXAq3bi7Mk
	eooQwdbHyTLh8itNyURMhEGFgF/U2rmUPOQpc+7szaUcahcWThClF6TZh2Dtt/6rLqwtuquEbSJ
	s7ewPyD3qNDZnFKOhRWaw/s=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d9SqW6HCzzRhRb;
	Tue, 18 Nov 2025 10:14:47 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 773B0180477;
	Tue, 18 Nov 2025 10:16:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 10:16:29 +0800
Message-ID: <de446b03-b311-4630-aa7c-b503bcd82b69@huawei.com>
Date: Tue, 18 Nov 2025 10:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/10] erofs: support user-defined fingerprint name
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-6-lihongbo22@huawei.com>
 <3a90b6b0-bfba-4a25-8fe7-dcb0f3c12acc@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <3a90b6b0-bfba-4a25-8fe7-dcb0f3c12acc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi Xiang,

On 2025/11/18 1:26, Gao Xiang wrote:
> 
> 
> On 2025/11/17 21:25, Hongbo Li wrote:
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
>>   fs/erofs/internal.h |  2 ++
>>   fs/erofs/super.c    |  5 +++--
>>   fs/erofs/xattr.c    | 15 +++++++++++++++
>>   5 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index d81f3318417d..c88b6d0714a4 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>>         at higher priority.
>>         If unsure, say N.
>> +
>> +config EROFS_FS_PAGE_CACHE_SHARE
>> +    bool "EROFS page cache share support (experimental)"
>> +    depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
>> +    help
>> +      This enables page cache sharing among inodes with identical
>> +      content fingerprints on the same device.
>> +
>> +      If unsure, say N.
>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>> index 3d5738f80072..9b9fe1abe0b9 100644
>> --- a/fs/erofs/erofs_fs.h
>> +++ b/fs/erofs/erofs_fs.h
>> @@ -35,8 +35,9 @@
>>   #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES    0x00000040
>>   #define EROFS_FEATURE_INCOMPAT_48BIT        0x00000080
>>   #define EROFS_FEATURE_INCOMPAT_METABOX        0x00000100
>> +#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY    0x00000200
> 
> It seems that you didn't address this part I
> mentioned in the previous reply:
> https://lore.kernel.org/r/a3b0bac9-d08f-44dc-8adb-7cc85cae7b13@linux.alibaba.com
> 

Thanks for pointing it out. I will update here in next version (include 
the following issues).

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 9b9fe1abe0b9..28955456d2e1 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,7 +17,7 @@
  #define EROFS_FEATURE_COMPAT_XATTR_FILTER              0x00000004
  #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX      0x00000008
  #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX           0x00000010
-
+#define EROFS_FEATURE_COMPAT_ISHARE_KEY                        0x00000020

  /*
   * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -35,9 +35,8 @@
  #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES  0x00000040
  #define EROFS_FEATURE_INCOMPAT_48BIT           0x00000080
  #define EROFS_FEATURE_INCOMPAT_METABOX         0x00000100
-#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY      0x00000200
  #define EROFS_ALL_FEATURE_INCOMPAT             \
-       ((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
+       ((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)

  #define EROFS_SB_EXTSLOT_SIZE  16

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 37b536eebc3d..bb5dff36c9b8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -248,11 +248,11 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
  EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
  EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
  EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
-EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
  EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
  EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, 
COMPAT_SHARED_EA_IN_METABOX)
  EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
+EROFS_FEATURE_FUNCS(ishare_key, compat, COMPAT_ISHARE_KEY)

  static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, 
erofs_nid_t nid)
  {

Thanks,
Hongbo

>>   #define EROFS_ALL_FEATURE_INCOMPAT        \
>> -    ((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
>> +    ((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
>>   #define EROFS_SB_EXTSLOT_SIZE    16
>> @@ -83,7 +84,8 @@ struct erofs_super_block {
>>       __le32 xattr_prefix_start;    /* start of long xattr prefixes */
>>       __le64 packed_nid;    /* nid of the special packed inode */
>>       __u8 xattr_filter_reserved; /* reserved for xattr name filter */
>> -    __u8 reserved[3];
>> +    __u8 ishare_xattr_prefix_id;    /* indice the ishare key in 
>> prefix xattr */
> 
> /* indexes the ishare key in prefix xattres */ ?
> 
>> +    __u8 reserved[2];
>>       __le32 build_time;    /* seconds added to epoch for mkfs time */
>>       __le64 rootnid_8b;    /* (48BIT on) nid of root directory */
>>       __le64 reserved2;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 98fe652aea33..3033252211ba 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -134,6 +134,7 @@ struct erofs_sb_info {
>>       u32 xattr_blkaddr;
>>       u32 xattr_prefix_start;
>>       u8 xattr_prefix_count;
>> +    u8 ishare_xattr_pfx;    /* ishare prefix xattr index */
> 
> I think either giving a meaningful comment or just
> get rid of the comment entirely.
> 
>>       struct erofs_xattr_prefix_item *xattr_prefixes;
>>       unsigned int xattr_filter_reserved;
>>   #endif
>> @@ -234,6 +235,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, 
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
>> index 0d88c04684b9..80f032cb2cc3 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -298,6 +298,9 @@ static int erofs_read_superblock(struct 
>> super_block *sb)
>>           if (ret)
>>               goto out;
>>       }
>> +    if (erofs_sb_has_ishare_key(sbi))
>> +        sbi->ishare_xattr_pfx =
>> +            dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
>>       ret = -EINVAL;
>>       sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
>> @@ -339,7 +342,6 @@ static int erofs_read_superblock(struct 
>> super_block *sb)
>>               return -EFSCORRUPTED;    /* self-loop detection */
>>       }
>>       sbi->inos = le64_to_cpu(dsb->inos);
>> -
> 
> Unnecessary change here.
> 
>>       sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
>>       sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>>       super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>> @@ -737,7 +739,6 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       err = erofs_xattr_prefixes_init(sb);
>>       if (err)
>>           return err;
>> -
> 
> Unnecessary change here.
> 
>>       erofs_set_sysfs_name(sb);
>>       err = erofs_register_sysfs(sb);
>>       if (err)
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 396536d9a862..6cb76313c14c 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -519,6 +519,21 @@ int erofs_xattr_prefixes_init(struct super_block 
>> *sb)
>>       }
>>       erofs_put_metabuf(&buf);
>> +    if (!ret && erofs_sb_has_ishare_key(sbi)) {
>> +        struct erofs_xattr_long_prefix *new_pfx, *pfx =
>> +                    pfs[sbi->ishare_xattr_pfx].prefix;
> 
>          struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_pfx;
>          struct erofs_xattr_long_prefix *newpfx;
> 
>          newpfx = krealloc(pf->prefix,
>                  sizeof(*newpfx) + pf->infix_len + 1, GFP_KERNEL);
>          if (newpfx) {
>              newpfx->infix[pf->infix_len] = '\0';
>              pf->prefix = newpfx;
>          } else {
>              ret = -ENOMEM;
>          }
> 
> Thanks,
> Gao Xiang
> 
>> +
>> +        new_pfx = krealloc(pfx,
>> +                   sizeof(struct erofs_xattr_long_prefix) +
>> +                   pfs[sbi->ishare_xattr_pfx].infix_len + 1,
>> +                   GFP_KERNEL);
>> +        if (new_pfx) {
>> +            new_pfx->infix[pfs[sbi->ishare_xattr_pfx].infix_len] = '\0';
>> +            pfs[sbi->ishare_xattr_pfx].prefix = new_pfx;
>> +        } else {
>> +            ret = -ENOMEM;
>> +        }
>> +    }
>>       sbi->xattr_prefixes = pfs;
>>       if (ret)
>>           erofs_xattr_prefixes_cleanup(sb);
> 

