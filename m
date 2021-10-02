Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A1941FD7F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhJBRnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhJBRnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 13:43:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0594C0613EC;
        Sat,  2 Oct 2021 10:41:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s24so9618266wmh.4;
        Sat, 02 Oct 2021 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8l7NTwnBa/qBZ75J/tfIMrDpdaYdy3USx9U0mSmwSsE=;
        b=m9gXwL4N8j9exWtreTpmq6laTlbDwLo4jt9KdO/2S7CdufZHm2mSQ8Pp93k9xF+j8h
         712hIwLlCwHDSJV+Vk0fc7X852mi/8piq6zgKkLZ3xm0S1hUFMGZks0/Z/PP18XR4EKi
         oU/WADxB9akfgT4KPoTA90tSwFv3GUis+nx6EuEy4zsJd/sCveXyeeJ4SQLgKVi6l/vN
         NSM3XzjUx4q0MQc55+BDCmvwYRciFs+SYi15ktibFh8RCqiGM4PqC+ro+W7+ii6Yp1J+
         0JgiWFE2VU6eS/kv13+VtALMoZipASGohf/QFobojqy+aHwcKDeW1A0syTdMpQA8vwEL
         Sz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8l7NTwnBa/qBZ75J/tfIMrDpdaYdy3USx9U0mSmwSsE=;
        b=Z8weyv0B3meKrnPkYcKhgSnXv9w0oa81axjSB+XbfxRNqTqyyKVH1+MsleNWSy1oa/
         c2SIeDFqEtP1hTD2wW17NFxGbxWKcVpe9ibSZpmf1EORog4f2mFcUKDEL+xBuglXY/wt
         RMNMxsQOPVKb0n1Y7s5b0d6NsRvzEzn2QCG0gwVHM3Wmx/3cWbhqwmN8dHjHJ/+7RIzg
         NH+rcco0v8+QsnjMZ04cQD07O9n29IdvG4Pv4tT5+/I3yJjZFi9B2fe5jRc6iGMYUTRw
         Smy87s18ZK5KBb4UBrc8Ccx9X5rFJmdYwVidONNGacPOyfM/Pfs1Dh+kzHmGdFXKQ13B
         bwhw==
X-Gm-Message-State: AOAM530T5+xCLMXIM1W3XgvFmucWf3R4B2gDBj0GnZQMEfbW8t1/EqIc
        jcYQwZD6dsPVobx6WXonY2nPxAiSzdk=
X-Google-Smtp-Source: ABdhPJyyDm0ykUEc1iuiKCmRP6WI6dUaf3kX0L4tZcwQXwDRdeHFsy5u8CLm0LOdWNJ2qEEga954ig==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr10355988wml.179.1633196489380;
        Sat, 02 Oct 2021 10:41:29 -0700 (PDT)
Received: from [10.8.0.30] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id l26sm11246921wmi.25.2021.10.02.10.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 10:41:29 -0700 (PDT)
Subject: Re: [PATCH] fcntl.2: note that mandatory locking is fully deprecated
 as of v5.15
To:     Jeff Layton <jlayton@kernel.org>
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-man@vger.kernel.org
References: <20211001121306.17339-1-jlayton@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <3a303b30-2f42-e76f-f9f5-74c188512955@gmail.com>
Date:   Sat, 2 Oct 2021 19:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001121306.17339-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/1/21 2:13 PM, Jeff Layton wrote:
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   man2/fcntl.2 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index 7b5604e3a699..90e4c4a9f379 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -619,8 +619,8 @@ Because of these bugs,
>   and the fact that the feature is believed to be little used,
>   since Linux 4.5, mandatory locking has been made an optional feature,
>   governed by a configuration option
> -.RB ( CONFIG_MANDATORY_FILE_LOCKING ).
> -This is an initial step toward removing this feature completely.
> +.RB ( CONFIG_MANDATORY_FILE_LOCKING ). This feature is no longer
> +supported at all in Linux 5.15 and above.

The same applies here.  Please use a newline after '.', as the previous 
text did.

Thanks,

Alex

>   .PP
>   By default, both traditional (process-associated) and open file description
>   record locks are advisory.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
