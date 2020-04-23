Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276D81B6A06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 01:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgDWXjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 19:39:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50182 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgDWXjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:39:04 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200423233901epoutp01d035518abb9c67697018e436eac6dd7a~IlzlPG3yd0307703077epoutp01c
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 23:39:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200423233901epoutp01d035518abb9c67697018e436eac6dd7a~IlzlPG3yd0307703077epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587685141;
        bh=DwFvbvklwud1knopur7E6snit/XRuGA/GMpWgX6E89E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OoxeQq3gFSzwo8TVs0+ZCWCGxS0PADf0z9Cni/2MR9QQM4e1gMgoOj7oIh+8R3XZM
         nSWISfRQt0vP1t5U9eaaIA49jYZ+SpYp+Yk8fc73DQHKJTUbZMfZvvNXRkNKMQe+Rm
         xWWHmBrHYBxKiXHce0BATEFrjZmn6RmtGRl1UVuA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200423233900epcas1p1f26cbb4c236494d26d2ca9180b54a607~IlzlCcCYZ1071310713epcas1p1w;
        Thu, 23 Apr 2020 23:39:00 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 497YfW5xvFzMqYkb; Thu, 23 Apr
        2020 23:38:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.13.04544.31722AE5; Fri, 24 Apr 2020 08:38:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200423233859epcas1p4ee898a7cdc519b567618d09b44a17aab~IlzjV-68Q0801008010epcas1p4i;
        Thu, 23 Apr 2020 23:38:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200423233859epsmtrp274a2f4452abab82533ff1f153fa2c5ba~IlzjVUiwe0162601626epsmtrp2D;
        Thu, 23 Apr 2020 23:38:59 +0000 (GMT)
X-AuditID: b6c32a36-7ffff700000011c0-7a-5ea22713f1c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.FC.25866.21722AE5; Fri, 24 Apr 2020 08:38:58 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200423233858epsmtip1a795924df0995fceec68884604a4c7a4~IlzjMav-73200732007epsmtip1E;
        Thu, 23 Apr 2020 23:38:58 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Goldwyn Rodrigues'" <rgoldwyn@suse.de>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Sedat Dilek'" <sedat.dilek@gmail.com>
In-Reply-To: <20200423144411.hmby6ux2utdrqsls@fiona>
Subject: RE: [ANNOUNCE] exfatprogs-1.0.2 version released
Date:   Fri, 24 Apr 2020 08:38:58 +0900
Message-ID: <000101d619c8$5c6e3b90$154ab2b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK8+4Vt3Hn3JBh+0GBduZqobryGZwI03Iw/AuonTqmmkKCJkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTURzAO7t3D6PFbVqd7OG6IKX52FzTWzmVihBSEfpgBG1d9LKZe7G7
        2fODWakb9lCY1baiTTSTdEOt1FJJ6SGVH0p8QFla0dPKzEYo1d2u0r79zv/8/o/zECCiGl6k
        oFBvpkx6UovzFqO3+mIS4sM3eJSSmgEJMfTqG5+429WPEs87XTzi/GQzhzg9GEs02x+hGbzM
        DsdLfmZb7Tgns/XxsczplnW56D5tqoYiCyiTmNLnGwoK9WoFvnuPaodKniyRxku3ECm4WE/q
        KAW+Mys3flehlmmNi4tJrYUJ5ZI0jSempZoMFjMl1hhoswKnjAVao1RiTKBJHW3RqxPyDbqt
        UokkSc6YB7Sa6uobHONb7HCp/zu/BDwW2kCYAGKb4dC4AwRYhLUDePJatg0sZvgHgENPu3ns
        YhrAulk/ZyHDM9aEshmdALZNpbDSRwC9PSW8wAYPi4d/5nqCHIHFwfJWOxKQEKwfwKevJriB
        jTCm0szr2mClcGwLdLqe8AOMYtHQ6RxBAixk4j/u2/ksL4P9l94GfQSLgrcnXQg7kRj+flfP
        ZZtth/e6GjmsEwGd1rJ554wAut7n2YCA4Z3Q2pDHhsPhp4dtfJYj4fTXLh6rHINTPfOZFQB+
        8CtYlsFRr48bUBAsBno7E9nwetgxexmwTZfCrzOVXLaKEFaUiVglGp591jd/g6uhrfw7/zzA
        HSHHcoQcyxEyvuN/s6sAbQQrKCOtU1O01JgU+tItIPgnY5PbgWcgqxdgAoAvEY6Y3EoRlyym
        j+h6ARQgeITQN35FKRIWkEeOUiaDymTRUnQvkDO3XoVELs83MD9cb1ZJ5UkymYzYnJySLJfh
        K4X2Ya1ShKlJM1VEUUbKtJDHEYRFloDSzznlfLLJHffCssrfePOL4oHKt7R6baW5OPdCva4v
        fWDi+FydXVcvb5g9tWe46ZASW6O7M6bOIRpqekc+7Lc6N715V0h2l/o4c9eJc9lzrguLNra7
        NZMXI9IHu4q8GVF7/Z3lyl8e7sT01M/RN5+vu7edOCj7O8Ot9afVCausOEprSGksYqLJf5n9
        vnSpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK6Q+qI4gycNVhbX7r9nt9iz9ySL
        xeVdc9gsJrxdx2TRekXLYt3UEywObB47Z91l99iy+CGTx+bT1R6fN8kFsERx2aSk5mSWpRbp
        2yVwZUyatIap4IlARdP3D+wNjKd5uxg5OSQETCQW3VvL0sXIxSEksINRYvfWblaIhLTEsRNn
        mLsYOYBsYYnDh4shap4zSqz8toURpIZNQFfi35/9bCC2iICORPvmqcwgRcwCpxklet6/ZAdJ
        CAlsZpQ4elYWxOYE2vb1wWIWEFtYwFJi9pwzYDUsAqoSs2ffYAaxeYHin45OZYewBSVOznzC
        AnIEs4CeRNtGsL3MAvIS29/OYYa4U0Hi59NlrBA3OEkc3LuKCaJGRGJ2ZxvzBEbhWUgmzUKY
        NAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOGS2tHYx7Vn3QO8TI
        xMF4iFGCg1lJhHfDw3lxQrwpiZVVqUX58UWlOanFhxilOViUxHm/zloYJySQnliSmp2aWpBa
        BJNl4uCUamAy/1u7tLSZ99jduRqam59KTyw90nev5bY01/+H8/6VHkl5f3b/7tX7vy/nOPpv
        Wjp7aFKGoOa7PQK3ZBguSE+r3cu0zfPbr92qKU8OWl68HMkV0namflGOMjvLEy0eS/O8q82C
        Cn+mld3KyCws9Hd4sVnSaX/ypq4lzackp9jv7GrVsWF2S2Cs2S8u8flG3Pav7EePSvJMZOWT
        25j+KdCgM77Ko7pCt0HLJe4Ir2HkImaf1jXd/R+D3/Qf2hlU47v6W1N5nnh1U6rcp7PvTDkX
        hFecsdc3+mb0iXVNQPiGmduZfO+LV05jf7qh3ciuVMZ7S/oB6adv7qsXfvC5qZrrt+fmM4/C
        B877teZ3syixFGckGmoxFxUnAgBYlH5BCAMAAA==
X-CMS-MailID: 20200423233859epcas1p4ee898a7cdc519b567618d09b44a17aab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413
References: <CGME20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413@epcas1p1.samsung.com>
        <004701d6194c$0d238990$276a9cb0$@samsung.com>
        <20200423144411.hmby6ux2utdrqsls@fiona>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi Namjae,
Hi Goldwyn,
> 
> On 17:49 23/04, Namjae Jeon wrote:
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
> I agree with Eric. We can add "Conflicts" flag to make sure there are conflicting capabilities in
> packages.
Okay.
> 
> >
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
> > https://protect2.fireeye.com/url?k=c2ec59b9-9f266c0e-c2edd2f6-0cc47a30
> > 03e8-e469846ab6add112&q=1&u=https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fex
> > fatprogs
> >
> > The tarballs can be found at:
> >
> > https://protect2.fireeye.com/url?k=88473660-d58d03d7-8846bd2f-0cc47a30
> > 03e8-7bb3906eafbb32bc&q=1&u=https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fex
> > fatprogs%2Freleases%2Ftag%2F1.0.2
> >
> 
> Can we follow the standard of source tarballs be <projectname>-<version>.tar.gz? In this case, exfat-
> 1.0.2.tar.gz instead of 1.0.2.tar.gz?
Ah, When I tried to download it through this link, source tarballs was exfatprogs-1.0.2.tar.gz...
Am I missing something ?
> 
> --
> Goldwyn

