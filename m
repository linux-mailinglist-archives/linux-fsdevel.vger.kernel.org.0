Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9A2DB037
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 16:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgLOPiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 10:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLOPh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:37:58 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121ECC0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:37:18 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id 2so19597523ilg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZD9opThJzdw5uaxcEbMggg+xr4MCHA075jI1OjlKCOE=;
        b=z8vPP4mkVb+o+WRNf5XPMXRls8An188CSDkA1+TVhyTQwhTmi39QFDAAOc89R5a6jJ
         zpsdrqziPtc7+kUt3o2BgeHG0WmWudZTxAIW4WBPRMIZmSglIVE/ABAC9aYVBHb+Ap/m
         oDhqJbxVSHxtakY/X/btgRePD1r3KxJrgE3CDpt7Bd3/HUx96SKnGC1OrMkaQmzJvmAt
         fFOGNHG2zNzpiD3gj1/QdvnYg0KolBufeIyFr2nmNgiwN31nObFeYnmL5Zr7s/SXPyfE
         729W9Sg1HFE6MMndpSzWFZhGhtgXitNAMN75Q+i1vS3/9bYtQUZb9+7BeryrpVDhMXrE
         GgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZD9opThJzdw5uaxcEbMggg+xr4MCHA075jI1OjlKCOE=;
        b=U0uTnNMX9VQrNXMaGy69tLOduVoeCD9fPM8/1SD2VNHMVJMilEiGWazEvgYasLtrE1
         NnKX3srVgMXXT8SS71VfBYHI3eNczqwhaLLheI+ztNJvwSxsWnydCUlJbagsELXkQo4/
         Ctp9vlJGUebZR7p96uwd/8f9yzn4aNHLG+KhB0KfRmWhlSpkypwpWjPYxkS/5QJY5Blr
         pwBptgAzsmhw6Li+ial2PIf00G2PC85CkIH6C7ePmE+5FUBgyGQhZt32+HQQqEpSymKm
         AnL+jxtPoGW3CvuhaC+U/QCIqH9dr8gfs4UZ7Urx6nWNZ62zso0Nb2sYfQ1jTCnyg8k3
         FvfQ==
X-Gm-Message-State: AOAM531hdOeGJHVJ3dpwsLjVCuLtwVoODJIA2NCucyPC8hIu+br5f/9x
        41KaEoyRrP1LOscEPLsYgGVYdkPGTiy+pg==
X-Google-Smtp-Source: ABdhPJzvvDuQZfUn2wh7TfP/n+ZUjimz0zIYdO4W02QlJuGUH92OKvAM2JeD/nYPUGRmlykokRNLCw==
X-Received: by 2002:a92:d8c4:: with SMTP id l4mr39759629ilo.38.1608046637499;
        Tue, 15 Dec 2020 07:37:17 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z4sm6182439ioh.32.2020.12.15.07.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:37:16 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org>
 <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
Date:   Tue, 15 Dec 2020 08:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215153319.GU2443@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 8:33 AM, Matthew Wilcox wrote:
> On Tue, Dec 15, 2020 at 08:29:40AM -0700, Jens Axboe wrote:
>> On 12/15/20 5:24 AM, Matthew Wilcox wrote:
>>> On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
>>>> +++ b/fs/namei.c
>>>> @@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>>>>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>>>>  
>>>>  	nd->flags &= ~LOOKUP_RCU;
>>>> +	if (nd->flags & LOOKUP_NONBLOCK)
>>>> +		goto out1;
>>>
>>> If we try a walk in a non-blocking context, it fails, then we punt to
>>> a thread, do we want to prohibit that thread trying an RCU walk first?
>>> I can see arguments both ways -- this may only be a temporary RCU walk
>>> failure, or we may never be able to RCU walk this path.
>>
>> In my opinion, it's not worth it trying to over complicate matters by
>> handling the retry side differently. Better to just keep them the
>> same. We'd need a lookup anyway to avoid aliasing.
> 
> but by clearing LOOKUP_RCU here, aren't you making the retry handle
> things differently?  maybe i got lost.

That's already how it works, I'm just clearing LOOKUP_NONBLOCK (which
relies on LOOKUP_RCU) when we're clearing LOOKUP_RCU. I can try and
benchmark skipping LOOKUP_RCU when we do the blocking retry, but my gut
tells me it'll be noise.

-- 
Jens Axboe

