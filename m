Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A99CEF99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfJGX2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 19:28:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33349 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGX2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:28:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so7622663pls.0;
        Mon, 07 Oct 2019 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G3lhV5GuKjoH/FFmVAY4zEekEsLOojvvPiQU+nFfzrw=;
        b=R+qOk3O0SN18/3oCEAoTXc3at1jY6cpG6Iwdkx1w1Opn1SQpzdGPIAuiaLIgAjFjoQ
         NHXvmgk9LIJT9KZw+U1hsvHtCtxKugpMDN3CbxQmy1HWiUK5XeMimwRBTj3hwfku6cwk
         XCbE7DVkvMmrbKgIt07BDLJ+Rk62TTsBAIYTecf27SoFUkSiaZrU0lDhFQ8wZwLQmj2q
         rggE1Me5JfHUuXdCzPKYpDk/NvKdz/cY2bPhh5x3doyWihEnmylgOc3YvQDvIY69ZUzP
         bf3hLcceNdlcjaiKIYGwgNqkkMnhUcav4gRIOoCZYSxDQRgLYJWEBzPmI7iX25ye1813
         vVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G3lhV5GuKjoH/FFmVAY4zEekEsLOojvvPiQU+nFfzrw=;
        b=EMbJReIMxaMeagcEWcYhISB0ZoV8/L0wqYO/wC1Wk8SUE6kU1FIY09lGtBsAxlhwE6
         vifR6Uox8Z0KTBMW2NL8/dWEyQBZBIGrBiVGdlpDW+liBJmdH8fWY0xf5Oxg+XOo4q5h
         aQxQ2jwm1Jm57W/MWIUiod/ZSFfMJaacgTux4Z8ztl3AdsENwxEK424KmGtgNMNc0mYX
         fiIMKIdxhpLqrpiClLw5vCcXXSgGbbrfZB+ehqxxkSdZT6e1noluhf+rdtT5JnJMaFrz
         dtBJPyWgLakrSRy2OdITkNWNvAF4NpSG6f8BkQtieOE1tWKmbefVeAkUgMa8Lplr8FTb
         Jmow==
X-Gm-Message-State: APjAAAVQxjAb23lm/Uxgkmc8mSsLZ9BY1nsosk5hwj+tAxTkP6sKbU9h
        4bBIIWO+a+/1LmaGG1t7YRi1XWl+
X-Google-Smtp-Source: APXvYqxOIeNo/ReSp6jKfeIqHdIRnyYbKUOMzeNyeEZ1goIdm32pDLySpaMSQ8BUrUxYTTap//iY3A==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr33223460plp.36.1570490913719;
        Mon, 07 Oct 2019 16:28:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l24sm15981262pff.151.2019.10.07.16.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 16:28:33 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:28:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 05/18] watchdog: cpwd: use generic compat_ptr_ioctl
Message-ID: <20191007232832.GA26929@roeck-us.net>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814204259.120942-6-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd,

On Wed, Aug 14, 2019 at 10:42:32PM +0200, Arnd Bergmann wrote:
> The cpwd_compat_ioctl() contains a bogus mutex that dates
> back to a leftover BKL instance.
> 
> Simplify the implementation by using the new compat_ptr_ioctl()
> helper function that will do the right thing for all calls
> here.
> 
> Note that WIOCSTART/WIOCSTOP don't take any arguments, so
> the compat_ptr() conversion is not needed here, but it also
> doesn't hurt.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This patch made it into the kernel, but the infrastructure didn't make it.
Do we need to revert it ?

Guenter

> ---
>  drivers/watchdog/cpwd.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index b973b31179df..9393be584e72 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -473,29 +473,6 @@ static long cpwd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	return 0;
>  }
>  
> -static long cpwd_compat_ioctl(struct file *file, unsigned int cmd,
> -			      unsigned long arg)
> -{
> -	int rval = -ENOIOCTLCMD;
> -
> -	switch (cmd) {
> -	/* solaris ioctls are specific to this driver */
> -	case WIOCSTART:
> -	case WIOCSTOP:
> -	case WIOCGSTAT:
> -		mutex_lock(&cpwd_mutex);
> -		rval = cpwd_ioctl(file, cmd, arg);
> -		mutex_unlock(&cpwd_mutex);
> -		break;
> -
> -	/* everything else is handled by the generic compat layer */
> -	default:
> -		break;
> -	}
> -
> -	return rval;
> -}
> -
>  static ssize_t cpwd_write(struct file *file, const char __user *buf,
>  			  size_t count, loff_t *ppos)
>  {
> @@ -520,7 +497,7 @@ static ssize_t cpwd_read(struct file *file, char __user *buffer,
>  static const struct file_operations cpwd_fops = {
>  	.owner =		THIS_MODULE,
>  	.unlocked_ioctl =	cpwd_ioctl,
> -	.compat_ioctl =		cpwd_compat_ioctl,
> +	.compat_ioctl =		compat_ptr_ioctl,
>  	.open =			cpwd_open,
>  	.write =		cpwd_write,
>  	.read =			cpwd_read,
