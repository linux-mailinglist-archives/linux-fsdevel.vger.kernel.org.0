Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD823C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392220AbfETPmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 11:42:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36293 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfETPmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 11:42:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so6910162plr.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2019 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vmcG8RNx8r27qs4G/uvSxbM38xV4AIXjM9JTTM1N3Q=;
        b=YZPNJ9rSGLx7NaKcAWzN7Sh8J6x54n6erTjGVANbIwkVYsbsRJ9FwZlBXrqq5QUDe3
         kYbCAdaTxP5hmBmFTI6wbjwJrBgVlpDkg6bBkys46ab5uSTvpUKal1d2XXulejw7VyE+
         hziQx0oM2n476jqJkhf7R6QnHEn/CPBoUHOHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vmcG8RNx8r27qs4G/uvSxbM38xV4AIXjM9JTTM1N3Q=;
        b=JtqIDgvD28bM77S0+9oNLMro2y5bbEeCty+v6QpLVCDS5W/gt1pv+D/PglNR5Plc/Q
         yHNSkYp436RxJIZyR59v223pMXMfKtolF1mkTdUBqMrrYHa5vFkvBGtZVMap1Cwe3TAY
         pwMsxp2vU2AzuQtszPTkb6pW/sUBsp10dU3wDJqcRBFERj4ScUZVhRHPYZOyREn1Hyfq
         3GPpMUepvrhBE8htd5MWxu88nb1Uponk4RDvWB0tYbdazQ4urYTh6DqAt6jrnS9dU+lm
         dtLKMhV6CLzTgGDlzz6hHcGVnOBDMq6S7JZW0yZPN3yQsvOFczEe/KpYjm4sHY/D+TgP
         ohXA==
X-Gm-Message-State: APjAAAX+Am5/lmIwtMVp8Ovpb+mlnO+51BzhaGcZjePb78BP3yIURG+Y
        TtKioI4n6rbP05dvA3ps55dZRnHeHlM=
X-Google-Smtp-Source: APXvYqx9MxJHmbNe1U10Xlc6d40xONeoEjkJKAoJNQoMZAkTkvrWlX6jIuUFqmLh8sQIyWwDEvAsAw==
X-Received: by 2002:a17:902:284a:: with SMTP id e68mr51897631plb.258.1558366927935;
        Mon, 20 May 2019 08:42:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i12sm20224833pgb.61.2019.05.20.08.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:42:06 -0700 (PDT)
Date:   Mon, 20 May 2019 08:42:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: fix typos and some coding style in comments
Message-ID: <201905200841.8A35A0C@keescook>
References: <20190520023700.8472-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520023700.8472-1-houweitaoo@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 20, 2019 at 10:37:00AM +0800, Weitao Hou wrote:
> fix lenght to length

What about the other instances of this misspelling? (See "git grep
lenght").

-Kees

> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
> Changes in v2:
>   - fix space before tab warnings
> ---
>  kernel/sysctl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
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
> -- 
> 2.18.0
> 

-- 
Kees Cook
