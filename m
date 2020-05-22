Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D51DF23B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgEVWpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 18:45:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40279 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 18:45:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so4993484plo.7;
        Fri, 22 May 2020 15:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8g5iMWxUv50Vq/9o6YUA17pf5mu6Tfr8Vt6J3G1KMjw=;
        b=A48DfZACU6Vqs1oq6gaNH3JqB6pRStANuGrdXRKhBDkbSBJhSuLYH8vI7q5hxayJj7
         FpiFv8kWpoDnDVCSR4SF3SW0+meGSh90Wucd9F75eB/+8Wydmj8VOVUtAxTYy1PAzW+c
         ue8Eepi5aqdat7ZhoNX+BCWeYjiepKmPYVT721x1Z9W4HRKe5MnGTWf+tIvdT7lHH9k/
         aLcZB+8JZyP+sMe88ZKeda6uu5tqGziKTdX/fXfqvuDHf8iO+4rj+8EIG/a3xyYOwIeA
         OkPPcUgXO29I1GWi8kn8YuQe/9TzbSSGiKNvp9rmGitCuJasK3HWHaK5YnzqR9vi5xC9
         3Ezg==
X-Gm-Message-State: AOAM530pric/CTYV5GTprqRUXmuvadwZiEySlABAPm4TVRdrAibeblrh
        M/JIynqAvydEeibOgcG40+s=
X-Google-Smtp-Source: ABdhPJxPnLaXKZi6piF1gumOCdvZvC04BxRzx6RSexsCidM2Ze9jl64zKzSemvH8XBSCIcZQgl3Jng==
X-Received: by 2002:a17:90a:4f42:: with SMTP id w2mr7268999pjl.74.1590187510516;
        Fri, 22 May 2020 15:45:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x191sm3798942pfd.37.2020.05.22.15.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 15:45:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4908B40321; Fri, 22 May 2020 22:45:08 +0000 (UTC)
Date:   Fri, 22 May 2020 22:45:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] firmware_loader: change enum fw_opt to u32
Message-ID: <20200522224508.GE11244@42.do-not-panic.com>
References: <20200522214658.12722-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522214658.12722-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 02:46:58PM -0700, Scott Branden wrote:
>  
>  /**
> - * enum fw_opt - options to control firmware loading behaviour
> + * fw_opt - options to control firmware loading behaviour
>   *
>   * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
>   *	when the firmware is not found. Userspace is in charge to load the
> @@ -33,15 +33,13 @@
>   *	the platform's main firmware. If both this fallback and the sysfs
>   *      fallback are enabled, then this fallback will be tried first.
>   */
> -enum fw_opt {
> -	FW_OPT_UEVENT			= BIT(0),
> -	FW_OPT_NOWAIT			= BIT(1),
> -	FW_OPT_USERHELPER		= BIT(2),
> -	FW_OPT_NO_WARN			= BIT(3),
> -	FW_OPT_NOCACHE			= BIT(4),
> -	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
> -	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
> -};
> +#define FW_OPT_UEVENT			BIT(0)
> +#define FW_OPT_NOWAIT			BIT(1)
> +#define FW_OPT_USERHELPER		BIT(2)
> +#define FW_OPT_NO_WARN			BIT(3)
> +#define FW_OPT_NOCACHE			BIT(4)
> +#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
> +#define FW_OPT_FALLBACK_PLATFORM	BIT(6)

Everything looked good up to here. The enum defines each flag.
We just want to use an enum for *one* flag represetnation, not
a bundle.

  Luis
