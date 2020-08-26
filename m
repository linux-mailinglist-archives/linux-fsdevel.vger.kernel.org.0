Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1C2524F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHZBMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 21:12:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44110 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHZBMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:12:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200826010315epoutp040fd9b4ae63fb762ae0ecf028ca123b04~uq8iUVqgK1584415844epoutp04B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 01:03:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200826010315epoutp040fd9b4ae63fb762ae0ecf028ca123b04~uq8iUVqgK1584415844epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598403795;
        bh=GArVnUQlfGs75UJ6SGWrUgWlyvN3uE4bsrDRJWD991Q=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nA68HLMrNwUT90gpV/gL4cK1YOyqISHeFVr4Uh7VIuNTmC0GtrekNUrWokazh8z+m
         5thI7llF4dMwSr9kOkgWAi/CNqdYm3Q/q5OdesF9GAcPCkVZeEhZ4E0dADc0OU2efK
         M3cTHlUKml2ZFZ372li7cJADwNxm89OQ8Kk8A908=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200826010315epcas1p1f23fe85bb12878fcb63d995541324379~uq8iClkD42321123211epcas1p1p;
        Wed, 26 Aug 2020 01:03:15 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BbnfV3GGszMqYkZ; Wed, 26 Aug
        2020 01:03:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.69.18978.1D4B54F5; Wed, 26 Aug 2020 10:03:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200826010313epcas1p1e1df3c0235f84b2dbc1bd6eaa770ca88~uq8f7yREE2321123211epcas1p1m;
        Wed, 26 Aug 2020 01:03:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200826010313epsmtrp1652abb59429cc427b0ee9e93510a7e86~uq8f7H3kP0915909159epsmtrp1V;
        Wed, 26 Aug 2020 01:03:13 +0000 (GMT)
X-AuditID: b6c32a35-b8298a8000004a22-75-5f45b4d1c9cf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.CB.08382.0D4B54F5; Wed, 26 Aug 2020 10:03:13 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200826010312epsmtip177affdc1e9bc98b957a90900e74f4edd~uq8fuQZVM0946209462epsmtip1a;
        Wed, 26 Aug 2020 01:03:12 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <fdaff3a3-99ba-8b9e-bdaf-9bcf9d7208e0@gmail.com>
Subject: RE: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Wed, 26 Aug 2020 10:03:13 +0900
Message-ID: <000101d67b44$ac458c80$04d0a580$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6G9isXEQ9sMxkt33jRW4ItYjr3QIF0gSvAfjtwRwBp6Lp0QLf0PstAjwGXzmorDU8MA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmge7FLa7xBm+65S1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEn482jDywFF/grJs58zNjAuJWni5GTQ0LAROL/tYnsXYxcHEICOxgl5l6YyArh
        fGKUaLt5jwnC+cYoseHcNmaYlidtE1kgEnsZJVbsW8II4bxklLhzZRM7SBWbgK7Evz/72UBs
        EQE9iZMnr7OBFDELNDJJLD/xBWwUp4CtxMt5U4BsDg5hAS+Jeb1SIGEWAVWJhxv2gZXwClhK
        rL1zmAXCFpQ4OfMJmM0sIC+x/e0cqIsUJH4+XcYKsStMom9pBztEjYjE7M42ZpC9EgILOSRW
        7/jNBtHgItFxpJcFwhaWeHV8CzuELSXxsr+NHeQeCYFqiY/7oeZ3MEq8+G4LYRtL3Fy/gRWk
        hFlAU2L9Ln2IsKLEzt9zGSHW8km8+9rDCjGFV6KjTQiiRFWi79JhJghbWqKr/QP7BEalWUge
        m4XksVlIHpiFsGwBI8sqRrHUguLc9NRiwwJD5MjexAhOp1qmOxgnvv2gd4iRiYPxEKMEB7OS
        CK/gRed4Id6UxMqq1KL8+KLSnNTiQ4ymwKCeyCwlmpwPTOh5JfGGpkbGxsYWJmbmZqbGSuK8
        D28pxAsJpCeWpGanphakFsH0MXFwSjUw5ffFHyxkdI567Hskvdf3R3PDDS25hUfZE2dttwxJ
        vb7Q37Ow++T+ukau5dxa83x/nd4snFX1Vlpr5Wabxry3ixceq5Dz7NI+MMl5t9M8jVop7Vub
        fr7r2T9N+KHtWZ5qW77oj/fmrmbhn1Am35KY9j4s4HSw9sTeim9xCUc/L/v6rWKFyc+M/49V
        fIJf3lhVVLGtj4P98a+0aXu3G4g+rDkmVHPwRNPzQ9M7HD3muc+fayhsNN+yO6H39xVpeU71
        o/nvj73n3XzoguvpjK3BexrTf1pGbv7YdnCqvEfniRNstivWtc1WUFrFuG1d9yOeaUvana99
        ehZU1KlldPxA2d7Nj5PL7dX1W37P3N1crMRSnJFoqMVcVJwIADjAygQwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTvfiFtd4g29TmC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlfHm0QeWggv8FRNnPmZsYNzK08XIySEhYCLxpG0iSxcj
        F4eQwG5Gia3725kgEtISx06cYe5i5ACyhSUOHy6GqHnOKLG78wFYDZuArsS/P/vZQGwRAT2J
        kyevs4EUMQs0M0l8e7aEGaLjBJPE14WdrCBVnAK2Ei/nTQGbKizgJTGvVwokzCKgKvFwwz5m
        EJtXwFJi7Z3DLBC2oMTJmU/AbGYBbYmnN59C2fIS29/OYYY4VEHi59NlrBBHhEn0Le1gh6gR
        kZjd2cY8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+du
        YgRHlpbmDsbtqz7oHWJk4mA8xCjBwawkwit40TleiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+N
        woVxQgLpiSWp2ampBalFMFkmDk6pBqaOFV0mf/Z53Qg7W3mqWnrqzveRO2boxh58YRmrNevO
        sWZW5gm2O9Uc7vZGfVDW+P1ulYbkfNaEx5wVglvnPjzR9mOWgsfroj6336unqsQUzz7xxcVf
        L3xv/wWxuZ4PG1Q+RM6W33bth8T1xQ1KYs8yNFQYDO5K7SutVzJnusTk986M9WUJz4+eB7M+
        FP6Zk7F3Q8LfOUIm6WVSrZYpVyTCmp77XbdoNeBwORJ5uX7tVGZ2jv0sn5xyN8rN2bvvDBNX
        KG/j+8185ok2qleXPs/XSs1cFiUtc4H7us4HTg8W3+bny+2ja9LXX+l4zcq6hvtO4IcKB5Gz
        1z5Hnwtl+2W3OLLG9fzsuXEibG/rliqxFGckGmoxFxUnAgDH553jGwMAAA==
X-CMS-MailID: 20200826010313epcas1p1e1df3c0235f84b2dbc1bd6eaa770ca88
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Second: Range validation and type validation should not be separated.
> When I started making this patch, I intended to add only range validation.
> However, after the caller gets the ep, the type validation follows.
> Get ep, null check of ep (= range verification), type verification is a series of procedures.
> There would be no reason to keep them independent anymore.
> Range and type validation is enforced when the caller uses ep.
You can add a validate flags as argument of exfat_get_dentry_set(), e.g. none, basic and strict.
none : only range validation.
basic : range + type validation.
strict : range + type + checksum and name length, etc.
 
> > -	/* validiate cached dentries */
> > -	for (i = 1; i < num_entries; i++) {
> > -		ep = exfat_get_dentry_cached(es, i);
> > -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> > +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
> > +	if (!ep || ep->type != EXFAT_STREAM)
> > +		goto free_es;
> > +	es->de[ENTRY_STREAM] = ep;
> 
> The value contained in stream-ext dir-entry should not be used before validating the EntrySet checksum.
> So I would insert EntrySet checksum validation here.
> In that case, the checksum verification loop would be followed by the TYPE_NAME verification loop, can
> you acceptable?
Yes. That would be great.

Thanks!
> 
> 
> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> > 44dc04520175..0e4cc8ba2f8e 100644
> > --- a/fs/exfat/exfat_fs.h
> > +++ b/fs/exfat/exfat_fs.h
> > @@ -33,6 +33,12 @@ enum {
> >   	NLS_NAME_OVERLEN,	/* the length is over than its limit */
> >   };
> >
> > +enum {
> > +	ENTRY_FILE,
> > +	ENTRY_STREAM,
> > +	ENTRY_NAME,
> > +};
> 
> This is necessary!
> With this, some magic numbers will be gone.
> But, I think it's better to use a name that can be recognized as an offset/index in the EntrySet.
> And, I think it's better to define this in "exfat_raw.h"
Okay, You can rename it and move it to there.

