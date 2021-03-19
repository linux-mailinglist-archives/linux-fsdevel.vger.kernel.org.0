Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABF34164B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 08:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhCSHLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 03:11:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43730 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhCSHKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:10:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210319071037epoutp023f483c92b5c55269856e285abc690dbc~trMzeQGrc1797317973epoutp02C
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 07:10:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210319071037epoutp023f483c92b5c55269856e285abc690dbc~trMzeQGrc1797317973epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616137837;
        bh=tQmqXyJw5q9RHUfRqUbLjHC+qLc4pYZJCn12SQGg5Ww=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NDKBdCTVZkrPon21WPjnNdeZ2D36+/4UVfmNOgrYN3DCNSPBP/JAzTGzPnCAXNW5X
         mic8CjbKBrcfXAamz+xElgtCaB17H5yRlGEQlSZa8nMNoegfeO/CeZPfrh4DItCAul
         NSYA4m9r/zqUnHcuFEx+tmGf9cKNyliQ+qW8ySkY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210319071036epcas1p3243b89c5fd0e127923a52922154d80d3~trMzAUKAu2018620186epcas1p3W;
        Fri, 19 Mar 2021 07:10:36 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F1w5l57c4z4x9Pq; Fri, 19 Mar
        2021 07:10:35 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.2F.50768.B6E44506; Fri, 19 Mar 2021 16:10:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210319071035epcas1p29f8766cca280391ad210a58a3f631e91~trMxjoKtN2281322813epcas1p2J;
        Fri, 19 Mar 2021 07:10:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210319071035epsmtrp21f76c80bc0699409c649474d36e64766~trMxi6JkE2263122631epsmtrp2n;
        Fri, 19 Mar 2021 07:10:35 +0000 (GMT)
X-AuditID: b6c32a37-56c76a800000c650-0f-60544e6bd8cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.52.13470.B6E44506; Fri, 19 Mar 2021 16:10:35 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210319071034epsmtip13f83a1d06c230c4a45b007616322cf88~trMxWXwKN0204802048epsmtip1W;
        Fri, 19 Mar 2021 07:10:34 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Hyeongseok Kim'" <hyeongseok@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <9a7c01d71af5$51d17470$f5745d50$@samsung.com>
Subject: RE: [PATCH] exfat: improve write performance when dirsync enabled
Date:   Fri, 19 Mar 2021 16:10:35 +0900
Message-ID: <002601d71c8e$f512e930$df38bb90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHrkVYthcVH6BAyEbje7ZFeNRCC9QIEdcHjAxV+Pj+qOSuBIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmvm62X0iCwc0+BYu/Ez8xWezZe5LF
        4vKuOWwWW/4dYXVg8dg56y67R9+WVYwenzfJBTBH5dhkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZDz92M5asJO5ou3uD6YGxidMXYycHBIC
        JhK/Ztxh62Lk4hAS2MEosaZ1MSuE84lR4va3e4wQzjdGic1TpwJlOMBaJh+tAukWEtjLKDGj
        zRKi5iWjxJRzvawgCTYBXYl/f/azgdgiAlESe5e9A1vHLOAs0XnxNFgNp4CVxKtbj8BsYQEv
        iXsPp4PVsAioSrz/fwcszitgKdF69CcbhC0ocXLmExaIOfIS29/OYYZ4QUHi59NlrBC7nCSm
        PO2C2iUiMbuzjRnkOAmBj+wS1yecZINocJE4en0x1P/CEq+Ob2GHsKUkPr/bywbxZLXEx/1Q
        8zsYJV58t4WwjSVurt8ADgdmAU2J9bv0IcKKEjt/z2WEWMsn8e5rDzSoeCU62oQgSlQl+i4d
        hloqLdHV/oF9AqPSLCSPzULy2CwkD8xCWLaAkWUVo1hqQXFuemqxYYExclRvYgSnQy3zHYzT
        3n7QO8TIxMF4iFGCg1lJhNc0LyBBiDclsbIqtSg/vqg0J7X4EKMpMKgnMkuJJucDE3JeSbyh
        qZGxsbGFiZm5mamxkjhvksGDeCGB9MSS1OzU1ILUIpg+Jg5OqQYm23iR1O0+yzir+xa5xDdm
        7FwlpL4nWHa2wUyXVl7BrdvMF851OWmg+m7d77VOeYbLCl57Xn/p7ixh07W7g6fwvbpRt6aE
        s1T5l+yiFSy9tvLXjvxZEFjFXB/2oC1b8mTLTxnD9ZdV2Ln7P26v265+auO7druWXYWaJQs5
        p2e2pKinNU2++m8j0y7hGyXsS37u2Xf5DuekyYcF/5w6c+Xyl8rFVhfldGc7lMjzRK3YpJRQ
        55YmYjlf1Wd2pej/o63P3zT9T6stKJ3bulJR+2hxR+Tb7zucLy05sF9hf/fWbDXDnINrNiab
        Sy41+mizv8sl7m9cTM42g9XqFu+3mQfaH3yje4ZLp69OcfXcpapKLMUZiYZazEXFiQB/xms4
        EAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnG62X0iCwYbfLBZ/J35istiz9ySL
        xeVdc9gstvw7wurA4rFz1l12j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mp4+rGdtWAnc0Xb
        3R9MDYxPmLoYOTgkBEwkJh+t6mLk4hAS2M0o8WPTccYuRk6guLTEsRNnmCFqhCUOHy6GqHnO
        KPHzxytmkBo2AV2Jf3/2s4HYIgJREueOnwGzmQVcJdpeHGGFaNjFKDH72z5WkASngJXEq1uP
        wGxhAS+Jew+nM4HYLAKqEu//3wGL8wpYSrQe/ckGYQtKnJz5hAViqLbE05tPoWx5ie1v5zBD
        HKog8fPpMlaII5wkpjztYoKoEZGY3dnGPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucW
        GxYY5qWW6xUn5haX5qXrJefnbmIEx4aW5g7G7as+6B1iZOJgPMQowcGsJMJrmheQIMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANT1USJdcfZJaavmZkx
        rzelreP0xIUBChovD84RZ5hQnjeXo+DchF7fmjWbVaamvW9KW7B97bVjncrM913SQ6Zv1Mtd
        e1f81O/GKz4fjTPu879WLkl9pVfSKxjql7hMvny1yS9Zm+9O0QfOf3ixRcPzqsZvTQYTo8YC
        44P3/qR6rzuid/Qc55LubxNMSotvnvk+xTJr/s7Hk4/7f7FX2fBylqRtpuaL5aV2TcfnG9sq
        B054tum8QYB21CUVtyc7jkkr+rtq3C3J4Og+4OHwgenC1Ae/xRxSJ9R0hy/M6uLoibqxS299
        87zz+hL7g9aI6ayZ8niSeuj59afUjsjk392l1Oi0++pO10d6c1xWfvulqcRSnJFoqMVcVJwI
        ACzEOtH8AgAA
X-CMS-MailID: 20210319071035epcas1p29f8766cca280391ad210a58a3f631e91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315041325epcas1p11488673d4f146350dedded4b3b20fd6f
References: <CGME20210315041325epcas1p11488673d4f146350dedded4b3b20fd6f@epcas1p1.samsung.com>
        <20210315041255.174167-1-hyeongseok@gmail.com>
        <9a7c01d71af5$51d17470$f5745d50$@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Degradation of write speed caused by frequent disk access for cluster
> > bitmap update on every cluster allocation could be improved by
> > selective syncing bitmap buffer. Change to flush bitmap buffer only
> > for the directory related operations.
> >
> > Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> 
> Looks good.
> Thanks for your work.
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks!

