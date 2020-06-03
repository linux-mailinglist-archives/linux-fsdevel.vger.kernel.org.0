Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC91EC6BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFCBcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 21:32:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26946 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCBcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:32:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200603013243epoutp02905275ecab5029736e444fd4307c09e9~U5KRpJ0HX2767627676epoutp02Y
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 01:32:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200603013243epoutp02905275ecab5029736e444fd4307c09e9~U5KRpJ0HX2767627676epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591147963;
        bh=nxeJZfGa9r2cyIZWQE2vqh/T28fViow0gBdv2f0AluQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=skzfgfN5pTS1GssmYuluAoSaXA8Wmgnv6EjR1BudD+722cjojTJOwt8fkuEQWj/km
         l63w3JKeOrgtNqSsFUZsPMlFo5bh3ZAQHj6DEa1UVsN4kJaK1m9P8KGUYSwLW7EFqy
         ldCRPaibLJ9iT0j4Kny4usvJ6OetvMCMfn2WQeks=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200603013242epcas1p2043435034759a56915cab70407f5ace0~U5KRZCU512931229312epcas1p2y;
        Wed,  3 Jun 2020 01:32:42 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49cBHF483bzMqYkj; Wed,  3 Jun
        2020 01:32:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.17.28578.9BDF6DE5; Wed,  3 Jun 2020 10:32:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200603013241epcas1p103bf8ec353b94b9f2c1b395a5f96fe7b~U5KP3IDWX2191721917epcas1p1V;
        Wed,  3 Jun 2020 01:32:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200603013241epsmtrp253f1a1e8393dc54be1f2640a83e483f1~U5KP2awLU2386823868epsmtrp2j;
        Wed,  3 Jun 2020 01:32:41 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-a7-5ed6fdb9b9fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.A5.08382.9BDF6DE5; Wed,  3 Jun 2020 10:32:41 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200603013240epsmtip20cb536b99c8847434a7ab75c5f293900~U5KPn4Pkw1845218452epsmtip2K;
        Wed,  3 Jun 2020 01:32:40 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Al Viro'" <viro@zeniv.linux.org.uk>
Cc:     <sj1557.seo@samsung.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'syzkaller'" <syzkaller@googlegroups.com>,
        "'butt3rflyh4ck'" <butterflyhuangxx@gmail.com>
In-Reply-To: <20200602162808.GK23230@ZenIV.linux.org.uk>
Subject: RE: memory leak in exfat_parse_param
Date:   Wed, 3 Jun 2020 10:32:41 +0900
Message-ID: <014501d63946$df61a260$9e24e720$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKSa5uL/3zbJoN7v+1iAtBKiDoxiAJWHDiqAihSHFqnKbrZcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmvu7Ov9fiDJo/yFnMWTWFzWLP3pMs
        Fpd3zWGz2PLvCKvFkTfdzBbn/x5ndWDz2DnrLrvHnokn2Tz6tqxi9Pi8Sc5j05O3TAGsUTk2
        GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKCmUJeaU
        AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjI+
        LjnLVPCPp+J481zWBsYrXF2MnBwSAiYSG95+Yeti5OIQEtjBKPHj9Ro2kISQwCdGif6TrhCJ
        b4wS5/fNZ4HpmLZsITNEYi+jxMXGXlYI5yWjxI0tx1hBqtgEdCX+/dkPNkpEQFPi/9wJYB3M
        IB0rFxwAG8UpYCFxbtEVdhBbGKih9fVaZhCbRUBF4nvbIjCbV8BSYuKa94wQtqDEyZlPwHqZ
        BeQltr+dwwxxkoLEz6fLWCGWOUlMP3aCHaJGRGJ2ZxvYYgmBiRwSl/qfskM0uEjs725ghbCF
        JV4d3wIVl5L4/G4v0NUcQHa1xMf9UPM7GCVefLeFsI0lbq7fwApSwgz02Ppd+hBhRYmdv+cy
        Qqzlk3j3tYcVYgqvREebEESJqkTfpcNMELa0RFf7B/YJjEqzkDw2C8ljs5A8MAth2QJGllWM
        YqkFxbnpqcWGBabIkb2JEZw6tSx3ME5/+0HvECMTB+MhRgkOZiURXivZa3FCvCmJlVWpRfnx
        RaU5qcWHGE2BQT2RWUo0OR+YvPNK4g1NjYyNjS1MzMzNTI2VxHmdrC/ECQmkJ5akZqemFqQW
        wfQxcXBKNTAd5Ty763v6Ca1fecbpXAfDTjFI3m1kWdsas+iasMCR9p9tGWe9598J2Bz6yCTr
        RdK8n2ezPi0+25x9ROMVQz/vrzM3Js0vP8HS/9uxo6KCb0HG88f9DRen+289+MHPzM3sYIPH
        LPZXmUoz/Rs/1z77liEU/M1i/wmLFekLTvHuFPxbNP+LdPH0LzvUs8KuL2LsDilQPMExWSMy
        fzY7t3bB0oj77VOY2L2qGapUNPpk1kk6XrfvdP18tqJBVGH5ia8FCc761wpfSbD2ZEh+Mtgj
        k3j3wLT9MmxFbKveZm0MnpA0Y53V/A3mWeXZ6g+ZuM+ZPig5+zE+0ckuchpP1jNdlfam+nIv
        tuNSnwumZiixFGckGmoxFxUnAgCRgGt0JgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvO7Ov9fiDJ5eYbWYs2oKm8WevSdZ
        LC7vmsNmseXfEVaLI2+6mS3O/z3O6sDmsXPWXXaPPRNPsnn0bVnF6PF5k5zHpidvmQJYo7hs
        UlJzMstSi/TtErgyPi45y1Twj6fiePNc1gbGK1xdjJwcEgImEtOWLWTuYuTiEBLYzSgx8+Mj
        doiEtMSxE2eAEhxAtrDE4cPFEDXPGSXa53xlBqlhE9CV+PdnPxuILSKgKfF/7gSwQcwCBxkl
        rlx6zwjRcY5RYu3piWBTOQUsJM4tugJmCwN1t75eCzaJRUBF4nvbIjCbV8BSYuIakGYQW1Di
        5MwnLCBXMAvoSbRtBAszC8hLbH87hxniUAWJn0+XsUIc4SQx/dgJdogaEYnZnW3MExiFZyGZ
        NAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4hrQ0dzBuX/VB
        7xAjEwfjIUYJDmYlEV4r2WtxQrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5N
        LUgtgskycXBKNTC5vHks+OHL382RX8yubZ82ayX3RI+Z/sc9XfTsDXXWzsia2mjxT36RXf6t
        RbLfTH5umDv7iPsbEffYFccEYsz2ha9TE1900ETqzpLplwP77eI/ezw32cHq8M1BTourrqL5
        /bp/rDnbiw6yO/xw8SteKjer7P2x14eWb5dVdjPZPn3C7F4ZH9VaNZ1StcO7hSRvfDJtW69U
        9XYVO/+L6f5vdT88M0sOc7q5RDdnd71A8yITX+6J11bbuEUmzDzSum754oRKm8QIzxyvxIO1
        c2Xivgp8+3tbUDBiSeAh69p/y/N/7FN8OsFo/qp7vxfy5MubXLSQ+B137GfXZkGJioy0r8wp
        kYb5Ba9uXzrQ+l5HiaU4I9FQi7moOBEAJCXuehADAAA=
X-CMS-MailID: 20200603013241epcas1p103bf8ec353b94b9f2c1b395a5f96fe7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200602162821epcas1p218a2f86ae11943f11ea728d6b0dbdfb6
References: <CAFcO6XPVo-u0CkBxy0Ox+FPfqgPUwmo0pnVYrLCP6EM05Sd6-A@mail.gmail.com>
        <CGME20200602162821epcas1p218a2f86ae11943f11ea728d6b0dbdfb6@epcas1p2.samsung.com>
        <20200602162808.GK23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Tue, Jun 02, 2020 at 01:03:05PM +0800, butt3rflyh4ck wrote:
> > I report a bug (in linux-5.7.0-rc7) found by syzkaller.
> >
> > kernel config:
> > https://protect2.fireeye.com/url?k=f3a88a7d-ae6446d8-f3a90132-0cc47a30
> > d446-6021a2fbdd1681a8&q=1&u=https%3A%2F%2Fgithub.com%2Fbutterflyhack%2
> > Fsyzkaller-fuzz%2Fblob%2Fmaster%2Fconfig-v5.7.0-rc7
> >
> > and can reproduce.
> >
> > A param->string held by exfat_mount_options.
> 
> Humm...
> 
> 	First of all, exfat_free() ought to call exfat_free_upcase_table().
> What's more, WTF bother with that kstrdup(), anyway?  Just steal the string and be done with that...
Thanks for your patch. I will push it to exfat tree.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index 0565d5539d57..01cd7ed1614d 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -259,9 +259,8 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  	case Opt_charset:
>  		exfat_free_iocharset(sbi);
> -		opts->iocharset = kstrdup(param->string, GFP_KERNEL);
> -		if (!opts->iocharset)
> -			return -ENOMEM;
> +		opts->iocharset = param->string;
> +		param->string = NULL;
>  		break;
>  	case Opt_errors:
>  		opts->errors = result.uint_32;
> @@ -611,7 +610,10 @@ static int exfat_get_tree(struct fs_context *fc)
> 
>  static void exfat_free(struct fs_context *fc)  {
> -	kfree(fc->s_fs_info);
> +	struct exfat_sb_info *sbi = fc->s_fs_info;
> +
> +	exfat_free_iocharset(sbi);
> +	kfree(sbi);
>  }
> 
>  static const struct fs_context_operations exfat_context_ops = {

