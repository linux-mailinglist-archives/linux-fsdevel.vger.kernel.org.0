Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8615212E2EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgABGGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 01:06:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21637 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgABGGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:06:21 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200102060618epoutp032f8b03737b721aa8195102730fc2e9c1~l-Mejj7Df0420504205epoutp03W
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 06:06:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200102060618epoutp032f8b03737b721aa8195102730fc2e9c1~l-Mejj7Df0420504205epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577945178;
        bh=iiwDFsSq7I+vznqNBy0yhlQ/JOVo+ktu5saryrjetFM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RxAmITBNBaFoNsKnC8mw9TtBYDnYPc2OqwZuVbEQapl5qaIYEYEWL6O/oSO2nr9DQ
         aIgmCZal48jgDhB83aNr4DGtSULwj9NlAD47cs5t36ZUre5u+LiF49yoKVk926LaQf
         VKxI0Ut/HilN6fLI5hRq44n87lpcMRxqX1r6JVl0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200102060618epcas1p38591a94fdad40315ec7bf587f9baae06~l-MeRJECH2982729827epcas1p3t;
        Thu,  2 Jan 2020 06:06:18 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47pHbY48VNzMqYkj; Thu,  2 Jan
        2020 06:06:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.EC.48498.9588D0E5; Thu,  2 Jan 2020 15:06:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200102060617epcas1p19e7808cf1f4008f9b906f902ec969b20~l-MdDMptW1921619216epcas1p1I;
        Thu,  2 Jan 2020 06:06:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200102060617epsmtrp1bf7c264a94bcd14151b92c7a9ad8e29b~l-MdCe0fY1453814538epsmtrp1A;
        Thu,  2 Jan 2020 06:06:17 +0000 (GMT)
X-AuditID: b6c32a36-ea9ad9c00001bd72-87-5e0d88599598
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.1F.06569.9588D0E5; Thu,  2 Jan 2020 15:06:17 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200102060617epsmtip15751be7503d40289c7d56b096ffd3b3a~l-Mc7ki4m2577025770epsmtip1E;
        Thu,  2 Jan 2020 06:06:17 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?utf-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>
In-Reply-To: <20191229134025.qb3mmqatsn5c4gao@pali>
Subject: RE: [PATCH v8 02/13] exfat: add super block operations
Date:   Thu, 2 Jan 2020 15:06:16 +0900
Message-ID: <000701d5c132$bed73c80$3c85b580$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHsN8nXp7WTsPLA/dnVZpcSktwQNAEpoQLVAH0AW2oCon8f8qeHqjkw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3d3urtbqdjM9GOS61A+F5eacXstlUdhAqZn0oyDXTW9utS92
        t74Msi8zM0vyT0vFPiHLrLTUlRgriVX0sSgzEFFMnH0XZrGott1F/nvOeZ9znnOe9xAY1YIn
        Eiark3NYWTONx4pv3UtOVayvlBUp28bmMQfOteLMpcu9IqZv4A3G3On2iZkXnnqcqX0UFDHt
        v+9LGP+nz+JlhK7LPSDV9TRckepu95fjupr2ZqT7dmOeztvxHtfjG8zZRo4t4RxyzlpsKzFZ
        S7V0XqFhhUGToVQpVFlMJi23shZOS6/M1ytyTebQQLR8O2t2hVJ6lufp1KXZDpvLycmNNt6p
        pTl7idmuUtoX8ayFd1lLFxXbLItVSmWaJsTcZDa++v4T2evxnUF/JV6O6iRViCCATIeTY+lV
        KJagyE4EjZcbcCH4iiA4ekEiBN8RPOy7i1WhmEjFed87SRhTZDeCb4NRUgDB7cMtePgBJxXw
        +1dPBMeRDHT2TkbaYuRdBENXr0eqY0g17GsKREizyRy49qxNFJ5JTC6AN8Orw2kZmQW1I/US
        Ac8C36kRcRhjZBJ0fKiPDiSHn28vSgStXPC9rEMCJw5OH6nAwrpA/sHB+yEoEQpWQnXjMVzA
        s2H8QbtUwIkQOF4hFXwpgy890f6VCMYmtQJWQ3/rtYh1GJkMrZ5UIT0fuoINUdkZ8HGiOuqu
        DCorKIGyEGr890QCngtVhz9LTyDaPWUx95TF3FMWcP8Xa0LiZhTP2XlLKcer7GlTv/oGipxq
        SkYnOvsk34tIAtHTZa8bpxdREnY7v8viRUBgdJxsR4GsiJKVsLt2cw6bweEyc7wXaUK212KJ
        c4ptocO3Og0qTZparWbSMzIzNGo6QUb8eL6RIktZJ7eN4+yc41+diIhJLEfSJ1kdOTnZ2rlJ
        E6/ib+6/qT8Yd2ZQaRvU9TzqJbR98YpDHzd39y9/MWyiHL6nrrWmzoMtR/ito4bnE0dnFRiS
        mpdsG55ZkLBq1aGF4+MeT12h/umcZWdMZW3KPdSke0VOvnFaXlcuNbRlXewmT8D/oOwXDf7H
        AXyDL2XN2ry952kxb2RVKZiDZ/8CSiiTV8ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG5kB2+cwdRebovmxevZLFauPspk
        cf3uLWaLPXtPslhc3jWHzWLi6d9MFlv+HWG1uPT+A4sDh8fOWXfZPfbPXcPusftmA5tH35ZV
        jB6fN8l5HNr+hi2ALYrLJiU1J7MstUjfLoEr49q3n4wFc9gqfl/qYGtgnMLaxcjJISFgIrHk
        5Gsgm4tDSGA3o8ThrkMsEAlpiWMnzjB3MXIA2cIShw8XQ9Q8Z5SYMauTHaSGTUBX4t+f/Wwg
        toiAhcSOo9/ZQIqYBU4wSpzpvwW2QUjgGaPE6mXeIDangLFE44KXYA3CAvYSGy5sZgJZwCKg
        InHrkR9ImFfAUmLikzmsELagxMmZT8DuYRbQlnh68ymULS+x/e0cZog7FSR+Pl3GCnGDm8TJ
        q1MYIWpEJGZ3tjFPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGMERpqW1g/HEifhDjAIcjEo8vDfm8cQJsSaWFVfmHmKU4GBWEuEtD+SNE+JNSays
        Si3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cAoObllS5hhaOuGQ2IH
        Ly34s9SG33u92YnZe5L3JBpo/6urufHZ+IXl5UP+v3IbKzfoPzXbeOv8WeZuaTtWEXtbi67e
        tFs2Gy9LrL4zSTuHPfffCvsKrsiQFxsK+du++G3jKZaZWKAWWGR/UGb75ogv4Zn/5scdObKi
        ue3kRLlzV1masx68PumtxFKckWioxVxUnAgA6rMR+qwCAAA=
X-CMS-MailID: 20200102060617epcas1p19e7808cf1f4008f9b906f902ec969b20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
        <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
        <20191220062419.23516-3-namjae.jeon@samsung.com>
        <20191229134025.qb3mmqatsn5c4gao@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +static const struct fs_parameter_spec exfat_param_specs[] = {
> > +	fsparam_u32("uid",			Opt_uid),
> > +	fsparam_u32("gid",			Opt_gid),
> > +	fsparam_u32oct("umask",			Opt_umask),
> > +	fsparam_u32oct("dmask",			Opt_dmask),
> > +	fsparam_u32oct("fmask",			Opt_fmask),
> > +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
> > +	fsparam_string("iocharset",		Opt_charset),
> > +	fsparam_flag("utf8",			Opt_utf8),
> 
> Hello! What is the purpose of having extra special "utf8" mount option?
> Is not one "iocharset=utf8" option enough?
utf8 nls_table supports utf8<->utf32 conversion and does not support
surrogate character conversion. The utf8 option can support the surrogate
character conversion of utf16 using utf16s_to_utf8s/utf8s_to_utf16s of
the nls base.

Thanks!

