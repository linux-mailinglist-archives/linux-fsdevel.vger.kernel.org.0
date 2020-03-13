Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA97184522
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCMKpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 06:45:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgCMKpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584096318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zctn6k2f5mixNGrxrLzyiam0TKHGTxDS/k1jN+OYlZ8=;
        b=gZF2Cv2m8VhflK0wpDOtLc182kXjTeKi1Urdk1c4yhuXq/FYGu4pKPJ6H/tv9n+UZXv1Lq
        WAZv/J7IPetJsYkxQIZCDLym5TTLMPWaV8xjZ7/XW3HhGGq+ZGRJ14PPBTSQIaHjbIrycK
        pIbSocl4w4fZwl3bCZQxtc4i4D8WMXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-jtTKzEKeMgunG84EEsDQJw-1; Fri, 13 Mar 2020 06:45:17 -0400
X-MC-Unique: jtTKzEKeMgunG84EEsDQJw-1
Received: by mail-wm1-f70.google.com with SMTP id a23so3281097wmm.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 03:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zctn6k2f5mixNGrxrLzyiam0TKHGTxDS/k1jN+OYlZ8=;
        b=H2lbu3ah9zHCv4v6PsoruhgmEJPyGOW/ls6AEegf79Nqy2HS5YFy6mhyBfZDpHFCTz
         NXEPHiMGgefx/Gi4wFYITlHGE2PGdXXjaB1bM5UCbOavPdARAINboj4hQVS1uaintUFd
         k5i0iCdFy0JiIO+YXdxHt7Brh41xtGIyqG0bu4biFl6bQgAVW/1CgWnKINw8ezOO6Nme
         AluK8D/Ni3Ihu513OkvyiFCx65FT9cri0aOHMt97PJ/OKg0taU7Va1WjMKD/O8EWFIiw
         xg51oRnNyznqNEhRojI+a+L38IW33/yu6DYXQEsGJblpaL8t99Pty0Ti8+FTrJDema0D
         7PMQ==
X-Gm-Message-State: ANhLgQ3HsZR9JJP+gSQqFlF56qH/DjAKwjELOjy2Umjmx96YzY+Yth7b
        mXG01zT4POPgVqfAUTVtNYnwUP1u+kQnfFyIy6MTWZITBiyhV0tPzW+mZzrSSDpYXXfSrGX8jtX
        g14qbTnOrCa+uRNZ27dZ6xO0NMg==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr9834651wme.115.1584096316104;
        Fri, 13 Mar 2020 03:45:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vviKBLP6HiMs9SO8RNyYOgApRUQbugrPMiXiR6xqFNcz8q1Uphz7JwEuPG86DI5+Afewd8XZg==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr9834631wme.115.1584096315904;
        Fri, 13 Mar 2020 03:45:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id o10sm5209579wrs.65.2020.03.13.03.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:45:15 -0700 (PDT)
Subject: Re: [PATCH] fs: Fix missing 'bit' in comment
To:     Chucheng Luo <luochucheng@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org
References: <20200313014655.28967-1-luochucheng@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dfd44b01-3d90-3923-2971-d8d5bce5db08@redhat.com>
Date:   Fri, 13 Mar 2020 11:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313014655.28967-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 3/13/20 2:46 AM, Chucheng Luo wrote:
> The missing word may make it hard for other developers to
> understand it.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>

This new version also looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

p.s.

In the future please mark new versions as such by using e.g.:

git send-email --subject-prefix="PATCH v2" ...

Actually, it would be good to resend this patch (with my
Acked-by added to the commit msg) this way because now there
is no way for the fs maintainers to figure out which one
of the 2 patches you've send out to apply.



> ---
>   fs/vboxsf/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index dd147b490982..4d569f14a8d8 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
>   		d_type = vboxsf_get_d_type(info->info.attr.mode);
>   
>   		/*
> -		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
> +		 * On 32-bit systems pos is 64-bit signed, while ino is 32-bit
>   		 * unsigned so fake_ino may overflow, check for this.
>   		 */
>   		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
> 

