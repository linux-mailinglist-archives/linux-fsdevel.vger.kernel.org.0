Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1D29687B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374559AbgJWCYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 22:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374551AbgJWCYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:24:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000BC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 19:24:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t14so21535pgg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IilmWqQBIzdGRFEb8WDv/BGb6Zru01TJYp2UzzvimNo=;
        b=wpeItj4YfzkY9NGX9eDHOZimPqRVq75UcGTuCiNxcwnlDWgOiW57hJ3NtX0tTfJp2E
         x2gbYpQzowr6u+7nM+r93TWzmVJxllGDoUTgZ049kEHsNpVgR0XoNyr4ckDamD/ih83h
         wrS82wdQoSkFPu8fwQVOA/taOU3+U89m7ITVz3gRrXAq8FpurjLUryK6+7jU8zFmVfBl
         bOqk86u+zEi7/njiX3F6GTKjlUlx6FUlQf1ixvdQwrqtmllqDIuFudNIsYqinCpgCbTH
         WlHaXTrHm+w7bpds8L3b4oGt1U2zNH03mToy3yfk3NWzqy8UBC2j6sYRhEksUGnNfc9Y
         uNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IilmWqQBIzdGRFEb8WDv/BGb6Zru01TJYp2UzzvimNo=;
        b=HyVB4msyZuNHfAfrdnGiglyAYol5opBszXdINDg3fNM8Gbhfn8nOO3mZhSf9/4cMum
         RdoJEGTcipK7vnu1FKLnESDmjXZhci3R7S4mQdCIPbGGFEVRp3/KHSscd4heLmNE1jSd
         MFz3G6b0CCOP9iuU3YF+6+XZdT/BZS409ZM8/+k6/SXG5m2y/qeaHLKnPSFnBIZNtT45
         yQaZRO3rihtw5BkSsyVEFdJpzHpKFq90nsd3N8QKPvF68a/eZ+wF0hVquAiAB6nfYBsV
         3YJwj8Ag275LGAPk38vb0tsBfx1Els3Nfoy/cIiz6Rt9Wpc1lTpzqQrF7pJKCtQxUzfq
         C3Kg==
X-Gm-Message-State: AOAM531JgYSMezC0npXzMDoqxRiLDGd5jXSxJ/Yc06R4uj26cQtmSMMl
        zD4eJNv8f7RbRFBOZiz9bGY7NEES3MRU7g==
X-Google-Smtp-Source: ABdhPJzA5EZBSeUdXLjtYYke6gTJ/cVfed1VsTekaPVYNDWK1FLHOCtzWYTzE2/HpeO13h227ZcwHA==
X-Received: by 2002:a62:a10a:0:b029:154:fd62:ba90 with SMTP id b10-20020a62a10a0000b0290154fd62ba90mr10722pff.62.1603419858432;
        Thu, 22 Oct 2020 19:24:18 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g85sm82708pfb.4.2020.10.22.19.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 19:24:17 -0700 (PDT)
Subject: Re: Question on io-wq
To:     Hillf Danton <hdanton@sina.com>
Cc:     Zhang Qiang <qiang.zhang@windriver.com>, viro@zeniv.linux.org.uk,
        io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <98c41fba-87fe-b08d-2c8c-da404f91ef31@windriver.com>
 <20201023020514.2230-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e61d3c07-7db0-28d8-03a0-cae13698a634@kernel.dk>
Date:   Thu, 22 Oct 2020 20:24:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023020514.2230-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/20 8:05 PM, Hillf Danton wrote:
> On Thu, 22 Oct 2020 08:08:09 -0600 Jens Axboe wrote:
>> On 10/22/20 3:02 AM, Zhang,Qiang wrote:
>>>
>>> Hi Jens Axboe
>>>
>>> There are some problem in 'io_wqe_worker' thread, when the 
>>> 'io_wqe_worker' be create and  Setting the affinity of CPUs in NUMA 
>>> nodes, due to CPU hotplug, When the last CPU going down, the 
>>> 'io_wqe_worker' thread will run anywhere. when the CPU in the node goes 
>>> online again, we should restore their cpu bindings?
>>
>> Something like the below should help in ensuring affinities are
>> always correct - trigger an affinity set for an online CPU event. We
>> should not need to do it for offlining. Can you test it?
> 
> CPU affinity is intact because of nothing to do on offline, and scheduler
> will move the stray workers on to the correct NUMA node if any CPU goes
> online, so it's a bit hard to see what is going to be tested.

Test it yourself:

- Boot with > 1 NUMA node
- Start an io_uring, you now get 2 workers, each affinitized to a node
- Now offline all CPUs in one node
- Online one or more of the CPU in that same node

The end result is that the worker on the node that was offlined now
has a mask of the other node, plus the newly added CPU.

So your last statement isn't correct, which is what the original
reporter stated.

-- 
Jens Axboe

