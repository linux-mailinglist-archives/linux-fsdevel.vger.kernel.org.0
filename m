Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EF232C2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 08:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgG3G7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 02:59:11 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27932 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3G7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:59:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200730065906epoutp033726ee90da44b33dbb4483f3f9a1435c~mdYhcspMA0943909439epoutp03p
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 06:59:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200730065906epoutp033726ee90da44b33dbb4483f3f9a1435c~mdYhcspMA0943909439epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596092346;
        bh=pDvJp/B32STG6lSb4sos12eTCOwHaRMloGPYdlNzDzk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ROpRuTiBERS0/ge6VM3/BlNHL7pnkOsQwuSnAXxYhkOcfT9hPA6Bu1cZmcDI67GOZ
         F05Hytcb4LzhQqZNqyVOaBbUMc9X7gOivyFNKYTSUueLW87xCLKqL40wxfFP7LpMy/
         RHxE0mKQ7YSP8g/yHNH5GtbMZ+BpUe3GqlfyUEgw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200730065905epcas1p234aa4fa21170e122709ce2d996e24708~mdYguMJHX0989609896epcas1p2Z;
        Thu, 30 Jul 2020 06:59:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BHLqY0ktGzMqYkf; Thu, 30 Jul
        2020 06:59:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.68.19033.8BF622F5; Thu, 30 Jul 2020 15:59:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200730065904epcas1p4c3c049738b1a543aaa37f63d92d0c35d~mdYfpf6Vh0573405734epcas1p4O;
        Thu, 30 Jul 2020 06:59:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200730065904epsmtrp12017cdd9f76713325f52c09579d18b10~mdYfoaZPz3001230012epsmtrp1j;
        Thu, 30 Jul 2020 06:59:04 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-70-5f226fb82628
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.A7.08382.8BF622F5; Thu, 30 Jul 2020 15:59:04 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200730065904epsmtip16ed9e1d48eaf82e39682897bd35e3597~mdYffDp4G0290802908epsmtip16;
        Thu, 30 Jul 2020 06:59:04 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>,
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <fa122230-e0fd-6ed6-5473-31b17b56260c@gmail.com>
Subject: RE: [PATCH] exfat: retain 'VolumeFlags' properly
Date:   Thu, 30 Jul 2020 15:59:04 +0900
Message-ID: <015e01d6663e$e99e4ec0$bcdaec40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJOchBlupSQwdEhi4rggGDYoy3yLwE5agcKAmVRsN0CrFCHjgKKBjVEAx7tf5ECsQmAL6e6b/8Q
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmvu7OfKV4g1+9zBY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tl
        aGBgZApUmZCTMe3QX8aCmRwVX28dZ2lgPMbWxcjJISFgInHj/xsgm4tDSGAHo8T1Jd+ZIJxP
        jBLHv55jAqkSEvjGKNFxzQamY83LF6wQRXsZJW4t/8oM4bwEKpo7C2wum4CuxL8/+8FsEYEE
        ic23NjOD2MwC5xklGif4g9icArYSH7buZAexhQUsJV5O2glWzyKgKvHk2gIWEJsXKP73xAtm
        CFtQ4uTMJywQc+Qltr+dwwxxkYLEz6fLWCF2RUk8vP8dqkZEYnZnG9hxEgILOSQ2X1sE1eAi
        0dh8lB3CFpZ4dXwLlC0l8bK/DcjmALKrJT7uhyrvYJR48d0WwjaWuLl+AytICbOApsT6XfoQ
        YUWJnb/nMkKs5ZN497WHFWIKr0RHmxBEiapE36XDTBC2tERX+wf2CYxKs5A8NgvJY7OQPDAL
        YdkCRpZVjGKpBcW56anFhgVGyHG9iRGcTLXMdjBOevtB7xAjEwfjIUYJDmYlEd52LoV4Id6U
        xMqq1KL8+KLSnNTiQ4ymwKCeyCwlmpwPTOd5JfGGpkbGxsYWJmbmZqbGSuK8D28BNQmkJ5ak
        ZqemFqQWwfQxcXBKNTAFsXvl+l1V+af8Pix5+r9VP8ou2IpI1aZwiX/5vLNxaW0f35QV5k9f
        2i2erp+abRThnhmaYcRwdIdyTqvX0TyBsydbLglayp/vfKn3iev3zUYfdQ3XZb4ZB6bv/rdH
        1Ofa+eeLS7LOGIsoLr0ye5HDzH1TJpWafTu42kgqSqt9TtqeNh1Om6aCNINZjydOMbCUvsx3
        X1FX9UVnXCbPB4Vd79fwF21fvk5r4m6JJOuq6TtaX3i3PeiSiisqjbqtZGx0i5vfwOD4M79J
        xw4vea75+dzJ789mx8pmd25QP7z8WsvrikeLVs0y1uhZEGn+I+XF+WUeQoHlQd8k3gYkaN1b
        lRgV89phT+4+kUWGripKLMUZiYZazEXFiQD76bdALwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTndHvlK8wdsNshY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgyph26C9jwUyOiq+3jrM0MB5j62Lk5JAQMJFY8/IFaxcj
        F4eQwG5GidVfJjJCJKQljp04w9zFyAFkC0scPlwMUfOcUeLS8WMsIDVsAroS//7sBxskIpAg
        sfnWZmaQImaBi4wS/xfuYYbomMEssXLbPWaQKk4BW4kPW3eyg9jCApYSLyftBOtmEVCVeHJt
        AdhUXqD43xMvmCFsQYmTM5+AxZkFtCV6H7YyQtjyEtvfzmGGuFRB4ufTZawQV0RJPLz/Hape
        RGJ2ZxvzBEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7
        iREcW1qaOxi3r/qgd4iRiYPxEKMEB7OSCG87l0K8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4b
        hQvjhATSE0tSs1NTC1KLYLJMHJxSDUylLeHcRvpTkqzn6c/XTTujsfRK6IIuucfPVvJqnP94
        9c7D3ulndwgKmU24nFY3g3frDHmF3u1cKYdOXtZaWyCSlP7UaZmJdW4zW2i50q4QnQzzz4em
        S1bMvmvOYBFcbim9ddKaKdKnPX5mKy9OmHP1/LQCZptChyczAyOXMN6S75jP3eU436dL4eOT
        5T/PljYpPjh7Z+uDyMULxBXbCw94VX/3bFJZnNr81jdkSpmNz4sovUV/Dh+rMgj+v+zAl69m
        kmWsn/dsnrSNtfPWKt+jkvPtnB9qxDzcYXmQTeuyF4P83CSd5XVZL7t8FWdOdntoOcewOUb3
        vgrnMqXe3hk3RW77Tln12X+tQXdUs4kSS3FGoqEWc1FxIgBBzbLyHAMAAA==
X-CMS-MailID: 20200730065904epcas1p4c3c049738b1a543aaa37f63d92d0c35d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
        <20200708095746.4179-1-kohada.t2@gmail.com>
        <005101d658d1$7202e5d0$5608b170$@samsung.com>
        <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
        <015801d65a4a$ebedd380$c3c97a80$@samsung.com>
        <ad0beeab-48ba-ee6d-f4cf-de19ec35a405@gmail.com>
        <fa122230-e0fd-6ed6-5473-31b17b56260c@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Ping..
Hi Tetsuhiro,

> 
> On 2020/07/15 19:06, Tetsuhiro Kohada wrote:
> >> It looks complicated. It would be better to simply set/clear VOLUME DIRTY bit.
> >
> > I think exfat_set_vol_flags() gets a little complicated, because it
> > needs the followings (with bit operation)
> >   a) Set/Clear VOLUME_DIRTY.
> >   b) Set MEDIA_FAILUR.
> 
> How about splitting these into separate functions  as below?
> 
> 
> exfat_set_volume_dirty()
> 	exfat_set_vol_flags(sb, sbi->vol_flag | VOLUME_DIRTY);
> 
> exfat_clear_volume_dirty()
> 	exfat_set_vol_flags(sb, sbi->vol_flag & ~VOLUME_DIRTY);
Looks good.

> 
> exfat_set_media_failure()
> 	exfat_set_vol_flags(sb, sbi->vol_flag | MEDIA_FAILURE);
Where will this function be called? We don't need to create unused functions in advance...

> 
> 
> The implementation is essentially the same for exfat_set_vol_flags(), but I think the intention of the
> operation will be easier to understand.
Yes.

Thanks!
> 
> 
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>

