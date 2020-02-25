Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4616EED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 20:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgBYTQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 14:16:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40894 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgBYTQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:16:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so185312plp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b99EgRmcp6u1zsZNpUbvhzpwtqn608FaTwMrFvX1wow=;
        b=L9WLI+4G74iViWuakHZtFcVF28mi9T91ZIzz6uQPWJh0QOMf/QV5QztwhxNuO8j7L5
         9Qi2BOkxxZQOGBDbtc5+e6wmFhLIR4r3LA0NT2PoVyEPhJyLl0SEyt09g9oEFaJQGJuy
         WoTXiGT8QYDglCNKAU5Chk7k0p/0Ci/AlVXO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b99EgRmcp6u1zsZNpUbvhzpwtqn608FaTwMrFvX1wow=;
        b=tubY0L6WANbbZ2wub2/LMeUYfvtlu1wxZOtjWA6Z5FNcdB9eWqUNkxnyX1m+imqMKc
         VYo6uMyKBpRsudyFFQQPtQP2WfBPctTfvKgAbWV2hRb3V3bOgaigDkBW3hSYE/8k58u0
         cAGKayzMovJ7yRB+5hyLlyrOmJ+IYN//eMRA8EWHikaHAfEHekQplyWGWgChA3rZhKdn
         ydf0HLPb1pWyTv4WWTCrqmr/RrMcvGnJvhBDjY2JMyL65L002Q5WpAwlZcVKb90teAkB
         H27udK2cvN3YZ4qZV9PmBs2bxEYG5DeYzT1+DmAEKSwJ5zAUgRBQ9mX7f5q6bizSYN4m
         NxSw==
X-Gm-Message-State: APjAAAU/aVd1elfBw+mX2e4qvyejYoNRaz7mFZ0ZKrbwrkNetqiG4daT
        6xIUw+W9oaQnp1gAoU2Zg04nyA==
X-Google-Smtp-Source: APXvYqzQlLhPIFPq3uvh5CL4wIxLVhcX97mccMpaVx6FggtRnvJcPxL13cj25t0wmPJlTqiWsgadYw==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr23977plo.284.1582658176242;
        Tue, 25 Feb 2020 11:16:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm17295948pfn.42.2020.02.25.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:16:15 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:16:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     qiwuchen55@gmail.com
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH 2/2] pstore/ram: remove unnecessary
 ramoops_unregister_dummy()
Message-ID: <202002251116.EA2C8C561@keescook>
References: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
 <1581068800-13817-2-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581068800-13817-2-git-send-email-qiwuchen55@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:46:40PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Remove unnecessary ramoops_unregister_dummy() if ramoops
> platform device register failed.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Thanks! Applied to for-next/pstore.

-Kees

> ---
>  fs/pstore/ram.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 013486b..7956221 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -963,7 +963,6 @@ static void __init ramoops_register_dummy(void)
>  		pr_info("could not create platform device: %ld\n",
>  			PTR_ERR(dummy));
>  		dummy = NULL;
> -		ramoops_unregister_dummy();
>  	}
>  }
>  
> -- 
> 1.9.1
> 

-- 
Kees Cook
