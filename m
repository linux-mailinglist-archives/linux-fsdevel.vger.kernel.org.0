Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE0196974
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 22:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgC1VYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 17:24:49 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52769 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgC1VYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:24:49 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so5663064pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2020 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cy0P29m0MX5a7JFbLWS3gTrzYWk3vEpJ85XaL9jURGY=;
        b=Fym4U+OhmhAbl1OsMQYALcHZh8Cbq7DPseAxcdF8GVCBfn1m5pmejdl7MBDQzNM5R5
         OWM8ZW+4c4IgDFIM+ijx7Uyw5qH+xM7rIUfAN/56TFdAmOHiEMrXne2TRw5j8HUrDjtE
         hT+A1ibxBhq9Mf0aBoV5UbX7a/Co0SN5finZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cy0P29m0MX5a7JFbLWS3gTrzYWk3vEpJ85XaL9jURGY=;
        b=Vv1BnKYPYREHYZqmNuymAwegalXTVAWaNSSzwRC9AQM8TkTiWCF/NVVsazO9mWHB5U
         4NTTWAEGrq1y3dAI/RxlRX3YzpH/JvyWo5IS0fBfrFSwWVoqFwVmePyebIBJzhXJc1J5
         nyRKeTuYC324NOT4IVJEyad/U128Euoee27GOStJZHG0OfkECMvQJ3OLXGvegzcbs+IT
         G8/A1BziB4RFQABkaCE2erZUCeYlPNREXJZp9LCUN21DqjDMZUfWlicPIbMwjuCCBcfv
         x1YRmhWp0rJJBLvEIcIcrMZRbue+wAaGT+/gW7a3hnprj0pNUXRoBe6AlBpNBcMK8fDp
         q8/w==
X-Gm-Message-State: ANhLgQ1baVUhl1nsRbFC1+38BYcxRiJc+L7Ne1KY2mxZmpU3YGVNxTNi
        Gaug46XziOOmAP2n9cmvFI5PJQscSFw=
X-Google-Smtp-Source: ADFU+vsIk9aw4uyC0avS98IH5kwZ5Uml814+6i6qlsjFCB+5DFcxd0rGLtkHO7OYR5+4vffyy3kG+Q==
X-Received: by 2002:a17:90a:fa8f:: with SMTP id cu15mr5295441pjb.108.1585430688506;
        Sat, 28 Mar 2020 14:24:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6sm6441542pjk.33.2020.03.28.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:24:47 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:24:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Jules Irenge <jbi.octave@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "open list:PROC SYSCTL" <linux-kernel@vger.kernel.org>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] kernel/sysctl.c: Replace 1 and 0 by corresponding
 boolean value
Message-ID: <202003281423.E2DA6482@keescook>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
 <20200327212358.5752-10-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327212358.5752-10-jbi.octave@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:23:56PM +0000, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: Assignment of 0/1 to bool variable
> 
> To fix this, values 1 and 0 of first variable
> are replaced by true and false respectively.
> Given that variable first is of bool type.
> This fixes the warnings.

Sure! Thanks. :)

> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ad5b88a53c5a..4132a35e85bd 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3158,7 +3158,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			 void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int err = 0;
> -	bool first = 1;
> +	bool first = true;
>  	size_t left = *lenp;
>  	unsigned long bitmap_len = table->maxlen;
>  	unsigned long *bitmap = *(unsigned long **) table->data;
> @@ -3249,7 +3249,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			}
>  
>  			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
> -			first = 0;
> +			first = false;
>  			proc_skip_char(&p, &left, '\n');
>  		}
>  		kfree(kbuf);
> @@ -3281,7 +3281,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  					break;
>  			}
>  
> -			first = 0; bit_b++;
> +			first = false; bit_b++;
>  		}
>  		if (!err)
>  			err = proc_put_char(&buffer, &left, '\n');
> -- 
> 2.25.1
> 

-- 
Kees Cook
