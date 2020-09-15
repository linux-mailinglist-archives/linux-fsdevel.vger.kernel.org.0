Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2736426A90D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgIOPp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgIOPnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4717C06121C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 08:34:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c8so3497063edv.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=Ao9p83o0ua5WUYSt4RNH8bBO+xKzGzoJbkpKYdHCM5I=;
        b=Ylp6y/O4OeuRnkwdo8Ep4dXRL02bewbDuxRhqY73iAlSRHnXVBq0CDxQZ5u8PgaQsl
         Qmkm9nEXtAPk8U3SJt04lgRs9mqP4uM4BbjRe9H+Ubr8UhTqEzVj/5Ovzl4wnxSI4XyP
         F0ylBnnfDkKexd1oZwepU5V53wUJ3ZzsAwYPDKFu2U8hmhO62x3/SCvjX8+mKE4z8Lyr
         ISC27xli0KQ/fGEU5lYr1Reez+Sm0/XrNUs/uB8iRC8ES6CctoG/CI2VGcI+DWcyFGaZ
         ee6TgK7A1NxQie4Yy4lxawbTes7si9na4hbEKb6MU++mJCD+jxes0J0S7Wu8kHHTHfji
         Wang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Ao9p83o0ua5WUYSt4RNH8bBO+xKzGzoJbkpKYdHCM5I=;
        b=eawbbjEgluwyGZU19ws4ldNl3sYvQstP1k6QUoLUnmVACCc7xwPk0s8ZyzVB0rq5ur
         aRH2lGA0JemdmHkgQmL0/vBm1U8KUaJXMfvH0pAyfMspZIRnjEkBxfuupHEOQb8tAVa9
         +7/z5nD6HBZsl4znYa7YNZWYAZRuY44KQqYpPMPuVraaFc6AgDM7X3H1ULEI/03gX3/x
         Pt0WbGRFHhgAwhorNn/jF9R9UF2JtAUASPutLMl9o1soEJE0Pv67nGT2/NIAKzdljqde
         vMdmmwVE/pfFMFVLjjW+dbpqvoF2+XSLGR4QB5MT0Kb8nkfUC+VNWsowpGAjqoKN/5Iq
         qSFw==
X-Gm-Message-State: AOAM531dSkF/6m8Fu6vY87Jb2vaHOZm3LTLxrC9FA8UrKs5V89xkMoK2
        8la1vnksxzLMaixKFnlB4m8wbbJVOXeO3sjw
X-Google-Smtp-Source: ABdhPJxrnIYV6leClXz7DYfr1jcQqePwZtH5Z76/ieXtE9XWk/pCF4DNCCuuTZtH+5UM3RncwehGQw==
X-Received: by 2002:a05:6402:14d4:: with SMTP id f20mr12292526edx.291.1600184092767;
        Tue, 15 Sep 2020 08:34:52 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ec32:668e:7a20:c1cd])
        by smtp.gmail.com with ESMTPSA id j5sm10506301ejt.52.2020.09.15.08.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 08:34:52 -0700 (PDT)
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
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
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
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
Date:   Tue, 15 Sep 2020 17:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------FA417B90012EF9AEF780888D"
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FA417B90012EF9AEF780888D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Thank you very much for your reply, with very clear explanations and 
instructions!

On 14/09/2020 22:53, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 1:21 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Recently, some of these packetdrill tests have been failing after 2
>> minutes (timeout) instead of being executed in a few seconds (~6
>> seconds). No packets are even exchanged during these two minutes.
> 
> Hmm.
> 
> That sounds like a deadlock to me, and sounds like it's a latent bug
> waiting to happen.

Yesterday evening, I wanted to get confirmation about that using 
PROVE_LOCKING but just like today, each time I enable this kconfig, I 
cannot reproduce the issue.

Anyway I am sure you are right and this bug has been there for sometime 
but is too hard to reproduce.
>> I would be glad to help by validating new modifications or providing new
>> info. My setup is also easy to put in place: a Docker image is built
>> with all required tools to start the same VM just like the one I have.
> 
> I'm not familiar enough with packetdrill or any of that infrastructure
> - does it do its own kernel modules etc for the packet latency
> testing?

No, Packetdrill doesn't load any kernel module.

Here is a short description of the execution model of Packetdrill from a 
paper the authors wrote:

     packetdrill parses an entire test script, and then executes each
     timestamped line in real time -- at the pace described by the
     timestamps -- to replay and verify the scenario.
     - For each system call line, packetdrill executes the system call
       and verifies that it returns the expected result.
     - For each command line, packetdrill executes the shell command.
     - For each incoming packet (denoted by a leading < on the line),
       packetdrill constructs a packet and injects it into the kernel.
     - For each outgoing packet (denoted by a leading > on the line),
       packetdrill sniffs the next outgoing packet and verifies that the
       packet's timing and contents match the script.

Source: https://research.google/pubs/pub41316/

> But it sounds like it's 100% repeatable with the fair page lock, which
> is actually a good thing. It means that if you do a "sysrq-w" while
> it's blocking, you should see exactly what is waiting for what.
> 
> (Except since it times out nicely eventually, probably at least part
> of the waiting is interruptible, and then you need to do "sysrq-t"
> instead and it's going to be _very_ verbose and much harder to
> pinpoint things, and you'll probably need to have a very big printk
> buffer).

Thank you for this idea! I was focused on using lockdep and I forgot 
about this simple method. It is not (yet) a reflex for me to use it!

I think I got an interesting trace I took 20 seconds after having 
started packetdrill:


------------------- 8< -------------------
[   25.507563] sysrq: Show Blocked State
[   25.510695] task:packetdrill     state:D stack:13848 pid:  188 ppid: 
   155 flags:0x00004000
[   25.517841] Call Trace:
[   25.520103]  __schedule+0x3eb/0x680
[   25.523197]  schedule+0x45/0xb0
[   25.526013]  io_schedule+0xd/0x30
[   25.528964]  __lock_page_killable+0x13e/0x280
[   25.532794]  ? file_fdatawait_range+0x20/0x20
[   25.536605]  filemap_fault+0x6b4/0x970
[   25.539911]  ? filemap_map_pages+0x195/0x330
[   25.543682]  __do_fault+0x32/0x90
[   25.546620]  handle_mm_fault+0x8c1/0xe50
[   25.550050]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   25.554637]  __get_user_pages+0x25c/0x750
[   25.558101]  populate_vma_page_range+0x57/0x60
[   25.561968]  __mm_populate+0xa9/0x150
[   25.565125]  __x64_sys_mlockall+0x151/0x180
[   25.568787]  do_syscall_64+0x33/0x40
[   25.571915]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   25.576230] RIP: 0033:0x7f21bee46b3b
[   25.579357] Code: Bad RIP value.
[   25.582199] RSP: 002b:00007ffcb5f8ad38 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   25.588588] RAX: ffffffffffffffda RBX: 000055c9762f1450 RCX: 
00007f21bee46b3b
[   25.594627] RDX: 00007ffcb5f8ad28 RSI: 0000000000000002 RDI: 
0000000000000003
[   25.600637] RBP: 00007ffcb5f8ad40 R08: 0000000000000001 R09: 
0000000000000000
[   25.606701] R10: 00007f21beec9ac0 R11: 0000000000000246 R12: 
000055c9762b30a0
[   25.612738] R13: 00007ffcb5f8b180 R14: 0000000000000000 R15: 
0000000000000000
[   25.618762] task:packetdrill     state:D stack:13952 pid:  190 ppid: 
   153 flags:0x00004000
[   25.625781] Call Trace:
[   25.627987]  __schedule+0x3eb/0x680
[   25.631046]  schedule+0x45/0xb0
[   25.633796]  io_schedule+0xd/0x30
[   25.636726]  ? wake_up_page_bit+0xd1/0x100
[   25.640271]  ? file_fdatawait_range+0x20/0x20
[   25.644022]  ? filemap_fault+0x6b4/0x970
[   25.647427]  ? filemap_map_pages+0x195/0x330
[   25.651146]  ? __do_fault+0x32/0x90
[   25.654227]  ? handle_mm_fault+0x8c1/0xe50
[   25.657752]  ? __get_user_pages+0x25c/0x750
[   25.661368]  ? populate_vma_page_range+0x57/0x60
[   25.665338]  ? __mm_populate+0xa9/0x150
[   25.668707]  ? __x64_sys_mlockall+0x151/0x180
[   25.672467]  ? do_syscall_64+0x33/0x40
[   25.675751]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   25.680213] task:packetdrill     state:D stack:13952 pid:  193 ppid: 
   160 flags:0x00004000
[   25.687285] Call Trace:
[   25.689472]  __schedule+0x3eb/0x680
[   25.692547]  schedule+0x45/0xb0
[   25.695314]  io_schedule+0xd/0x30
[   25.698216]  __lock_page_killable+0x13e/0x280
[   25.702013]  ? file_fdatawait_range+0x20/0x20
[   25.705752]  filemap_fault+0x6b4/0x970
[   25.709010]  ? filemap_map_pages+0x195/0x330
[   25.712691]  __do_fault+0x32/0x90
[   25.715620]  handle_mm_fault+0x8c1/0xe50
[   25.719013]  __get_user_pages+0x25c/0x750
[   25.722485]  populate_vma_page_range+0x57/0x60
[   25.726326]  __mm_populate+0xa9/0x150
[   25.729528]  __x64_sys_mlockall+0x151/0x180
[   25.733138]  do_syscall_64+0x33/0x40
[   25.736263]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   25.740587] RIP: 0033:0x7feb59c16b3b
[   25.743716] Code: Bad RIP value.
[   25.746653] RSP: 002b:00007ffd75ef7f38 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   25.753019] RAX: ffffffffffffffda RBX: 0000562a49acc450 RCX: 
00007feb59c16b3b
[   25.759077] RDX: 00007ffd75ef7f28 RSI: 0000000000000002 RDI: 
0000000000000003
[   25.765127] RBP: 00007ffd75ef7f40 R08: 0000000000000001 R09: 
0000000000000000
[   25.771231] R10: 00007feb59c99ac0 R11: 0000000000000246 R12: 
0000562a49a8e0a0
[   25.777442] R13: 00007ffd75ef8380 R14: 0000000000000000 R15: 
0000000000000000
[   25.783496] task:packetdrill     state:D stack:13952 pid:  194 ppid: 
   157 flags:0x00004000
[   25.790536] Call Trace:
[   25.792726]  __schedule+0x3eb/0x680
[   25.795777]  schedule+0x45/0xb0
[   25.798582]  io_schedule+0xd/0x30
[   25.801473]  __lock_page_killable+0x13e/0x280
[   25.805246]  ? file_fdatawait_range+0x20/0x20
[   25.809015]  filemap_fault+0x6b4/0x970
[   25.812279]  ? filemap_map_pages+0x195/0x330
[   25.815981]  __do_fault+0x32/0x90
[   25.818909]  handle_mm_fault+0x8c1/0xe50
[   25.822458]  __get_user_pages+0x25c/0x750
[   25.825947]  populate_vma_page_range+0x57/0x60
[   25.829775]  __mm_populate+0xa9/0x150
[   25.832973]  __x64_sys_mlockall+0x151/0x180
[   25.836591]  do_syscall_64+0x33/0x40
[   25.839715]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   25.844089] RIP: 0033:0x7f1bdd340b3b
[   25.847219] Code: Bad RIP value.
[   25.850079] RSP: 002b:00007fff992f49e8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   25.856446] RAX: ffffffffffffffda RBX: 0000557ddd3b8450 RCX: 
00007f1bdd340b3b
[   25.862481] RDX: 00007fff992f49d8 RSI: 0000000000000002 RDI: 
0000000000000003
[   25.868455] RBP: 00007fff992f49f0 R08: 0000000000000001 R09: 
0000000000000000
[   25.874528] R10: 00007f1bdd3c3ac0 R11: 0000000000000246 R12: 
0000557ddd37a0a0
[   25.880541] R13: 00007fff992f4e30 R14: 0000000000000000 R15: 
0000000000000000
[   25.886556] task:packetdrill     state:D stack:13952 pid:  200 ppid: 
   162 flags:0x00004000
[   25.893568] Call Trace:
[   25.895776]  __schedule+0x3eb/0x680
[   25.898833]  schedule+0x45/0xb0
[   25.901578]  io_schedule+0xd/0x30
[   25.904495]  __lock_page_killable+0x13e/0x280
[   25.908246]  ? file_fdatawait_range+0x20/0x20
[   25.912012]  filemap_fault+0x6b4/0x970
[   25.915270]  ? filemap_map_pages+0x195/0x330
[   25.918964]  __do_fault+0x32/0x90
[   25.921853]  handle_mm_fault+0x8c1/0xe50
[   25.925245]  __get_user_pages+0x25c/0x750
[   25.928720]  populate_vma_page_range+0x57/0x60
[   25.932543]  __mm_populate+0xa9/0x150
[   25.935727]  __x64_sys_mlockall+0x151/0x180
[   25.939348]  do_syscall_64+0x33/0x40
[   25.942466]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   25.946906] RIP: 0033:0x7fb34860bb3b
[   25.950026] Code: Bad RIP value.
[   25.952846] RSP: 002b:00007ffea61b7668 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   25.959289] RAX: ffffffffffffffda RBX: 000055c6f01c2450 RCX: 
00007fb34860bb3b
[   25.965453] RDX: 00007ffea61b7658 RSI: 0000000000000002 RDI: 
0000000000000003
[   25.971504] RBP: 00007ffea61b7670 R08: 0000000000000001 R09: 
0000000000000000
[   25.977505] R10: 00007fb34868eac0 R11: 0000000000000246 R12: 
000055c6f01840a0
[   25.983596] R13: 00007ffea61b7ab0 R14: 0000000000000000 R15: 
0000000000000000
[   25.989598] task:packetdrill     state:D stack:13952 pid:  203 ppid: 
   169 flags:0x00004000
[   25.996611] Call Trace:
[   25.998823]  __schedule+0x3eb/0x680
[   26.001863]  schedule+0x45/0xb0
[   26.004645]  io_schedule+0xd/0x30
[   26.007576]  ? wake_up_page_bit+0xd1/0x100
[   26.011133]  ? file_fdatawait_range+0x20/0x20
[   26.014900]  ? filemap_fault+0x6b4/0x970
[   26.018282]  ? filemap_map_pages+0x195/0x330
[   26.021973]  ? __do_fault+0x32/0x90
[   26.025017]  ? handle_mm_fault+0x8c1/0xe50
[   26.028551]  ? __get_user_pages+0x25c/0x750
[   26.032163]  ? populate_vma_page_range+0x57/0x60
[   26.036134]  ? __mm_populate+0xa9/0x150
[   26.039487]  ? __x64_sys_mlockall+0x151/0x180
[   26.043260]  ? do_syscall_64+0x33/0x40
[   26.046528]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.050968] task:packetdrill     state:D stack:13904 pid:  207 ppid: 
   173 flags:0x00004000
[   26.058008] Call Trace:
[   26.060192]  __schedule+0x3eb/0x680
[   26.063248]  schedule+0x45/0xb0
[   26.066032]  io_schedule+0xd/0x30
[   26.068924]  __lock_page_killable+0x13e/0x280
[   26.072677]  ? file_fdatawait_range+0x20/0x20
[   26.076429]  filemap_fault+0x6b4/0x970
[   26.079704]  ? filemap_map_pages+0x195/0x330
[   26.083424]  __do_fault+0x32/0x90
[   26.086342]  handle_mm_fault+0x8c1/0xe50
[   26.089722]  __get_user_pages+0x25c/0x750
[   26.093209]  populate_vma_page_range+0x57/0x60
[   26.097040]  __mm_populate+0xa9/0x150
[   26.100218]  __x64_sys_mlockall+0x151/0x180
[   26.103837]  do_syscall_64+0x33/0x40
[   26.106948]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.111256] RIP: 0033:0x7f90fb829b3b
[   26.114383] Code: Bad RIP value.
[   26.117183] RSP: 002b:00007ffc3ae07ea8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   26.123589] RAX: ffffffffffffffda RBX: 0000560bf837d450 RCX: 
00007f90fb829b3b
[   26.129614] RDX: 00007ffc3ae07e98 RSI: 0000000000000002 RDI: 
0000000000000003
[   26.135641] RBP: 00007ffc3ae07eb0 R08: 0000000000000001 R09: 
0000000000000000
[   26.141660] R10: 00007f90fb8acac0 R11: 0000000000000246 R12: 
0000560bf833f0a0
[   26.147675] R13: 00007ffc3ae082f0 R14: 0000000000000000 R15: 
0000000000000000
[   26.153693] task:packetdrill     state:D stack:13952 pid:  210 ppid: 
   179 flags:0x00004000
[   26.160728] Call Trace:
[   26.162923]  ? sched_clock_cpu+0x95/0xa0
[   26.166326]  ? ttwu_do_wakeup.isra.0+0x34/0xe0
[   26.170172]  ? __schedule+0x3eb/0x680
[   26.173349]  ? schedule+0x45/0xb0
[   26.176271]  ? io_schedule+0xd/0x30
[   26.179320]  ? __lock_page_killable+0x13e/0x280
[   26.183216]  ? file_fdatawait_range+0x20/0x20
[   26.187031]  ? filemap_fault+0x6b4/0x970
[   26.190451]  ? filemap_map_pages+0x195/0x330
[   26.194128]  ? __do_fault+0x32/0x90
[   26.197161]  ? handle_mm_fault+0x8c1/0xe50
[   26.200692]  ? push_rt_tasks+0xc/0x20
[   26.203866]  ? __get_user_pages+0x25c/0x750
[   26.207474]  ? populate_vma_page_range+0x57/0x60
[   26.211423]  ? __mm_populate+0xa9/0x150
[   26.214763]  ? __x64_sys_mlockall+0x151/0x180
[   26.218506]  ? do_syscall_64+0x33/0x40
[   26.221757]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.226216] task:packetdrill     state:D stack:13952 pid:  212 ppid: 
   185 flags:0x00004000
[   26.233223] Call Trace:
[   26.235435]  __schedule+0x3eb/0x680
[   26.238487]  schedule+0x45/0xb0
[   26.241234]  io_schedule+0xd/0x30
[   26.244133]  __lock_page_killable+0x13e/0x280
[   26.247890]  ? file_fdatawait_range+0x20/0x20
[   26.251647]  filemap_fault+0x6b4/0x970
[   26.254906]  ? filemap_map_pages+0x195/0x330
[   26.258590]  __do_fault+0x32/0x90
[   26.261462]  handle_mm_fault+0x8c1/0xe50
[   26.264869]  __get_user_pages+0x25c/0x750
[   26.268327]  populate_vma_page_range+0x57/0x60
[   26.272162]  __mm_populate+0xa9/0x150
[   26.275347]  __x64_sys_mlockall+0x151/0x180
[   26.278970]  do_syscall_64+0x33/0x40
[   26.282082]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.286466] RIP: 0033:0x7f00e8863b3b
[   26.289574] Code: Bad RIP value.
[   26.292420] RSP: 002b:00007fff5b28f378 EFLAGS: 00000246 ORIG_RAX: 
0000000000000097
[   26.298797] RAX: ffffffffffffffda RBX: 000055ea3bc97450 RCX: 
00007f00e8863b3b
[   26.304787] RDX: 00007fff5b28f368 RSI: 0000000000000002 RDI: 
0000000000000003
[   26.310867] RBP: 00007fff5b28f380 R08: 0000000000000001 R09: 
0000000000000000
[   26.316697] R10: 00007f00e88e6ac0 R11: 0000000000000246 R12: 
000055ea3bc590a0
[   26.322525] R13: 00007fff5b28f7c0 R14: 0000000000000000 R15: 
0000000000000000
------------------- 8< -------------------


A version from "decode_stacktrace.sh" is also attached to this email, I 
was not sure it would be readable here.
Please tell me if anything else is needed.

One more thing, only when I have the issue, I can also see this kernel 
message that seems clearly linked:

   [    7.198259] sched: RT throttling activated

> There are obviously other ways to do it too - kgdb or whatever - which
> you may or may not be more used to.

I never tried to use kgdb with this setup but it is clearly a good 
occasion to start! I guess I will be able to easily reproduce the issue 
and then generate the crash dump.

> But sysrq is very traditional and often particularly easy if it's a
> very repeatable "things are hung". Not nearly as good as lockdep, of
> course. But if the machine is otherwise working, you can just do
> 
>      echo 'w' > /proc/sysrq-trigger
> 
> in another terminal (and again, maybe you need 't', but then you
> really want to do it *without* having a full GUI setup or anythign
> like that, to at least make it somewhat less verbose).

Please tell me if the trace I shared above is helpful. If not I can 
easily share the long output from sysrq-t -- no GUI nor any other 
services are running in the background -- and if needed I can prioritise 
the generation of a crash dump + analysis.

> Aside: a quick google shows that Nick Piggin did try to extend lockdep
> to the page lock many many years ago. I don't think it ever went
> anywhere. To quote Avril Lavigne: "It's complicated".

:-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

--------------FA417B90012EF9AEF780888D
Content-Type: text/plain; charset=UTF-8;
 name="sysrq_w_1_analysed.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sysrq_w_1_analysed.txt"

WyAgIDI1LjUwNzU2M10gc3lzcnE6IFNob3cgQmxvY2tlZCBTdGF0ZQpbICAgMjUuNTEwNjk1
XSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEzODQ4IHBpZDogIDE4OCBw
cGlkOiAgIDE1NSBmbGFnczoweDAwMDA0MDAwClsgICAyNS41MTc4NDFdIENhbGwgVHJhY2U6
ClsgICAyNS41MjAxMDNdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6Mzc3OCkK
WyAgIDI1LjUyMzE5N10gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3Bz
Lmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjUuNTI2MDEzXSBpb19zY2hlZHVsZSAo
a2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjUuNTI4OTY0XSBfX2xvY2tfcGFnZV9r
aWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNS41MzI3OTRdID8gZmlsZV9mZGF0
YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjUuNTM2
NjA1XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkKWyAgIDI1LjUzOTkxMV0g
PyBmaWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oOjE2MDYpClsg
ICAyNS41NDM2ODJdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNS41NDY2
MjBdIGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDI1LjU1MDA1MF0g
PyBhc21fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0ICguL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2lkdGVudHJ5Lmg6NTgxKQpbICAgMjUuNTU0NjM3XSBfX2dldF91c2VyX3BhZ2VzICht
bS9ndXAuYzo4NzkpClsgICAyNS41NTgxMDFdIHBvcHVsYXRlX3ZtYV9wYWdlX3JhbmdlICht
bS9ndXAuYzoxNDIwKQpbICAgMjUuNTYxOTY4XSBfX21tX3BvcHVsYXRlIChtbS9ndXAuYzox
NDc2KQpbICAgMjUuNTY1MTI1XSBfX3g2NF9zeXNfbWxvY2thbGwgKC4vaW5jbHVkZS9saW51
eC9tbS5oOjI1NjcpClsgICAyNS41Njg3ODddIGRvX3N5c2NhbGxfNjQgKGFyY2gveDg2L2Vu
dHJ5L2NvbW1vbi5jOjQ2KQpbICAgMjUuNTcxOTE1XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUgKGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MTI1KQpbICAgMjUuNTc2MjMw
XSBSSVA6IDAwMzM6MHg3ZjIxYmVlNDZiM2IKWyAyNS41NzkzNTddIENvZGU6IEJhZCBSSVAg
dmFsdWUuCm9iamR1bXA6ICcvdG1wL3RtcC44Tm1LREdUeTE3Lm8nOiBObyBzdWNoIGZpbGUK
CkNvZGUgc3RhcnRpbmcgd2l0aCB0aGUgZmF1bHRpbmcgaW5zdHJ1Y3Rpb24KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpbICAgMjUuNTgyMTk5XSBSU1A6
IDAwMmI6MDAwMDdmZmNiNWY4YWQzOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAw
MDAwMDAwMDAwMDk3ClsgICAyNS41ODg1ODhdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6
IDAwMDA1NWM5NzYyZjE0NTAgUkNYOiAwMDAwN2YyMWJlZTQ2YjNiClsgICAyNS41OTQ2Mjdd
IFJEWDogMDAwMDdmZmNiNWY4YWQyOCBSU0k6IDAwMDAwMDAwMDAwMDAwMDIgUkRJOiAwMDAw
MDAwMDAwMDAwMDAzClsgICAyNS42MDA2MzddIFJCUDogMDAwMDdmZmNiNWY4YWQ0MCBSMDg6
IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClsgICAyNS42MDY3MDFd
IFIxMDogMDAwMDdmMjFiZWVjOWFjMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
NTVjOTc2MmIzMGEwClsgICAyNS42MTI3MzhdIFIxMzogMDAwMDdmZmNiNWY4YjE4MCBSMTQ6
IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwClsgICAyNS42MTg3NjJd
IHRhc2s6cGFja2V0ZHJpbGwgICAgIHN0YXRlOkQgc3RhY2s6MTM5NTIgcGlkOiAgMTkwIHBw
aWQ6ICAgMTUzIGZsYWdzOjB4MDAwMDQwMDAKWyAgIDI1LjYyNTc4MV0gQ2FsbCBUcmFjZToK
WyAgIDI1LjYyNzk4N10gX19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzozNzc4KQpb
ICAgMjUuNjMxMDQ2XSBzY2hlZHVsZSAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9iaXRvcHMu
aDoyMDcgKGRpc2NyaW1pbmF0b3IgMSkpClsgICAyNS42MzM3OTZdIGlvX3NjaGVkdWxlIChr
ZXJuZWwvc2NoZWQvY29yZS5jOjYyNzEpClsgICAyNS42MzY3MjZdID8gd2FrZV91cF9wYWdl
X2JpdCAobW0vZmlsZW1hcC5jOjExMjgpClsgICAyNS42NDAyNzFdID8gZmlsZV9mZGF0YXdh
aXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6NTE1KQpbICAgMjUuNjQ0MDIy
XSA/IGZpbGVtYXBfZmF1bHQgKG1tL2ZpbGVtYXAuYzoyNTM4KQpbICAgMjUuNjQ3NDI3XSA/
IGZpbGVtYXBfbWFwX3BhZ2VzICguL2luY2x1ZGUvbGludXgveGFycmF5Lmg6MTYwNikKWyAg
IDI1LjY1MTE0Nl0gPyBfX2RvX2ZhdWx0IChtbS9tZW1vcnkuYzozNDM5KQpbICAgMjUuNjU0
MjI3XSA/IGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykKWyAgIDI1LjY1Nzc1
Ml0gPyBfX2dldF91c2VyX3BhZ2VzIChtbS9ndXAuYzo4NzkpClsgICAyNS42NjEzNjhdID8g
cG9wdWxhdGVfdm1hX3BhZ2VfcmFuZ2UgKG1tL2d1cC5jOjE0MjApClsgICAyNS42NjUzMzhd
ID8gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI1LjY2ODcwN10gPyBfX3g2
NF9zeXNfbWxvY2thbGwgKC4vaW5jbHVkZS9saW51eC9tbS5oOjI1NjcpClsgICAyNS42NzI0
NjddID8gZG9fc3lzY2FsbF82NCAoYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NDYpClsgICAy
NS42NzU3NTFdID8gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9l
bnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI1LjY4MDIxM10gdGFzazpwYWNrZXRkcmlsbCAg
ICAgc3RhdGU6RCBzdGFjazoxMzk1MiBwaWQ6ICAxOTMgcHBpZDogICAxNjAgZmxhZ3M6MHgw
MDAwNDAwMApbICAgMjUuNjg3Mjg1XSBDYWxsIFRyYWNlOgpbICAgMjUuNjg5NDcyXSBfX3Nj
aGVkdWxlIChrZXJuZWwvc2NoZWQvY29yZS5jOjM3NzgpClsgICAyNS42OTI1NDddIHNjaGVk
dWxlICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9wcy5oOjIwNyAoZGlzY3JpbWluYXRv
ciAxKSkKWyAgIDI1LjY5NTMxNF0gaW9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6
NjI3MSkKWyAgIDI1LjY5ODIxNl0gX19sb2NrX3BhZ2Vfa2lsbGFibGUgKG1tL2ZpbGVtYXAu
YzoxMjQ1KQpbICAgMjUuNzAyMDEzXSA/IGZpbGVfZmRhdGF3YWl0X3JhbmdlICguL2luY2x1
ZGUvbGludXgvcGFnZW1hcC5oOjUxNSkKWyAgIDI1LjcwNTc1Ml0gZmlsZW1hcF9mYXVsdCAo
bW0vZmlsZW1hcC5jOjI1MzgpClsgICAyNS43MDkwMTBdID8gZmlsZW1hcF9tYXBfcGFnZXMg
KC4vaW5jbHVkZS9saW51eC94YXJyYXkuaDoxNjA2KQpbICAgMjUuNzEyNjkxXSBfX2RvX2Zh
dWx0IChtbS9tZW1vcnkuYzozNDM5KQpbICAgMjUuNzE1NjIwXSBoYW5kbGVfbW1fZmF1bHQg
KG1tL21lbW9yeS5jOjM4MzMpClsgICAyNS43MTkwMTNdIF9fZ2V0X3VzZXJfcGFnZXMgKG1t
L2d1cC5jOjg3OSkKWyAgIDI1LjcyMjQ4NV0gcG9wdWxhdGVfdm1hX3BhZ2VfcmFuZ2UgKG1t
L2d1cC5jOjE0MjApClsgICAyNS43MjYzMjZdIF9fbW1fcG9wdWxhdGUgKG1tL2d1cC5jOjE0
NzYpClsgICAyNS43Mjk1MjhdIF9feDY0X3N5c19tbG9ja2FsbCAoLi9pbmNsdWRlL2xpbnV4
L21tLmg6MjU2NykKWyAgIDI1LjczMzEzOF0gZG9fc3lzY2FsbF82NCAoYXJjaC94ODYvZW50
cnkvY29tbW9uLmM6NDYpClsgICAyNS43MzYyNjNdIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSAoYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoxMjUpClsgICAyNS43NDA1ODdd
IFJJUDogMDAzMzoweDdmZWI1OWMxNmIzYgpbIDI1Ljc0MzcxNl0gQ29kZTogQmFkIFJJUCB2
YWx1ZS4Kb2JqZHVtcDogJy90bXAvdG1wLngzbDllSjQxOUEubyc6IE5vIHN1Y2ggZmlsZQoK
Q29kZSBzdGFydGluZyB3aXRoIHRoZSBmYXVsdGluZyBpbnN0cnVjdGlvbgo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClsgICAyNS43NDY2NTNdIFJTUDog
MDAyYjowMDAwN2ZmZDc1ZWY3ZjM4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAw
MDAwMDAwMDAwOTcKWyAgIDI1Ljc1MzAxOV0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDog
MDAwMDU2MmE0OWFjYzQ1MCBSQ1g6IDAwMDA3ZmViNTljMTZiM2IKWyAgIDI1Ljc1OTA3N10g
UkRYOiAwMDAwN2ZmZDc1ZWY3ZjI4IFJTSTogMDAwMDAwMDAwMDAwMDAwMiBSREk6IDAwMDAw
MDAwMDAwMDAwMDMKWyAgIDI1Ljc2NTEyN10gUkJQOiAwMDAwN2ZmZDc1ZWY3ZjQwIFIwODog
MDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKWyAgIDI1Ljc3MTIzMV0g
UjEwOiAwMDAwN2ZlYjU5Yzk5YWMwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA1
NjJhNDlhOGUwYTAKWyAgIDI1Ljc3NzQ0Ml0gUjEzOiAwMDAwN2ZmZDc1ZWY4MzgwIFIxNDog
MDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDAKWyAgIDI1Ljc4MzQ5Nl0g
dGFzazpwYWNrZXRkcmlsbCAgICAgc3RhdGU6RCBzdGFjazoxMzk1MiBwaWQ6ICAxOTQgcHBp
ZDogICAxNTcgZmxhZ3M6MHgwMDAwNDAwMApbICAgMjUuNzkwNTM2XSBDYWxsIFRyYWNlOgpb
ICAgMjUuNzkyNzI2XSBfX3NjaGVkdWxlIChrZXJuZWwvc2NoZWQvY29yZS5jOjM3NzgpClsg
ICAyNS43OTU3NzddIHNjaGVkdWxlICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9wcy5o
OjIwNyAoZGlzY3JpbWluYXRvciAxKSkKWyAgIDI1Ljc5ODU4Ml0gaW9fc2NoZWR1bGUgKGtl
cm5lbC9zY2hlZC9jb3JlLmM6NjI3MSkKWyAgIDI1LjgwMTQ3M10gX19sb2NrX3BhZ2Vfa2ls
bGFibGUgKG1tL2ZpbGVtYXAuYzoxMjQ1KQpbICAgMjUuODA1MjQ2XSA/IGZpbGVfZmRhdGF3
YWl0X3JhbmdlICguL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oOjUxNSkKWyAgIDI1LjgwOTAx
NV0gZmlsZW1hcF9mYXVsdCAobW0vZmlsZW1hcC5jOjI1MzgpClsgICAyNS44MTIyNzldID8g
ZmlsZW1hcF9tYXBfcGFnZXMgKC4vaW5jbHVkZS9saW51eC94YXJyYXkuaDoxNjA2KQpbICAg
MjUuODE1OTgxXSBfX2RvX2ZhdWx0IChtbS9tZW1vcnkuYzozNDM5KQpbICAgMjUuODE4OTA5
XSBoYW5kbGVfbW1fZmF1bHQgKG1tL21lbW9yeS5jOjM4MzMpClsgICAyNS44MjI0NThdIF9f
Z2V0X3VzZXJfcGFnZXMgKG1tL2d1cC5jOjg3OSkKWyAgIDI1LjgyNTk0N10gcG9wdWxhdGVf
dm1hX3BhZ2VfcmFuZ2UgKG1tL2d1cC5jOjE0MjApClsgICAyNS44Mjk3NzVdIF9fbW1fcG9w
dWxhdGUgKG1tL2d1cC5jOjE0NzYpClsgICAyNS44MzI5NzNdIF9feDY0X3N5c19tbG9ja2Fs
bCAoLi9pbmNsdWRlL2xpbnV4L21tLmg6MjU2NykKWyAgIDI1LjgzNjU5MV0gZG9fc3lzY2Fs
bF82NCAoYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NDYpClsgICAyNS44Mzk3MTVdIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSAoYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzox
MjUpClsgICAyNS44NDQwODldIFJJUDogMDAzMzoweDdmMWJkZDM0MGIzYgpbIDI1Ljg0NzIx
OV0gQ29kZTogQmFkIFJJUCB2YWx1ZS4Kb2JqZHVtcDogJy90bXAvdG1wLnk1RUFZTVdZM3cu
byc6IE5vIHN1Y2ggZmlsZQoKQ29kZSBzdGFydGluZyB3aXRoIHRoZSBmYXVsdGluZyBpbnN0
cnVjdGlvbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Clsg
ICAyNS44NTAwNzldIFJTUDogMDAyYjowMDAwN2ZmZjk5MmY0OWU4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwOTcKWyAgIDI1Ljg1NjQ0Nl0gUkFYOiBmZmZm
ZmZmZmZmZmZmZmRhIFJCWDogMDAwMDU1N2RkZDNiODQ1MCBSQ1g6IDAwMDA3ZjFiZGQzNDBi
M2IKWyAgIDI1Ljg2MjQ4MV0gUkRYOiAwMDAwN2ZmZjk5MmY0OWQ4IFJTSTogMDAwMDAwMDAw
MDAwMDAwMiBSREk6IDAwMDAwMDAwMDAwMDAwMDMKWyAgIDI1Ljg2ODQ1NV0gUkJQOiAwMDAw
N2ZmZjk5MmY0OWYwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAw
MDAKWyAgIDI1Ljg3NDUyOF0gUjEwOiAwMDAwN2YxYmRkM2MzYWMwIFIxMTogMDAwMDAwMDAw
MDAwMDI0NiBSMTI6IDAwMDA1NTdkZGQzN2EwYTAKWyAgIDI1Ljg4MDU0MV0gUjEzOiAwMDAw
N2ZmZjk5MmY0ZTMwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAw
MDAKWyAgIDI1Ljg4NjU1Nl0gdGFzazpwYWNrZXRkcmlsbCAgICAgc3RhdGU6RCBzdGFjazox
Mzk1MiBwaWQ6ICAyMDAgcHBpZDogICAxNjIgZmxhZ3M6MHgwMDAwNDAwMApbICAgMjUuODkz
NTY4XSBDYWxsIFRyYWNlOgpbICAgMjUuODk1Nzc2XSBfX3NjaGVkdWxlIChrZXJuZWwvc2No
ZWQvY29yZS5jOjM3NzgpClsgICAyNS44OTg4MzNdIHNjaGVkdWxlICguL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2JpdG9wcy5oOjIwNyAoZGlzY3JpbWluYXRvciAxKSkKWyAgIDI1LjkwMTU3
OF0gaW9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6NjI3MSkKWyAgIDI1LjkwNDQ5
NV0gX19sb2NrX3BhZ2Vfa2lsbGFibGUgKG1tL2ZpbGVtYXAuYzoxMjQ1KQpbICAgMjUuOTA4
MjQ2XSA/IGZpbGVfZmRhdGF3YWl0X3JhbmdlICguL2luY2x1ZGUvbGludXgvcGFnZW1hcC5o
OjUxNSkKWyAgIDI1LjkxMjAxMl0gZmlsZW1hcF9mYXVsdCAobW0vZmlsZW1hcC5jOjI1Mzgp
ClsgICAyNS45MTUyNzBdID8gZmlsZW1hcF9tYXBfcGFnZXMgKC4vaW5jbHVkZS9saW51eC94
YXJyYXkuaDoxNjA2KQpbICAgMjUuOTE4OTY0XSBfX2RvX2ZhdWx0IChtbS9tZW1vcnkuYzoz
NDM5KQpbICAgMjUuOTIxODUzXSBoYW5kbGVfbW1fZmF1bHQgKG1tL21lbW9yeS5jOjM4MzMp
ClsgICAyNS45MjUyNDVdIF9fZ2V0X3VzZXJfcGFnZXMgKG1tL2d1cC5jOjg3OSkKWyAgIDI1
LjkyODcyMF0gcG9wdWxhdGVfdm1hX3BhZ2VfcmFuZ2UgKG1tL2d1cC5jOjE0MjApClsgICAy
NS45MzI1NDNdIF9fbW1fcG9wdWxhdGUgKG1tL2d1cC5jOjE0NzYpClsgICAyNS45MzU3Mjdd
IF9feDY0X3N5c19tbG9ja2FsbCAoLi9pbmNsdWRlL2xpbnV4L21tLmg6MjU2NykKWyAgIDI1
LjkzOTM0OF0gZG9fc3lzY2FsbF82NCAoYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NDYpClsg
ICAyNS45NDI0NjZdIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSAoYXJjaC94ODYv
ZW50cnkvZW50cnlfNjQuUzoxMjUpClsgICAyNS45NDY5MDZdIFJJUDogMDAzMzoweDdmYjM0
ODYwYmIzYgpbIDI1Ljk1MDAyNl0gQ29kZTogQmFkIFJJUCB2YWx1ZS4Kb2JqZHVtcDogJy90
bXAvdG1wLjdkVEl1RlY0MGgubyc6IE5vIHN1Y2ggZmlsZQoKQ29kZSBzdGFydGluZyB3aXRo
IHRoZSBmYXVsdGluZyBpbnN0cnVjdGlvbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09ClsgICAyNS45NTI4NDZdIFJTUDogMDAyYjowMDAwN2ZmZWE2MWI3
NjY4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwOTcKWyAgIDI1
Ljk1OTI4OV0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDU1YzZmMDFjMjQ1MCBS
Q1g6IDAwMDA3ZmIzNDg2MGJiM2IKWyAgIDI1Ljk2NTQ1M10gUkRYOiAwMDAwN2ZmZWE2MWI3
NjU4IFJTSTogMDAwMDAwMDAwMDAwMDAwMiBSREk6IDAwMDAwMDAwMDAwMDAwMDMKWyAgIDI1
Ljk3MTUwNF0gUkJQOiAwMDAwN2ZmZWE2MWI3NjcwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBS
MDk6IDAwMDAwMDAwMDAwMDAwMDAKWyAgIDI1Ljk3NzUwNV0gUjEwOiAwMDAwN2ZiMzQ4Njhl
YWMwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA1NWM2ZjAxODQwYTAKWyAgIDI1
Ljk4MzU5Nl0gUjEzOiAwMDAwN2ZmZWE2MWI3YWIwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBS
MTU6IDAwMDAwMDAwMDAwMDAwMDAKWyAgIDI1Ljk4OTU5OF0gdGFzazpwYWNrZXRkcmlsbCAg
ICAgc3RhdGU6RCBzdGFjazoxMzk1MiBwaWQ6ICAyMDMgcHBpZDogICAxNjkgZmxhZ3M6MHgw
MDAwNDAwMApbICAgMjUuOTk2NjExXSBDYWxsIFRyYWNlOgpbICAgMjUuOTk4ODIzXSBfX3Nj
aGVkdWxlIChrZXJuZWwvc2NoZWQvY29yZS5jOjM3NzgpClsgICAyNi4wMDE4NjNdIHNjaGVk
dWxlICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9wcy5oOjIwNyAoZGlzY3JpbWluYXRv
ciAxKSkKWyAgIDI2LjAwNDY0NV0gaW9fc2NoZWR1bGUgKGtlcm5lbC9zY2hlZC9jb3JlLmM6
NjI3MSkKWyAgIDI2LjAwNzU3Nl0gPyB3YWtlX3VwX3BhZ2VfYml0IChtbS9maWxlbWFwLmM6
MTEyOCkKWyAgIDI2LjAxMTEzM10gPyBmaWxlX2ZkYXRhd2FpdF9yYW5nZSAoLi9pbmNsdWRl
L2xpbnV4L3BhZ2VtYXAuaDo1MTUpClsgICAyNi4wMTQ5MDBdID8gZmlsZW1hcF9mYXVsdCAo
bW0vZmlsZW1hcC5jOjI1MzgpClsgICAyNi4wMTgyODJdID8gZmlsZW1hcF9tYXBfcGFnZXMg
KC4vaW5jbHVkZS9saW51eC94YXJyYXkuaDoxNjA2KQpbICAgMjYuMDIxOTczXSA/IF9fZG9f
ZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsgICAyNi4wMjUwMTddID8gaGFuZGxlX21tX2Zh
dWx0IChtbS9tZW1vcnkuYzozODMzKQpbICAgMjYuMDI4NTUxXSA/IF9fZ2V0X3VzZXJfcGFn
ZXMgKG1tL2d1cC5jOjg3OSkKWyAgIDI2LjAzMjE2M10gPyBwb3B1bGF0ZV92bWFfcGFnZV9y
YW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI2LjAzNjEzNF0gPyBfX21tX3BvcHVsYXRlICht
bS9ndXAuYzoxNDc2KQpbICAgMjYuMDM5NDg3XSA/IF9feDY0X3N5c19tbG9ja2FsbCAoLi9p
bmNsdWRlL2xpbnV4L21tLmg6MjU2NykKWyAgIDI2LjA0MzI2MF0gPyBkb19zeXNjYWxsXzY0
IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAgIDI2LjA0NjUyOF0gPyBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUgKGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MTI1
KQpbICAgMjYuMDUwOTY4XSB0YXNrOnBhY2tldGRyaWxsICAgICBzdGF0ZTpEIHN0YWNrOjEz
OTA0IHBpZDogIDIwNyBwcGlkOiAgIDE3MyBmbGFnczoweDAwMDA0MDAwClsgICAyNi4wNTgw
MDhdIENhbGwgVHJhY2U6ClsgICAyNi4wNjAxOTJdIF9fc2NoZWR1bGUgKGtlcm5lbC9zY2hl
ZC9jb3JlLmM6Mzc3OCkKWyAgIDI2LjA2MzI0OF0gc2NoZWR1bGUgKC4vYXJjaC94ODYvaW5j
bHVkZS9hc20vYml0b3BzLmg6MjA3IChkaXNjcmltaW5hdG9yIDEpKQpbICAgMjYuMDY2MDMy
XSBpb19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjYuMDY4OTI0
XSBfX2xvY2tfcGFnZV9raWxsYWJsZSAobW0vZmlsZW1hcC5jOjEyNDUpClsgICAyNi4wNzI2
NzddID8gZmlsZV9mZGF0YXdhaXRfcmFuZ2UgKC4vaW5jbHVkZS9saW51eC9wYWdlbWFwLmg6
NTE1KQpbICAgMjYuMDc2NDI5XSBmaWxlbWFwX2ZhdWx0IChtbS9maWxlbWFwLmM6MjUzOCkK
WyAgIDI2LjA3OTcwNF0gPyBmaWxlbWFwX21hcF9wYWdlcyAoLi9pbmNsdWRlL2xpbnV4L3hh
cnJheS5oOjE2MDYpClsgICAyNi4wODM0MjRdIF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0
MzkpClsgICAyNi4wODYzNDJdIGhhbmRsZV9tbV9mYXVsdCAobW0vbWVtb3J5LmM6MzgzMykK
WyAgIDI2LjA4OTcyMl0gX19nZXRfdXNlcl9wYWdlcyAobW0vZ3VwLmM6ODc5KQpbICAgMjYu
MDkzMjA5XSBwb3B1bGF0ZV92bWFfcGFnZV9yYW5nZSAobW0vZ3VwLmM6MTQyMCkKWyAgIDI2
LjA5NzA0MF0gX19tbV9wb3B1bGF0ZSAobW0vZ3VwLmM6MTQ3NikKWyAgIDI2LjEwMDIxOF0g
X194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUvbGludXgvbW0uaDoyNTY3KQpbICAgMjYu
MTAzODM3XSBkb19zeXNjYWxsXzY0IChhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0NikKWyAg
IDI2LjEwNjk0OF0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9l
bnRyeS9lbnRyeV82NC5TOjEyNSkKWyAgIDI2LjExMTI1Nl0gUklQOiAwMDMzOjB4N2Y5MGZi
ODI5YjNiClsgMjYuMTE0MzgzXSBDb2RlOiBCYWQgUklQIHZhbHVlLgpvYmpkdW1wOiAnL3Rt
cC90bXAuUnl6dHh1QmJVaS5vJzogTm8gc3VjaCBmaWxlCgpDb2RlIHN0YXJ0aW5nIHdpdGgg
dGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KWyAgIDI2LjExNzE4M10gUlNQOiAwMDJiOjAwMDA3ZmZjM2FlMDdl
YTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDA5NwpbICAgMjYu
MTIzNTg5XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwNTYwYmY4MzdkNDUwIFJD
WDogMDAwMDdmOTBmYjgyOWIzYgpbICAgMjYuMTI5NjE0XSBSRFg6IDAwMDA3ZmZjM2FlMDdl
OTggUlNJOiAwMDAwMDAwMDAwMDAwMDAyIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICAgMjYu
MTM1NjQxXSBSQlA6IDAwMDA3ZmZjM2FlMDdlYjAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIw
OTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjYuMTQxNjYwXSBSMTA6IDAwMDA3ZjkwZmI4YWNh
YzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDU2MGJmODMzZjBhMApbICAgMjYu
MTQ3Njc1XSBSMTM6IDAwMDA3ZmZjM2FlMDgyZjAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIx
NTogMDAwMDAwMDAwMDAwMDAwMApbICAgMjYuMTUzNjkzXSB0YXNrOnBhY2tldGRyaWxsICAg
ICBzdGF0ZTpEIHN0YWNrOjEzOTUyIHBpZDogIDIxMCBwcGlkOiAgIDE3OSBmbGFnczoweDAw
MDA0MDAwClsgICAyNi4xNjA3MjhdIENhbGwgVHJhY2U6ClsgICAyNi4xNjI5MjNdID8gc2No
ZWRfY2xvY2tfY3B1IChrZXJuZWwvc2NoZWQvY2xvY2suYzozODIpClsgICAyNi4xNjYzMjZd
ID8gdHR3dV9kb193YWtldXAuaXNyYS4wIChrZXJuZWwvc2NoZWQvY29yZS5jOjI0ODApClsg
ICAyNi4xNzAxNzJdID8gX19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUuYzozNzc4KQpb
ICAgMjYuMTczMzQ5XSA/IHNjaGVkdWxlICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9w
cy5oOjIwNyAoZGlzY3JpbWluYXRvciAxKSkKWyAgIDI2LjE3NjI3MV0gPyBpb19zY2hlZHVs
ZSAoa2VybmVsL3NjaGVkL2NvcmUuYzo2MjcxKQpbICAgMjYuMTc5MzIwXSA/IF9fbG9ja19w
YWdlX2tpbGxhYmxlIChtbS9maWxlbWFwLmM6MTI0NSkKWyAgIDI2LjE4MzIxNl0gPyBmaWxl
X2ZkYXRhd2FpdF9yYW5nZSAoLi9pbmNsdWRlL2xpbnV4L3BhZ2VtYXAuaDo1MTUpClsgICAy
Ni4xODcwMzFdID8gZmlsZW1hcF9mYXVsdCAobW0vZmlsZW1hcC5jOjI1MzgpClsgICAyNi4x
OTA0NTFdID8gZmlsZW1hcF9tYXBfcGFnZXMgKC4vaW5jbHVkZS9saW51eC94YXJyYXkuaDox
NjA2KQpbICAgMjYuMTk0MTI4XSA/IF9fZG9fZmF1bHQgKG1tL21lbW9yeS5jOjM0MzkpClsg
ICAyNi4xOTcxNjFdID8gaGFuZGxlX21tX2ZhdWx0IChtbS9tZW1vcnkuYzozODMzKQpbICAg
MjYuMjAwNjkyXSA/IHB1c2hfcnRfdGFza3MgKGtlcm5lbC9zY2hlZC9ydC5jOjE5NDUgKGRp
c2NyaW1pbmF0b3IgMSkpClsgICAyNi4yMDM4NjZdID8gX19nZXRfdXNlcl9wYWdlcyAobW0v
Z3VwLmM6ODc5KQpbICAgMjYuMjA3NDc0XSA/IHBvcHVsYXRlX3ZtYV9wYWdlX3JhbmdlICht
bS9ndXAuYzoxNDIwKQpbICAgMjYuMjExNDIzXSA/IF9fbW1fcG9wdWxhdGUgKG1tL2d1cC5j
OjE0NzYpClsgICAyNi4yMTQ3NjNdID8gX194NjRfc3lzX21sb2NrYWxsICguL2luY2x1ZGUv
bGludXgvbW0uaDoyNTY3KQpbICAgMjYuMjE4NTA2XSA/IGRvX3N5c2NhbGxfNjQgKGFyY2gv
eDg2L2VudHJ5L2NvbW1vbi5jOjQ2KQpbICAgMjYuMjIxNzU3XSA/IGVudHJ5X1NZU0NBTExf
NjRfYWZ0ZXJfaHdmcmFtZSAoYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoxMjUpClsgICAy
Ni4yMjYyMTZdIHRhc2s6cGFja2V0ZHJpbGwgICAgIHN0YXRlOkQgc3RhY2s6MTM5NTIgcGlk
OiAgMjEyIHBwaWQ6ICAgMTg1IGZsYWdzOjB4MDAwMDQwMDAKWyAgIDI2LjIzMzIyM10gQ2Fs
bCBUcmFjZToKWyAgIDI2LjIzNTQzNV0gX19zY2hlZHVsZSAoa2VybmVsL3NjaGVkL2NvcmUu
YzozNzc4KQpbICAgMjYuMjM4NDg3XSBzY2hlZHVsZSAoLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9iaXRvcHMuaDoyMDcgKGRpc2NyaW1pbmF0b3IgMSkpClsgICAyNi4yNDEyMzRdIGlvX3Nj
aGVkdWxlIChrZXJuZWwvc2NoZWQvY29yZS5jOjYyNzEpClsgICAyNi4yNDQxMzNdIF9fbG9j
a19wYWdlX2tpbGxhYmxlIChtbS9maWxlbWFwLmM6MTI0NSkKWyAgIDI2LjI0Nzg5MF0gPyBm
aWxlX2ZkYXRhd2FpdF9yYW5nZSAoLi9pbmNsdWRlL2xpbnV4L3BhZ2VtYXAuaDo1MTUpClsg
ICAyNi4yNTE2NDddIGZpbGVtYXBfZmF1bHQgKG1tL2ZpbGVtYXAuYzoyNTM4KQpbICAgMjYu
MjU0OTA2XSA/IGZpbGVtYXBfbWFwX3BhZ2VzICguL2luY2x1ZGUvbGludXgveGFycmF5Lmg6
MTYwNikKWyAgIDI2LjI1ODU5MF0gX19kb19mYXVsdCAobW0vbWVtb3J5LmM6MzQzOSkKWyAg
IDI2LjI2MTQ2Ml0gaGFuZGxlX21tX2ZhdWx0IChtbS9tZW1vcnkuYzozODMzKQpbICAgMjYu
MjY0ODY5XSBfX2dldF91c2VyX3BhZ2VzIChtbS9ndXAuYzo4NzkpClsgICAyNi4yNjgzMjdd
IHBvcHVsYXRlX3ZtYV9wYWdlX3JhbmdlIChtbS9ndXAuYzoxNDIwKQpbICAgMjYuMjcyMTYy
XSBfX21tX3BvcHVsYXRlIChtbS9ndXAuYzoxNDc2KQpbICAgMjYuMjc1MzQ3XSBfX3g2NF9z
eXNfbWxvY2thbGwgKC4vaW5jbHVkZS9saW51eC9tbS5oOjI1NjcpClsgICAyNi4yNzg5NzBd
IGRvX3N5c2NhbGxfNjQgKGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjQ2KQpbICAgMjYuMjgy
MDgyXSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUgKGFyY2gveDg2L2VudHJ5L2Vu
dHJ5XzY0LlM6MTI1KQpbICAgMjYuMjg2NDY2XSBSSVA6IDAwMzM6MHg3ZjAwZTg4NjNiM2IK
WyAyNi4yODk1NzRdIENvZGU6IEJhZCBSSVAgdmFsdWUuCm9iamR1bXA6ICcvdG1wL3RtcC5q
djBWT0FLaDFxLm8nOiBObyBzdWNoIGZpbGUKCkNvZGUgc3RhcnRpbmcgd2l0aCB0aGUgZmF1
bHRpbmcgaW5zdHJ1Y3Rpb24KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpbICAgMjYuMjkyNDIwXSBSU1A6IDAwMmI6MDAwMDdmZmY1YjI4ZjM3OCBFRkxB
R1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDk3ClsgICAyNi4yOTg3OTdd
IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA1NWVhM2JjOTc0NTAgUkNYOiAwMDAw
N2YwMGU4ODYzYjNiClsgICAyNi4zMDQ3ODddIFJEWDogMDAwMDdmZmY1YjI4ZjM2OCBSU0k6
IDAwMDAwMDAwMDAwMDAwMDIgUkRJOiAwMDAwMDAwMDAwMDAwMDAzClsgICAyNi4zMTA4Njdd
IFJCUDogMDAwMDdmZmY1YjI4ZjM4MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAw
MDAwMDAwMDAwMDAwClsgICAyNi4zMTY2OTddIFIxMDogMDAwMDdmMDBlODhlNmFjMCBSMTE6
IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwNTVlYTNiYzU5MGEwClsgICAyNi4zMjI1MjVd
IFIxMzogMDAwMDdmZmY1YjI4ZjdjMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAw
MDAwMDAwMDAwMDAwCg==
--------------FA417B90012EF9AEF780888D--
