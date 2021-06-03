Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D51399F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFCKny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCKnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:43:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1DAC06174A;
        Thu,  3 Jun 2021 03:42:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jt22so8521920ejb.7;
        Thu, 03 Jun 2021 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=wJVYMLShJcEHY1M41voNtHfPWItH6cQvkxCpZVR0vs8=;
        b=XOqADyF/nJ0rA072xUGq1GxKZjgwb4Wrm5ReoZ1rpmKFVXvmQDc+hVYMpJYJ6Yyp3o
         D4CZjvK1rA42CZssk1DAoYJpgRW2rX3kTEPTNYIY/AYpZHI7Ik04GrraIPN8vDZkoHHD
         iKoDmmOEmtOkpOKjsId64TWJ83dsirCXsfjUrjdG5S7RX2GF1JGl+8Dij5NtVp0o0tFO
         3dXIZea0WLq4o+cj9rWtYNNLvf1QjVGbzd/6lRWaBE9mM9tOhbuI6Sahki83bIm1ecdu
         nPX3cJ02shej292z8Gt+8yc08o5DNN0+74yHLyRoflk/mlEK+4iP1yFWgKGkJ3SylF/m
         BWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=wJVYMLShJcEHY1M41voNtHfPWItH6cQvkxCpZVR0vs8=;
        b=hN/nUP5gPgCvVEPL65fU+dHCdA3lTiZ8RqOIxDeGlAM4OeDkDQ8E2+hD0sH2ChzMtm
         ET80gjlSvz99jT1JUf5FmH82E6krxTV3FWfl/1rWvH7fRyt9o1+YxnBtVbwEAKAwV9bI
         KBF+syI9PIfa52WDbucT8aKYZv6D1j5StNzp+fNiCmDEJ8VdybHz3LsmbHpLjmB+1U0M
         s/TNrz0L9MuZZi8SOjF6Ept6vsSGu46UEk/Bp8k8iNTbhyQc8BkBpSWOasE1AVCTlll9
         k5oxnZjKWLGn8nrDSkQQx2czBQ8ru5V1AQu0YyiOuhxRXIvoHtSGFX5SabuWp6fu3XLk
         Z48A==
X-Gm-Message-State: AOAM533sJfXoEFaEkAT34F1ldDuyvXq/EdPbvplMdIhPaOXUR6w3cgw2
        7ADLwjN7PcQKmXYKkrBkPXvTjMABI+Ok0g==
X-Google-Smtp-Source: ABdhPJyQ98INu/bg6n9Pa4Xb8TqWMXaIgBi62SiHv9wRIP1x8ujNteC/67jKfp4eG0pIEO8i1AZJqg==
X-Received: by 2002:a17:906:848:: with SMTP id f8mr13370399ejd.198.1622716927705;
        Thu, 03 Jun 2021 03:42:07 -0700 (PDT)
Received: from [109.186.180.4] (109-186-180-4.bb.netvision.net.il. [109.186.180.4])
        by smtp.gmail.com with ESMTPSA id u4sm1350420eje.81.2021.06.03.03.42.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 03:42:07 -0700 (PDT)
Message-ID: <60B8B189.6060404@gmail.com>
Date:   Thu, 03 Jun 2021 13:40:09 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2021-06-01-19-57 uploaded (xillybus)
References: <20210602025803.3TVVfGdaW%akpm@linux-foundation.org> <d880c052-e3e3-3af7-040d-7abdc97df1d1@infradead.org> <YLcQc0sHBaYViZIN@kroah.com>
In-Reply-To: <YLcQc0sHBaYViZIN@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/06/21 08:00, Greg Kroah-Hartman wrote:
>> (on i386)
>> >  
>> >  CONFIG_XILLYBUS_CLASS=y
>> >  CONFIG_XILLYBUS=m
>> >  CONFIG_XILLYUSB=y
>> >  
>> >  ERROR: modpost: "xillybus_cleanup_chrdev" [drivers/char/xillybus/xillybus_core.ko] undefined!
>> >  ERROR: modpost: "xillybus_init_chrdev" [drivers/char/xillybus/xillybus_core.ko] undefined!
>> >  ERROR: modpost: "xillybus_find_inode" [drivers/char/xillybus/xillybus_core.ko] undefined!
>> >  
>> >  
>> >  Full randconfig file is attached.
>>      
> Sorry about that, I have a fix in my inbox for this that I will push out
> later today...
>    
For the record, this is the said pending patch:

https://lkml.org/lkml/2021/5/28/245

I've tested this issue, and can confirm the compilation problem and that 
the patch fixes it.

Regards,
    Eli
