Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C725CF7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 04:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIDCvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 22:51:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:20592 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbgIDCvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:51:43 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200904025140epoutp04ca439fc637fcc76803e5bd80045bc7af~xdOw9glEl0778707787epoutp04d
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2020 02:51:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200904025140epoutp04ca439fc637fcc76803e5bd80045bc7af~xdOw9glEl0778707787epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599187900;
        bh=3j9wXFPoXrGR29SzTgKQa2jvraHCbCGq1Geo06fCDFc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QUVcsk1+COo5cvzKxlDucqiFHSa8lHdwVaFZW/7tSif8LvfB2qL0xIyUioohcv4Xu
         6Dc86UEOc6agz9L5MtshahaxnXxN/wCIeZO38ANr9xVrwgly3TgMVVxQB6uv8cqrlA
         MZFwvoLgINFcUI0hPq5SUe70yG6J0RF8bn/ZYGxE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200904025140epcas1p4e5bbc3942f86f7a7ce336a8fd5e06cfd~xdOwdHCAg2235622356epcas1p4s;
        Fri,  4 Sep 2020 02:51:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BjMdR1qRBzMqYlr; Fri,  4 Sep
        2020 02:51:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.F9.18978.BBBA15F5; Fri,  4 Sep 2020 11:51:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200904025138epcas1p2aa6ede81a216c41405a57ef1ede0ff39~xdOuzWmYA1801918019epcas1p2Z;
        Fri,  4 Sep 2020 02:51:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904025138epsmtrp2b855f2394fa9e428c2b2707252745bc7~xdOuyjqrX1999719997epsmtrp2T;
        Fri,  4 Sep 2020 02:51:38 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-f1-5f51abbb106e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.7B.08303.ABBA15F5; Fri,  4 Sep 2020 11:51:38 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200904025138epsmtip2d0b4f7b4ccbd54e4049ebf81df3fa01d~xdOuhyiv72414624146epsmtip2W;
        Fri,  4 Sep 2020 02:51:38 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <000001d681e3$2da33bc0$88e9b340$@samsung.com>
Subject: RE: [PATCH] exfat: eliminate dead code in exfat_find()
Date:   Fri, 4 Sep 2020 11:51:38 +0900
Message-ID: <001a01d68266$4f416850$edc438f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHi/AdGy7WFjhE0CTAe/r6eZnJXbwGnddttAjFSwr+pIA0swA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmge7u1YHxBgf+8Vj8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxpN3V1gK1jBVrNrTxNjA+Juxi5GTQ0LAROLo7P2sXYxcHEICOxgltrb/h3I+
        MUqcX7CLDcL5zCgx980lJpiW6Y3LmCASuxgl7i9ezgLhvGSU6Lu0khmkik1AV+Lfn/1sILaI
        QLTEsR3nGUGKmAWuMEo8eDQLbBSngJXEjttzwGxhAXuJGc27wBpYBFQkLmztZwWxeQUsJe6f
        usEOYQtKnJz5hAXEZhaQl9j+dg4zxEkKEj+fLmOFWOYksWzfd0aIGhGJ2Z1tUDUzOSQ2nmeB
        sF0k3p7Yww5hC0u8Or4FypaS+PxuL9ANHEB2tcTH/VCtHYwSL77bQtjGEjfXb2AFKWEW0JRY
        v0sfIqwosfP3XKitfBLvvvawQkzhlehoE4IoUQWGzmFoGEpLdLV/YJ/AqDQLyV+zkPw1C8n9
        sxCWLWBkWcUollpQnJueWmxYYIgc2ZsYwelUy3QH48S3H/QOMTJxMB5ilOBgVhLhnXnDN16I
        NyWxsiq1KD++qDQntfgQoykwpCcyS4km5wMTel5JvKGpkbGxsYWJmbmZqbGSOO/DWwrxQgLp
        iSWp2ampBalFMH1MHJxSDUwTLBiNnsdJ6EtOPlx9o/pwSs+r16qq73od/h2bnPronrIFU5eb
        gsCHS5OPq15a/bOS2Yfb2KWwSP/GwQjTeVobV20613FnTm5drxGvFtfem+V9myP4ZNTsrsZl
        Lfn/M3xv08GYqZNMbvVqfFr5wnqbS+icDzNeOIVH5ZTUbnnw/8km+cWCu7bPa8lx0moTXulx
        Q2Ht+TbzoBevGi4nXw83P8c92SBsFlPGnXtz77DLTLO7eZar9IvlYyExE6akT0ve7C3U7Vxh
        eFR0RquV4hFTg5zIOlszk+1+B1+3LLgjsqmI4R4Pg8Hn5RNu3/BI5lieocBiNSHxcPK9I0HC
        aSe4mGoKC8OW2saVTBL8FK/EUpyRaKjFXFScCABlTiogMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXnfX6sB4gzcfeS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlfHk3RWWgjVMFav2NDE2MP5m7GLk5JAQMJGY3riMqYuR
        i0NIYAejxJp525khEtISx06cAbI5gGxhicOHiyFqnjNKbGw5wARSwyagK/Hvz342EFtEIFri
        6t+/LCA2s8A1Ronv07MhGrYzStxe/YEVJMEpYCWx4/YcsGZhAXuJGc27wJpZBFQkLmztB6vh
        FbCUuH/qBjuELShxcuYTqKHaEk9vPoWy5SW2v50DdaiCxM+ny1ghjnCSWLbvOyNEjYjE7M42
        5gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOLK0
        tHYw7ln1Qe8QIxMH4yFGCQ5mJRHemTd844V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5I
        ID2xJDU7NbUgtQgmy8TBKdXAFM87WY35Wka+IMMzAz8fUdcolWqv+d++LOVJ6Stz9uxT9wwX
        qZ1lpti+un6auTyHqdFMr3WcHgbbNaU0XsVKPP73udB5T19desjsExYCF82suq8ZWZ/wD8qJ
        TN5lmtfds0l6SopJ6JQl+tNzeCbIOZ2tfi04y7U6bcb02TFmv42mLjbOZg55uM1AT/oUt1ck
        V6uHncqjEo4pk24KbHeMXX1R5HiBr/eaZba/29dcf2n2rfvIC46u6M6qkEWKd39+n+y3eV5I
        qkrrhadLTVbO3Td780mbCatbKuXSTlpWthYlzTWS7Dh15Lt4yeG38yck/RKqP6J8++m0j32s
        mvOOXhfcuO+p9qsPzPzTa24osRRnJBpqMRcVJwIAKlLWdxsDAAA=
X-CMS-MailID: 20200904025138epcas1p2aa6ede81a216c41405a57ef1ede0ff39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200902075318epcas1p3c35299366ec32bb4947362f73b50b56f
References: <CGME20200902075318epcas1p3c35299366ec32bb4947362f73b50b56f@epcas1p3.samsung.com>
        <20200902075306.8439-1-kohada.t2@gmail.com>
        <000001d681e3$2da33bc0$88e9b340$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > The exfat_find_dir_entry() called by exfat_find() doesn't return -EEXIST.
> > Therefore, the root-dir information setting is never executed.
> >
> > Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks for your work!

