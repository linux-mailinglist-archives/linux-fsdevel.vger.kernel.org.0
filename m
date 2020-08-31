Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340EF25801D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgHaSDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgHaSDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:03:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC2C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:03:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d22so1009798pfn.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=g6E52b5I8mR5KAkbDEucrPH4cDy1aF3VO+CkmbQ2A0g=;
        b=ZAevM2/DMjnqqhuaoUhV6EqD8UIHo+sk/LFHZ4AbJqbIIYHaft988qsjgJtW7I9Lh/
         1MAoz94WnNB62n3+nHfsHhiBE7JoGSpdAoTko54bRLZC3cWLeuonBRm+THahtaky09zp
         msE0LwD59iKwZU8mUT8SyZ+HHdcJMwnbJgpzy4WTenLyM7sRdP3aKJfiyuE6CelErfqC
         QqlhF0PcckTQ2GuaifB+YmPiot2G1K32GgyJMzqILsMsaaZUy30GkVz6kCCjgTDUVJ3W
         hOdGiLSBUmBsAcpawNEtfxKMYXFbKgjK9BQYrSJnI4T4PoHc9Qz3KalleTEM5kUHiMrz
         HuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=g6E52b5I8mR5KAkbDEucrPH4cDy1aF3VO+CkmbQ2A0g=;
        b=WHrakpRtTqVANoBVszE6lXREWUeHm9Ub4Q05N0ZzZGHxyMzYtDhN8dUoWas0Bdh1Dv
         kUWmztr0OfO2DnaXb38ZlJBwQTIFGdKJbIfM73pNHe5koa6LTD7zcIEIhl7mArddDxvY
         UIhPRksEQoFMwck75djrRKVFrnuAZNmLRUUAxtY5LANUqacBPdOtSIY1m0SUISDKlvlq
         7BclK6Abv2HJxCv1I0ZENFIIRfCazlWRDFfT1dx/CfLY+kLGBAVMRHmra5MLokojPljz
         cQbPaUN3sM/HecfAUXkMvtrBrhIVwta26PA94bcNyL9N8bkRkqgV6zv5r+AyxkkWD7g+
         XSgw==
X-Gm-Message-State: AOAM53187jVz1aZXQCuG1oyn2v4iKCp9kFwF5HVaf9Wp5yq/YmzjRjeT
        4xADs4rhWaa+ZGURSsDyVucc+Q==
X-Google-Smtp-Source: ABdhPJxRXLVV7hqO93zsmyCKFR3vo+jtf3bfZtvBoADH5t1nBRLJKF3/m2lKE7aQvDoqBua0iZmcyw==
X-Received: by 2002:a63:4f26:: with SMTP id d38mr2077889pgb.72.1598896980014;
        Mon, 31 Aug 2020 11:03:00 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id lj3sm243104pjb.26.2020.08.31.11.02.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:02:58 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E7419E0D-6FF8-4E7E-B04A-835B0FE695B2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0BACD754-6F90-47C4-94D0-D0169FE89A87";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: xattr names for unprivileged stacking?
Date:   Mon, 31 Aug 2020 12:02:56 -0600
In-Reply-To: <20200831132339.GD14765@casper.infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
References: <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_0BACD754-6F90-47C4-94D0-D0169FE89A87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 31, 2020, at 7:23 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Aug 31, 2020 at 01:51:20PM +0200, Miklos Szeredi wrote:
>> On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> =
wrote:
>>=20
>>> As I said to Dave, you and I have a strong difference of opinion =
here.
>>> I think that what you are proposing is madness.  You're making it =
too
>>> flexible which comes with too much opportunity for abuse.
>>=20
>> Such as?
>=20
> One proposal I saw earlier in this thread was to do something like
> $ runalt /path/to/file ls
> which would open_alt() /path/to/file, fchdir to it and run ls inside =
it.
> That's just crazy.
>=20
>>> I just want
>>> to see alternate data streams for the same filename in order to =
support
>>> existing use cases.  You seem to be able to want to create an entire
>>> new world inside a file, and that's just too confusing.
>>=20
>> To whom?  I'm sure users of ancient systems with a flat directory
>> found directory trees very confusing.  Yet it turned out that the
>> hierarchical system beat the heck out of the flat one.
>=20
> Which doesn't mean that multiple semi-hidden hierarchies are going to
> be better than one visible hierarchy.

I can see the use of ADS for "additional information" about a single =
file
(e.g. verity Merkle tree with checksums of the file data) that are too =
big
to put into an xattr and/or need random updates.  However, I don't see =
the
benefits of attaching a whole arbitrary set of files to a single =
filename.

If people want a whole hierarchy of directories contained within a =
single
file, why not use a container (e.g. ext4 filesystem image) to hold all =
of
that?  That allows an arbitrary group of files/directories/permissions =
to
be applied to a tree of files, but the container can be copied or =
removed
atomically as needed?

Using a filesystem image as the container is (IMHO) preferable to using =
a
tarball or similar, because it can be randomly updated after creation, =
and
already has all of the semantics needed.

The main thing that is needed is some mechanism that users can access =
that
decides whether access to the image is as a file, or if processed should
automount the image and descend into the contained namespace.

Cheers, Andreas






--Apple-Mail=_0BACD754-6F90-47C4-94D0-D0169FE89A87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9NO1AACgkQcqXauRfM
H+DNiBAAnqNmf2BUolWIp4ZcQVocqjahcmZiYEQ52yQV+E5WsuicY9lAYGB6bu23
Oagdcrg1pCq2enAlH3zfOX1J/DLXcce97j+jjgDdpxo3Cwx0nCQrhUttGyBOQcIa
xh7TaK+nB8pY/d2CdB0ch+WO6Z9ZgLZFR0kvQUFzpsWLJi1HinfFZF1fZJC1Dnv7
0/ZYfvs26KHekQ9xcJdjspxr9jiu7QnSL1SuU0NuOHTnnSJClefy5v8zG5tfWzd+
bSZd7UNRptwU65o3XAey0djtyy5MptLE9+cUsIS4xOOpZQ4ioi5N3/prRlpXql+J
SUQW+o/p9gc+n/2fFu1kTXFRpbVZ2j2Gaa4Ta/bRgj0iy2uN71G3muYtmOiUA3Dy
s5PoSfrmlLiqVGkZ+7pmsczmxs5+coltYe+tjKPZzLUgWx/boOnedaFmOxgPSWx4
FWCLvtK2uLcIInoImrSlpKU9i0Ekil1eP1+mwUk6ySS/fOIj+T3XUxZK/zlUtvvc
TpyB1eklR2VvwnhgQNom67xXbBWUMRCSijoA/AuF9fxOvq3nEuIMTaiMI6XvspnZ
KerATteVos7bJN/4XPrt9aLfktCBDT/RLhXUtgPpJ4izQwLtcrRh+PR2HMCq3WX/
V2jgjFJC/kp38xsUlf7auizyABbFQHEsatiMDaSF04rto8aVO+k=
=2SkZ
-----END PGP SIGNATURE-----

--Apple-Mail=_0BACD754-6F90-47C4-94D0-D0169FE89A87--
