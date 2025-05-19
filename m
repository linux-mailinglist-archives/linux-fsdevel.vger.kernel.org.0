Return-Path: <linux-fsdevel+bounces-49324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496AABB35F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 04:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE8B174A29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 02:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946C1DE2A8;
	Mon, 19 May 2025 02:38:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C21CF7AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622321; cv=none; b=hjNgiIvqJMUzpfk2M8vqhdxlSKhU3Zr7nrO/4adSZ2odNzcelUHPWVN/Tcjz29i1Urkil4HWlnnzMvGQdBO2sxPT/iBJx4jaB7madTJ/vdJIq9qCIpYHebDyva3Hg3mIiVjFpySyj78n0hBT2UpXm9GbELIeT3eDpTmk2pm/Hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622321; c=relaxed/simple;
	bh=R79nJdfeCjiJccIoBV7J2iTesRTN4c+XAvF/H8gj5lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fmJFDzOFAEup6zE4Im7LZXhylgX5CvjFfQ9lpV0fh/wPbGrOWGemceYvlU4bRIqbOYiix8T12CGo5mSRXBHOgn+6KKmxWopH08rGLaJQGQr17fQnuQYPnhDuITj7zKyubEYp5RdJJvK6XwVOPSMXqH2elaMBuDaLMUc0n7g1Qg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4b11yp2jcTz1R7M0;
	Mon, 19 May 2025 10:36:18 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 889511400D2;
	Mon, 19 May 2025 10:38:29 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 10:38:29 +0800
Message-ID: <ba636c8d-f612-4afc-813a-8bf0e9e602b3@huawei.com>
Date: Mon, 19 May 2025 10:38:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>, Eric Sandeen <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <ff2c9a74-f359-4bcc-9792-46af946c70ad@kernel.org>
 <63d1977d-2f0b-4c58-9867-0dc1285815a0@huawei.com>
 <979015aa-433d-4057-a454-afaea2c68131@kernel.org>
 <2ea178cb-1ed3-40ba-8dc6-8fa3bff06850@huawei.com>
 <aCS3LZ3IOMgiissx@google.com>
 <ceeb4951-ee88-4cae-b20a-8c06edf2bfc3@huawei.com>
 <aCd3YoPS_wm2dcff@google.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <aCd3YoPS_wm2dcff@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/5/17 1:35, Jaegeuk Kim wrote:
> On 05/16, Hongbo Li wrote:
>>
>>
>> On 2025/5/14 23:30, Jaegeuk Kim wrote:
>>> Hi, Hongbo,
>>>
>>> It seems we're getting more issues in the patch set. May I ask for some
>>> help sending the new patch series having all the fixes that I made as well
>>> as addressing the concerns? You can get the patches from [1].
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test
>>>
>>
>> Hi, Jaegeuk
>>
>> I will discuss these issues with Eric. It may take some time, but not too
>> long. When we send the next version, should we resend this patch series
>> based on dev-test after modifying the code, only removing your S-O-B?
>> (You'll ultimately add your S-O-B back yourself)
> 
> Hi Hongbo,
> 
> Thank you for this hard work. Could you please resend the entire patch-set based
> on dev-test w/o my SOB? I'm going to dequeue the series from dev-test. Instead,
> I rebased the latest version onto [2].
> 
> Please also consider another report, [1].
> 

Ok, got it!

Thanks,
Hongbo

> [1] https://lore.kernel.org/linux-f2fs-devel/2f16981b-0e13-4c64-83a8-d0e0b4297348@suswa.mountain/T/#u
> [2] https://github.com/jaegeuk/f2fs/commits/mount/
> 
>>
>> Thanks,
>> Hongbo
>>
>>> On 05/14, Hongbo Li wrote:
>>>>
>>>>
>>>> On 2025/5/14 12:03, Chao Yu wrote:
>>>>> On 5/14/25 10:33, Hongbo Li wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/5/13 16:59, Chao Yu wrote:
>>>>>>> On 4/24/25 01:08, Eric Sandeen wrote:
>>>>>>>> From: Hongbo Li <lihongbo22@huawei.com>
>>>>>>>>
>>>>>>>> The new mount api will execute .parse_param, .init_fs_context, .get_tree
>>>>>>>> and will call .remount if remount happened. So we add the necessary
>>>>>>>> functions for the fs_context_operations. If .init_fs_context is added,
>>>>>>>> the old .mount should remove.
>>>>>>>>
>>>>>>>> See Documentation/filesystems/mount_api.rst for more information.
>>>>>>>
>>>>>>> mkfs.f2fs -f -O extra_attr,flexible_inline_xattr /dev/vdb
>>>>>>> mount -o inline_xattr_size=512 /dev/vdb /mnt/f2fs
>>>>>>> mount: /mnt/f2fs: wrong fs type, bad option, bad superblock on /dev/vdb, missing codepage or helper program, or other error.
>>>>>>>            dmesg(1) may have more information after failed mount system call.
>>>>>>> dmesg
>>>>>>> [ 1758.202282] F2FS-fs (vdb): Image doesn't support compression
>>>>>>> [ 1758.202286] F2FS-fs (vdb): inline_xattr_size option should be set with inline_xattr option
>>>>>>>
>>>>>>> Eric, Hongbo, can you please take a look at this issue?
>>>>>>>
>>>>>> Sorry, we only check the option hold in ctx, we should do the double check in sbi. Or other elegant approaches.
>>>>>>
>>>>>> For the "support compression", is it also the error in this testcase?
>>>>>
>>>>> I think so, I checked this w/ additional logs, and found this:
>>>>>
>>>>> #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00080000
>>>>> #define F2FS_SPEC_compress_chksum		(1 << 19) /* equal to 0x00080000)
>>>>>
>>>>> 	if (!f2fs_sb_has_compression(sbi)) {
>>>>> 		if (test_compression_spec(ctx->opt_mask) ||
>>>>> 			ctx_test_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE))
>>>>> 			f2fs_info(sbi, "Image doesn't support compression");
>>>>> 		clear_compression_spec(ctx);
>>>>> 		ctx->opt_mask &= ~F2FS_MOUNT_COMPRESS_CACHE;
>>>>> 		return 0;
>>>>> 	}
>>>>>
>>>>> We should use test_compression_spec(ctx->spec_mask) instead of
>>>>> test_compression_spec(ctx->opt_mask) to check special mask of compression
>>>>> option?
>>>>>
>>>>
>>>> Yeah, you're right. test_compression_spec is used to check spec_mask, and we
>>>> got it wrong.
>>>>
>>>> Thanks,
>>>> Hongbo
>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Hongbo
>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>>>>>> [sandeen: forward port]
>>>>>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>>>>>> ---
>>>>>>>>      fs/f2fs/super.c | 156 +++++++++++++++++++-----------------------------
>>>>>>>>      1 file changed, 62 insertions(+), 94 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>>>> index 37497fd80bb9..041bd6c482a0 100644
>>>>>>>> --- a/fs/f2fs/super.c
>>>>>>>> +++ b/fs/f2fs/super.c
>>>>>>>> @@ -1141,47 +1141,6 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>>>>>>>          return 0;
>>>>>>>>      }
>>>>>>>>      -static int parse_options(struct fs_context *fc, char *options)
>>>>>>>> -{
>>>>>>>> -    struct fs_parameter param;
>>>>>>>> -    char *key;
>>>>>>>> -    int ret;
>>>>>>>> -
>>>>>>>> -    if (!options)
>>>>>>>> -        return 0;
>>>>>>>> -
>>>>>>>> -    while ((key = strsep(&options, ",")) != NULL) {
>>>>>>>> -        if (*key) {
>>>>>>>> -            size_t v_len = 0;
>>>>>>>> -            char *value = strchr(key, '=');
>>>>>>>> -
>>>>>>>> -            param.type = fs_value_is_flag;
>>>>>>>> -            param.string = NULL;
>>>>>>>> -
>>>>>>>> -            if (value) {
>>>>>>>> -                if (value == key)
>>>>>>>> -                    continue;
>>>>>>>> -
>>>>>>>> -                *value++ = 0;
>>>>>>>> -                v_len = strlen(value);
>>>>>>>> -                param.string = kmemdup_nul(value, v_len, GFP_KERNEL);
>>>>>>>> -                if (!param.string)
>>>>>>>> -                    return -ENOMEM;
>>>>>>>> -                param.type = fs_value_is_string;
>>>>>>>> -            }
>>>>>>>> -
>>>>>>>> -            param.key = key;
>>>>>>>> -            param.size = v_len;
>>>>>>>> -
>>>>>>>> -            ret = f2fs_parse_param(fc, &param);
>>>>>>>> -            kfree(param.string);
>>>>>>>> -            if (ret < 0)
>>>>>>>> -                return ret;
>>>>>>>> -        }
>>>>>>>> -    }
>>>>>>>> -    return 0;
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>      /*
>>>>>>>>       * Check quota settings consistency.
>>>>>>>>       */
>>>>>>>> @@ -2583,13 +2542,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
>>>>>>>>          f2fs_flush_ckpt_thread(sbi);
>>>>>>>>      }
>>>>>>>>      -static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>> +static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>>>>>>>>      {
>>>>>>>>          struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>>>>>>>          struct f2fs_mount_info org_mount_opt;
>>>>>>>> -    struct f2fs_fs_context ctx;
>>>>>>>> -    struct fs_context fc;
>>>>>>>>          unsigned long old_sb_flags;
>>>>>>>> +    unsigned int flags = fc->sb_flags;
>>>>>>>>          int err;
>>>>>>>>          bool need_restart_gc = false, need_stop_gc = false;
>>>>>>>>          bool need_restart_flush = false, need_stop_flush = false;
>>>>>>>> @@ -2635,7 +2593,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>      #endif
>>>>>>>>            /* recover superblocks we couldn't write due to previous RO mount */
>>>>>>>> -    if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
>>>>>>>> +    if (!(flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
>>>>>>>>              err = f2fs_commit_super(sbi, false);
>>>>>>>>              f2fs_info(sbi, "Try to recover all the superblocks, ret: %d",
>>>>>>>>                    err);
>>>>>>>> @@ -2645,21 +2603,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>            default_options(sbi, true);
>>>>>>>>      -    memset(&fc, 0, sizeof(fc));
>>>>>>>> -    memset(&ctx, 0, sizeof(ctx));
>>>>>>>> -    fc.fs_private = &ctx;
>>>>>>>> -    fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
>>>>>>>> -
>>>>>>>> -    /* parse mount options */
>>>>>>>> -    err = parse_options(&fc, data);
>>>>>>>> -    if (err)
>>>>>>>> -        goto restore_opts;
>>>>>>>> -
>>>>>>>> -    err = f2fs_check_opt_consistency(&fc, sb);
>>>>>>>> +    err = f2fs_check_opt_consistency(fc, sb);
>>>>>>>>          if (err < 0)
>>>>>>>>              goto restore_opts;
>>>>>>>>      -    f2fs_apply_options(&fc, sb);
>>>>>>>> +    f2fs_apply_options(fc, sb);
>>>>>>>>        #ifdef CONFIG_BLK_DEV_ZONED
>>>>>>>>          if (f2fs_sb_has_blkzoned(sbi) &&
>>>>>>>> @@ -2678,20 +2626,20 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>           * Previous and new state of filesystem is RO,
>>>>>>>>           * so skip checking GC and FLUSH_MERGE conditions.
>>>>>>>>           */
>>>>>>>> -    if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
>>>>>>>> +    if (f2fs_readonly(sb) && (flags & SB_RDONLY))
>>>>>>>>              goto skip;
>>>>>>>>      -    if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
>>>>>>>> +    if (f2fs_dev_is_readonly(sbi) && !(flags & SB_RDONLY)) {
>>>>>>>>              err = -EROFS;
>>>>>>>>              goto restore_opts;
>>>>>>>>          }
>>>>>>>>        #ifdef CONFIG_QUOTA
>>>>>>>> -    if (!f2fs_readonly(sb) && (*flags & SB_RDONLY)) {
>>>>>>>> +    if (!f2fs_readonly(sb) && (flags & SB_RDONLY)) {
>>>>>>>>              err = dquot_suspend(sb, -1);
>>>>>>>>              if (err < 0)
>>>>>>>>                  goto restore_opts;
>>>>>>>> -    } else if (f2fs_readonly(sb) && !(*flags & SB_RDONLY)) {
>>>>>>>> +    } else if (f2fs_readonly(sb) && !(flags & SB_RDONLY)) {
>>>>>>>>              /* dquot_resume needs RW */
>>>>>>>>              sb->s_flags &= ~SB_RDONLY;
>>>>>>>>              if (sb_any_quota_suspended(sb)) {
>>>>>>>> @@ -2747,7 +2695,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>              goto restore_opts;
>>>>>>>>          }
>>>>>>>>      -    if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
>>>>>>>> +    if ((flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
>>>>>>>>              err = -EINVAL;
>>>>>>>>              f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
>>>>>>>>              goto restore_opts;
>>>>>>>> @@ -2758,7 +2706,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>           * or if background_gc = off is passed in mount
>>>>>>>>           * option. Also sync the filesystem.
>>>>>>>>           */
>>>>>>>> -    if ((*flags & SB_RDONLY) ||
>>>>>>>> +    if ((flags & SB_RDONLY) ||
>>>>>>>>                  (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
>>>>>>>>                  !test_opt(sbi, GC_MERGE))) {
>>>>>>>>              if (sbi->gc_thread) {
>>>>>>>> @@ -2772,7 +2720,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>              need_stop_gc = true;
>>>>>>>>          }
>>>>>>>>      -    if (*flags & SB_RDONLY) {
>>>>>>>> +    if (flags & SB_RDONLY) {
>>>>>>>>              sync_inodes_sb(sb);
>>>>>>>>                set_sbi_flag(sbi, SBI_IS_DIRTY);
>>>>>>>> @@ -2785,7 +2733,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>           * We stop issue flush thread if FS is mounted as RO
>>>>>>>>           * or if flush_merge is not passed in mount option.
>>>>>>>>           */
>>>>>>>> -    if ((*flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
>>>>>>>> +    if ((flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
>>>>>>>>              clear_opt(sbi, FLUSH_MERGE);
>>>>>>>>              f2fs_destroy_flush_cmd_control(sbi, false);
>>>>>>>>              need_restart_flush = true;
>>>>>>>> @@ -2827,7 +2775,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>           * triggered while remount and we need to take care of it before
>>>>>>>>           * returning from remount.
>>>>>>>>           */
>>>>>>>> -    if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
>>>>>>>> +    if ((flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
>>>>>>>>                  !test_opt(sbi, MERGE_CHECKPOINT)) {
>>>>>>>>              f2fs_stop_ckpt_thread(sbi);
>>>>>>>>          } else {
>>>>>>>> @@ -2854,7 +2802,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>>>              (test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>>>>>>>>            limit_reserve_root(sbi);
>>>>>>>> -    *flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>>>>>>>> +    fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>>>>>>>>            sbi->umount_lock_holder = NULL;
>>>>>>>>          return 0;
>>>>>>>> @@ -3523,7 +3471,6 @@ static const struct super_operations f2fs_sops = {
>>>>>>>>          .freeze_fs    = f2fs_freeze,
>>>>>>>>          .unfreeze_fs    = f2fs_unfreeze,
>>>>>>>>          .statfs        = f2fs_statfs,
>>>>>>>> -    .remount_fs    = f2fs_remount,
>>>>>>>>          .shutdown    = f2fs_shutdown,
>>>>>>>>      };
>>>>>>>>      @@ -4745,16 +4692,13 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>>>>>>>>          sbi->readdir_ra = true;
>>>>>>>>      }
>>>>>>>>      -static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>> +static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>>>>>      {
>>>>>>>>          struct f2fs_sb_info *sbi;
>>>>>>>>          struct f2fs_super_block *raw_super;
>>>>>>>> -    struct f2fs_fs_context ctx;
>>>>>>>> -    struct fs_context fc;
>>>>>>>>          struct inode *root;
>>>>>>>>          int err;
>>>>>>>>          bool skip_recovery = false, need_fsck = false;
>>>>>>>> -    char *options = NULL;
>>>>>>>>          int recovery, i, valid_super_block;
>>>>>>>>          struct curseg_info *seg_i;
>>>>>>>>          int retry_cnt = 1;
>>>>>>>> @@ -4767,9 +4711,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>>          raw_super = NULL;
>>>>>>>>          valid_super_block = -1;
>>>>>>>>          recovery = 0;
>>>>>>>> -    memset(&fc, 0, sizeof(fc));
>>>>>>>> -    memset(&ctx, 0, sizeof(ctx));
>>>>>>>> -    fc.fs_private = &ctx;
>>>>>>>>            /* allocate memory for f2fs-specific super block info */
>>>>>>>>          sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
>>>>>>>> @@ -4820,22 +4761,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>>                              sizeof(raw_super->uuid));
>>>>>>>>            default_options(sbi, false);
>>>>>>>> -    /* parse mount options */
>>>>>>>> -    options = kstrdup((const char *)data, GFP_KERNEL);
>>>>>>>> -    if (data && !options) {
>>>>>>>> -        err = -ENOMEM;
>>>>>>>> -        goto free_sb_buf;
>>>>>>>> -    }
>>>>>>>> -
>>>>>>>> -    err = parse_options(&fc, options);
>>>>>>>> -    if (err)
>>>>>>>> -        goto free_options;
>>>>>>>>      -    err = f2fs_check_opt_consistency(&fc, sb);
>>>>>>>> +    err = f2fs_check_opt_consistency(fc, sb);
>>>>>>>>          if (err < 0)
>>>>>>>> -        goto free_options;
>>>>>>>> +        goto free_sb_buf;
>>>>>>>>      -    f2fs_apply_options(&fc, sb);
>>>>>>>> +    f2fs_apply_options(fc, sb);
>>>>>>>>            sb->s_maxbytes = max_file_blocks(NULL) <<
>>>>>>>>                      le32_to_cpu(raw_super->log_blocksize);
>>>>>>>> @@ -5160,7 +5091,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>>              if (err)
>>>>>>>>                  goto sync_free_meta;
>>>>>>>>          }
>>>>>>>> -    kvfree(options);
>>>>>>>>            /* recover broken superblock */
>>>>>>>>          if (recovery) {
>>>>>>>> @@ -5255,7 +5185,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>>              kfree(F2FS_OPTION(sbi).s_qf_names[i]);
>>>>>>>>      #endif
>>>>>>>>          fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
>>>>>>>> -    kvfree(options);
>>>>>>>>      free_sb_buf:
>>>>>>>>          kfree(raw_super);
>>>>>>>>      free_sbi:
>>>>>>>> @@ -5271,14 +5200,39 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>>>          return err;
>>>>>>>>      }
>>>>>>>>      -static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
>>>>>>>> -            const char *dev_name, void *data)
>>>>>>>> +static int f2fs_get_tree(struct fs_context *fc)
>>>>>>>>      {
>>>>>>>> -    return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
>>>>>>>> +    return get_tree_bdev(fc, f2fs_fill_super);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int f2fs_reconfigure(struct fs_context *fc)
>>>>>>>> +{
>>>>>>>> +    struct super_block *sb = fc->root->d_sb;
>>>>>>>> +
>>>>>>>> +    return __f2fs_remount(fc, sb);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void f2fs_fc_free(struct fs_context *fc)
>>>>>>>> +{
>>>>>>>> +    struct f2fs_fs_context *ctx = fc->fs_private;
>>>>>>>> +    int i;
>>>>>>>> +
>>>>>>>> +    if (!ctx)
>>>>>>>> +        return;
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_QUOTA
>>>>>>>> +    for (i = 0; i < MAXQUOTAS; i++)
>>>>>>>> +        kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
>>>>>>>> +#endif
>>>>>>>> +    fscrypt_free_dummy_policy(&F2FS_CTX_INFO(ctx).dummy_enc_policy);
>>>>>>>> +    kfree(ctx);
>>>>>>>>      }
>>>>>>>>        static const struct fs_context_operations f2fs_context_ops = {
>>>>>>>>          .parse_param    = f2fs_parse_param,
>>>>>>>> +    .get_tree    = f2fs_get_tree,
>>>>>>>> +    .reconfigure = f2fs_reconfigure,
>>>>>>>> +    .free    = f2fs_fc_free,
>>>>>>>>      };
>>>>>>>>        static void kill_f2fs_super(struct super_block *sb)
>>>>>>>> @@ -5322,10 +5276,24 @@ static void kill_f2fs_super(struct super_block *sb)
>>>>>>>>          }
>>>>>>>>      }
>>>>>>>>      +static int f2fs_init_fs_context(struct fs_context *fc)
>>>>>>>> +{
>>>>>>>> +    struct f2fs_fs_context *ctx;
>>>>>>>> +
>>>>>>>> +    ctx = kzalloc(sizeof(struct f2fs_fs_context), GFP_KERNEL);
>>>>>>>> +    if (!ctx)
>>>>>>>> +        return -ENOMEM;
>>>>>>>> +
>>>>>>>> +    fc->fs_private = ctx;
>>>>>>>> +    fc->ops = &f2fs_context_ops;
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static struct file_system_type f2fs_fs_type = {
>>>>>>>>          .owner        = THIS_MODULE,
>>>>>>>>          .name        = "f2fs",
>>>>>>>> -    .mount        = f2fs_mount,
>>>>>>>> +    .init_fs_context = f2fs_init_fs_context,
>>>>>>>>          .kill_sb    = kill_f2fs_super,
>>>>>>>>          .fs_flags    = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>>>>>>>>      };
>>>>>>>
>>>>>
>>>>>
>>>
>>>
> 

