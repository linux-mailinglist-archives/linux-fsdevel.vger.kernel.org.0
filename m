Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A239926BC5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIPGOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:14:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgIPGOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600236848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAy8F21gDH6+Sw9pecHci2b6o0ZbXZ2VL3vO/JJIxCg=;
        b=DghPFtmvpHDsbd5QTDosgwdLlsXgdk4BQWkjQtANVGyu+jB8jasMt4xwe3VNIblMdzNJWJ
        o0IF/0HSyLhI099NtJMfDg+93k/Ps2zMG/mFzISoGGziNabdJAxTV3TGbf0qtLxaVzeMsJ
        g4yd4w01fdk/oIDgQizSePLn8KvbCqk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-mb_VWsQ0PMK4onTNxOWB0Q-1; Wed, 16 Sep 2020 02:14:06 -0400
X-MC-Unique: mb_VWsQ0PMK4onTNxOWB0Q-1
Received: by mail-ed1-f70.google.com with SMTP id y15so2054315edq.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 23:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAy8F21gDH6+Sw9pecHci2b6o0ZbXZ2VL3vO/JJIxCg=;
        b=rN1GnsaS9YQZLhw+heq1YS4KnoZM0um6cE9VNemn/Qj9oHbPlwt4QxHyIp1FfHHKcd
         pQYhASX8Tbzvws+jqYJObnNgtIcyXtHVXbfFd4bMvQApaqsj6Nakzk1t4rDuRrvkXzDB
         CeFSyGuZGhtXObgCLT0571PQ7LWICNS1m3Xssbif+pQhsmthJlg108yWR3P+fBR5cDo1
         kvYqmnxzOl/KanmVUBNzcNylC+AaRs0MykzUFGpfXca2jiTnsMLM/haxEVjFNukmm7Iu
         H/4kkCkmRpxoc88FsBC2tCPk3zJf6jazJ1XJS2Ne8pmLN7uXf/UYa6erYv15O9gfREVz
         coSg==
X-Gm-Message-State: AOAM5311T17fHAPvM9Kt77HYbe8vBrkBpCL8J0Hxv9ivSrkMZnpC72JW
        lDnbygX8ASvT2dVHlpYH9i8x5CD+75nTJMXjryPNfuzcTHhPrVHjLW78nvecTT+u+u9ebbs0cPO
        AWdoUx04Hoai6YdjbbWrxe3krYg==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr26801635edq.101.1600236844785;
        Tue, 15 Sep 2020 23:14:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOj51KeyKT0NbzS0wwH7CKGKR5OD5UR2xdM1DwXRbWiZncCtgIlJTtmyzDAZRfw8qbkiFyyw==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr26801621edq.101.1600236844528;
        Tue, 15 Sep 2020 23:14:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b5sm13086528edq.69.2020.09.15.23.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:14:03 -0700 (PDT)
Subject: Re: [PATCH] vboxsf: fix comparison of signed char constant with
 unsigned char array elements
To:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200915160336.36107-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <65fbb23b-a533-aedb-75eb-69e1c53eaae9@redhat.com>
Date:   Wed, 16 Sep 2020 08:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915160336.36107-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/15/20 6:03 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparison of signed char constants with unsigned char array
> elements leads to checks that are always false. Fix this by declaring
> the VBSF_MOUNT_SIGNATURE_BYTE* macros as octal unsigned int constants
> rather than as signed char constants. (Argueably the U is not necessarily
> required, but add it to be really clear of intent).
> 
> Addresses-Coverity: ("Operands don't affect result")
> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

A fix for this has already been queued up:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=fixes

Explicit nack for this one, since it will still apply, but combined
with the other fix, it will re-break things.

Regards,

Hans



> ---
>   fs/vboxsf/super.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 25aade344192..986efcb29cc2 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,10 +21,10 @@
>   
>   #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>   
> -#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
> +#define VBSF_MOUNT_SIGNATURE_BYTE_0 0000U
> +#define VBSF_MOUNT_SIGNATURE_BYTE_1 0377U
> +#define VBSF_MOUNT_SIGNATURE_BYTE_2 0376U
> +#define VBSF_MOUNT_SIGNATURE_BYTE_3 0375U
>   
>   static int follow_symlinks;
>   module_param(follow_symlinks, int, 0444);
> 

