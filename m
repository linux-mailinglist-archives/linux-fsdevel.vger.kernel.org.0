Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC15F1B69EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgDWXfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 19:35:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48845 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDWXfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:35:14 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200423233510epoutp011334f79c590413c66b77040181001b8b~IlwOcX3F00071600716epoutp01C
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 23:35:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200423233510epoutp011334f79c590413c66b77040181001b8b~IlwOcX3F00071600716epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587684910;
        bh=MJ2059NgkqHV9qBMiMC4hQhr/liQz6xXIM6JdR1yACw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=K3U8gVqDlbitQX3Zo2Swyl/rjwY4LfUt0NuulRP31ADtCuC6h0Bd1cp3DtBRyc5ZE
         O/wksfa7banNMPvhcL2H4lnrFb5JsWtSs169XapN0vSq/9ooS/8WuuUZX6TOyrcz2O
         Tp6SHVUbxrytRXjOPHqpRJ8mkDcdcsZ+MlHJC40Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200423233510epcas1p17ef8d42763374ff42553fe458a117085~IlwOOMBF01577815778epcas1p1S;
        Thu, 23 Apr 2020 23:35:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 497YZ51QjczMqYlp; Thu, 23 Apr
        2020 23:35:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.4A.04648.D2622AE5; Fri, 24 Apr 2020 08:35:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200423233508epcas1p41cd03b07685093a91500f9dc26ab77d6~IlwM1iB0e2156021560epcas1p4p;
        Thu, 23 Apr 2020 23:35:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200423233508epsmtrp13c514d0dbbb0c8478f044ee9fdf949b8~IlwM0vIjj3182231822epsmtrp1p;
        Thu, 23 Apr 2020 23:35:08 +0000 (GMT)
X-AuditID: b6c32a37-1dbff70000001228-d3-5ea2262dedc6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.BC.25866.C2622AE5; Fri, 24 Apr 2020 08:35:08 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200423233508epsmtip1d6312a9fcb88657972488700b05926da~IlwMrh7Oe2674026740epsmtip1h;
        Thu, 23 Apr 2020 23:35:08 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Eric Sandeen'" <sandeen@sandeen.net>
Cc:     "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Sedat Dilek'" <sedat.dilek@gmail.com>,
        "'Goldwyn Rodrigues'" <rgoldwyn@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3f535421-d21b-0647-6e46-47b545ff3dfb@sandeen.net>
Subject: RE: [ANNOUNCE] exfatprogs-1.0.2 version released
Date:   Fri, 24 Apr 2020 08:35:08 +0900
Message-ID: <000001d619c7$d32434c0$796c9e40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK8+4Vt3Hn3JBh+0GBduZqobryGZwI03Iw/Ag8fhYmml3RgMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeba73au0uC2zg1GuGxUupptzOlN7MatBfRD6EpbazV2ndLc7
        dqdlRfhBrUzKChOnlb0JWU5TsSmJsUUpiUXlS5D4glEGZk3MxKg27yK//Tjn/3/+5zzPQ4jl
        16RhRK7FztgsNEtJg7E2T4RKpdp0O0NddzNIPzAyjeufdPZg+rcdNVJ9+ZRTpC9+p9Q7K7qx
        HVJDu2MYN7TeGRMZWl6eMsw0r0vF0tjEHIY2MjYFY8nijLkWUxK170DmrkxdrFqj0sTr4yiF
        hTYzSVTK/lTVnlzWF00p8mk2z1dKpXmeitqWaOPy7Iwih+PtSRRjNbJWjdoaydNmPs9iiszi
        zFs1anW0zqc8wubUe7OtrtATPx49RYXourwUBRFAxoCzsA8rRcGEnHQhaGh34v6GnPQiqKo0
        Co0ZBIUTf6T/HHMXSqRCowPBh+GFgH0SweRoLfKrpKQKfv/qWnSEkEqYvvhn0SEmexD0Tl/y
        OQgiiNwONxd4v2YlGQ/VNb2L0Ri5Edr63RI/y3z1Xu+gSOAV0FM1gflZTIbD46kasTCRAuY/
        1kmErGTwNC/ggiYEqs+XBDTnCah7iAROgdezs7jAK+HLi9YAh8HkpRLcPxqQp+B7V8B6DsHn
        uSSBtfC+sUnil4jJCGjsiBLK66F94ToSUpfD19kyiXCKDM6VBC56I1x84xEJvAZKz37DyxHl
        WLKXY8lejiXzO/6H1SKsHoUyVt5sYniNVbv0pZvR4p9UxrlQU99+NyIJRC2TDdluZcgldD5f
        YHYjIMRUiKxp7EaGXGakC04yNi7TlscyvBvpfNd+WRy2Kovz/XCLPVOji9ZqtfqY2LhYnZZa
        LasYZDPkpIm2M8cYxsrY/vlERFBYIcqPshqW1zb0s5tNB/GK5EOH7x8vbkgLrbwicXU+Sz/j
        eD2q1XL1tQNQl9DQ4drrLYP56hj3mVe7iz4Rm3bId3JRd1PK7s0T2UUV6dhVr3fLFLdtQ8Jn
        +9B4QcttZT/u7JoZ+eQOVyZ4yh9UjjtOb30zODrRffS5qFyx9udmzwYK43NojVJs4+m/JPrK
        jKkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK6O2qI4g01/VC2u3X/PbrFn70kW
        i8u75rBZTHi7jsmi9YqWxbqpJ1gc2Dx2zrrL7rFl8UMmj82nqz0+b5ILYInisklJzcksSy3S
        t0vgylj1Ka1gh1jFt40HGBsY5wp1MXJySAiYSHzvbmMDsYUEdjBK3JtSAxGXljh24gxzFyMH
        kC0scfhwcRcjF1DJc0aJJ9OWs4PUsAnoSvz7sx+sV0RAS+J93382kCJmgbOMEo/mPmKE6NjH
        KPF052NWkEmcAvYS838XgzQIC1hKzJ5zBmwQi4CqxLarh1hBbF6g+JlP15kgbEGJkzOfsIDY
        zALaEk9vPoWy5SW2v53DDHGogsTPp8tYIY5wkji86Tc7RI2IxOzONuYJjMKzkIyahWTULCSj
        ZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhmtLR2MO5Z9UHvECMTB+Mh
        RgkOZiUR3g0P58UJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/06a2GckEB6YklqdmpqQWoRTJaJ
        g1OqgWlKxrH7HWUz9zNIz1e7ES/Xr/JZ4WRMsdy2w5Z3/0RPf6lt8VS24vfP1wHPbxat65xn
        GlJz+57cJbeYazrZzumnrOMXL7/htMR2CS9vq+wJ+YiKvxpJpyJd94myVK/z2rv8wqemxRvj
        vOYK8CetStbsDU/K8Hh46wuDxjPFo/M41+/fPr+u+anQ7rt/dqbXOgVcCNhgWsxondihupX7
        wgzvuOPhb/vnfryz6vH5tw8msRS98szV6jsXUCpfnd/t5vbz/I6bjE8upb1vrXt56/Gyt3az
        j+Y8VFlWdco2PPTuur2FqmuYfvgJX1k3KfVnxZnjSr0vOEJWvq3+Zfw9fVV6xMylh2aeX2Rb
        uCEtvnC6EktxRqKhFnNRcSIA7cfjJggDAAA=
X-CMS-MailID: 20200423233508epcas1p41cd03b07685093a91500f9dc26ab77d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413
References: <CGME20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413@epcas1p1.samsung.com>
        <004701d6194c$0d238990$276a9cb0$@samsung.com>
        <3f535421-d21b-0647-6e46-47b545ff3dfb@sandeen.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 4/23/20 3:49 AM, Namjae Jeon wrote:
> > This is the second release of exfatprogs since the initial version(1.0.1).
> > We have received various feedbacks and patches since the previous
> > release and applied them in this release. Thanks for feedback and patches!
> >
> > According to Goldwyn's comments, We renamed the project name from
> > exfat-utils to exfatprogs. However, There is an opinion that just
> > renaming the name is not enough. Because the binary names(mkfs.exfat,
> > fsck.exfat) still are same with ones in current exfat-utils RPM package.
> >
> > If that's real problem, We are considering a long jump with 2.0.0 when
> > adding repair feature.
> >
> > Any feedback is welcome!:)
> 
> Just my $0.02 - I think you need to keep the binary names the same, this is a very common naming
> convention that other software may depend on.  At least xfstests certainly expects that the
> "exfat.$FOO" naming convention is there, and that "exfat" is used consistently across utilities,
> module names, statfs and blkid output etc.
Okay, I will keep them.
And he is saying that the version of mkfs/fsck.exfat in exfatprogs should be higher than
the version 1.3.1 of mkfs/fsck.exfat in current exfat-utils package to reduce the confusion of
old users. For this reason, it confuses me whether it makes sense to significantly increase the version.
So I'm thinking about raising the version to 2.0.0 when the big feature like repair comes in.
> 
> Personally I think it would be sufficient for distribution packages to set the equivalent of a
> "Conflicts: exfat-utils" in the exfatprogs package so that they cannot be installed simultaneously?
> The devil is in the details on packaging but there are usually packaging tricks if we need to replace
> or exclude one package with another.
Oh, there's a way.
Thanks for your opinion!
> 
> Thanks,
> -Eric
> 
> > The major changes in this release:
> >  * Rename project name to exfatprogs.
> >  * label.exfat: Add support for label.exfat to set/get exfat volume label.
> >  * Replace iconv library by standard C functions mbstowcs() and wcrtomb().
> >  * Fix the build warnings/errors and add warning options.
> >  * Fix several bugs(memory leak, wrong endian conversion, zero out
> > beyond end of file) and cleanup codes
> >  * Fix issues on big endian system and on 32bit system.
> >  * Add support for Android build system.
> >
> > The git tree is at:
> >
> > https://protect2.fireeye.com/url?k=f7b9f8ba-aa6aa104-f7b873f5-0cc47a31
> > ba82-14a9f1852cdf3dd6&q=1&u=https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fex
> > fatprogs
> >
> > The tarballs can be found at:
> >
> > https://protect2.fireeye.com/url?k=35b018cd-68634173-35b19382-0cc47a31
> > ba82-7c9ab2990d663462&q=1&u=https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fex
> > fatprogs%2Freleases%2Ftag%2F1.0.2
> >

