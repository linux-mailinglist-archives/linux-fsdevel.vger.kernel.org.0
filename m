Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3B25944
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfEUUlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 16:41:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45869 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfEUUkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 16:40:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so8954633pls.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VmjDYig5cOfeJzpmuRnE4YbNJQ8zuwD2EO9PKFuRqCg=;
        b=ZoN3w9z3uD8ECaFrH1mWGfcXbdL2H57DFbX418kzrKyjv83IjiPRGWXJIdemvMzk9r
         LkE+onb3hP+uPA5KQMc/BtXm2bk4ZHMT06ZG/59w5HqfIarSuJfbz0UD9W7TdgNSiHIB
         CYqGb7kaaeQyzZXVIZwccQCYkLZ3uUPQ5JHHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmjDYig5cOfeJzpmuRnE4YbNJQ8zuwD2EO9PKFuRqCg=;
        b=GbJwzFRR6KFPfc3zPwuNo0Bxupy5jO7oUG6FCnBESr2LYS2VSkX3999ih5yZ8K73id
         6OqRhT1ecS8FcOOGHOIEl6yDoTWVL1BfSzTgRmGsBeMJZ+LEN40ESIuhsaj8yZ1I4Jpa
         AnRF/xdl8mn/PTNrlJ6766HZjCRb1dkX639kIwD9EdOsPrp1FYuraKy4A4mfVXPqv5nn
         HZKgfVlbxGDPmy3yWOU8/rvwWo3wPi+xoIljxFbB1d7unHMQlpKk4WnRtntuV6AbWuLd
         BfPJC+W/6EGAouPFl5Wq1GZkLHvn6P9toN1/eth4ke9M7Vo4KSG91R8gInM50YJNP5ql
         ZDeQ==
X-Gm-Message-State: APjAAAXS/qg5Uzk85HklwyxG8zptflWDSHgtyYDwi+4l5GKwZSAJMZeb
        TIJ4wLzz3kSDwxXFDGSMt42m4g==
X-Google-Smtp-Source: APXvYqzcoa60DP1BCRfYNNgykS/fRPS1E7bZ8Eb21n8ia+/CEeccKQvQRrIXVo4G+UKTFG8KapwAEg==
X-Received: by 2002:a17:902:e7:: with SMTP id a94mr60595135pla.182.1558471239758;
        Tue, 21 May 2019 13:40:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c76sm41508742pfc.43.2019.05.21.13.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:40:39 -0700 (PDT)
Date:   Tue, 21 May 2019 13:40:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] kernel: fix typos and some coding style in comments
Message-ID: <201905211338.D073AB64@keescook>
References: <20190521050937.4370-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521050937.4370-1-houweitaoo@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 01:09:37PM +0800, Weitao Hou wrote:
> fix lenght to length
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

I've aimed this at akpm... Colin, who normally takes your spelling
fix patches? (It looks like your split them up normally? That seems
silly here...)

-Kees

> ---
> Changes in v3:
> - fix all other same typos with git grep
> ---
>  .../devicetree/bindings/usb/s3c2410-usb.txt    |  2 +-
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c  |  2 +-
>  kernel/sysctl.c                                | 18 +++++++++---------
>  sound/soc/qcom/qdsp6/q6asm.c                   |  2 +-
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
> index e45b38ce2986..26c85afd0b53 100644
> --- a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
> @@ -4,7 +4,7 @@ OHCI
>  
>  Required properties:
>   - compatible: should be "samsung,s3c2410-ohci" for USB host controller
> - - reg: address and lenght of the controller memory mapped region
> + - reg: address and length of the controller memory mapped region
>   - interrupts: interrupt number for the USB OHCI controller
>   - clocks: Should reference the bus and host clocks
>   - clock-names: Should contain two strings
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> index 6b89f7eab26c..e0f5e6202a27 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -53,7 +53,7 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
>  	pad = round_up(skb->len, 4) + 4 - skb->len;
>  
>  	/* First packet of a A-MSDU burst keeps track of the whole burst
> -	 * length, need to update lenght of it and the last packet.
> +	 * length, need to update length of it and the last packet.
>  	 */
>  	skb_walk_frags(skb, iter) {
>  		last = iter;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 943c89178e3d..f78f725f225e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -187,17 +187,17 @@ extern int no_unaligned_warning;
>   * enum sysctl_writes_mode - supported sysctl write modes
>   *
>   * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
> - * 	to be written, and multiple writes on the same sysctl file descriptor
> - * 	will rewrite the sysctl value, regardless of file position. No warning
> - * 	is issued when the initial position is not 0.
> + *	to be written, and multiple writes on the same sysctl file descriptor
> + *	will rewrite the sysctl value, regardless of file position. No warning
> + *	is issued when the initial position is not 0.
>   * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
> - * 	not 0.
> + *	not 0.
>   * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
> - * 	file position 0 and the value must be fully contained in the buffer
> - * 	sent to the write syscall. If dealing with strings respect the file
> - * 	position, but restrict this to the max length of the buffer, anything
> - * 	passed the max lenght will be ignored. Multiple writes will append
> - * 	to the buffer.
> + *	file position 0 and the value must be fully contained in the buffer
> + *	sent to the write syscall. If dealing with strings respect the file
> + *	position, but restrict this to the max length of the buffer, anything
> + *	passed the max length will be ignored. Multiple writes will append
> + *	to the buffer.
>   *
>   * These write modes control how current file position affects the behavior of
>   * updating sysctl values through the proc interface on each write.
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 4f85cb19a309..e8141a33a55e 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -1194,7 +1194,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
>   * q6asm_write_async() - non blocking write
>   *
>   * @ac: audio client pointer
> - * @len: lenght in bytes
> + * @len: length in bytes
>   * @msw_ts: timestamp msw
>   * @lsw_ts: timestamp lsw
>   * @wflags: flags associated with write
> -- 
> 2.18.0
> 

-- 
Kees Cook
