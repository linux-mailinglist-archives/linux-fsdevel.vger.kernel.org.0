Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA12CAAC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgLAScP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 13:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgLAScP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:32:15 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0381C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 10:31:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so1674624pgi.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0RILkJhwT1gNN2v1WOAqqXRJY0oRcDFSFoTrZJdnf4Q=;
        b=IR51M4ehABuMM6RkJRems+o/xPTA7D/jAaO6107e5tcDmAXTvPitnW8s5XBAhd+TbX
         fKHr+MG4+EHWwKWNe4LtLdebu1hKdi0IdE+L3rIxBnffFg3KwDWSsESsccmV8naMKW5o
         P7Boq6nAtTyR7XtX43JdqzM481lFcE3Zg3k19CMaWpO9ta41CIHxp0+oRZu1tMAQUP8B
         bSaM1z2HuhPdldAntdGBFc73qvV/oPisao2Pu12/0eLsaPdwk3g+b08iWjczQG/HS9dK
         hcSegO1s40rq/nDM8/s39ZLjjEkgXeFjjJg5A/JQ4fYi3c7Aw32viwp8Z1q4zo/Vrou5
         Z/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0RILkJhwT1gNN2v1WOAqqXRJY0oRcDFSFoTrZJdnf4Q=;
        b=hpLs2gaLUIqrTEz7FEfFutwdZwnrA/N1pgHtzkXLCYx8tQht3DmA7QXpR1BJlr0yPK
         pljJkL1FlYkVdJVkUBTzktQBfDIXVP3km7PLmhTw+QV8p73q417uLqnhBV/EgIN2oKIQ
         63MZkzRYYZA+2WGqEpUwsEJCwZLLVVh1jT7SnDDGqWqvxy/h/l/BtYVssDCwnyNseqMH
         UNZCN4+938r4zdBG2MJyEC7OWJqEjd+eriaYT9dRuJlclef+BXKEXigovP+07S3ncY56
         lKZUiYNla+2rq7RSi8dT61Y1hlxCHBRD8H0o7RAXYywsIWZyRMf42hd6/SUDBOMawaO4
         N9Fg==
X-Gm-Message-State: AOAM531lYVV6CTDhAgNgi6v2rSQ7VjrOa2fi6gu/yaS/pC1t7xMiOdTR
        nqoBAnMbLn5VRIF/GlIBEEwF6g==
X-Google-Smtp-Source: ABdhPJylEh/Yf0I5dqANnamzUb9OMOunJOqwyS2HEELj8E62cuaX7M7t9wxCRpFmCuPCZn2bQgWrmw==
X-Received: by 2002:a63:b511:: with SMTP id y17mr3432421pge.345.1606847494108;
        Tue, 01 Dec 2020 10:31:34 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id iq3sm368325pjb.57.2020.12.01.10.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 10:31:32 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7E59D613-41D7-4AD1-8674-BCF9F5DC2A0C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0A927CB4-C95C-4C8C-AFBA-8F091BDCA3B9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Date:   Tue, 1 Dec 2020 11:31:28 -0700
In-Reply-To: <242fce05-90ed-2d2a-36f9-3c8432d57cbc@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Xiaoli Feng <xifeng@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
 <20201201173213.GH143045@magnolia>
 <242fce05-90ed-2d2a-36f9-3c8432d57cbc@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_0A927CB4-C95C-4C8C-AFBA-8F091BDCA3B9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 1, 2020, at 10:44 AM, Eric Sandeen <sandeen@redhat.com> wrote:
>=20
> On 12/1/20 11:32 AM, Darrick J. Wong wrote:
>> On Tue, Dec 01, 2020 at 10:57:11AM -0600, Eric Sandeen wrote:
>>> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same =
value,
>>> so one of them needs fixing. Move STATX_ATTR_DAX.
>>>=20
>>> While we're in here, clarify the value-matching scheme for some of =
the
>>> attributes, and explain why the value for DAX does not match.
>>>=20
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>> ---
>>> include/uapi/linux/stat.h | 7 ++++---
>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>>> index 82cc58fe9368..9ad19eb9bbbf 100644
>>> --- a/include/uapi/linux/stat.h
>>> +++ b/include/uapi/linux/stat.h
>>> @@ -171,9 +171,10 @@ struct statx {
>>>  * be of use to ordinary userspace programs such as GUIs or ls =
rather than
>>>  * specialised tools.
>>>  *
>>> - * Note that the flags marked [I] correspond to generic =
FS_IOC_FLAGS
>>> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS =
flags
>>>  * semantically.  Where possible, the numerical value is picked to =
correspond
>>> - * also.
>>> + * also. Note that the DAX attribute indicates that the inode is =
currently
>>> + * DAX-enabled, not simply that the per-inode flag has been set.
>>=20
>> I don't really like using "DAX-enabled" to define "DAX attribute".  =
How
>> about cribbing from the statx manpage?
>>=20
>> "Note that the DAX attribute indicates that the file is in the CPU
>> direct access state.  It does not correspond to the per-inode flag =
that
>> some filesystems support."
>=20
> Sure.  Consistency and specificity is good, I'll change that.
>=20
>>>  */
>>> #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File =
is compressed by the fs */
>>> #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File =
is marked immutable */
>>> @@ -183,7 +184,7 @@ struct statx {
>>> #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: =
Automount trigger */
>>> #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a =
mount */
>>> #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity =
protected file */
>>> -#define STATX_ATTR_DAX			0x00002000 /* [I] File =
is DAX */
>>> +#define STATX_ATTR_DAX			0x00400000 /* File is =
currently DAX-enabled */
>>=20
>> Why not use the next bit in the series (0x200000)?  Did someone =
already
>> claim it in for-next?
>=20
> Since it didn't match the FS_IOC_SETFLAGS flag, I was trying to pick =
one that
> seemed unlikely to ever gain a corresponding statx flag, and since =
0x00400000 is
> "reserved for ext4" it seemed like a decent choice.
>=20
> But 0x200000 corresponds to FS_EA_INODE_FL/EXT4_EA_INODE_FL which is =
ext4-specific
> as well, so sure, I'll change to that.

If you look a few lines up in the context, this is supposed to be using =
the
same value as the other inode flags:

 * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
 * semantically.  Where possible, the numerical value is picked to =
correspond
 * also.

#define FS_DAX_FL                       0x02000000 /* Inode is DAX */
#define EXT4_DAX_FL                     0x02000000 /* Inode is DAX */

(FS_DAX_FL also used by XFS) so this should really be "0x02000000" =
instead
of some other value.

Cheers, Andreas






--Apple-Mail=_0A927CB4-C95C-4C8C-AFBA-8F091BDCA3B9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/GjAAACgkQcqXauRfM
H+AnKw//cRgK1C4EfGuGNe66Y54cpBM0GiwtonyQ9A3HdrekbHxppM4b47mYBUoj
km4UMhalpNyJS/2OvEoKfpjzBmni6TCvyTaGcAqt9qoTsRIniGXimGXKQI4m//gq
mjmNiVMlp00H3e7/BNGHUfq5U/6kquPwspv3Qb+VCeEOE2ZOLJG8htYhOejoKaiK
RWxL6JCvoaJAvzeywnoeaiDDqt70sU8KGx+dBptJ6My3gcJviBtifRBjC04aqwjr
Hs+jwCxlJNFRRg6SWVXXY7i/8WLyHYeWDrGpcNYIO8DyN7tJ58SQvZsdCiBz9UTQ
USHMCUnte5oQw7FuPavdzn7NMKvuL21s4nu8gLEuDhW2tFMg2hIZyVa/WwjBpcbT
TDQymhAs376Ex8D19/XxAKxtsHwO5ioZfmzxol/WXLWeY2y/Rk8i5ifAbYlTAQB1
oYE8kZmrVJevRE86P5TBqWacrl2SP51YFo7V/3uooCaq8bhPi1tcE3fzcXpK02Yd
oktXB9HEhNwn+mSAjwxxXhBXYL77vUnwrH/NhsaK7SuSzLtEq+RfHgP2AZcTala9
2K41nItn2UlWLBnD4j1v1p2ba4HqVyvMVN6FABDjTDd1Sls7F7cX4h2NvRpKtABC
g/mM9Q3YIgn3/jqmX7jkBgegQfgy6cBoZV+tvRJBzia2qWwzQR8=
=6iL3
-----END PGP SIGNATURE-----

--Apple-Mail=_0A927CB4-C95C-4C8C-AFBA-8F091BDCA3B9--
