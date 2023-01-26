Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CE67C2D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 03:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjAZCbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 21:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAZCbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:31:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629E611DB;
        Wed, 25 Jan 2023 18:31:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s67so274111pgs.3;
        Wed, 25 Jan 2023 18:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIQM+I4lgk9cQtbdYSLbHFLgtpBx+yHsfP7MUvofRag=;
        b=UhzOKdpEuDB+o7lBK7giJW280mz8gzSF2PhZNymYEQjD4DCId7dJ180EqV141jnpMS
         0RbkrkwV+aaLWoimH4nb+HObgI7aDCylkkCIEMskfhQlqJxWmKeSh0finEQ3cetn7Rm3
         uO6QHgxsFwYnWjelAg9PZoFnaAJdSJnuzqYoe8WkSaRDgp8/JO4MewAGh4eRl4WA9n7Z
         XsRBEPYTQNiogV0hyNP3wYIoQS0NgudyOP1ha3/EteFCNhHY4GNzOUYvhPRQmYUQcheM
         Q3eyN8qUKsbMMMbNyrAW7SV2YoIHDjAEUzTn7nFlhI64ulIvuSeLKUaZO9fnAO2dbNoo
         gOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIQM+I4lgk9cQtbdYSLbHFLgtpBx+yHsfP7MUvofRag=;
        b=WWMwT9szuGLPIbkgXDYrXK+gTm/n0dCjEyNwOjnEA6JUNSeH+87u8SKiBBdNt0Otav
         VGviHmIvuiyA2cjabMhYnrV4TSCgYaL4FZNhJP/hISoc7l8Ijfb662w7ivhtb5ha6wpv
         FQ6Rry7oTl7eDr/620/Dvc4RF4Y7cC/Nx3M7/DbkT5TUyWDRHdZZSCe+L/rM3eg/OtTB
         lbDgvSErGuf5CjaQS6JUT2bo4hW5TXCGdaePJs0b97xcq6QXqULo2AbbLrZIxt9P4jLi
         mVJTVPiLqjbl367PKowEdG0LsBJWtGAXvlJU1cyjiIi+fhqEbYGulOj3xTjqMCw8F1lG
         FZdw==
X-Gm-Message-State: AO0yUKUxglTdCF0ZhICsN4QPv3zPkx+D2qlsymyEPY4GmgEfsRg0zdeL
        2ieIPqEhYUPkoc1Y8/QngFE=
X-Google-Smtp-Source: AK7set/Air5s1n/z/81QIW4ftdUCbe5RsVyIv4AWaM53nZ1DFEGlUQ7O21P2igmVpu9gQzyPrysHKg==
X-Received: by 2002:aa7:85c9:0:b0:590:65f7:da5a with SMTP id z9-20020aa785c9000000b0059065f7da5amr2383493pfn.22.1674700301813;
        Wed, 25 Jan 2023 18:31:41 -0800 (PST)
Received: from debian.me (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a0022d400b005877d374069sm4476690pfj.10.2023.01.25.18.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 18:31:41 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2560010544A; Thu, 26 Jan 2023 09:31:38 +0700 (WIB)
Date:   Thu, 26 Jan 2023 09:31:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Stefan Roesch <shr@devkernel.io>,
        linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v1 10/20] docs: document general_profit sysfs
 knob
Message-ID: <Y9HmCY5zEiD/yCPi@debian.me>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <20230123173748.1734238-11-shr@devkernel.io>
 <Y89Zko/TWYcphmJA@debian.me>
 <87h6wfhpi8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yNjPRXiGv58sTMBT"
Content-Disposition: inline
In-Reply-To: <87h6wfhpi8.fsf@meer.lwn.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yNjPRXiGv58sTMBT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 09:21:51AM -0700, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > Seems like the wording is confusing me, so I write the improv:
> >
> > ---- >8 ----
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentat=
ion/ABI/testing/sysfs-kernel-mm-ksm
> > index 7768e90f7a8fef..5309a912ab679b 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> > @@ -56,6 +56,6 @@ What:		/sys/kernel/mm/ksm/general_profit
> >  Date:		January 2023
> >  KernelVersion:  6.1
> >  Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> > -Description:	Measure how effective KSM is.
> > -		general_profit: how effective is KSM. The formula for the
> > -		calculation is in Documentation/admin-guide/mm/ksm.rst.
> > +Description:	Measure the KSM profit. See
> > +		:ref:`KSM documentation <monitoring-ksm-profit>` for details
> > +		on the calculated formula.
>=20
> So the original at least attempted to tell us what "KSM profit" is; the
> "improved" version makes no such effort.  I don't think that is actually
> better.

I overlooked that, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--yNjPRXiGv58sTMBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9HmCQAKCRD2uYlJVVFO
o47gAP9Pr/JO3RwPkqRmtfmLZ7BhyCG3fv7UG8NSuCjLg7nthQD/bpZeTPQb+WXZ
5VZo8azAg6zACdVjLL40ChkmXlNWPQg=
=FWAf
-----END PGP SIGNATURE-----

--yNjPRXiGv58sTMBT--
