Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D745A3A1C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFISHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 14:07:21 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46844 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFISHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:07:20 -0400
Received: by mail-pf1-f180.google.com with SMTP id u126so15057804pfu.13;
        Wed, 09 Jun 2021 11:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsG2vaYvQdsKPU22yVSS/01hRddm/EYSOLT0Jl+RAWg=;
        b=NdIVcZXG1ZTfKccG5eX1Z8CMUwAnfD4ZtJGT71isAQVbHtavoLxmAanMQR6pWdHLSx
         8U4U0VFaaYZ4KRamr+0vPpjEB5tmwBBY2khpVnMGQjVRNiUPCvA9+SUhp9xipaKsMFLg
         5NiFoxKBK6wK9Fs3wS6FYyzibOrI8nZ34Vw0FogMf1E/eUTgeP3JBbbUrX1+MHSwUK+1
         jXdU6s/kY9oKZVMCI72/tKsbWRSJnoE9/vBLctsyHKlQ8h2OojAIIrPvYKKb8tkvl47n
         8651rVEAiXcEvFD59yejYEif5Povu5WC4kLGGYF4Fr8kNb8LwTzyP9xX71Uq3kch9WeO
         q5pg==
X-Gm-Message-State: AOAM530nbp5qbDDuq3macelzFyvHc2lQuAEy3nBYyogZPtwSWW0URtF/
        h++/zfYyqDH/WK3CDNXPDMtfk+tXU7M=
X-Google-Smtp-Source: ABdhPJwiyuIter/swQY3pmVDFdPLJluOoHfavogqfTx6tTfv6Cz1YMd5zHC5FpTpzhrMGj7ZqDZ2bg==
X-Received: by 2002:a63:fc06:: with SMTP id j6mr933048pgi.226.1623261924921;
        Wed, 09 Jun 2021 11:05:24 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x20sm219024pfu.205.2021.06.09.11.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 11:05:24 -0700 (PDT)
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
To:     Ric Wheeler <ricwheeler@gmail.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
Date:   Wed, 9 Jun 2021 11:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/21 3:53 AM, Ric Wheeler wrote:
> Consumer devices are pushed to use the highest capacity emmc class
> devices, but they have horrible write durability.
> 
> At the same time, we layer on top of these devices our normal stack -
> device mapper and ext4 or f2fs are common configurations today - which
> causes write amplification and can burn out storage even faster. I think
> it would be useful to discuss how we can minimize the write
> amplification when we need to run on these low end parts & see where the
> stack needs updating.
> 
> Great background paper which inspired me to spend time tormenting emmc
> parts is:
> 
> http://www.cs.unc.edu/~porter/pubs/hotos17-final29.pdf

Without having read that paper, has zoned storage been considered? F2FS
already supports zoned block devices. I'm not aware of a better solution
to reduce write amplification for flash devices. Maybe I'm missing
something?

More information is available in this paper:
https://dl.acm.org/doi/pdf/10.1145/3458336.3465300.

Thanks,

Bart.
