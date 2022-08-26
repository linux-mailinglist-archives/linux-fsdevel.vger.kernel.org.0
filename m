Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D365A2D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344686AbiHZRLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiHZRLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:11:51 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B9B0887
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661533908; bh=BjGErp7VQSmdg7wKiwYWi91SipqV8tAxeV5RpgsuZJk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VpwjT+KuH0NEw1UpFqYe5lZN8Ay1Hr9CgBJnpDEvzGHNqqQKvid2R/Z4l9WHI6Od9S4oMz3qcIgKx4ybmKAwd6m0mfz0a59OjZOuiahF6Dq5rS+930fSNjXFKfSWzNluNGtmylr75nOi5J5X+hf1rx2zobo2Mg95pNya9/BpqptYvYvQSJt0o/kXzC7R5MGSyUjRMW99yaXWA4CrtlV5xHw5a0C1QcdPneg4IFiSPn0dmJMvM1yaFxRWmZUsUFOG1Gagb7xvFzwkGodPMZ7i0Y0rbmm9y1ei4w3iuijc7QhRTagBPIzce08mPBSqwRtEVBmhVuLBinmkpIpf+C3qfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661533908; bh=ZZR9W96fDTqng5nBAch+HJ4ZoRq6+NrR6e+OImz1Mgq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cGGkzHsKMnVEHEzXAz0gfYtIEM/f1p643Pik7eHRbugy4NfNG5TPBVLMM7irGrmBchPUF2dyoy2NFrqHNdSPn2Im9smqYqN5RPIEZAsg5wINETEtmagbYA3VwPbWVD04ubDhlpKbqh6Gd6Z60fl4vNXbAMyreWQHq49vfSgx2Nv+wg+C2xK+QZhQ6qtciPdudaVfL+cRX9Jl957f1g2bC7OKwUU+6NnvM5D2dD34zWcvYbg0xd3cciYzL8uEcQe2bHDDiHstWFm0FNzQs2a9RzLKO7wVJ62zU3JN4MfzdFSKBcGHbDFHopLSC5X1rePxMc5yjLSbOacIo4jLrtG7ng==
X-YMail-OSG: M7cMbVsVM1lrmseMSVC4dQ3B0ZM8N4eGmeogdbfj3CF9Iula_84w99aM6p3.b.s
 .ExIttB8KbA.e_WJMV5BLIWmxYbx30wil93BJYjlBeTms3B5R.BqkcD7K4HxNJ9fIrOG_zBV4v0.
 3xouBFazjp5dBnDpSCeTgz3IWsYRX7s6n6dmgpTxUWqeeSHsIOdwB8jzqWUQvnud9ig8duuHBEEE
 5XkK1KNjJYc9cMh_mJ1GJRKWmWhJJtqTvLw8EUDbC2dFdcb5gGIDWJ_Y25FtDn4V2Y97Xd.hyQfB
 AqLTUGTV0KPzZSNJNrsooLjyxqIM6Qk2HrFXJhBeBYgeWquvlGZW2_WaZU1hifHzq6PdFcjxGptK
 bVtqMoYQs8xVjFXoEg.CA8hF5O3WYrHdlOBY4OI2xbFNSpeqiqrdUvBzEdy7yRn30MThnfRGQKvG
 ZmxBm5uwk.A8n.Yt8gJDzWZmtvivpP56cgWH7bvDNOSFAdn24npQ1pvm0pJ8aKAEjVuvsfZYltVi
 ELFjXXAPqwe02MXuG4qb7lvkQ1XxAWTRBgzSLDLFxdIjoh_P3Lv9mnQOhZ.w74VUuRraRW4d2p3W
 8Vj3saayDFK0fUDyx5qtcNzlFqcyt22kpa6pgvdVGyn1l66OogUJqVhPxj3wYZME2M7cCQ822Ud1
 86tL6bWsJD5r9wLVHUqift516aqx9gacFBo96RCpGmTd2f4UK5hzkp97pzce7rV_wR07Hin.WofH
 0WvtKpwYfhL8PpdQFvOLH.BzWUR_oHloOSdHD.1A69SIfbOHqRBESjUr6k8NBerZ0xoe6xBHB9QQ
 tx8JS8Ismj7xm_cQ19NFjsvDsUW8b9kee9uZB_On_oMLE7lqFAqnb9I7nlDlIgKre8JywMf6qU5J
 pzWCucNySA3NuWD7JFs_xZETfUz1dHRyOAjYQmNYtKKqDa_y29G1CJMDc8DtTNJJnoWE4OiVgMF9
 OgUxzowIxURZHPXhjP3KSLKnDBkVWLWEwMtJ9_uD55ZRKNnB2ccNxR3qKTQTAZUAy4ZcdUKSVSDH
 u8T9__19eTy5IrV.OOACAOI3TqYOi6pJE1lTmhUYSIbokc_gYxLtwDXlcTKZlnr4bE0zAd0kE5p9
 xoI2oy7jZDFfiSNgVB0cP.ziRtPZ.Aj0DMu0iRl84_ymhr6ySLW7FHqGL5ox5DXp1TbT8j3IRht3
 R.FPuP8nv7F5K3qxWhItp2w.pux1JgDqtAblTFrUwJi.0ZW7YW3iJQ9rHdB9e53SfL.zSlXvkUiI
 6A1uyTnirw8_hmN3Uk8UQAvkMwRjXjSfylBQ.o125Qc4Bio_Rov5kaQ_XsGFMtNZm8Iz3aIB2ukR
 H767kc0d_ApQ9bXiL7RP9Ld57QKN_LLQNxHz1b6L0KsPzGPjwC3nO9OtmeiDCnY31qPlruZELZcI
 NLNROpW.ak4rP3ZZEtlKnRcDwBBE_cqR6DHX9DNImZn5qoo3_QYwsdz1QHCgY3gGrVNJsr2taqKj
 V8YD5T8YHIwSlZr763eggOGHQ9cJKk2uDVRfsPfp1gVA.MZrwKKySdhgrFGAhCVnw6QXBNiGRn5V
 kLx6ItBj9bTNNajTSgWb0WmcDZIAR3PUlEron4I1AggHLqYvjdkZwAw7AhBcrEFP3Q23y1ydPUPH
 0nDQHo.MrCLL43ULdajwzowP1nBwBs8bpW5oiFskrsp7kgOmm_YoZmhcU_7.2xd7WRvIWWvUcw2w
 FZCl4fgQz6UL4aHxhops4tqN_XO8lIdx8FzdNuslX2cBcNH5vSHFajbqhlK5Z7KPYIgXhmSXcuvW
 6L0AXI_fk87KK8U3Ely464l7nzqn9dQObJa3U1VEfWFJOWobo741whJjsTfbZLuP5V3.BIo3mCSr
 BQu7UOGZ_WOQAFXJH1mHmjT9RBC74CzdbxZJ0LehXnABggcWnFS1E91x60HxQ22k2i0bLdeh1.gw
 08AMS2dOjcNdxvnfc75XNygZ5QtA1k3aW5doynaT7IyI3P.qacFTSfET1IS1rxDUUtmnVabh50H5
 QXS6a6HEVMUW7vtKeRHW1d4cYmvzFLRetxsyLjmb8M8H39QV1Og9PyuWhgpMGLr_AJuKSNotgCpl
 FiSkq84KFD.nc2Ok6pl_u1sBNaz3RrY.L9QOGOLKqWSxcuob_Y0nmBSKB7FLyj7Wo2KlHnN1Da9x
 tWUwnoqemNHKAyY3Hne74XZlsc_sPLZGOn7wlnB8kJDKCMIGkbbCXduFEhfkYLz5nvbqpTjfAl8A
 xQiMq6cATqKYGLcVBHz.dW.l40edza8AuzXHJgDiI9RHx6IU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Aug 2022 17:11:48 +0000
Received: by hermes--production-ne1-6649c47445-rtgvf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d1446b6f120dd0671a202e122773c63d;
          Fri, 26 Aug 2022 17:11:44 +0000 (UTC)
Message-ID: <c648aa7c-a49c-a7e2-6a05-d1dfe44b8fdb@schaufler-ca.com>
Date:   Fri, 26 Aug 2022 10:11:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk>
 <20220826082439.wdestxwkeccsyqtp@wittgenstein>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220826082439.wdestxwkeccsyqtp@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/26/2022 1:24 AM, Christian Brauner wrote:
> On Wed, Aug 24, 2022 at 11:09:50AM +0100, David Howells wrote:
>> When NFS superblocks are created by automounting, their LSM parameters
>> aren't set in the fs_context struct prior to sget_fc() being called,
>> leading to failure to match existing superblocks.
>>
>> Fix this by adding a new LSM hook to load fc->security for submount
>> creation when alloc_fs_context() is creating the fs_context for it.
>>
>> However, this uncovers a further bug: nfs_get_root() initialises the
>> superblock security manually by calling security_sb_set_mnt_opts() or
>> security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
>> security_sb_set_mnt_opts(), which can lead to SELinux, at least,
>> complaining.
>>
>> Fix that by adding a flag to the fs_context that suppresses the
>> security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
>> when it sets the LSM context on the new superblock.
>>
>> The first bug leads to messages like the following appearing in dmesg:
>>
>> 	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
>>
>> Changes
>> =======
>> ver #4)
>>  - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
>>    Smack.
>>
>> ver #3)
>>  - Made LSM parameter extraction dependent on fc->purpose ==
>>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
>>
>> ver #2)
>>  - Added Smack support
>>  - Made LSM parameter extraction dependent on reference != NULL.
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
>> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
>> Tested-by: Jeff Layton <jlayton@kernel.org>
>> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
>> cc: Anna Schumaker <anna@kernel.org>
>> cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> cc: Scott Mayhew <smayhew@redhat.com>
>> cc: Jeff Layton <jlayton@kernel.org>
>> cc: Paul Moore <paul@paul-moore.com>
>> cc: Casey Schaufler <casey@schaufler-ca.com>
>> cc: linux-nfs@vger.kernel.org
>> cc: selinux@vger.kernel.org
>> cc: linux-security-module@vger.kernel.org
>> cc: linux-fsdevel@vger.kernel.org
>> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
>> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
>> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
>> ---
>>
>>  fs/fs_context.c               |    4 +++
>>  fs/nfs/getroot.c              |    1 +
>>  fs/super.c                    |   10 +++++---
>>  include/linux/fs_context.h    |    1 +
>>  include/linux/lsm_hook_defs.h |    1 +
>>  include/linux/lsm_hooks.h     |    6 ++++-
>>  include/linux/security.h      |    6 +++++
>>  security/security.c           |    5 ++++
>>  security/selinux/hooks.c      |   27 +++++++++++++++++++++
>>  security/smack/smack_lsm.c    |   54 +++++++++++++++++++++++++++++++++++++++++
>>  10 files changed, 110 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fs_context.c b/fs/fs_context.c
>> index 24ce12f0db32..22248b8a88a8 100644
>> --- a/fs/fs_context.c
>> +++ b/fs/fs_context.c
>> @@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>>  		break;
>>  	}
>>  
>> +	ret = security_fs_context_init(fc, reference);
>> +	if (ret < 0)
>> +		goto err_fc;
>> +
>>  	/* TODO: Make all filesystems support this unconditionally */
>>  	init_fs_context = fc->fs_type->init_fs_context;
>>  	if (!init_fs_context)
>> diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
>> index 11ff2b2e060f..651bffb0067e 100644
>> --- a/fs/nfs/getroot.c
>> +++ b/fs/nfs/getroot.c
>> @@ -144,6 +144,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
>>  	}
>>  	if (error)
>>  		goto error_splat_root;
>> +	fc->lsm_set = true;
>>  	if (server->caps & NFS_CAP_SECURITY_LABEL &&
>>  		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
>>  		server->caps &= ~NFS_CAP_SECURITY_LABEL;
>> diff --git a/fs/super.c b/fs/super.c
>> index 734ed584a946..94666c0c92a4 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1552,10 +1552,12 @@ int vfs_get_tree(struct fs_context *fc)
>>  	smp_wmb();
>>  	sb->s_flags |= SB_BORN;
>>  
>> -	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
>> -	if (unlikely(error)) {
>> -		fc_drop_locked(fc);
>> -		return error;
>> +	if (!(fc->lsm_set)) {
>> +		error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
>> +		if (unlikely(error)) {
>> +			fc_drop_locked(fc);
>> +			return error;
>> +		}
>>  	}
>>  
>>  	/*
>> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
>> index 13fa6f3df8e4..3876dd96bb20 100644
>> --- a/include/linux/fs_context.h
>> +++ b/include/linux/fs_context.h
>> @@ -110,6 +110,7 @@ struct fs_context {
>>  	bool			need_free:1;	/* Need to call ops->free() */
>>  	bool			global:1;	/* Goes into &init_user_ns */
>>  	bool			oldapi:1;	/* Coming from mount(2) */
>> +	bool			lsm_set:1;	/* security_sb_set/clone_mnt_opts() already done */
>>  };
>>  
>>  struct fs_context_operations {
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 806448173033..40ac14d772da 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *f
>>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
>>  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
>>  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
>> +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct dentry *reference)
>>  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>>  	 struct fs_context *src_sc)
>>  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 84a0d7e02176..aec42d6287b5 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -87,8 +87,12 @@
>>   * Security hooks for mount using fs_context.
>>   *	[See also Documentation/filesystems/mount_api.rst]
>>   *
>> + * @fs_context_init:
>> + *	Initialise fc->security.  This is initialised to NULL by the caller.
>> + *	@fc indicates the new filesystem context.
>> + *	@dentry indicates a reference for submount/remount
>>   * @fs_context_dup:
>> - *	Allocate and attach a security structure to sc->security.  This pointer
>> + *	Allocate and attach a security structure to fc->security.  This pointer
>>   *	is initialised to NULL by the caller.
>>   *	@fc indicates the new filesystem context.
>>   *	@src_fc indicates the original filesystem context.
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 1bc362cb413f..e7dfe38df72d 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -291,6 +291,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
>>  int security_bprm_check(struct linux_binprm *bprm);
>>  void security_bprm_committing_creds(struct linux_binprm *bprm);
>>  void security_bprm_committed_creds(struct linux_binprm *bprm);
>> +int security_fs_context_init(struct fs_context *fc, struct dentry *reference);
>>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
>>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
>>  int security_sb_alloc(struct super_block *sb);
>> @@ -622,6 +623,11 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
>>  {
>>  }
>>  
>> +static inline int security_fs_context_init(struct fs_context *fc,
>> +					   struct dentry *reference)
>> +{
>> +	return 0;
>> +}
>>  static inline int security_fs_context_dup(struct fs_context *fc,
>>  					  struct fs_context *src_fc)
>>  {
>> diff --git a/security/security.c b/security/security.c
>> index 14d30fec8a00..7b677087c4eb 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -880,6 +880,11 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
>>  	call_void_hook(bprm_committed_creds, bprm);
>>  }
>>  
>> +int security_fs_context_init(struct fs_context *fc, struct dentry *reference)
>> +{
>> +	return call_int_hook(fs_context_init, 0, fc, reference);
>> +}
>> +
>>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>>  {
>>  	return call_int_hook(fs_context_dup, 0, fc, src_fc);
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 79573504783b..c09dcf6df2b6 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2765,6 +2765,32 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
>>  				   FILESYSTEM__UNMOUNT, NULL);
>>  }
>>  
>> +static int selinux_fs_context_init(struct fs_context *fc,
>> +				   struct dentry *reference)
>> +{
>> +	const struct superblock_security_struct *sbsec;
>> +	const struct inode_security_struct *root_isec;
>> +	struct selinux_mnt_opts *opts;
>> +
>> +	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
>> +		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
>> +		if (!opts)
>> +			return -ENOMEM;
>> +
>> +		root_isec = backing_inode_security(reference->d_sb->s_root);
>> +		sbsec = selinux_superblock(reference->d_sb);
>> +		if (sbsec->flags & FSCONTEXT_MNT)
>> +			opts->fscontext_sid	= sbsec->sid;
>> +		if (sbsec->flags & CONTEXT_MNT)
>> +			opts->context_sid	= sbsec->mntpoint_sid;
>> +		if (sbsec->flags & DEFCONTEXT_MNT)
>> +			opts->defcontext_sid	= sbsec->def_sid;
>> +		fc->security = opts;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int selinux_fs_context_dup(struct fs_context *fc,
>>  				  struct fs_context *src_fc)
>>  {
>> @@ -7236,6 +7262,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  	/*
>>  	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>>  	 */
>> +	LSM_HOOK_INIT(fs_context_init, selinux_fs_context_init),
>>  	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>>  	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>>  	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 001831458fa2..8665428481d3 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -612,6 +612,59 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
>>  	return -EINVAL;
>>  }
>>  
>> +/**
>> + * smack_fs_context_init - Initialise security data for a filesystem context
>> + * @fc: The filesystem context.
>> + * @reference: Reference dentry (automount/reconfigure) or NULL
>> + *
>> + * Returns 0 on success or -ENOMEM on error.
>> + */
>> +static int smack_fs_context_init(struct fs_context *fc,
>> +				 struct dentry *reference)
>> +{
>> +	struct superblock_smack *sbsp;
>> +	struct smack_mnt_opts *ctx;
>> +	struct inode_smack *isp;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +	fc->security = ctx;
>> +
>> +	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
>> +		sbsp = smack_superblock(reference->d_sb);
>> +		isp = smack_inode(reference->d_sb->s_root->d_inode);
>> +
>> +		if (sbsp->smk_default) {
>> +			ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
>> +			if (!ctx->fsdefault)
>> +				return -ENOMEM;
>> +		}
>> +
>> +		if (sbsp->smk_floor) {
>> +			ctx->fsfloor = kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
>> +			if (!ctx->fsfloor)
>> +				return -ENOMEM;
>> +		}
>> +
>> +		if (sbsp->smk_hat) {
>> +			ctx->fshat = kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
>> +			if (!ctx->fshat)
>> +				return -ENOMEM;
>> +		}
>> +
>> +		if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
>> +			if (sbsp->smk_root) {
>> +				ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
>> +				if (!ctx->fstransmute)
>> +					return -ENOMEM;
> Just curious, how's freeing that worked for this case? Is all of that
> memory dropped in ops->free() somehow?

Yes, in the current implementation. However ...

The authors of this version of the mount code failed to look
especially closely at how Smack maintains label names. Once a
label name is used in the kernel it is kept on a list forever.
All the copies of smk_known here and in the rest of the mount
infrastructure are unnecessary and wasteful. The entire set of
Smack hooks that deal with mounting need to be reworked to remove
that waste. It's on my list of Smack cleanups, but I'd be happy
if someone else wanted a go at it.

