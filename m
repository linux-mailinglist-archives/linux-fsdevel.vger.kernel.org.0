Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E111DC461
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 02:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgEUA54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgEUA5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 20:57:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B33C061A0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 17:57:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so2148548pjb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 17:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=KGVkUClSLYZCYqVJ3Vb5pZma0B0CMSc9xCimjRrMQV4=;
        b=EnQnho+durolBvxcF0rxSWNlK3Jrfd93rhtSLlUIhi9jN+cueOLJafrsVZwBtv+S4T
         u55ccsGngVMxemnta6jzq7wQr0igjPVYLCO8xLpwPlrlYTCvOdeeqy/VJ/6Vk/h88zXl
         l1LoAoIyNz7ljBFkIsL9VzXKO+sseDFQLBf6PzhnBvs4ofZ6JPuIrassGtHsUKVac8AN
         smMD1oLfWN2s9P6qa6JLgmq7SC1WH1KuGsnULxIkCdiJ5QPLyM4sBHihQ+2SwcD30Nr3
         Rm5kO+A6kY3IyayvdnN/lO9Wvs13f8pJOc0dK+agLWoF4o909nKS1b+PZsxcQgXG19Zs
         Rzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=KGVkUClSLYZCYqVJ3Vb5pZma0B0CMSc9xCimjRrMQV4=;
        b=ZtbKC3GRZ4G7h2CNKSqxiMEX+e0APfeIlBK7RLslBy297sudoJj2WR76TSpLaah8GO
         gVUUPzTwhG+qERefh+tPFHtw/rO0DDuRSofPKSmlR5NEfUmAw/WyM+NqN0rZtfNo1aiz
         ST2T3AQ8c3/j+pk2NOlYlilE3qsc6unb3TW2MC5KB1+6RmM7mDUd7BT43hFvs6tQL+Cf
         qsEbiWS+lVQL22xDhqXibvsBshklb717l8snBsT+mHI007TyNFjS4ZokFw4BSfbkw1f6
         B4zbMjFhHlgLEWfZldY7M6rIwYH3lPBfgEit1YbJevE+M1tM6tMhMWyrN6FeWjfjPY2I
         Zm0g==
X-Gm-Message-State: AOAM530YYYPJaIsnAAtJ5u7OdsIA9xJJcgjHvqKCFxkJgtle3ZzSwkdD
        Zg5OATEU4bPST5//qFHLKTGlZQ==
X-Google-Smtp-Source: ABdhPJwaaQYhjUcbFZBfpiHUoSoUl0ma74EGGoSXAFK2cUprsydh9kP/qRONl5U5tw78WUFI6JGn7w==
X-Received: by 2002:a17:90a:734b:: with SMTP id j11mr8170570pjs.108.1590022673733;
        Wed, 20 May 2020 17:57:53 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e13sm2744584pfh.19.2020.05.20.17.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 17:57:52 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <5D85188E-34E0-49F0-8A77-0AF4CD0EC3E1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1495D86A-A351-44B7-922D-BABD111013ED";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V3 7/8] fs/ext4: Introduce DAX inode flag
Date:   Wed, 20 May 2020 18:57:49 -0600
In-Reply-To: <20200520205509.GA17615@magnolia>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Xi <lixi@ddn.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-8-ira.weiny@intel.com>
 <34ECB1DE-9F2F-4365-BBBC-DFACF703E7D4@dilger.ca>
 <20200520200242.GG3660833@iweiny-DESK2.sc.intel.com>
 <20200520205509.GA17615@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_1495D86A-A351-44B7-922D-BABD111013ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 20, 2020, at 2:55 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
> On Wed, May 20, 2020 at 01:02:42PM -0700, Ira Weiny wrote:
>> On Wed, May 20, 2020 at 01:26:44PM -0600, Andreas Dilger wrote:
>>> On May 19, 2020, at 11:57 PM, ira.weiny@intel.com wrote:
>>>>=20
>>>> From: Ira Weiny <ira.weiny@intel.com>
>>>>=20
>>>> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
>>>>=20
>>>> Set the flag to be user visible and changeable.  Set the flag to be
>>>> inherited.  Allow applications to change the flag at any time with =
the
>>>> exception of if VERITY or ENCRYPT is set.
>>>>=20
>>>> Disallow setting VERITY or ENCRYPT if DAX is set.
>>>>=20
>>>> Finally, on regular files, flag the inode to not be cached to =
facilitate
>>>> changing S_DAX on the next creation of the inode.
>>>>=20
>>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>>>=20
>>>> ---
>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>> index 6235440e4c39..467c30a789b6 100644
>>>> --- a/fs/ext4/ext4.h
>>>> +++ b/fs/ext4/ext4.h
>>>> @@ -415,13 +415,16 @@ struct flex_groups {
>>>> #define EXT4_VERITY_FL			0x00100000 /* Verity =
protected inode */
>>>> #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for =
large EA */
>>>> /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
>>>> +
>>>> +#define EXT4_DAX_FL			0x01000000 /* Inode is =
DAX */
>>>> +
>>>> #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has =
inline data. */
>>>> #define EXT4_PROJINHERIT_FL		0x20000000 /* Create =
with parents projid */
>>>> #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
>>>> #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 =
lib */
>>>=20
>>> Hi Ira,
>>> This flag value conflicts with the reserved flag in e2fsprogs for =
snapshots:
>>>=20
>>> #define EXT4_SNAPFILE_FL                0x01000000  /* Inode is a =
snapshot */
>>=20
>> Sure NP but is that new?  I'm building off of 5.7-rc4.
>>=20
>> Just curious if I completely missed something.
>=20
> Yeah, you missed that ... for some reason the kernel ext4 driver is
> missing flags that are in e2fsprogs.  (huh??)

It's no different than ext2 not having the full set of bits defined or
in use.

> I would say you could probably just take over the flag because the =
2010s
> called and they don't want next3 back.  I guess that leaves 0x02000000
> as the sole unclaimed bit, but this seriously needs some cleaning.

Darrick,
we are in the process of updating the snapshot code for ext4, so need to
keep the 0x01000000 bit for snapshots.  Since 0x02000000 has never been
used for anything, there is no reason not to use it instead.

If we need to reclaim flags, it would be better to look at "COMPR" =
flags:

/* Reserved for compression usage... */
#define FS_COMPR_FL           0x00000004 /* Compress file */
#define FS_DIRTY_FL           0x00000100
#define FS_COMPRBLK_FL        0x00000200 /* One or more compressed =
clusters */
#define FS_NOCOMP_FL          0x00000400 /* Don't compress */

since I don't think they have ever been used.  I don't think we need 4x
on-disk state flags for that, especially not as part of the API.  It is
enough to have FS_COMPR_FL for the API, and then handle internal state
separately (e.g. compress into a separate on-disk extent and then swap
extents atomically instead of storing transient state on disk).

Cheers, Andreas






--Apple-Mail=_1495D86A-A351-44B7-922D-BABD111013ED
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7F0g0ACgkQcqXauRfM
H+CWlRAAu3u2+ZaTMjCUV9frowE4dctq6hQJiA8VeuTTKBNRQIZ+kVXOtFtsbASL
8CaEdjxXsCVyrxFVG1cjCI2GU+90Ae77P52Z5dfzIv0YEA4CC45lCQ/fSHYNfSBd
z1efesNBiaXnShzidJKR+4J1AtAbTWMVgTIcHPq1Vyim/0ECtv8HHspTZBCHm8R8
bY3Yjf5+0HYqAdsrqbWOC4eXOt1MchCkUokD8i1awqoNFSmupJedVI7ytZjeEUTW
oWX+iJCTfvH9rUZd9pJvnR1O3W1awSRueVeG6YXmQmD/PRyu03n5eFEHfo3MEvWm
XtND5oisszz8/RPI26LLmBLFXZjxziXKyvy90Z6+m9MmT0B/74CGbwYGZ4Y3/wL8
asC14AYoB6yZhM+wdPDlvHGEVvtQJS8yk/gcFK54D4j8K2jC+loIW4rE02liEGQA
lEFLCeKqJxS9KpnqMM+s54jjK/3dsLKnUm8i6KL1GWE/9umIURgE68Rd3HCdzb6c
IOQPcg0/USAjYQLA3TXzlsf126wHvT5DjD+296dDFP9uE7VyKzH5FnU/+gvtYqI8
JN1srfp7AdhsC/v0DxZn+FYFujF8gf2uCT5e/LuNajzPbUYGiOuv5+CWttMsu3mp
a1yfBYgR6sgx8ay0+V4tljFQroujSfYNFEAQVKIVL2asV8d4LA0=
=cMli
-----END PGP SIGNATURE-----

--Apple-Mail=_1495D86A-A351-44B7-922D-BABD111013ED--
