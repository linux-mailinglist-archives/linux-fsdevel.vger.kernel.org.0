Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AF5F842A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJHHyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJHHyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:54:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DFDFE0;
        Sat,  8 Oct 2022 00:54:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e18so9749850edj.3;
        Sat, 08 Oct 2022 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTcYlUpm1v++pvrqpgQnHLKJV6uVTn/MuzBRzviS18U=;
        b=VKOZWe29lOwGZuCNU40ZRjX/KMzsaEuoIS7WRVpYRSwt7ODHEWDGP4ZdQEUEVLpfnH
         GcVq49k/ov4liUu3XKXU1Q824LBdAap00ogpPI70ca4IRT3FZqW70Fnz9TAptMQU3Lri
         jEVa/IqYZEa6qWGyFWqQfUSU/469RLNczSJb9N7XUPmoSeibqoYs2YZ7dNfL0WYoBeSc
         yW81PG4pKKiGTPspz4PGR9xZCbbyQQ6uRmSJQFC3mwEQG7lJjuZ8BZ74CqCidvPTJYnP
         ObFhEu8026JATbN/nYRJngoCcsnVoifs6Z9aJyJgzwe+0fe5T55Ir0AAt7/8YosEetCP
         Fm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTcYlUpm1v++pvrqpgQnHLKJV6uVTn/MuzBRzviS18U=;
        b=aiicETp95QVcio4jalcq05bKE2PhPI9TVBZ3SvshPRIRAcx3dLwVKbf40TWg9d+t2l
         DLtQC3Rr5XGyqxhCX8A6MvL0B8AzzJ5feQ09bKEmtrNiLOob6nDnb9Yg3TyPtFVzsfMX
         GwaAUVYuFlmomqw3UU/Aqh9PMZ913B8/Xw/KpAhp0EtFyS4bi0EuNwwiO8f9B10gEef3
         cj4WjegbO/Ocba+ehpqj8B0YN1UiNASjxKLTa5R22yVExfKZY6LR4O1NiaSiKfQXgDbr
         IsHbv7Syu9SfXbYifCo2RUYnrPY+xa5NKgXCb6wlbZHDg8aUafVG8c7+L9Dx6ungUxwi
         vgqQ==
X-Gm-Message-State: ACrzQf0FgcZx4lb8mfazTBk4ATMbJpq0TWvCdXRHnjjngkl6WcGwJcP9
        6sol/egzfI+iGrJHWFXjCjc=
X-Google-Smtp-Source: AMsMyM5siMjQdivEQixsYYQSv5l9/Ukw1CgIsoDdMsDAI7pnYhhKVABh1USQrQtu7WglcjJyjn/4vA==
X-Received: by 2002:a05:6402:1a4d:b0:459:319f:ff80 with SMTP id bf13-20020a0564021a4d00b00459319fff80mr8285342edb.144.1665215681509;
        Sat, 08 Oct 2022 00:54:41 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id b26-20020a17090630da00b00783f32d7eaesm2360164ejb.164.2022.10.08.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:54:41 -0700 (PDT)
Date:   Sat, 8 Oct 2022 09:54:39 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 3/9] landlock: Refactor check_access_path_dual() into
 is_access_to_paths_allowed()
Message-ID: <Y0Esvz32Kw5iKFFr@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-4-gnoack3000@gmail.com>
 <16f036ca-fd68-2e89-2ceb-0b9e211a4b23@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f036ca-fd68-2e89-2ceb-0b9e211a4b23@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:54:08PM +0200, Mickaël Salaün wrote:
> On 01/10/2022 17:49, Günther Noack wrote:
> > * Rename it to is_access_to_paths_allowed()
> > * Make it return true iff the access is allowed
> > * Calculate the EXDEV/EACCES error code in the one place where it's needed
> 
> Can you please replace these bullet points with (one-sentence) paragraphs?

Done.

> > Suggested-by: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   security/landlock/fs.c | 89 +++++++++++++++++++++---------------------
> >   1 file changed, 44 insertions(+), 45 deletions(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index a9dbd99d9ee7..083dd3d359de 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -430,7 +430,7 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
> >   }
> >   /**
> > - * check_access_path_dual - Check accesses for requests with a common path
> > + * is_access_to_paths_allowed - Check accesses for requests with a common path
> >    *
> >    * @domain: Domain to check against.
> >    * @path: File hierarchy to walk through.
> > @@ -465,14 +465,10 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
> >    * allow the request.
> >    *
> >    * Returns:
> > - * - 0 if the access request is granted;
> > - * - -EACCES if it is denied because of access right other than
> > - *   LANDLOCK_ACCESS_FS_REFER;
> > - * - -EXDEV if the renaming or linking would be a privileged escalation
> > - *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFER is
> > - *   not allowed by the source or the destination.
> > + * - true if the access request is granted;
> > + * - false otherwise
> 
> Missing final dot.

Done.

> >    */
> > -static int check_access_path_dual(
> > +static bool is_access_to_paths_allowed(
> >   	const struct landlock_ruleset *const domain,
> >   	const struct path *const path,
> >   	const access_mask_t access_request_parent1,
> > @@ -492,17 +488,17 @@ static int check_access_path_dual(
> >   	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
> >   	if (!access_request_parent1 && !access_request_parent2)
> > -		return 0;
> > +		return true;
> >   	if (WARN_ON_ONCE(!domain || !path))
> > -		return 0;
> > +		return true;
> >   	if (is_nouser_or_private(path->dentry))
> > -		return 0;
> > +		return true;
> >   	if (WARN_ON_ONCE(domain->num_layers < 1 || !layer_masks_parent1))
> > -		return -EACCES;
> > +		return false;
> >   	if (unlikely(layer_masks_parent2)) {
> >   		if (WARN_ON_ONCE(!dentry_child1))
> > -			return -EACCES;
> > +			return false;
> >   		/*
> >   		 * For a double request, first check for potential privilege
> >   		 * escalation by looking at domain handled accesses (which are
> > @@ -513,7 +509,7 @@ static int check_access_path_dual(
> >   		is_dom_check = true;
> >   	} else {
> >   		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
> > -			return -EACCES;
> > +			return false;
> >   		/* For a simple request, only check for requested accesses. */
> >   		access_masked_parent1 = access_request_parent1;
> >   		access_masked_parent2 = access_request_parent2;
> > @@ -622,24 +618,7 @@ static int check_access_path_dual(
> >   	}
> >   	path_put(&walker_path);
> > -	if (allowed_parent1 && allowed_parent2)
> > -		return 0;
> > -
> > -	/*
> > -	 * This prioritizes EACCES over EXDEV for all actions, including
> > -	 * renames with RENAME_EXCHANGE.
> > -	 */
> > -	if (likely(is_eacces(layer_masks_parent1, access_request_parent1) ||
> > -		   is_eacces(layer_masks_parent2, access_request_parent2)))
> > -		return -EACCES;
> > -
> > -	/*
> > -	 * Gracefully forbids reparenting if the destination directory
> > -	 * hierarchy is not a superset of restrictions of the source directory
> > -	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
> > -	 * source or the destination.
> > -	 */
> > -	return -EXDEV;
> > +	return allowed_parent1 && allowed_parent2;
> >   }
> >   static inline int check_access_path(const struct landlock_ruleset *const domain,
> > @@ -649,8 +628,10 @@ static inline int check_access_path(const struct landlock_ruleset *const domain,
> >   	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> >   	access_request = init_layer_masks(domain, access_request, &layer_masks);
> > -	return check_access_path_dual(domain, path, access_request,
> > -				      &layer_masks, NULL, 0, NULL, NULL);
> > +	if (is_access_to_paths_allowed(domain, path, access_request,
> > +				       &layer_masks, NULL, 0, NULL, NULL))
> > +		return 0;
> > +	return -EACCES;
> >   }
> >   static inline int current_check_access_path(const struct path *const path,
> > @@ -711,8 +692,9 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
> >    * file.  While walking from @dir to @mnt_root, we record all the domain's
> >    * allowed accesses in @layer_masks_dom.
> >    *
> > - * This is similar to check_access_path_dual() but much simpler because it only
> > - * handles walking on the same mount point and only check one set of accesses.
> > + * This is similar to is_access_to_paths_allowed() but much simpler because it
> > + * only handles walking on the same mount point and only checks one set of
> > + * accesses.
> >    *
> >    * Returns:
> >    * - true if all the domain access rights are allowed for @dir;
> > @@ -857,10 +839,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
> >   		access_request_parent1 = init_layer_masks(
> >   			dom, access_request_parent1 | access_request_parent2,
> >   			&layer_masks_parent1);
> > -		return check_access_path_dual(dom, new_dir,
> > -					      access_request_parent1,
> > -					      &layer_masks_parent1, NULL, 0,
> > -					      NULL, NULL);
> > +		if (is_access_to_paths_allowed(
> > +			    dom, new_dir, access_request_parent1,
> > +			    &layer_masks_parent1, NULL, 0, NULL, NULL))
> > +			return 0;
> > +		return -EACCES;
> >   	}
> >   	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
> > @@ -886,11 +869,27 @@ static int current_check_refer_path(struct dentry *const old_dentry,
> >   	 * parent access rights.  This will be useful to compare with the
> >   	 * destination parent access rights.
> >   	 */
> > -	return check_access_path_dual(dom, &mnt_dir, access_request_parent1,
> > -				      &layer_masks_parent1, old_dentry,
> > -				      access_request_parent2,
> > -				      &layer_masks_parent2,
> > -				      exchange ? new_dentry : NULL);
> > +	if (is_access_to_paths_allowed(
> > +		    dom, &mnt_dir, access_request_parent1, &layer_masks_parent1,
> > +		    old_dentry, access_request_parent2, &layer_masks_parent2,
> > +		    exchange ? new_dentry : NULL))
> > +		return 0;
> > +
> > +	/*
> > +	 * This prioritizes EACCES over EXDEV for all actions, including
> > +	 * renames with RENAME_EXCHANGE.
> > +	 */
> > +	if (likely(is_eacces(&layer_masks_parent1, access_request_parent1) ||
> > +		   is_eacces(&layer_masks_parent2, access_request_parent2)))
> > +		return -EACCES;
> > +
> > +	/*
> > +	 * Gracefully forbids reparenting if the destination directory
> > +	 * hierarchy is not a superset of restrictions of the source directory
> > +	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
> > +	 * source or the destination.
> > +	 */
> > +	return -EXDEV;
> >   }
> >   /* Inode hooks */

-- 
