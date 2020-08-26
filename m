Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADD25287B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHZHcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 03:32:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53315 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgHZHcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:32:11 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200826073207epoutp040ee1ffd422dcf0d593b07c3e10c0d7b6~uwQD0CbA-0653606536epoutp04L
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 07:32:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200826073207epoutp040ee1ffd422dcf0d593b07c3e10c0d7b6~uwQD0CbA-0653606536epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598427127;
        bh=5HnYi4RTlc9KvdaHm873eIAyqLO0uup3opJXskAVJrs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=KK1lpo4m+WnkgBIvOzy0OXN8C9SdqeVZcp3w0JDt7XQiwSECEapPiXudHedbBeFBl
         a6sJAvwonbSvDX6IBv7tkns/NkBwtlyOZYv3WHteq5n1Zwqu333zHYNr1aBFdWjHra
         ts3jz9+y2+SYZBjAj5FRG9VEm4uDdnGy6GoXi5mE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826073207epcas1p2856243e5f6678a053df21d23ac7d26a4~uwQDhN7DM0700107001epcas1p2T;
        Wed, 26 Aug 2020 07:32:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BbyHB1wLHzMqYkg; Wed, 26 Aug
        2020 07:32:06 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.95.19033.5FF064F5; Wed, 26 Aug 2020 16:32:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200826073205epcas1p44e8b8ca54b87f7f2d9d89e9bb96715b7~uwQBg1G1U0949809498epcas1p4j;
        Wed, 26 Aug 2020 07:32:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200826073204epsmtrp2b6fdd810ab359e8d238f5922693b25bc~uwQBT-IKT1610816108epsmtrp28;
        Wed, 26 Aug 2020 07:32:04 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-c1-5f460ff5d8d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.1E.08382.4FF064F5; Wed, 26 Aug 2020 16:32:04 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200826073204epsmtip18116d0fe99524d2ba5ecda9943635022~uwQBFf2ys2892328923epsmtip1p;
        Wed, 26 Aug 2020 07:32:04 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <7d7ec460-b5ab-68da-658b-2104f393b4e8@gmail.com>
Subject: RE: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Wed, 26 Aug 2020 16:32:04 +0900
Message-ID: <004301d67b7a$ff0dcf50$fd296df0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6G9isXEQ9sMxkt33jRW4ItYjr3QIF0gSvAfjtwRwBp6Lp0QLf0PstAjwGXzkCQUE62QDGw52qAUD18EYBLf0H56iA6BpA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmnu5Xfrd4g2/bjSx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEno6HhL3vBecmKByufMDUwXhbpYuTkkBAwkZjw7BtjFyMXh5DADkaJD7vmM0E4
        nxglHnVeYAOpEhL4xijx968rTEfn/GtQRXsZJR7O3wzlvGSUWPvnDBNIFZuArsS/P/vBukUE
        9CROnrzOBlLELNDIJLH8xBdmkASngK3Eh5W7gBIcHMICXhLzeqVAwiwCqhK7tsxjBbF5BSwl
        Fr9ogbIFJU7OfMICYjMLyEtsfzuHGeIiBYmfT5exQuzKk/izfQ9UjYjE7M42ZpC9EgILOST+
        PfnLCNHgIvHx/QkmCFtY4tXxLewQtpTE53d7we6REKiW+Lgfan4Ho8SL77YQtrHEzfUbWEFK
        mAU0Jdbv0ocIK0rs/D2XEWItn8S7rz2sEFN4JTrahCBKVCX6Lh2GWiot0dX+gX0Co9IsJI/N
        QvLYLCQPzEJYtoCRZRWjWGpBcW56arFhgRFyXG9iBCdTLbMdjJPeftA7xMjEwXiIUYKDWUmE
        V/Cic7wQb0piZVVqUX58UWlOavEhRlNgUE9klhJNzgem87ySeENTI2NjYwsTM3MzU2Mlcd6H
        txTihQTSE0tSs1NTC1KLYPqYODilGpjCJ2Snxgq91D9/J3h3YAt/S+s+KUlv32lHMp7N3cKZ
        7Ft/5vhensl/pVJ+Fc0pKI5KsImqNd76/WrGKv36IzHSrmtfCn1Ml097sVbfI0bufaHdYzuH
        me66c2V7F/TO/3uqyT1fa/qx+CTvyjVKu95IpSo4fV/rY/cpvJjdYLb9M/bQnpseSv+7JGXa
        Vpav8T9T+D9Rbkcwx+S7IYblS78ZO500512fc3Ll+wL/uuJrnBdZ1oatO6Ktw3fD1Id59qNV
        FUEmfhsZM4/fWz+9V+INh+5frWnOC1z9PkcwROl3cF8y9pMRsD3o+lwy7D1ztunTX4037rdx
        tsjqf5VcuHQ6C8umE2ovXsYFv3m+UYmlOCPRUIu5qDgRALSUv/QvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTvcLv1u8wdorhhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgymho+MtecF6y4sHKJ0wNjJdFuhg5OSQETCQ6519j6mLk
        4hAS2M0oMePlLRaIhLTEsRNnmLsYOYBsYYnDh4tBwkICzxklvuw3A7HZBHQl/v3ZzwZiiwjo
        SZw8eZ0NZA6zQDOTxLdnS5ghhraxSGw8+oQJpIpTwFbiw8pdbCBDhQW8JOb1SoGEWQRUJXZt
        mccKYvMKWEosftECZQtKnJz5BOweZgFtiac3n0LZ8hLb385hhrhTQeLn02WsEEfkSfzZvgeq
        RkRidmcb8wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yf
        u4kRHFdamjsYt6/6oHeIkYmD8RCjBAezkgiv4EXneCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        NwoXxgkJpCeWpGanphakFsFkmTg4pRqY1J/EzZCIdJVg8J+pujnC1MSSK1htH+dMPs/uojdC
        Nt6K7DzdQQd+XNuRNKvxGU/g8n77Yy1LY5l31x0vENkr2HP96pkXKjdj0tzDQ/1WeiQsDO9L
        /Z7CKBY2J1Iu5munadazN4FfzKOrHL4f7+dgN7jbKO7/NH576Xy5mYILHxt9NA4JUTTrvRn9
        +OvksPNzQ9ySmxc6zm1378hQvXDz8WqftdEzbSPUIh5cP/rhepjXL3OngEl5LJuOXhZ5HChy
        959hgtbLKzPOJb7hzee6ndKTGLJDjitI6g/TrfdLz0i+4FA+u3qG353Y+otXDD7+sgvfMldp
        CePDuRvlJVy71CxW6XZnBGiZak/s3qzEUpyRaKjFXFScCABNoCfZGgMAAA==
X-CMS-MailID: 20200826073205epcas1p44e8b8ca54b87f7f2d9d89e9bb96715b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e
References: <CGME20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e@epcas1p4.samsung.com>
        <20200806010229.24690-1-kohada.t2@gmail.com>
        <003c01d66edc$edbb1690$c93143b0$@samsung.com>
        <ca3b2b52-1abc-939c-aa11-8c7d12e4eb2e@gmail.com>
        <000001d67787$d3abcbb0$7b036310$@samsung.com>
        <fdaff3a3-99ba-8b9e-bdaf-9bcf9d7208e0@gmail.com>
        <000101d67b44$ac458c80$04d0a580$@samsung.com>
        <d1df9cca-3020-9e1e-0f3d-9db6752a22b6@gmail.com>
        <002e01d67b60$0b7d82a0$227887e0$@samsung.com>
        <7d7ec460-b5ab-68da-658b-2104f393b4e8@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thank you for quick reply!
> 
> On 2020/08/26 13:19, Namjae Jeon wrote:
> >> On 2020/08/26 10:03, Namjae Jeon wrote:
> >>>> Second: Range validation and type validation should not be separated.
> >>>> When I started making this patch, I intended to add only range validation.
> >>>> However, after the caller gets the ep, the type validation follows.
> >>>> Get ep, null check of ep (= range verification), type verification is a series of procedures.
> >>>> There would be no reason to keep them independent anymore.
> >>>> Range and type validation is enforced when the caller uses ep.
> >>> You can add a validate flags as argument of exfat_get_dentry_set(), e.g. none, basic and strict.
> >>> none : only range validation.
> >>> basic : range + type validation.
> >>> strict : range + type + checksum and name length, etc.
> >>
> >> Currently, various types of verification will not be needed.
> >> Let's add it when we need it.
> >>>
> >>>>> -	/* validiate cached dentries */
> >>>>> -	for (i = 1; i < num_entries; i++) {
> >>>>> -		ep = exfat_get_dentry_cached(es, i);
> >>>>> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> >>>>> +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
> >>>>> +	if (!ep || ep->type != EXFAT_STREAM)
> >>>>> +		goto free_es;
> >>>>> +	es->de[ENTRY_STREAM] = ep;
> >>>>
> >>>> The value contained in stream-ext dir-entry should not be used
> >>>> before validating the EntrySet
> >> checksum.
> >>>> So I would insert EntrySet checksum validation here.
> >>>> In that case, the checksum verification loop would be followed by
> >>>> the TYPE_NAME verification loop, can you acceptable?
> >>> Yes. That would be great.
> >>
> >> OK.
> >> I'll add TYPE_NAME verification after checksum verification, in next patch.
> >> However, I think it is enough to validate TYPE_NAME when extracting name.
> >> Could you please tell me why you think you need TYPE_NAME validation here?
> > I've told you on previous mail. This function should return validated
> > dentry set after checking
> > file->stream->name in sequence.
> 
> Yes. I understand that the current implementation checks in that order.
> Sorry, my question was unclear.
> Why do you think you should leave the TYPE_NAME validation in this function?
> What kind of problem are you worried about if this function does not validate TYPE_NAME?
> (for preserve the current behavior?)
We have not checked the problem when it is removed because it was implemented
according to the specification from the beginning. And your v3 patch are
already checking the name entries as TYPE_SECONDARY. And it check them with
TYPE_NAME again in exfat_get_uniname_from_ext_entry(). If you check TYPE_NAME
with stream->name_len, We don't need to perform the loop for extracting
filename from the name entries if stream->name_len or name entry is invalid.

And I request to prove why we do not need to validate name entries in this
function calling from somewhere. So as I suggested earlier, You can make it
with an argument flags so that we skip the validation.
> 
> Don't worry, I will add TYPE_NAME verification to the v4 patch.
> I will post it later today.
Sound good.
> 
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>

