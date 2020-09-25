Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA85F27815F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 09:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIYHRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 03:17:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26618 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYHRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:17:08 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200925071705epoutp03d370149621f69252a70d2209c2d51d72~39ZfvqLMp0174601746epoutp03U
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 07:17:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200925071705epoutp03d370149621f69252a70d2209c2d51d72~39ZfvqLMp0174601746epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601018225;
        bh=c82u0uyr4KiZ6XbQJfNS/z4SX/aPM3kU9bW0MORguYg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ILsk0bjCtmAUz+36Ani88Zmjlu+IQgnssq+Gip4tMiW0l3m4HrAsaPBSmAWTn6iXc
         7C4ngYFYeQWhvZcIuifM8FwXVJ68/CrkvdXMMoxMlbrr6DkuPre9bIT2huSIZ2CaPA
         esQOgcGAPXHxgAhACtvYlRhMAbF8v1mTD6mD/qrY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200925071705epcas1p341d985bb8541acb40fabaa41b2c12f77~39ZfXDZtj0526005260epcas1p3B;
        Fri, 25 Sep 2020 07:17:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4ByNWz5lXszMqYkg; Fri, 25 Sep
        2020 07:17:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.41.10463.F699D6F5; Fri, 25 Sep 2020 16:17:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200925071703epcas1p4721ad60640102fabf18d5b20b4a0bfa2~39Zd0Rn742375523755epcas1p4h;
        Fri, 25 Sep 2020 07:17:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200925071703epsmtrp2f3a0ba18c893f947bb3d219393402d38~39ZdveGEh1937619376epsmtrp2Y;
        Fri, 25 Sep 2020 07:17:03 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-29-5f6d996f31b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.4A.08745.F699D6F5; Fri, 25 Sep 2020 16:17:03 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200925071703epsmtip1c380da2800535406494ecaa31d2efa78~39ZdkPxIo3128331283epsmtip1y;
        Fri, 25 Sep 2020 07:17:03 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <716101d692d6$ef1dc2d0$cd594870$@samsung.com>
Subject: RE: [PATCH v2] exfat: remove 'rwoffset' in exfat_inode_info
Date:   Fri, 25 Sep 2020 16:17:03 +0900
Message-ID: <004301d6930b$ddf877e0$99e967a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI3QAIiS02qQVZr3s2cWPTf2qgwLQKUIcn3AXWqI5Wol0kEYA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmrm7+zNx4gw8PtSx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBZb/h1hdWDz+DLnOLtH87GVbB47Z91l9+jbsorR4/MmuQDWqByb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORk7
        /6xmKnjBXLHx8xymBsZ+5i5GTg4JAROJOdf2sXcxcnEICexglFiw8CMLhPOJUeL/uz/MEM5n
        RokfC2ezwrRcurKNCcQWEtjFKDHpgTeE/ZJR4ss3DRCbTUBX4t+f/WwgtohAtMSxHecZQQYx
        CyxhlLi67j1QMwcHp4CVxJYX6iA1wgIuEgs2bWIHsVkEVCWuP70LNp9XwFJi9ffTLBC2oMTJ
        mU/AbGYBeYntb+dAvaAg8fPpMlaIXU4SMxtuskHUiEjM7mwDe0BCYCKHROe/R0wQDS4SG2/N
        Y4GwhSVeHd/CDmFLSXx+t5cN5DYJgWqJj/uh5ncwSrz4bgthG0vcXL+BFaSEWUBTYv0ufYiw
        osTO33MZIdbySbz72sMKMYVXoqNNCKJEVaLv0mGoA6Qluto/sE9gVJqF5LFZSB6bheSBWQjL
        FjCyrGIUSy0ozk1PLTYsMEGO6k2M4LSpZbGDce7bD3qHGJk4GA8xSnAwK4nwHt+QEy/Em5JY
        WZValB9fVJqTWnyI0RQY1BOZpUST84GJO68k3tDUyNjY2MLEzNzM1FhJnPfhLYV4IYH0xJLU
        7NTUgtQimD4mDk6pBiZedq6QC/OXG5eeuzD/QlDh6S3FV4MMf3PahX4J49OaNH8HxwzOQxtK
        A2POO/IG3NTYsWG24tISjVkqM06duFy6a92Hky4b5eWZVLQzUuO+mhuc1Fswz7PyzCqT2B/X
        m6SeXr+17J3fm/5nFY1/lIxDzUS89gmVtt778mTCncPtpuGMj2vzpqU+9svca1UadphDObBr
        quf8sGKXknd/5MJF4xvXiL1xzZfwD+L1l7nCxCfmWb3t3Lm26niO3M+qwue0nmTYi/m0SkZF
        lu43yki049j9ZGWFv1dGtF/gycUFi6ed15lQ+e5xZSOjl7+K3/KL0ikMS35EF9VdV56sWjDh
        ZqX7z8B3LevszsQuUGIpzkg01GIuKk4EALQhm5okBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG7+zNx4g8mf+C1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBZb/h1hdWDz+DLnOLtH87GVbB47Z91l9+jbsorR4/MmuQDWKC6b
        lNSczLLUIn27BK6MnX9WMxW8YK7Y+HkOUwNjP3MXIyeHhICJxKUr25i6GLk4hAR2MEocnTmN
        ESIhLXHsxBmgIg4gW1ji8OFiiJrnjBKNxy6ANbMJ6Er8+7OfDcQWEYiWuPr3LwtIEbPAMkaJ
        DYc3MEJ0bGeU+NZ6hR1kEqeAlcSWF+ogDcICLhILNm1iB7FZBFQlrj+9ywRi8wpYSqz+fpoF
        whaUODnzCZjNLKAt8fTmUyhbXmL72zlQHyhI/Hy6jBXiCCeJmQ032SBqRCRmd7YxT2AUnoVk
        1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBUaSltYNxz6oP
        eocYmTgYDzFKcDArifAe35ATL8SbklhZlVqUH19UmpNafIhRmoNFSZz366yFcUIC6Yklqdmp
        qQWpRTBZJg5OqQYmK5sFz2x8F1f3LL9wxO5d2ImcwL0TO2666F5oF9gVqXBRJFpt0eTgidaP
        vwqkWN76u6XH49qRjxEsnifqfjXtO3vTrerx1JczWqfNnnFp9rlblWIzV2U6OMlfKK+8wrU4
        +K91iaCaZ8PGjpa46AkJiqLc05+Evtosrtd/8O+ju7KR7ZaWjA98eL56mu/LznPVs+73NmZg
        3zs1szh0jui3aTKbtv16LGJRzq52pr/ucpXZuaNCC79/3/NcvSF/7fdoq+yDx8xlD0ea/1RU
        PDD3VOidbYYH3ixn2rShx4vJkEN1B0Oqxvq6n0fvCu8yYHy4e2ZgzHHmmdrZv4teXW+fJfDP
        TPiC8+foguUyuvoLlFiKMxINtZiLihMBhdAHRREDAAA=
X-CMS-MailID: 20200925071703epcas1p4721ad60640102fabf18d5b20b4a0bfa2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200917014010epcas1p335c9ba540cd41ff9bf6b0ce2e39d7519
References: <CGME20200917014010epcas1p335c9ba540cd41ff9bf6b0ce2e39d7519@epcas1p3.samsung.com>
        <20200917013916.4523-1-kohada.t2@gmail.com>
        <716101d692d6$ef1dc2d0$cd594870$@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Remove 'rwoffset' in exfat_inode_info and replace it with the
> > parameter of exfat_readdir().
> > Since rwoffset is referenced only by exfat_readdir(), it is not
> > necessary a exfat_inode_info's member.
> > Also, change cpos to point to the next of entry-set, and return the
> > index of dir-entry via dir_entry->entry.
> >
> > Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks for your patch!

