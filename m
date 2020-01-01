Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5F12E023
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2020 19:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgAASjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jan 2020 13:39:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34140 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAASjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:39:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so37464663wrr.1;
        Wed, 01 Jan 2020 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HvBEzrmYz69a4NMFwWtIzRWoAgKYkgUWVarQ3dgxM2g=;
        b=UEvfJALbnySSRtHWUhvjWZnpYARbWZMA4Dft/STZFdWZVeVabEF52SJh41hv7gChWl
         07u0HfHKoEpvNbA/kZux/txZRTimQMwRMmYawgUbcCBH0WmxRNLCjtvO/2hvnHKzLblf
         RlyZN25C+yuFAS3GxVAU3HP2y4WQZ1LfBwJhFTXhFZIkUcDpHLdW/apldEQmA4+3/nbr
         JaZoDOZvfnU4sGLX/a0snfc0ISYIht5Ew3RFSdVkj6Cbw0b2LEqP3qRBitAHunEg7eAl
         gtkgyKSyICAo5rQMMwYAQtpknpB0GUfWJGdl42FgFS8kMleRGC/hp/xfLNOcn3qbkAdv
         b5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvBEzrmYz69a4NMFwWtIzRWoAgKYkgUWVarQ3dgxM2g=;
        b=Ca9l/Urxl9VLbtKIxQ6s6iWERIS1Jv1gyki9blMzbIWY4Oprrd2JqXWSoIhSAlKSZj
         dE5As6S0iy7mvTq1RzBUR99INUTg1OuG/18xgbMR8I/NUxBP5FDhiGjUc66E846kRPAB
         b8Wpu2WmmY8Rs6viJcYPacXmIY+fnU98gUVs0l7Y7SsNrz5vUWHLSOn2aX/QPNZLQmDy
         XYiQ5/IgUqiMp9HoPAwie1KY50DtnuFAHKbGTJCgbrdOhww3StP6Db/v3xXYULxqrupJ
         ygTTfwzu517VMaTZotbpTmgganGmuK4AdaZYqE46YPJDh+LxnP2NrSBTMBT4YkVliaHZ
         tnxQ==
X-Gm-Message-State: APjAAAUG2EqVEKuzUem0+CzzeAGldPCuIS00Cr4FitBg6m7TcloYqe2t
        T90bzU9+1u9lKkO2xEmzgPM=
X-Google-Smtp-Source: APXvYqziJ2bzVefnHhd60hvpZStBd29KtBFJyz3gkmsi2mvksf3gTmi44s102RIVKCGo2735JUxCfA==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr73877703wrk.53.1577903962068;
        Wed, 01 Jan 2020 10:39:22 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x7sm52762649wrq.41.2020.01.01.10.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 10:39:21 -0800 (PST)
Date:   Wed, 1 Jan 2020 19:39:20 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20200101183920.imncit5sllj46c22@pali>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
 <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
 <20200101181054.GB191637@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ljaqsjjx2ntjyawm"
Content-Disposition: inline
In-Reply-To: <20200101181054.GB191637@mit.edu>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ljaqsjjx2ntjyawm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 01 January 2020 13:10:54 Theodore Y. Ts'o wrote:
> On Tue, Dec 31, 2019 at 04:54:18PM -0600, Eric Sandeen wrote:
> > > Because I was not able to find any documentation for it, what is form=
at
> > > of passed buffer... null-term string? fixed-length? and in which
> > > encoding? utf-8? latin1? utf-16? or filesystem dependent?
> >=20
> > It simply copies the bits from the memory location you pass in, it knows
> > nothing of encodings.
> >=20
> > For the most part it's up to the filesystem's own utilities to do any
> > interpretation of the resulting bits on disk, null-terminating maximal-=
length
> > label strings, etc.
>=20
> I'm not sure this is going to be the best API design choice.  The
> blkid library interprets the on disk format for each file syustem
> knowing what is the "native" format for that particular file system.
> This is mainly an issue only for the non-Linux file systems; for the
> Linux file system, the party line has historically been that we don't
> get involved with character encoding, but in practice, what that has
> evolved into is that userspace has standardized on UTF-8, and that's
> what we pass into the kernel from userspace by convention.
>=20
> But the problem is that if the goal is to make FS_IOC_GETFSLABEL and
> FS_IOC_SETFSLABEL work without the calling program knowing what file
> system type a particular pathname happens to be, then it would be
> easist for the userspace program if it can expect that it can always
> pass in a null-terminated UTF-8 string, and get back a null-terminated
> UTF-8.  I bet that in practice, that is what most userspace programs
> are going to be do anyway, since it works that way for all other file
> system syscalls.
>=20
> So for a file system which is a non-Linux-native file system, if it
> happens to store the its label using utf-16, or some other
> Windows-system-silliness, it would work a lot better if it assumed
> that it was passed in utf-8, and stored in the the Windows file system
> using whatever crazy encoding Windows wants to use.  Otherwise, why
> bother uplifting the ioctl to one which is file system independent, if
> the paramters are defined to be file system *dependent*?

Exactly. In another email I wrote that for those non-Linux-native
filesystem could be used encoding specified in iocharset=3D mount
parameter. I think it is better as usage of one fixing encoding (e.g.
UTF-8) if other filesystem strings are propagated to userspace in other
encoding (as specified by iocharset=3D).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ljaqsjjx2ntjyawm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgznVgAKCRCL8Mk9A+RD
Uq/dAKC/LUl+L6i+bIx/lS/Q9eX7ypHzPwCgqJTJ2tEJd/GWDuze8BuYQyPk1TU=
=Er2m
-----END PGP SIGNATURE-----

--ljaqsjjx2ntjyawm--
