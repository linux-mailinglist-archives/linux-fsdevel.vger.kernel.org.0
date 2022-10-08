Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44F5F8431
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJHIIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJHIIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:08:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023BF357D1;
        Sat,  8 Oct 2022 01:08:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sc25so9460907ejc.12;
        Sat, 08 Oct 2022 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6V+wD8Ywi0fx53ia5LhphgsC5O2nKHJfRnmEVZgqdjc=;
        b=FrNil9THQ6jOCQQDmrr5p1lLQQ94n3WetSrp2Z0sY7jyRU3SHoPCyF4QU5Cdv4aKsL
         f6kccrAGmEWhGka4KnrXgbdda9MkCRr8sDtLhwKPYkJQiRBs+0mSLraB9TTTLx/ENnkY
         7vWVPXmf8Ncs6rada4+eyPnLm/KNtZsvXqrA/gopdZ3dZUhPegbx5XV/G/kWewypHL0O
         meS6wvcDhs3jl96dAAawwZydUB3UZMbDkjV8+J1UrCS6i2npFsm6R/yhFPw96MUHoChE
         pkHIKRe/bgiHR+n+gpL2irjI1Ryt5fzIJq32H13LChscmbSvKdAYPZPI3xmndoQyfd9u
         ALFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6V+wD8Ywi0fx53ia5LhphgsC5O2nKHJfRnmEVZgqdjc=;
        b=CTPzwDl2WZOGhRbShFC+anheVnj1IRJM88a8lM6/FmDF6/+/5LxtlK+1xVGv/ASxXJ
         Pp3ouUWBasB8tjQuY82Y3swR0Qq+hUoxR5L08O8rG9w/DqyXUJE3fl/suiCAXGmVM6ic
         Oyy77To8GsoPBvYQZsolECsVAH1zE5Lm2gq34tScCmb9rW9pmpMFaaUzEmTvRDIuQwgw
         6IV/U5vltmYT9YojLXZA3e5odPeIyuTdpdJeKAdMCc/rqX23zE2FlW6gTFo2321v/xDy
         inZkAu1Zx9zXN6U7bb5Gy1VvG4gZ3Fpo8dOyEAJgjDsPY3ZJwNUmXnM8eRQoz5DfqLfa
         UvQA==
X-Gm-Message-State: ACrzQf3OJs0TCDhpzw6NJ38nrjYtDyPazlnS+37RmGKBSvDg7TL8DC2B
        9AThi14tr5C8KvQQhtQ9HBE=
X-Google-Smtp-Source: AMsMyM511f7iK6agHLNb7W7JfuMgbqs8HL8cZLITCVgFWwfdpwounN9nWy9sEAU89LergYY/dA668Q==
X-Received: by 2002:a17:907:2cf3:b0:77d:89da:499c with SMTP id hz19-20020a1709072cf300b0077d89da499cmr6883152ejc.694.1665216524321;
        Sat, 08 Oct 2022 01:08:44 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b00458c07702c1sm2972364edw.23.2022.10.08.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:08:43 -0700 (PDT)
Date:   Sat, 8 Oct 2022 10:08:42 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 4/9] landlock: Support file truncation
Message-ID: <Y0EwClE+AGaZ09RL@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-5-gnoack3000@gmail.com>
 <d885ec9b-be20-8737-ec9c-e61102465e06@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d885ec9b-be20-8737-ec9c-e61102465e06@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:55:42PM +0200, Mickaël Salaün wrote:
> 
> On 01/10/2022 17:49, Günther Noack wrote:
> > Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> > 
> > This flag hooks into the path_truncate LSM hook and covers file
> > truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> > well as creat().
> > 
> > This change also increments the Landlock ABI version, updates
> > corresponding selftests, and updates code documentation to document
> > the flag.
> > 
> > The following operations are restricted:
> > 
> > open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
> > implicitly truncated as part of the open() (e.g. using O_TRUNC).
> > 
> > Notable special cases:
> > * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
> > * open() with O_TRUNC does *not* need the TRUNCATE right when it
> >    creates a new file.
> > 
> > truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
> > right.
> > 
> > ftruncate() (on a file): requires that the file had the TRUNCATE right
> > when it was previously opened.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   include/uapi/linux/landlock.h                |  21 +++-
> >   security/landlock/fs.c                       | 102 +++++++++++++++++--
> >   security/landlock/fs.h                       |  24 +++++
> >   security/landlock/limits.h                   |   2 +-
> >   security/landlock/setup.c                    |   1 +
> >   security/landlock/syscalls.c                 |   2 +-
> >   tools/testing/selftests/landlock/base_test.c |   2 +-
> >   tools/testing/selftests/landlock/fs_test.c   |   7 +-
> >   8 files changed, 144 insertions(+), 17 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 23df4e0e8ace..d830cdfdbe56 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -95,8 +95,19 @@ struct landlock_path_beneath_attr {
> >    * A file can only receive these access rights:
> >    *
> >    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> > - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> > + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> > + *   you might additionally need the `LANDLOCK_ACCESS_FS_TRUNCATE` right in
> 
> %LANDLOCK_ACCESS_FS_TRUNCATE

Done.

> > + *   order to overwrite files with :manpage:`open(2)` using `O_TRUNC` or
> > + *   :manpage:`creat(2)`.
> >    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> > + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
> > + *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> > + *   `O_TRUNC`. Whether an opened file can be truncated with
> 
> %O_TRUNC

Done. (Also in the case a few line above.)


> > + *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in the
> > + *   same way as read and write permissions are checked during
> > + *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
> > + *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since the
> > + *   third version of the Landlock ABI.
> >    *
> >    * A directory can receive access rights related to files or directories.  The
> >    * following access right is applied to the directory itself, and the
> > @@ -139,10 +150,9 @@ struct landlock_path_beneath_attr {
> >    *
> >    *   It is currently not possible to restrict some file-related actions
> >    *   accessible through these syscall families: :manpage:`chdir(2)`,
> > - *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
> > - *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
> > - *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
> > - *   :manpage:`access(2)`.
> > + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> > + *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> > + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> >    *   Future Landlock evolutions will enable to restrict them.
> >    */
> >   /* clang-format off */
> > @@ -160,6 +170,7 @@ struct landlock_path_beneath_attr {
> >   #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
> >   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
> >   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> > +#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> >   /* clang-format on */
> >   #endif /* _UAPI_LINUX_LANDLOCK_H */
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 083dd3d359de..80d507ce2305 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -146,7 +146,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> >   #define ACCESS_FILE ( \
> >   	LANDLOCK_ACCESS_FS_EXECUTE | \
> >   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > -	LANDLOCK_ACCESS_FS_READ_FILE)
> > +	LANDLOCK_ACCESS_FS_READ_FILE | \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> >   /* clang-format on */
> >   /*
> > @@ -297,6 +298,18 @@ get_handled_accesses(const struct landlock_ruleset *const domain)
> >   	return access_dom & LANDLOCK_MASK_ACCESS_FS;
> >   }
> > +/*
> > + * init_layer_masks - Populates @layer_masks such that for each access right in
> > + * @access_request, the bits for all the layers are set where this access right
> > + * is handled.
> 
> Thanks for this extra documentation!
> 
> Can you convert it to a proper code documentation (even if it not used yet),
> with a heading `/**` and a short title following the function name?
> Something like "init_layer_masks - Initialize layer masks". Please follow
> this convention for the other doc strings, or just use a paragraph in a
> simple comment (e.g. for get_required_file_open_access).
> 
> Because there is no direct link with Landlock supporting truncation, this
> should be in a standalone patch, but you can keep it in this series.

Done, I split it off into a separate patch and fixed the formatting to
use /** and the right documentation format.

I fixed up the get_required_file_open_access documentation as well,
but kept it in this patch, because it's a related change.

> > + *
> > + * @domain: The domain that defines the current restrictions.
> > + * @access_request: The requested access rights to check.
> > + * @layer_masks: The layer masks to populate.
> > + *
> > + * Returns: An access mask where each access right bit is set which is handled
> > + * in any of the active layers in @domain.
> > + */
> >   static inline access_mask_t
> >   init_layer_masks(const struct landlock_ruleset *const domain,
> >   		 const access_mask_t access_request,
> > @@ -1141,9 +1154,19 @@ static int hook_path_rmdir(const struct path *const dir,
> >   	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
> >   }
> > +static int hook_path_truncate(const struct path *const path)
> > +{
> > +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > +}
> > +
> >   /* File hooks */
> > -static inline access_mask_t get_file_access(const struct file *const file)
> > +/*
> > + * get_required_file_open_access - Returns the access rights that are required
> > + * for opening the file, depending on the file type and open mode.
> > + */
> > +static inline access_mask_t
> > +get_required_file_open_access(const struct file *const file)
> >   {
> >   	access_mask_t access = 0;
> > @@ -1163,17 +1186,82 @@ static inline access_mask_t get_file_access(const struct file *const file)
> >   static int hook_file_open(struct file *const file)
> >   {
> > +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > +	access_mask_t open_access_request, full_access_request, allowed_access;
> > +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> >   	const struct landlock_ruleset *const dom =
> >   		landlock_get_current_domain();
> > -	if (!dom)
> > +	if (!dom) {
> > +		/*
> > +		 * Grants all access rights, even if most of them are not
> > +		 * checked later on. It is more consistent.
> > +		 */
> > +		landlock_file(file)->allowed_access = LANDLOCK_MASK_ACCESS_FS;
> 
> This looks like the right approach but unfortunately, because there is
> multiple ways to get a file descriptors (e.g. memfd_create, which is worth
> mentioning in a comment), this doesn't work well. For now, it only makes
> sense for Landlock to restrict file descriptors obtained through open(2). We
> can then move this initialization to a new hook implementation for
> file_alloc_security.

Good catch -- that was indeed still a bug.

> I think this is the bug Nathan reported.

As discussed on the other thread, that is unclear, and I failed to
reproduce his crash here. He did try it with the fixed version from
your next branch.

> We should have a test with memfd_create(2) to make sure it works as
> expected. I think the documentation is still correct though.

I added the memfd_create(2) test in a separate commit, verified that
it fails with the old version of the code, as expected, and fixed the
bug in this commit with the same approach which you also took on your
next branch, by implementing a file_alloc_security hook.

> >   		return 0;
> > +	}
> > +
> >   	/*
> > -	 * Because a file may be opened with O_PATH, get_file_access() may
> > -	 * return 0.  This case will be handled with a future Landlock
> > +	 * Because a file may be opened with O_PATH, get_required_file_open_access()
> > +	 * may return 0.  This case will be handled with a future Landlock
> >   	 * evolution.
> >   	 */
> > -	return check_access_path(dom, &file->f_path, get_file_access(file));
> > +	open_access_request = get_required_file_open_access(file);
> > +
> > +	/*
> > +	 * We look up more access than what we immediately need for open(), so
> > +	 * that we can later authorize operations on opened files.
> > +	 */
> > +	full_access_request = open_access_request | optional_access;
> > +
> > +	allowed_access = full_access_request;
> > +	if (!is_access_to_paths_allowed(
> > +		    dom, &file->f_path,
> > +		    init_layer_masks(dom, full_access_request, &layer_masks),
> > +		    &layer_masks, NULL, 0, NULL, NULL)) {
> 
> I'd prefer (less error prone and easier to read) to add an
> is_access_paths_allowed branch to initialize allowed_access with
> full_access_request, and tweak this branch to initialize allowed_access with
> 0 and then populate it according to !layer_masks[access_bit].

Done, this makes sense.

> > +		unsigned long access_bit;
> > +		unsigned long access_req = full_access_request;
> 
> const unsigned long access_req

Done.

> > +
> > +		/*
> > +		 * Calculate the actual allowed access rights from layer_masks.
> > +		 * Remove each access right from allowed_access which has been
> > +		 * vetoed by any layer.
> > +		 */
> > +		for_each_set_bit(access_bit, &access_req,
> > +				 ARRAY_SIZE(layer_masks)) {
> > +			if (layer_masks[access_bit])
> > +				allowed_access &= ~BIT_ULL(access_bit); > +		}
> > +	}
> 
> We can move `landlock_file(file)->allowed_access = allowed_access` here to
> be sure that the struct file allowed access is consistent even if it should
> not be used (because access may be denied).

Done, moved it after the "if" branch to clarify that it happens unconditionally.

> > +
> > +	if (open_access_request & ~allowed_access)
> > +		return -EACCES;
> 
> And here invert the check ((open_access_request & allowed_access) ==
> open_access_request) to make it more consistent with other checks…

Done, good suggestion. I find this easier to read as well.

> > +
> > +	/*
> > +	 * For operations on already opened files (i.e. ftruncate()), it is the
> > +	 * access rights at the time of open() which decide whether the
> > +	 * operation is permitted. Therefore, we record the relevant subset of
> > +	 * file access rights in the opened struct file.
> > +	 */
> > +	landlock_file(file)->allowed_access = allowed_access;
> > +	return 0;
> 
> …and return -EACCES here.

Done.

> > +}
> > +
> > +static int hook_file_truncate(struct file *const file)
> > +{
> > +	/*
> > +	 * Allows truncation if the truncate right was available at the time of
> > +	 * opening the file, to get a consistent access check as for read, write
> > +	 * and execute operations.
> > +	 *
> > +	 * Note: For checks done based on the file's Landlock rights, we enforce
> 
> s/file's Landlock rights/file's Landlock allowed access/ maybe?

Done.

> > +	 * them independently of whether the current thread is in a Landlock
> > +	 * domain, so that open files passed between independent processes
> > +	 * retain their behaviour.
> > +	 */
> > +	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_TRUNCATE)
> > +		return 0;
> > +	return -EACCES;
> >   }
> >   static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> > @@ -1193,6 +1281,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> >   	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
> >   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
> >   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> > +	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> > +	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> 
> Please move the hook_file_truncate entry after the hook_file_open one, these
> entries are in the same order as their hook implementations.

Done.

> >   	LSM_HOOK_INIT(file_open, hook_file_open),
> >   };
> > diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> > index 8db7acf9109b..488e4813680a 100644
> > --- a/security/landlock/fs.h
> > +++ b/security/landlock/fs.h
> > @@ -36,6 +36,24 @@ struct landlock_inode_security {
> >   	struct landlock_object __rcu *object;
> >   };
> > +/**
> > + * struct landlock_file_security - File security blob
> > + *
> > + * This information is populated when opening a file in hook_file_open, and
> > + * tracks the relevant Landlock access rights that were available at the time
> > + * of opening the file. Other LSM hooks use these rights in order to authorize
> > + * operations on already opened files.
> > + */
> > +struct landlock_file_security {
> > +	/**
> > +	 * @allowed_access: Access rights that were available at the time of
> > +	 * opening the file. This is not necessarily the full set of access
> > +	 * rights available at that time, but it's the necessary subset as
> > +	 * needed to authorize later operations on the open file.
> > +	 */
> > +	access_mask_t allowed_access;
> > +};
> > +
> >   /**
> >    * struct landlock_superblock_security - Superblock security blob
> >    *
> > @@ -50,6 +68,12 @@ struct landlock_superblock_security {
> >   	atomic_long_t inode_refs;
> >   };
> > +static inline struct landlock_file_security *
> > +landlock_file(const struct file *const file)
> > +{
> > +	return file->f_security + landlock_blob_sizes.lbs_file;
> > +}
> > +
> >   static inline struct landlock_inode_security *
> >   landlock_inode(const struct inode *const inode)
> >   {
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index b54184ab9439..82288f0e9e5e 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -18,7 +18,7 @@
> >   #define LANDLOCK_MAX_NUM_LAYERS		16
> >   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
> > -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
> > +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> >   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
> >   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
> > diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> > index f8e8e980454c..3f196d2ce4f9 100644
> > --- a/security/landlock/setup.c
> > +++ b/security/landlock/setup.c
> > @@ -19,6 +19,7 @@ bool landlock_initialized __lsm_ro_after_init = false;
> >   struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
> >   	.lbs_cred = sizeof(struct landlock_cred_security),
> > +	.lbs_file = sizeof(struct landlock_file_security),
> >   	.lbs_inode = sizeof(struct landlock_inode_security),
> >   	.lbs_superblock = sizeof(struct landlock_superblock_security),
> >   };
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 735a0865ea11..f4d6fc7ed17f 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
> >   	.write = fop_dummy_write,
> >   };
> > -#define LANDLOCK_ABI_VERSION 2
> > +#define LANDLOCK_ABI_VERSION 3
> >   /**
> >    * sys_landlock_create_ruleset - Create a new ruleset
> > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> > index da9290817866..72cdae277b02 100644
> > --- a/tools/testing/selftests/landlock/base_test.c
> > +++ b/tools/testing/selftests/landlock/base_test.c
> > @@ -75,7 +75,7 @@ TEST(abi_version)
> >   	const struct landlock_ruleset_attr ruleset_attr = {
> >   		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> >   	};
> > -	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
> > +	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
> >   					     LANDLOCK_CREATE_RULESET_VERSION));
> >   	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 45de42a027c5..87b28d14a1aa 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -406,9 +406,10 @@ TEST_F_FORK(layout1, inval)
> >   #define ACCESS_FILE ( \
> >   	LANDLOCK_ACCESS_FS_EXECUTE | \
> >   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > -	LANDLOCK_ACCESS_FS_READ_FILE)
> > +	LANDLOCK_ACCESS_FS_READ_FILE | \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> > -#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
> > +#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> >   #define ACCESS_ALL ( \
> >   	ACCESS_FILE | \
> > @@ -422,7 +423,7 @@ TEST_F_FORK(layout1, inval)
> >   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
> >   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> >   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> > -	ACCESS_LAST)
> > +	LANDLOCK_ACCESS_FS_REFER)
> >   /* clang-format on */

-- 
