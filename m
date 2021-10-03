Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13542003E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhJCFtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 01:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:49:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535AC0613EC;
        Sat,  2 Oct 2021 22:47:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b22so8964728pls.1;
        Sat, 02 Oct 2021 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=savTH8tOINZ2J99oLslSAWNZa5Ho6D9RgvdIZJ7bFnA=;
        b=Y7uNNINBrkq5cxVztJ3SYWUhJ4cqOz8cuJbfN83wQn95FC/D2R99w+R2PGb9+omyw9
         oUMBBOL7Q2qXknqyn+ueCjhRRkGnQvpvwzbs+lH1kJcT7mhA/Sv5L5QSKRg4csmSP3i7
         KQf0X+t+NalR3wLVAXSHYb4TC8CIkajx690fgi5nQq7/ONabkjke8DE4NrtX3mbsKCov
         6GKUAjmQjbUU46Au+jp8B3bHxUi4dgI9/hNH0sygbvUe0nxcWAjC9QFLyx8xMU0L23zo
         3MbZYv6rWeB3f/d/ixsniSvPVzZlDq3h4NGCPXkQIMFaUYbnnngJuLp7T857lqiStDFe
         WmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=savTH8tOINZ2J99oLslSAWNZa5Ho6D9RgvdIZJ7bFnA=;
        b=LAT2rnWjzWef3CqOnK7hceQReCldU++G4ZUr7UgKe22BYQXR2MnvQbBS4HwlYhBZBG
         mF9UOuTMkqsu+Ge2AQGZ84shRRGpiWtV7IGo19/5l8L7KlDWX8bKxlvNc4w4l1rjyoo2
         xfB1qpBVTQUvxEkE4M5BRq2lbM2Prd5LQkuj5vvXph60p+JrQ/Mju3uWFdsmX7qEPPkI
         4uibaMx66HRyryxGcmIo6Uz91fuKP2hqHlvqFdrMbYolaA7fWx8Qc/KUb022/YPRtRRp
         X4nTTJlZ1Ac4tUrEk7OPboTNtJ3cYjDilymVzARRTjXDUB6Pyx/ux3cX8LMm6Vfqrnd+
         pqYA==
X-Gm-Message-State: AOAM5309FcmgNiS5BQgodW/YqAn/8xYdQU9EIZjSsX8GHFHLJgoNvfbn
        7ttJdj8RezkTtyfxE3quv+Y=
X-Google-Smtp-Source: ABdhPJy5HRxA5o6Rs+cSxf9+J2Z0L3aQbAXv7HdqnVMMAbnAdw/SICL9EIXJilE004Mcf5mNUIhaVQ==
X-Received: by 2002:a17:902:d2c6:b0:13e:9bc9:1ae3 with SMTP id n6-20020a170902d2c600b0013e9bc91ae3mr5601433plc.87.1633240070503;
        Sat, 02 Oct 2021 22:47:50 -0700 (PDT)
Received: from [10.12.152.158] ([154.21.212.155])
        by smtp.gmail.com with ESMTPSA id y7sm10286631pfr.33.2021.10.02.22.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 22:47:50 -0700 (PDT)
To:     seanjc@google.com
Cc:     djwong@kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stephenackerman16@gmail.com
References: <YVSEZTCbFZ+HD/f0@google.com>
Subject: Re: kvm crash in 5.14.1?
From:   Stephen <stephenackerman16@gmail.com>
Message-ID: <85e40141-3c17-1dff-1ed0-b016c5d778b6@gmail.com>
Date:   Sat, 2 Oct 2021 22:47:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVSEZTCbFZ+HD/f0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I think this should fix the problems?
>
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 21c3771e6a56..988528b5da43 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
>         mapping = (struct address_space *)
>                 ((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>
> -       if (mapping != page->mapping)
> +       if (!mapping || mapping != page->mapping)
>                 return false;
>
>         return mapping->a_ops == &secretmem_aops;

I have validated that my system was stable after several days on
v5.13.19. I'm now booted into a v5.14.8 kernel with this patch, and I'll
try to report back if I see a crash; or in roughly a week if the system
seems to have stabilized.

Thanks,
    Stephen

