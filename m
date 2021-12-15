Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D7E476445
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhLOVJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 16:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhLOVJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:09:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC06C06173E
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 13:09:07 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c3so32242568iob.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 13:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=khq2CEvPFR4tLwZGMVCjn1G+8eKInJXDKthA9h24I/Y=;
        b=oG9+1bGB1AA/Wh7IQU205m2239LxqczPKzgdy7NZ5g/sA40XovmcqJZ3tZXho06huq
         3xAKP3g1Okm3JTt8Rqg+0YpFFwvMGVtZOgohlAwD8z8t2oiyBopINuOpOx0u4rgpuhfN
         Dj6YWOOGEcwi+rTIyH+1+AMa7PRYfrrl5P4zPSYHNGtjdVZt6zg6XOYvROnvfSAIqIAD
         +Lf/AwgKp67QouQmCJtVIpzM5XMKVneVoAlH0F1i/j0azzbIP2KWHS1CM7DUHuslPGoP
         AL1ah9sHo3afCX+3LuXS6PowA7GlXN+9TciS3pcNn3qnEm2qiEy+Fom24OxpNajp1Es0
         n5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khq2CEvPFR4tLwZGMVCjn1G+8eKInJXDKthA9h24I/Y=;
        b=vmJdzvFUaj16/8VfkEDELm0tBBguBFSnRgPQ/F/FaPJFm6Ofz/CkqIxUvQe0OdDbdj
         7nVR4HH060y0sdPxVwdwcmsSDx59lUqekaLVBoThl4XFiAIvNRdgtO0mGqJOJ2OLwk/+
         LwZZe2TXocoj8mA6XVPXgp/aKGEmeY+caCd1MEfuyUheweemaqJ8FLMBfcrMHN5rFIw0
         ROU072D3lJErI+pKqZdzYHRqK+okva4BDqEKIcM5JwAc5PP6JHgef/pUXA/rzLJrza5x
         BWb9dqBehYugN7RaHIwj/Xp4kpN3MmT2yP4N3IvmblLUmyKNE4A4yq4+vqEgA2yQqBv5
         ocRg==
X-Gm-Message-State: AOAM532lAgz0E+TCCvaw77EDNzXBucWuaN8cD7Kktxcoz7+SrcfJ5iHb
        lRB+XdBuLZ3U1B9MZfKF1Ve4DQ==
X-Google-Smtp-Source: ABdhPJygjAe+3TBjMYBvjkYFaGgWrOk5Zn7Fg7LV3r75EDI6dlOEie++cM9odTqV5Fz6KGvsI0v7ag==
X-Received: by 2002:a05:6638:38a:: with SMTP id y10mr7035274jap.8.1639602546968;
        Wed, 15 Dec 2021 13:09:06 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i1sm1613091ilv.54.2021.12.15.13.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 13:09:06 -0800 (PST)
Subject: Re: [PATCH v3 0/5] io_uring: add xattr support
To:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20211203191516.1327214-1-shr@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <809a9b1c-236d-abb0-2c65-e011e9f28057@kernel.dk>
Date:   Wed, 15 Dec 2021 14:09:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211203191516.1327214-1-shr@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/3/21 12:15 PM, Stefan Roesch wrote:
> This adds the xattr support to io_uring. The intent is to have a more
> complete support for file operations in io_uring.
> 
> This change adds support for the following functions to io_uring:
> - fgetxattr
> - fsetxattr
> - getxattr
> - setxattr
> 
> Patch 1: fs: split off do_user_path_at_empty from user_path_at_empty()
>   This splits off a new function do_user_path_at_empty from
>   user_path_at_empty that is based on filename and not on a
>   user-specified string.
> 
> Patch 2: fs: split off setxattr_setup function from setxattr
>   Split off the setup part of the setxattr function.
> 
> Patch 3: fs: split off do_getxattr from getxattr
>   Split of the do_getxattr part from getxattr. This will
>   allow it to be invoked it from io_uring.
> 
> Patch 4: io_uring: add fsetxattr and setxattr support
>   This adds new functions to support the fsetxattr and setxattr
>   functions.
> 
> Patch 5: io_uring: add fgetxattr and getxattr support
>   This adds new functions to support the fgetxattr and getxattr
>   functions.

Al, ping on this series, are you fine with the VFS changes?

-- 
Jens Axboe

