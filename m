Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06756452C57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhKPIFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 03:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhKPIFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637049755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCSrynp2laCG1R5XEbg3KqtinIS3fppXUc3OoVzsOks=;
        b=G7gljdma5ojE2wOjnRpUf8jL2V0t+Pu9Q+0a0wZRt/Mtibzy3BGzeQJqkKbBfsVZhHpJ8+
        oTnHP00jtYUX9cudhvTHb5MQksy8ibbYM4PfRGaGpFNAYAcNjGIiNSpLcpVOKcuuZjpIsS
        OB9OiZywpMVVHYN2g21PqVUSYQ4bTPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-ytRm86hcPzeHaSoupcPCgA-1; Tue, 16 Nov 2021 03:02:34 -0500
X-MC-Unique: ytRm86hcPzeHaSoupcPCgA-1
Received: by mail-wm1-f72.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so1057133wme.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 00:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LCSrynp2laCG1R5XEbg3KqtinIS3fppXUc3OoVzsOks=;
        b=qvOpVwhXElxgSqH4i8xUAEXWDhvfUvyDcJwUiC4uGyJ6xg4If+uP8dWVWz8UlhgBn1
         QPcI2YvxaMhAiXNmuomJ4Hrg5HKZlbw7TxFZE9ZI6gVZU2aOYxqV6oBINNCm+HHdRxqj
         KLklg9I83DXhIqacZY4QVaRp6rSOFzIU4E3NC6pQK90fy1Vgg49uJ9CGUd/I60+lGXJX
         5JUarASZ6kYvjmvvox1LsKHkr7YNRyJUzZHSliZDU237Cz0tSRo6PAWTbGWtCwZ3m8Mo
         I8xMd8QyqBjdoK446pTMGXvGu5NsD6ynyfhBaOXiS+UeNR+Ah+c9Wcy156SNnmXeuBYs
         DvRQ==
X-Gm-Message-State: AOAM532vaopYVckHtdo4Q3bXZBF28Ke7slckXZu5HleTtx58Jm/udggI
        UEOpTdUFdCOohijgnHxsJ0+nHBIu31TipS38jIsMD6Q9HrsXRtOvbKbbLTV3SXiyyn/QwxqHkkT
        Q2WYR9bGLrkdwtiVw2hWXyJcE/w==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr6954095wrw.104.1637049753060;
        Tue, 16 Nov 2021 00:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6Utf7cFwIqmSHQp5zkqSecC4ZA2odmOYlZZgrRcZkRsT04uEEng/kHgOkrk3tTuv1xPPHkQ==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr6954047wrw.104.1637049752784;
        Tue, 16 Nov 2021 00:02:32 -0800 (PST)
Received: from [192.168.3.132] (p4ff23d3a.dip0.t-ipconnect.de. [79.242.61.58])
        by smtp.gmail.com with ESMTPSA id m20sm1745208wmq.11.2021.11.16.00.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 00:02:32 -0800 (PST)
Message-ID: <4289b936-e40c-cde8-eb08-0bd13c44eba3@redhat.com>
Date:   Tue, 16 Nov 2021 09:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20211112092750.6921-1-david@redhat.com>
 <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.11.21 23:04, Andrew Morton wrote:
> On Fri, 12 Nov 2021 10:27:50 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> To clear a user buffer we cannot simply use memset, we have to use
>> clear_user(). With a virtio-mem device that registers a vmcore_cb and has
>> some logically unplugged memory inside an added Linux memory block, I can
>> easily trigger a BUG by copying the vmcore via "cp":
>>
>> ...
>>
>> Some x86-64 CPUs have a CPU feature called "Supervisor Mode Access
>> Prevention (SMAP)", which is used to detect wrong access from the kernel to
>> user buffers like this: SMAP triggers a permissions violation on wrong
>> access. In the x86-64 variant of clear_user(), SMAP is properly
>> handled via clac()+stac().
>>
>> To fix, properly use clear_user() when we're dealing with a user buffer.
>>
> 
> I added cc:stable, OK?
> 

I was a bit hesitant because this would (beofe the virtio-mem changes)
only trigger under XEN and I was wondering why nobody notices under XEN
so far. But yes, even though it only applies to the kdump kernel,
cc:stable sounds like the right think to do!

Thanks Andrew!

-- 
Thanks,

David / dhildenb

