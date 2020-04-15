Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EC41A9177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 05:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbgDODKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731026AbgDODKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:10:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB1C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2020 20:10:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n10so910293pff.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2020 20:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rl9PWj3uTfyqXygouG7eBzkOuRR3ht3SlSVZEdS5vi4=;
        b=WReb3FooecG/mGVKk7KoTDNmzBB8JA07kS8Wlt7cGOj1b+24cYEuDDpfQIYT19Pgq3
         D6Lmumf0FVKLo2Mq50BPVQcRiaZfDl6vC92/MGZX/r0LfWfPWUejG4s92xqamybetQPm
         UmeEt0q1UUwCZuMGpM5Q2JjGxrKiO51WcBNsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rl9PWj3uTfyqXygouG7eBzkOuRR3ht3SlSVZEdS5vi4=;
        b=DklaTGQsxPAnkv66EsvZ57/sLMF0jGau/1ZWaePFZNhA0+isoRGu0ULZUyc/dH/3+C
         La0YrDMITPQPizaHbO8Xo2wxbWiOoXTS50BHTSrHhnkb5qdbeuT5sg74KsW7BSAl/77v
         4tAg1/WdV32y27+6XGdiR1eoTV9ITVp9Ezl+xX9aogEA42bgdnQzvTTEegBzh7qBCTOY
         l0GDAlqjrfZEJ4oX49yLLOu4wqcUIOZyicDx2vNA/+omT02L9mt7V3bsDMtP868eq14o
         CancR/nfDyb7h0BK3kBZLw+I/wc5ALSEiu/8VfmueFAlTsYB1zl2zEqZh1n8sZ/bGwN0
         7Pyw==
X-Gm-Message-State: AGi0PuZl4xvQMChTpfOrd996vL9SVxI4fGNofqrfS3+MAiZxc1J6f8U7
        0nc3EBdT6751UMgl6uk5CiLkRA==
X-Google-Smtp-Source: APiQypLN7j/9XXU0t6HBqN7MgkhuUOzn37VdNDeJBnJniYxDkolOenYFHYWHDRbtpX384Nu0Yk81cA==
X-Received: by 2002:a62:e213:: with SMTP id a19mr11074202pfi.180.1586920245009;
        Tue, 14 Apr 2020 20:10:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189sm12161684pfg.170.2020.04.14.20.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:10:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:10:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] test_firmware: remove unnecessary test_fw_mutex in
 test_dev_config_show_xxx
Message-ID: <202004142010.C0847F5@keescook>
References: <20200415002517.4328-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415002517.4328-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:25:17PM -0700, Scott Branden wrote:
> Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
> functions that show simple bool, int, and u8.

I would expect at least a READ_ONCE(), yes?

> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  lib/test_firmware.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 0c7fbcf07ac5..9fee2b93a8d1 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -310,27 +310,13 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
>  	return ret;
>  }
>  
> -static ssize_t
> -test_dev_config_show_bool(char *buf,
> -			  bool config)
> +static ssize_t test_dev_config_show_bool(char *buf, bool val)
>  {
> -	bool val;
> -
> -	mutex_lock(&test_fw_mutex);
> -	val = config;
> -	mutex_unlock(&test_fw_mutex);
> -
>  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>  
> -static ssize_t test_dev_config_show_int(char *buf, int cfg)
> +static ssize_t test_dev_config_show_int(char *buf, int val)
>  {
> -	int val;
> -
> -	mutex_lock(&test_fw_mutex);
> -	val = cfg;
> -	mutex_unlock(&test_fw_mutex);
> -
>  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>  
> @@ -354,14 +340,8 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>  	return size;
>  }
>  
> -static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
> +static ssize_t test_dev_config_show_u8(char *buf, u8 val)
>  {
> -	u8 val;
> -
> -	mutex_lock(&test_fw_mutex);
> -	val = cfg;
> -	mutex_unlock(&test_fw_mutex);
> -
>  	return snprintf(buf, PAGE_SIZE, "%u\n", val);
>  }
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
