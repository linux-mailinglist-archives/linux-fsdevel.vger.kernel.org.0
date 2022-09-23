Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403F45E7975
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiIWLWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiIWLWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:22:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BF137916;
        Fri, 23 Sep 2022 04:22:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd10so5870ejc.2;
        Fri, 23 Sep 2022 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=G06WM7bNVNg2ix4gBSuEaAwqMbZEU/3aXA60ImPqoGc=;
        b=mybCwJ1nwQg33sCwjw3aDf8hLtMuh61ApUrs0RjpaIyQajNRwz4l9Zvn5mFsUtpmv1
         wAMtrM0JFv9a3Txb8Gwy8TLWeLuRIFDdc0wf5cohiPLoBUct2ub2D8xyCjbnST7uNaLL
         scHBji0VBlx7NDUfbrxEt446f08acX53XOpTmXskak0mQUdiKC+e+98nzmgDy8s41/S6
         HMPXs50OFmoKC70H4zFneQsolzjeeXcbYfdM7TyxWE7LwEzp6s8UJXo81J8t7i5lkNNz
         7reZjG1X2ocqwFTqyVQlwhxZWw4y0ZZWdPZXXG7ZdpQnUOg5v4C5iKwgqsV3vI8QdWoY
         lmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G06WM7bNVNg2ix4gBSuEaAwqMbZEU/3aXA60ImPqoGc=;
        b=sCzvTjSKCSdBqe3mQuMU8vTjBUxax79OKs8LrtwfprVcV+a/v9dZrflvAcxtwMWfsP
         QNws4lUrsDf5L9FLO+PK8SZvHkXrP/9i42gmtdtd9E3B76WnXY3p/uc5UnHsgPrDM/sj
         VDJnIQepxwp1+2jVpBXl/XsPXEFb+oDEdrfNSQAvIGW8EWXcmeygzSTn9cK/SdK05yhL
         rdhAsL38DBtWXReFBuKHSx4iDf91AsW5YMfbiGAWD6rrGItUgIfnl/kypsFffouJOZX4
         +fjV9BPd3fNeMj7bIVmmAMOhWOMc5o7sSoyPO43cNncEveEQCPXtU/kRcANM/bGasDPE
         OEUA==
X-Gm-Message-State: ACrzQf0AzCQFP4ytDkyBtIB6zG//fwCY8miPxErU6WKg6QU1LlCFGlTp
        gSOfHjpP4YWMcIjr9oVN92z6UflUpjU=
X-Google-Smtp-Source: AMsMyM78+DtvF01B7AbXplQ0wnSXWwlA44e7OiroHNoMZPhVPsBuXsAUJO5SIAipcl8IFO5N7sdc7Q==
X-Received: by 2002:a17:906:2245:b0:715:7c81:e39d with SMTP id 5-20020a170906224500b007157c81e39dmr6988356ejr.262.1663932122142;
        Fri, 23 Sep 2022 04:22:02 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0073d7ab84375sm3885581ejf.92.2022.09.23.04.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:22:01 -0700 (PDT)
Date:   Fri, 23 Sep 2022 13:21:59 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Message-ID: <Yy2W14NMQBvfG9Fw@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
 <2c4db214-e425-3e40-adeb-9e406c3ea2f9@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c4db214-e425-3e40-adeb-9e406c3ea2f9@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:41:32PM +0200, Mickaël Salaün wrote:
> 
> On 08/09/2022 21:58, Günther Noack wrote:
> > Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> 
> [...]
> 
> > @@ -761,6 +762,47 @@ static bool collect_domain_accesses(
> >   	return ret;
> >   }
> > +/**
> > + * get_path_access_rights - Returns the subset of rights in access_request
> > + * which are permitted for the given path.
> > + *
> > + * @domain: The domain that defines the current restrictions.
> > + * @path: The path to get access rights for.
> > + * @access_request: The rights we are interested in.
> > + *
> > + * Returns: The access mask of the rights that are permitted on the given path,
> > + * which are also a subset of access_request (to save some calculation time).
> > + */
> > +static inline access_mask_t
> > +get_path_access_rights(const struct landlock_ruleset *const domain,
> > +		       const struct path *const path,
> > +		       access_mask_t access_request)
> > +{
> > +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > +	unsigned long access_bit;
> > +	unsigned long access_req;
> > +
> > +	init_layer_masks(domain, access_request, &layer_masks);
> > +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
> > +				    NULL, 0, NULL, NULL)) {
> > +		/*
> > +		 * Return immediately for successful accesses and for cases
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
> 
> This seems to be redundant with the value returned by init_layer_masks(),
> which should be passed to check_access_path_dual() to avoid useless path
> walk.

True, I'll use the result of init_layer_masks() to feed it back to
check_access_path_dual() to avoid a bit of computation.

Like this:

        effective_access_request =
		init_layer_masks(domain, access_request, &layer_masks);
	if (!check_access_path_dual(domain, path, effective_access_request,
	    &layer_masks, NULL, 0, NULL, NULL)) {
		// ...
	}

Overall, the approach here is:

* Initialize the layer_masks, so that it has a bit set for every
  access right in access_request and layer where that access right is
  handled.

* check_access_path_dual() with only the first few parameters -- this
  will clear all the bits in layer masks which are actually permitted
  according to the individual rules.

  As a special case, this *may* return 0 immediately, in which case we
  can (a) save a bit of calculation in the loop below and (b) we might
  be in the case where access is permitted because it's a file from a
  special file system (even though not all bits are cleared). If
  check_access_path_dual() returns 0, we return the full requested
  access_request that we received as input.

* In the loop below, if there are any bits left in layer_masks, those
  are rights which are not permitted for the given path. We remove
  these from access_request and return the modified access_request.


> This function is pretty similar to check_access_path(). Can't you change it
> to use an access_mask_t pointer and get almost the same thing?

I'm shying away from this approach. Many of the existing different use
cases are already realized by "doing if checks deep down". I think it
would make the code more understandable if we managed to model these
differences between use cases already at the layer of function calls.
(This is particularly true for check_access_path_dual(), where in
order to find out how the "single" case works, you need to disentangle
to a large extent how the much more complicated dual case works.)

If you want to unify these two functions, what do you think of the
approach of just using get_path_access_rights() instead of
check_access_path()?

Basically, it would turn

return check_access_path(dom, path, access_request);

into

if (get_path_access_rights(dom, path, access_request) == access_request)
	return 0;
return -EACCES;

This is slightly more verbose in the places where it's called, but it
would be more orthogonal, and it would also clarify that -EACCES is
the only possible error in the "single" path walk case.

Let me know what you think.

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
> >   	return access;
> >   }
> >   static int hook_file_open(struct file *const file)
> >   {
> > +	access_mask_t access_req, access_rights;
> 
> "access_request" is used for access_mask_t, and "access_req" for unsigned
> int. I'd like to stick to this convention.

Done.

> > +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;
> 
> You use "rights" often and I'm having some trouble to find a rational for
> that (compared to "access")…

Done. Didn't realize you already had a different convention here.

I'm renaming get_path_access_rights() to get_path_access() as well
then (and I'll rename get_file_access() to
get_required_file_open_access() - that's more verbose, but it sounded
too similar to get_path_access(), and it might be better to clarify
that this is a helper for the file_open hook). Does that sound
reasonable?


> >   	const struct landlock_ruleset *const dom =
> >   		landlock_get_current_domain();
> > -	if (!dom)
> > +	if (!dom) {
> > +		/* Grant all rights. */
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
> 
> We should add a test to make sure this (optional_rights) logic is correct
> (and doesn't change), with a matrix of cases involving a ruleset handling
> either FS_WRITE, FS_TRUNCATE or both. This should be easy to do with test
> variants.

OK, adding one to the selftests.

> > +	/*
> > +	 * For operations on already opened files (i.e. ftruncate()), it is the
> > +	 * access rights at the time of open() which decide whether the
> > +	 * operation is permitted. Therefore, we record the relevant subset of
> > +	 * file access rights in the opened struct file.
> > +	 */
> > +	landlock_file(file)->rights = access_rights;
> > +
> > +	return 0;
> > +}

-- 
