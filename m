Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509921F3556
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFIHqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 03:46:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:49013 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIHqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:46:46 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200609074644epoutp024f61590661e0a50cfd2cdc399df3bacc~W0IjZkkCM0917909179epoutp02V
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 07:46:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200609074644epoutp024f61590661e0a50cfd2cdc399df3bacc~W0IjZkkCM0917909179epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591688804;
        bh=cedIVXjtzLSnKrBd+Zx0W8tgSjqCqYlUTOvsImY/zZY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=P7vL56Q7y3cIDhGUdRlmZdrryXb14wKC26yNGDCHDAL7XqxxFt+G5Vxrw0iA4Hy4s
         a3DXZ9kfOqNyJsdqDur6wnlsJBQi7eccAXkdmd/fnytnkmVqE/ONZaVIWvWsTfK4XX
         sToXhhEgl/hV2U8U9GyfMzAdAVW4RjNaaqDAu9r0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200609074644epcas1p3b5774501e0f11bd5f2d8ba062460d59c~W0IjFbFgl2676226762epcas1p38;
        Tue,  9 Jun 2020 07:46:44 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49h2J312DYzMqYkp; Tue,  9 Jun
        2020 07:46:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.74.28578.36E3FDE5; Tue,  9 Jun 2020 16:46:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200609074642epcas1p24308d7c4659bf8ece42509d3d5e8921b~W0IhwoPRf1993719937epcas1p2T;
        Tue,  9 Jun 2020 07:46:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609074642epsmtrp22f299bcd8053de2d55a0abd98b23445d~W0IhwC7M60556705567epsmtrp26;
        Tue,  9 Jun 2020 07:46:42 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-ba-5edf3e637661
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.F6.08382.26E3FDE5; Tue,  9 Jun 2020 16:46:42 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609074642epsmtip21cf38bd3a918a0bab5cd50a53dd0947e~W0Ihmt3QY1458114581epsmtip2T;
        Tue,  9 Jun 2020 07:46:42 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok.Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1591680644-8378-1-git-send-email-Hyeongseok@gmail.com>
Subject: RE: [PATCH v2] exfat: Set the unused characters of FileName field
 to the value 0000h
Date:   Tue, 9 Jun 2020 16:46:42 +0900
Message-ID: <03cc01d63e32$1dec4a40$59c4dec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQCyiFQHEUSyYSCkK7CIBhZBenp9NAGiDhdLqwozeGA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmnm6y3f04g93nWSz+TvzEZLFn70kW
        ix/T6x2YPXbOusvu0bdlFaPH501yAcxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QHuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWG
        BgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5Gavf7mErWMhRsenoVbYGxn1sXYycHBICJhIbXs1l
        6mLk4hAS2MEosfLMT1YI5xOjxK2GNnYI5xujRP/0r6wwLcdbl0K17GWUuL5rJpTzklFi7rrF
        7CBVbAK6Ek9u/GQGsUUEPCSO3j0BtJCDg1lAWWLll2CQMKeAi8TNHQfByoUF4iX+PbkCtoBF
        QEXixLSJLCA2r4ClxJtve5khbEGJkzOfgMWZBeQltr+dwwxxkILE7k9HWSFWWUmc2/uDGaJG
        RGJ2ZxtUzSN2iZ2n7CFsF4mfy7uhnhGWeHV8CzuELSXx+d1eaLjUS+xedYoF5C8JgQZGiSOP
        FrJAJIwl5rcsZIb4RVNi/S59iLCixM7fcxkh9vJJvPvawwpSIiHAK9HRJgRRoiLx/cNOFphV
        V35cZZrAqDQLyWezkHw2C8kHsxCWLWBkWcUollpQnJueWmxYYIoc2ZsYwWlQy3IH4/S3H/QO
        MTJxMB5ilOBgVhLhrX5wJ06INyWxsiq1KD++qDQntfgQoykwrCcyS4km5wMTcV5JvKGpkbGx
        sYWJmbmZqbGSOK+T9YU4IYH0xJLU7NTUgtQimD4mDk6pBqaNExNmP10itPdPCMPiA4Yth3dc
        ePReacnm68tmyjtK/+v5+fqOamRMw9sCpdc2xzo65H/WsVwI9mMTn7H1RjKT4zvpFSLaIhv9
        M7zPB+2T6vAXe/lF8UiYKUODXIqWflnztkgez0sbFb5m3Ln8fJrTqb4jj5duUV+y/oDUM8nP
        BbFn2l2Z2cQl6/MFCwQeOfPNjAx/c+B11NL7W28omT1t2Saud+GgQ8fKE38nb5ysf1pxJcuc
        UwK3Gu5q1RzjvhzZw7u9JSJq1d/+9L2qbw0D59kz7PT+9Zg1ovVPVMmy4O4p76ymTsmtVVvS
        /v8d67NzZV7C9gZez/v5fvKdcmg52pd+eJJM0p76iKn3OGcpsRRnJBpqMRcVJwIAfC0RIAwE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvG6S3f04g007NCz+TvzEZLFn70kW
        ix/T6x2YPXbOusvu0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBmr3+5hK1jIUbHp6FW2BsZ9
        bF2MnBwSAiYSx1uXMnUxcnEICexmlPizcSVLFyMHUEJK4uA+TQhTWOLw4WKIkueMEv/nH2AH
        6WUT0JV4cuMnM4gtIuAlcXLhSbBWZgFliZVfgiHqpzJKzD32BqyeU8BF4uaOg2C2sECsxNyn
        q8F6WQRUJE5Mm8gCYvMKWEq8+baXGcIWlDg58wnUTD2Jto2MIGFmAXmJ7W/nMEOcryCx+9NR
        VogTrCTO7f3BDFEjIjG7s415AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjmpZbr
        FSfmFpfmpesl5+duYgRHgpbmDsbtqz7oHWJk4mA8xCjBwawkwlv94E6cEG9KYmVValF+fFFp
        TmrxIUZpDhYlcd4bhQvjhATSE0tSs1NTC1KLYLJMHJxSDUwKtseZ1qU5lImXBnZX9Nn9vb7L
        4vOqW19S/y0M3mgQwKszO7TE/Udw6pu9n05Ir3E4FP7A/nvPjA9aanFRX7VMnMvLl/IXbc0V
        cdrVKBLyWe3Y4v33fn69vWunvFnW7zvuf3U9rzVL+M8x0bE6+lxSb3eXhE/xqmapDz43RbL7
        ln3tzZrD5Mv+quJYxYY5kq935BpGX3zZFGzD9OuER6OVbKBLXSJjV0hS/nTHPc1LOb0m+s/0
        0HvPp/toQnXU4X4fLsNFiZZhH9TyfELDPmm+ndH/IG3HWfHa+1Zud7ep78kQv7LfSMD2dNT1
        N6c3aWkY+7EEPZZYaBL40u162N/krm3Gjv+E13vwbkluVWIpzkg01GIuKk4EAI35OJHzAgAA
X-CMS-MailID: 20200609074642epcas1p24308d7c4659bf8ece42509d3d5e8921b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609053051epcas1p2dcc80d99a10bcc83e11fda481239e64a
References: <CGME20200609053051epcas1p2dcc80d99a10bcc83e11fda481239e64a@epcas1p2.samsung.com>
        <1591680644-8378-1-git-send-email-Hyeongseok@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Some fsck tool complain that padding part of the FileName field is not set
> to the value 0000h. So let's maintain filesystem cleaner, as exfat's spec.
> recommendation.
> 
> Signe-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good to me. Thanks.

> ---
>  fs/exfat/dir.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..8e775bd 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -425,10 +425,12 @@ static void exfat_init_name_entry(struct
> exfat_dentry *ep,
>  	ep->dentry.name.flags = 0x0;
> 
>  	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
> -		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
> -		if (*uniname == 0x0)
> -			break;
> -		uniname++;
> +		if (*uniname != 0x0) {
> +			ep->dentry.name.unicode_0_14[i] =
> cpu_to_le16(*uniname);
> +			uniname++;
> +		} else {
> +			ep->dentry.name.unicode_0_14[i] = 0x0;
> +		}
>  	}
>  }
> 
> --
> 2.7.4


