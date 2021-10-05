Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37F422B87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhJEOzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 10:55:55 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:61147 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEOzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:55:54 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211005145402epoutp040cc1d3d7ca234e406b4d563ab7c889ab~rKihWPgwu1716717167epoutp04G
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 14:54:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211005145402epoutp040cc1d3d7ca234e406b4d563ab7c889ab~rKihWPgwu1716717167epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633445642;
        bh=owNFM42vrkk5mvEoZ58WzfGeNc+ZJu5wxnvZyxZipAs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nuxujnPcTTwk5kwPhH2DA1ceRUS0lYsJIz9/7c17lcKAqknoWC7IbcPIpKsGz3Ns6
         1RaMU5cUVSh3AQXzrhnAS/Cpe7joo952uebp8UoXdb6kACHzZX47Wl/8UE8/ShIq2E
         C4cGVsJn87GF48QX1YwUtaMSXhwOEDJcBdR+yOzI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211005145402epcas1p3baddf512744067eb796ad28f804bcc1a~rKig6DQ170387503875epcas1p3L;
        Tue,  5 Oct 2021 14:54:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.250]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HP0w820tyz4x9Pr; Tue,  5 Oct
        2021 14:54:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.78.62504.8076C516; Tue,  5 Oct 2021 23:54:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211005145359epcas1p34f605fae95833457c3c5bbde8427d463~rKieO1TE-0610506105epcas1p3p;
        Tue,  5 Oct 2021 14:53:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211005145359epsmtrp213d6346e170c72f49e2ba9b48a2e59eb~rKieOG_o50698306983epsmtrp2H;
        Tue,  5 Oct 2021 14:53:59 +0000 (GMT)
X-AuditID: b6c32a38-79bff7000002f428-e3-615c6708fd99
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.92.09091.7076C516; Tue,  5 Oct 2021 23:53:59 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211005145359epsmtip182df3aeb55ae35b4743c4d0d5b6a7a71~rKieCX9xk0828308283epsmtip1H;
        Tue,  5 Oct 2021 14:53:59 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'Chung-Chiang Cheng'" <cccheng@synology.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shepjeng@gmail.com>, <sj1557.seo@samsung.com>
In-Reply-To: <CAKYAXd_vFjVcHJxn5xau5hFNHBXc2K7o1wFHbkhz9TcCteG2Rw@mail.gmail.com>
Subject: RE: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't
 set
Date:   Tue, 5 Oct 2021 23:53:58 +0900
Message-ID: <d43501d7b9f8$d3f33b80$7bd9b280$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGbLD2CCutv2trCrUWvFxdYN9vjigGoD6NLAWfhRkYBJWz3gQLEsXbMAWOpcn8CEie+dqvp5/CA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTQJcjPSbR4MY3Loutz46zWkyctpTZ
        Ys/ekywWl3fNYbNonS1pseXfEVYHNo+ds+6ye2xa1cnm0bdlFaPHjA/7WT0+b5ILYI3KtslI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ3xdsYM
        1oKlShVNi9QaGB9IdzFyckgImEg0z/nOCGILCexglGhoUe5i5AKyPzFKXOzoZodwvjFKHLvb
        ygTTcenlPiaIxF5GiWmP7kNVvWSUeHrkNytIFZuArsSTGz+Zuxg5OEQEtCXuv0gHqWEWWMYo
        sat5OiNInFMgUOLVSkmQcmGBAInemRfAWlkEVCRWTLzAAmLzClhKPL+xhw3CFpQ4OfMJWJxZ
        QF5i+9s5zBAHKUjs/nQUrFdEIErizZcXbBA1IhKzO9uYQfZKCHRySPTe/cIG0eAicfvtTKhm
        YYlXx7ewQ9hSEp/f7YWqqZf4P38tO0RzC6PEw0/bmECOlhCwl3h/yQLEZBbQlFi/Sx+iXFFi
        5++5jBB7+STefe1hhajmlehoE4IoUZH4/mEnC8ymKz+uMk1gVJqF5LNZSD6bheSDWQjLFjCy
        rGIUSy0ozk1PLTYsMIFHdXJ+7iZGcMrUstjBOPftB71DjEwcjIcYJTiYlUR4r3pFJgrxpiRW
        VqUW5ccXleakFh9iNAWG9URmKdHkfGDSziuJNzSxNDAxMzKxMLY0NlMS5z322jJRSCA9sSQ1
        OzW1ILUIpo+Jg1OqgUlWprbncf056WfnTeM2P9/3XHrfvq9t3szfpry70Bdh1c/i9L1xo9Wx
        VMGl7YJ2Lt+26U1tWvVNV8vdoKxw8snHyczCV7ODxSPmFbrsZwvh9PwVc2+TxGS/B5tXK7V/
        D8nokp4Zq+Q3c+6ep0VuRx2q7u38rbhZ/uuejcVTnv6cVnT9Bpv95ZPf5n9UNd4hWK7h9uJn
        3uIzd45vmvz7xNZ7ya/PTlasbZ7e5Ofz1//79S8fty+/sP0yy+fPEwTVnzAtt55vJPl17i97
        y2l93eX37ebKMB/heN4Wptd2z8m1s678w+dTBu4/KlYKv1x/xmTiFM28F+WMSqub7jMmFLX/
        ZrP6diaeu/zs4cJNlcVvlFiKMxINtZiLihMBxegnzyIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnC57ekyiwYeb7BZbnx1ntZg4bSmz
        xZ69J1ksLu+aw2bROlvSYsu/I6wObB47Z91l99i0qpPNo2/LKkaPGR/2s3p83iQXwBrFZZOS
        mpNZllqkb5fAlfF2xgzWgqVKFU2L1BoYH0h3MXJySAiYSFx6uY8JxBYS2M0osbGdq4uRAygu
        JXFwnyaEKSxx+HAxRMVzRok7+4RAbDYBXYknN34yg5SICGhL3H+RDhJmFljFKLH0eXUXIxdQ
        +XZmiQeHP7KA1HAKBEq8WikJYgoL+EnM32kPUs4ioCKxYuIFFhCbV8BS4vmNPWwQtqDEyZlP
        WCBGakv0PmxlhLDlJba/ncMMcbuCxO5PR1lBbBGBKIk3X16wQdSISMzubGOewCg8C8moWUhG
        zUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjRktzB+P2VR/0DjEy
        cTAeYpTgYFYS4b3qFZkoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQi
        mCwTB6dUA5NNKMO6lLUbGZp/GKetsNqt4ByoZO0Su0D4ae7JXTlcOoznde5JxlXWptx4IavN
        4Xn8a/vP6nlfr+sy7NO5ySXLOfttudoHfWXG1kUuNss/WCyMvjQhUVFwdeGVSw6MvFveKfNO
        DWudYam86tt1tzty1wWmHS/7pJZcP2mrkmfgzAadBFn9TOOYCUGvG3YfeeLb7hlzurM+a+s6
        y5NzNtyavcs68uQbrpOpBrYMFWzp1iwRB81ear3z11xkmVxr/MP+Q1mC54aj+he5HrpH871v
        ZQ6J7BBVs/mZJSi7d+FDmYcCh2M1VUwXc84znKax6/e7Ldfq/8+drcn/JG0dy2xey/L2DCbJ
        TLFALXYtJZbijERDLeai4kQAZ7ysYQkDAAA=
X-CMS-MailID: 20211005145359epcas1p34f605fae95833457c3c5bbde8427d463
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd
References: <20210909065543.164329-1-cccheng@synology.com>
        <CGME20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd@epcas1p4.samsung.com>
        <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
        <997a01d7b6c6$ea0c3f50$be24bdf0$@samsung.com>
        <CAKYAXd9COEWU_QF3p0mnEnH4nHMrHQ5ujwBZ6rt4ZBjEFBnB=w@mail.gmail.com>
        <c28301d7b99e$37fb5af0$a7f210d0$@samsung.com>
        <CAKYAXd_vFjVcHJxn5xau5hFNHBXc2K7o1wFHbkhz9TcCteG2Rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 2021-10-05 13:05 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> >> 2021-10-01 22:19 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> >> > Hello, Namjae,
> >> Hi Sungjong,
> >> >
> >> > I found an important difference between the code we first wrote and
> >> > the code that has changed since our initial patch review. This
> >> > difference seems to cause compatibility issues when reading saved
> >> timestamps without timezone.
> >> > (In our initial patch review, there were concerns about possible
> >> > compatibility issues.) I think the code that reads timestamps
> >> > without timezone should go back to the concept we wrote in the
> >> > first place like reported patch.
> >> Are you talking about using sys_tz?
> > Yes, exactly, a part like below.
> Have you read discussion about this before ?

Of course. That's why I wrote the expression "go back".
As you know, there was the discussion of local time conversion method for
reading timestamps that have no OffsetValid bit.
that is, whether to use sys_tz or not was the main topic.

And I understand that the current exFAT implementation doesn't use sys_tz
and depends entirely on time_offset.(UTC if time_offset is not set)

> Let me know what I am missing something.

No, there is nothing you are missing.
I thought compatibility issues regarding sys_tz could be serious
because I misunderstood that other compatibility issues were reported. :(

I am just concerned that most system daemons mount exfat-fs without
time_offset option, which could be reported as a compatibility issue.

However, to discuss this more, it would be nice to see the trend of how
many issues regarding sys_tz will be reported.

> 
> >
> > +static inline int exfat_tz_offset(struct exfat_sb_info *sbi) {
> > +	return (sbi->options.tz_set ? -sbi->options.time_offset :
> > +			sys_tz.tz_minuteswest) * SECS_PER_MIN; }
> > +
> >
> >>
> >> > It could be an answer of another timestamp issue.
> >> What is another timestamp issue ?
> >
> > What I'm saying is "timestamp incompatibilities in exfat-fs" from
> > Reiner <reinerstallknecht@gmail.com> I think it might be the same
> > issue with this.
> Have you checked fuse-exfat patch he shared ? It was exfat timezone
> support.
> I am not sure how it is related to sys_tz...

As I mentioned above, I misunderstood. :)
I mistakenly thought that the code that handles timestamp without
OffsetValid bit was added as well.

Thanks!

> 
> Thanks!
> >
> >>
> >> >
> >> > Could you please let me know what you think?
> >> >
> >> > Thanks.
> >> >> -----Original Message-----
> >> >> From: Namjae Jeon [mailto:linkinjeon@kernel.org]
> >> >> Sent: Friday, September 10, 2021 10:01 AM
> >> >> To: Chung-Chiang Cheng <cccheng@synology.com>
> >> >> Cc: sj1557.seo@samsung.com; linux-fsdevel@vger.kernel.org; linux-
> >> >> kernel@vger.kernel.org; shepjeng@gmail.com
> >> >> Subject: Re: [PATCH] exfat: use local UTC offset when
> >> >> EXFAT_TZ_VALID isn't set
> >> >>
> >> >> 2021-09-09 15:55 GMT+09:00, Chung-Chiang Cheng
> <cccheng@synology.com>:
> >> >> > EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
> >> >> > specification [1]. If this bit isn't set, timestamps should be
> >> >> > treated as having the same UTC offset as the current local time.
> >> >> >
> >> >> > This patch uses the existing mount option 'time_offset' as fat
> does.
> >> >> > If time_offset isn't set, local UTC offset in sys_tz will be
> >> >> > used as the default value.
> >> >> >
> >> >> > Link: [1]
> >> >> > https://protect2.fireeye.com/v1/url?k=cba4edf5-943fd4c8-cba566ba
> >> >> > -0c
> >> >> > c47
> >> >> > a31309a-e70aa065be678729&q=1&e=225feff2-841f-404c-9a2e-c12064b23
> >> >> > 2d0
> >> >> > &u=
> >> >> > https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fwin32%2Ffil
> >> >> > eio %2F exfat-specification%2374102-offsetvalid-field
> >> >> > Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> >> >> Please read this discussion:
> >> >>
> >> >> https://protect2.fireeye.com/v1/url?k=9bbcab7c-c4279381-9bbd2033-0
> >> >> 00babff317b-88ee581b44536876&q=1&e=b0d8a44b-4821-44a8-860a-4d3116c
> >> >> b634d&u=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-
> >> >> fsdevel/patch/20200115082447.19520-10-namjae.jeon@samsung.com/
> >> >>
> >> >> Thanks!
> >> >
> >> >
> >
> >

