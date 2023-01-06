Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3D660189
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjAFNtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 08:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjAFNtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:49:41 -0500
X-Greylist: delayed 156107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 05:49:39 PST
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898D265C;
        Fri,  6 Jan 2023 05:49:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 601CA604F1;
        Fri,  6 Jan 2023 14:49:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673012976; bh=nrpGCol9vSWMjQ2sV6HMFGcy7zTh1fSvD6DJLZxpQvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mH5MF/fztODThvd5cOsRAnZJh6HXt1cf6/eLjk1o6AcjzR4kvRLVF2Z/87YnPZUy4
         XIwQpadxP6EymogPf3gUCT+v+Xu7WJVqPOry8t+LexZef19PsSQz5c2aKMJJsx6xUz
         RaZHptBl6eW5mHGLEmDlREL8FFX/0Ndby9nfux1tQZG1KOySE6hXnIDX1ktwXYRc1X
         n1q6BO49ZT1bxZRakvbEs7TlqNbCGB3Uco7MpjHyn1qvKrobM7z5VZ5aUOIuErvGNx
         G/KC1u1eN+bil6MReSFjScSG9uXEvpgxPXQo0o2Qf1T0tavOZ+jLbPL6a3smWwqsQa
         //gINH4deGg5w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WxSTEYOd956Q; Fri,  6 Jan 2023 14:49:34 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 831EE604F0;
        Fri,  6 Jan 2023 14:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673012974; bh=nrpGCol9vSWMjQ2sV6HMFGcy7zTh1fSvD6DJLZxpQvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TBIScCXoaH7GsyEmyrE4lmAGBjbSptK05peZDw4rozCadokJ43+2XtsbBxswPax/R
         xaZt0x2ydbeH6dN/lr3XcZIKnVBJ14o7Wz4GBjoEXuatDsBcaeKASupPH11o5TZEvb
         sIoZiUpHt4Yc0t+xivo8d2CEORmNYhiBRs3zMhZHaVjqo3NAUKq3rNNza2RUaCmFV9
         C3GGiKKqz7QlcMNTW3Kxg1dioGskyF2n+ZkRJnB8gdqIR+lPeSjj94wLLkvrtUzKUH
         pxtWMc28tIswwDTPU99L+k0UmPwJb1dIo2eWkYus8gU1pYQzLz8T04n3SIWJ08XeOM
         /qsqhrY1oFdpA==
Message-ID: <144466ba-842f-1cb4-81e4-c5910b88a1bc@alu.unizg.hr>
Date:   Fri, 6 Jan 2023 14:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: core dump in selftest of proc fs
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
 <Y7XHL8ZRBf7TA/q7@p183>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y7XHL8ZRBf7TA/q7@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04. 01. 2023. 19:36, Alexey Dobriyan wrote:
> On Wed, Jan 04, 2023 at 07:27:40PM +0100, Mirsad Goran Todorovac wrote:
>> Trying to complete `make kselftest` for the first time, so maybe I'm doing something wrong?
>>
>> Or we are having a regression in 6.2-rc2 release candidate ...
>>
>> However, the output of selftest run is:
> 
>> # proc-empty-vm: proc-empty-vm.c:184: test_proc_pid_maps: Assertion `rv == 0' failed.
>> # /usr/bin/timeout: the monitored command dumped core
>> # Aborted
>> not ok 5 selftests: proc: proc-empty-vm # exit=134
>> # selftests: proc: proc-pid-vm
>> # proc-pid-vm: proc-pid-vm.c:365: main: Assertion `rv == len' failed.
>> # /usr/bin/timeout: the monitored command dumped core
>> # Aborted
>>
>> Please find attached lshw output, dmesg, config and lsmod.
>>
>> I am available for further diagnostics.
>>
>> The platform is Ubuntu 22.10 kinetic kudu on a Lenovo Ideapad 3 15ITL6 laptop.
> 
> What the output of "cat /proc/self/maps" ?

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds# cat /proc/self/maps
5606e3099000-5606e309b000 r--p 00000000 103:04 5505728                   /usr/bin/cat
5606e309b000-5606e309f000 r-xp 00002000 103:04 5505728                   /usr/bin/cat
5606e309f000-5606e30a1000 r--p 00006000 103:04 5505728                   /usr/bin/cat
5606e30a1000-5606e30a2000 r--p 00007000 103:04 5505728                   /usr/bin/cat
5606e30a2000-5606e30a3000 rw-p 00008000 103:04 5505728                   /usr/bin/cat
5606e4804000-5606e4825000 rw-p 00000000 00:00 0                          [heap]
7f9833400000-7f9833c42000 r--p 00000000 103:04 5505206                   /usr/lib/locale/locale-archive
7f9833e00000-7f9833e22000 r--p 00000000 103:04 5506045                   /usr/lib/x86_64-linux-gnu/libc.so.6
7f9833e22000-7f9833f9b000 r-xp 00022000 103:04 5506045                   /usr/lib/x86_64-linux-gnu/libc.so.6
7f9833f9b000-7f9833ff2000 r--p 0019b000 103:04 5506045                   /usr/lib/x86_64-linux-gnu/libc.so.6
7f9833ff2000-7f9833ff6000 r--p 001f1000 103:04 5506045                   /usr/lib/x86_64-linux-gnu/libc.so.6
7f9833ff6000-7f9833ff8000 rw-p 001f5000 103:04 5506045                   /usr/lib/x86_64-linux-gnu/libc.so.6
7f9833ff8000-7f9834005000 rw-p 00000000 00:00 0
7f983401e000-7f9834040000 rw-p 00000000 00:00 0
7f9834040000-7f9834097000 r--p 00000000 103:04 5636099                   /usr/lib/locale/C.utf8/LC_CTYPE
7f9834097000-7f983409a000 rw-p 00000000 00:00 0
7f983409d000-7f983409e000 r--p 00000000 103:04 5636115                   /usr/lib/locale/C.utf8/LC_NUMERIC
7f983409e000-7f983409f000 r--p 00000000 103:04 5636123                   /usr/lib/locale/C.utf8/LC_TIME
7f983409f000-7f98340a0000 r--p 00000000 103:04 5636098                   /usr/lib/locale/C.utf8/LC_COLLATE
7f98340a0000-7f98340a1000 r--p 00000000 103:04 5636111                   /usr/lib/locale/C.utf8/LC_MONETARY
7f98340a1000-7f98340a2000 r--p 00000000 103:04 5636109                   /usr/lib/locale/C.utf8/LC_MESSAGES/SYS_LC_MESSAGES
7f98340a2000-7f98340a3000 r--p 00000000 103:04 5636117                   /usr/lib/locale/C.utf8/LC_PAPER
7f98340a3000-7f98340a4000 r--p 00000000 103:04 5636113                   /usr/lib/locale/C.utf8/LC_NAME
7f98340a4000-7f98340a5000 r--p 00000000 103:04 5636097                   /usr/lib/locale/C.utf8/LC_ADDRESS
7f98340a5000-7f98340a6000 r--p 00000000 103:04 5636121                   /usr/lib/locale/C.utf8/LC_TELEPHONE
7f98340a6000-7f98340a7000 r--p 00000000 103:04 5636107                   /usr/lib/locale/C.utf8/LC_MEASUREMENT
7f98340a7000-7f98340ae000 r--s 00000000 103:04 6164284                   /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
7f98340ae000-7f98340af000 r--p 00000000 103:04 5636106                   /usr/lib/locale/C.utf8/LC_IDENTIFICATION
7f98340af000-7f98340b1000 rw-p 00000000 00:00 0
7f98340b1000-7f98340b2000 r--p 00000000 103:04 5505669                   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f98340b2000-7f98340db000 r-xp 00001000 103:04 5505669                   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f98340db000-7f98340e5000 r--p 0002a000 103:04 5505669                   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f98340e5000-7f98340e7000 r--p 00034000 103:04 5505669                   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f98340e7000-7f98340e9000 rw-p 00036000 103:04 5505669                   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7ffd0e771000-7ffd0e792000 rw-p 00000000 00:00 0                          [stack]
7ffd0e7ec000-7ffd0e7f0000 r--p 00000000 00:00 0                          [vvar]
7ffd0e7f0000-7ffd0e7f2000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds#

Sorry, overlooked your reply in the bunch of msgs. :(

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

