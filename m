Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8909E265F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKMHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:07:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbgIKMGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599825964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXnXExdfU/LgNFGqrEAIRqusTbjwtKOcyQ9t6Q3DukY=;
        b=KBHsrKDuZq/W8exCKiF8KsJ7tGIYneZ8Zcj/fudmpLUMNWc5HkIljjcBRXo6dlibAC6N1z
        vEn1xJJ3b3976URD+XT/LAMe2F+bzJJjLYa7xT7HE/9JXaWJIYe+bYgHUkNfYwuRB6syhZ
        hcqecGACUidnEWcR4ziIYYkTp7/dVoo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-zhl4yWJjNVGLvTLkhzZnXQ-1; Fri, 11 Sep 2020 08:06:02 -0400
X-MC-Unique: zhl4yWJjNVGLvTLkhzZnXQ-1
Received: by mail-ej1-f69.google.com with SMTP id w17so4451356eja.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 05:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tXnXExdfU/LgNFGqrEAIRqusTbjwtKOcyQ9t6Q3DukY=;
        b=KBTI9ky17PF9lKehGJtPp5H6wzT2xbZ/q2AEIW2d0/i2WV+UFO0L+FQJg8XPcEhtCB
         5r/ja5N7XTSlwwNUWDZjWxNO8flRvJMrezlQ4BED6R6a/U5dvHM20IR0LoagwMq4LefX
         2BNg5LeD6/VAlRU+Lu5XN8ygimFV9A10z2WEK72ahOvJ5Zq31L6Y8m1fFYapiYMtFSY8
         z6Gvn2u5Pt+1lPfN3gy3LGJuy+QXIohrC+Eh1d21L0lTaKTVtvJN/vm1NBjRAduvdnB3
         SgM+/ueQ5I19bIgHNEuJffg0F06IpfJq5lOsflRqChkBFd2g2Sqyi1fTDOM4AiRR66ZZ
         umzQ==
X-Gm-Message-State: AOAM532qg88oL54dzaPVJKQ8E2s2u92ZpJqqiHu4eM0+GOgZTPef+2Pd
        6BCbUjphIdizETqX4UNlNyHOz0TrazO1aWuaNHspns0yr1d/OOeqz3hDZWeEvk2G8jZ4vobGX9y
        bwuWgE78WovcVz5grbXYBhd2lNA==
X-Received: by 2002:aa7:cf05:: with SMTP id a5mr1618691edy.313.1599825961109;
        Fri, 11 Sep 2020 05:06:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGeHcc3Seug1HpP+JhTlX1wxV4JWfVvs8nAUaaY4C2YTOgc5vpea65aMg/Gr3DPSBQwzpjEw==
X-Received: by 2002:aa7:cf05:: with SMTP id a5mr1618654edy.313.1599825960828;
        Fri, 11 Sep 2020 05:06:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y25sm1474481edv.15.2020.09.11.05.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 05:06:00 -0700 (PDT)
Subject: Re: [PATCH -next] fs: vboxsf: Fix a kernel-doc warning in
 vboxsf_wrappers.c
To:     Wang Hai <wanghai38@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200911114339.62308-1-wanghai38@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <03f07277-d80a-f652-1050-472124db5900@redhat.com>
Date:   Fri, 11 Sep 2020 14:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911114339.62308-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/11/20 1:43 PM, Wang Hai wrote:
> Fixes the following W=1 kernel build warning(s):
> 
> fs/vboxsf/vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thank you, looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   fs/vboxsf/vboxsf_wrappers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
> index bfc78a097dae..3b6630e2847d 100644
> --- a/fs/vboxsf/vboxsf_wrappers.c
> +++ b/fs/vboxsf/vboxsf_wrappers.c
> @@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
>    * vboxsf_create - Create a new file or folder
>    * @root:         Root of the shared folder in which to create the file
>    * @parsed_path:  The path of the file or folder relative to the shared folder
> - * @param:        create_parms Parameters for file/folder creation.
> + * @create_parms: create_parms Parameters for file/folder creation.
>    *
>    * Create a new file or folder or open an existing one in a shared folder.
>    * Note this function always returns 0 / success unless an exceptional condition
> 

