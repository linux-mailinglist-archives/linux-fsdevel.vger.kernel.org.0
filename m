Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000F2243291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 04:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMCxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 22:53:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:30002 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgHMCxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:53:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200813025309epoutp01c80bfb1823a3d99c06906ab5de76cd94~qtDxZsCsi3083830838epoutp01X
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:53:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200813025309epoutp01c80bfb1823a3d99c06906ab5de76cd94~qtDxZsCsi3083830838epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597287189;
        bh=MhLS3hiSKvnM3/ughr97TehaOG7NwJ0QCjLMWwWTnog=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=E1mdURy9i4tXrR/uzVBp4xdGJqeFkXrVFI3C3uj3gfPWHtyTrM+65weldWYFFayoP
         WIoeEhYD4pBhe22y86uZqHurJbfG4bnUSQEI+8uZA6CadsaZPhqsXqvU+XfgwU/efu
         mgCNfFc9O8kLTkyjXYCGkF0gXgjOGkMxLtr+SVvc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200813025308epcas1p13262255658a8ea7d09bed57c07af4b87~qtDw1xbMr2939229392epcas1p1k;
        Thu, 13 Aug 2020 02:53:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BRrjH3VlxzMqYm2; Thu, 13 Aug
        2020 02:53:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.1E.28581.31BA43F5; Thu, 13 Aug 2020 11:53:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200813025306epcas1p359c49c1668e81716dfc9055fc234e657~qtDvSSYDS2388023880epcas1p3M;
        Thu, 13 Aug 2020 02:53:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200813025306epsmtrp21bc505bb706af3aea140c0579b5419d6~qtDvRibw02473124731epsmtrp2e;
        Thu, 13 Aug 2020 02:53:06 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-93-5f34ab13597c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.A8.08382.21BA43F5; Thu, 13 Aug 2020 11:53:06 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200813025306epsmtip12f911e2ce7e705e3ef9d43c54060848a~qtDvIN64K2150121501epsmtip1u;
        Thu, 13 Aug 2020 02:53:06 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <ed561c17-3b85-9bf1-e765-5d9a15786585@gmail.com>
Subject: RE: [PATCH 1/2] exfat: add NameLength check when extracting name
Date:   Thu, 13 Aug 2020 11:53:06 +0900
Message-ID: <001001d6711c$def48c80$9cdda580$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGPHLM6XNMdYK+OwXwRZrdCO4AVLgGp1IjqAWFBSrABxrnHLamdZzLg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmga7wapN4g6atEhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tl
        aGBgZApUmZCTMXnKT/aCo4IVr390sDQwruPrYuTkkBAwkXjWt4ipi5GLQ0hgB6PE2z2vWCGc
        T4wSC05fZIdwvjFKbNm8mxmm5dKaTcwQib2MElv79jJCOC8ZJfraJ7GBVLEJ6Er8+7MfzBYR
        0JM4efI6G0gRs0Ajk8TyE1/ARnEK2EqsfLqOEcQWFvCU2NY6mRXEZhFQlfi27j/QVRwcvAKW
        Em/3BoGEeQUEJU7OfMICYjMLyEtsfzsH6iIFiZ9Pl7FC7HKT+HLzJiNEjYjE7M42sEslBBZy
        SLxtu8sO0eAicXjLPxYIW1ji1fEtUHEpic/v9rKB7JUQqJb4uB9qfgejxIvvthC2scTN9RtY
        QUqYBTQl1u/ShwgrSuz8PRdqLZ/Eu689rBBTeCU62oQgSlQl+i4dZoKwpSW62j+wT2BUmoXk
        sVlIHpuF5IFZCMsWMLKsYhRLLSjOTU8tNiwwQY7sTYzgdKplsYNx7tsPeocYmTgYDzFKcDAr
        ifAyXzaOF+JNSaysSi3Kjy8qzUktPsRoCgzpicxSosn5wISeVxJvaGpkbGxsYWJmbmZqrCTO
        +/CWQryQQHpiSWp2ampBahFMHxMHp1QDU1vSNd+Fe3VZH0w/XzT3/ZZTLB3d51atsVe+madj
        0qxjc/T1meLFe4IUe3r9yr2WMc189E3RuH395qM3EpfdzdgQVSjS9+TR/IVp3Is3GUx5yVby
        pZFVae7zs0tOS7x/abjobCPDcaOt02f7/blb8nrXX71bn9YVsXvaZhy5XbImPLLU4Nmhna4T
        NU7EyrS0tqnMqImTePqle9tJk+b7UhqfuvinMMp3mF0UrNTokljcG3azXWE/s3GBaKbWiqTe
        ycuWr//HMU8saVe9y8mtAX+/SMp8+BPZfv3ucQmNvbM8PaJfp960qmi/mzFpv69rf4PrCnPm
        rKXTbb8wLZDjOugxiU96tsqtt0Em3sUVS5RYijMSDbWYi4oTAVtd+fAwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTldotUm8Qd9jQ4sfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEVx2aSk5mSWpRbp2yVwZUye8pO94KhgxesfHSwNjOv4uhg5OSQETCQurdnE3MXI
        xSEksJtR4uv8N8wQCWmJYyfOANkcQLawxOHDxRA1zxkl5kx6CFbDJqAr8e/PfjYQW0RAT+Lk
        yetsIEXMAs1MEt+eLYGa+oJR4tuc2awgVZwCthIrn65jBLGFBTwltrVOBouzCKhKfFv3nwlk
        G6+ApcTbvUEgYV4BQYmTM5+wgNjMAtoSvQ9bGSFseYntb+dAHaog8fPpMlaII9wkvty8CVUj
        IjG7s415AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/d
        xAiOLC3NHYzbV33QO8TIxMF4iFGCg1lJhJf5snG8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4b
        hQvjhATSE0tSs1NTC1KLYLJMHJxSDUwb3e9ruRanKblsf8DDqsa1IGBqyul95qLTT/Ja8qxf
        Jpemt/GE5K3KApbtB5d/3L31lte2nrrzEakTt547EzA5Jbzue/YFt+izW+ziDDIMjzdkOD/7
        +kdo/uYfwdsbS1auO7Tvbml36E+5nRMfaPBbe3P89EqNmZew5a/bXqZVd3rasvqtOfvu3gnn
        nvItg/mva3FpgGWur8R7+b0qSRs+T/daHWOXc09V8UTk/74l7xzDVp/hfHFrzYGJS+6/msom
        a1NhEG/W9EJnz162nxWZJxamFJx66aRpcW7Luo9Vh3hdjp54+iSZU/DO427H/9oi2mYawV72
        Fx1WykxadHR9CvvZaZM4p/6cL2m5ZlGLEktxRqKhFnNRcSIAJaHdGBsDAAA=
X-CMS-MailID: 20200813025306epcas1p359c49c1668e81716dfc9055fc234e657
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806055718epcas1p1763d92dbf47e2a331a74d0bb9ea03c15
References: <CGME20200806055718epcas1p1763d92dbf47e2a331a74d0bb9ea03c15@epcas1p1.samsung.com>
        <20200806055653.9329-1-kohada.t2@gmail.com>
        <003d01d66edd$5baf4810$130dd830$@samsung.com>
        <ed561c17-3b85-9bf1-e765-5d9a15786585@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thank you for your reply.
> 
> >> -static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
> >> -		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
> >> +static int exfat_get_uniname_from_name_entries(struct exfat_entry_set_cache *es,
> >> +		struct exfat_uni_name *uniname)
> >>   {
> >> -	int i;
> >> -	struct exfat_entry_set_cache *es;
> >> +	int n, l, i;
> >>   	struct exfat_dentry *ep;
> >>
> >> -	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
> >> -	if (!es)
> >> -		return;
> >> +	uniname->name_len = es->de_stream->name_len;
> >> +	if (uniname->name_len == 0)
> >> +		return -EIO;
> > Can we validate ->name_len and name entry ->type in exfat_get_dentry_set() ?
> 
> Yes.
> As I wrote in a previous email, entry type validation, name-length validation, and name extraction
> should not be separated, so implement all of these in exfat_get_dentry_set().
> It can be easily implemented by adding uniname to exfat_entry_set_cache and calling
> exfat_get_uniname_from_name_entries() from exfat_get_dentry_set().
No, We can check stream->name_len and name entry type in exfat_get_dentry_set().
And you are already checking entry type with TYPE_SECONDARY in
exfat_get_dentry_set(). Why do we have to check twice?

>
> However, that would be over-implementation.
> Not all callers of exfat_get_dentry_set() need a name.
Where? It will not checked with ES_2_ENTRIES.

> It is enough to validate the name when it is needed.
> This is a file-system driver, not fsck.
Sorry, I don't understand what you are talking about. If there is a problem
in ondisk-metadata, Filesystem should return error.

> Validation is possible in exfat_get_dentry_set(), but unnecessary.
> 
> Why do you want to validate the name in exfat_get_dentry_set()?
exfat_get_dentry_set validates file, stream entry. And you are trying to check
name entries with type_secondary. In addition, trying add the checksum check.
Conversely, Why would you want to add those checks to exfat_get_dentry_set()?
Why do we check only name entries separately? Aren't you intent to return
validated entry set in exfat_get_dentry_set()?
> 
> 
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>

