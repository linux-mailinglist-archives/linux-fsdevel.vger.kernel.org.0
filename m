Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0BA13C189
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 13:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAOMqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 07:46:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40349 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgAOMqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:46:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so7654400pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gmoQ2haBcdZ66ZDAcejuAD/SWwNHe0hv7/dpuVRBEMA=;
        b=ZV4lQu1bHo4asCHiL7ozMJpG/aEIGXOcgzjC/kEDUUZsdau0d9QRTdOQ30HzQuDYrV
         b41qPBXQtb8i3tlzlIXPXVz83Q2mensnr7ehTLBKYfYzkxqGhU4Pya07R2XawdaDQ7CU
         UM5VdJoDNVdjCuWnhyvmTm71oKafu/NPZlGMzsK7sq2ipah7itvwMWw4ZkpVn89065se
         P4nisLUT7hFX2ENj1YAnbmC1dYoq0i73Pt94XA4ZXgsv2xSSa4g097q/zOGM+1fzhMQt
         45Mi0/rP2wrjrYryo4Cah0ID66q7fFpqmDwHufPxEtnTeOteJV57X+d9YKXQob5UJd19
         toLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gmoQ2haBcdZ66ZDAcejuAD/SWwNHe0hv7/dpuVRBEMA=;
        b=VVc9V5igmp6SW1X94r0Lmd6aTHDb0ELdVbw2iXpmAhc8zVbHEd8hG22ken0zwM6ZaW
         TH651nXYHJwD1k73ABtfzvmfruPsoqFLOMeCfx9FKJ8QuUea4dFEFJRE1MAaISuVqeFP
         xpZLbyP3AkNAAHqiB6kcU/c7VEzHBDQA2nVwqD5No6g719v2A2+ITK0udIIsCv+8+SfQ
         sdptiMv1njqOxzWYgmBLv25Y7YjbCzynd4qzsGaRSMFXn1PH/3ShfVOBgTshMGy9lJi/
         lEz4jkUlF9C/tp+AsUO7w5cuvBp+4xRyjpH1fmiFlSOzSpU5OE8+1al1rmWzc4ID6G3Z
         79dw==
X-Gm-Message-State: APjAAAV5nl4ALnqTCWTEvKLNHo4n5yhdaUgXzvbFixEMMxR1rGQp62Zp
        93IsA3xMrkUP3kNZPryjXKqgMA==
X-Google-Smtp-Source: APXvYqzUxA7fFBZl1bJC5jmBI/c13+6jszL7qbSUfqyyg4cn3067Iuv26XRPqcfguDmjvZLqzdo6VQ==
X-Received: by 2002:a17:90b:30c8:: with SMTP id hi8mr35620232pjb.73.1579092374824;
        Wed, 15 Jan 2020 04:46:14 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e19sm20348397pjr.10.2020.01.15.04.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 04:46:14 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_28ADC79E-8B49-4CCD-92BE-382545043A5C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Problems with determining data presence by examining extents?
Date:   Wed, 15 Jan 2020 05:46:10 -0700
In-Reply-To: <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <4467.1579020509@warthog.procyon.org.uk>
 <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_28ADC79E-8B49-4CCD-92BE-382545043A5C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Jan 14, 2020, at 8:54 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
> On 2020/1/15 =E4=B8=8A=E5=8D=8812:48, David Howells wrote:
>> Again with regard to my rewrite of fscache and cachefiles:
>>=20
>> 	=
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dfscache-iter
>>=20
>> I've got rid of my use of bmap()!  Hooray!
>>=20
>> However, I'm informed that I can't trust the extent map of a backing =
file to
>> tell me accurately whether content exists in a file because:
>=20
>>=20
>> (b) Blocks of zeros that I write into the file may get punched out by
>>     filesystem optimisation since a read back would be expected to =
read zeros
>>     there anyway, provided it's below the EOF.  This would give me a =
false
>>     negative.
>=20
> I know some qemu disk backend has such zero detection.
> But not btrfs. So this is another per-fs based behavior.
>=20
> And problem (c):
>=20
> (c): A multi-device fs (btrfs) can have their own logical address =
mapping.
> Meaning the bytenr returned makes no sense to end user, unless used =
for
> that fs specific address space.

It would be useful to implement the multi-device extension for FIEMAP, =
adding
the fe_device field to indicate which device the extent is resident on:

+ #define FIEMAP_EXTENT_DEVICE		0x00008000 /* fe_device is =
valid, non-
+						    * local with =
EXTENT_NET */
+ #define FIEMAP_EXTENT_NET		0x80000000 /* Data stored =
remotely. */

 struct fiemap_extent {
 	__u64 fe_logical;  /* logical offset in bytes for the start of
 			    * the extent from the beginning of the file =
*/
 	__u64 fe_physical; /* physical offset in bytes for the start
 			    * of the extent from the beginning of the =
disk */
 	__u64 fe_length;   /* length in bytes for this extent */
 	__u64 fe_reserved64[2];
 	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
-	__u32 fe_reserved[3];
+	__u32 fe_device;   /* device number (fs-specific if =
FIEMAP_EXTENT_NET)*/
+	__u32 fe_reserved[2];
 };

That allows userspace to distinguish fe_physical addresses that may be
on different devices.  This isn't in the kernel yet, since it is mostly
useful only for Btrfs and nobody has implemented it there.  I can give
you details if working on this for Btrfs is of interest to you.

> This is even more trickier when considering single device btrfs.
> It still utilize the same logical address space, just like all =
multiple
> disks btrfs.
>=20
> And it completely possible for a single 1T btrfs has logical address
> mapped beyond 10T or even more. (Any aligned bytenr in the range [0,
> U64_MAX) is valid for btrfs logical address).
>=20
>=20
> You won't like this case either.
> (d): Compressed extents
> One compressed extent can represents more data than its on-disk size.
>=20
> Furthermore, current fiemap interface hasn't considered this case, =
thus
> there it only reports in-memory size (aka, file size), no way to
> represent on-disk size.

There was a prototype patch to add compressed extent support to FIEMAP
for btrfs, but it was never landed:

[PATCH 0/5 v4] fiemap: introduce EXTENT_DATA_COMPRESSED flag David =
Sterba
https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg35837.html

This adds a separate "fe_phys_length" field for each extent:

+#define FIEMAP_EXTENT_DATA_COMPRESSED  0x00000040 /* Data is compressed =
by fs.
+                                                   * Sets =
EXTENT_ENCODED and
+                                                   * the compressed =
size is
+                                                   * stored in =
fe_phys_length */

 struct fiemap_extent {
 	__u64 fe_physical;    /* physical offset in bytes for the start
			       * of the extent from the beginning of the =
disk */
 	__u64 fe_length;      /* length in bytes for this extent */
-	__u64 fe_reserved64[2];
+	__u64 fe_phys_length; /* physical length in bytes, may be =
different from
+			       * fe_length and sets additional extent =
flags */
+	__u64 fe_reserved64;
 	__u32 fe_flags;	      /* FIEMAP_EXTENT_* flags for this extent =
*/
 	__u32 fe_reserved[3];
 };


> And even more bad news:
> (e): write time dedupe
> Although no fs known has implemented it yet (btrfs used to try to
> support that, and I guess XFS could do it in theory too), you won't
> known when a fs could get such "awesome" feature.
>=20
> Where your write may be checked and never reach disk if it matches =
with
> existing extents.
>=20
> This is a little like the zero-detection-auto-punch.
>=20
>> Is there some setting I can use to prevent these scenarios on a file =
- or can
>> one be added?
>=20
> I guess no.
>=20
>> Without being able to trust the filesystem to tell me accurately what =
I've
>> written into it, I have to use some other mechanism.  Currently, I've =
switched
>> to storing a map in an xattr with 1 bit per 256k block, but that gets =
hard to
>> use if the file grows particularly large and also has integrity =
consequences -
>> though those are hopefully limited as I'm now using DIO to store data =
into the
>> cache.
>=20
> Would you like to explain why you want to know such fs internal info?

I believe David wants it to store sparse files as an cache and use =
FIEMAP to
determine if the blocks are cached locally, or if they need to be =
fetched from
the server.  If the filesystem doesn't store the written blocks =
accurately,
there is no way for the local cache to know whether it is holding valid =
data
or not.


Cheers, Andreas






--Apple-Mail=_28ADC79E-8B49-4CCD-92BE-382545043A5C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4fCZIACgkQcqXauRfM
H+B94hAAq/hGq+KM2EW4oM8Xq5qSFfrwDIPyyRLbCXbSfeZGLWbpHlWbaD9RXEIf
p/FBpXupxq8ihBMQEjbtbary5fyEHgpRAircigQ5AHkRj0QZlzftiXgYrsN1u6UQ
UZAsP8P7JuFBC3nwD9gPJOcwtLMuIsWFVk/1hCbYs5EkG75LNNzBM4uBCskzwB/e
p1TKmAgjzkO2JiGUo4iwHoZUzoFOgnLLeTXvDC5qqDvbqmW0MaG+wFbkYpb3lln3
W5JN63xrQ83epKfl1VrLu8YMqc6ZNldJst0CeNf3wF2PHtHiM1aIh8vv1E5AraDu
5JL8hdsIi5/EnhHlExZkQDi54zKMDF9tr9SvjON9kxmH148m6WVOEivnv5aG69ui
xso3+qjoRsi3WhNKnW8LgjnPTVaEGkAbDYDZd/nsB6IcPlTjRI+gExhRtqR76hIj
UVLlL0adfBVM+cvNoXh+2sdMrI5BGA6sIhesQdYKlIOyRKBHHmlDghpXVIz+ePHK
OsOD0rh28NGTbVhT2rnXOPdCyW1+Btp0gVUaq46oz2XCr6o0HYNUp4iCQtauNKvo
Mr9gy7oRv+64PAsjOazbWUUs65eRVIwCYaLUzLuFkfFIHbAoFjyb+Zaagz8EbOrn
KdgWCUCo0PDg76uzaIA2XSHKQpoPDeC5fDZmBlpcfIY5YHeWmrI=
=pzA/
-----END PGP SIGNATURE-----

--Apple-Mail=_28ADC79E-8B49-4CCD-92BE-382545043A5C--
