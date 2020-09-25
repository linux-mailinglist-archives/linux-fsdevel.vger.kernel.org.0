Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB40278E77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgIYQaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 12:30:23 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:56608 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIYQaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:30:22 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 32B0781E18;
        Fri, 25 Sep 2020 19:30:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1601051420;
        bh=ku5HcfPTrYYoHR4U6YrcFO4/qyieMTdjlj9S1ShhrAA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=p0auxOBZUhx5pDvQLRLUT0ZmH3owNNRFUGVliazh1czvFEjX+eik4SzesuD47wAeJ
         3wJ+SS5yUt/gL8/dkWNAphj9T0rNQPa53144F15Ku00Mpykl4xYHAR2f8acwaa0pFl
         YPCxG8Pv1RVSCjwnRKrlj0UalcUpsXF/jd4IXZ9g=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 25 Sep 2020 19:30:19 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 25 Sep 2020 19:30:19 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: RE: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Topic: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Index: AQHWiEVMa6NNOPBUmU2lQbRIYYQ96qly8s2AgAaqUoA=
Date:   Fri, 25 Sep 2020 16:30:19 +0000
Message-ID: <7facb550be6449c2b35f467ab1716224@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-9-almaz.alexandrovich@paragon-software.com>
 <20200921132631.q6jfmbhqf6j6ay5t@pali>
In-Reply-To: <20200921132631.q6jfmbhqf6j6ay5t@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pali Roh=E1r <pali@kernel.org>
Sent: Monday, September 21, 2020 4:27 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; dsterba@suse.cz; aaptel@suse.com;
> willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmsto=
ne.com; nborisov@suse.com
> Subject: Re: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
>=20
> On Friday 11 September 2020 17:10:16 Konstantin Komarov wrote:
> > +Mount Options
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The list below describes mount options supported by NTFS3 driver in ad=
dition to
> > +generic ones.
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +nls=3Dname		This option informs the driver how to interpret path
> > +			strings and translate them to Unicode and back. If
> > +			this option is not set, the default codepage will be
> > +			used (CONFIG_NLS_DEFAULT).
> > +			Examples:
> > +				'nls=3Dutf8'
> > +
> > +nls_alt=3Dname		This option extends "nls". It will be used to translat=
e
> > +			path string to Unicode if primary nls failed.
> > +			Examples:
> > +				'nls_alt=3Dcp1251'
>=20
> Hello! I'm looking at other filesystem drivers and no other with UNICODE
> semantic (vfat, udf, isofs) has something like nls_alt option.
>=20
> So do we really need it? And if yes, it should be added to all other
> UNICODE filesystem drivers for consistency.
>=20
> But I'm very sceptical if such thing is really needed. nls=3D option just
> said how to convert UNICODE code points for userpace. This option is
> passed by userspace (when mounting disk), so userspace already know what
> it wanted. And it should really use this encoding for filenames (e.g.
> utf8 or cp1251) which already told to kernel.

Hi Pali! Thanks for the feedback. We do not consider the nls_alt option as =
the must have
one. But it is very nice "QOL-type" mount option, which may help some amoun=
t of
dual-booters/Windows users to avoid tricky fails with files originated on n=
on-English
Windows systems. One of the cases where this one may be useful is the case =
of zipping
files with non-English names (e.g. Polish etc) under Windows and then unzip=
ping the archive
under Linux. In this case unzip will likely to fail on those files, as arch=
ive stores filenames not
in utf. Windows have that "Language for non-Unicode programs" setting, whic=
h controls the
encoding used for the described (and similar) cases.
Overall, it's kinda niche mount option, but we suppose it's legit for Windo=
ws-originated filesystems.
What do you think on this, Pali?

Best regards!
