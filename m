Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4F5EFDDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiI2TWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiI2TWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:22:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E7146F84;
        Thu, 29 Sep 2022 12:22:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y100so2773123ede.6;
        Thu, 29 Sep 2022 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=hnZY0i/n0jhCagORyV/ydNhN2EhRuILceXmEQm5eGAE=;
        b=REUvWOESwGGjPRqpCbQX2ps/nBoNqO1RMiT0fQ6tOPBA2mwQdg9c1Q+H1rOBexP2Yg
         M8b74R2zL/FiVbUUQhqt7VtNsXGEXuZ8ULDZP6cKHNM9Poyg0ZAu93WwRhQypKgRo5ZZ
         Iltc9dolTiEWDG2x1UtFy5lgWSi1hcyQUj0+D89WVbbzcDXar54Qew6om+fMrklKcjea
         oISjMPy3xuPpJXi9X1GHgIJGyfByP0uby6BCjctur1qgWhDAPCKFlYJx64TmsaQrmagY
         rATpxKSxFY5yQvScOzT3MD96NMtandaQ0/BMVM2UbmD433shh5M/peAfuZLBnSxBzT5g
         45LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hnZY0i/n0jhCagORyV/ydNhN2EhRuILceXmEQm5eGAE=;
        b=HyeF0fxb93M0/Xefkwt7qoSVPu3YbCEFF6Gtres85FxFrr2TC5t6cJ8DHybZB3FVFF
         a0mWKYR5jpaabod38SiWtNbVqlQndgZNJz6JdLpSsRreZ72JfF76nLUIPF06zc+/mSOl
         mKYaNMiWGBmu6Gjn4Z3cMcl0Hb9CmabZPLRgF97KVnd1PmL01xNjz73Z7KiuaLYY7pc+
         9Wdr+Zb/O1/veYJIe8gzmdyNJorNd9CUqP0+ftPdnoVnCt06/CSWIW1saGQZpBElqBYa
         8iyhEKeCA9fLd7HDzVQUpOpJNSN+5IsSgMZciBp6f7YcrV9QWHLKzQD6TQYdkbM8wOEB
         Mn4Q==
X-Gm-Message-State: ACrzQf2LHJ5dO+8l5M9LfqfO/OUi6wYnYyxMt5yqN1mfQGPFqpzxdmP+
        tL+W+Bmmeho4aB3/+d7rs4IDBUIHpyg=
X-Google-Smtp-Source: AMsMyM4dzDH0Fdl44hJph4ObGk/wxfEphNqpEX7+n/38JQO7RaVXpha+lF0hN4GmQpRcz0j7IVLzZQ==
X-Received: by 2002:aa7:da0c:0:b0:458:f56:5a00 with SMTP id r12-20020aa7da0c000000b004580f565a00mr4642845eds.298.1664479353878;
        Thu, 29 Sep 2022 12:22:33 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p6-20020aa7cc86000000b004574f4326b8sm237576edt.30.2022.09.29.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:22:33 -0700 (PDT)
Date:   Thu, 29 Sep 2022 21:22:31 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Message-ID: <YzXwdwxIl1KD8TMM@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
 <2c4db214-e425-3e40-adeb-9e406c3ea2f9@digikod.net>
 <Yy2W14NMQBvfG9Fw@nuc>
 <0dea6e07-dd98-0d3c-4c2b-7f45e06374ed@digikod.net>
 <YzCZVuP1d9GpQt+k@nuc>
 <e5b0b338-c4e5-8348-1fe0-1d434235dc01@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5b0b338-c4e5-8348-1fe0-1d434235dc01@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:32:02PM +0200, Mickaël Salaün wrote:
> On 25/09/2022 20:09, Günther Noack wrote:
> > On Fri, Sep 23, 2022 at 10:53:23PM +0200, Mickaël Salaün wrote:
> > > On 23/09/2022 13:21, Günther Noack wrote:
> > > > On Mon, Sep 12, 2022 at 09:41:32PM +0200, Mickaël Salaün wrote:
> > > > > On 08/09/2022 21:58, Günther Noack wrote:
> > > > > > Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > +/**
> > > > > > + * get_path_access_rights - Returns the subset of rights in access_request
> > > > > > + * which are permitted for the given path.
> > > > > > + *
> > > > > > + * @domain: The domain that defines the current restrictions.
> > > > > > + * @path: The path to get access rights for.
> > > > > > + * @access_request: The rights we are interested in.
> > > > > > + *
> > > > > > + * Returns: The access mask of the rights that are permitted on the given path,
> > > > > > + * which are also a subset of access_request (to save some calculation time).
> > > > > > + */
> > > > > > +static inline access_mask_t
> > > > > > +get_path_access_rights(const struct landlock_ruleset *const domain,
> > > > > > +		       const struct path *const path,
> > > > > > +		       access_mask_t access_request)
> > > > > > +{
> > > > > > +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > > > > > +	unsigned long access_bit;
> > > > > > +	unsigned long access_req;
> > > > > > +
> > > > > > +	init_layer_masks(domain, access_request, &layer_masks);
> > > > > > +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
> > > > > > +				    NULL, 0, NULL, NULL)) {
> > > > > > +		/*
> > > > > > +		 * Return immediately for successful accesses and for cases
> > > > > > +		 * where everything is permitted because the path belongs to an
> > > > > > +		 * internal filesystem.
> > > > > > +		 */
> > > > > > +		return access_request;
> > > > > > +	}
> > > > > > +
> > > > > > +	access_req = access_request;
> > > > > > +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
> > > > > > +		if (layer_masks[access_bit]) {
> > > > > > +			/* If any layer vetoed the access right, remove it. */
> > > > > > +			access_request &= ~BIT_ULL(access_bit);
> > > > > > +		}
> > > > > > +	}
> > > > > 
> > > > > This seems to be redundant with the value returned by init_layer_masks(),
> > > > > which should be passed to check_access_path_dual() to avoid useless path
> > > > > walk.
> > > > 
> > > > True, I'll use the result of init_layer_masks() to feed it back to
> > > > check_access_path_dual() to avoid a bit of computation.
> > > > 
> > > > Like this:
> > > > 
> > > >           effective_access_request =
> > > > 		init_layer_masks(domain, access_request, &layer_masks);
> > > > 	if (!check_access_path_dual(domain, path, effective_access_request,
> > > > 	    &layer_masks, NULL, 0, NULL, NULL)) {
> > > > 		// ...
> > > > 	}
> > > 
> > > correct
> > > 
> > > > 
> > > > Overall, the approach here is:
> > > > 
> > > > * Initialize the layer_masks, so that it has a bit set for every
> > > >     access right in access_request and layer where that access right is
> > > >     handled.
> > > > 
> > > > * check_access_path_dual() with only the first few parameters -- this
> > > >     will clear all the bits in layer masks which are actually permitted
> > > >     according to the individual rules.
> > > > 
> > > >     As a special case, this *may* return 0 immediately, in which case we
> > > >     can (a) save a bit of calculation in the loop below and (b) we might
> > > >     be in the case where access is permitted because it's a file from a
> > > >     special file system (even though not all bits are cleared). If
> > > >     check_access_path_dual() returns 0, we return the full requested
> > > >     access_request that we received as input. >
> > > > * In the loop below, if there are any bits left in layer_masks, those
> > > >     are rights which are not permitted for the given path. We remove
> > > >     these from access_request and return the modified access_request.
> > > > 
> > > > 
> > > > > This function is pretty similar to check_access_path(). Can't you change it
> > > > > to use an access_mask_t pointer and get almost the same thing?
> > > > 
> > > > I'm shying away from this approach. Many of the existing different use
> > > > cases are already realized by "doing if checks deep down". I think it
> > > > would make the code more understandable if we managed to model these
> > > > differences between use cases already at the layer of function calls.
> > > > (This is particularly true for check_access_path_dual(), where in
> > > > order to find out how the "single" case works, you need to disentangle
> > > > to a large extent how the much more complicated dual case works.)
> > > 
> > > I agree that check_access_path_dual() is complex, but I couldn't find a
> > > better way.
> > 
> > It seems out of the scope of this patch set, but I sometimes find it
> > OK to just duplicate the code and have a set of tests to demonstrate
> > that the two variants do the same thing.
> > 
> > check_access_path_dual() is mostly complex because of performance
> > reasons, as far as I can tell, and it might be possible to check its
> > results against a parallel implementation of it which runs slower,
> > uses more memory, but is more obviously correct. (I have used one
> > myself to check against when developing the truncate patch set.)
> > 
> > > > If you want to unify these two functions, what do you think of the
> > > > approach of just using get_path_access_rights() instead of
> > > > check_access_path()?
> > > > 
> > > > Basically, it would turn
> > > > 
> > > > return check_access_path(dom, path, access_request);
> > > > 
> > > > into
> > > > 
> > > > if (get_path_access_rights(dom, path, access_request) == access_request)
> > > > 	return 0;
> > > > return -EACCES;
> > > > 
> > > > This is slightly more verbose in the places where it's called, but it
> > > > would be more orthogonal, and it would also clarify that -EACCES is
> > > > the only possible error in the "single" path walk case.
> > > > 
> > > > Let me know what you think.
> > > 
> > > What about adding an additional argument `access_mask_t *const
> > > access_allowed` to check_access_path_dual() which returns the set of
> > > accesses (i.e. access_masked_parent1 & access_masked_parent2) that could
> > > then be stored to landlock_file(file)->allowed_access? If this argument is
> > > NULL it should just be ignored. What is left from get_path_access_rights()
> > > could then be merged into hook_file_open().
> > 
> > IMHO, check_access_path_dual() does not seem like the right place to
> > add this. This functionality is not needed in any of the "dual path"
> > cases so far, and I'm not sure what it would mean. The necessary
> > information can also be easily derived from the resulting layer_masks,
> > which is already exposed in the check_access_path_dual() interface,
> > and I also believe that this approach is at least equally fast as
> > updating it on the fly when changing the layer_masks.
> > 
> > I could be convinced to add a `access_mask_t *const access_allowed`
> > argument to check_access_path() if you prefer that, but then again, in
> > that case the returned boolean can be reconstructed from the new
> > access_allowed variable, and we could as well make check_access_path()
> > return the access_allowed result instead of the boolean and let
> > callers check equality with what they expected...? (I admittedly don't
> > have a good setup to test the performance right now, but it looks like
> > a negligible difference to me?)
> 
> Good idea, let's try to make check_access_path_dual() returns the allowed
> accesses (according to the request) and rename it to get_access_path_dual().
> unmask_layers() could be changed to return the still-denied accesses instead
> of a boolean, and we could use this values (for potential both parents) to
> return allowed_parent1 & allowed_parent2 (with access_mask_t types). This
> would also simplify is_eaccess() and its calls could be moved to
> current_check_refer_path(). This would merge get_path_access_rights() into
> check_access_path_dual() and make the errno codes more explicit per hook or
> defined in check_access_path().

Thanks for the review!

I'm afraid I don't understand this approach at the moment. I'm
probably still missing some insight about how the "refer" logic works
which would make this clearer.

With the proposed changes to check_access_path_dual(), it sounds like
we would have to change the logic of the "refer" implementation quite
a bit, which would expand the scope of the "truncate" patch set beyond
what it was originally meant to do. Is this check_access_path_dual()
refactoring something you'd insist on for the truncate patch set, or
would you be OK with doing that separately?

For the truncate patch set, what do you think of the lighter
refactoring options, which I had outlined in my previous mail? - see
the four bullet points quoted here:

> > Here are the options we have discussed, in the order that I would
> > prefer them:
> > 
> > * to keep it as a separate function as it already is,
> >    slightly duplicating check_access_path(). (I think it's cleaner,
> >    because the code path for the rest of the hooks other than
> >    security_file_open() stays simpler.)
> > 
> > * to make check_access_path() return the access_allowed access mask
> >    and make callers check that it covers the access_request that they
> >    asked for (see example from my previous mail on this thread). (This
> >    is equivalent to discarding the existing check_access_path() and
> >    using the get_path_access() function instead.)
> > 
> > * to add a `access_mask_t *const access_allowed` argument to
> >    check_access_path(), which is calculated if it's non-NULL based on
> >    the layer_masks result. It would be used from the security_file_open
> >    hook.
> > 
> > * to add a `access_mask_t *const access_allowed` argument to
> >    check_access_path_dual(). This doesn't make much sense, IMHO,
> >    because an on-the-fly calculation of this result does not look like
> >    a performance benefit to me, and calculating it based on the two
> >    resulting layer_masks is already possible now. It's also not clear
> >    to me what it would mean to calculate an access_allowed on two paths
> >    at once, and what that would be used for.
> > 
> > Let me know which option you prefer. In the end, I don't feel that
> > strongly about it and I'm happy to do this either way.

Thanks,
Günther

-- 
