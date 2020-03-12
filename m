Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED716182DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCLKko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 06:40:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLKko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584009643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tq0ulOygpiuzF7J6PhCS00wRKj0wnRcrsFL7zpzSoFk=;
        b=aMq35+EjHODEHuXXxrVIiRi23cvwhqnVfpojLYLZZwcxEuu5Pj5xgiGWj1TGK4U1U5e9F2
        Ege44mgk2wN9SVtpNZ+OXSJHsve0uzorIEGonBDEJ43wBOQI26FeZ+f/3V8od5JfZFN/bj
        i8bz+pu6vU07kHMA+v9ARdjXkuQfiB8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-zSDW6SNiM66tDJoy_UnxOA-1; Thu, 12 Mar 2020 06:40:41 -0400
X-MC-Unique: zSDW6SNiM66tDJoy_UnxOA-1
Received: by mail-wr1-f70.google.com with SMTP id q18so2395528wrw.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 03:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tq0ulOygpiuzF7J6PhCS00wRKj0wnRcrsFL7zpzSoFk=;
        b=VuY6LBUuU/hIHyj9IqJ7H13jdqrsQxof2csqPYp/aXS517RRTSNXx9swpRmnotroFB
         AJIt2Bi6DqclN4huw/ABdkeoeWa2VezfLLUnu4NXT4yFyKaY2Zzwfwi8wpQ/zfOjATgd
         KmfTd6nW6dVIEiQqh8rq2p2fSxIv09Yl1d+MD53vmJIf/2HzdIj5b6EUxalNHgHTUrcr
         sPflW8cHv1KmYQtCkwxRLrrxaKmuqw4lgUfqx6HnPjbH4MqD7/JZfjKT6kZ2AONevZY8
         UqAQW9OypCnHtVmN6dOAd350CNZnAJvLMxPm13i474KAipwonrIV/e4d3u/t865sBLF0
         KXgg==
X-Gm-Message-State: ANhLgQ3GLCL8evaVVS47Cy/h+wYNdvO5YKseoAgAMPc+aIsUCW9B4TDp
        4bHASrjMn1ybjo4hcMsEz/zlmSZVQn/kOHmjv5bQe0erol8KSPHoziIl1rIHhxWvKdhqYV0BQT6
        VRtkAqf0F/1s/OUYZfqFIR5d3sQ==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr4041246wmc.166.1584009640758;
        Thu, 12 Mar 2020 03:40:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6ccLDIECUJ4QzcC0ZWPgWFXvbh19qItJSE4oK0axsizvLpMS3bxMwAA/uv2s0UwqJY6ijRw==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr4041227wmc.166.1584009640532;
        Thu, 12 Mar 2020 03:40:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id o26sm11337897wmc.33.2020.03.12.03.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:40:39 -0700 (PDT)
Subject: Re: [PATCH] fs: Fix missing 'bit' in comment
To:     Chucheng Luo <luochucheng@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org
References: <20200312074037.25829-1-luochucheng@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ed0f14ce-25f8-7ef7-54a6-6b3f9fa4bdfc@redhat.com>
Date:   Thu, 12 Mar 2020 11:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312074037.25829-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 3/12/20 8:40 AM, Chucheng Luo wrote:
> The missing word may make it hard for other developers to
> understand it.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>

Thanks for catching this:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   fs/vboxsf/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index dd147b490982..be4f72625d36 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
>   		d_type = vboxsf_get_d_type(info->info.attr.mode);
>   
>   		/*
> -		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
> +		 * On 32 bit systems pos is 64 bit signed, while ino is 32 bit
>   		 * unsigned so fake_ino may overflow, check for this.
>   		 */
>   		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
> 

