Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A15B27B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIHU2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIHU2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:28:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78854EC75F;
        Thu,  8 Sep 2022 13:28:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso2318705wms.2;
        Thu, 08 Sep 2022 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=kw3e2c2V3XhwcCAs0QDug0D2e6obPmzp/LzbAj5Onvs=;
        b=BCaKzvYzTSzBG+8z1kIDDeCa86x3TGagL8qSZ0fe/ZFPG5lsgNUGtcDUurlVRxsLzG
         Wkwy2/TzsTfnVeMdBDLNjhGewUFNk8u8EcJ1oNLtrMCBPtC2+1yiR4G9czLPYa5kGEQh
         aeiR5uvB8br2Y0nISAk2uRId4SIIxzj+seaP+vURyxQsORFzzj0QzKCYlhOT28n8Z6FX
         YJYcndJlBRvigm/0ZQMcUhxJnfN+id/HlxA5RLDwslD6g4RXTBb7DiK3HkxzZWIIj5xf
         F7QDNOIN+ovfih/wJvG6clu2/BkVujy9gAN6IGcD6aeC4kTNVU8lSfv/MQT3uTqbz32H
         5MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kw3e2c2V3XhwcCAs0QDug0D2e6obPmzp/LzbAj5Onvs=;
        b=J8MwMFB3F6sLWiSnPlBHoWdp5+7nF3BR5X/RPKJEsfx3/6DzqMYJpcEo957mYGnJz/
         g3xoB1pMv5B3s8hzDVoaIRrYUyESGFUp3irJLbO8X7F32Qaf4t1wVfOmfhCx38jt7n4N
         0deX+6TB2nAi06gqedork7oBtgzqT7CXA8qAqdWd3pPoTOv/PfTmqC23ffH+oGbWQoZF
         NHB9Tupn09VnEX8Zg5kQSnPrE91OpS54NH23Q7p0z+ZuO2tjtXs3Jpc1Dln5VnvpcIOb
         TgkWbJGbS6nDbEYkQu7ZwggXHAVFYwlo7eZ6VD3XpqBwT/K0HY3EqS0AugFX36IZWq3M
         +FIA==
X-Gm-Message-State: ACgBeo1+NhpmWfDG24AIvhZs/TkZWGSgdhuwbCBwPgcyKTjgfcaABfj7
        fZ71HoIBo7HhyCJtp0plbX1Q2pqTA1c=
X-Google-Smtp-Source: AA6agR7HOydaUnEOufib+8PmuHWossnrCB53E8G2e7OcXjAo4IwwB0um+0jk1H9zwRA4RpPeKTJp2w==
X-Received: by 2002:a1c:f701:0:b0:3b3:37aa:a2e5 with SMTP id v1-20020a1cf701000000b003b337aaa2e5mr2063176wmh.58.1662668887968;
        Thu, 08 Sep 2022 13:28:07 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003a5537bb2besm3713551wmd.25.2022.09.08.13.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:28:07 -0700 (PDT)
Date:   Thu, 8 Sep 2022 22:28:05 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
Message-ID: <YxpQVTDrcJSig8X2@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-2-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908195805.128252-2-gnoack3000@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding Namjae Jeon and David Howells as authors of the respective
files in fs/ksmbd and fs/cachefiles -- do you happen to know whether
these vfs_truncate() calls are using 'struct file's that are opened by
normal userspace processes, where LSM policies may apply?

P.S. In this patch I have looked for all places where the
security_path_truncate() hook was called, to see which of these should
rather use security_file_truncate() (and I made sure that it does the
same thing for all the LSMs that use it).

I'm confident that this does the right thing when truncate() or
ftruncate() are called from userspace, but one of the places that
still calls the path-based hook is vfs_truncate(), and this is called
from more places in the kernel than just from userspace:

init/initramfs.c
387:				vfs_truncate(&wfile->f_path, body_len);

security/keys/big_key.c
172:		vfs_truncate(&payload->path, 0);

fs/cachefiles/interface.c
242:		ret = vfs_truncate(&file->f_path, dio_size);

fs/cachefiles/namei.c
497:			ret = vfs_truncate(&path, ni_size);

fs/ksmbd/smb2pdu.c
2350:	int rc = vfs_truncate(path, 0);

fs/ksmbd/vfs.c
874:	err = vfs_truncate(&filp->f_path, size);

I suspect that these are benign but am not familiar with all of these
corners of the codebase. -- The question is: Some of these call
vfs_truncate() on the f_path of an existing struct file -- should
these rather be calling the security_file_truncate() than the
security_path_truncate() hook to authorize the truncation?

Specifically, I think:

* initramfs happens at system startup and LSMs should not interfere at
  this point yet
* security/keys does not use an opened struct file, so calling the
  path-based hook through vfs_truncate() is correct
* fs/cachefiles and fs/ksmbd use the file system from the kernel to
  expose it as another file system (in a cached form for cachefiles,
  and over the network for ksmbd). I suspect that these file systems
  are not handling 'struct file's which are opened in contexts where a
  LSM applies? It that a reasonable assumption?

Thanks,
Günther

On Thu, Sep 08, 2022 at 09:58:01PM +0200, Günther Noack wrote:
> Like path_truncate, the file_truncate hook also restricts file
> truncation, but is called in the cases where truncation is attempted
> on an already-opened file.
>
> This is required in a subsequent commit to handle ftruncate()
> operations differently to truncate() operations.
>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  fs/namei.c                    |  6 +++---
>  fs/open.c                     |  4 ++--
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/apparmor/lsm.c       |  6 ++++++
>  security/security.c           |  5 +++++
>  security/tomoyo/tomoyo.c      | 13 +++++++++++++
>  7 files changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 53b4bc094db2..52105873d1f8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -53,8 +53,8 @@
>   * The new code replaces the old recursive symlink resolution with
>   * an iterative one (in case of non-nested symlink chains).  It does
>   * this with calls to <fs>_follow_link().
> - * As a side effect, dir_namei(), _namei() and follow_link() are now
> - * replaced with a single function lookup_dentry() that can handle all
> + * As a side effect, dir_namei(), _namei() and follow_link() are now
> + * replaced with a single function lookup_dentry() that can handle all
>   * the special cases of the former code.
>   *
>   * With the new dcache, the pathname is stored at each inode, at least as
> @@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
>  	if (error)
>  		return error;
>
> -	error = security_path_truncate(path);
> +	error = security_file_truncate(filp);
>  	if (!error) {
>  		error = do_truncate(mnt_userns, path->dentry, 0,
>  				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> diff --git a/fs/open.c b/fs/open.c
> index 8a813fa5ca56..0831433e493a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -188,7 +188,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>  	if (IS_APPEND(file_inode(f.file)))
>  		goto out_putf;
>  	sb_start_write(inode->i_sb);
> -	error = security_path_truncate(&f.file->f_path);
> +	error = security_file_truncate(f.file);
>  	if (!error)
>  		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
>  				    ATTR_MTIME | ATTR_CTIME, f.file);
> @@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
>  {
>  	struct filename *name = getname_kernel(filename);
>  	struct file *file = ERR_CAST(name);
> -
> +
>  	if (!IS_ERR(name)) {
>  		file = file_open_name(name, flags, mode);
>  		putname(name);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 60fff133c0b1..dee35ab253ba 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -177,6 +177,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>  	 struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)
>  LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, file_truncate, struct file *file)
>  LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>  	 unsigned long clone_flags)
>  LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7bd0c490703d..f80b23382dd9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -394,6 +394,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>  				 struct fown_struct *fown, int sig);
>  int security_file_receive(struct file *file);
>  int security_file_open(struct file *file);
> +int security_file_truncate(struct file *file);
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>  void security_task_free(struct task_struct *task);
>  int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
> @@ -1011,6 +1012,11 @@ static inline int security_file_open(struct file *file)
>  	return 0;
>  }
>
> +static inline int security_file_truncate(struct file *file)
> +{
> +	return 0;
> +}
> +
>  static inline int security_task_alloc(struct task_struct *task,
>  				      unsigned long clone_flags)
>  {
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index e29cade7b662..98ecb7f221b8 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -329,6 +329,11 @@ static int apparmor_path_truncate(const struct path *path)
>  	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
>  }
>
> +static int apparmor_file_truncate(struct file *file)
> +{
> +	return apparmor_path_truncate(&file->f_path);
> +}
> +
>  static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
>  				 const char *old_name)
>  {
> @@ -1232,6 +1237,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
>  	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
>  	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
> +	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
>
>  	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..e491120c48ba 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1210,6 +1210,11 @@ int security_path_truncate(const struct path *path)
>  	return call_int_hook(path_truncate, 0, path);
>  }
>
> +int security_file_truncate(struct file *file)
> +{
> +	return call_int_hook(file_truncate, 0, file);
> +}
> +
>  int security_path_chmod(const struct path *path, umode_t mode)
>  {
>  	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 71e82d855ebf..af04a7b7eb28 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -134,6 +134,18 @@ static int tomoyo_path_truncate(const struct path *path)
>  	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
>  }
>
> +/**
> + * tomoyo_file_truncate - Target for security_file_truncate().
> + *
> + * @file: Pointer to "struct file".
> + *
> + * Returns 0 on success, negative value otherwise.
> + */
> +static int tomoyo_file_truncate(struct file *file)
> +{
> +	return tomoyo_path_truncate(&file->f_path);
> +}
> +
>  /**
>   * tomoyo_path_unlink - Target for security_path_unlink().
>   *
> @@ -545,6 +557,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
>  	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
>  	LSM_HOOK_INIT(file_open, tomoyo_file_open),
> +	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
>  	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
>  	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
>  	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),
> --
> 2.37.3
>

--
