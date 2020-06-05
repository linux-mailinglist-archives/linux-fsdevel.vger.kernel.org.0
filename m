Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE21EF27F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFEHxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 03:53:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47938 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgFEHxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:53:54 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200605075351epoutp04fc91b4ddbd69f7241a83b212f20c26b4~Vlpn_yAkL1105611056epoutp04h
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 07:53:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200605075351epoutp04fc91b4ddbd69f7241a83b212f20c26b4~Vlpn_yAkL1105611056epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591343631;
        bh=yo48EemrL/9a64UMD89Nt3dsELWEtZLTAUPX5e3kK98=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=C7Zt0p39Ah/AVbUJAr5uN6/LBmmyhSx44WKNtHCR/HSJg1hNhPu4NCHhymw1bHTO8
         2zpOb1uBl+Tz+hqCz1YaJVFnTqXkF39axunEEHOZrlxdWgep4yst01tH6/B8UdFbEr
         /4e6BxFGsRVes4SZtBm+iBTeh+xfrIQMB5Cfq7VA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200605075350epcas1p175b9519388be275c27b9efc9da0bb596~VlpnN4UaB3146231462epcas1p1l;
        Fri,  5 Jun 2020 07:53:50 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49dZf56zvbzMqYlr; Fri,  5 Jun
        2020 07:53:49 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.A0.19033.D0AF9DE5; Fri,  5 Jun 2020 16:53:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200605075349epcas1p1b5279de123f6dcda03b71d61361db715~Vlpl3QSeB3145131451epcas1p18;
        Fri,  5 Jun 2020 07:53:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200605075349epsmtrp2ab2ec5b66408ed602a9dfd1c74690e16~Vlpl0MreO1871518715epsmtrp2G;
        Fri,  5 Jun 2020 07:53:49 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-ed-5ed9fa0dad29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.9F.08382.D0AF9DE5; Fri,  5 Jun 2020 16:53:49 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200605075348epsmtip24c16c9c235f112620981fde49309102e~Vlplp_Ji30975309753epsmtip2N;
        Fri,  5 Jun 2020 07:53:48 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'hyeongseok.kim'" <hyeongseok@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <3b5501d63a4d$4213b950$c63b2bf0$@samsung.com>
Subject: RE: [PATCH] exfat: fix range validation error in alloc and free
 cluster
Date:   Fri, 5 Jun 2020 16:53:48 +0900
Message-ID: <000501d63b0e$727aa6f0$576ff4d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxYN2oYYNEwgPUPKVHj0TzywX0XwKkTEp7ANn6mAKod2i2kA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmni7vr5txBq+vGlj8nfiJyWLP3pMs
        Flv+HWF1YPbYOesuu0ffllWMHp83yQUwR+XYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gAtUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GScft7HWHCbqeL/gVbmBsZpTF2MnBwSAiYSXzpf
        sHcxcnEICexglNjccZMRwvnEKLFgQyNU5hujxNEVixhhWj6eXA9VtZdR4nnjcSYI5yWjxNNn
        b1lAqtgEdCX+/dnPBmKLANl3WyaBLWQWCJDYfGAX2CROASuJdR2PWEFsYYEgic79zcwgNouA
        isTPm4vA4rwClhIru5+wQdiCEidnPmGBmCMvsf3tHGaIixQkfj5dxgqxy0ni69smqF0iErM7
        26BqXrJLPP/OBmG7SHyc8gbKFpZ4dXwLO4QtJfH53V6gOAeQXS3xcT9UawejxIvvthC2scTN
        9RtYQUqYBTQl1u/ShwgrSuz8PZcRYiufxLuvPawQU3glOtqEIEpUJfouHYaGurREV/sH9gmM
        SrOQ/DULyV+zkNw/C2HZAkaWVYxiqQXFuempxYYFRshxvYkRnAa1zHYwTnr7Qe8QIxMH4yFG
        CQ5mJRHe574344R4UxIrq1KL8uOLSnNSiw8xmgJDeiKzlGhyPjAR55XEG5oaGRsbW5iYmZuZ
        GiuJ86rJXIgTEkhPLEnNTk0tSC2C6WPi4JRqYLJ+xCf01iIv+czHzYVzuKvufznrGRb9te26
        c2DPEW83rb+14rpxxzJUlzxlikpaVVbIHi04w1ZFX0LwvIZcs+nzZKGH//NPJqsZXK3UF/P5
        9o350Lzny1Wazr1e/eSC2FkehTNNYZnXFnfvXhMlk1e3ZeUjVtaa1/Zno2V1eJ5uXNJzrs56
        TsKMI0sWFNx2vXXnwKXMa8ufcNS9zor/ws71p3VflZFE5fXV5zRC1VWNBXeu4Pn1bd2LsIWb
        P/0MucB+cs8MiUeHsjReM6vnru+qeM2l516jV2v48O62T3obi84+apqi+126/Fnu69DgL2H3
        65JvbzVdLRvf5vHf7tCeBzssmxTenfvH7CB275ASS3FGoqEWc1FxIgC7YyX+DAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvC7vr5txBv92sVv8nfiJyWLP3pMs
        Flv+HWF1YPbYOesuu0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBlnH7ex1hwm6ni/4FW5gbG
        aUxdjJwcEgImEh9PrmfsYuTiEBLYzSjRfn4nO0RCWuLYiTPMXYwcQLawxOHDxRA1zxklPt/q
        ZQGpYRPQlfj3Zz8biC0CZN9tmQQ2lFkgQOJY90V2iIYjjBJ3Pq5gBklwClhJrOt4xApiCwMV
        /TyxHcxmEVCR+HlzEZjNK2ApsbL7CRuELShxcuYTFoih2hK9D1sZIWx5ie1v5zBDHKog8fPp
        MlaII5wkvr5tgjpCRGJ2ZxvzBEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREcE1qaOxi3r/qgd4iRiYPxEKMEB7OSCO9z35txQrwpiZVVqUX58UWl
        OanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTBN+zfNyOLufGdxqfQ+Y4d/Igwr
        /rWGBPm/8l9VpnLqPptOSYewVnveWjYRG9fZYZMqj50NmnJla9bOCtdf1T8P2iyUslue9PLu
        VQXb21xH6zuefv/AlHTA98Z5qyevXR49SJYy/73r87QPGYtM6i5cPNKjErj/XdDatoYVL6xb
        BQvKOXo+GTo+iDlo1eW/bnlIIcu2pxZ21SFpX47dk3H/qP1t6cz2/mAr8RXb8vOub313qi10
        8+/qqJsHW3a1Tt729L7iVLcuGX/FDWwMre8nb6uYdktlnW32+gqTM6kd9n7b/sRYG2t5dS3v
        ujKlX69N60JpVrNUqpvBVsn698s+v7272+5UvnjLDrs/C84rsRRnJBpqMRcVJwIAgZtA/fgC
        AAA=
X-CMS-MailID: 20200605075349epcas1p1b5279de123f6dcda03b71d61361db715
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200604045437epcas1p17180ef9b61d8ff1d4877c49755e766a2
References: <CGME20200604045437epcas1p17180ef9b61d8ff1d4877c49755e766a2@epcas1p1.samsung.com>
        <1591246468-32426-1-git-send-email-hyeongseok@gmail.com>
        <3b5501d63a4d$4213b950$c63b2bf0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> > There is check error in range condition that can never be entered even
> > with invalid input.
> > Replace incorrent checking code with already existing valid checker.
> >
> > Signed-off-by: hyeongseok.kim <hyeongseok@gmail.com>
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
> 
> Looks good. Thank you!
Applied. Thanks!

