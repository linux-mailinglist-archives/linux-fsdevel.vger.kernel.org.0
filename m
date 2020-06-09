Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E01F3225
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFICDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 22:03:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:12239 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgFICDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:03:02 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200609020259epoutp020dcaa0f2a043c33d39eebf135726bbda~Wvcamo4z92975729757epoutp02A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 02:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200609020259epoutp020dcaa0f2a043c33d39eebf135726bbda~Wvcamo4z92975729757epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591668179;
        bh=R8Sr9xQ0isxegvea6Sq7X7Fbc4GHj3RJPM1sjjKZIO8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GeCE7tA6KDHxPbDC4Rwz/dG5CosXjUEkTHCa3ZWPTs2OdNRlN71x9naQh/+Au1OOi
         W3VHAapFJ0FpIdqlrNiqEAept7VykIqxlEciZov69hQwlZVioXRX6Jpbd9Us/f4cko
         3SunVsuj8ZqTE3HKBLkr0WsoG1L5fKsOMWhMFj9Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200609020258epcas1p268e6b7f6f3ccd506e5943a382032758f~WvcaRaYAL0974409744epcas1p2u;
        Tue,  9 Jun 2020 02:02:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49gtgQ1XHLzMqYkb; Tue,  9 Jun
        2020 02:02:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.DD.28581.2DDEEDE5; Tue,  9 Jun 2020 11:02:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200609020257epcas1p1829b7a8df3db637870b1bd26f8e6476d~WvcZPY2pj0976309763epcas1p1n;
        Tue,  9 Jun 2020 02:02:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609020257epsmtrp23903db503dff0c38dcacf53ccc46b361~WvcZOr-Q52147421474epsmtrp21;
        Tue,  9 Jun 2020 02:02:57 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-2d-5edeedd284f9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.BB.08382.1DDEEDE5; Tue,  9 Jun 2020 11:02:57 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609020257epsmtip1292fbbe6ac085a9dba1d5e13fdd17baa~WvcZFFneR2253722537epsmtip1u;
        Tue,  9 Jun 2020 02:02:57 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>
In-Reply-To: <TY1PR01MB157812F9DFC574527D8AA26E90850@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH 3/3] exfat: set EXFAT_SB_DIRTY and VOL_DIRTY at the same
 timing
Date:   Tue, 9 Jun 2020 11:02:57 +0900
Message-ID: <00a801d63e02$1885ffe0$4991ffa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLXKQP27k1kxA/L0Bi34tDQsKzyRwIaHrMyAgnBFJkBlgzLbAE6MjkHAs32T0wCUxAIpKZtBZvA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmge6lt/fiDL6c4bR4c3Iqi8XEaUuZ
        LfbsPclicXnXHDaLy/8/sVgs+zKZxWLLvyOsDuweX+YcZ/dom/yP3aP52Eo2j02rOtk8+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxqwbv9kLJvNVfHiymaWBcSp3FyMnh4SAicTDG0dYuhi5OIQEdjBKfP0wmQUk
        ISTwiVGi50gGROIbo8TK5W+ZYDo2n9zCDJHYyyhx6fZFqPaXjBInTy9jBqliE9CV+PdnP1sX
        IweHiICRxNOThSA1zAI/GCVWf1sMNolTIFZizvrHYLawQKhE6+PN7CA2i4CKxMcjixhBbF4B
        S4lbv9pYIGxBiZMzn4DZzALyEtvfzmGGuEhB4ufTZawgtohAlMSB+YuZIWpEJGZ3toFdKiGw
        kEOi5dNUqBdcJK4ebmKDsIUlXh3fwg5hS0l8frcX7GgJgWqJj/uh5ncwSrz4bgthG0vcXL+B
        FaSEWUBTYv0ufYiwosTO33MZIdbySbz72sMKMYVXoqNNCKJEVaLv0mGoA6Qluto/sE9gVJqF
        5LFZSB6bheSBWQjLFjCyrGIUSy0ozk1PLTYsMEGO602M4GSqZbGDce7bD3qHGJk4GA8xSnAw
        K4nwVj+4EyfEm5JYWZValB9fVJqTWnyI0RQY1BOZpUST84HpPK8k3tDUyNjY2MLEzNzM1FhJ
        nPek1YU4IYH0xJLU7NTUgtQimD4mDk6pBqa43K/usxwT4v4pdnwXPTL39OuN1pq31RgKlKRW
        nD/RJ8l7OeDKAT97rnNal4/flFnaMfGSt6/2gr0yi05Y2+oa8dQFRAY1NH2on/ehreA0t5pK
        mGDuyg0yqVm+k098ujV5Rn/re+WTYq8Zv7x8pJlhcPff/svbD1//MvmC/MOKi3tmZkRv3PRw
        nsLDNqd8x4tyKy1yP/y46SNxVDR92qfeDcdMM48dMHr8uG1FWKBT+SqLA/lNzaz5lu7RNV9N
        nbeUPknMP1CSN6PL9NbKKXUNz2SCEpue9rsveqRRxKz1JbZCespFx/N71qTf3NK+/F7Hq3cX
        f63/FLPSyu17cnWiZ8Qahz8ZUXc3pR3pTtmhxFKckWioxVxUnAgAKGKdYS8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTvfi23txBrM7tSzenJzKYjFx2lJm
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY9OqTjaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgyph14zd7wWS+ig9PNrM0ME7l7mLk5JAQMJHYfHILcxcj
        F4eQwG5GiTkndrFCJKQljp04A5TgALKFJQ4fLoaoec4oset3CztIDZuArsS/P/vZQGpEBIwk
        np4sBKlhFvjDKPH/3EpWiIY1zBKvP59mBGngFIiVmLP+MROILSwQLLHoyiGwOIuAisTHI4vA
        bF4BS4lbv9pYIGxBiZMzn4DZzALaEr0PWxkhbHmJ7W/nMEMcqiDx8+kysKNFBKIkDsxfzAxR
        IyIxu7ONeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIjiwtzR2M21d90DvEyMTBeIhRgoNZSYS3+sGdOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        NwoXxgkJpCeWpGanphakFsFkmTg4pRqY5ri03LrGzObwboHGl7Wbcj8YMFXcLQ9Mb7rwJsrr
        I8/+F5u/vrqgU7v4uMgVzQtigfpXLvoWv5matm6BsYa6641t8pElKrveaN04tMmmUsF86vsq
        uX6+N92Lvj2duuvBxpeuG49qnIs8toXV/ljST9uPh23XMjw/8cFsDU9ad8fsd0IcEpLqMman
        TTaf4w38HXFla2nHdPXMnysZUsWlFadJyu1zkCtMq+f5/Z7PcfGvvttyUy1bzXctqFYKk9hc
        OX+j2Odna/msDRaaz5F6etToyKmHS8KlVTdPfeSxuW2WX5qPoa3p3+uBrxZOaDEyPKgiwOK2
        pskx6ctL7wc1n+5vCbe8eOw2H4vNoYZjZ5VYijMSDbWYi4oTAVd0UEEbAwAA
X-CMS-MailID: 20200609020257epcas1p1829b7a8df3db637870b1bd26f8e6476d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200604084534epcas1p281a332cd6d556b5d6c0ae61ec816c5a4
References: <20200604084445.19205-1-kohada.t2@gmail.com>
        <CGME20200604084534epcas1p281a332cd6d556b5d6c0ae61ec816c5a4@epcas1p2.samsung.com>
        <20200604084445.19205-3-kohada.t2@gmail.com>
        <000401d63b0b$8664f290$932ed7b0$@samsung.com>
        <229ab132-c5f1-051c-27c4-4f962ceff700@gmail.com>
        <CAKYAXd8SqaMj6e9urqdKWCdaexgAoN78Pzh0NYQ35iRYA=2tiA@mail.gmail.com>
        <TY1PR01MB157812F9DFC574527D8AA26E90850@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thank you for your comment.
> 
> > >> Can you split this patch into two? (Don't set VOL_DIRTY on
> > >> -ENOTEMPTY and Setting EXFAT_SB_DIRTY is merged into
> > >> exfat_set_vol_flag). I need to check the second one more.
> > >
> > > Can't do that.
> > >
> > > exfat_set_vol_flag() is called when rmdir processing begins. When
> > > Not-empty is detected, VOL_DIRTY has already been written and synced
> > > to the media.
> > You can move it before calling exfat_remove_entries().
> 
> Can be moved, but that doesn't solve the problem.
> It causes the similar problem as before.
> 
> exfat_remove_entries() calls exfat_get_dentry().
> If exfat_get_dentry() fails, update bh and set SB_DIRTY will not be executed.
> As a result, SB_DIRTY is not set and sync does not work.
> Similar problems occur with other writing functions.
> Similar problems occur when pre-write checks are added in the future.
> 
> If you don't set VOL_DIRTY at the beginning, you should delay to set VOL_DIRTY until update-bh & set
> SB_DIRTY.
> This avoids unnecessary changes to VOL_DIRTY/VOL_CLEAN.
Right, That's what I am going to point out.
> I think this method is smart, but it is difficult to decide when to set VOL_CLEAN.
> (I tried to implement it, but gave up)
Okay, I'm a little busy now, but I'll give you feedback soon.
Thanks for your work!
> 
> > > By doing this, sync is guaranteed if VOL_DIRTY is set by calling
> > > exfat_set_vol_flag.
> > >
> > > This change may still have problems, but it's little better than
> > > before, I think.
> > I need to check more if it is the best or there is more better way.
> 
> I think the sync-problems still exist.
> Let's improve little by little. :-)
> 
> BR
> ---
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

