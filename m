Return-Path: <linux-fsdevel+bounces-44363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDADA67ECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30040425F1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E41202C40;
	Tue, 18 Mar 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEqrF0sB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897D1DF240;
	Tue, 18 Mar 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333679; cv=none; b=WoKYmfmloiM2a0L4qvVDTzPqmJrxNtV4+RKqpNh9wj/XdElkpqO8zX4PbR4EdKMRnOGBNlz6XbiWD9bYQZ/izBgVq+pmzPSPaBZ3ODjiMKK4E1Lq8nBIntKgPJJbuoWq88ppaM8TSYarRl42eF4ZTDbqPN/n1VTx1riyuGk7DdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333679; c=relaxed/simple;
	bh=0buc3BGABQvvmyt7LtwOJk9M8Xme5yFmFEtBpPy9beM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7cfSxqiWWH3ZJ6b9TBG8JTPDeqYJ07EHxhbAJk6whzfii4yFs6Rvn8UBAiu0VhTL+LnIQoiUSYLW7vgAIQ2THzn5ohahxewkhXmouuT0roj8udaikNRUsH23JJmzNl8VQa4KEBS5xMQZB0mOs5e5AD06BQffZh7UsXkfdV9T3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEqrF0sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AD5C4CEEE;
	Tue, 18 Mar 2025 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742333679;
	bh=0buc3BGABQvvmyt7LtwOJk9M8Xme5yFmFEtBpPy9beM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TEqrF0sBlKlIPeUptkRRioQWdiq120tSzX0zDaBWFezUzKLo2SUCCS7FlOL8N1eqs
	 0/5N+p37M+SG45TwYaQnhjkNKV8hQCjeeemkl4yiLkuFBpGMhZgMCUWKOMd9PL2E7U
	 ND3h7cAFG2Y9itYjc90Gmgv+wZYbL9mMMxvcpfKSCA1RzGKpfIf/JiDXVZ2/a233Vm
	 Y9EGTjOrpYpqASZsBll64rQKv7wT/FRGyrI/AC8hukmIXvyoBBReCcxpNY276VLXt7
	 XCSZqvW3zh/xFaSRVnvLaOxMsUI+q669WN0BSx1GLvaWe3AAZgeHNFS54Xe27SwdQB
	 bUzsHS7dW4clA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so6616217e87.2;
        Tue, 18 Mar 2025 14:34:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXj732RRBgtYEc0CJ6pOVX4zM1VP6JA4moerNj92gCmFlwtg+it8tdpQCPxdUi3DGjfGG4N5R+HCUoOJQZj@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKsNPPGz1bRYiYDPcRNQ7EcvEiHMFTDVrv02zpfU6No1jWCAX
	sqyjrPeRn8rtBIBJ4ZV+suyEtkZ3jX5Dpppua968RmbDsmNkuCO1Qxk5Ps0V9zryCZAnk5N32yY
	NtyoiTtqKUVLiJIQcvdS8EekQGyU=
X-Google-Smtp-Source: AGHT+IHlVI/Lt50jV+R+EgmmvzfyZsQIZMmQ/SiEwWwNjsZEWgf5aq5RWwvcuzsg2PgnpRSELXo5OV7OjHk3bSRppTg=
X-Received: by 2002:a05:6512:1305:b0:545:a2f:22b4 with SMTP id
 2adb3069b0e04-54acb1fe2a3mr27577e87.40.1742333677615; Tue, 18 Mar 2025
 14:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com> <20250318194111.19419-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250318194111.19419-4-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Mar 2025 22:34:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOJLFXyGq6bH06BvDM_vTEpTB30qyd3dzA596XVa3ngg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp5oA-4h7b25JUC6aRijZPnXZHB8IjWV-shL0spVXHlLldcTQZIF53YP74
Message-ID: <CAMj1kXFOJLFXyGq6bH06BvDM_vTEpTB30qyd3dzA596XVa3ngg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] efivarfs: replace iterate_dir with libfs function simple_iterate_call
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 20:46, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This relieves us of the requirement to have a struct path and use file
> operations, which greatly simplifies the code.  The superblock is now
> pinned by the blocking notifier (which is why deregistration moves
> above kill_litter_super).
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/efivarfs/super.c | 103 +++-----------------------------------------
>  1 file changed, 7 insertions(+), 96 deletions(-)
>

I like this a lot. Assuming it gets blessed by the VFS maintainers,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 81b3c6b7e100..135b0bb9b4b5 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -393,29 +393,13 @@ static const struct fs_context_operations efivarfs_context_ops = {
>         .reconfigure    = efivarfs_reconfigure,
>  };
>
> -struct efivarfs_ctx {
> -       struct dir_context ctx;
> -       struct super_block *sb;
> -       struct dentry *dentry;
> -};
> -
> -static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
> -                          loff_t offset, u64 ino, unsigned mode)
> +static bool efivarfs_iterate_callback(void *data, struct dentry *dentry)
>  {
>         unsigned long size;
> -       struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
> -       struct qstr qstr = { .name = name, .len = len };
> -       struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
> -       struct inode *inode;
> -       struct efivar_entry *entry;
> +       struct inode *inode = d_inode(dentry);
> +       struct efivar_entry *entry = efivar_entry(inode);
>         int err;
>
> -       if (IS_ERR_OR_NULL(dentry))
> -               return true;
> -
> -       inode = d_inode(dentry);
> -       entry = efivar_entry(inode);
> -
>         err = efivar_entry_size(entry, &size);
>         size += sizeof(__u32);  /* attributes */
>         if (err)
> @@ -426,12 +410,10 @@ static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
>         inode_unlock(inode);
>
>         if (!size) {
> -               ectx->dentry = dentry;
> -               return false;
> +               pr_info("efivarfs: removing variable %pd\n", dentry);
> +               simple_recursive_removal(dentry, NULL);
>         }
>
> -       dput(dentry);
> -
>         return true;
>  }
>
> @@ -474,33 +456,11 @@ static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
>         return err;
>  }
>
> -static void efivarfs_deactivate_super_work(struct work_struct *work)
> -{
> -       struct super_block *s = container_of(work, struct super_block,
> -                                            destroy_work);
> -       /*
> -        * note: here s->destroy_work is free for reuse (which
> -        * will happen in deactivate_super)
> -        */
> -       deactivate_super(s);
> -}
> -
> -static struct file_system_type efivarfs_type;
> -
>  static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
>                               void *ptr)
>  {
>         struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
>                                                     pm_nb);
> -       struct path path;
> -       struct efivarfs_ctx ectx = {
> -               .ctx = {
> -                       .actor  = efivarfs_actor,
> -               },
> -               .sb = sfi->sb,
> -       };
> -       struct file *file;
> -       struct super_block *s = sfi->sb;
>         static bool rescan_done = true;
>
>         if (action == PM_HIBERNATION_PREPARE) {
> @@ -513,64 +473,15 @@ static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
>         if (rescan_done)
>                 return NOTIFY_DONE;
>
> -       /* ensure single superblock is alive and pin it */
> -       if (!atomic_inc_not_zero(&s->s_active))
> -               return NOTIFY_DONE;
> -
>         pr_info("efivarfs: resyncing variable state\n");
>
> -       path.dentry = sfi->sb->s_root;
> -
> -       /*
> -        * do not add SB_KERNMOUNT which a single superblock could
> -        * expose to userspace and which also causes MNT_INTERNAL, see
> -        * below
> -        */
> -       path.mnt = vfs_kern_mount(&efivarfs_type, 0,
> -                                 efivarfs_type.name, NULL);
> -       if (IS_ERR(path.mnt)) {
> -               pr_err("efivarfs: internal mount failed\n");
> -               /*
> -                * We may be the last pinner of the superblock but
> -                * calling efivarfs_kill_sb from within the notifier
> -                * here would deadlock trying to unregister it
> -                */
> -               INIT_WORK(&s->destroy_work, efivarfs_deactivate_super_work);
> -               schedule_work(&s->destroy_work);
> -               return PTR_ERR(path.mnt);
> -       }
> -
> -       /* path.mnt now has pin on superblock, so this must be above one */
> -       atomic_dec(&s->s_active);
> -
> -       file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
> -                               current_cred());
> -       /*
> -        * safe even if last put because no MNT_INTERNAL means this
> -        * will do delayed deactivate_super and not deadlock
> -        */
> -       mntput(path.mnt);
> -       if (IS_ERR(file))
> -               return NOTIFY_DONE;
> -
>         rescan_done = true;
>
>         /*
>          * First loop over the directory and verify each entry exists,
>          * removing it if it doesn't
>          */
> -       file->f_pos = 2;        /* skip . and .. */
> -       do {
> -               ectx.dentry = NULL;
> -               iterate_dir(file, &ectx.ctx);
> -               if (ectx.dentry) {
> -                       pr_info("efivarfs: removing variable %pd\n",
> -                               ectx.dentry);
> -                       simple_recursive_removal(ectx.dentry, NULL);
> -                       dput(ectx.dentry);
> -               }
> -       } while (ectx.dentry);
> -       fput(file);
> +       simple_iterate_call(sfi->sb->s_root, NULL, efivarfs_iterate_callback);
>
>         /*
>          * then loop over variables, creating them if there's no matching
> @@ -609,8 +520,8 @@ static void efivarfs_kill_sb(struct super_block *sb)
>         struct efivarfs_fs_info *sfi = sb->s_fs_info;
>
>         blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
> -       kill_litter_super(sb);
>         unregister_pm_notifier(&sfi->pm_nb);
> +       kill_litter_super(sb);
>
>         kfree(sfi);
>  }
> --
> 2.43.0
>
>

