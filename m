Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5F23591A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHBQnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 12:43:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55478 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgHBQnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:43:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 885DB8EE1D9;
        Sun,  2 Aug 2020 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596386609;
        bh=oOhMZH0FB4G6orqdqFAkNZTXeB04XgPNUsm8TD4axsQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FAJShkAZZYyORIkhrqfSw8BqDSP8QlmrngZQFw4ROTqB3PQ+G9V8iksNfVUVn74Xj
         +x8faujRDzZNkaOa4js3O4QsNJo03gHhpNQ1OkoSSrlN9lKDbK5hALrRjPbs1fIY6m
         l1nRpnp3y5eFE5YVTo1Os2MZ6mCFp1ZXz0qKGUoI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bIfAAv72tOKa; Sun,  2 Aug 2020 09:43:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2357D8EE16A;
        Sun,  2 Aug 2020 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596386609;
        bh=oOhMZH0FB4G6orqdqFAkNZTXeB04XgPNUsm8TD4axsQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FAJShkAZZYyORIkhrqfSw8BqDSP8QlmrngZQFw4ROTqB3PQ+G9V8iksNfVUVn74Xj
         +x8faujRDzZNkaOa4js3O4QsNJo03gHhpNQ1OkoSSrlN9lKDbK5hALrRjPbs1fIY6m
         l1nRpnp3y5eFE5YVTo1Os2MZ6mCFp1ZXz0qKGUoI=
Message-ID: <1596386606.4087.20.camel@HansenPartnership.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Cc:     snitzer@redhat.com, Deven Bowers <deven.desai@linux.microsoft.com>,
        zohar@linux.ibm.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        mdsakib@microsoft.com, jmorris@namei.org,
        nramas@linux.microsoft.com, serge@hallyn.com,
        pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, corbet@lwn.net, linux-kernel@vger.kernel.org,
        eparis@redhat.com, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Date:   Sun, 02 Aug 2020 09:43:26 -0700
In-Reply-To: <20200802143143.GB20261@amd>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
         <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
         <20200802143143.GB20261@amd>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MrVpu3P/x22sFTzai/hX"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-MrVpu3P/x22sFTzai/hX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-08-02 at 16:31 +0200, Pavel Machek wrote:
> On Sun 2020-08-02 10:03:00, Sasha Levin wrote:
> > On Sun, Aug 02, 2020 at 01:55:45PM +0200, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > IPE is a Linux Security Module which allows for a configurable
> > > > policy to enforce integrity requirements on the whole system.
> > > > It attempts to solve the issue of Code Integrity: that any code
> > > > being executed (or files being read), are identical to the
> > > > version that was built by a trusted source.
> > >=20
> > > How is that different from security/integrity/ima?
> >=20
> > Maybe if you would have read the cover letter all the way down to
> > the 5th paragraph which explains how IPE is different from IMA we
> > could avoided this mail exchange...
>=20
> "
> IPE differs from other LSMs which provide integrity checking (for
> instance,
> IMA), as it has no dependency on the filesystem metadata itself. The
> attributes that IPE checks are deterministic properties that exist
> solely
> in the kernel. Additionally, IPE provides no additional mechanisms of
> verifying these files (e.g. IMA Signatures) - all of the attributes
> of
> verifying files are existing features within the kernel, such as
> dm-verity
> or fsverity.
> "
>=20
> That is not really helpful.

I think what the above is trying to to is to expose is an IMA
limitation that the new LSM fixes.  I think what it meant to say is
that IMA uses xattrs to store the signature data which is the "metadata
dependency".  However, it overlooks the fact that IMA can use appended
signatures as well, which have no metadata dependency, so I'm not sure
I've helped you understand why this is different from IMA.

Perhaps a more convincing argument is that IMA hooks into various
filesystem "gates" to perform integrity checks (file read and file
execute being the most obvious).  This LSM wants additional gates
within device mapper itself that IMA currently doesn't hook into.

Perhaps the big question is: If we used the existing IMA appended
signature for detached signatures (effectively becoming the
"properties" referred to in the cover letter) and hooked IMA into
device mapper using additional policy terms, would that satisfy all the
requirements this new LSM has?

James

--=-MrVpu3P/x22sFTzai/hX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXybtLgAKCRDnQslM7pis
hWimAP9T9I/4sBSeBrGI7NqoyKwG2H+cwtXr/XrBRxwSXraDUgD/TFHreLGqN12U
JeJ3dF9i/fLU2fxGJpJrexE3/T8J3AQ=
=Q5Lc
-----END PGP SIGNATURE-----

--=-MrVpu3P/x22sFTzai/hX--

