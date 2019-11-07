Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DEF250C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 03:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKGCMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 21:12:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40773 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfKGCMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:12:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so1106928pfl.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2019 18:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lND0a/QZ/kzzfBaRTM52v39GPUt9IGJLbKna6xlvGWc=;
        b=E9nt9Zda9ZmaAVCTZ9u2gQsOmAcHCJbaGHoI/YO8Z+uWxTELDG31E7B9bYYyb2BTJE
         GRGcc7Lz88e0LbwWrbZUeFy7fK+F3BpkTrUNmYYlrIqcpbZdUegFx6C1CX/RGMNaqdj1
         Ad5s8Sq+3vdbq9WkylDf8kJzRRH92VQfBC+6+o2JBUQGsU5xMILNc2JSj4GhK4jFhixT
         lLJHfy/WaYHNC574eTjSK2xQCycNBAigQvl734xD0tPESuCi62o7i4FYWcHi9GwNglc2
         SWt6UNQiOyr08TwKfcOTh8HIgyu4pqFrRVMgBS6fQx/yivjUlDfKL2GdSrHA5YsmeMpQ
         UHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lND0a/QZ/kzzfBaRTM52v39GPUt9IGJLbKna6xlvGWc=;
        b=sytdZxwrfdWCUyjB706jt1C0xbIZTgtHtYNpZTxyO8IV99jjcjrovGDsFruaz4TfKO
         Ro3cs5Im3bsMcVGOHIg1eZ1JQaFdNvx+g0gg1jOubWIWL3vOVhbYs/E6dwyPOOf1Ogpz
         lsJyh7WfUPn8rjXU+Ti3rivdoMVJQ83xYEBuO8amied3j1BIT5nAcuJwTX6ATcJOjxBB
         xVmqxr97B/bq4FwZfwjhGbB2kQNhAtueAvVDMaSHENuunJgZtu+vWYl83wcPPauzxk+7
         rXBHV5NYhD6PoyeykUuSccSlEtEA5CFWYd1/sZnu3qTFMRbSDPM1+uhBnIzyeXx3oEZl
         d9Ag==
X-Gm-Message-State: APjAAAXWbnEcYmw0IJ+NDrydX6WCyO/BFP/v+aNg7upIeoTdM+olkL/d
        8gdxYDvfscHu1BuQ9UZosDnf7w==
X-Google-Smtp-Source: APXvYqz63fAIViICS1tEROcaB2czzrHA8q7TJwg8iXkKJ6Mbv4ipKW4aRC0BZiQxQ6iT896wyzjbvA==
X-Received: by 2002:aa7:971d:: with SMTP id a29mr693865pfg.205.1573092751343;
        Wed, 06 Nov 2019 18:12:31 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f59sm5268936pje.0.2019.11.06.18.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:12:30 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EFEE536E-B2E7-4AFF-ADCD-8C39F26E9C70@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F6EB440A-C078-4861-A5DE-5E6513FE9F53";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] statx: define STATX_ATTR_VERITY
Date:   Wed, 6 Nov 2019 19:05:38 -0700
In-Reply-To: <20191107014420.GD15212@magnolia>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20191029204141.145309-1-ebiggers@kernel.org>
 <20191029204141.145309-2-ebiggers@kernel.org>
 <20191107014420.GD15212@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_F6EB440A-C078-4861-A5DE-5E6513FE9F53
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 6, 2019, at 6:44 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
>=20
> On Tue, Oct 29, 2019 at 01:41:38PM -0700, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>>=20
>> Add a statx attribute bit STATX_ATTR_VERITY which will be set if the
>> file has fs-verity enabled.  This is the statx() equivalent of
>> FS_VERITY_FL which is returned by FS_IOC_GETFLAGS.
>>=20
>> This is useful because it allows applications to check whether a file =
is
>> a verity file without opening it.  Opening a verity file can be
>> expensive because the fsverity_info is set up on open, which involves
>> parsing metadata and optionally verifying a cryptographic signature.
>>=20
>> This is analogous to how various other bits are exposed through both
>> FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.
>>=20
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> ---
>> include/linux/stat.h      | 3 ++-
>> include/uapi/linux/stat.h | 2 +-
>> 2 files changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/stat.h b/include/linux/stat.h
>> index 765573dc17d659..528c4baad09146 100644
>> --- a/include/linux/stat.h
>> +++ b/include/linux/stat.h
>> @@ -33,7 +33,8 @@ struct kstat {
>> 	 STATX_ATTR_IMMUTABLE |				\
>> 	 STATX_ATTR_APPEND |				\
>> 	 STATX_ATTR_NODUMP |				\
>> -	 STATX_ATTR_ENCRYPTED				\
>> +	 STATX_ATTR_ENCRYPTED |				\
>> +	 STATX_ATTR_VERITY				\
>> 	 )/* Attrs corresponding to FS_*_FL flags */
>> 	u64		ino;
>> 	dev_t		dev;
>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>> index 7b35e98d3c58b1..ad80a5c885d598 100644
>> --- a/include/uapi/linux/stat.h
>> +++ b/include/uapi/linux/stat.h
>> @@ -167,8 +167,8 @@ struct statx {
>> #define STATX_ATTR_APPEND		0x00000020 /* [I] File is =
append-only */
>> #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to =
be dumped */
>> #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires =
key to decrypt in fs */
>> -
>> #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount =
trigger */
>> +#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity =
protected file */
>=20
> Any reason why this wasn't 0x2000?

A few lines earlier in this file it states:

 * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
 * semantically.  Where possible, the numerical value is picked to
 * correspond also.

Cheers, Andreas






--Apple-Mail=_F6EB440A-C078-4861-A5DE-5E6513FE9F53
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3DfJ0ACgkQcqXauRfM
H+C67w/+PzbCLZMTkU9avwCySPMGr9WuwCpEcfNUagrH5o9t3EThVRYKlznqnD0M
SWRQeFvDugcj1Ojr35RmukzOmPdgcw5G5AQp2wSrC6LJrfr/ltMXL39zD29lMHEB
gCiYe6iGKq9UafGTAByH0ArPegVIZsEbsrPIiCzCkLGmRTRyAh3/bVyucsnX1lli
RwTBDfU8ABJ1hY7weKi/NhXYRo18xre0U3gLHVQZRGlgESUpPHDGCGlQyfaXBzl0
aodswi6xnEA+WbRH7QjSLQ+k+UEvWaH2G5H6dUFVaG0eUWPTryPwJnL3Ljk4PgXx
5YYGmJ72DkxVNnzB65CLl8li1W7fsJdSQwOGsQ1/MZTw0H3mZpy6L2CwJxhhtluI
4u0ZF4ZOiUgXpPqdv/DAUjeIMtE4DFHaQe/UHns04oIasp/0K1prqiXi+/zgkoCu
0raYL1GseaT2ATMKB3qAFrQ0tC1qEbAKC3pdm1lpTh9n6oTQufaWRgrP8B1S1TAk
cKr+4VXtxJ/lwFCfqUXKRKCO/OWIKRsP1P13VhEr7ClDBE1mkyowwBvt7Misylpl
8oLHkdYu+qF+/5uQE9bADaIRHG+kuqDMga9905IgcNg/TRYOVQeMCcBPTQsVH1JP
7VZ+j1tEe4TcWctvhT+usADtkrjjF5sAJXq8nkyCriS6RbFBmfw=
=71BE
-----END PGP SIGNATURE-----

--Apple-Mail=_F6EB440A-C078-4861-A5DE-5E6513FE9F53--
