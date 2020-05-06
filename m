Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D031C7BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 22:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgEFU7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 16:59:18 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:50207 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726815AbgEFU7R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 16:59:17 -0400
Received: from venice.bhome ([94.37.193.252])
        by smtp-33.iol.local with ESMTPA
        id WR8LjnfsurZwsWR8Ljrqj0; Wed, 06 May 2020 22:59:13 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1588798753; bh=/UyPGe9StAYqxUzEJ3oBQK/NzqrMWKGLD8DM7wBPVPU=;
        h=From;
        b=WErH4FwL6WBgpWGU1LOgYBxaEG7huhrYa6ilbb5hI0fJQfT7UIB4YS1TVIcKRR+aH
         ty2ANJoPl7uXxAoOwbLGNcO+ZbXopsAPIiob0KgxGTwvjTTvzP6UVfIW9SxPbsazVH
         Er83ttDl2rFzT46IIyD6zar+hY2cNXvnEP2mFzgQQX5evDmmffcbHUiGyK+mBn0Xj5
         3TRb4LR88bnzQSIYAFrytgsONV4yeuYPP+0l3TiskGX0K10nCUCU45sZYjuZENGlbt
         MD+OE5b5gQNDlotvON/aYRBjbhsPXKqbdRIedhrYEQvUKzb4wakoLS619mgTY2ryxl
         ZBblXExZv3WYw==
X-CNFS-Analysis: v=2.3 cv=ANbu9Azk c=1 sm=1 tr=0
 a=m9MdMCwkAncLgtUozvdZtQ==:117 a=m9MdMCwkAncLgtUozvdZtQ==:17
 a=IkcTkHD0fZMA:10 a=JF9118EUAAAA:8 a=GMMIqeRl9_w7wcUW1qQA:9
 a=JBGJNMo24WBDtPIH:21 a=tKcsS2AzCCHkw58Z:21 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <bcd4e839-36ac-9be5-e5e7-613124385177@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <ee971571-cbc2-31b5-e092-c8c7d229e5e3@libero.it>
Date:   Wed, 6 May 2020 22:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bcd4e839-36ac-9be5-e5e7-613124385177@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLT9Dwtf19yIq9Y6kxMOK8H9j5v2ghwGzBebKDcK9eAnCm6blKKOfgFO5Q3BocEj+QFXqcAqZPKwGGhzHJPqXNg98dZk+Xk/mtsTIsq8rDlAQZisn6UF
 jxd6UQwoDyYbTgvhkkCJOLmrkoOEnblxDZC/xTOyRqhU0X7cFho8aqN8Lpo9c5xCFF9aLUGngBSqzeCZ5ngNQDCt2L7jIj+fJrSCFXhlqN6eMgF1W7ItrQd1
 yHu2q6yUUpQdHJ7gZRX2H6Nv4P2eENPGn0mmOUuxkd9dl3ddcfhEJMuq0EddwPTQPnj0n2liikgu7hlFIcVcZU0BZ8PLb8gPjiYMSjc3L2PmApvjqaCPpuIG
 Bu54p46NTLqIqeHfW8Ad6xB7HXoxTupHkB96ewt0+IePjt9lPf9ZJ1qTIv3yucE4dv7JEZcV
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/20 11:43 AM, Qu Wenruo wrote:
> 
> 
> On 2020/4/28 下午6:58, Johannes Thumshirn wrote:
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Add authentication support for a BTRFS file-system.
>>
>> This works, because in BTRFS every meta-data block as well as every
>> data-block has a own checksum. For meta-data the checksum is in the
>> meta-data node itself. For data blocks, the checksums are stored in the
>> checksum tree.
>>
>> When replacing the checksum algorithm with a keyed hash, like HMAC(SHA256),
>> a key is needed to mount a verified file-system. This key also needs to be
>> used at file-system creation time.
>>
>> We have to used a keyed hash scheme, in contrast to doing a normal
>> cryptographic hash, to guarantee integrity of the file system, as a
>> potential attacker could just replay file-system operations and the
>> changes would go unnoticed.
>>
>> Having a keyed hash only on the topmost Node of a tree or even just in the
>> super-block and using cryptographic hashes on the normal meta-data nodes
>> and checksum tree entries doesn't work either, as the BTRFS B-Tree's Nodes
>> do not include the checksums of their respective child nodes, but only the
>> block pointers and offsets where to find them on disk.
>>
>> Also note, we do not need a incompat R/O flag for this, because if an old
>> kernel tries to mount an authenticated file-system it will fail the
>> initial checksum type verification and thus refuses to mount.
>>
>> The key has to be supplied by the kernel's keyring and the method of
>> getting the key securely into the kernel is not subject of this patch.
>>
>> Example usage:
>> Create a file-system with authentication key 0123456
>> mkfs.btrfs --csum hmac-sha256 --auth-key 0123456 /dev/disk
>>
>> Add the key to the kernel's keyring as keyid 'btrfs:foo'
>> keyctl add logon btrfs:foo 0123456 @u
>>
>> Mount the fs using the 'btrfs:foo' key
>> mount -t btrfs -o auth_key=btrfs:foo /dev/disk /mnt/point
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> Looks pretty straight forward, and has the basic protection against
> re-writing all csum attack.
> 
> So looks good to me.
> 
> But still I have one question around the device scan part.
> 
> Since now superblock can only be read after verified the csum, it means
> without auth_key mount option, device scan won't even work properly.

It is really needed to perform the checksum at "scan" time ? It should be possible to defer the cksum at the mount time.
The device scan is used only to track the disks for building a filesystem. We could check only the "magic", the UUID and the FSID.
The check of the cheksum may be performed at mount time.
> 
> Do you assume that all such hmac protected multi-device btrfs must be
> mounted using device= mount option along with auth_key?
> If so, a lot of users won't be that happy afaik.
> 
> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/ctree.c                |  3 ++-
>>   fs/btrfs/ctree.h                |  2 ++
>>   fs/btrfs/disk-io.c              | 53 ++++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/super.c                | 24 ++++++++++++++++---
>>   include/uapi/linux/btrfs_tree.h |  1 +
>>   5 files changed, 78 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index 6c28efe5b14a..76418b5b00a6 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -31,7 +31,7 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
>>   
>>   static const struct btrfs_csums {
>>   	u16		size;
>> -	const char	name[10];
>> +	const char	name[12];
>>   	const char	driver[12];
>>   } btrfs_csums[] = {
>>   	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
>> @@ -39,6 +39,7 @@ static const struct btrfs_csums {
>>   	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
>>   	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
>>   				     .driver = "blake2b-256" },
>> +	[BTRFS_CSUM_TYPE_HMAC_SHA256] = { .size = 32, .name = "hmac(sha256)" }
>>   };
>>   
>>   int btrfs_super_csum_size(const struct btrfs_super_block *s)
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index c79e0b0eac54..b692b3dc4593 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -719,6 +719,7 @@ struct btrfs_fs_info {
>>   	struct rb_root swapfile_pins;
>>   
>>   	struct crypto_shash *csum_shash;
>> +	char *auth_key_name;
>>   
>>   	/*
>>   	 * Number of send operations in progress.
>> @@ -1027,6 +1028,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>>   #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>>   #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>>   #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
>> +#define BTRFS_MOUNT_AUTH_KEY		(1 << 30)
>>   
>>   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>>   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index d10c7be10f3b..fe403fb62178 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/error-injection.h>
>>   #include <linux/crc32c.h>
>>   #include <linux/sched/mm.h>
>> +#include <keys/user-type.h>
>>   #include <asm/unaligned.h>
>>   #include <crypto/hash.h>
>>   #include "ctree.h"
>> @@ -339,6 +340,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
>>   	case BTRFS_CSUM_TYPE_XXHASH:
>>   	case BTRFS_CSUM_TYPE_SHA256:
>>   	case BTRFS_CSUM_TYPE_BLAKE2:
>> +	case BTRFS_CSUM_TYPE_HMAC_SHA256:
>>   		return true;
>>   	default:
>>   		return false;
>> @@ -2187,6 +2189,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
>>   {
>>   	struct crypto_shash *csum_shash;
>>   	const char *csum_driver = btrfs_super_csum_driver(csum_type);
>> +	struct key *key;
>> +	const struct user_key_payload *ukp;
>> +	int err = 0;
>>   
>>   	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
>>   
>> @@ -2198,7 +2203,53 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
>>   
>>   	fs_info->csum_shash = csum_shash;
>>   
>> -	return 0;
>> +	/*
>> +	 * if we're not doing authentication, we're done by now. Still we have
>> +	 * to validate the possible combinations of BTRFS_MOUNT_AUTH_KEY and
>> +	 * keyed hashes.
>> +	 */
>> +	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256 &&
>> +	    !btrfs_test_opt(fs_info, AUTH_KEY)) {
>> +		crypto_free_shash(fs_info->csum_shash);
>> +		return -EINVAL;
>> +	} else if (btrfs_test_opt(fs_info, AUTH_KEY)
>> +		   && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) {
>> +		crypto_free_shash(fs_info->csum_shash);
>> +		return -EINVAL;
>> +	} else if (!btrfs_test_opt(fs_info, AUTH_KEY)) {
>> +		/*
>> +		 * This is the normal case, if noone want's authentication and
>> +		 * doesn't have a keyed hash, we're done.
>> +		 */
>> +		return 0;
>> +	}
>> +
>> +	key = request_key(&key_type_logon, fs_info->auth_key_name, NULL);
>> +	if (IS_ERR(key))
>> +		return PTR_ERR(key);
>> +
>> +	down_read(&key->sem);
>> +
>> +	ukp = user_key_payload_locked(key);
>> +	if (!ukp) {
>> +		btrfs_err(fs_info, "");
>> +		err = -EKEYREVOKED;
>> +		goto out;
>> +	}
>> +
>> +	err = crypto_shash_setkey(fs_info->csum_shash, ukp->data, ukp->datalen);
>> +	if (err)
>> +		btrfs_err(fs_info, "error setting key %s for verification",
>> +			  fs_info->auth_key_name);
>> +
>> +out:
>> +	if (err)
>> +		crypto_free_shash(fs_info->csum_shash);
>> +
>> +	up_read(&key->sem);
>> +	key_put(key);
>> +
>> +	return err;
>>   }
>>   
>>   static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 7932d8d07cff..2645a9cee8d1 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -333,6 +333,7 @@ enum {
>>   	Opt_treelog, Opt_notreelog,
>>   	Opt_usebackuproot,
>>   	Opt_user_subvol_rm_allowed,
>> +	Opt_auth_key,
>>   
>>   	/* Deprecated options */
>>   	Opt_alloc_start,
>> @@ -401,6 +402,7 @@ static const match_table_t tokens = {
>>   	{Opt_notreelog, "notreelog"},
>>   	{Opt_usebackuproot, "usebackuproot"},
>>   	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
>> +	{Opt_auth_key, "auth_key=%s"},
>>   
>>   	/* Deprecated options */
>>   	{Opt_alloc_start, "alloc_start=%s"},
>> @@ -910,7 +912,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>>    * All other options will be parsed on much later in the mount process and
>>    * only when we need to allocate a new super block.
>>    */
>> -static int btrfs_parse_device_options(const char *options, fmode_t flags,
>> +static int btrfs_parse_device_options(struct btrfs_fs_info *info,
>> +				      const char *options, fmode_t flags,
>>   				      void *holder)
>>   {
>>   	substring_t args[MAX_OPT_ARGS];
>> @@ -939,7 +942,8 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
>>   			continue;
>>   
>>   		token = match_token(p, tokens, args);
>> -		if (token == Opt_device) {
>> +		switch (token) {
>> +		case Opt_device:
>>   			device_name = match_strdup(&args[0]);
>>   			if (!device_name) {
>>   				error = -ENOMEM;
>> @@ -952,6 +956,18 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
>>   				error = PTR_ERR(device);
>>   				goto out;
>>   			}
>> +			break;
>> +		case Opt_auth_key:
>> +			info->auth_key_name = match_strdup(&args[0]);
>> +			if (!info->auth_key_name) {
>> +				error = -ENOMEM;
>> +				goto out;
>> +			}
>> +			btrfs_info(info, "doing authentication");
>> +			btrfs_set_opt(info->mount_opt, AUTH_KEY);
>> +			break;
>> +		default:
>> +			break;
>>   		}
>>   	}
>>   
>> @@ -1394,6 +1410,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>>   #endif
>>   	if (btrfs_test_opt(info, REF_VERIFY))
>>   		seq_puts(seq, ",ref_verify");
>> +	if (btrfs_test_opt(info, AUTH_KEY))
>> +		seq_printf(seq, ",auth_key=%s", info->auth_key_name);
>>   	seq_printf(seq, ",subvolid=%llu",
>>   		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>>   	seq_puts(seq, ",subvol=");
>> @@ -1542,7 +1560,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>>   	}
>>   
>>   	mutex_lock(&uuid_mutex);
>> -	error = btrfs_parse_device_options(data, mode, fs_type);
>> +	error = btrfs_parse_device_options(fs_info, data, mode, fs_type);
>>   	if (error) {
>>   		mutex_unlock(&uuid_mutex);
>>   		goto error_fs_info;
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>> index a02318e4d2a9..bfaf127b37fd 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -344,6 +344,7 @@ enum btrfs_csum_type {
>>   	BTRFS_CSUM_TYPE_XXHASH	= 1,
>>   	BTRFS_CSUM_TYPE_SHA256	= 2,
>>   	BTRFS_CSUM_TYPE_BLAKE2	= 3,
>> +	BTRFS_CSUM_TYPE_HMAC_SHA256 = 32,
>>   };
>>   
>>   /*
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
