Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0725C042
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 13:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgICLZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 07:25:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43231 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgICLXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:23:52 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200903111301epoutp0201d8ac0d818f5c6b243283192d114006~xQbNU8Pfz3039330393epoutp02J
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 11:13:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200903111301epoutp0201d8ac0d818f5c6b243283192d114006~xQbNU8Pfz3039330393epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599131581;
        bh=ciQYrD3Tn+9WjZa6amZbj5BAhCek31MGMXV8HcEB6Dk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QVRg6ZG3UDKjyF1t4nYZv3TRRgzXPulY5OfgzfNU+XC/u2AUxA2pB4mT+eCw4AdXn
         p7aN1zvIrBdamKS4Nq8/2hV4B+NdJ4ZlW8TEJOBce/J9jFrqj3QGYu1efV1CqIGwZI
         FyL5FevFLznUP4DJy8Xm9pUYtws6gh2dGlvwKUEU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200903111300epcas1p4d2a6b5e162679cb00ee0d5a282243d02~xQbM1EBXR0956509565epcas1p4H;
        Thu,  3 Sep 2020 11:13:00 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BhypM4tcGzMqYkf; Thu,  3 Sep
        2020 11:12:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.C7.19033.BBFC05F5; Thu,  3 Sep 2020 20:12:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200903111259epcas1p2564a6a8f400eea1390d1cf2e344dd4a5~xQbLV-X8f1369513695epcas1p2T;
        Thu,  3 Sep 2020 11:12:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200903111259epsmtrp2f93c85e5e351761e763754501f9e1ade~xQbLVS9Bq2006820068epsmtrp2q;
        Thu,  3 Sep 2020 11:12:59 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-7d-5f50cfbbf41d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.6E.08382.ABFC05F5; Thu,  3 Sep 2020 20:12:58 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200903111258epsmtip112ea102f652e62b79d1a8f01c5c7fed4~xQbLH37AA1455414554epsmtip1J;
        Thu,  3 Sep 2020 11:12:58 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902075306.8439-1-kohada.t2@gmail.com>
Subject: RE: [PATCH] exfat: eliminate dead code in exfat_find()
Date:   Thu, 3 Sep 2020 20:12:57 +0900
Message-ID: <000001d681e3$2da33bc0$88e9b340$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHi/AdGy7WFjhE0CTAe/r6eZnJXbwGnddttqTCKrAA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmru7u8wHxBr8/Kln8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISdjzruzbAUrmSs6Z65mbWB8xNTFyMkhIWAi0fB7C5DNxSEksINRYkNfHwuE84lR
        4vruLmaQKiGBb4wSM9dmw3RsOPaYDaJoL6PEjQO3WCCKXjJKPLwnDmKzCehKPLnxE6xZREBP
        4uTJ62wgNrNAI5PEiZdggzgFLCQmLz4F1issYC8xo3kXWA2LgIrE3TPvWUFsXgFLiW3/l7FD
        2IISJ2c+YYGYIy+x/e0cZoiDFCR2fzrKCrHLSuL6jnXMEDUiErM725hBDpUQWMghMWH/IlaI
        BheJ9y/nMULYwhKvjm9hh7ClJD6/28sGYddL/J+/lh2iuQXosU/bgIHEAeTYS7y/ZAFiMgto
        SqzfpQ9Rriix8/dcRoi9fBLvvvawQlTzSnS0CUGUqEh8/7CTBWbTlR9XmSYwKs1C8tksJJ/N
        QvLBLIRlCxhZVjGKpRYU56anFhsWGCHH9SZGcCrVMtvBOOntB71DjEwcjIcYJTiYlUR4Z97w
        jRfiTUmsrEotyo8vKs1JLT7EaAoM64nMUqLJ+cBknlcSb2hqZGxsbGFiZm5maqwkzvvwlkK8
        kEB6YklqdmpqQWoRTB8TB6dUA5OV0s5pgd/K1b7NPjbFSac+QLNe4UrTXFa/b4FcH6Ksm6QX
        hOg/rP5fv2+144W8tqXG/kHVN7L3NM45H3zywqpXuVdWXJWJWLY2R+Y4i/93QW1z8VbPNq/f
        uzpT85ZJv9mfdsVQ4vKXNe7pjO9drAVdF4ZHBDxcbPJxo+xR9oW35OQP7jTeaHnjetGnh8om
        xseUOpRvR9x7dOgSS7ZGY3pgzKz0Td9i001s+LZUbn/556Ry3PTl0nIH2t49ijrVs4n506EX
        HvKTT05w/5i9NLqtu6Q7lGPdEoGeBxy/1x78WbDtyzlz9ZZONu81pvL/jy3p/rgla/K3+9kp
        gX1XpR3+PnIWDVx9cNoU5eVNvxWUWIozEg21mIuKEwHgvIgwLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTnfX+YB4gx9vLC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKmPPuLFvBSuaKzpmrWRsYHzF1MXJySAiYSGw49piti5GL
        Q0hgN6PEkpsbmLsYOYASUhIH92lCmMIShw8XQ5Q8Z5R4NmUSG0gvm4CuxJMbP5lBbBEBPYmT
        J6+DzWEWaGaSaP3SzATR0cko8WbOeRaQKk4BC4nJi0+B2cIC9hIzmneBTWIRUJG4e+Y9K4jN
        K2Apse3/MnYIW1Di5MwnLCBXMANtaNvICBJmFpCX2P52DjPEAwoSuz8dZYU4wkri+o51zBA1
        IhKzO9uYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7u
        JkZwTGlp7mDcvuqD3iFGJg7GQ4wSHMxKIrwzb/jGC/GmJFZWpRblxxeV5qQWH2KU5mBREue9
        UbgwTkggPbEkNTs1tSC1CCbLxMEp1cDke+L4FT3NK7x3gzf3LkpYtuOR2NbIv6GiLxsf6Cbt
        rNwmbWIRty814K4C927j11XfIxM+vFMJ4hRmVY9XnTvx4uelkdfa7J/etuG8WLSqZI9JdNxb
        Yw9nhb9Jfl8V6jWONGqrJrSFhUQaiSze2dB5VWnv6wThD3whL1WVhD6rFoZteLV3Ef+8uh99
        c4OO+M97H1Moeel7U9ivogqjs+pGS3iWxc2dvD7llU/CnfQJZgrKLzeedJ3dZ8aQ0CZ7cEO1
        22rBllfR2znqEzfsPMw7e1fok0X/1l5/y2bbYHtO6vnuuCg9zc0nzy9MF7V13n6rNGq/u8iu
        rxPf73W8/VZ5b+WCLpXfS2RXXUpW1chSYinOSDTUYi4qTgQA2AccExgDAAA=
X-CMS-MailID: 20200903111259epcas1p2564a6a8f400eea1390d1cf2e344dd4a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200902075318epcas1p3c35299366ec32bb4947362f73b50b56f
References: <CGME20200902075318epcas1p3c35299366ec32bb4947362f73b50b56f@epcas1p3.samsung.com>
        <20200902075306.8439-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The exfat_find_dir_entry() called by exfat_find() doesn't return -EEXIST.
> Therefore, the root-dir information setting is never executed.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c   |   1 -
>  fs/exfat/namei.c | 120 +++++++++++++++++++----------------------------
>  2 files changed, 47 insertions(+), 74 deletions(-)

