Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC31F2E03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 02:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgFIAib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 20:38:31 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35150 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgFIAh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:37:57 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200609003750epoutp01d5249be4735d73be62755a08ded2730a~WuSE43cEd2325523255epoutp014
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 00:37:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200609003750epoutp01d5249be4735d73be62755a08ded2730a~WuSE43cEd2325523255epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591663070;
        bh=q10Na41zgCObZAxAJMn9N7qtdNyK7r4tQYvR2kZZd4M=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=F5gn54VAk//Z48by8f0X1qw7NBjCk+0p+SJ6Ys0x34hy/y57sjAVmF2okhPW5okpz
         yH9nMkvmBy3+UdIqkqoludKuWhr51Pe9EXnegOBoCn7pNCFsG0hGiDpsP+mb7+VkxX
         WakJsBMc/L2mpt2i2iLE+fmqMhkpkT1ivx0VRU+Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200609003750epcas1p3a17b1b95b0ef23dcd1c1988f6fcb98b8~WuSEgedWT2513525135epcas1p3b;
        Tue,  9 Jun 2020 00:37:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49grn92QpvzMqYkX; Tue,  9 Jun
        2020 00:37:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.EF.29173.DD9DEDE5; Tue,  9 Jun 2020 09:37:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200609003748epcas1p1f034333f92535dc97f26cd9f49560551~WuSDSQ7yK2846528465epcas1p1N;
        Tue,  9 Jun 2020 00:37:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609003748epsmtrp26ce49200a9880f5e57c12609a201fea4~WuSDRsbRP0964509645epsmtrp2A;
        Tue,  9 Jun 2020 00:37:48 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-27-5eded9dd804b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.51.08382.CD9DEDE5; Tue,  9 Jun 2020 09:37:48 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609003748epsmtip16b4f0313886b6c2080097ae6ffaf5729~WuSDJNifI1188711887epsmtip1W;
        Tue,  9 Jun 2020 00:37:48 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>
Cc:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
In-Reply-To: <20200608141629.GA1912173@mwanda>
Subject: RE: [PATCH] exfat: Fix pontential use after free in
 exfat_load_upcase_table()
Date:   Tue, 9 Jun 2020 09:37:48 +0900
Message-ID: <00a401d63df6$3370adc0$9a520940$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHN6CJjsnVWAfliAKZmdf3Bml3OWAGGpuqaqNPltlA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTQPfuzXtxBtM/81m8/jedxWLrLWmL
        H3Nvs1js2XuSxeLyrjlsFlv+HWF1YPPYOesuu8fHp7dYPPq2rGL0+LxJLoAlKscmIzUxJbVI
        ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2i3kkJZYk4pUCggsbhY
        Sd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ6N99XTmgrNs
        Fe8/tLA1MM5l7WLk5JAQMJHYu2AXO4gtJLCDUeLaQqkuRi4g+xOjxMz1N9ggnG+MElea3zLB
        dNx9858JIrGXUWJu5xSo9peMEsfuxoDYbAK6Ev/+7GcDsUUEDCTunXzBAtLALHCYUeJix0yw
        SZwCehKrbs9lBrGFBSIkvj55zAhiswioSMy9dgOshlfAUuLcj/1QtqDEyZlPWEBsZgF5ie1v
        5zBDXKQg8fPpMlaIZVYSv8/uZ4WoEZGY3dnGDLJYQqCXQ+LL1p9QT7tITJz5kw3CFpZ4dXwL
        O4QtJfH53V6gOAeQXS3xcT/U/A5GiRffbSFsY4mb6zewgpQwC2hKrN+lDxFWlNj5ey4jxFo+
        iXdfe1ghpvBKdLQJQZSoSvRdOgwNQ2mJrvYP7BMYlWYheWwWksdmIXlgFsKyBYwsqxjFUguK
        c9NTiw0LjJHjehMjOFlqme9gnPb2g94hRiYOxkOMEhzMSiK81Q/uxAnxpiRWVqUW5ccXleak
        Fh9iNAUG9URmKdHkfGC6ziuJNzQ1MjY2tjAxMzczNVYS5/W1uhAnJJCeWJKanZpakFoE08fE
        wSnVwFR1zlnrmMbN7T/nPWZmnJE5N+/zKhFf5a+da/bcdn2Xfvjcdp5tfxXj129Ozpd99Cck
        bPqZAnXxgqerX4od3dzdGBu0+Z7EhuqXy+b/+8TIe/pUnIXOGgOVV6rnCxclb0jmdQqaEMZg
        0BzgptUvpn/bvDegPnzLn/igT1UTzZ2Xme/zzdCalnVDOGp1jO7bsGNTXn48Y+a417nll0Sd
        Wznf9Lfc2768/cj+xWWGh7n/tYbbcb8Ymi1m3pp702nm0tgJlyqmySTd5s7I0dHm4GY6pj7j
        yxXB1kgl06l5T/d42/E/4oirvfevNErkXuDaXuvHzq8WqExY8/zq6TNrNvDVGR493etxUuf0
        tMYK5UVKLMUZiYZazEXFiQC2EZnSHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO6dm/fiDP4uMbN4/W86i8XWW9IW
        P+beZrHYs/cki8XlXXPYLLb8O8LqwOaxc9Zddo+PT2+xePRtWcXo8XmTXABLFJdNSmpOZllq
        kb5dAldG++rpzAVn2Sref2hha2Ccy9rFyMkhIWAicffNf6YuRi4OIYHdjBLbuuZAJaQljp04
        w9zFyAFkC0scPlwMUfOcUeLSkVnMIDVsAroS//7sZwOxRQQMJO6dfMECUsQscJRRovVXD1hC
        SKBeYvHhKUwgNqeAnsSq23PBmoUFwiTWHbjNCGKzCKhIzL12A6yGV8BS4tyP/VC2oMTJmU9Y
        QI5gBupt2whWziwgL7H97RxmiDsVJH4+XcYKcYOVxO+z+1khakQkZne2MU9gFJ6FZNIshEmz
        kEyahaRjASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4KjR0tzBuH3VB71DjEwc
        jIcYJTiYlUR4qx/ciRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6NwYZyQQHpiSWp2ampBahFM
        lomDU6qBaX7R669X87r1Q84GPbqaJbl7edv1eCXNqo/XdqrefNtmZX1iqc/aL3eSgnb/DPA/
        fbuqc+MXry9TDq1uuZBV+jvihL2p5fK7pfu+lIlwK+Waxn6q6XubuWsLt2SkW23Ah7MLsrpd
        J767Is9TFL6nwvhD14k3bz7tetz5ROpkxl2NIxe+Tv2eZ7jhWVlSOZO5n06l+tl7G/a8vNp5
        6bS8ve/SuxKsYgryliHVNh7MZ94qLJKxiGI6z2mZsCWYa2HWiV9umTpPVkfOTdxtMv+u/Ham
        tScNfm7+PbfZO+MTT3DsjbbjNXPDZq+0ki5t23z5UG+/dLT6y1tZlZNWHD6sqXGiPWv+7YcP
        rjOv1Ghu/qjEUpyRaKjFXFScCADf18VmCQMAAA==
X-CMS-MailID: 20200609003748epcas1p1f034333f92535dc97f26cd9f49560551
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200608141649epcas1p14558f3552afb0fcd3cd32a8c09afb880
References: <CGME20200608141649epcas1p14558f3552afb0fcd3cd32a8c09afb880@epcas1p1.samsung.com>
        <20200608141629.GA1912173@mwanda>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This code calls brelse(bh) and then dereferences "bh" on the next line resulting in a possible use
> after free.  The brelse() should just be moved down a line.
> 
> Fixes: b676fdbcf4c8 ("exfat: standardize checksum calculation")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied. Thanks!
> ---
>  fs/exfat/nls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c index c1ec056954974..57b5a7a4d1f7a 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -692,8 +692,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
>  				index++;
>  			}
>  		}
> -		brelse(bh);
>  		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
> +		brelse(bh);
>  	}
> 
>  	if (index >= 0xFFFF && utbl_checksum == chksum)
> --
> 2.26.2


