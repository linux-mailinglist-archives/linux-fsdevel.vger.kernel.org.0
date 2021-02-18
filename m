Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82131F1B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 22:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBRV14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 16:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBRV1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:27:54 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA4C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 13:27:14 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so1969463pgm.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c+m79ciEPQtD3HXhDa9Mx7ioE7eB7tEB4Vc2ZMwa3tU=;
        b=kMtwIBeVJIlXUzdhySveJr/AeMa8rcI/Bk61f8oH2huplsyeFRVvT1yS8Gc1djF5Tz
         DEmybvfbWBdc95TC/424Wid7kLXfy44gK9F6Ixdz9dN0QoRPPb0eEItRK7qUNv6z6w+v
         9C1SOz5gUwdXpPw/RyQFaJKXLvhyXBbsKAWmPCSjtyF3ez02pK8rBhZUYlOE2+7X6Jny
         HKayWOJq6YuBEY+/1hB3WNBztfuiobxGv/vcIk537c0I0LFISpJsFzGXqQr7MhbhGL1Y
         9ZytG+S0EObBXOara0UC95mIkAKydr5xcOyzQh4DSE4GsMAwvUHmxNGkFV/SteX6fb5N
         o4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c+m79ciEPQtD3HXhDa9Mx7ioE7eB7tEB4Vc2ZMwa3tU=;
        b=lDq3nF7T/wohpjWhyLQ1bZ/vOFjKY+RhQ1v47Nd9EGvlMyhvMXDp6Hc+XefKRX0n2i
         arqzql3RMIkiTx8G72Jv3rI9JSAP/4YpNxmM04ev6IaWmkh+lQ0hwLfsdgmbIYTANVJ8
         S6p0DnamRsb4+eKjpsrQk10uVF6alF4HrtqkBcVLTSM7IG0UZ60mja+AZRrb/NWRKUR5
         ghepOrsvdhruM3Khn9ta95NsPhSeuh4m/hvK+g+sBQFH/XaBy5YD8ysFxa5vXsFzow/s
         xmujrH0m/1nMKoV89yX21jvBOMfiQN/paROdws2CgNoD86GnnYLng5kpyt4xtlySQHcK
         zjoA==
X-Gm-Message-State: AOAM531caktDrIU3p9DU895gcdDnr4feCC0w3+BOZFA9b+dPzCggn1Id
        MHHfvuQthso0A0FwMXLftlCOTw==
X-Google-Smtp-Source: ABdhPJyGQfUvusezDX6eZOyJlUrPSWdxOsvET5Pr6Fbz2U6vnS7DjzgJxmFA3P3nI3Or9F3nq+sq5A==
X-Received: by 2002:a05:6a00:8d4:b029:1b7:7ad9:4864 with SMTP id s20-20020a056a0008d4b02901b77ad94864mr6043969pfu.34.1613683633830;
        Thu, 18 Feb 2021 13:27:13 -0800 (PST)
Received: from [10.64.183.147] (static-198-54-131-136.cust.tzulo.com. [198.54.131.136])
        by smtp.gmail.com with ESMTPSA id u3sm7806487pfm.144.2021.02.18.13.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 13:27:13 -0800 (PST)
Subject: Re: page->index limitation on 32bit system?
To:     Matthew Wilcox <willy@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Message-ID: <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net>
Date:   Thu, 18 Feb 2021 13:27:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218121503.GQ2858050@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/21 4:15 AM, Matthew Wilcox wrote:

> On Thu, Feb 18, 2021 at 04:54:46PM +0800, Qu Wenruo wrote:
>> Recently we got a strange bug report that, one 32bit systems like armv6
>> or non-64bit x86, certain large btrfs can't be mounted.
>>
>> It turns out that, since page->index is just unsigned long, and on 32bit
>> systemts, that can just be 32bit.
>>
>> And when filesystems is utilizing any page offset over 4T, page->index
>> get truncated, causing various problems.
> 4TB?  I think you mean 16TB (4kB * 4GB)
>
> Yes, this is a known limitation.  Some vendors have gone to the trouble
> of introducing a new page_index_t.  I'm not convinced this is a problem
> worth solving.  There are very few 32-bit systems with this much storage
> on a single partition (everything should work fine if you take a 20TB
> drive and partition it into two 10TB partitions).
For what it's worth, I'm the reporter of the original bug. My use case 
is a custom NAS system. It runs on a 32-bit ARM processor, and has 5 8TB 
drives, which I'd like to use as a single, unified storage array. I 
chose btrfs for this project due to the filesystem-integrated snapshots 
and checksums. Currently, I'm working around this issue by exporting the 
raw drives using nbd and mounting them on a 64-bit system to access the 
filesystem, but this is very inconvenient, only allows one machine to 
access the filesystem at a time, and prevents running any tools that 
need access to the filesystem (such as backup and file sync utilities) 
on the NAS itself.

It sounds like this limitation would also prevent me from trying to use 
a different filesystem on top of software RAID, since in that case the 
logical filesystem would still be over 16TB.

> As usual, the best solution is for people to stop buying 32-bit systems.
I purchased this device in 2018, so it's not exactly ancient. At the 
time, it was the only SBC I could find that was low power, used ECC RAM, 
had a crypto accelerator, and had multiple sata ports with 
port-multiplier support.
