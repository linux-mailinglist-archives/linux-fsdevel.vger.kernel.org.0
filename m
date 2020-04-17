Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3F1AD5EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 08:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDQGHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 02:07:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:18547 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgDQGHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:07:24 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200417060720epoutp0186982ec403a573a758e7332f720aba6f~GhlojpAQq0965309653epoutp01k
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2020 06:07:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200417060720epoutp0186982ec403a573a758e7332f720aba6f~GhlojpAQq0965309653epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587103640;
        bh=NhQHiTq9cJAvH0W07/hKaJSVvib7t1lCg7QttxUmkL4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=asJvzW7H2d2sWnn4k3rdbhp+SEcBUiTFyJBev+L4VPXLQBPYPKIiQy+7BWX8XpXCm
         afIRJiGKOC+2U5sA7BgxVarPQYyB+1axFgZJfuhPY7zVfXwCd7c8nAFJDfSfbL8ogG
         nazyYA69eblTElwa4GTwf3P4G4BTz2aRyjvVn/sA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200417060720epcas1p3e9ca3cd42465d49a8a49999d07f95c29~GhloX886S1867118671epcas1p3f;
        Fri, 17 Apr 2020 06:07:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 493Qbq1ZsQzMqYkg; Fri, 17 Apr
        2020 06:07:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.F2.04648.697499E5; Fri, 17 Apr 2020 15:07:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200417060718epcas1p24b3814d0c27b94b2f2aaa9d3783bf02b~GhlmxPBI80158601586epcas1p2s;
        Fri, 17 Apr 2020 06:07:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417060718epsmtrp1e0c4cc412c1d3294285657923448b95e~Ghlmwk7ZJ0772207722epsmtrp1h;
        Fri, 17 Apr 2020 06:07:18 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-5c-5e9947964195
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.FE.04158.697499E5; Fri, 17 Apr 2020 15:07:18 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200417060718epsmtip242aefd7d55e070437fbc50c7adb65506~GhlmjQ0Jp1218412184epsmtip20;
        Fri, 17 Apr 2020 06:07:18 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Eric Sandeen'" <sandeen@sandeen.net>
Cc:     "'fsdevel'" <linux-fsdevel@vger.kernel.org>
In-Reply-To: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
Subject: RE: [PATCH 0/2] exfat: timestamp fixes
Date:   Fri, 17 Apr 2020 15:07:18 +0900
Message-ID: <004b01d6147e$73115980$59340c80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKsuKjHOwhZ6f0g/NtxwPHRTZHiogKFv9ZUprtdVKA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmge4095lxBvPe6lvs2XuSxaL1ipYD
        k8eWxQ+ZPD5vkgtgisqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAGarqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvX
        S87PtTI0MDAyBapMyMn42hRe8JG54u/+pywNjM3MXYycHBICJhJrf11m7GLk4hAS2MEoMes0
        SALE+cQo8aNnMZTzjVHi3LH3jDAti35MY4dI7GWUOLZoCVT/S0aJSy9WgA1mE9CV+PdnPxuI
        LSKgJfG+7z+QzcHBLKAv0bOfByTMKWAvMe/dI7ByYaDw5+NvwRawCKhKvNr+kgXE5hWwlPjW
        eoAVwhaUODnzCVicWUBeYvvbOVA/KEj8fLqMFWKVlcS1G1uZIWpEJGZ3toF9ICGwhk1iw8Mb
        bBANLhKLpr5ggbCFJV4d38IOYUtJvOxvYwe5U0KgWuLjfqj5HYwSL77bQtjGEjfXb2CFeEVT
        Yv0ufYiwosTO33MZIdbySbz72sMKMYVXoqNNCKJEVaLv0mEmCFtaoqv9A/sERqVZSB6bheSx
        WUgemIWwbAEjyypGsdSC4tz01GLDAmPkqN7ECE53WuY7GDec8znEKMDBqMTDm2A/I06INbGs
        uDL3EKMEB7OSCO9Bt5lxQrwpiZVVqUX58UWlOanFhxhNgeE+kVlKNDkfmIrzSuINTY2MjY0t
        TMzMzUyNlcR5p17PiRMSSE8sSc1OTS1ILYLpY+LglGpgLNfh0Ztl8ON0m+RfG7vNG012vDPI
        afk3a5bPzRWW7QlZk0X+xGR6Tllq4MJ474RH1KIZ92x1VlqfWxl2QGZlkcXsUxsmnl+g9WWX
        z4nPR/6yzeeTfrT6VeH5s6zrlyc8vj3t1PT0SL4dweERF0oZ1jsyREQG5OsL9FQr/2uzKXMM
        +hp3aOLCk0osxRmJhlrMRcWJAFl2Xb2NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO4095lxBlcOi1rs2XuSxaL1ipYD
        k8eWxQ+ZPD5vkgtgiuKySUnNySxLLdK3S+DK+NoUXvCRueLv/qcsDYzNzF2MnBwSAiYSi35M
        Y+9i5OIQEtjNKPHg5CM2iIS0xLETZ4CKOIBsYYnDh4shap4zSly98hysmU1AV+Lfn/1g9SIC
        WhLv+/6zgdQzC+hL9OzngaifwCix7cVMRpAaTgF7iXnvHoH1CgPVfD7+FizOIqAq8Wr7SxYQ
        m1fAUuJb6wFWCFtQ4uTMJ2BxZgFtiac3n0LZ8hLb386BekBB4ufTZawQN1hJXLuxlRmiRkRi
        dmcb8wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kR
        HPhaWjsYT5yIP8QowMGoxMObYD8jTog1say4MvcQowQHs5II70G3mXFCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGNmi9RL9npVJxS9c9UKk9HaVu8q8
        o5801ohl5Bb4MZisEIq/+11gnsyCb253e56s4GFTbVhpFT1n15PL4So1Vv9spqRrnrfet8dn
        /5tJl+4VzejSnF+pPMd0X97hghkpG7aary5hnSzcfE3NXeXobZ09kVo3Nbbf5My6dq6Kec/H
        7k/bGz4mPVRiKc5INNRiLipOBABAgo0/eAIAAA==
X-CMS-MailID: 20200417060718epcas1p24b3814d0c27b94b2f2aaa9d3783bf02b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200416010734epcas1p38e25193dcaf42638ee8fd183afe2a112
References: <CGME20200416010734epcas1p38e25193dcaf42638ee8fd183afe2a112@epcas1p3.samsung.com>
        <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I've seen 2 issues w/ exfat timestamps - discovered by xfstests
> generic/003
> 
> 1) time granularity is set wrong, so subsecond timestamps change when
>    an inode cycles out of memory and is reread from disk
> 
> 2) the disk format doesn't seem to support subsecond atime, so a similar
>    problem exists there.e
> 
> The last xfstests generic/003 issue is re: change time but exfat doesn't
> really support change times (?) so that'll be a test workaround.
Applied.
Thanks!

