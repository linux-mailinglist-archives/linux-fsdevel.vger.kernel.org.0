Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2F2351BE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHAKoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 06:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgHAKoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:44:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ACFC06174A;
        Sat,  1 Aug 2020 03:44:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so33861322ejj.10;
        Sat, 01 Aug 2020 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0hR1kw516Ttmwtk75PPlNpB22ThBWPz7u2QG6F7p13A=;
        b=LPV2RD/E1EGqZbS/0B8C9K5qxhCYETSftJhPP9uMqCbwELRj4l7kchkjWFq0tzxQ7i
         9jWsx/ny6CLNipd7I3HWSaNFwMCBtYHz40oXc1QHbqcG4mMjHSA5AN93uZ9+kA5J0tmN
         8HRXRkF42x/22uWZa8OYRLF43Ni0wq7p2gicP1Y0OYtH7bFhfUruMGSt6U3qCZ97v52F
         bKGJ71MxVPRTr53CT6ilJ1jcEss/+FeSOyKpC6XFBOr99mUP3ouL6FgbC+lJMnOoEA9a
         8MLcrUY6GI1yjVAwxAAX4tyMyWp9zTODg23ylt9Ib9/0O9ezruAnCjZRLXgXPf2OdxAi
         gSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0hR1kw516Ttmwtk75PPlNpB22ThBWPz7u2QG6F7p13A=;
        b=UbKqSu7Vr+N5De23d6jO5+AzNGQhMrcTJwPrV5I1v8rjFGonAzX/CmxqAsT9vyFsuW
         pBvNagd6NL7whbijhiZTcr7aB2/LDaTZCbvAt+hC/iiZXYsxtfco84SKIXh3bUIkphnT
         htkcR87h7TYc2ZdSNiEY6RYTPM50tunlm0wLFW1vLoJfwHOqyxgcHVrcRsnQSN5a6V7E
         uhp4FqDONG3/fE4HMmVoDG5HiLpH2+LDCuf+mNIwSqdW87pAO+ejrD9qx8P1PRo7m3S+
         LNx7bURRVvAUkbtsNAY9ujjr0hwykJ0DL2p9Bfbxsq6EzWnUBs+O+KRQPdLl0fCsvuoO
         FyGg==
X-Gm-Message-State: AOAM5333Vt+OzRyMYv+Lcfw6xtVfR0W17dlBh1Cwt8o5y5iU9z8aCaOA
        lrbYa71YaLM2mE+wB53QDNuuE1w2
X-Google-Smtp-Source: ABdhPJzot2TqgbaoViR6wXLlx1jcJa4HDZxAtnu4RtPaAEG9K8HFqTEfTzhrvJummpjKyIM2efyR+A==
X-Received: by 2002:a17:906:60c6:: with SMTP id f6mr7685153ejk.265.1596278676541;
        Sat, 01 Aug 2020 03:44:36 -0700 (PDT)
Received: from [192.168.43.105] ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id y7sm11039439edq.25.2020.08.01.03.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 03:44:36 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
Message-ID: <d79b17cd-2a48-3802-87a5-030ff6d64a53@gmail.com>
Date:   Sat, 1 Aug 2020 13:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/08/2020 13:36, Pavel Begunkov wrote:
> Use a local var to collect flags in kiocb_set_rw_flags(). That spares
> some memory writes and allows to replace most of the jumps with MOVEcc.

This one is pretty old, but looks like nobody in fsdevel cares.

Jens, any chance you can pick this up? For instancec, I don't like the
binary it generates for io_uring.

> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: fast exit on flags == 0 (Matthew Wilcox)
> 
>  include/linux/fs.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8a00ba99284e..b7f1f1b7d691 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3282,22 +3282,28 @@ static inline int iocb_flags(struct file *file)
>  
>  static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  {
> +	int kiocb_flags = 0;
> +
> +	if (!flags)
> +		return 0;
>  	if (unlikely(flags & ~RWF_SUPPORTED))
>  		return -EOPNOTSUPP;
>  
>  	if (flags & RWF_NOWAIT) {
>  		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>  			return -EOPNOTSUPP;
> -		ki->ki_flags |= IOCB_NOWAIT;
> +		kiocb_flags |= IOCB_NOWAIT;
>  	}
>  	if (flags & RWF_HIPRI)
> -		ki->ki_flags |= IOCB_HIPRI;
> +		kiocb_flags |= IOCB_HIPRI;
>  	if (flags & RWF_DSYNC)
> -		ki->ki_flags |= IOCB_DSYNC;
> +		kiocb_flags |= IOCB_DSYNC;
>  	if (flags & RWF_SYNC)
> -		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> +		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
>  	if (flags & RWF_APPEND)
> -		ki->ki_flags |= IOCB_APPEND;
> +		kiocb_flags |= IOCB_APPEND;
> +
> +	ki->ki_flags |= kiocb_flags;
>  	return 0;
>  }
>  
> 

-- 
Pavel Begunkov
