Return-Path: <linux-fsdevel+bounces-72037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5ACCDBC87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D269301EC70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46132F75F;
	Wed, 24 Dec 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AcGlsGDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41A1C84A0;
	Wed, 24 Dec 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568384; cv=none; b=Tja7odxbIxHvT9bt1uT5jNuZSlzy7UJRWbbeDuFCe91OU3E1xVTlOX9Pu/jA+8dudYJNQ423G1oxhweWnVrFyM/2doBae6alRi1NQWaQOBVQ8hHjcEvTRC5aFldF4Jag7hAVJCDEU51qKZID7GehDzH5H8fOJtD/s68Yy937kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568384; c=relaxed/simple;
	bh=LZqVMg9AXDzcJXt7l/r/N6I2bizNqMXE5UfkekWTGgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NMwWmVsm90qKuzRMfmR+H6ZULV0ceQOoaWw3eTcD6juWGeSVHy8DGtbl7jPuTyE/4d4LKOQNRDFLug0kxvM+OSEIDLvFdm3XQu4gThpyXTGol/T/0y8ASajYcYuOE71V+XQmKTU4BoIl5wIcgSAG30s4Ayr8Zh6nVB004YMvy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AcGlsGDG; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5w6XUmc2UvDnalo5beovSliVvB4/amDnBO0tMG8ysBY=;
	b=AcGlsGDGUBuw7WiaKdJHfQL9coxfEGIbty1pvcqkeGnQr+0KndNxOp2GzhZwZWKC2FsjJnxzI
	gVHHggZxWbtnSNL3Qr1uKmnBR/9wA7P6T89KOpq7HDqIqAUBNGDsQxyQ1YjsYzo1XCFz/lWCMuE
	/HK4oYUiUPUYriJvh4BV3vw=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dbmd96k8dzKm5C;
	Wed, 24 Dec 2025 17:23:09 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 828BC40086;
	Wed, 24 Dec 2025 17:26:17 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 17:26:16 +0800
Message-ID: <5aad8772-458d-4040-a8b6-feff924c1d30@huawei.com>
Date: Wed, 24 Dec 2025 17:26:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] erofs: introduce the page cache share feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-8-lihongbo22@huawei.com>
 <64b03916-7b57-4719-bb2c-8f15ae333330@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <64b03916-7b57-4719-bb2c-8f15ae333330@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)


Hi, Xiang
On 2025/12/24 16:09, Gao Xiang wrote:
> 
> 
> On 2025/12/24 12:09, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce inode_share mount option to enable the page sharing mode
>> during mounting.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   4 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/internal.h                 |  31 +++++
>>   fs/erofs/ishare.c                   | 171 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  52 ++++++++-
>>   fs/erofs/xattr.c                    |  40 ++++++-
>>   fs/erofs/xattr.h                    |  12 +-
>>   7 files changed, 300 insertions(+), 11 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 08194f194b94..1ef91b967b62 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -128,7 +128,11 @@ device=%s              Specify a path to an extra 
>> device to be used together.
>>   fsid=%s                Specify a filesystem image ID for Fscache 
>> back-end.
>>   domain_id=%s           Specify a domain ID in fscache mode so that 
>> different images
>>                          with the same blobs under a given domain ID 
>> can share storage.
>> +                       Also used for inode page sharing mode which 
>> defines a sharing
>> +                       domain.
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing mode. Files with the 
>> same content
>> +                       can reuse page cache under the same domain_id.
> 
> Enable inode page sharing for this filesystem.  Inodes with identical 
> content
> within the same domain ID can share the page cache.
> 
>>   ===================    
>> =========================================================
>>   Sysfs Entries
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 549abc424763..a80e1762b607 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += 
>> decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 99e2857173c3..a2b2434ee3c8 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -179,6 +179,7 @@ struct erofs_sb_info {
>>   #define EROFS_MOUNT_DAX_ALWAYS        0x00000040
>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>> +#define EROFS_MOUNT_INODE_SHARE        0x00000200
>>   #define clear_opt(opt, option)    ((opt)->mount_opt &= 
>> ~EROFS_MOUNT_##option)
>>   #define set_opt(opt, option)    ((opt)->mount_opt |= 
>> EROFS_MOUNT_##option)
>> @@ -269,6 +270,13 @@ static inline u64 erofs_nid_to_ino64(struct 
>> erofs_sb_info *sbi, erofs_nid_t nid)
>>   /* default readahead size of directories */
>>   #define EROFS_DIR_RA_BYTES    16384
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +struct erofs_inode_fingerprint {
>> +    u8 *opaque;
>> +    int size;
>> +};
>> +#endif
>> +
>>   struct erofs_inode {
>>       erofs_nid_t nid;
>> @@ -304,6 +312,16 @@ struct erofs_inode {
>>           };
>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>       };
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    struct list_head ishare_list;
>> +    union {
> 
>          /* for each anon shared inode */
>> +        struct {
>> +            struct erofs_inode_fingerprint fingerprint;
>> +            spinlock_t ishare_lock;
>> +        };
> 
>          /* for each real inode */
> 
>> +        struct inode *realinode;
> 
> 
> Sorry, I think this variable indicates the anon inode instead
> of some real inode, so it should be called
> 
>          struct inode *sharedinode;
> 
>> +    };
>> +#endif
>>       /* the corresponding vfs inode */
>>       struct inode vfs_inode;
>>   };
>> @@ -410,6 +428,7 @@ extern const struct inode_operations erofs_dir_iops;
>>   extern const struct file_operations erofs_file_fops;
>>   extern const struct file_operations erofs_dir_fops;
>> +extern const struct file_operations erofs_ishare_fops;
>>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>> @@ -541,6 +560,18 @@ static inline struct bio 
>> *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +int __init erofs_init_ishare(void);
>> +void erofs_exit_ishare(void);
>> +bool erofs_ishare_fill_inode(struct inode *inode);
>> +void erofs_ishare_free_inode(struct inode *inode);
>> +#else
>> +static inline int erofs_init_ishare(void) { return 0; }
>> +static inline void erofs_exit_ishare(void) {}
>> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { 
>> return false; }
>> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
>> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +
>>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long 
>> arg);
>>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>               unsigned long arg);
>> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
>> new file mode 100644
>> index 000000000000..09ea456f2eab
>> --- /dev/null
>> +++ b/fs/erofs/ishare.c
>> @@ -0,0 +1,171 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include <linux/xxhash.h>
>> +#include <linux/mount.h>
>> +#include "internal.h"
>> +#include "xattr.h"
>> +
>> +#include "../internal.h"
>> +
>> +static struct vfsmount *erofs_ishare_mnt;
>> +
>> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
>> +    struct erofs_inode_fingerprint *fp2 = data;
>> +
>> +    return fp1->size == fp2->size &&
>> +        !memcmp(fp1->opaque, fp2->opaque, fp2->size);
>> +}
>> +
>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock_init(&vi->ishare_lock);
>> +    return 0;
>> +}
>> +
>> +bool erofs_ishare_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_inode_fingerprint fp;
>> +    struct inode *idedup;
> 
> maybe just aligned with the term above
> 
>      struct inode *sharedinode;
> 
>> +    unsigned long hash;
>> +
>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>> +        return false;
>> +    fp = erofs_xattr_get_ishare_fp(inode, sbi->domain_id);
>> +    if (!fp.size)
>> +        return false;
>> +    hash = xxh32(fp.opaque, fp.size, 0);
>> +    idedup = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>> +                  erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>> +                  &fp);
>> +    if (!idedup) {
>> +        kfree(fp.opaque);
>> +        return false;
>> +    }
>> +
>> +    INIT_LIST_HEAD(&vi->ishare_list);
> 
> I think we could move this line after the following if block
> and just before spin_lock.
> 
>> +    vi->realinode = idedup;
>> +    if (inode_state_read_once(idedup) & I_NEW) {
>> +        if (erofs_inode_is_data_compressed(vi->datalayout))
>> +            idedup->i_mapping->a_ops = &z_erofs_aops;
>> +        else
>> +            idedup->i_mapping->a_ops = &erofs_aops;
>> +        idedup->i_mode = vi->vfs_inode.i_mode;
>> +        idedup->i_size = vi->vfs_inode.i_size;
>> +        unlock_new_inode(idedup);
>> +    } else {
>> +        kfree(fp.opaque);
>> +    }
>> +    spin_lock(&EROFS_I(idedup)->ishare_lock);> +    
>> list_add(&vi->ishare_list, &EROFS_I(idedup)->ishare_list);
>> +    spin_unlock(&EROFS_I(idedup)->ishare_lock);
>> +    return true;
>> +}
>> +
>> +void erofs_ishare_free_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct inode *idedup = vi->realinode;
> 
>      struct inode *sharedinode = vi->sharedinode;
> 
>> +
>> +    if (!idedup)
>> +        return;
>> +    spin_lock(&EROFS_I(idedup)->ishare_lock);
>> +    list_del(&vi->ishare_list);
>> +    spin_unlock(&EROFS_I(idedup)->ishare_lock);
>> +    iput(idedup);
>> +    vi->realinode = NULL;
>> +}
>> +
>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile;
>> +    struct inode *dedup;
> 
> same here, sharedinode;
> 
>> +
>> +    dedup = EROFS_I(inode)->realinode;
>> +    realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, 
>> current_cred());
>> +    if (IS_ERR(realfile))
>> +        return PTR_ERR(realfile);
>> +    ihold(dedup);
>> +    realfile->f_op = &erofs_file_fops;
>> +    realfile->f_inode = dedup;
>> +    realfile->f_mapping = dedup->i_mapping;
>> +    path_get(&file->f_path);
>> +    backing_file_set_user_path(realfile, &file->f_path);
>> +
>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>> +    realfile->private_data = EROFS_I(inode);
>> +    file->private_data = realfile;
>> +    return 0;
>> +}
>> +
>> +static int erofs_ishare_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    iput(realfile->f_inode);
>> +    fput(realfile);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>> +                            struct iov_iter *to)
>> +{
>> +    struct file *realfile = iocb->ki_filp->private_data;
>> +    struct inode *inode = file_inode(iocb->ki_filp);
>> +    struct kiocb dedup_iocb;
>> +    ssize_t nread;
>> +
>> +    if (!iov_iter_count(to))
>> +        return 0;
>> +
>> +    /* fallback to the original file in DAX or DIRECT mode */
> 
> I think we should just disallow FSDAX if inode_share is on.
> 
> 
>> +    if (IS_DAX(inode) || (iocb->ki_flags & IOCB_DIRECT))
>> +        realfile = iocb->ki_filp;
>> +
>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>> +    nread = filemap_read(&dedup_iocb, to, 0);
>> +    iocb->ki_pos = dedup_iocb.ki_pos;
>> +    file_accessed(iocb->ki_filp);
>> +    return nread;
>> +}
>> +
>> +static int erofs_ishare_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    vma_set_file(vma, realfile);
>> +    return generic_file_readonly_mmap(file, vma);
>> +}
>> +
>> +const struct file_operations erofs_ishare_fops = {
>> +    .open        = erofs_ishare_file_open,
>> +    .llseek        = generic_file_llseek,
>> +    .read_iter    = erofs_ishare_file_read_iter,
>> +    .mmap        = erofs_ishare_mmap,
>> +    .release    = erofs_ishare_file_release,
>> +    .get_unmapped_area = thp_get_unmapped_area,
>> +    .splice_read    = filemap_splice_read,
>> +};
>> +
>> +int __init erofs_init_ishare(void)
>> +{
>> +    erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
>> +    if (IS_ERR(erofs_ishare_mnt))
>> +        return PTR_ERR(erofs_ishare_mnt);
>> +    return 0;
>> +}
>> +
>> +void erofs_exit_ishare(void)
>> +{
>> +    kern_unmount(erofs_ishare_mnt);
>> +}
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 819ab0ae9950..b3b0dedcadab 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -390,6 +390,7 @@ static void erofs_default_options(struct 
>> erofs_sb_info *sbi)
>>   enum {
>>       Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>       Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
>> +    Opt_inode_share,
>>   };
>>   static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -417,6 +418,7 @@ static const struct fs_parameter_spec 
>> erofs_fs_parameters[] = {
>>       fsparam_string("domain_id",    Opt_domain_id),
>>       fsparam_flag_no("directio",    Opt_directio),
>>       fsparam_u64("fsoffset",        Opt_fsoffset),
>> +    fsparam_flag("inode_share",    Opt_inode_share),
>>       {}
>>   };
>> @@ -545,6 +547,14 @@ static int erofs_fc_parse_param(struct fs_context 
>> *fc,
>>       case Opt_fsoffset:
>>           sbi->dif0.fsoff = result.uint_64;
>>           break;
>> +#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>> +    case Opt_inode_share:
>> +        set_opt(&sbi->opt, INODE_SHARE);
>> +#else
>> +    case Opt_inode_share:
>> +        errorfc(fc, "%s option not supported", 
>> erofs_fs_parameters[opt].name);
>> +#endif
>> +        break;
>>       }
>>       return 0;
>>   }
>> @@ -643,6 +653,12 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>       sb->s_op = &erofs_sops;
>> +    if (sbi->domain_id &&
>> +        (!sbi->fsid && !test_opt(&sbi->opt, INODE_SHARE))) {
>> +        errorfc(fc, "domain_id should be with fsid or inode_share 
>> option");
>> +        return -EINVAL;
>> +    }
>> +
>>       sbi->blkszbits = PAGE_SHIFT;
>>       if (!sb->s_bdev) {
>>           /*
>> @@ -942,14 +958,34 @@ static struct file_system_type erofs_fs_type = {
>>   };
>>   MODULE_ALIAS_FS("erofs");
>> -#if defined(CONFIG_EROFS_FS_ONDEMAND)
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || 
>> defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>> +static void erofs_free_anon_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    kfree(vi->fingerprint.opaque);
>> +#endif
>> +    kmem_cache_free(erofs_inode_cachep, vi);
>> +}
>> +
>> +static const struct super_operations erofs_anon_sops = {
>> +    .alloc_inode = erofs_alloc_inode,
>> +    .free_inode = erofs_free_anon_inode,
>> +};
>> +
>>   static int erofs_anon_init_fs_context(struct fs_context *fc)
>>   {
>> -    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
>> +    struct pseudo_fs_context *ctx;
>> +
>> +    ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
>> +    if (ctx)
>> +        ctx->ops = &erofs_anon_sops;
>> +
>> +    return ctx ? 0 : -ENOMEM;
>>   }
>>   struct file_system_type erofs_anon_fs_type = {
>> -    .owner        = THIS_MODULE,
>>       .name           = "pseudo_erofs",
>>       .init_fs_context = erofs_anon_init_fs_context,
>>       .kill_sb        = kill_anon_super,
>> @@ -981,6 +1017,10 @@ static int __init erofs_module_init(void)
>>       if (err)
>>           goto sysfs_err;
>> +    err = erofs_init_ishare();
>> +    if (err)
>> +        goto ishare_err;
>> +
>>       err = register_filesystem(&erofs_fs_type);
>>       if (err)
>>           goto fs_err;
>> @@ -988,6 +1028,8 @@ static int __init erofs_module_init(void)
>>       return 0;
>>   fs_err:
>> +    erofs_exit_ishare();
>> +ishare_err:
>>       erofs_exit_sysfs();
>>   sysfs_err:
>>       z_erofs_exit_subsystem();
>> @@ -1005,6 +1047,7 @@ static void __exit erofs_module_exit(void)
>>       /* Ensure all RCU free inodes / pclusters are safe to be 
>> destroyed. */
>>       rcu_barrier();
>> +    erofs_exit_ishare();
>>       erofs_exit_sysfs();
>>       z_erofs_exit_subsystem();
>>       erofs_exit_shrinker();
>> @@ -1057,6 +1100,8 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>           seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>>       if (sbi->dif0.fsoff)
>>           seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>> +    if (test_opt(opt, INODE_SHARE))
>> +        seq_puts(seq, ",inode_share");
>>       return 0;
>>   }
>> @@ -1067,6 +1112,7 @@ static void erofs_evict_inode(struct inode *inode)
>>           dax_break_layout_final(inode);
>>   #endif
>> +    erofs_ishare_free_inode(inode);
>>       truncate_inode_pages_final(&inode->i_data);
>>       clear_inode(inode);
>>   }
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 969e77efd038..7542aee01609 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -25,6 +25,9 @@ struct erofs_xattr_iter {
>>       struct dentry *dentry;
>>   };
>> +static int erofs_getxattr(struct inode *inode, int index, const char 
>> *name,
>> +            void *buffer, size_t buffer_size);
> 
> could we clean it up in a seperate patch?
> It can be an independent patch against this series.
> 
>> +
>>   static int erofs_init_inode_xattrs(struct inode *inode)
>>   {
>>       struct erofs_inode *const vi = EROFS_I(inode);
>> @@ -391,7 +394,7 @@ static int erofs_xattr_iter_shared(struct 
>> erofs_xattr_iter *it,
>>       return i ? ret : -ENODATA;
>>   }
>> -int erofs_getxattr(struct inode *inode, int index, const char *name,
>> +static int erofs_getxattr(struct inode *inode, int index, const char 
>> *name,
>>              void *buffer, size_t buffer_size)
>>   {
>>       int ret;
>> @@ -577,3 +580,38 @@ struct posix_acl *erofs_get_acl(struct inode 
>> *inode, int type, bool rcu)
>>       return acl;
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +struct erofs_inode_fingerprint erofs_xattr_get_ishare_fp(struct inode 
>> *inode,
> 
> why return `struct erofs_inode_fingerprint` instead of:
> 
> int erofs_xattr_get_ishare_fp(struct erofs_inode_fingerprint *fp,
>                    struct inode *inode, const char *domain_id)
> 
> instead?
> 

How about declaring this as void erofs_xattr_fill_ishare_fp(struct 
erofs_inode_fingerprint *fp, struct inode *inode, const char 
*domain_id)? Because the return value seems useless.

Thanks,
Hongbo

>> +                            const char *domain_id)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_inode_fingerprint fp = {};
>> +    struct erofs_xattr_prefix_item *prefix;
>> +    const char *infix;
>> +    int valuelen, base_index, domainlen;
>> +
>> +    if (!erofs_sb_has_ishare_xattrs(sbi))
>> +        goto out;
> 
> Just use return 0; instead?
> 
>> +    prefix = sbi->xattr_prefixes + sbi->ishare_xattr_pfx;
>> +    infix = prefix->prefix->infix;
>> +    base_index = prefix->prefix->base_index;
>> +    valuelen = erofs_getxattr(inode, base_index, infix, NULL, 0);
>> +    if (valuelen <= 0 || valuelen > (1 << sbi->blkszbits))
>> +        goto out;
> 
> `return -EFSCORRUPTED` here.
> 
>> +    domainlen = domain_id ? strlen(domain_id) : 0;
>> +    fp.opaque = kmalloc(valuelen + domainlen, GFP_KERNEL);
>> +    if (!fp.opaque)
>> +        goto out;
> 
> `return -ENOMEM;` here.
> 
>> +    if (valuelen != erofs_getxattr(inode, base_index, infix,
>> +                       fp.opaque, valuelen)) {
>> +        kfree(fp.opaque);
>> +        fp.opaque = NULL;
>> +        goto out;
> 
>          return -EFSCORRUPTED;
> 
>> +    }
>> +    memcpy(fp.opaque + valuelen, domain_id, domainlen);
>> +    fp.size = valuelen + domainlen;
>> +out:
>> +    return fp;
> 
>      return 0;
> 
>> +}
>> +#endif
>> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
>> index 6317caa8413e..32e08ed9cfc9 100644
>> --- a/fs/erofs/xattr.h
>> +++ b/fs/erofs/xattr.h
>> @@ -45,17 +45,10 @@ extern const struct xattr_handler * const 
>> erofs_xattr_handlers[];
>>   int erofs_xattr_prefixes_init(struct super_block *sb);
>>   void erofs_xattr_prefixes_cleanup(struct super_block *sb);
>> -int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
>>   ssize_t erofs_listxattr(struct dentry *, char *, size_t);
>>   #else
>>   static inline int erofs_xattr_prefixes_init(struct super_block *sb) 
>> { return 0; }
>>   static inline void erofs_xattr_prefixes_cleanup(struct super_block 
>> *sb) {}
>> -static inline int erofs_getxattr(struct inode *inode, int index,
>> -                 const char *name, void *buffer,
>> -                 size_t buffer_size)
>> -{
>> -    return -EOPNOTSUPP;
>> -}
> 
> As I said earlier, I will clean this part in a seperate patch.
> 
> 
>>   #define erofs_listxattr (NULL)
>>   #define erofs_xattr_handlers (NULL)
>> @@ -67,4 +60,9 @@ struct posix_acl *erofs_get_acl(struct inode *inode, 
>> int type, bool rcu);
>>   #define erofs_get_acl    (NULL)
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> 
> No need to wrap it with a `#ifdef`.
> 
> Thanks,
> Gao Xiang
> 
>> +struct erofs_inode_fingerprint erofs_xattr_get_ishare_fp(struct inode 
>> *inode,
>> +                        const char *domain_id);
>> +#endif
>> +
>>   #endif
> 

