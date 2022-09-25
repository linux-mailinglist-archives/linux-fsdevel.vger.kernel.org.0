Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF095E9553
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiIYSJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiIYSJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:09:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458C30D;
        Sun, 25 Sep 2022 11:09:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r18so9862592eja.11;
        Sun, 25 Sep 2022 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=XwZiAavT3TrXEw+kVPAQhwKGeAPgK7CpYh9zVHj11c0=;
        b=HQhxysCbaD/cK8IKEwJXPGvHBV+Z2yHeTErirynk3IjcS4uhWnA6bQhyTB3NIwOKrq
         WkIS3iJg+94h+K8tRxxhXCVXjU6bpo64fnaDufusX/rbL+v2FRhG1S4rQQ5hYqp9n+Or
         7GEXs//2C5HmqNwlDdS4M1j9f0R8hxdpeotqrYXmgxreywVHUjXHOakbXR+jGM+Ij9G2
         dsm6tHSgOWke+pGKiceA9NwCwNba6h0ojhsr6N2EKmWTnrgTUX5hxhcwc0q2JphJsXtI
         iggDJoJQV2nuPpKVe6Jdxhi5uMT3JoV3uWiqy4O1hujewomfu3LSxIkqiwOZ3wkeqLJ1
         okIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XwZiAavT3TrXEw+kVPAQhwKGeAPgK7CpYh9zVHj11c0=;
        b=eKkVyWSaRFQs71CqTg3dcPJn7oDrVLGbgfpFE/z5MTttLm78tJRbtKeZzzJ30MH3bq
         NKQOKJta9807lDItpeB3qElJnfs010KZBHMSk9ITZclXTOHWSEztdM8DD5eQMJYgpJM6
         VXJFu6x/JhEkSchW/a3fsyZ/40rRw/Kp/fgwYdJ2LEUuvv1xervZW3Ori/jM8T5GulOa
         QkVgoLRrA11K42AVMeFPGNRwR5KKiVtSAIWF3aDlL3blxRnM5F6yAkyEEeFDFYdQtV2R
         uugRyN4Sy+S3nfiVx1ZzTb2X7Gzgjz8YlexvxL+p55IdqHy+Jx8tFrhjWHQpSMgYJwPW
         v3LA==
X-Gm-Message-State: ACrzQf0ZlrADemnUAhFCchS7hVDj6tjpwhRKSZRWlUog6lODqi9NZIhA
        RjvNMiUUdjO5uS8EKDfhVGmHx2fwIB4=
X-Google-Smtp-Source: AMsMyM4+Y8q7TyFvfT/IawuxAHkEe/qrfiqBMEhVeCAMBP80gcK7dXv+gfqLFvNqQCj0oP2zhsi/vg==
X-Received: by 2002:a17:906:ee81:b0:77e:829a:76e9 with SMTP id wt1-20020a170906ee8100b0077e829a76e9mr15667594ejb.207.1664129368841;
        Sun, 25 Sep 2022 11:09:28 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906314700b007820bb9350fsm6708367eje.206.2022.09.25.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 11:09:28 -0700 (PDT)
Date:   Sun, 25 Sep 2022 20:09:26 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Message-ID: <YzCZVuP1d9GpQt+k@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
 <2c4db214-e425-3e40-adeb-9e406c3ea2f9@digikod.net>
 <Yy2W14NMQBvfG9Fw@nuc>
 <0dea6e07-dd98-0d3c-4c2b-7f45e06374ed@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dea6e07-dd98-0d3c-4c2b-7f45e06374ed@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:53:23PM +0200, Mickaël Salaün wrote:
> On 23/09/2022 13:21, Günther Noack wrote:
> > On Mon, Sep 12, 2022 at 09:41:32PM +0200, Mickaël Salaün wrote:
> > > On 08/09/2022 21:58, Günther Noack wrote:
> > > > Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> > > 
> > > [...]
> > > 
> > > > +/**
> > > > + * get_path_access_rights - Returns the subset of rights in access_request
> > > > + * which are permitted for the given path.
> > > > + *
> > > > + * @domain: The domain that defines the current restrictions.
> > > > + * @path: The path to get access rights for.
> > > > + * @access_request: The rights we are interested in.
> > > > + *
> > > > + * Returns: The access mask of the rights that are permitted on the given path,
> > > > + * which are also a subset of access_request (to save some calculation time).
> > > > + */
> > > > +static inline access_mask_t
> > > > +get_path_access_rights(const struct landlock_ruleset *const domain,
> > > > +		       const struct path *const path,
> > > > +		       access_mask_t access_request)
> > > > +{
> > > > +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > > > +	unsigned long access_bit;
> > > > +	unsigned long access_req;
> > > > +
> > > > +	init_layer_masks(domain, access_request, &layer_masks);
> > > > +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
> > > > +				    NULL, 0, NULL, NULL)) {
> > > > +		/*
> > > > +		 * Return immediately for successful accesses and for cases
> > > > +		 * where everything is permitted because the path belongs to an
> > > > +		 * internal filesystem.
> > > > +		 */
> > > > +		return access_request;
> > > > +	}
> > > > +
> > > > +	access_req = access_request;
> > > > +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
> > > > +		if (layer_masks[access_bit]) {
> > > > +			/* If any layer vetoed the access right, remove it. */
> > > > +			access_request &= ~BIT_ULL(access_bit);
> > > > +		}
> > > > +	}
> > > 
> > > This seems to be redundant with the value returned by init_layer_masks(),
> > > which should be passed to check_access_path_dual() to avoid useless path
> > > walk.
> > 
> > True, I'll use the result of init_layer_masks() to feed it back to
> > check_access_path_dual() to avoid a bit of computation.
> > 
> > Like this:
> > 
> >          effective_access_request =
> > 		init_layer_masks(domain, access_request, &layer_masks);
> > 	if (!check_access_path_dual(domain, path, effective_access_request,
> > 	    &layer_masks, NULL, 0, NULL, NULL)) {
> > 		// ...
> > 	}
> 
> correct
> 
> > 
> > Overall, the approach here is:
> > 
> > * Initialize the layer_masks, so that it has a bit set for every
> >    access right in access_request and layer where that access right is
> >    handled.
> > 
> > * check_access_path_dual() with only the first few parameters -- this
> >    will clear all the bits in layer masks which are actually permitted
> >    according to the individual rules.
> > 
> >    As a special case, this *may* return 0 immediately, in which case we
> >    can (a) save a bit of calculation in the loop below and (b) we might
> >    be in the case where access is permitted because it's a file from a
> >    special file system (even though not all bits are cleared). If
> >    check_access_path_dual() returns 0, we return the full requested
> >    access_request that we received as input. >
> > * In the loop below, if there are any bits left in layer_masks, those
> >    are rights which are not permitted for the given path. We remove
> >    these from access_request and return the modified access_request.
> > 
> > 
> > > This function is pretty similar to check_access_path(). Can't you change it
> > > to use an access_mask_t pointer and get almost the same thing?
> > 
> > I'm shying away from this approach. Many of the existing different use
> > cases are already realized by "doing if checks deep down". I think it
> > would make the code more understandable if we managed to model these
> > differences between use cases already at the layer of function calls.
> > (This is particularly true for check_access_path_dual(), where in
> > order to find out how the "single" case works, you need to disentangle
> > to a large extent how the much more complicated dual case works.)
> 
> I agree that check_access_path_dual() is complex, but I couldn't find a
> better way.

It seems out of the scope of this patch set, but I sometimes find it
OK to just duplicate the code and have a set of tests to demonstrate
that the two variants do the same thing.

check_access_path_dual() is mostly complex because of performance
reasons, as far as I can tell, and it might be possible to check its
results against a parallel implementation of it which runs slower,
uses more memory, but is more obviously correct. (I have used one
myself to check against when developing the truncate patch set.)

> > If you want to unify these two functions, what do you think of the
> > approach of just using get_path_access_rights() instead of
> > check_access_path()?
> > 
> > Basically, it would turn
> > 
> > return check_access_path(dom, path, access_request);
> > 
> > into
> > 
> > if (get_path_access_rights(dom, path, access_request) == access_request)
> > 	return 0;
> > return -EACCES;
> > 
> > This is slightly more verbose in the places where it's called, but it
> > would be more orthogonal, and it would also clarify that -EACCES is
> > the only possible error in the "single" path walk case.
> > 
> > Let me know what you think.
> 
> What about adding an additional argument `access_mask_t *const
> access_allowed` to check_access_path_dual() which returns the set of
> accesses (i.e. access_masked_parent1 & access_masked_parent2) that could
> then be stored to landlock_file(file)->allowed_access? If this argument is
> NULL it should just be ignored. What is left from get_path_access_rights()
> could then be merged into hook_file_open().

IMHO, check_access_path_dual() does not seem like the right place to
add this. This functionality is not needed in any of the "dual path"
cases so far, and I'm not sure what it would mean. The necessary
information can also be easily derived from the resulting layer_masks,
which is already exposed in the check_access_path_dual() interface,
and I also believe that this approach is at least equally fast as
updating it on the fly when changing the layer_masks.

I could be convinced to add a `access_mask_t *const access_allowed`
argument to check_access_path() if you prefer that, but then again, in
that case the returned boolean can be reconstructed from the new
access_allowed variable, and we could as well make check_access_path()
return the access_allowed result instead of the boolean and let
callers check equality with what they expected...? (I admittedly don't
have a good setup to test the performance right now, but it looks like
a negligible difference to me?)

Here are the options we have discussed, in the order that I would
prefer them:

* to keep it as a separate function as it already is,
  slightly duplicating check_access_path(). (I think it's cleaner,
  because the code path for the rest of the hooks other than
  security_file_open() stays simpler.)

* to make check_access_path() return the access_allowed access mask
  and make callers check that it covers the access_request that they
  asked for (see example from my previous mail on this thread). (This
  is equivalent to discarding the existing check_access_path() and
  using the get_path_access() function instead.)

* to add a `access_mask_t *const access_allowed` argument to
  check_access_path(), which is calculated if it's non-NULL based on
  the layer_masks result. It would be used from the security_file_open
  hook.

* to add a `access_mask_t *const access_allowed` argument to
  check_access_path_dual(). This doesn't make much sense, IMHO,
  because an on-the-fly calculation of this result does not look like
  a performance benefit to me, and calculating it based on the two
  resulting layer_masks is already possible now. It's also not clear
  to me what it would mean to calculate an access_allowed on two paths
  at once, and what that would be used for.

Let me know which option you prefer. In the end, I don't feel that
strongly about it and I'm happy to do this either way.


> > > > +	return access_request;
> > > > +}
> > > > +
> > > >    /**
> > > >     * current_check_refer_path - Check if a rename or link action is allowed
> > > >     *
> > > > @@ -1142,6 +1184,11 @@ static int hook_path_rmdir(const struct path *const dir,
> > > >    	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
> > > >    }
> > > > +static int hook_path_truncate(const struct path *const path)
> > > > +{
> > > > +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > > > +}
> > > > +
> > > >    /* File hooks */
> > > >    static inline access_mask_t get_file_access(const struct file *const file)
> > > > @@ -1159,22 +1206,55 @@ static inline access_mask_t get_file_access(const struct file *const file)
> > > >    	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
> > > >    	if (file->f_flags & __FMODE_EXEC)
> > > >    		access |= LANDLOCK_ACCESS_FS_EXECUTE;
> > > > +
> > > >    	return access;
> > > >    }
> > > >    static int hook_file_open(struct file *const file)
> > > >    {
> > > > +	access_mask_t access_req, access_rights;
> > > 
> > > "access_request" is used for access_mask_t, and "access_req" for unsigned
> > > int. I'd like to stick to this convention.
> > 
> > Done.
> > 
> > > > +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;
> > > 
> > > You use "rights" often and I'm having some trouble to find a rational for
> > > that (compared to "access")…
> > 
> > Done. Didn't realize you already had a different convention here.
> > 
> > I'm renaming get_path_access_rights() to get_path_access() as well
> > then (and I'll rename get_file_access() to
> > get_required_file_open_access() - that's more verbose, but it sounded
> > too similar to get_path_access(), and it might be better to clarify
> > that this is a helper for the file_open hook). Does that sound
> > reasonable?
> 
> I think it is better, but I'm not convinced this helper is useful.
> 
> > 
> > 
> > > >    	const struct landlock_ruleset *const dom =
> > > >    		landlock_get_current_domain();
> > > > -	if (!dom)
> > > > +	if (!dom) {
> > > > +		/* Grant all rights. */
> > > > +		landlock_file(file)->rights = LANDLOCK_MASK_ACCESS_FS;
> > > >    		return 0;
> > > > +	}
> > > > +
> > > >    	/*
> > > >    	 * Because a file may be opened with O_PATH, get_file_access() may
> > > >    	 * return 0.  This case will be handled with a future Landlock
> > > >    	 * evolution.
> > > >    	 */
> > > > -	return check_access_path(dom, &file->f_path, get_file_access(file));
> > > > +	access_req = get_file_access(file);
> > > > +	access_rights = get_path_access_rights(dom, &file->f_path,
> > > > +					       access_req | optional_rights);
> > > > +	if (access_req & ~access_rights)
> > > > +		return -EACCES;
> > > 
> > > We should add a test to make sure this (optional_rights) logic is correct
> > > (and doesn't change), with a matrix of cases involving a ruleset handling
> > > either FS_WRITE, FS_TRUNCATE or both. This should be easy to do with test
> > > variants.
> > 
> > OK, adding one to the selftests.
> > 
> > > > +	/*
> > > > +	 * For operations on already opened files (i.e. ftruncate()), it is the
> > > > +	 * access rights at the time of open() which decide whether the
> > > > +	 * operation is permitted. Therefore, we record the relevant subset of
> > > > +	 * file access rights in the opened struct file.
> > > > +	 */
> > > > +	landlock_file(file)->rights = access_rights;
> > > > +
> > > > +	return 0;
> > > > +}
> > 

-- 
