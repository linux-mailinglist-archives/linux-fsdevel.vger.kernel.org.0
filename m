Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1907312BE9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 20:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfL1TPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 14:15:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfL1TPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 14:15:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so13069235plt.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2019 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=SvOoylQ6teeU3N0UBqZLiYR+yruKjrC1zR60QXBr0Jk=;
        b=pLnScRwstsbDt2cv0ddGWf6yaMNWpKrknH6skWGkChcgaiTmUitKYRrHuYguS/eA+Z
         T8tCsB+r0yhbgkoXjYXZkwVycx4r2xs8EjnfHMAeuGGAxwI/GzURx92gmQThy9mZDNod
         nkcE1RS6FYftHoddStnJeRDBfn+3VO2SAXPdmWYVaYmoXfhfzRC5YJrP49ppNzSu7MYQ
         4hdnFEq54tjU9EEdCvESphmKaNqI+meaJkk4kJKpJW7FkmU4ywy46xCYGSDzVmg4pOhQ
         XVwY2ir5C9ojJJooGkNQSdV70Spvj8OLeZQVBCUppJWYpRIjD2foe+QVzF2Oj6aDpyi+
         d/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=SvOoylQ6teeU3N0UBqZLiYR+yruKjrC1zR60QXBr0Jk=;
        b=V0x8jzge1zdy5XGSgWgtnUWbllwhuGpuPXfn1+1JKQN44vU5dR93PRW53eLEuWX7Im
         u0GVdxrom0c5xkmIpxt9hQ0Q+NQLGfLqAVe7pNOZeLBZVm29q8kooY2iDkqKh5BgGeGI
         wssevcI55n43AkkkDW5HL7uxEEl1g7O3ZdfndvL2tjqBUiIGSP3ZEmemUXRJqaREXDGD
         PQvMbdC4u3zEwb1jP2lMfyrgnyRiY3x9PGaRLCzrCeWMEqV9q8K2pb+nNlZocT64SeHn
         hDWN9N1eShqUnXuIGOp81MN9mH89urhYPdQicZ2jL3nqb74NTJH2iH9QVlvTEu/m5Pn7
         qVCQ==
X-Gm-Message-State: APjAAAWgwjBmw9K5sCdPTtKDaLZ299lYZ0D7otDIa7SboW2BerDGUKa4
        mTNlpRvpAjap0D65SksHkd4xPw==
X-Google-Smtp-Source: APXvYqyoamHQsCeRHXqilswGLkqipjlpOaqzP0LJLs2XsktBWK/VCxaKAst+e04wIclOdDJWT1hqNg==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr33639409pjb.99.1577560502221;
        Sat, 28 Dec 2019 11:15:02 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 199sm47262164pfv.81.2019.12.28.11.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Dec 2019 11:15:01 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6C6421AB-84B1-4E9D-9E8F-492A704D2A16@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_39BFD451-41EB-47AD-A778-E1593D3723C6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Date:   Sat, 28 Dec 2019 12:14:57 -0700
In-Reply-To: <20191228143651.bjb4sjirn2q3xup4@pali>
Cc:     Eric Sandeen <sandeen@redhat.com>, David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_39BFD451-41EB-47AD-A778-E1593D3723C6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Dec 28, 2019, at 7:36 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
>=20
> Hello!
>=20
> I see that you have introduced in commit 62750d0 two new IOCTLs for
> filesyetems: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL.
>=20
> I would like to ask, are these two new ioctls mean to be generic way =
for
> userspace to get or set fs label independently of which filesystem is
> used? Or are they only for btrfs?
>=20
> Because I was not able to find any documentation for it, what is =
format
> of passed buffer... null-term string? fixed-length? and in which
> encoding? utf-8? latin1? utf-16? or filesystem dependent?

It seems that SETFSLABEL is supported by BtrFS and XFS, and GETFSLABEL
also by GFS2.  We were just discussing recently about adding it to ext4,
so if you wanted to submit a patch for that it would be welcome.

It looks like the label is a NUL-terminated string, up to the length
allowed by the various filesystems.  That said, it seems like a bit of
a bug that the kernel will return -EFAULT if a string shorter than the
maximum size is supplied (256 chars for btrfs).

The copy_{to,from}_user() function will (I think) return the number of
bytes remaining to be copied, so IMHO it would make sense that this is
compared to the string length of the label, and not return -EFAULT if
the buffer is large enough to hold the actual label.  Otherwise, the
caller has to magically know the maximum label size that is returned
from any filesystem and/or allocate specific buffer sizes for different
filesystem types, which makes it not very useful as a generic interface.


Cheers, Andreas






--Apple-Mail=_39BFD451-41EB-47AD-A778-E1593D3723C6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4HqbEACgkQcqXauRfM
H+Dm2g//SpKpi80w8UEmoN7QCS2u0vUtIkSIkPEnwm2aky+cIYNFUBYhvr3PTH0b
1dljQ/WDLghsalOBQSYAChYQejuWDqzW8WBF4OmILDB6hK4LGMZorSg8HDyqP5Kv
XSGBfKo9J1Kz5PViQIihfM9ioTF8iJPzK7kS2tW8/EKNFcJtbgt7s6S1jQOniwbh
L4SYhyWx1Tt+oFv+kazqzjD/JwI1aBeh9CJrdkV5i4G0HgwVW7C1sjgWNRk20bIx
NJVhH7AbXzYCkssipSGXY/uKAfbXtsbARtgyOOLmAL2IHBqiwxT9dCR9ev/1NGxn
FrWxiagxgKdPS8FQ5VnJNS8IYqxSHibMbVjQyLEXbEfHSarQcZ8GMkj4vRaGxeS0
K75+1dEClvrd8oAUY/UhHEs6aGYjF8OFvimu6UCoWRU9ogoKtdFfJ8G1tASOLCAd
vuAw2S2xv6ZSgIcZayq4pxCNlUYtq4jPYZ26/Ddz5QqRbaArWOvV7iXYI02uV9pw
SctIBAvO3nZ45OmHi2MDTGFS6w+IB14XcY9c60oTgM9spmxe1aWvjYRZOUxh1pAN
g2CKpasJpobdSxhpuQ5lIwxc//kz6GG6wVzUYBI9n4X/Cus7PKutJCdLbim0tvIK
DPaG8oZwuqpa650DAiJZzZGwUjOOmjRSg4YKrjVjEjmJctbQ0Rg=
=Qzkb
-----END PGP SIGNATURE-----

--Apple-Mail=_39BFD451-41EB-47AD-A778-E1593D3723C6--
