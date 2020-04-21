Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A221B2F40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDUSje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUSjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:39:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC94C0610D5;
        Tue, 21 Apr 2020 11:39:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so17704510wrv.10;
        Tue, 21 Apr 2020 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJizhPIf6NyV4cNeByQHlIQadv8zhj6cKyLoJX/fLXM=;
        b=qH6BVMauEPuWbI8+BqffzDitAkq3uZsNaYUszFsBZlo5/0pvT8PetpRt+eKyLgqsEg
         O9YmJcq2/tUPI9EDwYGAbEQAbYN7/nvVLPyTTLc53/5/+AB0gX7ATZxeJ0nJw+2vjYu9
         bC4DwtMA/iEdoQtljh4imeJUEirGItjd06vAnpU2L3wUP6fOaYdAlIyjL0RHY4rV7qDT
         mUMb2HyShVulBP/n5emPkb1VV7qOASGtLhM0EFaqSN02/65Crcj1Y5Rda0guQl/Hya4H
         xYYVbYypKNmXP4niTV25nc7zHROJgtz5lwdcnmUM4uoS5KPsNYekc3z3TTmWDzMp8R8W
         N4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJizhPIf6NyV4cNeByQHlIQadv8zhj6cKyLoJX/fLXM=;
        b=p0H/BmAB57UpOzBsPzkcEd4YeB2k2L39pTvdhOu19u0Vz5E4Qem+ceyzvLrP1j/R6O
         0BxFx7HRLYmA2M6Xw1/+htMi4NOML3txMFlfXOh3qjDZTe/LiIbNZjRFvvXc4KWzDvOJ
         trSSbyYsZIK+4oqID07amRxxUy0++L7K4izxt2cZT3z9mb06CDbzIR1a0ZO1pkfufjIK
         ruf8xGa9WjiDl0pwn4NfGYl+zkFOtmjZBsOPR9ckuz+q9piRnSPM60fEsjSHS5G/9M29
         +Li3/NOpuf1yZyKz8RCTvim8FtAL9m+ijP+0TpKabtYAKKZm91vu2kvbuPlTKtLAqyFI
         97YA==
X-Gm-Message-State: AGi0Pua7sYJ62VagFoENaI6NgRpo26o9I2o/C+vaJ2hvtvUG3ef74hA9
        mjorciIeTOGVyN9W5kjL33c=
X-Google-Smtp-Source: APiQypLLikwviD8b9Vkdy0Qs/Vnnj4zd4DX2356a0g73c8ikttpINLFkGHuDZeNC5xcWj+eKMeKbxQ==
X-Received: by 2002:adf:e486:: with SMTP id i6mr24389202wrm.377.1587494371379;
        Tue, 21 Apr 2020 11:39:31 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2:2::1])
        by smtp.gmail.com with ESMTPSA id h6sm4683609wmf.31.2020.04.21.11.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 11:39:30 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jQxns-0006E5-PS; Tue, 21 Apr 2020 20:39:28 +0200
Date:   Tue, 21 Apr 2020 20:39:28 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200421183928.GA23758@dumbo>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
 <20200420185255.GA20916@dumbo>
 <20200421154333.GG6749@magnolia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20200421154333.GG6749@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 08:43:33AM -0700, Darrick J. Wong wrote:
> On Mon, Apr 20, 2020 at 08:52:55PM +0200, Domenico Andreoli wrote:
> > On Sun, Mar 01, 2020 at 10:35:36PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli <domenico.andreoli@=
linux.com> wrote:
> > > >
> > > > Maybe user-space hibernation should be a separate option.
> > >=20
> > > That actually is not a bad idea at all in my view.
> >=20
> > I prepared a patch for this:
> > https://lore.kernel.org/linux-pm/20200413190843.044112674@gmail.com/
>=20
> If you succeed in making uswsusp a kconfig option, can you amend the
> "!hibernation available()" test in blkdev_write_iter so that users of
> in-kernel hibernate are protected against userspace swap device
> scribbles, please?

Yes, that's the plan.

>=20
> --D

Domenico

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ0d58WdvR3VfrFIt+pSrUd21xpcFAl6fPdsACgkQ+pSrUd21
xpdgzxAAzENdcM+tVdeJp7QwPwm0wea0IR10oKlhNdCrfL0n/EL2xJyXaWsKZQN6
tQN8O5rsM/FMagaY/askhRd0yv/nVcSxeWHlnlvDlVB8vK6jd4sJYekuReL1xA3c
4CD2y38JkX5m1BNkljm1Twg+kfgZSRv8g7rWQ31rOotF+joJvBkPUdd0cyiGWxrd
zy9/r5MpAPk5O4ya6TjzVarGZvSmqzqJ92MMHCvCumGOC1lEHqOU1GzsTZvrYcYI
R8OLNfeDcHKeSjg6NGjRBKHNeuYy3PanlNNabYBDY1eICCicSOTh9gw2iiKSyN7j
MKboOazCUwH77IK+qimrx1WL1zhH1AeGvn4yxIZPIQGs48oYL4cJw4RaCDfNj2gY
ynHGRZD5OcPWmHwsfmTV52uRWHRis7ziOE4ay09Pw/JYl0+q+54d2z//O6wy+EJg
uImjyBxpza4ySqrZ1QLJoOlw/vaD9rQXlk7IBav39xHpXBoUs86t3KnrNyXWMthV
AcN04jHhsjjebYzu9HvJO2DwxtobKhenkivHJcRGZH8c1p8VvsSeLWQqSTpz2bqx
n47SGboLz518iSwGelnXe9RYxqaHyld4+eMwXXrOWhl6DA7ruGvMqIvZYqKJgb2P
KnSbCPc6K8r/ImOgHvIOkcJ3hDyvaRIs3IArV8RpO/X78MZX7JI=
=9bYt
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
