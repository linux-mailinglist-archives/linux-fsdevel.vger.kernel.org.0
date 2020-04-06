Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC24E19EF06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 03:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgDFBOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 21:14:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55740 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFBOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:14:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so13018517wmg.5;
        Sun, 05 Apr 2020 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJtMRXUYGhEctBGfz2+hfKmFxvUUDe7W7/3S3divJqU=;
        b=ppBr4Gi9AFrAvDXZtUu8S83Fbs2TO8JPYKUBd1Ecul2SkZjm65BmNBJExrAZKopE2V
         22QY/GxWS6b7NN1b/i/ZBILsMez01/8GB2WQLQlmWBDVzWRQFbShBqLas8ujXP/Vj9wo
         kkNmSpTjMAIZg0pvlmtLq3puydUmz6fBmd97V0stlq2oXdqJNR6zid8dmcRabaJ6+TMG
         iHtb0r9UlSXjWWkSFEYQqKglc54hGeI2NkwcDF6/wr7Ow53vJHEfZ4sD4fe/J1BEXEFn
         auYFz6zz7A4JUhnbIed1KMCLb8vWpgIP78nUK58wKyPy2Qe530HGJ6ORkvjLNxQDAx8H
         1Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJtMRXUYGhEctBGfz2+hfKmFxvUUDe7W7/3S3divJqU=;
        b=BYJqwx7UvNIqk0+t4Dkx41PyFlIgpq0swTTnj8gTiEbyDL3bmvy/xVzoBdUZxpRCO7
         nNhT2lmin1cQKNJR+m1hHsa6dcgGeXl2zNxItSKcx9dwZbgZlur98dRcTzzeB+5317RU
         PISZD8yLy68Jx6IW+aFKS82z6w/QChmJbRoOOvArEVZfWQmsjsCYSTmCL7yf7IbJN0Ur
         rzJRsPcKBxPd0drwhDa3VfXILi3T8L4fd2axPzt0cvPzeRbTb1aYjzoww0jS5hY5u6Ix
         gRg+si9Lm0X45EQYeo4T+mroVtMMEaaE5MR/1dttsLXn53kQbgzdDoQvPSEbA9Lu+3dL
         +6Bw==
X-Gm-Message-State: AGi0Pubc7GagryFz1KWjWXzc+hlIn3A7LyvGpu9mNFtz4cZRoW+mAEYv
        iOqig0CCK4arGBdTIznwVaE=
X-Google-Smtp-Source: APiQypJTBqEB/X/t5i4jbXxMN0/duX0+pVDANaW5/a//QdH1E2+1MGftenSxW10V26tQOfxUv86m/A==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr3617549wmb.112.1586135647517;
        Sun, 05 Apr 2020 18:14:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y20sm13433886wmi.31.2020.04.05.18.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 18:14:06 -0700 (PDT)
Date:   Mon, 6 Apr 2020 01:14:06 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200406011406.aeccnuh4owmm53xs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
 <20200401221021.v6igvcpqyeuo2cws@master>
 <20200401222000.GK21484@bombadil.infradead.org>
 <20200405110743.bzpvz4jzwr4kharr@master>
 <20200405215636.GW21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405215636.GW21484@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 05, 2020 at 02:56:36PM -0700, Matthew Wilcox wrote:
>On Sun, Apr 05, 2020 at 11:07:43AM +0000, Wei Yang wrote:
>> Occasionally, I see this error message without my change on 5.6.
>
>I've never seen this one before.  Maybe my test machine is insufficient ...
>
>> random seed 1586068185
>> running tests
>> XArray: 21151201 of 21151201 tests passed
>> =================================================================
>> ==6040==ERROR: AddressSanitizer: heap-use-after-free on address 0x60c0031bce81 at pc 0x00000040b4b3 bp 0x7f95e87f9bb0 sp 0x7f95e87f9ba0
>> READ of size 1 at 0x60c0031bce81 thread T11
>>     #0 0x40b4b2 in xas_find_marked ../../../lib/xarray.c:1182
>>     #1 0x45318e in tagged_iteration_fn /root/git/linux/tools/testing/radix-tree/iteration_check.c:77
>>     #2 0x7f95ef2464e1 in start_thread (/lib64/libpthread.so.0+0x94e1)
>>     #3 0x7f95ee8026d2 in clone (/lib64/libc.so.6+0x1016d2)
>> 
>> 0x60c0031bce81 is located 1 bytes inside of 128-byte region [0x60c0031bce80,0x60c0031bcf00)
>> freed by thread T1 here:
>>     #0 0x7f95ef36c91f in __interceptor_free (/lib64/libasan.so.5+0x10d91f)
>>     #1 0x43e4ba in kmem_cache_free /root/git/linux/tools/testing/radix-tree/linux.c:64
>> 
>> previously allocated by thread T13 here:
>>     #0 0x7f95ef36cd18 in __interceptor_malloc (/lib64/libasan.so.5+0x10dd18)
>>     #1 0x43e1af in kmem_cache_alloc /root/git/linux/tools/testing/radix-tree/linux.c:44
>> 
>> Thread T11 created by T0 here:
>>     #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
>>     #1 0x454862 in iteration_test /root/git/linux/tools/testing/radix-tree/iteration_check.c:178
>> 
>> Thread T1 created by T0 here:
>>     #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
>>     #1 0x7f95ef235b89  (/lib64/liburcu.so.6+0x3b89)
>> 
>> Thread T13 created by T0 here:
>>     #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
>>     #1 0x4548a4 in iteration_test /root/git/linux/tools/testing/radix-tree/iteration_check.c:186
>> 
>> This is not always like this. Didn't figure out the reason yet. Hope you many
>> have some point.
>
>How often are you seeing it?
>

Didn't do a strict analysis. My intuition feels 30% of reproduction.

>T1 (the thread which frees the memory) is the RCU thread, so the freeing
>went through RCU.  For some reason, T11 (the iterating thread) isn't
>preventing the freeing by its use of the RCU read lock.

Maybe this is the RCU problem. I didn't manage to install liburcu from rpm,
but build it from source.

-- 
Wei Yang
Help you, Help me
