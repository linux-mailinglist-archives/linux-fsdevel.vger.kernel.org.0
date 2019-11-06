Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD23F15BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 13:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfKFMDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 07:03:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728646AbfKFMDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573041828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZEDT+gFJSe32nIwfqXTTM5I7IV6t9wwEKyln06CQEWM=;
        b=CVZWcz3aueUYzCZOuYeJjcpEM0+9Vy9WbaJ52v+4NvFRO3E/NK3+f/SyHfXUCUvVG49nGV
        zYF9b5j6hSIEHxHnP6quKucICD4WaWiPf94q1SMHIqOgmiZMMOLnAIGjQJuFVjrIC67lD/
        RysUI5etlCq/NdPqB4o2VwSu5B1bjko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-P0NgNwU1NeyuhnF1sKFIvA-1; Wed, 06 Nov 2019 07:03:47 -0500
Received: by mail-wr1-f69.google.com with SMTP id m17so13943107wrb.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2019 04:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FI656rpxAhSuEP64F+xjapGQefXenbiYP2SjKZj+Js=;
        b=KdDrH9kjlQzZD5HuiRlE0FhouYLDyNZ8//r2ryVpOXmw/cPBFwlipFAmEjBJCvDqbt
         w3UkBtcHEUOOKtbFLQGrs4A3vZQ815KJM9y3boWWmk3xDC2BYrFQhvnzkflNPlMq+Gku
         06AAmeFBR9LcMITlrdNXN/YpiHA1sIDBtDAZraTv/E6pGnajqcmGZ0Hv0w6W9agJXvO6
         N3JFI7zdxq7CkR4QTYsb0FEcz2PVdpOIgRPiFuyTRAZSuMHdLK4TRMVsm0Cvxhxm7v9l
         eIGPpjx8cwp53MzH39hKrJBFe1rYprGInnrb7sJ1u/zOig5nI1kKxPc2UEg6rntV6iCE
         POKg==
X-Gm-Message-State: APjAAAXKYPi/4oUkEdwFrshjq09e+8x+oDmIGtGDTvUnRd2uUx3dnzSh
        4pXYQxAWNs36ns73o1ftbR8HS5cgVtNcO/Cgcg/VI8x4vK5KBIaoCzBUHnSx5PPXJcEE6UeRhms
        FfmmC0bDOJzpPyVVloOQOFVBktA==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr1966863wmj.61.1573041825955;
        Wed, 06 Nov 2019 04:03:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwN32EKUFbPp8paDTE3jUpg+bxX0G43Q5JbYNVd63JKpd5hMWYcrk02CDjez2IuBoIgJ5qWw==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr1966853wmj.61.1573041825797;
        Wed, 06 Nov 2019 04:03:45 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id u16sm3809733wrr.65.2019.11.06.04.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 04:03:45 -0800 (PST)
Subject: Re: [PATCH -next] staging: Fix error return code in
 vboxsf_fill_super()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
References: <20191106115954.114678-1-weiyongjun1@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e466fadc-0e0d-129a-5cf3-6be2c86873a0@redhat.com>
Date:   Wed, 6 Nov 2019 13:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106115954.114678-1-weiyongjun1@huawei.com>
Content-Language: en-US
X-MC-Unique: P0NgNwU1NeyuhnF1sKFIvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 06-11-2019 12:59, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Fixes: df4028658f9d ("staging: Add VirtualBox guest shared folder (vboxsf=
) support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Good catch, thank you:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/staging/vboxsf/super.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/vboxsf/super.c b/drivers/staging/vboxsf/supe=
r.c
> index 3913ffafa83b..0bf4d724aefd 100644
> --- a/drivers/staging/vboxsf/super.c
> +++ b/drivers/staging/vboxsf/super.c
> @@ -176,8 +176,10 @@ static int vboxsf_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>   =09/* Turn source into a shfl_string and map the folder */
>   =09size =3D strlen(fc->source) + 1;
>   =09folder_name =3D kmalloc(SHFLSTRING_HEADER_SIZE + size, GFP_KERNEL);
> -=09if (!folder_name)
> +=09if (!folder_name) {
> +=09=09err =3D -ENOMEM;
>   =09=09goto fail_free;
> +=09}
>   =09folder_name->size =3D size;
>   =09folder_name->length =3D size - 1;
>   =09strlcpy(folder_name->string.utf8, fc->source, size);
>=20
>=20
>=20

