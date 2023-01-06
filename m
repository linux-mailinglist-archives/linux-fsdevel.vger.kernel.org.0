Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B015660192
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjAFNxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 08:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjAFNxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:53:16 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E81A210;
        Fri,  6 Jan 2023 05:53:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C67AA604F1;
        Fri,  6 Jan 2023 14:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673013193; bh=Q+AzEgTW/m2Pdu5fLVw0AFRlFGHoMItl3/gtOwW2H+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iDcIOkiFJfGX+psihuAYtSFeBTC+eH+3vaa1iabieBOGzw65S55QwRNFgKRuOFjsi
         vW8XCWnfQyi9YKIrbNjnEVVZ5jUYQ20Yt9JMKo+cSPwBLr+Jdao2ofxfCRN4l8X/N5
         17nXBfR+Ecq7TYOB16BArFjBSdjgVPAvwQ9joHY0KkDJ62ilAcsoWN2sa/YqLwwLuA
         KVfsrJPGPq9G7n+e+fZYiFD/oRD3RWPQFl0k14uaH470mrH3C1Nso+bGFM3R7oo+xo
         Vq3jEnPE1HdLIYmzmeiw3mBmDdAL2ql8gcrtvbTGmkqPtA4jz+WBYyx4BXVojcS3uN
         ISbHjCybQjeUQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SumuLJYPe6DP; Fri,  6 Jan 2023 14:53:11 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 729A0604F0;
        Fri,  6 Jan 2023 14:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673013191; bh=Q+AzEgTW/m2Pdu5fLVw0AFRlFGHoMItl3/gtOwW2H+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZnyFrMUW2LV1zU3pbUA5kgndltV48IbcTEs0SF3zdqUiYclFx7gNOOK5opKKD07+T
         mJsVriaFXLuRP3Cxs86+rIbErLJxMSam6BnR45PV5NlzXoqoFz9nSrhAbASPY8dwz0
         F15DVizRhqtaZ9M8IvPnn0+a0j1ApwdxSfQSZ/HrBs1p0ky0/bgm/kLQDWI4ky9L4S
         NO2r4BvdHO5cniVvOEhCaaRuCjTzTkGd3jAaRj4eA6NR95lbdgmOPGPp0snxqoRmNi
         WIjZ7IcxEco19NG+GthNle9Hz5Mj/O0E0Z9FMjruJlZSMFHTWkcBKaF65KHuRCHs1g
         6A5XdQSN2o6qg==
Message-ID: <97a9b094-11cc-5ad1-4874-8ead69a54127@alu.unizg.hr>
Date:   Fri, 6 Jan 2023 14:53:11 +0100
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
 <Y7f6WBUXBz8tlr3b@p183>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y7f6WBUXBz8tlr3b@p183>
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

On 06. 01. 2023. 11:39, Alexey Dobriyan wrote:
> On Wed, Jan 04, 2023 at 07:27:40PM +0100, Mirsad Goran Todorovac wrote:
>> Dear all,
>>
>> Trying to complete `make kselftest` for the first time, so maybe I'm doing something wrong?
>>
>> Or we are having a regression in 6.2-rc2 release candidate ...
>>
>> However, the output of selftest run is:
>>
>> make[2]: Entering directory '.../linux_torvalds/tools/testing/selftests/proc'
>> TAP version 13
>> 1..21
>> # selftests: proc: fd-001-lookup
>> ok 1 selftests: proc: fd-001-lookup
>> # selftests: proc: fd-002-posix-eq
>> ok 2 selftests: proc: fd-002-posix-eq
>> # selftests: proc: fd-003-kthread
>> ok 3 selftests: proc: fd-003-kthread
>> # selftests: proc: proc-loadavg-001
>> ok 4 selftests: proc: proc-loadavg-001
>> # selftests: proc: proc-empty-vm
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
> The "bug" is that "call rel32" instruction testing for executable
> vsyscall page which should be relocated to "call 0xffffffffff600000"
> is messed up. Ubuntu 22.10 ships with "vsyscall=xonly" so there should not be
> any faults when executing from it. But segfault happens with normal
> randomised userspace address.
> 
> I'll change it to "call *rax" which should be more robust (and works)
> and free from relocations.

If you will need to test the patch in the same environment where the problem initially
occurred, I am ready at your disposal.

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

