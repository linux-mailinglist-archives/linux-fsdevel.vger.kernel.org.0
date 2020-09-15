Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858B326AD8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIOT1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgIOT1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:27:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB43C061351
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:26:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p9so6682383ejf.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=mseVmTwgt4sXFJsBKX6yKcSzD3/ShrUxA/PPF66pEns=;
        b=PF8jhy/Id1wotYDl3GNEPxDJlhTkjP0vxFnTQP9b5JVcIA/PaxkEOAIBYtP/bNnlsJ
         KnWZvNItWtRvtqQQZJ8+ODJOuae3r5l1Zv39JFUkmKUImYWGtuLI2ksLnom5H+1AjiDs
         vuiNIzBm+8ghc9GgRv5yt198sjAA1suMLc5MotCZogorOzWeHdw5gIpwJv4wRT9PILqU
         i8/rjKHDrKTXCzzoNkd7jE6mZ1mThgCb76xHdhykQcCfFUvyXsb5YASxjQIRpR3RIjEz
         8M9qpGpdlAH9RXgjmswje3yFLgReiKMvrav+qsVvFhR7mHRO3Fd1BE514MDcw82REMny
         Pkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=mseVmTwgt4sXFJsBKX6yKcSzD3/ShrUxA/PPF66pEns=;
        b=SjUPiPHPat7QwwP3Co3xK0doWpUU/5XGdI6rF/KWUh21t6ZsrcRefP3SmtPgjc9psK
         sli+iUuxRKmhNFXMfVihjmAXhKQirc6Db+VrlgquVKZF6prCSv5mwP3oj6p5AeHZPPtd
         wLvNryYGROnbrBHdy5mC6hRGCkRZNKRMvDwY7HTYVREzbn+pBbw4hY8Vz3vGSPDrb4Tf
         uVVDyuaiR5SIXvs2o09XAB0bd8+tKWCw9RaLH+Vke6JtUJHMAPkFH9XSrpc9ZUyZjZhl
         Dp2kbeNBkoc8quqFgdJ/7Fk7GkF8OzeTSRVLk8Sj1IjFGZM5gXRg/zBsJwqukR2UDbwY
         8Yfg==
X-Gm-Message-State: AOAM532t6OmEXAVwvvSoI28rrSgxNuXHPwU3fcCA7D3DaKXp32hGlbpv
        l+nyirB9batNoAQ3Tb44agMyP2+vHZHK4Wyg
X-Google-Smtp-Source: ABdhPJwf0FZze8f7n67bH5Ev9WaEOaiis8Sw6Ks0SPEPvshlO6Hjrqvm5aHd3Uij0UujjVeaboxy3g==
X-Received: by 2002:a17:906:ca8f:: with SMTP id js15mr22721111ejb.175.1600198016111;
        Tue, 15 Sep 2020 12:26:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ec32:668e:7a20:c1cd])
        by smtp.gmail.com with ESMTPSA id p17sm10290390ejw.125.2020.09.15.12.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:26:55 -0700 (PDT)
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
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
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
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
Date:   Tue, 15 Sep 2020 21:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------83E65E0D9302FD4BD655044E"
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------83E65E0D9302FD4BD655044E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2020 20:47, Linus Torvalds wrote:
> On Tue, Sep 15, 2020 at 11:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Every one of them is in the "io_schedule()" in the filemap_fault()
>> path, although two of them seem to be in file_fdatawait_range() rather
>> than in the lock_page() code itself (so they are also waiting on a
>> page bit, but they are waiting for the writeback bit to clear).
> 
> No, that seems to be just stale entries on the stack from a previous
> system call, rather than a real trace. There's no way to reach
> file_fdatawait_range() from mlockall() that I can see.
> 
> So I'm not entirely sure why the stack trace for two of the processes
> looks a bit different, but they all look like they should be in
> __lock_page_killable().
> 
> It's possible those two were woken up (by another CPU) and their stack
> is in flux. They also have "wake_up_page_bit()" as a stale entry on
> their stack, so that's not entirely unlikely.

I don't know if this info is useful but I just checked and I can 
reproduce the issue with a single CPU. And the trace is very similar to 
the previous one:

------------------- 8< -------------------
[   23.884953] sysrq: Show Blocked State
[   23.888310] task:packetdrill     state:D stack:13952 pid:  177 ppid: 
   148 flags:0x00004000
[   23.895619] Call Trace:
[   23.897885]  __schedule+0x3eb/0x680
[   23.901033]  schedule+0x45/0xb0
[   23.903882]  io_schedule+0xd/0x30
[   23.906868]  __lock_page_killable+0x13e/0x280
[   23.910729]  ? file_fdatawait_range+0x20/0x20
[   23.914648]  filemap_fault+0x6b4/0x970
[   23.918061]  ? filemap_map_pages+0x195/0x330
[   23.921833]  __do_fault+0x32/0x90
[   23.924754]  handle_mm_fault+0x8c1/0xe50
[   23.928011]  __get_user_pages+0x25c/0x750
[   23.931594]  populate_vma_page_range+0x57/0x60
[   23.935518]  __mm_populate+0xa9/0x150
[   23.938467]  __x64_sys_mlockall+0x151/0x180
[   23.942228]  do_syscall_64+0x33/0x40
[   23.945408]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   23.949736] RIP: 0033:0x7f28b847bb3b
[   23.960960] Code: Bad RIP value.
[   23.963856] RSP: 002b:00007ffe48d833c8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   23.970157] RAX: ffffffffffffffda RBX: 000055a16594a450 RCX: 
00007f28b847bb3b
[   23.976474] RDX: 00007ffe48d812a2 RSI: 00007f28b84ff3c0 RDI: 
0000000000000003
[   23.982773] RBP: 00007ffe48d833d0 R08: 0000000000000000 R09: 
0000000000000000
[   23.988998] R10: 00007f28b84feac0 R11: 0000000000000246 R12: 
000055a16590c0a0
[   23.995079] R13: 00007ffe48d83810 R14: 0000000000000000 R15: 
0000000000000000
[   24.001143] task:packetdrill     state:D stack:13952 pid:  179 ppid: 
   146 flags:0x00004000
[   24.008425] Call Trace:
[   24.010495]  __schedule+0x3eb/0x680
[   24.013378]  schedule+0x45/0xb0
[   24.016053]  io_schedule+0xd/0x30
[   24.018763]  __lock_page_killable+0x13e/0x280
[   24.022663]  ? file_fdatawait_range+0x20/0x20
[   24.026564]  filemap_fault+0x6b4/0x970
[   24.029954]  ? filemap_map_pages+0x195/0x330
[   24.033865]  __do_fault+0x32/0x90
[   24.036773]  handle_mm_fault+0x8c1/0xe50
[   24.040072]  __get_user_pages+0x25c/0x750
[   24.043667]  populate_vma_page_range+0x57/0x60
[   24.047200]  __mm_populate+0xa9/0x150
[   24.050554]  __x64_sys_mlockall+0x151/0x180
[   24.054273]  do_syscall_64+0x33/0x40
[   24.057492]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.061795] RIP: 0033:0x7f3f900f2b3b
[   24.065048] Code: Bad RIP value.
[   24.067971] RSP: 002b:00007ffd682b6338 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.074233] RAX: ffffffffffffffda RBX: 0000563239032450 RCX: 
00007f3f900f2b3b
[   24.080303] RDX: 00007ffd682b4212 RSI: 00007f3f901763c0 RDI: 
0000000000000003
[   24.086263] RBP: 00007ffd682b6340 R08: 0000000000000000 R09: 
0000000000000000
[   24.092364] R10: 00007f3f90175ac0 R11: 0000000000000246 R12: 
0000563238ff40a0
[   24.098345] R13: 00007ffd682b6780 R14: 0000000000000000 R15: 
0000000000000000
[   24.104588] task:packetdrill     state:D stack:13512 pid:  185 ppid: 
   153 flags:0x00004000
[   24.111856] Call Trace:
[   24.114132]  __schedule+0x3eb/0x680
[   24.117323]  schedule+0x45/0xb0
[   24.120052]  io_schedule+0xd/0x30
[   24.123036]  __lock_page_killable+0x13e/0x280
[   24.126600]  ? file_fdatawait_range+0x20/0x20
[   24.130146]  filemap_fault+0x6b4/0x970
[   24.133264]  ? filemap_map_pages+0x195/0x330
[   24.136846]  __do_fault+0x32/0x90
[   24.139653]  handle_mm_fault+0x8c1/0xe50
[   24.143165]  __get_user_pages+0x25c/0x750
[   24.146439]  populate_vma_page_range+0x57/0x60
[   24.150050]  __mm_populate+0xa9/0x150
[   24.153325]  __x64_sys_mlockall+0x151/0x180
[   24.157089]  do_syscall_64+0x33/0x40
[   24.160181]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.164690] RIP: 0033:0x7f18e0da3b3b
[   24.167851] Code: Bad RIP value.
[   24.170516] RSP: 002b:00007ffc3a0d67f8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.177116] RAX: ffffffffffffffda RBX: 0000562d7b1b1450 RCX: 
00007f18e0da3b3b
[   24.183423] RDX: 00007ffc3a0d46d2 RSI: 00007f18e0e273c0 RDI: 
0000000000000003
[   24.189707] RBP: 00007ffc3a0d6800 R08: 0000000000000000 R09: 
0000000000000000
[   24.195977] R10: 00007f18e0e26ac0 R11: 0000000000000246 R12: 
0000562d7b1730a0
[   24.202018] R13: 00007ffc3a0d6c40 R14: 0000000000000000 R15: 
0000000000000000
[   24.208311] task:packetdrill     state:D stack:13952 pid:  188 ppid: 
   151 flags:0x00004000
[   24.215398] Call Trace:
[   24.217471]  __schedule+0x3eb/0x680
[   24.220446]  schedule+0x45/0xb0
[   24.223044]  io_schedule+0xd/0x30
[   24.225774]  __lock_page_killable+0x13e/0x280
[   24.229621]  ? file_fdatawait_range+0x20/0x20
[   24.233542]  filemap_fault+0x6b4/0x970
[   24.236868]  ? xas_start+0x69/0x90
[   24.239766]  ? filemap_map_pages+0x195/0x330
[   24.243194]  __do_fault+0x32/0x90
[   24.246252]  handle_mm_fault+0x8c1/0xe50
[   24.249759]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   24.254378]  __get_user_pages+0x25c/0x750
[   24.257960]  populate_vma_page_range+0x57/0x60
[   24.261868]  __mm_populate+0xa9/0x150
[   24.265114]  __x64_sys_mlockall+0x151/0x180
[   24.268683]  do_syscall_64+0x33/0x40
[   24.271658]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.275772] RIP: 0033:0x7f2d0b01eb3b
[   24.278691] Code: Bad RIP value.
[   24.281400] RSP: 002b:00007ffd7b2d9fa8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.287430] RAX: ffffffffffffffda RBX: 000055785f8a4450 RCX: 
00007f2d0b01eb3b
[   24.293273] RDX: 00007ffd7b2d7e82 RSI: 00007f2d0b0a23c0 RDI: 
0000000000000003
[   24.302752] RBP: 00007ffd7b2d9fb0 R08: 0000000000000000 R09: 
0000000000000000
[   24.309115] R10: 00007f2d0b0a1ac0 R11: 0000000000000246 R12: 
000055785f8660a0
[   24.315529] R13: 00007ffd7b2da3f0 R14: 0000000000000000 R15: 
0000000000000000
[   24.321891] task:packetdrill     state:D stack:13952 pid:  190 ppid: 
   157 flags:0x00004000
[   24.329197] Call Trace:
[   24.331531]  __schedule+0x3eb/0x680
[   24.334736]  schedule+0x45/0xb0
[   24.337548]  io_schedule+0xd/0x30
[   24.340362]  __lock_page_killable+0x13e/0x280
[   24.344098]  ? file_fdatawait_range+0x20/0x20
[   24.348001]  filemap_fault+0x6b4/0x970
[   24.351427]  ? filemap_map_pages+0x195/0x330
[   24.355292]  __do_fault+0x32/0x90
[   24.358282]  handle_mm_fault+0x8c1/0xe50
[   24.361788]  __get_user_pages+0x25c/0x750
[   24.365427]  populate_vma_page_range+0x57/0x60
[   24.369408]  __mm_populate+0xa9/0x150
[   24.372726]  __x64_sys_mlockall+0x151/0x180
[   24.376496]  do_syscall_64+0x33/0x40
[   24.379522]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.383623] RIP: 0033:0x7fe749a73b3b
[   24.386534] Code: Bad RIP value.
[   24.389240] RSP: 002b:00007fff6d4ad268 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.395433] RAX: ffffffffffffffda RBX: 0000556473049450 RCX: 
00007fe749a73b3b
[   24.401307] RDX: 00007fff6d4ab142 RSI: 00007fe749af73c0 RDI: 
0000000000000003
[   24.407426] RBP: 00007fff6d4ad270 R08: 0000000000000000 R09: 
0000000000000000
[   24.413696] R10: 00007fe749af6ac0 R11: 0000000000000246 R12: 
000055647300b0a0
[   24.419919] R13: 00007fff6d4ad6b0 R14: 0000000000000000 R15: 
0000000000000000
[   24.425940] task:packetdrill     state:D stack:13952 pid:  193 ppid: 
   160 flags:0x00004000
[   24.433269] Call Trace:
[   24.435568]  __schedule+0x3eb/0x680
[   24.438397]  schedule+0x45/0xb0
[   24.441030]  io_schedule+0xd/0x30
[   24.443760]  __lock_page_killable+0x13e/0x280
[   24.447275]  ? file_fdatawait_range+0x20/0x20
[   24.450919]  filemap_fault+0x6b4/0x970
[   24.453976]  ? filemap_map_pages+0x195/0x330
[   24.457501]  __do_fault+0x32/0x90
[   24.460273]  handle_mm_fault+0x8c1/0xe50
[   24.463397]  __get_user_pages+0x25c/0x750
[   24.466743]  populate_vma_page_range+0x57/0x60
[   24.470728]  __mm_populate+0xa9/0x150
[   24.474084]  __x64_sys_mlockall+0x151/0x180
[   24.477780]  do_syscall_64+0x33/0x40
[   24.480924]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.485302] RIP: 0033:0x7faf08ad9b3b
[   24.488404] Code: Bad RIP value.
[   24.491348] RSP: 002b:00007ffec68c61d8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.497549] RAX: ffffffffffffffda RBX: 00005556df2df450 RCX: 
00007faf08ad9b3b
[   24.503686] RDX: 00007ffec68c40b2 RSI: 00007faf08b5d3c0 RDI: 
0000000000000003
[   24.509693] RBP: 00007ffec68c61e0 R08: 0000000000000000 R09: 
0000000000000000
[   24.515919] R10: 00007faf08b5cac0 R11: 0000000000000246 R12: 
00005556df2a10a0
[   24.521919] R13: 00007ffec68c6620 R14: 0000000000000000 R15: 
0000000000000000
[   24.528173] task:packetdrill     state:D stack:13952 pid:  199 ppid: 
   163 flags:0x00004000
[   24.535290] Call Trace:
[   24.537348]  __schedule+0x3eb/0x680
[   24.540324]  schedule+0x45/0xb0
[   24.542834]  io_schedule+0xd/0x30
[   24.545594]  __lock_page_killable+0x13e/0x280
[   24.549485]  ? file_fdatawait_range+0x20/0x20
[   24.553266]  filemap_fault+0x6b4/0x970
[   24.556501]  ? filemap_map_pages+0x195/0x330
[   24.560073]  __do_fault+0x32/0x90
[   24.562786]  handle_mm_fault+0x8c1/0xe50
[   24.566304]  __get_user_pages+0x25c/0x750
[   24.569874]  populate_vma_page_range+0x57/0x60
[   24.573844]  __mm_populate+0xa9/0x150
[   24.577054]  __x64_sys_mlockall+0x151/0x180
[   24.580624]  do_syscall_64+0x33/0x40
[   24.583629]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.587866] RIP: 0033:0x7efdca54bb3b
[   24.590766] Code: Bad RIP value.
[   24.593713] RSP: 002b:00007ffe160c8be8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.600288] RAX: ffffffffffffffda RBX: 000055668dc19450 RCX: 
00007efdca54bb3b
[   24.606330] RDX: 00007ffe160c6ac2 RSI: 00007efdca5cf3c0 RDI: 
0000000000000003
[   24.612650] RBP: 00007ffe160c8bf0 R08: 0000000000000000 R09: 
0000000000000000
[   24.618715] R10: 00007efdca5ceac0 R11: 0000000000000246 R12: 
000055668dbdb0a0
[   24.625055] R13: 00007ffe160c9030 R14: 0000000000000000 R15: 
0000000000000000
[   24.631336] task:packetdrill     state:D stack:13952 pid:  200 ppid: 
   167 flags:0x00004000
[   24.638212] Call Trace:
[   24.640504]  __schedule+0x3eb/0x680
[   24.643730]  schedule+0x45/0xb0
[   24.646616]  io_schedule+0xd/0x30
[   24.649646]  __lock_page_killable+0x13e/0x280
[   24.653420]  ? file_fdatawait_range+0x20/0x20
[   24.657351]  filemap_fault+0x6b4/0x970
[   24.660596]  ? filemap_map_pages+0x195/0x330
[   24.664134]  __do_fault+0x32/0x90
[   24.666936]  handle_mm_fault+0x8c1/0xe50
[   24.670502]  __get_user_pages+0x25c/0x750
[   24.674111]  populate_vma_page_range+0x57/0x60
[   24.678106]  __mm_populate+0xa9/0x150
[   24.681434]  __x64_sys_mlockall+0x151/0x180
[   24.685191]  do_syscall_64+0x33/0x40
[   24.688289]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.692754] RIP: 0033:0x7f4ac3f45b3b
[   24.696017] Code: Bad RIP value.
[   24.698963] RSP: 002b:00007ffd159771e8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.705620] RAX: ffffffffffffffda RBX: 00005620eb450450 RCX: 
00007f4ac3f45b3b
[   24.711901] RDX: 00007ffd159750c2 RSI: 00007f4ac3fc93c0 RDI: 
0000000000000003
[   24.718195] RBP: 00007ffd159771f0 R08: 0000000000000000 R09: 
0000000000000000
[   24.724468] R10: 00007f4ac3fc8ac0 R11: 0000000000000246 R12: 
00005620eb4120a0
[   24.730689] R13: 00007ffd15977630 R14: 0000000000000000 R15: 
0000000000000000
[   24.736965] task:packetdrill     state:D stack:13952 pid:  202 ppid: 
   174 flags:0x00004000
[   24.744128] Call Trace:
[   24.746188]  __schedule+0x3eb/0x680
[   24.749129]  schedule+0x45/0xb0
[   24.751715]  io_schedule+0xd/0x30
[   24.754430]  __lock_page_killable+0x13e/0x280
[   24.758317]  ? file_fdatawait_range+0x20/0x20
[   24.762160]  filemap_fault+0x6b4/0x970
[   24.765582]  ? filemap_map_pages+0x195/0x330
[   24.769418]  __do_fault+0x32/0x90
[   24.772432]  handle_mm_fault+0x8c1/0xe50
[   24.775700]  __get_user_pages+0x25c/0x750
[   24.779051]  populate_vma_page_range+0x57/0x60
[   24.783009]  __mm_populate+0xa9/0x150
[   24.786309]  __x64_sys_mlockall+0x151/0x180
[   24.790052]  do_syscall_64+0x33/0x40
[   24.793285]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.797821] RIP: 0033:0x7f177627db3b
[   24.801013] Code: Bad RIP value.
[   24.803752] RSP: 002b:00007ffcd9c784d8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.810149] RAX: ffffffffffffffda RBX: 0000556bbe193450 RCX: 
00007f177627db3b
[   24.816393] RDX: 00007ffcd9c763b2 RSI: 00007f17763013c0 RDI: 
0000000000000003
[   24.822407] RBP: 00007ffcd9c784e0 R08: 0000000000000000 R09: 
0000000000000000
[   24.828686] R10: 00007f1776300ac0 R11: 0000000000000246 R12: 
0000556bbe1550a0
[   24.834924] R13: 00007ffcd9c78920 R14: 0000000000000000 R15: 
0000000000000000
[   24.840714] task:packetdrill     state:D stack:13952 pid:  204 ppid: 
   182 flags:0x00004000
[   24.847842] Call Trace:
[   24.850112]  __schedule+0x3eb/0x680
[   24.853316]  schedule+0x45/0xb0
[   24.856185]  io_schedule+0xd/0x30
[   24.859181]  __lock_page_killable+0x13e/0x280
[   24.862675]  ? file_fdatawait_range+0x20/0x20
[   24.866212]  filemap_fault+0x6b4/0x970
[   24.869525]  ? filemap_map_pages+0x195/0x330
[   24.873240]  __do_fault+0x32/0x90
[   24.876250]  handle_mm_fault+0x8c1/0xe50
[   24.879470]  __get_user_pages+0x25c/0x750
[   24.882680]  populate_vma_page_range+0x57/0x60
[   24.894498]  __mm_populate+0xa9/0x150
[   24.897763]  __x64_sys_mlockall+0x151/0x180
[   24.901363]  do_syscall_64+0x33/0x40
[   24.904437]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.908958] RIP: 0033:0x7ff1fe4e2b3b
[   24.911951] Code: Bad RIP value.
[   24.914865] RSP: 002b:00007ffc28177598 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   24.921310] RAX: ffffffffffffffda RBX: 0000558d9bbe3450 RCX: 
00007ff1fe4e2b3b
[   24.927427] RDX: 00007ffc28175472 RSI: 00007ff1fe5663c0 RDI: 
0000000000000003
[   24.933468] RBP: 00007ffc281775a0 R08: 0000000000000000 R09: 
0000000000000000
[   24.939722] R10: 00007ff1fe565ac0 R11: 0000000000000246 R12: 
0000558d9bba50a0
[   24.945719] R13: 00007ffc281779e0 R14: 0000000000000000 R15: 
0000000000000000
[   24.951908] task:packetdrill     state:D stack:13952 pid:  205 ppid: 
   187 flags:0x00004000
[   24.958948] Call Trace:
[   24.961229]  __schedule+0x3eb/0x680
[   24.964212]  schedule+0x45/0xb0
[   24.967086]  io_schedule+0xd/0x30
[   24.970104]  __lock_page_killable+0x13e/0x280
[   24.974001]  ? file_fdatawait_range+0x20/0x20
[   24.977912]  filemap_fault+0x6b4/0x970
[   24.981228]  ? filemap_map_pages+0x195/0x330
[   24.984924]  __do_fault+0x32/0x90
[   24.987934]  handle_mm_fault+0x8c1/0xe50
[   24.991452]  __get_user_pages+0x25c/0x750
[   24.995022]  populate_vma_page_range+0x57/0x60
[   24.998990]  __mm_populate+0xa9/0x150
[   25.002109]  __x64_sys_mlockall+0x151/0x180
[   25.005873]  do_syscall_64+0x33/0x40
[   25.009084]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   25.013550] RIP: 0033:0x7fc6a6880b3b
[   25.016548] Code: Bad RIP value.
[   25.019318] RSP: 002b:00007ffc69437db8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   25.025516] RAX: ffffffffffffffda RBX: 00005572a33dd450 RCX: 
00007fc6a6880b3b
[   25.031678] RDX: 00007ffc69435c92 RSI: 00007fc6a69043c0 RDI: 
0000000000000003
[   25.037940] RBP: 00007ffc69437dc0 R08: 0000000000000000 R09: 
0000000000000000
[   25.044100] R10: 00007fc6a6903ac0 R11: 0000000000000246 R12: 
00005572a339f0a0
[   25.049950] R13: 00007ffc69438200 R14: 0000000000000000 R15: 
0000000000000000

> So that sysrq-W state shows that yes, people are stuck waiting for a
> page, but that wasn't exactly unexpected.

Is there anything else I can do to get more info? I guess a core dump 
would start to be really interesting here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

--------------83E65E0D9302FD4BD655044E
Content-Type: text/plain; charset=UTF-8;
 name="sysrq_w_1_core_analysed.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sysrq_w_1_core_analysed.txt"

WyAgICA0LjcyMTM5NV0gaXAgKDE2NikgdXNlZCBncmVhdGVzdCBzdGFjayBkZXB0aDogMTIy
NjQgYnl0ZXMgbGVmdApbICAgIDQuOTExODYzXSBpcCAoMTk4KSB1c2VkIGdyZWF0ZXN0IHN0
YWNrIGRlcHRoOiAxMjE1MiBieXRlcyBsZWZ0CisgJ1snIC1kIC9wcm9jLzEzOCAnXScKKyBl
Y2hvIHcKWyAgIDIzLjg4NDk1M10gc3lzcnE6IFNob3cgQmxvY2tlZCBTdGF0ZQpbICAgMjMu
ODg4MzEwXSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDog
IDE3NyBwcGlkOiAgIDE0OCBmbGFnczoweDAwMDA0MDAwClsgICAyMy44OTU2MTldIENhbGwg
VHJhY2U6ClsgICAyMy44OTc4ODVdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6
Mzc3OCkKWyAgIDIzLjkwMTAzM10gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20v
Yml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjMuOTAzODgyXSBpb19zY2hl
ZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjMuOTA2ODY4XSBfX2xvY2tf
cGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyMy45MTA3MjldID8gZmls
ZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAg
MjMuOTE0NjQ4XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDIzLjkx
ODA2MV0gPyBmaWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2
MDYpClsgICAyMy45MjE4MzNdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAy
My45MjQ3NTRdIGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDIzLjky
ODAxMV0gX19nZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjMuOTMxNTk0XSBw
b3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDIzLjkzNTUxOF0g
X19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDIzLjkzODQ2N10gX194NjRfc3lz
X21sb2NrYWxsICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjMuOTQyMjI4XSBk
b19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAgIDIzLjk0NTQw
OF0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRy
eV82NC5TOjEyNSkKWyAgIDIzLjk0OTczNl0gUklQOiAwMDMzOjB4N2YyOGI4NDdiYjNiClsg
MjMuOTYwOTYwXSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuTGpx
NXJtRXhtZi5vJzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0
aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KWyAgIDIzLjk2Mzg1Nl0gUlNQOiAwMDJiOjAwMDA3ZmZlNDhkODMzYzggRUZMQUdT
OiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjMuOTcwMTU3XSBS
QVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTVhMTY1OTRhNDUwIFJDWDogMDAwMDdm
MjhiODQ3YmIzYgpbICAgMjMuOTc2NDc0XSBSRFg6IDAwMDA3ZmZlNDhkODEyYTIgUlNJOiAw
MDAwN2YyOGI4NGZmM2MwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjMuOTgyNzczXSBS
QlA6IDAwMDA3ZmZlNDhkODMzZDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAw
MDAwMDAwMDAwMApbICAgMjMuOTg4OTk4XSBSMTA6IDAwMDA3ZjI4Yjg0ZmVhYzAgUjExOiAw
MDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU1YTE2NTkwYzBhMApbICAgMjMuOTk1MDc5XSBS
MTM6IDAwMDA3ZmZlNDhkODM4MTAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAw
MDAwMDAwMDAwMApbICAgMjQuMDAxMTQzXSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpE
IHN0YWNrOjEzOTUyIHBpZDogIDE3OSBwcGlkOiAgIDE0NiBmbGFnczoweDAwMDA0MDAwClsg
ICAyNC4wMDg0MjVdIENhbGwgVHJhY2U6ClsgICAyNC4wMTA0OTVdIF9fc2NoZWR1bGUgKGtl
cm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAgIDI0LjAxMzM3OF0gc2NoZWR1bGUgKC4vYXJj
aC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAg
MjQuMDE2MDUzXSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAg
MjQuMDE4NzYzXSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsg
ICAyNC4wMjI2NjNdID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9w
YWdlbWFwLmg6NTE1KQpbICAgMjQuMDI2NTY0XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFw
LmM6MjUzOCkKWyAgIDI0LjAyOTk1NF0gPyBmaWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRl
L2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAyNC4wMzM4NjVdIF9fZG9fZmF1bHQgKG1tL21l
bW9yeS5jOjM0MzkpClsgICAyNC4wMzY3NzNdIGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5
LmM6MzgzMykKWyAgIDI0LjA0MDA3Ml0gX19nZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5
KQpbICAgMjQuMDQzNjY3XSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQy
MCkKWyAgIDI0LjA0NzIwMF0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI0
LjA1MDU1NF0gX194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3
KQpbICAgMjQuMDU0MjczXSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24u
Yzo0NikKWyAgIDI0LjA1NzQ5Ml0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChh
cmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0LjA2MTc5NV0gUklQOiAwMDMz
OjB4N2YzZjkwMGYyYjNiClsgMjQuMDY1MDQ4XSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpk
dW1wOiAnL3RtcC90bXAuV2JNQ1JOSmNhTC5vJzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0
aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KWyAgIDI0LjA2Nzk3MV0gUlNQOiAwMDJiOjAwMDA3
ZmZkNjgyYjYzMzggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5
NwpbICAgMjQuMDc0MjMzXSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTYzMjM5
MDMyNDUwIFJDWDogMDAwMDdmM2Y5MDBmMmIzYgpbICAgMjQuMDgwMzAzXSBSRFg6IDAwMDA3
ZmZkNjgyYjQyMTIgUlNJOiAwMDAwN2YzZjkwMTc2M2MwIFJESTogMDAwMDAwMDAwMDAwMDAw
MwpbICAgMjQuMDg2MjYzXSBSQlA6IDAwMDA3ZmZkNjgyYjYzNDAgUjA4OiAwMDAwMDAwMDAw
MDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuMDkyMzY0XSBSMTA6IDAwMDA3
ZjNmOTAxNzVhYzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU2MzIzOGZmNDBh
MApbICAgMjQuMDk4MzQ1XSBSMTM6IDAwMDA3ZmZkNjgyYjY3ODAgUjE0OiAwMDAwMDAwMDAw
MDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuMTA0NTg4XSB0YXNrOnBhY2tl
dGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzNTEyIHBpZDogIDE4NSBwcGlkOiAgIDE1MyBm
bGFnczoweDAwMDA0MDAwClsgICAyNC4xMTE4NTZdIENhbGwgVHJhY2U6ClsgICAyNC4xMTQx
MzJdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAgIDI0LjExNzMy
M10gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNj
cmltaW5hdG9yIDEpKQpbICAgMjQuMTIwMDUyXSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVk
L2NvcmUuYzo2MjcxKQpbICAgMjQuMTIzMDM2XSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0v
ZmlsZW1hcC5jOjEyNDUpClsgICAyNC4xMjY2MDBdID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2Ug
KC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjQuMTMwMTQ2XSBmaWxlbWFw
X2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0LjEzMzI2NF0gPyBmaWxlbWFwX21h
cF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAyNC4xMzY4NDZd
IF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNC4xMzk2NTNdIGhhbmRsZV9t
bV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDI0LjE0MzE2NV0gX19nZXRfdXNlcl9w
YWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjQuMTQ2NDM5XSBwb3B1bGF0ZV92bWFfcGFnZV9y
YW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI0LjE1MDA1MF0gX19tbV9wb3B1bGF0ZSAobW0v
Z3VwLmM6MTQ3NikKWyAgIDI0LjE1MzMyNV0gX194NjRfc3lzX21sb2NrYWxsICguL2luY2x1
ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjQuMTU3MDg5XSBkb19zeXNjYWxsXzY0IChhcmNo
L3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAgIDI0LjE2MDE4MV0gZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0
LjE2NDY5MF0gUklQOiAwMDMzOjB4N2YxOGUwZGEzYjNiClsgMjQuMTY3ODUxXSBDb2RlOiBC
YWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuTEtsakJ6cnBUSy5vJzogTm8gc3Vj
aCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAgIDI0LjE3MDUx
Nl0gUlNQOiAwMDJiOjAwMDA3ZmZjM2EwZDY3ZjggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JB
WDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjQuMTc3MTE2XSBSQVg6IGZmZmZmZmZmZmZmZmZm
ZGEgUkJYOiAwMDAwNTYyZDdiMWIxNDUwIFJDWDogMDAwMDdmMThlMGRhM2IzYgpbICAgMjQu
MTgzNDIzXSBSRFg6IDAwMDA3ZmZjM2EwZDQ2ZDIgUlNJOiAwMDAwN2YxOGUwZTI3M2MwIFJE
STogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjQuMTg5NzA3XSBSQlA6IDAwMDA3ZmZjM2EwZDY4
MDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQu
MTk1OTc3XSBSMTA6IDAwMDA3ZjE4ZTBlMjZhYzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIx
MjogMDAwMDU2MmQ3YjE3MzBhMApbICAgMjQuMjAyMDE4XSBSMTM6IDAwMDA3ZmZjM2EwZDZj
NDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQu
MjA4MzExXSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDog
IDE4OCBwcGlkOiAgIDE1MSBmbGFnczoweDAwMDA0MDAwClsgICAyNC4yMTUzOThdIENhbGwg
VHJhY2U6ClsgICAyNC4yMTc0NzFdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6
Mzc3OCkKWyAgIDI0LjIyMDQ0Nl0gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20v
Yml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjQuMjIzMDQ0XSBpb19zY2hl
ZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjQuMjI1Nzc0XSBfX2xvY2tf
cGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNC4yMjk2MjFdID8gZmls
ZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAg
MjQuMjMzNTQyXSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0LjIz
Njg2OF0gPyB4YXNfc3RhcnQgKGxpYi94YXJyYXkuYzoxOTMpClsgICAyNC4yMzk3NjZdID8g
ZmlsZW1hcF9tYXBfcGFnZXMgKC4vaW5jbHVkZS9saW51eC94YXJyYXkuaDoxNjA2KQpbICAg
MjQuMjQzMTk0XSBfX2RvX2ZhdWx0IChtbS9tZW1vcnkuYzozNDM5KQpbICAgMjQuMjQ2MjUy
XSBoYW5kbGVfbW1fZmF1bHQgKG1tL21lbW9yeS5jOjM4MzMpClsgICAyNC4yNDk3NTldID8g
YXNtX3N5c3ZlY19hcGljX3RpbWVyX2ludGVycnVwdCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9pZHRlbnRyeS5oOjU4MSkKWyAgIDI0LjI1NDM3OF0gX19nZXRfdXNlcl9wYWdlcyAobW0v
Z3VwLmM6ODc5KQpbICAgMjQuMjU3OTYwXSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0v
Z3VwLmM6MTQyMCkKWyAgIDI0LjI2MTg2OF0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3
NikKWyAgIDI0LjI2NTExNF0gX194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgv
bW0uaDoyNTY3KQpbICAgMjQuMjY4NjgzXSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRy
eS9jb21tb24uYzo0NikKWyAgIDI0LjI3MTY1OF0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0LjI3NTc3Ml0g
UklQOiAwMDMzOjB4N2YyZDBiMDFlYjNiClsgMjQuMjc4NjkxXSBDb2RlOiBCYWQgUklQIHZh
bHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuZkU2b2lGWENqSS5vJzogTm8gc3VjaCBmaWxlCgpD
b2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAgIDI0LjI4MTQwMF0gUlNQOiAw
MDJiOjAwMDA3ZmZkN2IyZDlmYTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAw
MDAwMDAwMDA5NwpbICAgMjQuMjg3NDMwXSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAw
MDAwNTU3ODVmOGE0NDUwIFJDWDogMDAwMDdmMmQwYjAxZWIzYgpbICAgMjQuMjkzMjczXSBS
RFg6IDAwMDA3ZmZkN2IyZDdlODIgUlNJOiAwMDAwN2YyZDBiMGEyM2MwIFJESTogMDAwMDAw
MDAwMDAwMDAwMwpbICAgMjQuMzAyNzUyXSBSQlA6IDAwMDA3ZmZkN2IyZDlmYjAgUjA4OiAw
MDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuMzA5MTE1XSBS
MTA6IDAwMDA3ZjJkMGIwYTFhYzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU1
Nzg1Zjg2NjBhMApbICAgMjQuMzE1NTI5XSBSMTM6IDAwMDA3ZmZkN2IyZGEzZjAgUjE0OiAw
MDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuMzIxODkxXSB0
YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDogIDE5MCBwcGlk
OiAgIDE1NyBmbGFnczoweDAwMDA0MDAwClsgICAyNC4zMjkxOTddIENhbGwgVHJhY2U6Clsg
ICAyNC4zMzE1MzFdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAg
IDI0LjMzNDczNl0gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6
MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjQuMzM3NTQ4XSBpb19zY2hlZHVsZSAoa2Vy
bmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjQuMzQwMzYyXSBfX2xvY2tfcGFnZV9raWxs
YWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNC4zNDQwOThdID8gZmlsZV9mZGF0YXdh
aXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjQuMzQ4MDAx
XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0LjM1MTQyN10gPyBm
aWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAy
NC4zNTUyOTJdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNC4zNTgyODJd
IGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDI0LjM2MTc4OF0gX19n
ZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjQuMzY1NDI3XSBwb3B1bGF0ZV92
bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI0LjM2OTQwOF0gX19tbV9wb3B1
bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI0LjM3MjcyNl0gX194NjRfc3lzX21sb2NrYWxs
ICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjQuMzc2NDk2XSBkb19zeXNjYWxs
XzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAgIDI0LjM3OTUyMl0gZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEy
NSkKWyAgIDI0LjM4MzYyM10gUklQOiAwMDMzOjB4N2ZlNzQ5YTczYjNiClsgMjQuMzg2NTM0
XSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuNDBnejRmalFHVy5v
JzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3Ry
dWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAg
IDI0LjM4OTI0MF0gUlNQOiAwMDJiOjAwMDA3ZmZmNmQ0YWQyNjggRUZMQUdTOiAwMDAwMDI0
NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjQuMzk1NDMzXSBSQVg6IGZmZmZm
ZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTU2NDczMDQ5NDUwIFJDWDogMDAwMDdmZTc0OWE3M2Iz
YgpbICAgMjQuNDAxMzA3XSBSRFg6IDAwMDA3ZmZmNmQ0YWIxNDIgUlNJOiAwMDAwN2ZlNzQ5
YWY3M2MwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjQuNDA3NDI2XSBSQlA6IDAwMDA3
ZmZmNmQ0YWQyNzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAw
MApbICAgMjQuNDEzNjk2XSBSMTA6IDAwMDA3ZmU3NDlhZjZhYzAgUjExOiAwMDAwMDAwMDAw
MDAwMjQ2IFIxMjogMDAwMDU1NjQ3MzAwYjBhMApbICAgMjQuNDE5OTE5XSBSMTM6IDAwMDA3
ZmZmNmQ0YWQ2YjAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAw
MApbICAgMjQuNDI1OTQwXSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEz
OTUyIHBpZDogIDE5MyBwcGlkOiAgIDE2MCBmbGFnczoweDAwMDA0MDAwClsgICAyNC40MzMy
NjldIENhbGwgVHJhY2U6ClsgICAyNC40MzU1NjhdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hl
ZC9jb3JlLmM6Mzc3OCkKWyAgIDI0LjQzODM5N10gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5j
bHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjQuNDQxMDMw
XSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjQuNDQzNzYw
XSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNC40NDcy
NzVdID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6
NTE1KQpbICAgMjQuNDUwOTE5XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkK
WyAgIDI0LjQ1Mzk3Nl0gPyBmaWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hh
cnJheS5oOjE2MDYpClsgICAyNC40NTc1MDFdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0
MzkpClsgICAyNC40NjAyNzNdIGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykK
WyAgIDI0LjQ2MzM5N10gX19nZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjQu
NDY2NzQzXSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI0
LjQ3MDcyOF0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI0LjQ3NDA4NF0g
X194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjQu
NDc3NzgwXSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAg
IDI0LjQ4MDkyNF0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9l
bnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0LjQ4NTMwMl0gUklQOiAwMDMzOjB4N2ZhZjA4
YWQ5YjNiClsgMjQuNDg4NDA0XSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3Rt
cC90bXAudGZwaVVFdWdXci5vJzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGgg
dGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KWyAgIDI0LjQ5MTM0OF0gUlNQOiAwMDJiOjAwMDA3ZmZlYzY4YzYx
ZDggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjQu
NDk3NTQ5XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTU1NmRmMmRmNDUwIFJD
WDogMDAwMDdmYWYwOGFkOWIzYgpbICAgMjQuNTAzNjg2XSBSRFg6IDAwMDA3ZmZlYzY4YzQw
YjIgUlNJOiAwMDAwN2ZhZjA4YjVkM2MwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjQu
NTA5NjkzXSBSQlA6IDAwMDA3ZmZlYzY4YzYxZTAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIw
OTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuNTE1OTE5XSBSMTA6IDAwMDA3ZmFmMDhiNWNh
YzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU1NTZkZjJhMTBhMApbICAgMjQu
NTIxOTE5XSBSMTM6IDAwMDA3ZmZlYzY4YzY2MjAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIx
NTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuNTI4MTczXSB0YXNrOnBhY2tldGRyaWxsICAg
ICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDogIDE5OSBwcGlkOiAgIDE2MyBmbGFnczoweDAw
MDA0MDAwClsgICAyNC41MzUyOTBdIENhbGwgVHJhY2U6ClsgICAyNC41MzczNDhdIF9fc2No
ZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAgIDI0LjU0MDMyNF0gc2NoZWR1
bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9y
IDEpKQpbICAgMjQuNTQyODM0XSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2
MjcxKQpbICAgMjQuNTQ1NTk0XSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5j
OjEyNDUpClsgICAyNC41NDk0ODVdID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVk
ZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjQuNTUzMjY2XSBmaWxlbWFwX2ZhdWx0ICht
bS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0LjU1NjUwMV0gPyBmaWxlbWFwX21hcF9wYWdlcyAo
Li9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAyNC41NjAwNzNdIF9fZG9fZmF1
bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNC41NjI3ODZdIGhhbmRsZV9tbV9mYXVsdCAo
bW0vbWVtb3J5LmM6MzgzMykKWyAgIDI0LjU2NjMwNF0gX19nZXRfdXNlcl9wYWdlcyAobW0v
Z3VwLmM6ODc5KQpbICAgMjQuNTY5ODc0XSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0v
Z3VwLmM6MTQyMCkKWyAgIDI0LjU3Mzg0NF0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3
NikKWyAgIDI0LjU3NzA1NF0gX194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgv
bW0uaDoyNTY3KQpbICAgMjQuNTgwNjI0XSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRy
eS9jb21tb24uYzo0NikKWyAgIDI0LjU4MzYyOV0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0LjU4Nzg2Nl0g
UklQOiAwMDMzOjB4N2VmZGNhNTRiYjNiClsgMjQuNTkwNzY2XSBDb2RlOiBCYWQgUklQIHZh
bHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuRlFmSVRTWFRNOC5vJzogTm8gc3VjaCBmaWxlCgpD
b2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAgIDI0LjU5MzcxM10gUlNQOiAw
MDJiOjAwMDA3ZmZlMTYwYzhiZTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAw
MDAwMDAwMDA5NwpbICAgMjQuNjAwMjg4XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAw
MDAwNTU2NjhkYzE5NDUwIFJDWDogMDAwMDdlZmRjYTU0YmIzYgpbICAgMjQuNjA2MzMwXSBS
RFg6IDAwMDA3ZmZlMTYwYzZhYzIgUlNJOiAwMDAwN2VmZGNhNWNmM2MwIFJESTogMDAwMDAw
MDAwMDAwMDAwMwpbICAgMjQuNjEyNjUwXSBSQlA6IDAwMDA3ZmZlMTYwYzhiZjAgUjA4OiAw
MDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuNjE4NzE1XSBS
MTA6IDAwMDA3ZWZkY2E1Y2VhYzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU1
NjY4ZGJkYjBhMApbICAgMjQuNjI1MDU1XSBSMTM6IDAwMDA3ZmZlMTYwYzkwMzAgUjE0OiAw
MDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuNjMxMzM2XSB0
YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDogIDIwMCBwcGlk
OiAgIDE2NyBmbGFnczoweDAwMDA0MDAwClsgICAyNC42MzgyMTJdIENhbGwgVHJhY2U6Clsg
ICAyNC42NDA1MDRdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAg
IDI0LjY0MzczMF0gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6
MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjQuNjQ2NjE2XSBpb19zY2hlZHVsZSAoa2Vy
bmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjQuNjQ5NjQ2XSBfX2xvY2tfcGFnZV9raWxs
YWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNC42NTM0MjBdID8gZmlsZV9mZGF0YXdh
aXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjQuNjU3MzUx
XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0LjY2MDU5Nl0gPyBm
aWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAy
NC42NjQxMzRdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNC42NjY5MzZd
IGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDI0LjY3MDUwMl0gX19n
ZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjQuNjc0MTExXSBwb3B1bGF0ZV92
bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI0LjY3ODEwNl0gX19tbV9wb3B1
bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI0LjY4MTQzNF0gX194NjRfc3lzX21sb2NrYWxs
ICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjQuNjg1MTkxXSBkb19zeXNjYWxs
XzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAgIDI0LjY4ODI4OV0gZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEy
NSkKWyAgIDI0LjY5Mjc1NF0gUklQOiAwMDMzOjB4N2Y0YWMzZjQ1YjNiClsgMjQuNjk2MDE3
XSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuU2o3N0pjWENxbC5v
JzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3Ry
dWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAg
IDI0LjY5ODk2M10gUlNQOiAwMDJiOjAwMDA3ZmZkMTU5NzcxZTggRUZMQUdTOiAwMDAwMDI0
NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjQuNzA1NjIwXSBSQVg6IGZmZmZm
ZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTYyMGViNDUwNDUwIFJDWDogMDAwMDdmNGFjM2Y0NWIz
YgpbICAgMjQuNzExOTAxXSBSRFg6IDAwMDA3ZmZkMTU5NzUwYzIgUlNJOiAwMDAwN2Y0YWMz
ZmM5M2MwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjQuNzE4MTk1XSBSQlA6IDAwMDA3
ZmZkMTU5NzcxZjAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAw
MApbICAgMjQuNzI0NDY4XSBSMTA6IDAwMDA3ZjRhYzNmYzhhYzAgUjExOiAwMDAwMDAwMDAw
MDAwMjQ2IFIxMjogMDAwMDU2MjBlYjQxMjBhMApbICAgMjQuNzMwNjg5XSBSMTM6IDAwMDA3
ZmZkMTU5Nzc2MzAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAw
MApbICAgMjQuNzM2OTY1XSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEz
OTUyIHBpZDogIDIwMiBwcGlkOiAgIDE3NCBmbGFnczoweDAwMDA0MDAwClsgICAyNC43NDQx
MjhdIENhbGwgVHJhY2U6ClsgICAyNC43NDYxODhdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hl
ZC9jb3JlLmM6Mzc3OCkKWyAgIDI0Ljc0OTEyOV0gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5j
bHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjQuNzUxNzE1
XSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjQuNzU0NDMw
XSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNC43NTgz
MTddID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6
NTE1KQpbICAgMjQuNzYyMTYwXSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkK
WyAgIDI0Ljc2NTU4Ml0gPyBmaWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hh
cnJheS5oOjE2MDYpClsgICAyNC43Njk0MThdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0
MzkpClsgICAyNC43NzI0MzJdIGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykK
WyAgIDI0Ljc3NTcwMF0gX19nZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjQu
Nzc5MDUxXSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI0
Ljc4MzAwOV0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI0Ljc4NjMwOV0g
X194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjQu
NzkwMDUyXSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAg
IDI0Ljc5MzI4NV0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9l
bnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0Ljc5NzgyMV0gUklQOiAwMDMzOjB4N2YxNzc2
MjdkYjNiClsgMjQuODAxMDEzXSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3Rt
cC90bXAucHNMbUNpS1pNdC5vJzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGgg
dGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KWyAgIDI0LjgwMzc1Ml0gUlNQOiAwMDJiOjAwMDA3ZmZjZDljNzg0
ZDggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjQu
ODEwMTQ5XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTU2YmJlMTkzNDUwIFJD
WDogMDAwMDdmMTc3NjI3ZGIzYgpbICAgMjQuODE2MzkzXSBSRFg6IDAwMDA3ZmZjZDljNzYz
YjIgUlNJOiAwMDAwN2YxNzc2MzAxM2MwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjQu
ODIyNDA3XSBSQlA6IDAwMDA3ZmZjZDljNzg0ZTAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIw
OTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuODI4Njg2XSBSMTA6IDAwMDA3ZjE3NzYzMDBh
YzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU1NmJiZTE1NTBhMApbICAgMjQu
ODM0OTI0XSBSMTM6IDAwMDA3ZmZjZDljNzg5MjAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIx
NTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuODQwNzE0XSB0YXNrOnBhY2tldGRyaWxsICAg
ICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDogIDIwNCBwcGlkOiAgIDE4MiBmbGFnczoweDAw
MDA0MDAwClsgICAyNC44NDc4NDJdIENhbGwgVHJhY2U6ClsgICAyNC44NTAxMTJdIF9fc2No
ZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAgIDI0Ljg1MzMxNl0gc2NoZWR1
bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9y
IDEpKQpbICAgMjQuODU2MTg1XSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2
MjcxKQpbICAgMjQuODU5MTgxXSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5j
OjEyNDUpClsgICAyNC44NjI2NzVdID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVk
ZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjQuODY2MjEyXSBmaWxlbWFwX2ZhdWx0ICht
bS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0Ljg2OTUyNV0gPyBmaWxlbWFwX21hcF9wYWdlcyAo
Li9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAyNC44NzMyNDBdIF9fZG9fZmF1
bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNC44NzYyNTBdIGhhbmRsZV9tbV9mYXVsdCAo
bW0vbWVtb3J5LmM6MzgzMykKWyAgIDI0Ljg3OTQ3MF0gX19nZXRfdXNlcl9wYWdlcyAobW0v
Z3VwLmM6ODc5KQpbICAgMjQuODgyNjgwXSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0v
Z3VwLmM6MTQyMCkKWyAgIDI0Ljg5NDQ5OF0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3
NikKWyAgIDI0Ljg5Nzc2M10gX194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgv
bW0uaDoyNTY3KQpbICAgMjQuOTAxMzYzXSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRy
eS9jb21tb24uYzo0NikKWyAgIDI0LjkwNDQzN10gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI0LjkwODk1OF0g
UklQOiAwMDMzOjB4N2ZmMWZlNGUyYjNiClsgMjQuOTExOTUxXSBDb2RlOiBCYWQgUklQIHZh
bHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuMDZmTzBnVlBPZS5vJzogTm8gc3VjaCBmaWxlCgpD
b2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAgIDI0LjkxNDg2NV0gUlNQOiAw
MDJiOjAwMDA3ZmZjMjgxNzc1OTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAw
MDAwMDAwMDA5NwpbICAgMjQuOTIxMzEwXSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAw
MDAwNTU4ZDliYmUzNDUwIFJDWDogMDAwMDdmZjFmZTRlMmIzYgpbICAgMjQuOTI3NDI3XSBS
RFg6IDAwMDA3ZmZjMjgxNzU0NzIgUlNJOiAwMDAwN2ZmMWZlNTY2M2MwIFJESTogMDAwMDAw
MDAwMDAwMDAwMwpbICAgMjQuOTMzNDY4XSBSQlA6IDAwMDA3ZmZjMjgxNzc1YTAgUjA4OiAw
MDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuOTM5NzIyXSBS
MTA6IDAwMDA3ZmYxZmU1NjVhYzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU1
OGQ5YmJhNTBhMApbICAgMjQuOTQ1NzE5XSBSMTM6IDAwMDA3ZmZjMjgxNzc5ZTAgUjE0OiAw
MDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjQuOTUxOTA4XSB0
YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDogIDIwNSBwcGlk
OiAgIDE4NyBmbGFnczoweDAwMDA0MDAwClsgICAyNC45NTg5NDhdIENhbGwgVHJhY2U6Clsg
ICAyNC45NjEyMjldIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkKWyAg
IDI0Ljk2NDIxMl0gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmg6
MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjQuOTY3MDg2XSBpb19zY2hlZHVsZSAoa2Vy
bmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjQuOTcwMTA0XSBfX2xvY2tfcGFnZV9raWxs
YWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNC45NzQwMDFdID8gZmlsZV9mZGF0YXdh
aXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjQuOTc3OTEy
XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDI0Ljk4MTIyOF0gPyBm
aWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsgICAy
NC45ODQ5MjRdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNC45ODc5MzRd
IGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDI0Ljk5MTQ1Ml0gX19n
ZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjQuOTk1MDIyXSBwb3B1bGF0ZV92
bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI0Ljk5ODk5MF0gX19tbV9wb3B1
bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI1LjAwMjEwOV0gX194NjRfc3lzX21sb2NrYWxs
ICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjUuMDA1ODczXSBkb19zeXNjYWxs
XzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAgIDI1LjAwOTA4NF0gZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEy
NSkKWyAgIDI1LjAxMzU1MF0gUklQOiAwMDMzOjB4N2ZjNmE2ODgwYjNiClsgMjUuMDE2NTQ4
XSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3RtcC90bXAuN1hjM1ZyUjVRaC5v
JzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3Ry
dWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAg
IDI1LjAxOTMxOF0gUlNQOiAwMDJiOjAwMDA3ZmZjNjk0MzdkYjggRUZMQUdTOiAwMDAwMDI0
NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjUuMDI1NTE2XSBSQVg6IGZmZmZm
ZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTU3MmEzM2RkNDUwIFJDWDogMDAwMDdmYzZhNjg4MGIz
YgpbICAgMjUuMDMxNjc4XSBSRFg6IDAwMDA3ZmZjNjk0MzVjOTIgUlNJOiAwMDAwN2ZjNmE2
OTA0M2MwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjUuMDM3OTQwXSBSQlA6IDAwMDA3
ZmZjNjk0MzdkYzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAw
MApbICAgMjUuMDQ0MTAwXSBSMTA6IDAwMDA3ZmM2YTY5MDNhYzAgUjExOiAwMDAwMDAwMDAw
MDAwMjQ2IFIxMjogMDAwMDU1NzJhMzM5ZjBhMApbICAgMjUuMDQ5OTUwXSBSMTM6IDAwMDA3
ZmZjNjk0MzgyMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAw
MAo=
--------------83E65E0D9302FD4BD655044E--
