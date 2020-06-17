Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9101FC856
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgFQIKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 04:10:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62924 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgFQIKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:10:36 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200617081033epoutp04bf73df3e0ef50fe91db5bc4855355e92~ZRnoBXKOF2005720057epoutp04w
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 08:10:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200617081033epoutp04bf73df3e0ef50fe91db5bc4855355e92~ZRnoBXKOF2005720057epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592381433;
        bh=6vBzU09E7w5ohkmbvcEsyaVQaTCwxwjlhZoB0mwElNw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qC3A3IiIjrTtLfQmzefJ/IVNwmsSodYJEV3LTQftYnS6+tK8vEeqm2L0MvrnTcBVb
         xcTnAmL3WvIWxgljyoW5UTC+7KJpr0u0sdx/F/MGLd/7JS+ruhXQIoMdzGH7bQYQQm
         d4UdUtHeQrOhcrmyrVxGttaIhSqKCrNcZwuxD9ig=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200617081032epcas1p1df60b68c9bddac884944dfae8bf306ff~ZRnnqeNU32850828508epcas1p1g;
        Wed, 17 Jun 2020 08:10:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49myRq4PhLzMqYlp; Wed, 17 Jun
        2020 08:10:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.48.28581.6FFC9EE5; Wed, 17 Jun 2020 17:10:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200617081029epcas1p40ea7f1a3c20c83191d8547edb71648a5~ZRnkeouBL1218912189epcas1p47;
        Wed, 17 Jun 2020 08:10:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200617081029epsmtrp2d3f6269030e73b83a8e229e452a73e4f~ZRnkcwnH22839328393epsmtrp2k;
        Wed, 17 Jun 2020 08:10:29 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-c2-5ee9cff66040
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.DD.08382.5FFC9EE5; Wed, 17 Jun 2020 17:10:29 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200617081029epsmtip1788b93e9b8ce8991b83b76a39b4a9d20~ZRnkQPbMG2917829178epsmtip1d;
        Wed, 17 Jun 2020 08:10:29 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200616053445.18125-1-hyc.lee@gmail.com>
Subject: RE: [PATCH v2] exfat: call sync_filesystem for read-only remount
Date:   Wed, 17 Jun 2020 17:10:28 +0900
Message-ID: <42fb01d6447e$c372d860$4a588920$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJvI9IWjSo26kFx55d3RL5JRBWksAG87Uq/p5zOWdA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmge638y/jDBZtZLW4dv89u8WevSdZ
        LC7vmsNm8WN6vQOLx85Zd9k9+rasYvT4vEkugDkqxyYjNTEltUghNS85PyUzL91WyTs43jne
        1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaJmSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
        tSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY8miH0wFO3kqFk+7wtbA+Jmzi5GTQ0LA
        ROJm91FGEFtIYAejxK6uii5GLiD7E6PE6ldn2SGcb4wSreevsXQxcoB17JxfDhHfyygxc89z
        NgjnJaPEj85/LCCj2AR0JZ7c+MkMYosIhEr0d00CW8Es4Cxx+MYpZpBBnALmEv0z80BMYQFP
        iR8fYkAqWARUJXZPO8MEYvMKWEr8n7uKBcIWlDg58wkLxBR5ie1v5zBDPKAgsfvTUVaQMSIC
        VhJzXkKViEjM7mxjBrlMQuAru0Tn2tMsEPUuEq3vu9ggbGGJV8e3sEPYUhKf3+2FitdL7F51
        igWiuYFR4sijhVDNxhLzWxaCnc8soCmxfpc+RFhRYufvuVAf8km8+9rDCgkqXomONiGIEhWJ
        7x92ssCsuvLjKtMERqVZSD6bheSzWUhemIWwbAEjyypGsdSC4tz01GLDAhPkmN7ECE6FWhY7
        GOe+/aB3iJGJg/EQowQHs5IIr/PvF3FCvCmJlVWpRfnxRaU5qcWHGE2BYT2RWUo0OR+YjPNK
        4g1NjYyNjS1MzMzNTI2VxHlPWl2IExJITyxJzU5NLUgtgulj4uCUamCy9A6V22j7fFbtRV82
        7km7WEyfzZLbErdjyrpdmqdfRfxkWT7l6r2WjxrTXLXiX3OdTT/OfcfnoLGkncaz5I6dosIW
        r7o11aLjJqdrzW4/XrsxyMLIRO6U/sY8s4bKmRcOM6W97nzY9v3hCvadVw4Z8Tu/LpzqahVZ
        ov6sqenOr7PXjKb2SYrt1V/84unVh5dnbjTpzV35uaLQeOqd/kSn0OXrUiVKbJetvVSyYa7V
        q0QOvYe8zjZ73uzIebTvPzd71L64TOfz3RYZDFpFDYybdkuusmc4cddP6MUyC/3tU8R3/r9m
        lNgWzDQr9UZeVOOH9R3/H3Flhq1+tfvYzu3bjPQKtNf9e7LAVl058rW0EktxRqKhFnNRcSIA
        OuOiBA4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO7X8y/jDDp72C2u3X/PbrFn70kW
        i8u75rBZ/Jhe78DisXPWXXaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyliy6AdTwU6eisXT
        rrA1MH7m7GLk4JAQMJHYOb+8i5GLQ0hgN6PE/pfvmSHiUhIH92lCmMIShw8XQ5Q8Z5Q48LyZ
        qYuRk4NNQFfiyY2fzCC2iECoxKJPZ9hBbGYBV4n5z1ezQTR0MEpMmb+CBWQQp4C5RP/MPBBT
        WMBT4seHGJByFgFVid3TzoCN5BWwlPg/dxULhC0ocXLmE7BOZgE9ibaNjBDT5SW2v50DtlVC
        QEFi96ejrCAlIgJWEnNeskCUiEjM7mxjnsAoPAvJoFkIg2YhGTQLSccCRpZVjJKpBcW56bnF
        hgWGeanlesWJucWleel6yfm5mxjB0aCluYNx+6oPeocYmTgYDzFKcDArifA6/34RJ8SbklhZ
        lVqUH19UmpNafIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgsEwenVAOTveFs9wPBPkZPCw2E
        3z7859Ytus7ReVVYecK8/4d8eROX7xfi5jho3PBr5rqOKe+uPyg/vfxLgPjcxN+fsv6FOK5J
        CduaxC69mtP8ryHLmZmPTv+YF/3tw6oGL2Opz+ZB2Taz5tgreBYGzfadqnRn02YfQS39321/
        FmeUCL6d2pDS91d710bNrkfe7yKvGJnsPGzzVeDMx+j0vMWlO2f/OhrT8+HkJ87D7xKc98ca
        LfmgtCfvm0er5+2+z/yv3ZjPnFdjXXZi9Z317bvOZl079nHvtqjPW+LuMLomzTMsWP74vfzq
        y9dPW7xUFU1fvF3hL1uf0WExBwmF+l+TXh8N/vR5zuXPyd6azI9++3RpdCqxFGckGmoxFxUn
        AgAnPX9/9QIAAA==
X-CMS-MailID: 20200617081029epcas1p40ea7f1a3c20c83191d8547edb71648a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616053459epcas1p4e7a4908eda3785d6f5cbb71150cbe50b
References: <CGME20200616053459epcas1p4e7a4908eda3785d6f5cbb71150cbe50b@epcas1p4.samsung.com>
        <20200616053445.18125-1-hyc.lee@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We need to commit dirty metadata and pages to disk before remounting exfat
> as read-only.
> 
> This fixes a failure in xfstests generic/452
> 
> generic/452 does the following:
> cp something <exfat>/
> mount -o remount,ro <exfat>
> 
> the <exfat>/something is corrupted. because while exfat is remounted as
> read-only, exfat doesn't have a chance to commit metadata and vfs
> invalidates page caches in a block device.
> 
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
> Changes from v1:
> - Does not check the return value of sync_filesystem to
>   allow to change from "rw" to "ro" even when this function
>   fails.
> - Add the detailed explanation why generic/452 fails
> 
>  fs/exfat/super.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> e650e65536f8..253a92460d52 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -693,10 +693,20 @@ static void exfat_free(struct fs_context *fc)
>  	}
>  }
> 
> +static int exfat_reconfigure(struct fs_context *fc) {
> +	fc->sb_flags |= SB_NODIRATIME;
> +
> +	/* volume flag will be updated in exfat_sync_fs */
> +	sync_filesystem(fc->root->d_sb);
> +	return 0;
> +}
> +
>  static const struct fs_context_operations exfat_context_ops = {
>  	.parse_param	= exfat_parse_param,
>  	.get_tree	= exfat_get_tree,
>  	.free		= exfat_free,
> +	.reconfigure	= exfat_reconfigure,
>  };
> 
>  static int exfat_init_fs_context(struct fs_context *fc)
> --
> 2.17.1


