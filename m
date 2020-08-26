Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427FD252612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 06:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgHZETO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 00:19:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11425 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHZETN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:19:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200826041911epoutp02114323767c8e12dd1edb069aa821d1ec~utnmsRxjW0362103621epoutp02T
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 04:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200826041911epoutp02114323767c8e12dd1edb069aa821d1ec~utnmsRxjW0362103621epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598415551;
        bh=vJGhhWEMdU4RI4OZUZrLMlmVOp+37EnHBm+2cAvft5A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ph/ow5Wb6ctfebKa9bR+c09dMz9TtuYryQxorG2i2pQNaegLp0iek93i2v+d9lMAq
         FcA2kzcV1OZ0razWq5DTKtwRCwrm8I/Dw/RqbnEpgGULEuo7cTBDsdTNTuPJTMoLkO
         q/hDvylasipMBqHVlWVllI/fA7SUBdhUvgjgpGGI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200826041911epcas1p19f1533c00e4fc98d69003ca85944f373~utnmSIz332055620556epcas1p1p;
        Wed, 26 Aug 2020 04:19:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Bbt0Y5g3pzMqYks; Wed, 26 Aug
        2020 04:19:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.68.28578.DB2E54F5; Wed, 26 Aug 2020 13:19:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200826041909epcas1p108db024e965f292c5b479a341bdd76b5~utnkjO58I2055620556epcas1p1l;
        Wed, 26 Aug 2020 04:19:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200826041909epsmtrp1204bee6a4dd0f9a97184e4fc19b014df~utnkimfOJ1440014400epsmtrp1O;
        Wed, 26 Aug 2020 04:19:09 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-91-5f45e2bd5169
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.A1.08303.DB2E54F5; Wed, 26 Aug 2020 13:19:09 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200826041908epsmtip2130885c172cdc3cfaf55c12035ad47be~utnkYYDEN2804828048epsmtip2G;
        Wed, 26 Aug 2020 04:19:08 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <d1df9cca-3020-9e1e-0f3d-9db6752a22b6@gmail.com>
Subject: RE: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Wed, 26 Aug 2020 13:19:09 +0900
Message-ID: <002e01d67b60$0b7d82a0$227887e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6G9isXEQ9sMxkt33jRW4ItYjr3QIF0gSvAfjtwRwBp6Lp0QLf0PstAjwGXzkCQUE62QDGw52qqJQvqBA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvu7eR67xBqdPaFv8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxsWtvxgLLvBXvLyxirWB8RBPFyMnh4SAicS1dxvYQGwhgR2MEqeuAsW5gOxP
        jBIr1y1ghnA+M0osfrKSBabj4fQmdojELkaJN7fOsUA4LxklDnfMYQKpYhPQlfj3Zz/YXBEB
        PYmTJ6+zgRQxCzQySSw/8QVoLgcHp4CtxIQOCxBTWMBLYl6vFEg5i4CqRP/ZQ6wgNq+ApcTF
        5mfsELagxMmZT8COYBaQl9j+dg4zxEEKEj+fLmOFWJUkcbtlIjNEjYjE7M42sA8kBBZySGye
        2cMI0eAicXXfDVYIW1ji1fEt7BC2lMTL/jZ2kHskBKolPu6Hmt/BKPHiuy2EbSxxc/0GVpAS
        ZgFNifW79CHCihI7f89lhFjLJ/Huaw8rxBReiY42IYgSVYm+S4eZIGxpia72D+wTGJVmIXls
        FpLHZiF5YBbCsgWMLKsYxVILinPTU4sNC0yRo3oTIziValnuYJz+9oPeIUYmDsZDjBIczEoi
        vIIXneOFeFMSK6tSi/Lji0pzUosPMZoCg3ois5Rocj4wmeeVxBuaGhkbG1uYmJmbmRorifM+
        vKUQLySQnliSmp2aWpBaBNPHxMEp1cCkrMFz3++pbdoSvvwJNwKTbqatevEkPXvqlBmuzFeO
        p3959HxWzbPMLcHlvVtObjx/pdkw317d2Wc586EdPpy6JRUfmconxET/+zhviryO0s5ZoufE
        lv/t+Xaia0FFq8XDyMhdm0vZ2ZZOY0kXamacHjPNe+d3x87ZXXtjW05XdM5xnfizIbV0hrtu
        6e2a5WcmZGbHbEjw4j4m+8h8vumF0sqVJ4TinzWdKQ5yXrGap+v/a4Wy9M1r2SYwi5ReX8N/
        ZZbQxnSeDfsaP+i7++gstN59ebOoXN3vxdsVXk5knlb3ovLxcvulx5oTvq0Tn3p2dQk7z23t
        mHCBK9r2q00OTFv087XLCi7fa+9l9034q8RSnJFoqMVcVJwIABqdCskuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXnfvI9d4g0VzWS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlXFx6y/Gggv8FS9vrGJtYDzE08XIySEhYCLxcHoTexcj
        F4eQwA5Gia6dvUwQCWmJYyfOMHcxcgDZwhKHDxeDhIUEnjNKNPQ5gdhsAroS//7sZwOxRQT0
        JE6evM4GModZoJlJ4tuzJcwQQ5czS/xbe4UVZBCngK3EhA4LEFNYwEtiXq8USC+LgKpE/9lD
        rCA2r4ClxMXmZ+wQtqDEyZlPWEBsZgFtiac3n0LZ8hLb385hhjhTQeLn02WsEDckSdxumcgM
        USMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECI4qLa0djHtWfdA7xMjEwXiIUYKDWUmEV/Cic7wQb0piZVVqUX58UWlOavEhRmkOFiVx
        3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamNxU5UqVPwse3SrdVBHFkZ/DeUl5zvYv2XV1XX9q
        S1gYQ8KXKVy5cSb2OFtTkQN77VyBF4VeoUFOz3YdfTol6Zh79K4JcbPaVu3+WN9/fauQqvC1
        6QfFBMvvFF7TqNftjeq6pRah5j9dsHdPncAdjiRWiTz+3yeM59wMnsu18UDnoxlR5pqpFjIZ
        twwXncyIWdNf9PWdmffGuWFH3JXv2k0pnDa182g0f6TRQvfuo0s3X1sy/yJXzbkvxbMqu1re
        +k27PD+Hd79B2cpJuZNCYxoVSu++0T5hsMFYJy1vpp5p7zyO4DWNFl1f0x257H+YRwsopawJ
        aqvq+VmyJiKmPtb2fJpEnkT78gqp0rNKLMUZiYZazEXFiQCAkxC0GQMAAA==
X-CMS-MailID: 20200826041909epcas1p108db024e965f292c5b479a341bdd76b5
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 2020/08/26 10:03, Namjae Jeon wrote:
> >> Second: Range validation and type validation should not be separated.
> >> When I started making this patch, I intended to add only range validation.
> >> However, after the caller gets the ep, the type validation follows.
> >> Get ep, null check of ep (= range verification), type verification is a series of procedures.
> >> There would be no reason to keep them independent anymore.
> >> Range and type validation is enforced when the caller uses ep.
> > You can add a validate flags as argument of exfat_get_dentry_set(), e.g. none, basic and strict.
> > none : only range validation.
> > basic : range + type validation.
> > strict : range + type + checksum and name length, etc.
> 
> Currently, various types of verification will not be needed.
> Let's add it when we need it.
> >
> >>> -	/* validiate cached dentries */
> >>> -	for (i = 1; i < num_entries; i++) {
> >>> -		ep = exfat_get_dentry_cached(es, i);
> >>> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> >>> +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
> >>> +	if (!ep || ep->type != EXFAT_STREAM)
> >>> +		goto free_es;
> >>> +	es->de[ENTRY_STREAM] = ep;
> >>
> >> The value contained in stream-ext dir-entry should not be used before validating the EntrySet
> checksum.
> >> So I would insert EntrySet checksum validation here.
> >> In that case, the checksum verification loop would be followed by the
> >> TYPE_NAME verification loop, can you acceptable?
> > Yes. That would be great.
> 
> OK.
> I'll add TYPE_NAME verification after checksum verification, in next patch.
> However, I think it is enough to validate TYPE_NAME when extracting name.
> Could you please tell me why you think you need TYPE_NAME validation here?
I've told you on previous mail. This function should return validated dentry set after checking
file->stream->name in sequence.
> 
> 
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>
> >

