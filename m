Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E175626AE46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgIOT62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgIOT4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:56:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97BC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:56:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gr14so6856198ejb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GpAjogX5KHpPYudErdDqBFNqQR1HiYdRO79ByOxK/1M=;
        b=YZ1qJeWD42At/4TPPtDp1NiAXhBuWITqr/9SfJi5gJ/aGGCrzamXIsOlxmqXCL7m5+
         IMDBGZeXSOP3Zr+fc0Eqa5VYV460KI/Lrt5BcRkCtkLLY1iugXf/E4yk85Gr649FVuyW
         BHSQ8ENiyk9US/p7BCZTf27LmX9B7Ed4hbnoZVBrWCfYVNbvF7nDO9Xx3cK5Eg2zuffg
         p7IHCOzxxGtocsXOX84JU7k5w1p9UrqH9F/1FjbHuYaTlLqW8HJ94zrw6FL9FIhTE6u7
         jZ22SQZpEPLKVHx8ZHwryuZxQB1NTc4s5+2Q0ZT7W/4bsGFDUJmNaIMaqcKHwXm3WaKU
         k0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpAjogX5KHpPYudErdDqBFNqQR1HiYdRO79ByOxK/1M=;
        b=f0kDx5tuAPo03ZzUeGwis2M4uO5aAnaBEzqiVIRP35DGpFXJRWtoVMtZE4syopImHb
         Z4qXPxy6VGZn38+64UO9vELkm3+DXZjOBFsgvqEDHA8bL4jM4ZeAvaVtGc1hWQQn1b8M
         DF5L5vxXz6mPhkSBFPoDuITatYcz5MhryaBVNWvJaQe0UR1sTIOZJ0xROOrHjKkQBonG
         nAScKJhaSF4TwhwdN8vxFeX/vGRCv6RAOudG5svt09Lkt1xBcbLkrx5hAS+zF02K4KQO
         4HW1qBY3qKXxC2FAzIa0kVOfGpVwM4PWf54X0YW1j1MDYPa/rGvQFHVFbvBV2nhrnEzU
         rDiA==
X-Gm-Message-State: AOAM531XyMMUu+0XBsn7Lf163mg1iB5toe8h+Nxifm67kKrk/cPYRuza
        y11uDEou7S/i8mfQ+bPQjqyjjxJy0+6Zx40O
X-Google-Smtp-Source: ABdhPJyryQLLphSyB8qnI1GpJF4j42P2if4BPsLIss/EPwd2ejE5TgpyVTFXUuEyqwfC76ZKJF0D3A==
X-Received: by 2002:a17:907:2115:: with SMTP id qn21mr21463544ejb.278.1600199803404;
        Tue, 15 Sep 2020 12:56:43 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ec32:668e:7a20:c1cd])
        by smtp.gmail.com with ESMTPSA id by24sm11059782ejc.100.2020.09.15.12.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:56:42 -0700 (PDT)
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net>
 <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
 <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
 <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
 <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <37989469-f88c-199b-d779-ed41bc65fe56@tessares.net>
Date:   Tue, 15 Sep 2020 21:56:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/09/2020 21:32, Linus Torvalds wrote:>
> Was that an actual UP kernel? It might be good to try that too, just
> to see if it could be an SMP race in the page locking code.

I am sorry, I am not sure how to verify this. I guess it was one 
processor because I removed "-smp 2" option from qemu. So I guess it 
switched to a uniprocessor mode.

Also, when I did the test and to make sure I was using only one CPU, I 
also printed the output of /proc/cpuinfo:


+ cat /proc/cpuinfo 

processor       : 0 

vendor_id       : AuthenticAMD 

cpu family      : 23 

model           : 1 

model name      : AMD EPYC 7401P 24-Core Processor 

stepping        : 2 

microcode       : 0x1000065 

cpu MHz         : 2000.000
cache size      : 512 KB 

physical id     : 0 
 
 

siblings        : 1 
 
 

core id         : 0 

cpu cores       : 1 

apicid          : 0 

initial apicid  : 0 

fpu             : yes 
 
 

fpu_exception   : yes 

cpuid level     : 13 

wp              : yes 
 
 

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm rep_good nopl cpuid extd_apicid tsc_known_freq pni 
pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm 
cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ssbd 
ibpb vmmcall fsgsbase tsc_adjust bmi1 avx2 smep bmi2 rdseed adx smap 
clflushopt sha_ni xsaveopt xsavec xgetbv1 virt_ssbd
arat npt nrip_save arch_capabilities
bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 
spectre_v2 spec_store_bypass 
 

bogomips        : 4000.00
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64 

address sizes   : 40 bits physical, 48 bits virtual 

power management:


Do you want me to try another qemu config?

Sorry, it is getting late for me but I also forgot to mention earlier 
that with 1 CPU and your new sysctl set to 1, it didn't reproduce my 
issue for 6 executions.

> After all, one such theoretical race was one reason I started the rewrite.

And that's a good thing, thank you! :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
