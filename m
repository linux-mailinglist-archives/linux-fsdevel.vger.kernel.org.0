Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC7C277D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 03:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIYBGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 21:06:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16208 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIYBGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 21:06:05 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 21:06:04 EDT
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200925005646epoutp01ee011bd5f7baf29383b1d6851b378ca2~34Nb_igCK2123221232epoutp01S
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 00:56:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200925005646epoutp01ee011bd5f7baf29383b1d6851b378ca2~34Nb_igCK2123221232epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600995406;
        bh=z32H6aQay7XFfuA804nDkfeVeeydsEIaljd/QbT8aUI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NYXFfix7ixEYe9izi4jnW6jsrkYqj8c6VarhAP3a2h9DLP/tqHTwqazq+liYZEzs0
         1WGYRspfrcbYL9JMrq7e47vdOA5hQD/s8uuO6IdNzMTvc/jhI9PCZkylpVYesXaS8I
         qZJIxeZzFZCxhge97MEea9Z8/oHf/5KxvutbGt6g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200925005645epcas1p401c9e6c33a83d249ef4d53c4196da45b~34NbVFdUj0917209172epcas1p4z;
        Fri, 25 Sep 2020 00:56:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4ByD584TnJzMqYkk; Fri, 25 Sep
        2020 00:56:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.A3.09543.C404D6F5; Fri, 25 Sep 2020 09:56:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200925005644epcas1p43904a4a4e545c6533e2bfd87ffca4b45~34NZ2RH0r0917209172epcas1p4t;
        Fri, 25 Sep 2020 00:56:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200925005644epsmtrp1807eda8f91f90720edc07ab36551a14b~34NZ1p7L_2495024950epsmtrp1c;
        Fri, 25 Sep 2020 00:56:44 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-42-5f6d404c6984
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.39.08604.C404D6F5; Fri, 25 Sep 2020 09:56:44 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200925005644epsmtip2c5a72b329430f5b16961fc79dcaab928~34NZnl4ZD1970419704epsmtip2F;
        Fri, 25 Sep 2020 00:56:44 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <0f9d3d3e-075f-511d-12e5-21346bca081e@gmail.com>
Subject: RE: [PATCH] exfat: remove 'rwoffset' in exfat_inode_info
Date:   Fri, 25 Sep 2020 09:56:43 +0900
Message-ID: <711c01d692d6$bc389610$34a9c230$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMi4/VQwbYo/U4C9ybSoLj7f91ObgIeTeE0AlzxujABsyhvGKauceYw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmga6PQ268wfV3yhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMlY0vmMsaCPr2LZj83MDYxvuboYOTkkBEwk5i+5xtTFyMUhJLCDUWLOuvusEM4n
        RokFU94zQjjfGCUeLVjCBtMy6+1NdojEXkaJy8d/QLW8ZJS482UrE0gVm4CuxJMbP5lBbBEB
        PYmTJ6+DdTMLNDJJnHiZDWJzCthKHJq4hBXEFhZwlPjVfg+snkVAVWLtsZMsIDavgKXE+nv9
        rBC2oMTJmU9YIObIS2x/O4cZ4iIFid2fjrJC7HKTOHvlJCNEjYjE7M42qJq5HBL3GuMgbBeJ
        RXf3QX0jLPHq+BZ2CFtK4mV/G5RdL/F//lqwLyUEWhglHn7aBvQYB5BjL/H+kgWIySygKbF+
        lz5EuaLEzt9zodbySbz72sMKUc0r0dEmBFGiIvH9w04WmE1XflxlmsCoNAvJY7OQPDYLyQOz
        EJYtYGRZxSiWWlCcm55abFhgiBzZmxjByVTLdAfjxLcf9A4xMnEwHmKU4GBWEuE9viEnXog3
        JbGyKrUoP76oNCe1+BCjKTCoJzJLiSbnA9N5Xkm8oamRsbGxhYmZuZmpsZI478NbCvFCAumJ
        JanZqakFqUUwfUwcnFINTAd+HZtlrrTEu1wu0JA/4mDpvPZv8rlpG+OntbQerli13SBnm7+b
        3JvNVx51vp0nL1v5TLK49tWTGN39ZdNlk8JCPx6bWHDt7BXxr1eUO2qFnwTvuSFzdZLtoctC
        y3dfObBxnZO4y6d/ohLqCkekP2c9jfi73frLh6berbd1SlpP+S96HHUxT/LsjT/B5TJFv73K
        l+qWu9+7tHuFmm6qVNmt03/cOK+67NG+bbRm1eXV3Esndr9PYekN/nar88qXvrNHEmr7DWbE
        3FVo3Ga6grFhnpJc3IMbWbWHk36J986pLmCyP6MUtcbJ7pxE+bNuyfu2a5cmCPEmrTlWb1FV
        /yW++MURpSWFO2etfsLXsU2JpTgj0VCLuag4EQD5itxlLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXtfHITfe4PEGdosfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLH5Mr3dg9/gy5zi7R9vkf+wezcdWsnnsnHWX3aNvyypG
        j8+b5ALYorhsUlJzMstSi/TtErgylnQ+Yyzo46tY9mMzcwPjW64uRk4OCQETiVlvb7J3MXJx
        CAnsZpR40/6RqYuRAyghJXFwnyaEKSxx+HAxRMlzRokNP54xgfSyCehKPLnxkxnEFhHQkzh5
        8jobSBGzQDOTROuXZrA5QgIvGSUOcoDUcArYShyauIQVxBYWcJT41X4PrJdFQFVi7bGTLCA2
        r4ClxPp7/awQtqDEyZlPwOLMAtoSvQ9bGSFseYntb+cwQ9yvILH701FWiBvcJM5eOQlVIyIx
        u7ONeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
        jiktzR2M21d90DvEyMTBeIhRgoNZSYT3+IaceCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoX
        xgkJpCeWpGanphakFsFkmTg4pRqYdIRLGmQW3tc7WzvrAJvK/5gDRXlnFx7eb7n9dKPKwb3x
        0Wx/hVO/uPGpzxScaP3c8O1r7ya1k0fO7mH6u/SnTIVkprZwqsrqyrgbT7RfVu6bd06JZa1k
        0B2hIEbnNL/SP2ZcZiqn803eV25mc9HbZXjqzOdZYT8vrNfu+fZs48UWoboPHDo98evt5jxu
        YGq/e/323x9x/yerekjdtd/0fdqlj19i8hNnRxawWvK9nxN8WktgYsuz0n8z7r+2FPy37vRt
        jTkP3qYFspwMshVW/poSsm6+bRJXleSrHquL3duXmCbEfpjK5dV9alLlB/HmBwaskfdfL+nO
        SpHapv1bot0tX/rTv3uHkhf/WNP9TYmlOCPRUIu5qDgRAOaRTlMYAwAA
X-CMS-MailID: 20200925005644epcas1p43904a4a4e545c6533e2bfd87ffca4b45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200909075713epcas1p44c2503251f78baa2fde0ce4351bf936d
References: <CGME20200909075713epcas1p44c2503251f78baa2fde0ce4351bf936d@epcas1p4.samsung.com>
        <20200909075652.11203-1-kohada.t2@gmail.com>
        <000001d688c1$c329cad0$497d6070$@samsung.com>
        <0f9d3d3e-075f-511d-12e5-21346bca081e@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 2020/09/12 14:01, Sungjong Seo wrote:
> >> Remove 'rwoffset' in exfat_inode_info and replace it with the
> >> parameter(cpos) of exfat_readdir.
> >> Since rwoffset of  is referenced only by exfat_readdir, it is not
> >> necessary a exfat_inode_info's member.
> >>
> >> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> >> ---
> >>   fs/exfat/dir.c      | 16 ++++++----------
> >>   fs/exfat/exfat_fs.h |  2 --
> >>   fs/exfat/file.c     |  2 --
> >>   fs/exfat/inode.c    |  3 ---
> >>   fs/exfat/super.c    |  1 -
> >>   5 files changed, 6 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> >> a9b13ae3f325..fa5bb72aa295 100644
> >> --- a/fs/exfat/dir.c
> >> +++ b/fs/exfat/dir.c
> > [snip]
> >> sector @@ -262,13 +260,11 @@ static int exfat_iterate(struct file
> >> *filp, struct dir_context *ctx)
> >>   		goto end_of_dir;
> >>   	}
> >>
> >> -	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
> >> -
> >>   	if (!nb->lfn[0])
> >>   		goto end_of_dir;
> >>
> >>   	i_pos = ((loff_t)ei->start_clu << 32) |
> >> -		((ei->rwoffset - 1) & 0xffffffff);
> >> +		(EXFAT_B_TO_DEN(cpos-1) & 0xffffffff);
> >
> > Need to fix the above line to be:
> > (EXFAT_B_TO_DEN(cpos)-1)) & 0xffffffff);
> 
> 
> Here, we simply converted so that the calculation results would be the
> same.
> But after reading it carefully again, I noticed.
>   - Why use the previous entry?
>   - Why does cpos point to stream dir-entry in entry-set?
> 
> For the former, there is no need to "++dentry" in exfat_readdir().
> For the latter, I think cpos should point to the next to current entry-set.
> 
> I'll make V2 considering these.
> How do you think?

The latter looks better.
> 
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>


