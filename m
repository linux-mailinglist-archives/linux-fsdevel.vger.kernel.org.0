Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92AD26B9CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 04:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIPCWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 22:22:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63591 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIPCWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:22:22 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200916022218epoutp046b81e4d9093479c96a1fe405c6bbdf02~1IkjLTj5C0813408134epoutp045
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 02:22:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200916022218epoutp046b81e4d9093479c96a1fe405c6bbdf02~1IkjLTj5C0813408134epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600222938;
        bh=Sj28rhX7L+myUlYy8n3SHdDM87JorFrFrqfkmoC2nUk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=koDvGUmNTpTFgmJ5rqtZskaYwdf7X8LN4AiiotKYXldv64bdweDXUdI2pmx5YBE11
         b/jskSRZDKm2p+VrJ4y09/BpDqfUWfDie+dC8mLtwqTDbihnPNNkv8LzGOiV1U7fgH
         0CtF0BGblRx8zzWevpMcBmuD1p1wAnvDanTN4hzs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200916022218epcas1p2691fb7947d65795b69cfb8bf93c4c13e~1IkilNLjm1211712117epcas1p2C;
        Wed, 16 Sep 2020 02:22:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BrkQ049P3zMqYky; Wed, 16 Sep
        2020 02:22:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.43.29173.4D6716F5; Wed, 16 Sep 2020 11:22:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200916022212epcas1p2048ed766ab7dd75fe43bc1996a62d2a3~1IkdooJ3I1211712117epcas1p2y;
        Wed, 16 Sep 2020 02:22:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200916022212epsmtrp2d045953f0d9c90b36531f0df82c447e5~1Ikdn4kcK2035820358epsmtrp2f;
        Wed, 16 Sep 2020 02:22:12 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-3a-5f6176d42d74
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.49.08382.4D6716F5; Wed, 16 Sep 2020 11:22:12 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200916022212epsmtip194f34abdbf302bd5ebb81bb739a31bb3~1IkdePnUU0164401644epsmtip1a;
        Wed, 16 Sep 2020 02:22:12 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200911044439.13842-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/3] exfat: remove useless directory scan in
 exfat_add_entry()
Date:   Wed, 16 Sep 2020 11:22:12 +0900
Message-ID: <015d01d68bd0$2fc6bb60$8f543220$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMWI+I2pfTF2STIlR6k2ufb8Rwp/wJPNK8aptjeoIA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmge7VssR4g/4vrBY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMmY/WUDY8FEzopZbzuZGxgXsncxcnJICJhIPD7cy9LFyMUhJLCDUeLimm2sIAkh
        gU+MEjv7VSAS3xgl9mw8wQjTsXr5KlaIxF5GiQMH57BBOC8ZJbq+fGEBqWIT0JV4cuMnM4gt
        IqAncfLkdTYQm1mgkUnixMvsLkYODk4BS4kHHUYgYWGBEInzz6+BtbIIqEpsufebFaSEF6jk
        7W95kDCvgKDEyZlPWCCmyEtsfzuHGeIeBYndn46yQmyyktjz8AVUjYjE7M42ZpDTJAQWckjc
        u7GIBaLBRWL/sj6oZ4QlXh3fAg0KKYnP7/ayQdj1Ev/nr2WHaG5hlHj4aRsTyEESAvYS7y9Z
        gJjMApoS63fpQ5QrSuz8PZcRYi+fxLuvPawQ1bwSHW1CECUqEt8/7GSB2XTlx1WmCYxKs5B8
        NgvJZ7OQfDALYdkCRpZVjGKpBcW56anFhgXGyFG9iRGcSLXMdzBOe/tB7xAjEwfjIUYJDmYl
        Ed4DjfHxQrwpiZVVqUX58UWlOanFhxhNgUE9kVlKNDkfmMrzSuINTY2MjY0tTMzMzUyNlcR5
        H95SiBcSSE8sSc1OTS1ILYLpY+LglGpgOuFRcCVKsk3+0s0z7wuW2AdJsW8wrDwuk1edq9Su
        e/6Jw9o3J58/Ee0/KVz/NXuGxje3yOfTj67PdTa/z+b5NOHpVzFxw5RnvEpbF8Ryv5Bi9lt4
        JkdQnauw7NrXy9xlfxNFglRW3jH9WzCpTnvpzKQH071mSNoLLDucp+0SHuL9dmvwxVfv/zzP
        M9O+ZN5xccbjV4YC5qz9/w/fnKA4OXD2ZultRiHf7f2f5u1U1Pu/JXv/kpiV7VOm9q5+vuc6
        o2j3G5GkewbbXM5ve9Eockjrt92FH71va/7UqbzaEczdVMsf1ce3yF3qzlWO/e8v9E2Uz4r+
        deTE+9Y9c6cGuJxbcPB9ybwXZfIWkxneSCqxFGckGmoxFxUnAgBZNT07LQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTvdKWWK8wbr3qhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlzP6ygbFgImfFrLedzA2MC9m7GDk5JARMJFYvX8XaxcjF
        ISSwm1GiqeU5YxcjB1BCSuLgPk0IU1ji8OFiiJLnjBIz1zxiAellE9CVeHLjJzOILSKgJ3Hy
        5HU2kCJmgWYmidYvzUwQHV2MErfeb2UDmcQpYCnxoMMIxBQWCJJ4/ZANpJdFQFViy73frCBh
        XqCKt7/lQcK8AoISJ2c+YQEJMwONb9vICBJmFpCX2P52DjPE9QoSuz8dZYW4wEpiz8MXLBA1
        IhKzO9uYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7u
        JkZwNGlp7mDcvuqD3iFGJg7GQ4wSHMxKIrwHGuPjhXhTEiurUovy44tKc1KLDzFKc7AoifPe
        KFwYJySQnliSmp2aWpBaBJNl4uCUamBSvlZQ7pS1cy6f0qx7F94vequxUs+UOehR2p/5zluy
        DO9nrg/axR+yajVHunugdXfDkkV/y3eZNCqrumza/E0/6p9RzRGngnmCBaneyqnzDL7KTHFZ
        nftI1dhv4sOdHHO6L1h/XHK75VMy854CcX+e4PfTzk5j8VuSImCzLiT+o/y6/dzrEv9+fbQj
        XCBA87DDvElh77cv3q0Rub9a+MCbh45eSzkkJoXcPfnoo9sx7qqNzxLZ975Y3pbUuuqmUVJX
        YvFN3SkKd/JSLtdMu9c6P2ouj248C29fg7HArQYvphL9nXzJm1SUju/MYCqNNVnsVvjhwaQo
        tfcsHy3ePZFY8fdZnN2xY6tY1zgFZDErsRRnJBpqMRcVJwIA9iQDIRUDAAA=
X-CMS-MailID: 20200916022212epcas1p2048ed766ab7dd75fe43bc1996a62d2a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200911044449epcas1p42ecc35423eebc3b62428b14529d6a592
References: <CGME20200911044449epcas1p42ecc35423eebc3b62428b14529d6a592@epcas1p4.samsung.com>
        <20200911044439.13842-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> There is nothing in directory just created, so there is no need to scan.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/namei.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> b966b9120c9c..803748946ddb 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -530,19 +530,10 @@ static int exfat_add_entry(struct inode *inode,
> const char *path,
>  		info->size = 0;
>  		info->num_subdirs = 0;
>  	} else {
> -		int count;
> -		struct exfat_chain cdir;
> -
>  		info->attr = ATTR_SUBDIR;
>  		info->start_clu = start_clu;
>  		info->size = clu_size;
> -
> -		exfat_chain_set(&cdir, info->start_clu,
> -			EXFAT_B_TO_CLU(info->size, sbi), info->flags);
> -		count = exfat_count_dir_entries(sb, &cdir);
> -		if (count < 0)
> -			return -EIO;
> -		info->num_subdirs = count + EXFAT_MIN_SUBDIR;
> +		info->num_subdirs = EXFAT_MIN_SUBDIR;
>  	}
>  	memset(&info->crtime, 0, sizeof(info->crtime));
>  	memset(&info->mtime, 0, sizeof(info->mtime));
> --
> 2.25.1


