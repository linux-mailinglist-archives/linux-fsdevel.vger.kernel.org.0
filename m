Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DDD164242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgBSKhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 05:37:09 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:54617 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSKhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:37:09 -0500
Received: by mail-wm1-f48.google.com with SMTP id n3so17621wmk.4;
        Wed, 19 Feb 2020 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YR8HyDW/1JEJwc8Sq5lAsfNmZdjey8txPG9y+rKXtEo=;
        b=Q3HPkrlIVqTM5/ph1qsmWRZI8SRyEQ4JRj7tXLmq4B548T01sn2x6P9Rw6eneQW2MI
         o3xauSlYv17dtcUAuY/Me0JncmDhAUgtFPsXWfaT1pgYc2Zn5IAzoxoRbYitXLn02OAm
         InoxsdZPJcS7FrJHFrKOEaJM/mzWhSRUXQ/QF9X4yoUAGMECT/vapvXYJPegg9SLfCN8
         DOfjHO1/5r4aDELgQY2z21kZAZX1+UmK9oQBS2g4RIzEHmAxyx5CR3vvunaEn6MgXtfR
         h/LsSvB+WcjP1hJBj7MQJ2AieSKcufViVILUsWZVyFBnD5cT1m6w+NPzXUegVOlt6LdE
         2gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YR8HyDW/1JEJwc8Sq5lAsfNmZdjey8txPG9y+rKXtEo=;
        b=Gk9qFRB0RD9mYxNqxoPKu8wWsoqsDh/dsf2vSwjfCKn3U/rlIYL1nXeracaBo1zJna
         YSYt1SHWh4jbtlpjURXccXijIXFC7KqEON4FZqjLzRN/SdLGOsx8CihC6heSxU5XqRI6
         ubZOyGuOeqO3TNq2mrpmAoKUsq8shxJZGPYaDT4hE8ISyUNJZp68NEAB+tkhNb+YD26T
         xNgugnYPzmgevNR6D5k86W4ulrH3L0jDRS7G3sGVVUgAlxTBGOvQVRoAzHgr2XPMIiH3
         OpIJet3RspQWnOijdRPvbT94hA5n591PjWPLMC+jGI+BIgLFgPl2Hehs09U8NeAbyzCg
         P2QA==
X-Gm-Message-State: APjAAAUtAsyWcPAD0gx1YYNDHEaTnmCTf7iYMLX+5bZeGLAT+FVldyIV
        UXr896OdapXbmOo9KQIiyO/KY+olQcE=
X-Google-Smtp-Source: APXvYqxzNgICRLz31TuNCbiNHXiNhH0Lyu27oebKWdTKttePk1LwZrftmpiEAUwwZ9dt0dR5LM8CXQ==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr3735887wmk.115.1582108626841;
        Wed, 19 Feb 2020 02:37:06 -0800 (PST)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id d22sm2297956wmd.39.2020.02.19.02.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 02:37:05 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:37:04 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Avi Kivity <avi@scylladb.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
Message-ID: <20200219103704.GA1076032@stefanha-x1.localdomain>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
 <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
 <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 12:54:30PM +0200, Avi Kivity wrote:
>=20
> On 12/02/2020 12.47, Paolo Bonzini wrote:
> > On 12/02/20 11:29, Stefan Hajnoczi wrote:
> > > On Wed, Feb 12, 2020 at 09:31:32AM +0100, Paolo Bonzini wrote:
> > > > On 29/01/20 18:20, Stefan Hajnoczi wrote:
> > > > > +	/* Semaphore semantics don't make sense when autoreset is enabl=
ed */
> > > > > +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
> > > > > +		return -EINVAL;
> > > > > +
> > > > I think they do, you just want to subtract 1 instead of setting the
> > > > count to 0.  This way, writing 1 would be the post operation on the
> > > > semaphore, while poll() would be the wait operation.
> > > True!  Then EFD_AUTORESET is not a fitting name.  EFD_AUTOREAD or
> > > EFD_POLL_READS?
> > Avi's suggestion also makes sense.  Switching the event loop from poll()
> > to IORING_OP_POLL_ADD would be good on its own, and then you could make
> > it use IORING_OP_READV for eventfds.
> >=20
> > In QEMU parlance, perhaps you need a different abstraction than
> > EventNotifier (let's call it WakeupNotifier) which would also use
> > eventfd but it would provide a smaller API.  Thanks to the smaller API,
> > it would not need EFD_NONBLOCK, unlike the regular EventNotifier, and it
> > could either set up a poll() handler calling read(), or use
> > IORING_OP_READV when io_uring is in use.
> >=20
>=20
> Just to be clear, for best performance don't use IORING_OP_POLL_ADD, just
> IORING_OP_READ. That's what you say in the second paragraph but the first
> can be misleading.

Thanks, that's a nice idea!  I already have experimental io_uring fd
monitoring code written for QEMU and will extend it to use IORING_OP_READ.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ND9AACgkQnKSrs4Gr
c8gMHAf/f9UuwAwjiMV/pwZZbwcYseAmnQ2FPZYE5HhiWScgJAg19otfE4JxYwR5
/NhXUNyYhp7sa0+fB+/aHJF/0mpIY70Mn1PX2umT7kb4ZpP6Qel0ZyVRuNOSp+k5
Wm19LAvKD4AyVu2Kxd4RJpibSu+UYelAT3Nh1d/c8Grrf0zHdcAj4Y4YwfTao1Xo
kPgrIWGOPS7qxvS+fyg9ifT13LfhwFhpP3679AlOhUozQUrxnM77G8ehAOJQV8mS
Ae+//m8fs/RVH2SRNgy7uRIr/v8pWdGt241pW8507oFHJChsRLFhNXJIWHP0dlUU
xHILARbPURoXO+KG1YPtyO2Y+16cZQ==
=5mbR
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
