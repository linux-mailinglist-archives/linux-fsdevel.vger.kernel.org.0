Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFA1DDB41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 01:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgEUXoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 19:44:11 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50152 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgEUXoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 19:44:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200521234407epoutp01896ede918d96750b1825a4e1092e1ddd~RL8CFElE81586215862epoutp01p
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 23:44:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200521234407epoutp01896ede918d96750b1825a4e1092e1ddd~RL8CFElE81586215862epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590104647;
        bh=ILJFN1oGudVY7QRjmbt8KLypujQgp/qoU/ax4gctSC4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FmtIVfND9V9a8YdWyPXHbg13t9YGvDE6wyhJep4TagW2oSn9JKNaWYcLvHZTIcMYj
         aSBi8Bl1n5XrnbRmUu6oOqBa297to3tctbmvLMfeZkiJf/qmVTOjNg3RwMmw2MPMlA
         aYrwkRq54sL3O+pnUQwqkmrKE1rRd7Ce8LR8OqzA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200521234406epcas1p2ec48f6b32f22641dfea4618f6a82afb3~RL8BucOPZ1405114051epcas1p2v;
        Thu, 21 May 2020 23:44:06 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49SmRT6lzzzMqYkY; Thu, 21 May
        2020 23:44:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.C6.04658.44217CE5; Fri, 22 May 2020 08:44:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200521234404epcas1p2922b1787353e207b3c1286130beb99f2~RL7-ljrbo1405114051epcas1p2n;
        Thu, 21 May 2020 23:44:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200521234404epsmtrp252428900519adde242ac29ac189a93c7~RL7-kwht81805318053epsmtrp24;
        Thu, 21 May 2020 23:44:04 +0000 (GMT)
X-AuditID: b6c32a39-a81ff70000001232-36-5ec712444091
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.C8.18461.44217CE5; Fri, 22 May 2020 08:44:04 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200521234404epsmtip28131a28e9e20699df6079970bbf0357a~RL7-YGE5E1476814768epsmtip26;
        Thu, 21 May 2020 23:44:04 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>,
        "'Eric Sandeen'" <sandeen@sandeen.net>
In-Reply-To: <004401d62fc9$4ba36620$e2ea3260$@samsung.com>
Subject: RE: [PATCH] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
Date:   Fri, 22 May 2020 08:44:04 +0900
Message-ID: <004501d62fc9$b645ad80$22d10880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJgsL+u4FsRIrdoKX1/b3H9pYdmWQLupgdfp4a7+lA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmnq6r0PE4g7kPmSz27D3JYnF51xw2
        ix/T6y1ar2hZPOp7y27x+8ccNgc2j80rtDxOzPjN4tG3ZRWjx5bFD5k8Pm+SC2CNyrHJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqvpFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIyXh74Cd7
        wRTpiu9n1jE2MM4T7mLk5JAQMJFYfmwWcxcjF4eQwA5GiZNrNkM5nxgl1n/pZoRwvjFKvLm0
        jxGm5UHzFyaIxF5GibOLF7BAOC8ZJQ5v3A5WxSagK/Hvz342EFtEQEei6+V2VpAiZoHdjBJ9
        i7aBJTgFrCTOvN4KZgsLpEl83jOJFcRmEVCVuHVxEtggXgFLiTvPZ0HZghInZz5hAbGZBeQl
        tr+dwwxxkoLEz6fLWCGWWUlsfbSLGaJGRGJ2ZxvYQxICvRwSh6f+hvrBRWLjk0lMELawxKvj
        W9ghbCmJz+/2Ah3EAWRXS3zcDzW/g1HixXdbCNtY4ub6DawgJcwCmhLrd+lDhBUldv6eywix
        lk/i3dceVogpvBIdbUIQJaoSfZcOQy2Vluhq/8A+gVFpFpLHZiF5bBaSB2YhLFvAyLKKUSy1
        oDg3PbXYsMAUObY3MYLTppblDsZj53wOMQpwMCrx8FqkHYsTYk0sK67MPcQowcGsJMK7kP9o
        nBBvSmJlVWpRfnxRaU5q8SFGU2C4T2SWEk3OB6b0vJJ4Q1MjY2NjCxMzczNTYyVx3qnXc+KE
        BNITS1KzU1MLUotg+pg4OKUaGFdyh+XEe3B93mScuiBD98DHH0ITFH21ftvouR6aHMVzx8f7
        ZqB8+hS/4/ufXQjseH73+nqx7aknpqUylPw1rgq7kT3Z6th1TnP3+LW3LOU/utbGvYt7d/nZ
        17MOdbXBBtyayx+U3d3i37tE8kMd67RLX9uLg502/opUXWpmzjqnx+Oop8oMRyWW4oxEQy3m
        ouJEAKY+/kSxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvK6L0PE4g86LihZ79p5ksbi8aw6b
        xY/p9RatV7QsHvW9Zbf4/WMOmwObx+YVWh4nZvxm8ejbsorRY8vih0wenzfJBbBGcdmkpOZk
        lqUW6dslcGW8PfCTvWCKdMX3M+sYGxjnCXcxcnJICJhIPGj+wtTFyMUhJLCbUaLpdzcjREJa
        4tiJM8xdjBxAtrDE4cPFEDXPGSWu3VvLDlLDJqAr8e/PfjYQW0RAR6Lr5XZWkCJmgf2MEh0z
        7zFCdHQzSmx/9Rasg1PASuLM661gHcICKRKTv3eAbWMRUJW4dXESmM0rYClx5/ksKFtQ4uTM
        JywgNrOAtkTvw1ZGCFteYvvbOcwQlypI/Hy6jBXiCiuJrY92MUPUiEjM7mxjnsAoPAvJqFlI
        Rs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI0hLcwfj9lUf9A4x
        MnEwHmKU4GBWEuFdyH80Tog3JbGyKrUoP76oNCe1+BCjNAeLkjjvjcKFcUIC6YklqdmpqQWp
        RTBZJg5OqQYm1sSaI3UTv+5XypjzpKx9ruLxLW/4EwuXGEjKndN6v/HbzUf6vxZYzWaKuGyy
        RmnhjW25dzmauEImLzFfFFTP58hVzNp5JPzP0XlMbn+jbBtVq766tf931F/It/jZgjRZwX29
        S2SyRRwt5rfOuPMxN7lYvpTLZGmVw432NOvFZ8yUueeeeuXD4vR2Yq9IzFTH6bbXSw4J+C3e
        1pwxZ8K/SbsncMpe7Cl7MdN5w/a3bU5TRJyYHvOWTLxzM3tu9amGedvca5+lFrFtuZe+Xnyz
        RXbCo/urT0+a37Ctl5+x+cexCb6+AnMufuF/9/dO27xwq1Vz5U782nZ57iOPIw/NKjfUvOn0
        4f8jvOyexdSKrUosxRmJhlrMRcWJANSShJYPAwAA
X-CMS-MailID: 20200521234404epcas1p2922b1787353e207b3c1286130beb99f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200521234105epcas1p14b910bcdc017938249a491a1b5207bb8
References: <CGME20200521234105epcas1p14b910bcdc017938249a491a1b5207bb8@epcas1p1.samsung.com>
        <004401d62fc9$4ba36620$e2ea3260$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, May 21, 2020 at 10:44:28AM -0500, Eric Sandeen wrote:
> > On 5/21/20 9:05 AM, Namjae Jeon wrote:
> > > As Ubuntu and Fedora release new version used kernel version equal
> > > to or higher than v5.4, They started to support kernel exfat filesystem.
> > >
> > > Linus Torvalds reported mount error with new version of exfat on Fedora.
> > >
> > >     exfat: Unknown parameter 'namecase'
> > >
> > > This is because there is a difference in mount option between old
> > > staging/exfat and new exfat.
> > > And utf8, debug, and codepage options as well as namecase have been
> > > removed from new exfat.
> > >
> > > This patch add the dummy mount options as deprecated option to be
> > > backward compatible with old one.
> >
> > Wow, it seems wild that we'd need to maintain compatibility with
> > options which only ever existed in a different codebase in a staging
> > driver (what's the point of staging if every interface that makes it
> > that far has to be maintained in perpetuity?)
> >
> > Often, when things are deprecated, they are eventually removed.
> > Perhaps a future removal date stated in this commit, or in
> > Documentation/..../exfat.txt would be good as a reminder to eventually remove this?
> 
> For NFS, 'intr' has been deprecated since December 2007 and has been printing a warning since June
> 2008.  How long until we delete it?
> 
> > >  static const struct constant_table exfat_param_enums[] = { @@
> > > -223,6 +229,10 @@ static const struct fs_parameter_spec exfat_parameters[] = {
> > >     fsparam_enum("errors",                  Opt_errors, exfat_param_enums),
> > >     fsparam_flag("discard",                 Opt_discard),
> > >     fsparam_s32("time_offset",              Opt_time_offset),
> > > +   fsparam_flag("utf8",                    Opt_utf8),
> > > +   fsparam_flag("debug",                   Opt_debug),
> > > +   fsparam_u32("namecase",                 Opt_namecase),
> > > +   fsparam_u32("codepage",                 Opt_codepage),
> 
>         __fsparam(NULL, "utf8",         Opt_utf8, fs_param_deprecated, NULL),
>         __fsparam(NULL, "debug",        Opt_debug, fs_param_deprecated, NULL),
>         __fsparam(fs_param_is_u32, "namecase", Opt_namecase,
>                                                 fs_param_deprecated, NULL),
>         __fsparam(fs_param_is_u32, "codepage", Opt_codepage,
>                                                 fs_param_deprecated, NULL),
> 
> > > @@ -278,6 +288,18 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter
> *param)
> > >                     return -EINVAL;
> > >             opts->time_offset = result.int_32;
> > >             break;
> > > +   case Opt_utf8:
> > > +           pr_warn("exFAT-fs: 'utf8' mount option is deprecated and has no effect\n");
> > > +           break;
> > > +   case Opt_debug:
> > > +           pr_warn("exFAT-fs: 'debug' mount option is deprecated and has no effect\n");
> > > +           break;
> > > +   case Opt_namecase:
> > > +           pr_warn("exFAT-fs: 'namecase' mount option is deprecated and has no effect\n");
> > > +           break;
> > > +   case Opt_codepage:
> > > +           pr_warn("exFAT-fs: 'codepage' mount option is deprecated and has no effect\n");
> > > +           break;
> 
> and then you don't need this hunk because the fs parser will print the deprecated message for you.
Fixed it on v3.
Thanks for your review!


