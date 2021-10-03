Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6B420194
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 14:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJCMhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhJCMhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:37:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA2C0613EC;
        Sun,  3 Oct 2021 05:35:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t2so1411551wrb.8;
        Sun, 03 Oct 2021 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gSncF0X+OOyV7r/Uz4usG5CGtDws9R4Nd6A8fGVLCX8=;
        b=S3v1CGmyos6UY0KgOmAt+9NCecT/VKgcdCqFiXEdrbF5E95W6PLYk9Qtuu/TznBdaO
         b4eWilQC3qt9oXbMq+CRBJJOE3hIXooIsVUn3EvyySaSiX1Xku8KKCIuA8CmGDBnAMMp
         0nQZchejxYHbSFK6yB/CFdcDUjOUgPhyzQEfajKI4X5yvA1NScMsJb1s8utBMGgTeqch
         wzeWbIzibYCtwc4dEmCzaLdZMcQfB83hWer3CQhbJCh4BQRXxiAzZHLOnH8RT2zoTzWg
         z/MwoRhgF8rJ2Pn4P4o1DgDNg19jWsLTEP0bRGi6LWfMmZSbnVYNKZSQiD07xkCfXk7l
         bTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSncF0X+OOyV7r/Uz4usG5CGtDws9R4Nd6A8fGVLCX8=;
        b=LpPgHq2i+uISjY3lD1GQjSxG+kNbNj/qLE2nVBM3GdutERTWi81P1ig/zx3FcfDHOm
         sXYYgCw3iz3Udb3uK2ieuAcb9CWuFEx65BvU/aVe67nZ93uJlQxkzlHVEZzh0qeViWPs
         eH6T9vcIVYzx93Ky8C24OM2MVq+mUpct8NwYX8aIt0m1N3tFbG9ZQ9afh3HgYUSqoEe2
         5a81AFCmrc9vdrkDlIjnSD2AfVTwcAxkAwTBuSYT3S5KvWNa0MPufaZLozThc95sR79C
         fLZfpjYME7oLKyOfDOwjv1L3GGydA5Q6rHP4MPDWjmE/F+5HX8JTtEnItXCRYEcBojDx
         zkhQ==
X-Gm-Message-State: AOAM530gRalgRnnTnSbEUnHNg9i38Crw5VrP9sIz4KJB92V3T9ApvN6a
        Xf0TZmSo+l4+u6a1E3IlOz0=
X-Google-Smtp-Source: ABdhPJxtJ3llD6HQiHWShkczw9FC15PdOlUIOR9L2aeL0NAt6AECMJOKticfwlKXwMSFATv75TYyHQ==
X-Received: by 2002:a5d:528a:: with SMTP id c10mr8549608wrv.101.1633264526188;
        Sun, 03 Oct 2021 05:35:26 -0700 (PDT)
Received: from [10.8.0.30] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id y10sm1182039wrw.5.2021.10.03.05.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 05:35:25 -0700 (PDT)
Subject: Re: [PATCH v2] fcntl.2: note that mandatory locking is fully
 deprecated as of v5.15
To:     Jeff Layton <jlayton@kernel.org>, linux-man@vger.kernel.org
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20211003122418.10765-1-jlayton@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <6cde9f13-cb35-375d-377e-7730452a1ef4@gmail.com>
Date:   Sun, 3 Oct 2021 14:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211003122418.10765-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/3/21 2:24 PM, Jeff Layton wrote:
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Patch applied.

Thanks,

Alex

>   man2/fcntl.2 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> v2: Use semantic newline per Alejandro's suggestion.
> 
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index 7b5604e3a699..4b53a0a2640b 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -620,7 +620,7 @@ and the fact that the feature is believed to be little used,
>   since Linux 4.5, mandatory locking has been made an optional feature,
>   governed by a configuration option
>   .RB ( CONFIG_MANDATORY_FILE_LOCKING ).
> -This is an initial step toward removing this feature completely.
> +This feature is no longer supported at all in Linux 5.15 and above.
>   .PP
>   By default, both traditional (process-associated) and open file description
>   record locks are advisory.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
