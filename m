Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673091A190B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 02:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDHADe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 20:03:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:30224 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDHADb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:03:31 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200408000329epoutp01f9bec96d5b6c619334050690ea9e5e4d~Dr0YPdalD0168701687epoutp01h
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2020 00:03:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200408000329epoutp01f9bec96d5b6c619334050690ea9e5e4d~Dr0YPdalD0168701687epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586304209;
        bh=hRyF0c6ns7OABMuq4l3TMMIsYeGkkkYf4TLQqHrU0tU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=eMoQ2oPLogBZcfOw8sqcJrZ5YhpdXc16cfgc2AvaGWVddkkXLZEVHQOu9ci592FZB
         npMUO9GPlNIjvK/gxECCqB1mEELujHKx+B5zltt2Vu62PM34blMcz4xyb1faphT7I+
         vREDCHDo1bCp3Xp9JBNquVqvuK8WbPtQCzSefzbU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200408000328epcas1p3bc5d69616107d6f6f20b9ae70e0e26bd~Dr0X9YE2T1873418734epcas1p3M;
        Wed,  8 Apr 2020 00:03:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48xky801CVzMqYks; Wed,  8 Apr
        2020 00:03:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.6B.04658.FC41D8E5; Wed,  8 Apr 2020 09:03:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200408000327epcas1p4f4695df4b40c53f5e87704174d8e2669~Dr0Ww3QRY2207822078epcas1p42;
        Wed,  8 Apr 2020 00:03:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200408000327epsmtrp2d3b3e66f0922ee375ad2da070f5ca290~Dr0WwBrmi2890328903epsmtrp28;
        Wed,  8 Apr 2020 00:03:27 +0000 (GMT)
X-AuditID: b6c32a39-a81ff70000001232-32-5e8d14cf1263
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.D6.04158.FC41D8E5; Wed,  8 Apr 2020 09:03:27 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200408000327epsmtip2519a8b17fb5837d0a7a07b8c8803081d~Dr0Wm5h8m3058830588epsmtip2d;
        Wed,  8 Apr 2020 00:03:27 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200407083410.79154-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: RE: [PATCH] exfat: remove 'bps' mount-option
Date:   Wed, 8 Apr 2020 09:03:27 +0900
Message-ID: <001301d60d39$212ccf10$63866d30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQICYKfYu26zgRX3njdSPq1gDqANSAEqKKnpqAxejhA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmru55kd44g/snzC3enJzKYrFn70kW
        i8u75rBZXP7/icVi2ZfJLBZb/h1hdWDz+DLnOLtH2+R/7B7Nx1ayefRtWcXo8XmTXABrVI5N
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIxP
        81vYCvo4KvqOX2RsYLzI1sXIySEhYCKx9MJ2pi5GLg4hgR2MEtduTGKBcD4xShxt+cIG4Xxj
        lDhxZi1cy9wZS9khEnsZJfr39UI5Lxklfs5exQRSxSagK/Hvz36wDhEBd4k1534ygxQxC5xn
        lJgw4R+Qw8HBKRAksfujKUiNsICpxIwL7WC9LAIqEs3TfoD18gpYSnzp/8kCYQtKnJz5BMxm
        FpCX2P52DjPERQoSP58uY4XYZSUxr+k/M0SNiMTszjawvRICr9kkup9eZQXZKyHgIjHlvg5E
        r7DEq+Nb2CFsKYnP7/ayQZRUS3zcDzW+g1HixXdbCNtY4ub6DWBTmAU0Jdbv0ocIK0rs/D2X
        EWIrn8S7rz1Qi3glOtqEIEpUJfouHWaCsKUluto/sE9gVJqF5K9ZSP6aheT+WQjLFjCyrGIU
        Sy0ozk1PLTYsMEWO602M4MSpZbmD8dg5n0OMAhyMSjy8DxJ74oRYE8uKK3MPMUpwMCuJ8Er1
        dsYJ8aYkVlalFuXHF5XmpBYfYjQFBvtEZinR5HxgUs8riTc0NTI2NrYwMTM3MzVWEuedej0n
        TkggPbEkNTs1tSC1CKaPiYNTqoGx+KRR1qzqHaoNLi7lMQvdljS8a7irYCR/eV1an/svNd6Y
        T2ftjnx0qMqzjZt3LsznT9LJ0Fbd1ycYwzn481Ztig5T1RARKPl6y6et+bfrkt3nJzlVSoYU
        XpJbWGx2M2aVQkvc/NsfWnsMJy/23cU03XsNV76l9OezvTOLL/9uOea1r2uWdZASS3FGoqEW
        c1FxIgB0MRDosgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXve8SG+cwb8ryhZvTk5lsdiz9ySL
        xeVdc9gsLv//xGKx7MtkFost/46wOrB5fJlznN2jbfI/do/mYyvZPPq2rGL0+LxJLoA1issm
        JTUnsyy1SN8ugSvj0/wWtoI+joq+4xcZGxgvsnUxcnJICJhIzJ2xlL2LkYtDSGA3o8THC7OZ
        IRLSEsdOnAGyOYBsYYnDh4tBwkICzxklnp0VAbHZBHQl/v3ZDzZHRMBdYs25n8wgc5gFLjJK
        /D+3jg1i6GJGiQmfnzOCDOIUCJLY/dEUpEFYwFRixoV2JhCbRUBFonnaD7BBvAKWEl/6f7JA
        2IISJ2c+YQFpZRbQk2jbyAgSZhaQl9j+dg7UmQoSP58uY4W4wUpiXtN/ZogaEYnZnW3MExiF
        ZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4frS0djCe
        OBF/iFGAg1GJh/dBYk+cEGtiWXFl7iFGCQ5mJRFeqd7OOCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MrKp2/BFyST7txwzcjj/4UKjRMv1sEsNmT+33
        YrPUG15Km9pseNRnuvylwWwZI+MXU57vmrbi68urAXm2a3fuYXp8rujH3thM5tVbqhtimY1t
        FlqWHYg887b+/sa+3F8zb5XdrDul5RF/cq1wyParyhdPJVkl3n8x1cz+i5OrxzStEMMP72e5
        K7EUZyQaajEXFScCAEgKzsCbAgAA
X-CMS-MailID: 20200408000327epcas1p4f4695df4b40c53f5e87704174d8e2669
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200407083445epcas1p243e93ccad42ed28249356d01bbe8bc7d
References: <CGME20200407083445epcas1p243e93ccad42ed28249356d01bbe8bc7d@epcas1p2.samsung.com>
        <20200407083410.79154-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> remount fails because exfat_show_options() returns unsupported option
> 'bps'.
> > # mount -o ro,remount
> > exfat: Unknown parameter 'bps'
> 
> To fix the problem, just remove 'bps' option from exfat_show_options().
> 
> Signed-off-by: Tetsuhiro Kohada
> <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
I will apply your patches after setting up exfat git tree.

Thanks for your work!
> ---
>  fs/exfat/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> 2dd62543a4..1b7d2eb034 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -151,7 +151,6 @@ static int exfat_show_options(struct seq_file *m,
> struct dentry *root)
>  		seq_puts(m, ",iocharset=utf8");
>  	else if (sbi->nls_io)
>  		seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
> -	seq_printf(m, ",bps=%ld", sb->s_blocksize);
>  	if (opts->errors == EXFAT_ERRORS_CONT)
>  		seq_puts(m, ",errors=continue");
>  	else if (opts->errors == EXFAT_ERRORS_PANIC)
> --
> 2.25.0


