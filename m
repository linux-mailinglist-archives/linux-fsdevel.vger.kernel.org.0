Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B535B5D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiILP24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiILP2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:28:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126542496B;
        Mon, 12 Sep 2022 08:28:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh9so21094560ejc.8;
        Mon, 12 Sep 2022 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=n4UoG8qELydLYS2y8sq7NIIKGwqJO/DaDGgVEG65wA8=;
        b=ICdLujNzhxacUBuQBIw1SaHKu8NIa7lfF24bsWBfQvmcukGblB5mG9/YaSpkzfKrCx
         46tcehEA5XAOI+BHekvcBBKWRHa5k/YAnYQ2KBko47Ld5UYwOYcbe+hSE/xzHzRn7kiN
         3r1c84kFIzeyCMWeqDY3EENlaw48+GpGGQfdL8+TeTmeHhUoJPtkHbkA8GQBQekkJkWj
         vwgJjLOy+9LHQ2o2FfqRgesHI6mkCWEmD2ey8pQ9hYg1G//Fm5VEvhKvKnPYH4Nvq1XT
         lBLZnBdWdKIs6WZ5HW7Nmfa/N0AWKA7POo2+RyvAfvzP1VcAYfnK49ikhrDUjHzvQ0PK
         0Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n4UoG8qELydLYS2y8sq7NIIKGwqJO/DaDGgVEG65wA8=;
        b=xUc4Vp7bwn8pM00+1AcdXmoAGKLEmMpQd2r6f9NH3N1mkrzlOQDfbMhEHixQ08A9+0
         XhybAMuW2oE7Fj+fqYbGK/cqTKDcSuRYHdzOTbFZQ4Jo2PEiOGLYcfhyPsMR+dmN4zky
         2IEmCDHjwiBZCHYouYBT903Xw1FsIP3b2xmH08O4mPoLF5ASU49bhC7UBB3tMl9KVx2U
         fHpgsIAsrOlJ7r7MDNv60DuWfsypI6vT0RtWmfT03S5E02ORBV3SftLFzCD99wxXLrJT
         SYbwjIr+bs16ULwhy/HRdj9QfkM2G5d2WqScuqDR03zTXw+pGj2ouF0BEBGqNG9otTsz
         Sx7A==
X-Gm-Message-State: ACgBeo2P/JWu9FsyKHGdYh6idMQFNgeOkJyRRROZUZCoHhRWqBK4Dzl/
        QFcJgAfOXsskTtk+BQhxGtWzHEu48bk=
X-Google-Smtp-Source: AA6agR5nl5eLU+oH11rNrxkUMtxWPtRBV4nsy1Gm0t50Nx361Sj1+mmNmHESc9g5CVtbB+sU+mZGUg==
X-Received: by 2002:a17:906:fe08:b0:77e:a290:988e with SMTP id wy8-20020a170906fe0800b0077ea290988emr2330784ejb.223.1662996532433;
        Mon, 12 Sep 2022 08:28:52 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b0077077c62cadsm4624941ejh.31.2022.09.12.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:28:51 -0700 (PDT)
Date:   Mon, 12 Sep 2022 17:28:49 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Message-ID: <Yx9QMbOA3i2i12ve@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
 <b5984fd3-6310-9803-8b33-99715beeccfb@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5984fd3-6310-9803-8b33-99715beeccfb@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 03:51:16PM +0200, Mickaël Salaün wrote:
> 
> On 08/09/2022 21:58, Günther Noack wrote:
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
> >   include/uapi/linux/landlock.h                | 18 ++--
> >   security/landlock/fs.c                       | 88 +++++++++++++++++++-
> >   security/landlock/fs.h                       | 18 ++++
> >   security/landlock/limits.h                   |  2 +-
> >   security/landlock/setup.c                    |  1 +
> >   security/landlock/syscalls.c                 |  2 +-
> >   tools/testing/selftests/landlock/base_test.c |  2 +-
> >   tools/testing/selftests/landlock/fs_test.c   |  7 +-
> >   8 files changed, 124 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 23df4e0e8ace..8c0124c5cbe6 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
> > + *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> > + *   `O_TRUNC`. The right to truncate a file gets carried along with an opened
> > + *   file descriptor for the purpose of :manpage:`ftruncate(2)`.
> 
> You can add a bit to explain that it is the same behavior as for
> LANDLOCK_ACCESS_FS_{READ,WRITE}_FILE .

Done.

> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index a9dbd99d9ee7..1b546edf69a6 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > +static inline access_mask_t
> > +get_path_access_rights(const struct landlock_ruleset *const domain,
> > +		       const struct path *const path,
> > +		       access_mask_t access_request)
> > +{
> > +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > +	unsigned long access_bit;
> > +	unsigned long access_req;
> 
> unsigned long access_bit, long access_req;

Done. Made it unsigned long access_bit, access_req;

> > +	init_layer_masks(domain, access_request, &layer_masks);
> > +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
> > +				    NULL, 0, NULL, NULL)) {
> > +		/*
> > +		 * Return immediately for successful accesses and for cases
> 
> Returns

Done.

> > +		 * where everything is permitted because the path belongs to an
> > +		 * internal filesystem.
> > +		 */
> > +		return access_request;
> > +	}
> > +
> > +	access_req = access_request;
> > +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
> > +		if (layer_masks[access_bit]) {
> > +			/* If any layer vetoed the access right, remove it. */
> > +			access_request &= ~BIT_ULL(access_bit);
> > +		}
> > +	}
> > +	return access_request;
> > +}
> > +
> >   /**
> >    * current_check_refer_path - Check if a rename or link action is allowed
> >    *
> > @@ -1142,6 +1184,11 @@ static int hook_path_rmdir(const struct path *const dir,
> >   	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
> >   }
> > +static int hook_path_truncate(const struct path *const path)
> > +{
> > +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > +}
> > +
> >   /* File hooks */
> >   static inline access_mask_t get_file_access(const struct file *const file)
> > @@ -1159,22 +1206,55 @@ static inline access_mask_t get_file_access(const struct file *const file)
> >   	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
> >   	if (file->f_flags & __FMODE_EXEC)
> >   		access |= LANDLOCK_ACCESS_FS_EXECUTE;
> > +
> 
> Not needed.

Done.

> >   	return access;
> >   }
> >   static int hook_file_open(struct file *const file)
> >   {
> > +	access_mask_t access_req, access_rights;
> > +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;
> >   	const struct landlock_ruleset *const dom =
> >   		landlock_get_current_domain();
> > -	if (!dom)
> > +	if (!dom) {
> > +		/* Grant all rights. */
> 
> Something like:
> Grants all rights, even if most of them are not checked here, it is more
> consistent.

Done.

> > +		landlock_file(file)->rights = LANDLOCK_MASK_ACCESS_FS;
> >   		return 0;
> > +	}
> > +
> >   	/*
> >   	 * Because a file may be opened with O_PATH, get_file_access() may
> >   	 * return 0.  This case will be handled with a future Landlock
> >   	 * evolution.
> >   	 */
> > -	return check_access_path(dom, &file->f_path, get_file_access(file));
> > +	access_req = get_file_access(file);
> > +	access_rights = get_path_access_rights(dom, &file->f_path,
> > +					       access_req | optional_rights);
> > +	if (access_req & ~access_rights)
> > +		return -EACCES;
> > +
> > +	/*
> > +	 * For operations on already opened files (i.e. ftruncate()), it is the
> > +	 * access rights at the time of open() which decide whether the
> > +	 * operation is permitted. Therefore, we record the relevant subset of
> > +	 * file access rights in the opened struct file.
> > +	 */
> > +	landlock_file(file)->rights = access_rights;
> > +
> 
> Style preferences, but why do you use a new line here? I try to group code
> blocks until the return.

Thanks, done. I just do this habitually and overlooked that I was at
odds with the surrounding style. I don't have a strong preference.

> > +	return 0;
> > +}
> > +
> > +static int hook_file_truncate(struct file *const file)
> > +{
> > +	/*
> > +	 * We permit truncation if the truncation right was available at the
> 
> Allows truncation if the related right was…
> 
> 
> > +	 * time of opening the file.
> 
> …to get a consistent access check as for read, write and execute operations.

Done.

I'm also adding this note here:

  Note: For checks done based on the file's Landlock rights, we enforce
  them independently of whether the current thread is in a Landlock
  domain, so that open files passed between independent processes
  retain their behaviour.

to explain that this is why we don't check for "if (!dom)" as we do in
other cases.


> This kind of explanation could be used to complete the documentation as
> well. The idea being to mimic the file mode check.

Added it to the documentation.

> 
> 
> > +	 */
> > +	if (!(landlock_file(file)->rights & LANDLOCK_ACCESS_FS_TRUNCATE))
> 
> I prefer to invert the "if" logic and return -EACCES by default.

Done. Thanks for pointing it out.

> > +		return -EACCES;
> > +
> > +	return 0;
> >   }


> > diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> > index 8db7acf9109b..275ba5375839 100644
> > --- a/security/landlock/fs.h
> > +++ b/security/landlock/fs.h
> > @@ -36,6 +36,18 @@ struct landlock_inode_security {
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
> > +	access_mask_t rights;
> 
> I think it would make it more consistent to name it "access" to be in line
> with struct landlock_layer and other types.

Done.

I also added a brief documentation for the access field, to point out
that this is not the *full* set of rights which was available at
open() time, but it's just the subset of rights that is needed to
authorize later operations on the file:

  @access: Access rights that were available at the time of opening the
  file. This is not necessarily the full set of access rights available
  at that time, but it's the necessary subset as needed to authorize
  later operations on the open file.

Thanks for the review! Fixes will be in the next version.

-Günther

-- 
