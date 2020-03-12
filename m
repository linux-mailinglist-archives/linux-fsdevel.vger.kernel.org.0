Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D87182B2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCLI0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:26:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLI0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:26:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id p2so6210518wrw.7;
        Thu, 12 Mar 2020 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOXwvXmhViXjWlgJNON6/RWwRCogM7s+tZi57Naxvsg=;
        b=mhVHewWmUn9cWoWob2kV9/oNAU+knm6pV/tEl5GH+wuUorgZf1lRoH9Y/KvDbdViVr
         +ENcNj2WPCz6KYNCfuWcVXHebOBdQBZHRj3gmvwpIr8LOqlAmo+TDDET0jGelOdAYlfD
         9aoqakgG+beS11JnyZnpnwEJLnAF+opgngnnov6QiKgiR+ZvawDV97f6S1H3UE0kgTx2
         iadbe6mRyYqUnadO6XgrWIsfmd8CBhFLh16oc1yLMdebAfvv+yDSGeSiqfqwlBer7cVM
         D92qxmrk56JOJwuV8yUQcxNuW6PDmtkresyqqlRZCSKBbGFZTEZhiWu6Dvi3vFO8OXQM
         5w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOXwvXmhViXjWlgJNON6/RWwRCogM7s+tZi57Naxvsg=;
        b=AKgeF6fTfFt/f7a+/z2cuL5MM8YQFDQiA+MFw+2I9k5+ZKFScIjHFVLDKPZqrELf3x
         qm4IvIXRnpwynqx6VKh548NAtmGVBumL6Dexy/tyGj73tOXJZddCZ/X+1LTJTW2EfLKY
         27A80F8zl0hmZZ8kJVbdkI8G23oopoMtr1Aqc4RRm+Asz8B/zFOGJ3+NCGB2Dpo+vusD
         UCfY2unuqWyEjZ3I2qKXl0BKPtbN/AgPmw8y8lhU4qglb3r5yg1adNKuDf7+UbFiU+6J
         5IahCNTqT3PAN+rh30FykyXWkzAtpWz5AfpzCfZcYBmcsWfy4iQ78KWX82uPLdNPXR+9
         SwFQ==
X-Gm-Message-State: ANhLgQ0csHOwrkxo3z720NITjchyo5ARUyWHE+leoBnBIvH+WVaBRBab
        jWbZx1GczvZ/hyrgAqPL5qSrJWqXQvM=
X-Google-Smtp-Source: ADFU+vvaWP4xGGNO/Jiptk/ZTdyzvml108TVAMDjhO6ya8t9Wsf3jbbjroPrwuYCL6+p5Y9jk1R+GQ==
X-Received: by 2002:a5d:6782:: with SMTP id v2mr9485138wru.218.1584001594497;
        Thu, 12 Mar 2020 01:26:34 -0700 (PDT)
Received: from [10.5.49.236] ([195.171.175.163])
        by smtp.gmail.com with ESMTPSA id b16sm71865540wrq.14.2020.03.12.01.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 01:26:33 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [man-pages PATCH v2] statx.2: document STATX_ATTR_VERITY
To:     Eric Biggers <ebiggers@kernel.org>
References: <20200128192449.260550-1-ebiggers@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <451297df-2371-336e-d058-4cd6b4ed9754@gmail.com>
Date:   Thu, 12 Mar 2020 09:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200128192449.260550-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Eric,

On 1/28/20 8:24 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the verity attribute for statx(), which was added in
> Linux 5.5.
> 
> For more context, see the fs-verity documentation:
> https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

Thanks for the patch! Applied.

Cheers,

Michael

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  man2/statx.2 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index d2f1b07b8..d015ee73d 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -461,6 +461,11 @@ See
>  .TP
>  .B STATX_ATTR_ENCRYPTED
>  A key is required for the file to be encrypted by the filesystem.
> +.TP
> +.B STATX_ATTR_VERITY
> +Since Linux 5.5: the file has fs-verity enabled.  It cannot be written to, and
> +all reads from it will be verified against a cryptographic hash that covers the
> +entire file, e.g. via a Merkle tree.
>  .SH RETURN VALUE
>  On success, zero is returned.
>  On error, \-1 is returned, and
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
