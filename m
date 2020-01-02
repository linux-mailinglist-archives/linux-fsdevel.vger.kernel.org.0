Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7312F1EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 00:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgABXsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 18:48:41 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:21448 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgABXsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:48:40 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200102234837epoutp04330a5f93ba3917c765b9319f087ede22~mNr-hIlTz1262512625epoutp04d
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 23:48:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200102234837epoutp04330a5f93ba3917c765b9319f087ede22~mNr-hIlTz1262512625epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578008917;
        bh=nsD3F5LcCYrq+OQmt3Ts6sn9EFV+R+rTzyqtxvAxOe0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nQaAgZ7FoyGEFqc5baKJaOj/wVWgsYVZ0q4SUKVP7fYDjhIqulUlBv8dY/LE7HS9Y
         y5pYe9+Dab/El9MXD3I1c942nu6JmYFri20aQ7tKqsR5BKAAWJini3ZGtTqlzdf42d
         XjeJN3gBRBWLa1RVqvYXUP7IAbaSUTGKpZIQpfkk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200102234836epcas1p488bf634402e5579fddee68b61f48718a~mNr_empUu2478624786epcas1p4O;
        Thu,  2 Jan 2020 23:48:36 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47pl9G6vsVzMqYlr; Thu,  2 Jan
        2020 23:48:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.5F.48498.2518E0E5; Fri,  3 Jan 2020 08:48:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200102234834epcas1p11aec3eea675ba77414e9e7a56ad51024~mNr9F2wNx3104831048epcas1p18;
        Thu,  2 Jan 2020 23:48:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200102234834epsmtrp2b7d8a1b9a59134f74efc77231636a8ad~mNr9FJv7b2626226262epsmtrp2k;
        Thu,  2 Jan 2020 23:48:34 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-fb-5e0e8152ec0e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.F6.06569.2518E0E5; Fri,  3 Jan 2020 08:48:34 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200102234834epsmtip1ebbaa917851f3c56f4d6382f573f570c~mNr841kzL1737017370epsmtip1g;
        Thu,  2 Jan 2020 23:48:34 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     =?iso-8859-1?Q?'Pali_Roh=E1r'?= <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <valdis.kletnieks@vt.edu>, <hch@lst.de>, <sj1557.seo@samsung.com>,
        "'Namjae Jeon'" <linkinjeon@gmail.com>
In-Reply-To: <20200102141910.GA4020603@kroah.com>
Subject: RE: [PATCH v9 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Fri, 3 Jan 2020 08:48:34 +0900
Message-ID: <001401d5c1c7$2531c8d0$6f955a70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwJukssYAlUK9DECBK+/DwIuybYIAbHfR8GmihFUEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTv2727u0aT27I6GeS69LRcm3PrWi2iogYZ2ZMoyi7uY1rb3WV3
        9iaMwFTStBR0ZfioQCsUkew1jGVUFFlq77Q3WFlZo6dRbbsL9t/v/M7vfOd3zndoQtNExdPZ
        gge7Bd7BUkPJs1em6pNW7I3dqL9fnsrtq2ukuPpTVxXcg57HBHfJd4Pkui4cpbjSm4MKruVP
        u5Lr/DRAzqOt5709Kmtb1WmV9eKjXMpa3NKArIHmcVZ/az+VTq1zzMnCvA27tVjIdNmyBbuF
        XbIyY0GGyaw3JBlSuZmsVuCd2MIuTEtPWpTtCBpitVt5R06QSucliZ0xd47blePB2iyX5LGw
        WLQ5RINe1Em8U8oR7LpMl3OWQa9PNgWVmxxZvd2HCHEfvb3pXRuRi45ThSiGBiYFPtdXKQrR
        UFrDnENQWtUVCb4g6GqvJuXgG4K3fQHF/5KGq+0ohDWMD8Hph5tl0VsEv2r7iVCCYpLgz++2
        cI84Zjrk37oefolg+hF09x1WhhIxjAF8tf5ggqZHMGngbbSFaJKZAM/3+sLvqJlU+FXzipTx
        cLhR+TqMCUYHD8vLKBknQOuHo4RsTgs/35xUynwcHCnII2QPayAQOBL2AMxfCu7c+xEpWAh1
        eS8jyxgB7661qGQcD4GPPirkDZhd8LktIs9H0PfdImMjPGpsUsp4PJwfrEJy31j4+PWAUi5V
        Q36eRpZMhOLOK5EdjoXC/QOqEsR6oybzRk3mjZrMGzVNNSIb0CgsSk47lgxicvRvN6PwtSaa
        z6Ha22l+xNCIHaYuua/eqFHyW6UdTj8CmmDj1NuWBym1jd+xE7tdGe4cB5b8yBTcfCkRPzLT
        Fbx9wZNhMCUbjUYuxTzTbDKyo9X0j7sbNIyd9+AtGIvY/b9OQcfE56KiCWd5c9mgWD1p2prN
        /b7ustU1iqfLylKTdS8qnjVf7hDEPQ5K1TGx09OrK1qXuF5oOtH8+8vBWJIet2K+fcYFPMWy
        lO+J7fiwtqKusqW1eHxhVw2ZUP8k5cyx2bW44EmvqCwoV1Oq3UNinIo06kGdfdUrZfGl9wNT
        F7tKXkwew5JSFm9IJNwS/w+zAjpnwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG5QI1+cwc+j0hbNi9ezWaxcfZTJ
        4vrdW8wWe/aeZLG4vGsOm8XE07+ZLLb8O8Jqcen9BxYHDo+ds+6ye+yfu4bdY/fNBjaPvi2r
        GD0+b5LzOLT9DVsAWxSXTUpqTmZZapG+XQJXxr0rk5gLmjkqNrzaz9zAuISti5GTQ0LARGLV
        0SOMXYxcHEICuxklJu9cygqRkJY4duIMcxcjB5AtLHH4cDFIWEjgOaPEvQ9hIDabgK7Evz/7
        weaICOhIdJw5wQIyh1ngE6PEpf8vmSCGXmSSeLWqgRGkilPAUGLvokMsIEOFBXwkZq1PAQmz
        CKhIPGjcywxi8wpYSvxa+JgFwhaUODnzCZjNLGAgcf9QByuELS+x/e0cZog7FSR+Pl0GFReR
        mN3ZxgxxUJjE58+zWSYwCs9CMmoWklGzkIyahaR9ASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
        0rx0veT83E2M4AjT0trBeOJE/CFGAQ5GJR7eCdd444RYE8uKK3MPMUpwMCuJ8JYHAoV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwMpzWqz2woWH9/z3P
        7Au+pqYtSw+epOVn++nW28YiPjuVNBOz+VyrIg82RNps3S655sYXt5lyM1ye7Y196lfgqpK6
        bL9KY1/9de7baQdZDINn8n4KcGxZbnD24ZLWPRumnT9/Rqn9R83zBwZraiSy3yb+9l61revN
        XF+WJR5G73+fM6rL++nxTYmlOCPRUIu5qDgRANHqCjasAgAA
X-CMS-MailID: 20200102234834epcas1p11aec3eea675ba77414e9e7a56ad51024
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082408epcas1p194621a6aa6729011703f0c5a076a7396
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082408epcas1p194621a6aa6729011703f0c5a076a7396@epcas1p1.samsung.com>
        <20200102082036.29643-13-namjae.jeon@samsung.com>
        <20200102125830.z2uz673dlsdttjvo@pali>
        <CAKYAXd9Y6o+a7q_yismLP8nNXOUqrudC3KW8N6Z05OghYLt1jg@mail.gmail.com>
        <20200102141910.GA4020603@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, Jan 02, 2020 at 10:07:16PM +0900, Namjae Jeon wrote:
> > >> index 98be354fdb61..2c7ea7e0a95b 100644
> > >> --- a/fs/Makefile
> > >> +++ b/fs/Makefile
> > >> @@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+=
hugetlbfs/
> > >>  obj-$(CONFIG_CODA_FS)		+= coda/
> > >>  obj-$(CONFIG_MINIX_FS)		+= minix/
> > >>  obj-$(CONFIG_FAT_FS)		+= fat/
> > >> +obj-$(CONFIG_EXFAT)		+= exfat/
> > >>  obj-$(CONFIG_BFS_FS)		+= bfs/
> > >>  obj-$(CONFIG_ISO9660_FS)	+= isofs/
> > >>  obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find
wrapped
> HFS+
> > >
> > > Seems that all filesystems have _FS suffix in their config names. So
> > > should not have exfat config also same convention? CONFIG_EXFAT_FS?
> > Yeah, I know, However, That name conflicts with staging/exfat.
> > So I subtracted _FS suffix.
> 
> If it's a problem, please send me a patch to rename the staging/exfat/
> config option so that you can use the "real" one someday soon.
Okay, I will:)
Thanks a lot!
> 
> thanks,
> 
> greg k-h

