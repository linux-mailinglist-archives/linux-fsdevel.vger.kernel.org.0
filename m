Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B51315E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 05:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBJEv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 23:51:59 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:48297 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhBJEv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 23:51:57 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210210045114epoutp01d7b85dbb04b4ef8349e1b0373e1c6b8b~iSbjIaxfT0597905979epoutp01t
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 04:51:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210210045114epoutp01d7b85dbb04b4ef8349e1b0373e1c6b8b~iSbjIaxfT0597905979epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612932674;
        bh=U4U+OKEI0dPT4kObwDS6TL4tLYt5RSRlMAi/eiqq/+I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jCm3n7jgmMwRvIVzkTiKaAHjaPukhUwAwj8F3rY6uoydRwmrVNIYQUDVXFwsLCnmt
         Ew8T2bcESqE7K106gxLPKTumjGNwqZceFfoq6gZHocjDe7DHdZiAzU+v7Wu6tpsNa7
         yAKKdXPFHY8u89n9clGt67WsMl5I0kWex4y4DXto=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210210045114epcas1p2027713a12f80f7e218794467fdfdcee7~iSbiszO3j1477914779epcas1p2K;
        Wed, 10 Feb 2021 04:51:14 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Db6m10zmLz4x9QF; Wed, 10 Feb
        2021 04:51:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.AE.09582.04663206; Wed, 10 Feb 2021 13:51:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210210045112epcas1p38db8a88e0ff6fe25451d28a58f2ac843~iSbg0vIL01750817508epcas1p3C;
        Wed, 10 Feb 2021 04:51:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210210045112epsmtrp2c879420119b004be18d4cd4e14c1cb97~iSbgz9noV2290222902epsmtrp2d;
        Wed, 10 Feb 2021 04:51:12 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-0e-60236640d539
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.57.08745.F3663206; Wed, 10 Feb 2021 13:51:11 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210210045111epsmtip26f7f7a45a433016c44ff7bba026bfb83~iSbglPRNd2306723067epsmtip2r;
        Wed, 10 Feb 2021 04:51:11 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <sedat.dilek@gmail.com>
Cc:     "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Goldwyn Rodrigues'" <rgoldwyn@suse.com>,
        "'Nicolas Boos'" <nicolas.boos@wanadoo.fr>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Luca Stefani'" <luca.stefani.ge1@gmail.com>,
        "'Matthieu CASTET'" <castet.matthieu@free.fr>,
        "'Sven Hoexter'" <sven@stormbind.net>,
        "'Ethan Sommer'" <e5ten.arch@gmail.com>,
        "'Hyeongseok Kim'" <hyeongseok@gmail.com>
In-Reply-To: <CA+icZUUFFrEJccHDZPV9nzj7zav-RA53eWqgKkDyvwOxCaKKnQ@mail.gmail.com>
Subject: RE: [ANNOUNCE] exfatprogs-1.1.0 version released
Date:   Wed, 10 Feb 2021 13:51:11 +0900
Message-ID: <001401d6ff68$5acaf360$1060da20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMf4qZO1kx5n+CS2tQqKq6p8yETxQHqCfvYAkF/TQSnna4y8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmnq5DmnKCwe9P2hafb/ayW3Qeecpm
        ce3+e3aLvxM/MVns2XuSxeLyrjlsFv/WN7NbNBw7wmLR9ncXq0XrFS2LdVNPsFi83vCM1YHH
        o3/dZ1aPnbPusntsWfyQyWPij2lsHuu3XGXx+LxJzuPz3fWsAexROTYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVUgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMjasOs5ecI+3Ym3/c5YG
        xmncXYycHBICJhI/Ni5h7WLk4hAS2MEocWnXSWYI5xOjxMkbrYwQzmdGies9JxlhWvZs+QCV
        2MUosWjtWiYI5yWjxLLNfewgVWwCuhL//uxnA7FFBKQlFj19xQZSxCzwmlnizaFVYAlOgUCJ
        NQv/Am3n4BAWsJS4cskOJMwioCqx7/pXFhCbFyj8/fdmNghbUOLkzCdgcWYBeYntb+cwQ1yk
        IPHz6TJWiF1OEoe2/GWCqBGRmN3ZBvaPhMAZDomzjSugGlwkNh85zQ5hC0u8Or4FypaS+Pxu
        LxvIPRIC1RIf90OVdzBKvPhuC2EbS9xcvwHsZGYBTYn1u/QhwooSO3/PZYRYyyfx7msPK8QU
        XomONiGIElWJvkuHmSBsaYmu9g/sExiVZiF5bBaSx2YheWAWwrIFjCyrGMVSC4pz01OLDQuM
        kSN7EyM4EWuZ72Cc9vaD3iFGJg7GQ4wSHMxKIrzOM5UShHhTEiurUovy44tKc1KLDzGaAoN6
        IrOUaHI+MBfklcQbmhoZGxtbmJiZm5kaK4nzJhk8iBcSSE8sSc1OTS1ILYLpY+LglGpgWtm1
        7ufLO3F+6nJ7ZxyxKFw5t3n2VHu/cLENb5tcpDx9ewuZPsak8k1tmBN+Z2ZAgEJir+Ribdfu
        65f+fJdLMZYwmnI7frXGCdvk95vVtO2OsEuK3HjL+/XkYt+1vdcvnTzv/G/O4QKFbfXmCvcn
        BbY97Jd27dq9SODd6awVu7zXztadlSnG9Nv3e7e6mu2h1yZvoxs2RZcoZetOqXpir+UkGf7P
        9UhXtOr0oNcKMhOWt7+LCE9IZZzcIyb9ou/KI/3bmhe3qu5aItD1o0k/RztAZpP0XIHUq08t
        C5j4vkVptuzfa/vx/vfZPbpKXsF9Pi63nKbe/qfg/PyRqp5VW1aVr5Tjh9KvykbXNASUWIoz
        Eg21mIuKEwGpO8Y4TQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK59mnKCwZkHFhafb/ayW3Qeecpm
        ce3+e3aLvxM/MVns2XuSxeLyrjlsFv/WN7NbNBw7wmLR9ncXq0XrFS2LdVNPsFi83vCM1YHH
        o3/dZ1aPnbPusntsWfyQyWPij2lsHuu3XGXx+LxJzuPz3fWsAexRXDYpqTmZZalF+nYJXBkb
        Vh1nL7jHW7G2/zlLA+M07i5GTg4JAROJPVs+MHYxcnEICexglLh++z0jREJa4tiJM8xdjBxA
        trDE4cPFEDXPGSVaP7SygtSwCehK/Puznw3EFgGqX/T0FRtIEbPAZ2aJM3+7mSE6LjBKtH9r
        ZAKp4hQIlFiz8C8ryFRhAUuJK5fsQMIsAqoS+65/ZQGxeYHC339vZoOwBSVOznwCFmcW0Jbo
        fdjKCGHLS2x/O4cZ4lAFiZ9Pl7FCHOEkcWjLXyaIGhGJ2Z1tzBMYhWchGTULyahZSEbNQtKy
        gJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcExqae1g3LPqg94hRiYOxkOMEhzM
        SiK8zjOVEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        6lodIOO34+GFO7+fdFberLAS7OiMubE4zFTUe2Nljq3ZjI69VxcuvxoXtaJnob6tSb7LBeN4
        6fhPq21f/l17yb1r1tOqPpuwxjWy2qdYu/Z3LOxl3rJu+27+pDz1t/fWumomXu+Tnr6qrux/
        pezC9uik+PhQwRebfzqkm3f4y5fs/suhO33lGqcQa+fujkV3lmmpC8zz3bbh45KZa7aJtWjf
        bQpK/b33jkZUt/ydZ8ejzAxXKGvXzTJsfHNk1SzLR8bPF+2b8izJacJjtR8f/kzLctdIMziS
        ++/pAY4ph1XOLfy0zvr8qyM/Pt9N+Ry72DWw2/Ds3+n1WdNmZe//2ukmVlbs/TGtx9XzqRzj
        AiWW4oxEQy3mouJEAB23h4k4AwAA
X-CMS-MailID: 20210210045112epcas1p38db8a88e0ff6fe25451d28a58f2ac843
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2
References: <CGME20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2@epcas1p1.samsung.com>
        <000001d6ff3e$62f336d0$28d9a470$@samsung.com>
        <CA+icZUUFFrEJccHDZPV9nzj7zav-RA53eWqgKkDyvwOxCaKKnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed, Feb 10, 2021 at 12:50 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
> >
> > Hi folk,
> >
> > We have released exfatprogs 1.1.0 version. In this release, exfatlabel
> > has been added to print or re-write volume label and volume serial value.
> > Also, A new dump.exfat util has been added to display statistics from
> > a given device(Requested by Mike Fleetwood(GParted Developer)).
> >
> > Any feedback is welcome!:)
> >
> 
Hi Sedat,
> Congrats to the new release and thanks to all involved people.
Thanks!

> 
> Hope Sven will do a new release for Debian.
> ( Note that Debian/bullseye release  plans "Milestone 2" this Friday, February 12th (see [1] > "Key
> release dates" > "[2021-Feb-12] Soft Freeze"). Dunno which impact this might have on this. )
I hope he will do it, too!

Thanks Sedat:)
> 
> - Sedat -
> 
> [1] https://release.debian.org/
> 
> 
> > CHANGES :
> >  * fsck.exfat: Recover corrupted boot region.
> >
> > NEW FEATURES :
> >  * exfatlabel: Print or set volume label and serial.
> >  * dump.exfat: Show the on-disk metadata information and the statistics.
> >
> > BUG FIXES :
> >  * Set _FILE_OFFSET_BITS=64 for Android build.
> >
> > The git tree is at:
> >
> > https://protect2.fireeye.com/v1/url?k=f588edef-aa13d460-f58966a0-0cc47
> > a31307c-ebe7fdcb9cce33c0&q=1&e=88dc7065-283e-4803-b82d-ffcf0f9d681e&u=
> > https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fexfatprogs
> >
> > The tarballs can be found at:
> >
> > https://protect2.fireeye.com/v1/url?k=98eca6ac-c7779f23-98ed2de3-0cc47a31307c-
> c97058e3d3889dd3&q=1&e=88dc7065-283e-4803-b82d-
> ffcf0f9d681e&u=https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fexfatprogs%2Freleases%2Fdownload%2F1.1.0%2Fexfa
> tprogs-1.1.0.tar.gz
> >

