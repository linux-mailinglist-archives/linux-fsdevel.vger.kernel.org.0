Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A312BECC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 21:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL1UF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 15:05:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36410 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfL1UF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:05:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so11145121wma.1;
        Sat, 28 Dec 2019 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQE2V0MavIjoNa3rWrPGslDKiPQuFVjAyrybXIXUGeY=;
        b=ZXNtoDk1HoPwPXMqYewft/Zj1tZIXnee1UDRwt/Rc5lS4rPL2mno0dSI5qUC6AJjgx
         DLkvqXukklYETUJsYlZ5rqOPI/ciM7t0GhFiqJm/n1FGvXmKcQRIT+MAmQu9/lvJZtgb
         SFnb1TGg6eR8TogkrZH/vJiHTdDPwKaEHwj3WZ5tTOBQvjkezwC+X0AlgPB/4+VL7LMh
         QMBVD2wWaDxvzYsd3sk8EvT6O+Rc5nDEnIcTUhjY1TX+ZCerx6xnsHxbkKfGZCbtNtI1
         uquyudBb6Bx49vwRE0mdtHw08r8WF2etiP8lFBIZBGZqzTvWlz1a25KOuZpN9EZHZgMs
         WBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQE2V0MavIjoNa3rWrPGslDKiPQuFVjAyrybXIXUGeY=;
        b=L/iPW3EbeRBNEM9d9Yg1aE9P+DQdipkFVoJRVgEM3jx06rWyY6w6+ZpZEDu2eJYt7a
         E+RCh2WbgPJpjrPFvZl0A8qXnj47zp//ViLEmCn5XmG/2REWdgRv0g69z4V+X+fGiHLX
         Zii92rBZ+3ZZDNlXl5cQ5O8IWq5Z3OSw2tD1cAdnLTXABFKmiFB0BiJTBZLujZXQB9Yf
         YtWH0NP1q9B/ac0XACNTE2voXySC89zcdwMkRTvWqfeaXM93U+8J0ItsUxAJAKxCqHMq
         6fvJlUPbm/j82ZFfx57ZWF/Rm2nuDe3QtSQnnIOoekMxOIFjBR2xaKprKxS4mV/Ps1ZR
         vIBg==
X-Gm-Message-State: APjAAAWDogNS/56U3zFy/R4mCdLIsFLHx+9hbWKxtxhqXX7OBe/0eAzv
        1r+9F/zReYuOZ29XYpM8LXc=
X-Google-Smtp-Source: APXvYqyb+qdAahOi3oQdnd9Wk7oYjD7tet+dAL/Tt59wBdUc8wJ10u41Ft7XXDCFxH6N1MuSvtzALg==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr25649868wme.108.1577563525851;
        Sat, 28 Dec 2019 12:05:25 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id d10sm40217948wrw.64.2019.12.28.12.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 12:05:24 -0800 (PST)
Date:   Sat, 28 Dec 2019 21:05:23 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Eric Sandeen <sandeen@redhat.com>, David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20191228200523.eaxpwxkpswzuihow@pali>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
 <6C6421AB-84B1-4E9D-9E8F-492A704D2A16@dilger.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sqlj2znpmlbywobt"
Content-Disposition: inline
In-Reply-To: <6C6421AB-84B1-4E9D-9E8F-492A704D2A16@dilger.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sqlj2znpmlbywobt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 28 December 2019 12:14:57 Andreas Dilger wrote:
> > On Dec 28, 2019, at 7:36 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >=20
> > Hello!
> >=20
> > I see that you have introduced in commit 62750d0 two new IOCTLs for
> > filesyetems: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL.
> >=20
> > I would like to ask, are these two new ioctls mean to be generic way for
> > userspace to get or set fs label independently of which filesystem is
> > used? Or are they only for btrfs?
> >=20
> > Because I was not able to find any documentation for it, what is format
> > of passed buffer... null-term string? fixed-length? and in which
> > encoding? utf-8? latin1? utf-16? or filesystem dependent?
>=20
> It seems that SETFSLABEL is supported by BtrFS and XFS, and GETFSLABEL
> also by GFS2.  We were just discussing recently about adding it to ext4,
> so if you wanted to submit a patch for that it would be welcome.

I have in-progress patches for FAT with following ioctls:

  #define FAT_IOCTL_GET_VOLUME_LABEL(len)      _IOC(_IOC_READ, 'r', 0x14, l=
en) /* variable length */
  #define FAT_IOCTL_SET_VOLUME_LABEL           _IOC(_IOC_WRITE, 'r', 0x15, =
0)  /* variable length, nul term string */

GET ioctl macro takes length of buffer and pass it via standard ioctl
bits into kernel would know how many bytes can copy to userspace.

And via SET ioctl is passed null term string, so kernel copy from
userspace whole null term string (with some upper limit to page size or
1024 bytes).

I plan to finish FAT patches in next month.

> It looks like the label is a NUL-terminated string, up to the length
> allowed by the various filesystems.  That said, it seems like a bit of
> a bug that the kernel will return -EFAULT if a string shorter than the
> maximum size is supplied (256 chars for btrfs).

FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls now seems like a nice
general / unified approach, but it has problems which I already mention
in questions in previous email.

There are basically two kinds of filesystems when looking how filename /
label should be represented.

First group: file name / label is sequence of bytes (possible null
termined) without any representation. It can be in any encoding, it is
up to the user. There is no mapping to Unicode. Examples: ext4

Second group: file name / label is stored in exact encoding (defined
internally or externally by e.g. code page). There is exact translate
function to Unicode. For these file system there is either iocharset=3D or
nls=3D mount option which maps name / label to bytes. Examples: vfat
(UTF-16LE), ntfs (UTF-16LE), udf (Latin1 and UTF-16BE), iso9660 with
joliet (UTF-16LE), apfs (UTF-8).

All mentioned file systems by you are in first group, so you probably
have not hit this "implementation" problem for FS_IOC_GETFSLABEL yet.

And question is, what should FS_IOC_GETFSLABEL returns for file systems
=66rom second group?

In my implementation for FAT_IOCTL_GET_VOLUME_LABEL I'm reading label
buffer from filesyetem, then converting this buffer from encoding
specified in codepage=3D mount option to Unicode and then from Unicode I'm
converting it to encoding specified in iocharset=3D mount option. Why?
Because same procedure is used for reading file names from vfat when
corresponding file name does not have long UTF-16LE vfat entry (label
on vfat really is not in UTF-16LE but in OEM code page). And I think
that volume label should be handled in same way like file names.

Is above behavior "label in ioctl would be retrieved in same encoding as
file names" correct / expected also for FS_IOC_GETFSLABEL?

Or do you have better idea how should filesystems from second group
implement FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL? (E.g. always in UTF-8
independently of mount options? Or in filesystem native encoding, so
sometimes in UTF-16LE, sometimes in UTF-16BE, sometimes in DOS OEM code
page, sometimes in Latin1? Or something different?)

> The copy_{to,from}_user() function will (I think) return the number of
> bytes remaining to be copied, so IMHO it would make sense that this is
> compared to the string length of the label, and not return -EFAULT if
> the buffer is large enough to hold the actual label.  Otherwise, the
> caller has to magically know the maximum label size that is returned
> from any filesystem and/or allocate specific buffer sizes for different
> filesystem types, which makes it not very useful as a generic interface.

I think that my approach with specifying length in ioctl bits for GET
ioctl is more flexible. But I do not know if it is even possible to
change as API is already in kernel.

Also I see there more important bug in that API:

  #define FSLABEL_MAX 256        /* Max chars for the interface; each fs ma=
y differ */

  git show 62750d040bd13

  "This retains 256 chars as the maximum size through the interface, which
  is the btrfs limit and AFAIK exceeds any other filesystem's maximum
  label size."

It has some artificial limit for volume label length. Which filesystems
was checked that maximal label length cannot be larger?

E.g. on UDF filesystem (supported by Linux kernel for a long time) is
label stored in 128bit buffer. First byte specifies Unicode encoding,
last byte specifies used length of buffer. Two possible encodings are
currently defined: Latin1 and UTF-16BE. Therefore if FS_IOC_GETFSLABEL
for UDF would use UTF-8 encoding, then maximal length for label is:
(128-2)*2 =3D 252 plus null byte (*2 because all non-ASCII Latin1
characters which are one-byte are encoded in UTF-8 by two bytes). Which
is almost upper limit of API. And this is just first filesytem which
I checked. I would not be surprised if there is already filesystem which
maximal length exceed current limit defined by kernel API.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--sqlj2znpmlbywobt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXge1gQAKCRCL8Mk9A+RD
UrywAKCfx4kgRs+SJOQuyUWBXE7dBIUljQCgra3wY2jmQd4tFIye8imTGHncbKU=
=vXud
-----END PGP SIGNATURE-----

--sqlj2znpmlbywobt--
