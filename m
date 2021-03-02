Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5632A520
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443403AbhCBLrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:32 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:35123 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbhCBG4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:56:19 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210302065454epoutp02dfc75ca65d82175f164b7942d9a5757d~odBPUrkpY1834418344epoutp02V
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 06:54:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210302065454epoutp02dfc75ca65d82175f164b7942d9a5757d~odBPUrkpY1834418344epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614668094;
        bh=DliXzqFkxMgF30IQ84dS6zeqHegjNaRZkb9cDXxw4mQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NPUeYhE8kQL6lyEpEx03Qbae6HKzqLQ3F1GFL1KFEVBtzzApv3RAZ3t74UNqn6FFC
         ubBhE2RToZs2u9M5HA5muy81YX/kqhGgWdonPt5ZWoCq+p+5MecL05s7J5f8kbopMU
         ua+PfCYuQkvlfs/nIbwMyRK6H4Va0TJI7v78RXbc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210302065454epcas1p355b95a88ee561da92a3b113f0902e596~odBO8-QvP0064200642epcas1p3U;
        Tue,  2 Mar 2021 06:54:54 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DqSYT15pCz4x9Pv; Tue,  2 Mar
        2021 06:54:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.23.02418.D31ED306; Tue,  2 Mar 2021 15:54:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210302065452epcas1p254e20208b86fc68be1303bc7ab230303~odBNL7zZ02915529155epcas1p2Y;
        Tue,  2 Mar 2021 06:54:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210302065452epsmtrp2b18eda2cff5a5226051c5dd89949cbb7~odBNLJq9J0481104811epsmtrp2Q;
        Tue,  2 Mar 2021 06:54:52 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-ce-603de13d032d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.8E.13470.C31ED306; Tue,  2 Mar 2021 15:54:52 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210302065452epsmtip21938a1c70c96358623ac6369d415b524~odBM70AdY0702607026epsmtip2L;
        Tue,  2 Mar 2021 06:54:52 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20210302050521.6059-2-hyeongseok@gmail.com>
Subject: RE: [PATCH v4 1/2] exfat: introduce bitmap_lock for cluster bitmap
 access
Date:   Tue, 2 Mar 2021 15:54:51 +0900
Message-ID: <04a901d70f30$f167af70$d4370e50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGcWnf6BTkYMyzP2LJXG6KPoRfNLgFpn8c6AfaWP3KqyqpeMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQNf2oW2CwdRmVou/Ez8xWezZe5LF
        4vKuOWwWP6bXW2z5d4TVgdVj56y77B59W1YxenzeJBfAHJVjk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2VoYGBkClSZkJPx+MwutoJ3TBUnZsxia2BcxdTF
        yMkhIWAi8f3mEdYuRi4OIYEdjBKrup6xQTifGCWur53LBOF8Y5Q4dW8tK0zLzQ3roFr2Mkpc
        +dTHCOG8ZJS4sa+NEaSKTUBX4smNn8wgtoiAh8TjpmNgC5kF4iV2T+sDq+EUsJQ41jOVDcQW
        FgiReNr8nR3EZhFQkZi58AWYzQtUs/1IC5QtKHFy5hMWiDnyEtvfzmGGuEhBYveno6wQu5wk
        7u/ayg5RIyIxu7ONGeQ4CYGf7BI7f35nhGhwkZh2/xAbhC0s8er4FnYIW0ri87u9UPF6if/z
        17JDNLcwSjz8tA3oAw4gx17i/SULEJNZQFNi/S59iHJFiZ2/5zJC7OWTePe1hxWimleio00I
        okRF4vuHnSwwm678uMo0gVFpFpLPZiH5bBaSD2YhLFvAyLKKUSy1oDg3PbXYsMAQObY3MYKT
        o5bpDsaJbz/oHWJk4mA8xCjBwawkwnvys2WCEG9KYmVValF+fFFpTmrxIUZTYFhPZJYSTc4H
        pue8knhDUyNjY2MLEzNzM1NjJXHeJIMH8UIC6YklqdmpqQWpRTB9TBycUg1M25XrQvdZBws6
        pSisXv9H0EUupNvjMgPjcqbudrvdDqu2cO7ZtVY+PCckp+XjPmn79vOdl37l/n0tN+vrdCne
        zsmXvJh7QlQrfA9aZmuvX/FtKaekG1vfPa0D+VEXmjcbGf981ejitHP2HK8kvclfeayePLh2
        5NTXyTF35nX8Xfi7VyoutDX8pGBR0FGVq0qLD1Tc8+3QNeE/HheQsNWoVaxRXurSjrInvcE7
        zi7fuPOL8UfzKRtqst42GEi0vXc3cLqXGtt8L+vqJzn+4pkC2Qfyr12cnFXbeODnQT+dVYf9
        fa5seVxt6Xpo9qp9Sbf8q2an/l4y8deRh+yeakGfi1mXNmeFz2246VPG8eq3EktxRqKhFnNR
        cSIA3pj7IBcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvK7NQ9sEg8dv5Cz+TvzEZLFn70kW
        i8u75rBZ/Jheb7Hl3xFWB1aPnbPusnv0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxuMzu9gK
        3jFVnJgxi62BcRVTFyMnh4SAicTNDetYuxi5OIQEdjNKnDp5gLmLkQMoISVxcJ8mhCkscfhw
        MUi5kMBzRomzU2RAbDYBXYknN34yg9giAl4S+5tes4PYzAKJEs1fLjFBjNzOKHHtczvYLk4B
        S4ljPVPZQGxhgSCJqSs2gDWzCKhIzFz4AqyZF6hm+5EWKFtQ4uTMJywgNzAL6Em0bWSEmC8v
        sf3tHGaI8xUkdn86ygpxg5PE/V1boW4QkZjd2cY8gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVML
        inPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjQ0tzB+P2VR/0DjEycTAeYpTgYFYS4T352TJB
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqaq3a/9/Fpt
        Vd6aBh48/9YnxPXwgq5n3NH80+I4VsX59PjULWm/tWTKmu93wxX4zuzZeeiW5MXJz3va4yyk
        LJ9Pen82dt1MhbN6R5ad0L3Cnba/WE8+8sNJZZcHp8TcHMoUTq4VKVf/2v/a53LftgeFJ1Pf
        datPcrN5qHnrQH3SjkCPg0p+y98+5xDTOfnG6++nFQst15TFc3b6n3PeurHXIb1S/s6Rg1WN
        N2Yfiygp8zn/TfZou+KnGh3/Ca4VhZqXf+6/n2htm6KXrhqz8+katWWL+eYvOCH0N573Svej
        xmpBq4IHaXGvWd/t/7/GMib3E5/MBpk7jcZiZaEi8xhqDnVnvW47J/NoX0bhlz1KLMUZiYZa
        zEXFiQDuYfg5/QIAAA==
X-CMS-MailID: 20210302065452epcas1p254e20208b86fc68be1303bc7ab230303
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210302050550epcas1p19adbc16f7c61a7988705f3ae91b4060a
References: <20210302050521.6059-1-hyeongseok@gmail.com>
        <CGME20210302050550epcas1p19adbc16f7c61a7988705f3ae91b4060a@epcas1p1.samsung.com>
        <20210302050521.6059-2-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> s_lock which is for protecting concurrent access of file operations is too
> huge for cluster bitmap protection, so introduce a new bitmap_lock to
> narrow the lock range if only need to access cluster bitmap.
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>

Looks good.
Thanks for your work!

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

