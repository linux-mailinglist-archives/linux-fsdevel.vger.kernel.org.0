Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D81420191
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJCMgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhJCMgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:36:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0188BC0613EC;
        Sun,  3 Oct 2021 05:34:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so6965333wro.3;
        Sun, 03 Oct 2021 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+6H29gk5JE9uOrVBBhJeJNY5FJh2GdZNPQn5DpZ8cZA=;
        b=BplgUUozAi7H34bV9L2fp1agmmrnZI3GhgDnyqL9TKSX+2eFBgxK/np6aFGkMh9M2U
         lbbEAdD6mA0iTe/P9B9wJd6rP0ZLCJD/HlFTB0fwKuZ+wfySqMnRRWcrxYJ7igQP9gMp
         jwP2VZG1Bbx0t/0cLj4Q7xPQyIKnBId3JLhXiTeOey0/9due9rIu/6aWgXblp8afRm9L
         N1A24kRecWrOIZwb9jK6Fx1bAERnKTcmlmvoGqsJEb+YG/wmG4KKnUmawnmv9cYSCFNn
         l1eVl9Df4d7FeeaiCrH8nqXw0s3XcGjNTdQZL0NLL5HFZDY66T9oZutg47H1Wh+XlOxs
         wEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+6H29gk5JE9uOrVBBhJeJNY5FJh2GdZNPQn5DpZ8cZA=;
        b=uf0PiVr9jjLNk9i2Km+Zn7l1cnreHuBjBGbjFR9Ss0sSiC79FzA2LYmzcqYAm4LeQy
         XU/nu+27UCVnnfqEs/lt++XsDt9XyqMnTFJ/ZL6jX/gpkoYKDgMz8f1+s2m5r7tKzdF+
         P8NtJjL4+MfCyRhhSeddGOis6Wj3X6pIs0JFKbTk9vyLLfPnSTNyOa507DFU9nwSN7GQ
         Bo7CLHIqzu56kQ17oj7QjtLh83pyQ7ndE3rZYe+9SpMDdsNkNlP7r3s6nLKSPXF+R6Y7
         pfZC7btH488s8si7ojGUichc/jvc/TNv06+O6M7gZQalisM7lDzHi3fOCKw7Ysx+Tb/9
         r2eQ==
X-Gm-Message-State: AOAM533Ro0BYTeRnDYvwKvFFGkjbZYCQ5aAV00N3ip4RtovLCrnIopHQ
        vodbpTeFCT5VdBp5xsq9L4w=
X-Google-Smtp-Source: ABdhPJwcSgxan5uPSUTL4o2/8/ashoPf6o9Qjb/reYW/vC/ikLqFZLmqw1lDS4sugJQlq6P8grbhxQ==
X-Received: by 2002:adf:b18a:: with SMTP id q10mr8302114wra.32.1633264493455;
        Sun, 03 Oct 2021 05:34:53 -0700 (PDT)
Received: from [10.8.0.30] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id i1sm11986911wrb.93.2021.10.03.05.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 05:34:53 -0700 (PDT)
Subject: Re: [PATCH v2] mount.2: note that mandatory locking is now fully
 deprecated
To:     Jeff Layton <jlayton@kernel.org>, linux-man@vger.kernel.org
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20211003122330.10664-1-jlayton@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <afe59b8c-845e-44b1-ffac-794334d75694@gmail.com>
Date:   Sun, 3 Oct 2021 14:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211003122330.10664-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

On 10/3/21 2:23 PM, Jeff Layton wrote:
> This support has been fully removed from the kernel as of v5.15.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Both patches applied.

Thanks,

Alex

> ---
>   man2/mount.2 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> v2: use semantic newline, per Alejandro's suggestion
> 
> diff --git a/man2/mount.2 b/man2/mount.2
> index bedd39e68a68..302baf6ebeb8 100644
> --- a/man2/mount.2
> +++ b/man2/mount.2
> @@ -196,6 +196,8 @@ this mount option requires the
>   capability and a kernel configured with the
>   .B CONFIG_MANDATORY_FILE_LOCKING
>   option.
> +Mandatory locking has been fully deprecated in v5.15 kernels, so
> +this flag should be considered deprecated.
>   .TP
>   .B MS_NOATIME
>   Do not update access times for (all types of) files on this filesystem.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
