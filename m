Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8B4F71B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 03:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiDGBxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDGBxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:53:34 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B14165ABA
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 18:51:35 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220407015132epoutp019ebbb8c87fd815630a6669e5612f0fd2~jej1m6evF2382623826epoutp01K
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 01:51:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220407015132epoutp019ebbb8c87fd815630a6669e5612f0fd2~jej1m6evF2382623826epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649296292;
        bh=xsV8vPUboovQGAmev436kkf9GfuEb8GqF1/R4lpVtHo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GyuWYx4jzvGpYajUChvSN8GigqojEtOxPvTvQ+eAJqGQ6bvwwA9IRDOCusufF00KU
         5NaiN0sWwi+g6jGgrmRqHButHsrQm5zQ7r/g+eXK9B2Ytk26+qhxH3usv+gAP2F16P
         pLi6v/6YG0lLGTSzJTIGKZAQn3RboFnv/H2TbD0c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220407015132epcas1p2ba5bfee70cac33fb85f4cfd6d830fe4f~jej1JAwHw1048710487epcas1p2J;
        Thu,  7 Apr 2022 01:51:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.240]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KYkrM00QTz4x9QB; Thu,  7 Apr
        2022 01:51:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.B7.28648.2A34E426; Thu,  7 Apr 2022 10:51:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220407015130epcas1p3762726625bafcbee17234459296cc750~jejzMVaiO0689506895epcas1p3T;
        Thu,  7 Apr 2022 01:51:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220407015130epsmtrp247028d69917da51de6d304a5a4b56e45~jejzLjewM0172901729epsmtrp2W;
        Thu,  7 Apr 2022 01:51:30 +0000 (GMT)
X-AuditID: b6c32a39-003ff70000006fe8-80-624e43a2ef81
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.DD.24342.1A34E426; Thu,  7 Apr 2022 10:51:29 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220407015129epsmtip1377db94fb6783dbee3011872b8276c8a~jejzAL-dY0685406854epsmtip1S;
        Thu,  7 Apr 2022 01:51:29 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Chung-Chiang Cheng'" <cccheng@synology.com>,
        <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <shepjeng@gmail.com>,
        <kernel@cccheng.net>, <sj1557.seo@samsung.com>
In-Reply-To: <20220406095552.111869-1-cccheng@synology.com>
Subject: RE: [PATCH] exfat: introduce mount option 'sys_tz'
Date:   Thu, 7 Apr 2022 10:51:29 +0900
Message-ID: <190001d84a22$001aced0$00506c70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQE+GJ2wccyO29S7feeCqQ9FmJBUCQNuVNderfyfAmA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmru4iZ78kg54pVhZbnx1ntVi/+D6z
        xcRpS5kt9uw9yWLROlvSYsu/I6wObB532g+xeOycdZfdY9OqTjaPvi2rGD1mfNjP6vF5k1wA
        W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScArMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7IwbDxcwF/QpVqxdNYOxgfG1VBcjJ4eEgInE9vbrzF2MXBxCAjsYJeZvv8gG4XxilDg//RFU
        5hujxKtbq1lgWnqWPmaBSOxllHjQMg3Kecko0bVkJytIFZuArsSTGz+ZQWwRAS+J282n2EBs
        ZoFsiWcvV7GD2JwC1hJrz3UzgdjCQPb1W5/A6lkEVCQmrV0NZHNw8ApYSkyZ4AES5hUQlDg5
        8wkLxBh5ie1v5zBDHKQgsfvTUVaIVVYS56ddYIeoEZGY3dkG9oGEwFQOidO/26E+cJFomtzK
        BGELS7w6voUdwpaS+PxuLxuE3cwo0dxoBGF3MEo83SgLco+EgL3E+0sWICazgKbE+l36EBWK
        Ejt/z2WEWMsn8e5rDytENa9ER5sQRImKxPcPO1lgFl35cZVpAqPSLCSPzULy2CwkD8xCWLaA
        kWUVo1hqQXFuemqxYYEpPK6T83M3MYLTp5blDsbpbz/oHWJk4mA8xCjBwawkwluV65MkxJuS
        WFmVWpQfX1Sak1p8iNEUGNITmaVEk/OBCTyvJN7QxNLAxMzIxMLY0thMSZx31bTTiUIC6Ykl
        qdmpqQWpRTB9TBycUg1MbJMuxPjXdLMH3XhufPi+7HkH5UfPD+8uvHP38VGZvo32G5jFj0W5
        zDycPrPiw5qlZTP1jFXvXk6WUrWd6GxYZPPy4pbfwWlaXSXhyRanJnOpuMuZLGWMaHpvrJNy
        6LTZl9vtfy61nPq9z8J3ybePhpHzOAIK7C1XT5/PvPtIGatMy5rV7dq7Tu3vuyL08szKa1Nr
        +CPUdp2a9ekAS8/sbdPlX7zcb//p5ISgX+YvCkzPFH14L6dxsfhsMNNKxx2ZYdl8wr3W3l8Y
        tP5OZpv6Y/6Cxfd5u+7L2F733Z5+w9VRTeGcgZ3rPfv5Tybc/fb4owbX55n1S/bq/fexlL7K
        Njl6xRzdfTFXlrr9VjottEiJpTgj0VCLuag4EQD3PC/DKAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO5CZ78kg6nrbSy2PjvOarF+8X1m
        i4nTljJb7Nl7ksWidbakxZZ/R1gd2DzutB9i8dg56y67x6ZVnWwefVtWMXrM+LCf1ePzJrkA
        tigum5TUnMyy1CJ9uwSujBsPFzAX9ClWrF01g7GB8bVUFyMnh4SAiUTP0scsXYxcHEICuxkl
        dq79wdrFyAGUkJI4uE8TwhSWOHy4GKLkOaPE91v7WEF62QR0JZ7c+MkMYosI+EicfreREcRm
        FsiXeLV/FjNEQw+jxNNjy8ASnALWEmvPdTOB2MJA9vVbn8CaWQRUJCatXc0MsoxXwFJiygQP
        kDCvgKDEyZlPWEDCzAJ6Em0w4+Ultr+dwwxxvoLE7k9HWSFOsJI4P+0CO0SNiMTszjbmCYzC
        s5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcRVqaOxi3
        r/qgd4iRiYPxEKMEB7OSCG9Vrk+SEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUweMXlr9A+qzsw+st1HWndJ7ROG5mXG8ZcZLt4NPpc0O2nnWYe2962L
        cvZm1aq8srK4t/WGsJVv8tdts06ekvrx4eLHLIMsTaXK2QvyDSeHh5xbmXZ+yvHHO+Ji7LKM
        vi9/uDs7UDitsDmBx+BCNHvoRuPUg3P+xascevL65uuyqFQXbsk5sWYba8VWzfg21yJa8h3n
        H5GMOpU+oZlsr6z2dbp3FH498GquT/3ep8+EZ+tUBn2tX75Mwt2P5fqV4t3vvG4EPv15qPju
        Nh5d/veZLHubLMWvXlr/8I4yj9Jn+XPR1g+kCoLbp6kc/G/81+bdm5mW516uSGYXCDuyOr1C
        Memo6QmrWHvHm7cSl51VYinOSDTUYi4qTgQAzXM77REDAAA=
X-CMS-MailID: 20220407015130epcas1p3762726625bafcbee17234459296cc750
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220406095559epcas1p19621ef9dedda9cd51edbb40d12a40936
References: <CGME20220406095559epcas1p19621ef9dedda9cd51edbb40d12a40936@epcas1p1.samsung.com>
        <20220406095552.111869-1-cccheng@synology.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> EXFAT_TZ_VALID bit in {create,modify,access}_tz is corresponding to
> OffsetValid field in exfat specification [1]. When this bit isn't set,
> timestamps should be treated as having the same UTC offset as the current
> local time.
> 
> Currently, there is an option 'time_offset' for users to specify the UTC
> offset for this issue. This patch introduces a new mount option 'sys_tz'
> to use system timezone as time offset.
> 
> Link: [1] https://protect2.fireeye.com/v1/url?k=6c606ee0-0d1d8463-
> 6c61e5af-74fe48600158-7870d6304b957d98&q=1&e=3704e121-39fa-4c75-a3c8-
> a4e968c00dbf&u=https%3A%2F%2Fdocs.microsoft.com%2Fen-
> us%2Fwindows%2Fwin32%2Ffileio%2Fexfat-specification%2374102-offsetvalid-
> field
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

Looks good!
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/exfat_fs.h |  1 +
>  fs/exfat/misc.c     | 10 ++++++++--
>  fs/exfat/super.c    |  9 ++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> c6800b880920..82e507413291 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -203,6 +203,7 @@ struct exfat_mount_options {
>  	/* on error: continue, panic, remount-ro */
>  	enum exfat_error_mode errors;
>  	unsigned utf8:1, /* Use of UTF-8 character set */
> +		 sys_tz:1, /* Use local timezone */
>  		 discard:1, /* Issue discard requests on deletions */
>  		 keep_last_dots:1; /* Keep trailing periods in paths */
>  	int time_offset; /* Offset of timestamps from UTC (in minutes) */
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c index
> d5bd8e6d9741..9380e0188b55 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -74,6 +74,13 @@ static void exfat_adjust_tz(struct timespec64 *ts, u8
> tz_off)
>  		ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);  }
> 
> +static inline int exfat_tz_offset(struct exfat_sb_info *sbi) {
> +	if (sbi->options.sys_tz)
> +		return -sys_tz.tz_minuteswest;
> +	return sbi->options.time_offset;
> +}
> +
>  /* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70).
> */  void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64
> *ts,
>  		u8 tz, __le16 time, __le16 date, u8 time_cs) @@ -96,8 +103,7
> @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64
> *ts,
>  		/* Adjust timezone to UTC0. */
>  		exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
>  	else
> -		/* Convert from local time to UTC using time_offset. */
> -		ts->tv_sec -= sbi->options.time_offset * SECS_PER_MIN;
> +		ts->tv_sec -= exfat_tz_offset(sbi) * SECS_PER_MIN;
>  }
> 
>  /* Convert linear UNIX date to a EXFAT time/date pair. */ diff --git
> a/fs/exfat/super.c b/fs/exfat/super.c index 8ca21e7917d1..3e0f67b2103e
> 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -170,7 +170,9 @@ static int exfat_show_options(struct seq_file *m,
> struct dentry *root)
>  		seq_puts(m, ",discard");
>  	if (opts->keep_last_dots)
>  		seq_puts(m, ",keep_last_dots");
> -	if (opts->time_offset)
> +	if (opts->sys_tz)
> +		seq_puts(m, ",sys_tz");
> +	else if (opts->time_offset)
>  		seq_printf(m, ",time_offset=%d", opts->time_offset);
>  	return 0;
>  }
> @@ -214,6 +216,7 @@ enum {
>  	Opt_errors,
>  	Opt_discard,
>  	Opt_keep_last_dots,
> +	Opt_sys_tz,
>  	Opt_time_offset,
> 
>  	/* Deprecated options */
> @@ -241,6 +244,7 @@ static const struct fs_parameter_spec
> exfat_parameters[] = {
>  	fsparam_enum("errors",			Opt_errors,
> exfat_param_enums),
>  	fsparam_flag("discard",			Opt_discard),
>  	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
> +	fsparam_flag("sys_tz",			Opt_sys_tz),
>  	fsparam_s32("time_offset",		Opt_time_offset),
>  	__fsparam(NULL, "utf8",			Opt_utf8,
> fs_param_deprecated,
>  		  NULL),
> @@ -298,6 +302,9 @@ static int exfat_parse_param(struct fs_context *fc,
> struct fs_parameter *param)
>  	case Opt_keep_last_dots:
>  		opts->keep_last_dots = 1;
>  		break;
> +	case Opt_sys_tz:
> +		opts->sys_tz = 1;
> +		break;
>  	case Opt_time_offset:
>  		/*
>  		 * Make the limit 24 just in case someone invents something
> --
> 2.34.1


