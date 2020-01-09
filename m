Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093AF1363B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgAIXVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:21:42 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22029 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:21:40 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200109232137epoutp01cb990eca551160596f84024be65073bd~oW1a9Vi8y3247832478epoutp01M
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:21:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200109232137epoutp01cb990eca551160596f84024be65073bd~oW1a9Vi8y3247832478epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578612097;
        bh=T+CeYd6IFZglOI4g+diQBYqoYYrYS/DvRp1wf9ehhSs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Y89hp8wXi3HKHGbnfbukvhKOGw0y6ZIwjNpfEuMTenrcuONm8E7Y9aALJfH9Gg2Gv
         EXZXbYYfyR+4AXid68qxUrZ4dAoY2+gWiZzQagaD0HI6v3whYsVnYAPz4JRMkIhLoN
         U468v4hMl1AZOlN05yWnwJWzblo4K9WoTKji7sZc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200109232137epcas1p4e338856c504cd9f67eadc4b1600deba4~oW1asrb5-0706907069epcas1p4I;
        Thu,  9 Jan 2020 23:21:37 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47v2Dw1YPYzMqYkg; Thu,  9 Jan
        2020 23:21:36 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.FA.48498.085B71E5; Fri, 10 Jan 2020 08:21:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200109232135epcas1p31123857fc9cec29067aafda53561683b~oW1ZbZY1t0707807078epcas1p3i;
        Thu,  9 Jan 2020 23:21:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109232135epsmtrp10c9724d2abb16adff1ebe63cb7e3fd4d~oW1ZasjBv1664216642epsmtrp1k;
        Thu,  9 Jan 2020 23:21:35 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-b3-5e17b580f5cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.46.10238.F75B71E5; Fri, 10 Jan 2020 08:21:35 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109232135epsmtip139602e5d66cf9aabfc8b266346cb88c9~oW1ZRA59Z1335813358epsmtip1c;
        Thu,  9 Jan 2020 23:21:35 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        <pali.rohar@gmail.com>
In-Reply-To: <20200108172135.GC13388@lst.de>
Subject: RE: [PATCH v9 02/13] exfat: add super block operations
Date:   Fri, 10 Jan 2020 08:21:35 +0900
Message-ID: <001701d5c743$8945ffe0$9bd1ffa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwKPpVYaAeKSrnsCTHWGIqa0Uqbw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmgW7DVvE4g/f97BbNi9ezWaxcfZTJ
        4vrdW8wWe/aeZLG4vGsOm8XE07+ZLLb8O8Jqcen9BxYHDo+ds+6ye+yfu4bdY/fNBjaPvi2r
        GD0+b5LzOLT9DVsAW1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QQUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAkODAr3ixNzi0rx0
        veT8XCtDAwMjU6DKhJyMZU0rWAuu8FRsXDqZuYHxIWcXIyeHhICJxL+/85m6GLk4hAR2MEq8
        PXyKESQhJPCJUeLFLEEI+xujxN8pojANza9WM0I07GWUuLihkQ3Ceckose/QFFaQKjYBXYl/
        f/azgdgiAmoSZ362sYMUMQucYpT4v3UiWIJTQEfi+LUZQAkODmEBe4mODZIgYRYBVYkDvd3s
        IDavgKXEotdPoGxBiZMzn7CA2MwC8hLb385hhrhIQeLn02WsELvcJFa1TWCDqBGRmN3Zxgyy
        V0KgnV1iwuzjTBANLhKHm0+wQdjCEq+Ob2GHsKUkXva3gd0jIVAt8XE/1PwOYEh8t4WwjSVu
        rt/AClLCLKApsX6XPkRYUWLn77mMEGv5JN597WGFmMIr0dEmBFGiKtF36TDUAdISXe0f2Ccw
        Ks1C8tgsJI/NQvLALIRlCxhZVjGKpRYU56anFhsWGCFH9SZGcFLVMtvBuOiczyFGAQ5GJR7e
        DGHxOCHWxLLiytxDjBIczEoivEdviMUJ8aYkVlalFuXHF5XmpBYfYjQFhvtEZinR5Hxgws8r
        iTc0NTI2NrYwMTM3MzVWEufl+HExVkggPbEkNTs1tSC1CKaPiYNTqoGxqdGDlfvuha75z0Ju
        SbXkTK7/WF4/4+HcH1ZXyi7+CWO+Nu39msIzL3Zcmf8/uvFD0iHH5RaPxXR+/UwMXdlz5/T6
        hVsfXF7hdNj13qOXmotCfHqvbUoV2xjv+ip/5vX2YA2jjq7Um37bc5ncBbfULNeu+xzJfuz2
        FZVLH2V+uiS/SVfhkY06qMRSnJFoqMVcVJwIAM5KO+/AAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnG79VvE4gwfd+hbNi9ezWaxcfZTJ
        4vrdW8wWe/aeZLG4vGsOm8XE07+ZLLb8O8Jqcen9BxYHDo+ds+6ye+yfu4bdY/fNBjaPvi2r
        GD0+b5LzOLT9DVsAWxSXTUpqTmZZapG+XQJXxrKmFawFV3gqNi6dzNzA+JCzi5GTQ0LARKL5
        1WrGLkYuDiGB3YwSiy5PYoRISEscO3GGuYuRA8gWljh8uBgkLCTwnFHi4nlBEJtNQFfi35/9
        bCC2iICaxJmfbewgc5gFLjFKTOhtYoYYep9RYv+BmSwgVZwCOhLHr81gBxkqLGAv0bFBEiTM
        IqAqcaC3mx3E5hWwlFj0+gmULShxcuYTFpByZgE9ibaNYKcxC8hLbH87hxniTAWJn0+XsULc
        4Caxqm0CG0SNiMTszjbmCYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCYl1quV5yY
        W1yal66XnJ+7iREcXVqaOxgvL4k/xCjAwajEw5shLB4nxJpYVlyZe4hRgoNZSYT36A2xOCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY45N7Mw4/ez0r
        3O/D4ZbP/f+mWD5z7Gi1l7934/2nn99P/fK8eoV7V+6T4PisGfvfOX56cPHHkeT5ooYfrNvd
        JnvGl1o3rtpkcvSW1ZQJgZHPD+1acP5+1U0Zof0tpff3/z5Y0rgqkP3glZ2HTr2rz5ysHlLM
        M2FpMKfDpeaSqZmxmnYlgXc6JyqxFGckGmoxFxUnAgA7vmGHqgIAAA==
X-CMS-MailID: 20200109232135epcas1p31123857fc9cec29067aafda53561683b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082401epcas1p2f33f3c11ecedabff2165ba216854d8fe
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082401epcas1p2f33f3c11ecedabff2165ba216854d8fe@epcas1p2.samsung.com>
        <20200102082036.29643-3-namjae.jeon@samsung.com>
        <20200108172135.GC13388@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Looks good, modulo a few nitpicks below:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!
> 
> On Thu, Jan 02, 2020 at 04:20:25PM +0800, Namjae Jeon wrote:
> > +static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf) {
> > +	struct super_block *sb = dentry->d_sb;
> > +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> > +	unsigned long long id = huge_encode_dev(sb->s_bdev->bd_dev);
> 
> > +	if (sbi->used_clusters == ~0u) {
> 
> Various other places use UINT_MAX here instead.  Maybe it makes sense to
> add a EXFAT_CLUSTERS_UNTRACKED or similar define and use that in all
> places?
Okay.
> 
> > +	if ((new_flag == VOL_DIRTY) && (!buffer_dirty(sbi->pbr_bh)))
> 
> No need for both sets of inner braces.
Yep.
> 
> > +static bool is_exfat(struct pbr *pbr) {
> > +	int i = MUST_BE_ZERO_LEN;
> > +
> > +	do {
> > +		if (pbr->bpb.f64.res_zero[i - 1])
> > +			break;
> > +	} while (--i);
> > +	return i ? false : true;
> > +}
> 
> I find the MUST_BE_ZERO_LEN a little weird here.  Maybe that should be
> something like PBP64_RESERVED_LEN?
Okay.

> 
> Also I think this could be simplified by just using memchr_inv in the
> caller
> 
> 	if (memchr_inv(pbr->bpb.f64.res_zero, 0,
> 			sizeof(pbr->bpb.f64.res_zero)))
> 		ret = -EINVAL;
> 		goto free_bh;
> 	}
Okay.
> 
> > +	/* set maximum file size for exFAT */
> > +	sb->s_maxbytes = 0x7fffffffffffffffLL;
> 
> That this is setting the max size is pretty obvious.  Maybe the comment
> should be updated to mention how this max file size is calculated?
I will add the comment.

Thanks for your review!

