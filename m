Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7497847BFC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhLUMfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 07:35:04 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43796 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhLUMfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:35:03 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211221123501epoutp0346b2a7a2e401846aeda0ec8806a3b903~CxUIAEuZi2985329853epoutp03W
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 12:35:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211221123501epoutp0346b2a7a2e401846aeda0ec8806a3b903~CxUIAEuZi2985329853epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640090101;
        bh=Aeqo+mXKuiCD3XJXF1+HfvuVW14emznO9LhB06v5ZZs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rsvcv1kXZHBw0ZvemawsQslK6o9r0sI45W4UlxKR5PRReiALKRpc0b7CahJMSam+g
         XrUIw6uRIAgwHh9ohHUyFwIZTtDm70s2nYWXRbu0e8V8zjYSRoM+mNckcS4Q7Mq0A8
         21Jp9Ydbu/HSwcMK7IKRSrwpm27YldfMCXFP3j+E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211221123501epcas1p10e8a7a2ff29cab2ee89d74bcac960b17~CxUHuaguQ3242432424epcas1p1I;
        Tue, 21 Dec 2021 12:35:01 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JJGBC6Hh3z4x9Pq; Tue, 21 Dec
        2021 12:34:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.3D.09592.3F9C1C16; Tue, 21 Dec 2021 21:34:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211221123459epcas1p272986a09cd62b9427269700df16ac08a~CxUFpYyOX0196301963epcas1p2C;
        Tue, 21 Dec 2021 12:34:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211221123459epsmtrp231e18cb666cebd25d27b59a432f22434~CxUFotkVx2382123821epsmtrp2T;
        Tue, 21 Dec 2021 12:34:59 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-35-61c1c9f399fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.A5.08738.2F9C1C16; Tue, 21 Dec 2021 21:34:58 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211221123458epsmtip1dc0e0dfc4c0c34165c1b3e11f93a75bb~CxUFcYMRR3187031870epsmtip1m;
        Tue, 21 Dec 2021 12:34:58 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <HK2PR04MB3891563FC310AE5E70896932817B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Subject: RE: [PATCH] exfat: fix missing REQ_SYNC in exfat_update_bhs()
Date:   Tue, 21 Dec 2021 21:34:58 +0900
Message-ID: <002001d7f667$2a968190$7fc384b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHJ22daV37VIoTUQqGa996KyhXcpAHh1MBHrEn4ssA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmru7nkwcTDQ6uNrKYOG0ps8WevSdZ
        LC7vmsNmseXfEVYHFo9NqzrZPPq2rGL0+LxJLoA5KtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE748PZ3ywFD3kqjszMa2DcxtXFyMkhIWAi
        8eD+f7YuRi4OIYEdjEDOFBYI5xOjxMV9vVCZz4wSvcc2ssK0TN5wDCqxi1Hi0OyLUC0vGSW+
        PPzBBlLFJqAr8eTGT2YQW0RAWmLexSlMIDazQLzE4h3HwWo4BWIlTpycygJiCwu4SSz4Pwms
        hkVAVaLjwTVGEJtXwFLi3YNWJghbUOLkzCcsEHPkJba/ncMMcZGCxO5PR1khdllJNK6HsJkF
        RCRmd7YxgxwnIfCVXWLFmr1QL7hIrN8zkx3CFpZ4dXwLlC0l8fndXjaIhumMEpO7L0E5qxkl
        bt66DrSaA8ixl3h/yQLEZBbQlFi/Sx+iV1Fi5++5jBCL+STefe1hhajmlehoE4IoUZH4/mEn
        C8yqKz+uMk1gVJqF5LVZSF6bheSFWQjLFjCyrGIUSy0ozk1PLTYsMIbHdnJ+7iZGcErUMt/B
        OO3tB71DjEwcjIcYJTiYlUR4t8zenyjEm5JYWZValB9fVJqTWnyI0RQY2BOZpUST84FJOa8k
        3tDE0sDEzMjEwtjS2ExJnPeF//REIYH0xJLU7NTUgtQimD4mDk6pBibj3frSb0P8k4pkn/Dv
        FJj1vSemZe772Gxhie3Thax458U7b/O11rvE0Wa7eW+GNstixx16sh/f5baJXeuN+7TzlXKY
        3G2BQ5wPpu5dxbFoft+jEjaradO+BiT39521OcDTnh5j8Hqf7kqmlr6ZT/14D9UISbgZnt8o
        56z6hnnFzegrEZ+fHbuSWipwIa1xzryXW1Q9vPs31mqtX3z/xJ4bW0p9mA/VLtXSnRl2cHpN
        Nd8tUaHZV2a9mPlWJDO0WZNl+f4LO5vM18vY7VnfeU6lf129fXmj8uk1e9gc/dZyTfDVe3B5
        haPT0TDjrGrBt+oF5VovX29w+nXj/qULH/fkxAuen7nV8++zRctsz91VYinOSDTUYi4qTgQA
        Ppu6cRIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO6nkwcTDY6c0LSYOG0ps8WevSdZ
        LC7vmsNmseXfEVYHFo9NqzrZPPq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSvjw9nfLAUPeSqO
        zMxrYNzG1cXIySEhYCIxecMxti5GLg4hgR2MEj1vLjB2MXIAJaQkDu7ThDCFJQ4fLoYoec4o
        sXbPW1aQXjYBXYknN34yg9giAtIS8y5OYQKxmQUSJc4saWOFaFjHKPGqazZYEadArMSJk1NZ
        QGxhATeJBf8ngTWwCKhKdDy4xghi8wpYSrx70MoEYQtKnJz5hAXkCGYBPYm2jYwQ8+Ultr+d
        wwxxv4LE7k9HWSFusJJoXA9hMwuISMzubGOewCg8C8mkWQiTZiGZNAtJxwJGllWMkqkFxbnp
        ucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFRoaW1g3HPqg96hxiZOBgPMUpwMCuJ8G6ZvT9RiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqa5NtwTHhpKsb3a
        0mT9YOOFOcFW274EbDp268bXqWxXrjudl3qnYxB63tRbJ+22dP4/Dt5769r1ue7+Cv4wc1dk
        y8e0s/tY24P/ns9JmLsxdGZb45M1UWd/W4fGJ6zmqflje4/H7dyvhIUFi5nFP23aVPNVfaYr
        6zPVL3JG5gt/xRd0OfG2P3ZUW/rDjZ3xHs/a3tSFEaXiThH5hWqWy8NuyrFonnnI0xp+Lkjz
        wp+02/F71Tfkrpw+Rzeg+O2v+R+Lc81FLonrJz1o6/m8X9qr+vqb/itvD9qxMEvUWgU3lNmK
        hoVdEF9+Ncpifp6wU8rBK0pGEjKrGVx+vtwYtcK57+Hh9FkWp49EcbAnGyuxFGckGmoxFxUn
        AgDpgBTx+QIAAA==
X-CMS-MailID: 20211221123459epcas1p272986a09cd62b9427269700df16ac08a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211220015249epcas1p4870b0ee2aeedbc4ca3b0b6e39361d4bb
References: <CGME20211220015249epcas1p4870b0ee2aeedbc4ca3b0b6e39361d4bb@epcas1p4.samsung.com>
        <HK2PR04MB3891563FC310AE5E70896932817B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If 'dirsync' is enabled, all directory updates within the
> filesystem should be done synchronously. exfat_update_bh()
> does as this, but exfat_update_bhs() does not.
> 
> Signed-off-by: Yuezhang.Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy.Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama, Wataru <wataru.aoyama@sony.com>
> Reviewed-by: Kobayashi, Kento <Kento.A.Kobayashi@sony.com>
> ---
>  fs/exfat/misc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> index d34e6193258d..d5bd8e6d9741 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -10,6 +10,7 @@
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/buffer_head.h>
> +#include <linux/blk_types.h>
> 
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -180,7 +181,7 @@ int exfat_update_bhs(struct buffer_head **bhs, int
> nr_bhs, int sync)
>  		set_buffer_uptodate(bhs[i]);
>  		mark_buffer_dirty(bhs[i]);
>  		if (sync)
> -			write_dirty_buffer(bhs[i], 0);
> +			write_dirty_buffer(bhs[i], REQ_SYNC);

I think there is no problem in terms of functionality related to
"synchronously" in the original code. However, REQ_SYNC could affect
I/O scheduling, and exfat_update_bh() already requests I/O with this
flag by calling sync_dirty_buffer(). And it is desirable for two
functions to have the same concept for I/O requests.

So, the original code does not seem like a bug,
but this patch looks useful.
Thanks.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

>  	}
> 
>  	for (i = 0; i < nr_bhs && sync; i++) {
> --
> 2.25.1

