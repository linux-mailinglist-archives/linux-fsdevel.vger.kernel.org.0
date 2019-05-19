Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7941225B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2019 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfESB4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 21:56:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41357 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfESB4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 21:56:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so5070351pgp.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2019 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kj4OJTopW4rotB8qihKVkdclA94Kw2w9hND/ZASmD4=;
        b=aDGV5YuWdqbIJilBO0WAM7gcfKLGH5t9gO/0KJVJ47LOMrp1HdMMS6jlrxipv7HfJD
         3lCFORRxYNin9JkiebhDNWTH4fM2d0xnjPrAZ29NlQyaz52fXr7/d4uy5D0jVIVt0q7M
         z3F+hS80VGUNPrsZWXwO1nfcpijgFKG2ERmZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+kj4OJTopW4rotB8qihKVkdclA94Kw2w9hND/ZASmD4=;
        b=XFNuiYNnCFzoqCEC/YRNsSfP2j08VeDj0rHyPWrrgsyMdQ2ft1+4OAnkXcFFeeI2hi
         syISdz6IGKJjq4hpXImbhxMP+4AF1fwc/c99fR0ZZIz4Bod8zyFmdTyeZBi1HUOTr85O
         2J/IcOi8A/BKcqv9mQCyi43mMOiRvoTgWMYiwSDMtq/O0Pj1RJ93yC9nBHO02r/+igGv
         +Gx27YNp7+hqxXOfkaaAzxXtcxN75uHgV3hoLpVQWFiKFiV1ZWvd/sQ0XSzbd+qV+Tmd
         1/EW/s5kGR2+AbCZ6CccbyuiLIQ4PykcdJS1Pfna0c+4OIR8/UmtZv1+Xb8/C0Kels2q
         LaLw==
X-Gm-Message-State: APjAAAXv7uppXeJnlDamosw7WsHBsp074xCylKgRnelfd8RBT8Zu9k2y
        ry4ywRr37xAbKGMadxhbg1k0QQ==
X-Google-Smtp-Source: APXvYqxPCwPSZydCQNb24+pWdRNYEyp8uXWZRnLGTAIxluddIHLpHn7S4Gzf1USIDt211iw0hLpNTQ==
X-Received: by 2002:a63:7146:: with SMTP id b6mr62397520pgn.426.1558230982600;
        Sat, 18 May 2019 18:56:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u66sm15405640pfb.76.2019.05.18.18.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 18:56:21 -0700 (PDT)
Date:   Sat, 18 May 2019 18:56:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel: fix typos and some coding style in comments
Message-ID: <201905181855.91DE502D@keescook>
References: <20190518101628.14633-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518101628.14633-1-houweitaoo@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 06:16:28PM +0800, Weitao Hou wrote:
> fix lenght to length

Can you please fix all the instances of this in the tree?

$ git grep lenght | grep -v spelling.txt
Documentation/devicetree/bindings/usb/s3c2410-usb.txt: - reg: address and lenght of the controller memory mapped region
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:   * length, need to update lenght of it and the last packet.
kernel/sysctl.c: *      passed the max lenght will be ignored. Multiple writes will append
sound/soc/qcom/qdsp6/q6asm.c: * @len: lenght in bytes

> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  kernel/sysctl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 943c89178e3d..0736a1d580df 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -187,17 +187,17 @@ extern int no_unaligned_warning;
>   * enum sysctl_writes_mode - supported sysctl write modes
>   *
>   * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
> - * 	to be written, and multiple writes on the same sysctl file descriptor
> - * 	will rewrite the sysctl value, regardless of file position. No warning
> - * 	is issued when the initial position is not 0.
> + * to be written, and multiple writes on the same sysctl file descriptor
> + * will rewrite the sysctl value, regardless of file position. No warning
> + * is issued when the initial position is not 0.
>   * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
> - * 	not 0.
> + * not 0.
>   * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
> - * 	file position 0 and the value must be fully contained in the buffer
> - * 	sent to the write syscall. If dealing with strings respect the file
> - * 	position, but restrict this to the max length of the buffer, anything
> - * 	passed the max lenght will be ignored. Multiple writes will append
> - * 	to the buffer.
> + * file position 0 and the value must be fully contained in the buffer
> + * sent to the write syscall. If dealing with strings respect the file
> + * position, but restrict this to the max length of the buffer, anything
> + * passed the max length will be ignored. Multiple writes will append
> + * to the buffer.

Also, why the reflow? It looks like these should stay indented...

>   *
>   * These write modes control how current file position affects the behavior of
>   * updating sysctl values through the proc interface on each write.
> -- 
> 2.18.0
> 

Besides that, thanks for noticing and sending a patch!

-- 
Kees Cook
