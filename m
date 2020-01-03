Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B812FCA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgACSgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 13:36:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50492 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgACSgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:36:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so9180370wmb.0;
        Fri, 03 Jan 2020 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vzL1C03qSTR7rYJpjU/gJEkrmFSHRlUddp5dmp3p9no=;
        b=fFlS5xGO61FvkvkImG2fHXPNTyMdKsfG1OY7Gk+kVJehzZ4kHXWeax1Ktt7QA+EzWN
         oGxzRaS+5/eI0kMtIQNWSnjfYbuIBS+kwZyIRnebDnlRfIgtpchzdpyhZVac2zLSlLAV
         LcTcwyCo76fPpiwPqeR0m8lY/t+3zNQ6Vr1DUCUGHauqlrRxsu8l32rQhOdNsyBnHg8/
         e6HtLrOndJhr9TAFIkr2Qf0jX+XTLBBlARq8jTOviXpqhA1jEFtuDnhWc5NgqFS/9oDi
         LzNFjo16jbTBE0GAod/ffMfr9upyla5QVzOHNApP1MQIiF4kmcO56h306faC2E73VOgQ
         DSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vzL1C03qSTR7rYJpjU/gJEkrmFSHRlUddp5dmp3p9no=;
        b=a78lbmElfr+lBF9X9yUKNIA6DptLnIE14IDBxHnLCORYvlqOiI6j11ZIi7rNusdqr6
         9/rzbjAFcejvj2nuDz+5oMCvUmABKirGyxqshcIGD7NjmDyxSqaHPSpTKGybI1KQZnXd
         +mk4l/AfnkZ6c++42OCtV2XRVRrtnZsC5Ie/RnZoYGFFkMuKf1a12fQyMPK9F2wQEnKc
         wd1WoVNa9ptbAgspBP7JAE5ImKcVo+3okRRX94czEOEOW0xvMH8NYCxukETPMMewLO6L
         ui70i4YxkYSVPihWxODSeS5GJwW8PEfWRMXTTF5VMkevpYuD9ssg4etcN6Mo9uH0KgUv
         77eg==
X-Gm-Message-State: APjAAAXgWJG6iy4GwJzhgPlaXJnA+TDkahwpaj/b5o5Fxa/UG0008wVA
        wpdl7CfZJjCvFIJxp0VyRMs=
X-Google-Smtp-Source: APXvYqw7z2EkVk9cvGIZNnWuRDvoCTGq09o1bnaW7iCSpBoqGy1oCMfe9hjgi945cDo7Fwyu+MisfA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr21893631wmb.137.1578076566167;
        Fri, 03 Jan 2020 10:36:06 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x14sm12956562wmj.42.2020.01.03.10.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:36:05 -0800 (PST)
Date:   Fri, 3 Jan 2020 19:36:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
Message-ID: <20200103183604.xzfvnu2qivqnqkkx@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
 <20200102082036.29643-10-namjae.jeon@samsung.com>
 <20200102091902.tk374bxohvj33prz@pali>
 <CAKYAXd_9XOWtcLYk-+gg636rFCYjLgHzrP5orR3XjXGMpTKWLA@mail.gmail.com>
 <20200102114034.bjezqs45xecz4atd@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="63ohlbp4gwxokjqp"
Content-Disposition: inline
In-Reply-To: <20200102114034.bjezqs45xecz4atd@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--63ohlbp4gwxokjqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 January 2020 12:40:34 Pali Roh=C3=A1r wrote:
> On Thursday 02 January 2020 20:30:03 Namjae Jeon wrote:
> > 2020-01-02 18:19 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> > > On Thursday 02 January 2020 16:20:32 Namjae Jeon wrote:
> > >> This adds the implementation of misc operations for exfat.
> > >>
> > >> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> > >> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > >> ---
> > >>  fs/exfat/misc.c | 253 +++++++++++++++++++++++++++++++++++++++++++++=
+++
> > >>  1 file changed, 253 insertions(+)
> > >>  create mode 100644 fs/exfat/misc.c
> > >>
> > >> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> > >> new file mode 100644
> > >> index 000000000000..7f533bcb3b3f
> > >> --- /dev/null
> > >> +++ b/fs/exfat/misc.c
> > >
> > > ...
> > >
> > >> +/* <linux/time.h> externs sys_tz
> > >> + * extern struct timezone sys_tz;
> > >> + */
> > >> +#define UNIX_SECS_1980    315532800L
> > >> +
> > >> +#if BITS_PER_LONG =3D=3D 64
> > >> +#define UNIX_SECS_2108    4354819200L
> > >> +#endif
> > >
> > > ...
> > >
> > >> +#define TIMEZONE_CUR_OFFSET()	((sys_tz.tz_minuteswest / (-15)) & 0x=
7F)
> > >> +/* Convert linear UNIX date to a FAT time/date pair. */
> > >> +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec=
64
> > >> *ts,
> > >> +		struct exfat_date_time *tp)
> > >> +{
> > >> +	time_t second =3D ts->tv_sec;
> > >> +	time_t day, month, year;
> > >> +	time_t ld; /* leap day */
> > >
> > > Question for other maintainers: Has kernel code already time_t defined
> > > as 64bit? Or it is still just 32bit and 32bit systems and some time64=
_t
> > > needs to be used? I remember that there was discussion about these
> > > problems, but do not know if it was changed/fixed or not... Just a
> > > pointer for possible Y2038 problem. As "ts" is of type timespec64, but
> > > "second" of type time_t.
> > My bad, I will change it with time64_t.
>=20
> Now I have looked into sources and time_t is just typedef from
> __kernel_old_time_t type. So it looks like that time64_t is the type
> which should be used in new code.
>=20
> But somebody else should confirm this information.
>=20
> > >
> > >> +
> > >> +	/* Treats as local time with proper time */
> > >> +	second -=3D sys_tz.tz_minuteswest * SECS_PER_MIN;
> > >> +	tp->timezone.valid =3D 1;
> > >> +	tp->timezone.off =3D TIMEZONE_CUR_OFFSET();
> > >> +
> > >> +	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
> > >> +	if (second < UNIX_SECS_1980) {
> > >> +		tp->second  =3D 0;
> > >> +		tp->minute  =3D 0;
> > >> +		tp->hour =3D 0;
> > >> +		tp->day  =3D 1;
> > >> +		tp->month  =3D 1;
> > >> +		tp->year =3D 0;
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	if (second >=3D UNIX_SECS_2108) {
> > >
> > > Hello, this code cause compile errors on 32bit systems as UNIX_SECS_2=
108
> > > macro is not defined when BITS_PER_LONG =3D=3D 32.
> > >
> > > Value 4354819200 really cannot fit into 32bit signed integer, so you
> > > should use 64bit signed integer. I would suggest to define this macro
> > > value via LL not just L suffix (and it would work on both 32 and 64bi=
t)
> > Okay.
> > >
> > >   #define UNIX_SECS_2108    4354819200LL
> > >
> > >> +		tp->second  =3D 59;
> > >> +		tp->minute  =3D 59;
> > >> +		tp->hour =3D 23;
> > >> +		tp->day  =3D 31;
> > >> +		tp->month  =3D 12;
> > >> +		tp->year =3D 127;
> > >> +		return;
> > >> +	}
> > Okay, I will check it.
> > Thanks for your review!

Also I think that you should apply this Arnd's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D44f6b40c225eb8e82eba8fd96d8f3fb843bc5a09

And maybe it is a good idea to look at applied staging patches:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/driv=
ers/staging/exfat

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--63ohlbp4gwxokjqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXg+JkgAKCRCL8Mk9A+RD
UoXhAJ44sgetNSzA0PmrQ5zCQYF4kic2tgCeMUINsv0Qdf4DuBROUPpVgpCE+JQ=
=hZkV
-----END PGP SIGNATURE-----

--63ohlbp4gwxokjqp--
