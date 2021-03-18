Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13D340753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhCRN7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhCRN67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4To2i+xwe+1qmiy7fiF6l/qncD34bYmhb08BdcZeNM=;
        b=Vatv76cwWJ7NiOdzP6leVcacqUK9nFkYIuyP56he5Pb8SJVnvXO49oZibjdkEj5Ysz5/IA
        ddii1pdKKTEjp9DmrlgNdGI9v+Zc09KeJ5eh5xCL1cETpJlIpOuBpgDnSG1jsdMWdhCo0s
        TuA0h3RBIS5lZ8UV0MtSPbioDy9zZo0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-HrXu0JfwOpS3t-vZRga5FQ-1; Thu, 18 Mar 2021 09:58:57 -0400
X-MC-Unique: HrXu0JfwOpS3t-vZRga5FQ-1
Received: by mail-oi1-f197.google.com with SMTP id x201so11571910oif.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 06:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4To2i+xwe+1qmiy7fiF6l/qncD34bYmhb08BdcZeNM=;
        b=rECULe2MPHia9dP/lHcBltTK+qNL1NOpZpxM+3beYrozwYWK8Ef2Bwm4syG/zVFjKR
         KfKddXOrAZrDJpSOd46xUm+Fq21POdINVojQcPsIjLhaRfXXlurNPC/m7kpWR7bpEtQb
         XMKJ470N5uwTDGPlRV3cFExLrf0OLTWkF/clTX65yg4+dgOAwDhgCuL355vVlH3McF79
         yirKTJ1I7hT2mTZBGiK+xPucf5WLUjX+tA9QLOOzlLeHl9wpwC0n74pOLSiNMDHrCw4c
         1/jW0AC94a9TgKDJ4NW9sqpVegNtmbWr1SrgmYu9iI+A8TDMXu1XRGaN0wQ0F3FRT2gC
         I9gg==
X-Gm-Message-State: AOAM533VAg69QpOtHI0+jyCffWBRCcgnDXdfrda3RFs/oU8k+Nj837Pf
        q01iWpeJZtpxyPxP22367y8EAPTCbyrlH7UvrBAlFYnF3cDQJhn8ChnAqvrkdoyq0Vvij4ssoHb
        wvV7xNY6GI5KOMAnvCK5OwpzVyA==
X-Received: by 2002:a05:6830:120b:: with SMTP id r11mr7191633otp.82.1616075936506;
        Thu, 18 Mar 2021 06:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW+4FG/lY4llWoReFXiv9GdGgubr4KeyLh41T4icSVsCGPTS5mcZltuT4ra5NPolTUeQT3ZA==
X-Received: by 2002:a05:6830:120b:: with SMTP id r11mr7191618otp.82.1616075936337;
        Thu, 18 Mar 2021 06:58:56 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id 24sm516927oiq.11.2021.03.18.06.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 06:58:56 -0700 (PDT)
Subject: Re: Question about sg_count_fuse_req() in linux/fs/fuse/virtio_fs.c
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <810089e0-3a09-0d8f-9f8e-be5b3ac70587@redhat.com>
 <20210318135600.GA368102@redhat.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <19c488d0-2006-4a96-610d-f4825aa43cb3@redhat.com>
Date:   Thu, 18 Mar 2021 08:58:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318135600.GA368102@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/18/21 8:56 AM, Vivek Goyal wrote:
> I think all the in args are being mapped into a single scatter gather
> element and that's why it does not matter whether in_numargs is 3, 2 or 1.
> They will be mapped in a single element.
> 
> sg_init_fuse_args()
> {
>          len = fuse_len_args(numargs - argpages, args);
>          if (len)
>                  sg_init_one(&sg[total_sgs++], argbuf, len);
> }
> 
>          out_sgs += sg_init_fuse_args(&sg[out_sgs], req,
>                                       (struct fuse_arg *)args->in_args,
>                                       args->in_numargs, args->in_pages,
>                                       req->argbuf, &argbuf_used);
> 
> When we are sending some data in some pages, then we set args->in_pages
> to true. And in that case, last element of args->in_args[] contains the
> total size of bytes in additional pages we are sending and is not part
> of in_args being mapped to scatter gather element. That's why this
> check.
> 
> 	if (args->in_numargs - args->in_pages)
> 		total_sgs += 1;

Aha! Thank you, Vivek. That makes sense.

> Not sure when we will have a case where args->in_numargs = 1 and
> args->in_pages=true. Do we ever hit that.

Not in my experience. My previous mail was examining this routine mainly 
in a vacuum.

Connor

> Thanks
> Vivek
> 
>>
>> Especially since the block right below it counts pages if args->in_pages is
>> true:
>>
>>          if (args->in_pages) {
>>                  size = args->in_args[args->in_numargs - 1].size;
>>                  total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
>>                                                   size);
>>          }
>>
>> The rest of the routine goes on similarly but for the 'out' components.
>>
>> I doubt incrementing 'total_sgs' in the first if-statement I showed above is
>> vestigial, I just think my mental model of what is happening here is
>> incomplete.
>>
>> Any clarification is much appreciated!
> 
>>
>> Connor
>>
> 

