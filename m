Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4028B3C2334
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGIMBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 08:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhGIMBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625831920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuFxCjGxNh1s//8/+rvZWuY1XbBWxr4LXzkXcXPHOes=;
        b=aRcQvZpdVKV+UY7Dnc/6LW3X1zWkUtBtmIoxMzhySfkju8a5iew36H1bFUdgU2nih+TQA3
        uvfFiTb01SipvqUZml+ioiUhkdwUzKVasIOKsEIvLzZXePck8PMn1gQxt29ykDZrtH8xix
        W1Jx/Xptkjf1YbAvwAoOwvnQBLBQ0gE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-9zd5Z9DzMUeA_74Nhe8WoQ-1; Fri, 09 Jul 2021 07:58:39 -0400
X-MC-Unique: 9zd5Z9DzMUeA_74Nhe8WoQ-1
Received: by mail-wr1-f70.google.com with SMTP id l21-20020a0560000235b029013564642c78so2752870wrz.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jul 2021 04:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FuFxCjGxNh1s//8/+rvZWuY1XbBWxr4LXzkXcXPHOes=;
        b=kW9ckySjoXUDHeMFhhw4UCyIxTomju/bigfIy3JkaoZAUfpJdegzRPHV941dZvqwUV
         4EFsyvjet/pZYJzOGGFUr7H6rb9YbeLi8nBD9wiIr27BB4vFHALqDUbqloU8RNv5fAZ/
         7AOI9o2N+xNihiS+Z+qSdqp6aAgYdf5zAsC4PtW1VtnWUFCvAaSMSntLE7JT1bbSY4/Z
         zlvQ2BLVIw4yOrzG07URq4T0KtakHCmUmDhsTR8Ve/5ZapUvhXrqADIuIcvwq470Pz8R
         JQjqDHMhqVEdKN5SsPcf8g82moIS4AzuTcqRRdsWJ+wb17lqIckZ3VeH6/KpNuknXaI2
         qe7Q==
X-Gm-Message-State: AOAM531hA81A5Qv3Gv6PdiiZElaeougW0OoSFU94oAb6IeFJvAHxKdCn
        g9Pu4KE9udtBuWNGCYvd/3h1CRyBnErAga25J232FUWSAggj7IQ4Bv/JK3bMBPMfgUl+bIWqqh/
        Za6CjwGQHzvAbPhNUwKF12nymYA==
X-Received: by 2002:adf:f68c:: with SMTP id v12mr3128763wrp.360.1625831918049;
        Fri, 09 Jul 2021 04:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyim5N1USaxYaocYdwzdDVk3Pi1SzoUm517PhIHt2LlW5hZerMhCXi5JonII8cQ1eauGxo3+A==
X-Received: by 2002:adf:f68c:: with SMTP id v12mr3128752wrp.360.1625831917915;
        Fri, 09 Jul 2021 04:58:37 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23a45.dip0.t-ipconnect.de. [79.242.58.69])
        by smtp.gmail.com with ESMTPSA id s9sm5066131wrn.87.2021.07.09.04.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 04:58:37 -0700 (PDT)
Subject: Re: [PATCH v1] binfmt: remove support for em86 (alpha only)
To:     Matt Turner <mattst88@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>
References: <20210420175631.46923-1-david@redhat.com>
 <CAEdQ38FOJdZxB7OGd569Lkn+RGPyjoukriwDfBEf2QKHvYguXQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8d3e3257-860a-6766-f598-0d94582db523@redhat.com>
Date:   Fri, 9 Jul 2021 13:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEdQ38FOJdZxB7OGd569Lkn+RGPyjoukriwDfBEf2QKHvYguXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.04.21 04:36, Matt Turner wrote:
> This seems very reasonable, and I'll merge it through my tree unless
> someone beats me to it.
> 

Hi Matt,

looks like this patch hasn't found its way upstream yet.

-- 
Thanks,

David / dhildenb

