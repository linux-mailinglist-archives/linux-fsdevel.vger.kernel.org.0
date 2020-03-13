Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069B3183E49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 02:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCMBHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 21:07:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41680 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCMBHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:07:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id z65so4161942pfz.8;
        Thu, 12 Mar 2020 18:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p1y55cnlFR5XIWnQzxqAJ77CuRfysEOntt316s397dE=;
        b=tYPjoAxWpUvTByRIrpV3+ZBaSj85zKl6daSyvjUdTpth+1b76YQDPF7yONc6kXab3Q
         oHoW1kqGQ/rYv0YacjJsHsS1ORNLiiNqvGW036ICnNjaabIN6mpOOo3iWKcb34P8oOoD
         2tGG6f8MJkXfhZfVF3idh0poGismbfjUUuZp/B+2BFaloClGViDLrBhmY+jlQ/fakCWC
         DmmIu3gxOul7mfDf9Uofx5nOK63/mpm0Pr1V9pJHq1cF/GQuVOj/xVm0bIb74Dhn0TVv
         ZWC+OLDom9sEB8XS0aW725ZG2y2LHhlhwOsffGUe/rvWTySJawenZLVT8x5LvRMvKxTl
         KCiA==
X-Gm-Message-State: ANhLgQ05iBA7luvBTCN9IzvzuU502NmvcFe/QufT/Yg8H23VVyp1r5z/
        NQ/PkjSDMhzLatGbdbGttY8=
X-Google-Smtp-Source: ADFU+vu+tQSISN41gD4tRdARFAEGoS3/lePcq8JnLRSye7+UdmfV6TEHHOWfLLbEW3/et9gxyN/r+Q==
X-Received: by 2002:a63:b21b:: with SMTP id x27mr10599525pge.310.1584061649053;
        Thu, 12 Mar 2020 18:07:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v133sm45358821pfc.68.2020.03.12.18.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 18:07:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 240364028E; Fri, 13 Mar 2020 01:07:27 +0000 (UTC)
Date:   Fri, 13 Mar 2020 01:07:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 3/4] docs: admin-guide: document the kernel.modprobe
 sysctl
Message-ID: <20200313010727.GT11244@42.do-not-panic.com>
References: <20200312202552.241885-1-ebiggers@kernel.org>
 <20200312202552.241885-4-ebiggers@kernel.org>
 <87lfo5telq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <87lfo5telq.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 09:04:01AM +1100, NeilBrown wrote:
> On Thu, Mar 12 2020, Eric Biggers wrote:
>=20
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Document the kernel.modprobe sysctl in the same place that all the other
> > kernel.* sysctls are documented.  Make sure to mention how to use this
> > sysctl to completely disable module autoloading, and how this sysctl
> > relates to CONFIG_STATIC_USERMODEHELPER.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jeff Vander Stoep <jeffv@google.com>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: NeilBrown <neilb@suse.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst | 25 ++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentatio=
n/admin-guide/sysctl/kernel.rst
> > index def074807cee9..454f3402ed321 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -49,7 +49,7 @@ show up in /proc/sys/kernel:
> >  - kexec_load_disabled
> >  - kptr_restrict
> >  - l2cr                        [ PPC only ]
> > -- modprobe                    =3D=3D> Documentation/debugging-modules.=
txt
> > +- modprobe
> >  - modules_disabled
> >  - msg_next_id		      [ sysv ipc ]
> >  - msgmax
> > @@ -444,6 +444,29 @@ l2cr: (PPC only)
> >  This flag controls the L2 cache of G3 processor boards. If
> >  0, the cache is disabled. Enabled if nonzero.
> > =20
> > +modprobe:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The path to the usermode helper for autoloading kernel modules, by
> > +default "/sbin/modprobe".  This binary is executed when the kernel
> > +requests a module.  For example, if userspace passes an unknown
> > +filesystem type "foo" to mount(), then the kernel will automatically
> > +request the module "fs-foo.ko" by executing this usermode helper.
>=20
> I don't think it is right to add the ".ko" there.  The string "fs-foo"
> is what is passed to the named executable, and it make well end up
> loading "bar.ko", depending what aliases are set up.
> I would probably write  '... request the module named 'fs-foo" by executi=
ng..'

And that is just because filesystems, in this case a mount call, will
use the fs- prefix for aliases. This is tribal knowledge in the context
above, and so someone not familiar with this won't easily grasp this.

Is there an easier autoloading example other than filesystems we can use th=
at
doesn't require you to explain the aliasing thing?

What is module autoloading? Where is this documented ? If that
can be slightly clarified this would be even easier to understand as
well.

  Luis

> (The "name" for a module can come from the file that stores it, and
> alias inside it, or configuration in modprobe.d).
>=20
> Thanks,
> NeilBrown
>=20
>=20
> > +This usermode helper should insert the needed module into the kernel.
> > +
> > +This sysctl only affects module autoloading.  It has no effect on the
> > +ability to explicitly insert modules.
> > +
> > +If this sysctl is set to the empty string, then module autoloading is
> > +completely disabled.  The kernel will not try to execute a usermode
> > +helper at all, nor will it call the kernel_module_request LSM hook.
> > +
> > +If CONFIG_STATIC_USERMODEHELPER=3Dy is set in the kernel configuration,
> > +then the configured static usermode helper overrides this sysctl,
> > +except that the empty string is still accepted to completely disable
> > +module autoloading as described above.
> > +
> > +Also see Documentation/debugging-modules.txt.
> > =20
> >  modules_disabled:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --=20
> > 2.25.1



--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEENnNq2KuOejlQLZofziMdCjCSiKcFAl5q3M4ACgkQziMdCjCS
iKdvtA//fmhoJkZ3Et5nHDbpWXGMr6uHdxlQqkt7Ai7fvX/IDYHHqDhdKadWyftD
jXEgyOIxfuicMFFY3cjRQL4wqpG7fTnY8ZLLLSZHd26fFqLMQxgQRPVJsW4WLeR/
G2yhcnzcnlLsRVczxUP7vZRwTpTCZHxH2W/SiyXIb8LRp1obEwYUlklc8L9+IX68
h7z/0f8KEJJTO8DEWCD2wKOBi9LkSmI1m4pMLalJ9AOTvyWDSxQWFQpj+kvcC6yG
WjTdkTiIlGIrFUcg9fNN5HumbFo8LU4+121p3jA3BtdBRG+sS0s6sZTN0BpHZdGe
tjhuq44cq6xgMsxZb5mfwSnmHptGgmCqda1wzmgNTdc9WUDNNHHlehjdXhyqVIYZ
wl1NgMDggZ2iqq1p+B2iw5eON9h4e1Nkx46ZGB0D9maqMXby7vV3SduZick8M5pK
IQYYNeILufSCqz2d8HMFE+PCUk0jwGObzxxcwLE6seK4G+5+syptX4NDVbw/KTtf
HxYw+F2B1CRjZrUxnqtTOqxyd0eRTArWeoWI6VWiYupMvwsTw1m88GPR6Tv/j9fz
cAgvzZ7xv5dlOchWH8XXhfpz2ON8DZT/9puhoNMcoWXMdT+R7VSXl6c8OG6HMJ7k
qpH4P9khGasEjyi7XWJe/B6RVJRTE9y8jcB6cmMvWHIGLOOKM+k=
=Kxfs
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
