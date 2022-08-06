Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEEF58B4DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbiHFJur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiHFJuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:50:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2475D6360;
        Sat,  6 Aug 2022 02:50:43 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4i3j-1nJTFK18Fj-011jVU; Sat, 06 Aug 2022 11:50:29 +0200
Message-ID: <64b7899f-d84d-93de-f9c5-49538bd080d0@i2se.com>
Date:   Sat, 6 Aug 2022 11:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <20220728100055.efbvaudwp3ofolpi@quack3>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220728100055.efbvaudwp3ofolpi@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F1YvMB+u/pmIcNnMLOPb4mMQnFOR6321Atr2xOmz7g75OffOXah
 e0v8RIg753iOQ0CUq3RUAgqLItetujsFzkwqEIhqqhJ1lhaay9RNMWgFHfyHqQsfUAQUO3j
 675pvP9LSVTcklAjQ6MRqtMPpWAVx+xFI3yfhHI1d3nUqCG0cvhGLWygzfr+vfLwEtvpxQ9
 6F3LzyQVm0M3qohG7s0eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zuVDuRXy/r4=:AtgI0XaLJ8nYeNSujLFvaD
 M5mRbIoXSjfhZDElm1WDpm1z2tX9Kpq9aHSgn43GEwcJTGu8wyOG0F/8fgUw9pMBjkbuTwrEL
 EXLhCst4sFbdB9EKx9p+6LLUi+DnN7LcJfbGi7v1kuC5muhlRHnWYRefm1mmQIJTpILFLD9gB
 OytAugx4s03WCUbk6wmJ7n82Mu9IuWejyKWUfzmS6yH2awqiWGtua7kRiLLI4zQtH0oRROrs9
 voXKyVykim7xGKwNxmpWin7bVjnZAG/vHFvvpnMMRbXB44QEz1x8M/+5c2kfKhMMzZ0Wmanuf
 iPYKFGSXJ+CxV7rtNriyUp/gin8VClYm2q933X1OVqHXcntMNEBqxxLVlvH45mGFzxsM4BaYq
 HupfdlcYs9PRJoqAJd1svhMr9xW/LhPWFNwmXfUJu/0TQkjyfrv/m7o3FeE0N1eSitt8JP2yv
 0EeOFpEYcWRzHE1k/OVG1VAbihiVXq7MKqGnKDuu8K9OnUAVNeEwtDAGeDnSzJ/mygPfPu++N
 zckMZ4NhuAYmEH1yXas8sYjBGna2sUigMX75vKeAsMhkFIoyIr8arJ2x2HzCazSC65beTbmX2
 XeJSGPWKd6z8M/PUld3JIIJzYJEaTewHmIe4HnjJptkZsYfDM4p7G6xU7z8AbUmm9PZPpTXgJ
 G+XZP/8NW67xVXcVP7OhfzhsDnkc5dtEeNTYmBXkddhXQcTUsrJJ2gHcvS6EEvOO5KoIerpS5
 NhoKb0OLZYlR7A0IuEatSl+X7THOUNjmi92kXbJDcDOXX2HEl9MiJQGe46g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

+add Florian

Am 28.07.22 um 12:00 schrieb Jan Kara:
> Hello!
>
> On Mon 18-07-22 15:29:47, Stefan Wahren wrote:
>> i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm
>> unable to run "rpi-update" without massive performance regression on my
>> Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 5.17 this
>> tool successfully downloads the latest firmware (> 100 MB) on my development
>> micro SD card (Kingston 16 GB Industrial) with a ext4 filesystem within ~ 1
>> min. The same scenario on Linux 5.18 shows the following symptoms:
> Thanks for report and the bisection!
>   
>> - download takes endlessly much time and leads to an abort by userspace in
>> most cases because of the poor performance
>> - massive system load during download even after download has been aborted
>> (heartbeat LED goes wild)
> OK, is it that the CPU is busy or are we waiting on the storage card?
> Observing top(1) for a while should be enough to get the idea.  (sorry, I'm
> not very familiar with RPi so I'm not sure what heartbeat LED shows).

My description wasn't precise. I mean the green ACT LED, which uses the 
LED heartbeat trigger:

"This allows LEDs to be controlled by a CPU load average. The flash 
frequency is a hyperbolic function of the 1-minute load average."

I'm not sure if it's CPU or IO driven load, here the top output in bad case:

top - 08:44:17 up 43 min,  2 users,  load average: 5,02, 5,45, 5,17
Tasks: 142 total,   1 running, 141 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0,4 us,  0,4 sy,  0,0 ni, 49,0 id, 50,2 wa,  0,0 hi, 0,0 si,  
0,0 st
MiB Mem :   7941,7 total,   4563,1 free,    312,7 used,   3066,0 buff/cache
MiB Swap:    100,0 total,    100,0 free,      0,0 used.   7359,6 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM TIME+ COMMAND
   879 pi        20   0  237712  50880  38824 S   1,6   0,6 0:07.69 
lxterminal
   539 root      20   0  203424  46356  25228 S   1,3   0,6 0:08.66 Xorg
  1046 pi        20   0   10296   2936   2556 R   1,3   0,0 0:03.13 top
   680 pi        20   0   83820  22172  17648 S   0,7   0,3 0:01.22 pcmanfm
    11 root      20   0       0      0      0 I   0,3   0,0 0:01.13 
rcu_sched
   234 root       0 -20       0      0      0 I   0,3   0,0 0:00.20 
kworker/u+
     1 root      20   0   33200   8580   6468 S   0,0   0,1 0:14.17 systemd
     2 root      20   0       0      0      0 S   0,0   0,0 0:00.02 
kthreadd
     3 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 rcu_gp
     4 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 
rcu_par_gp
     8 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 
mm_percpu+
     9 root      20   0       0      0      0 I   0,0   0,0 0:00.00 
rcu_tasks+
    10 root      20   0       0      0      0 S   0,0   0,0 0:03.77 
ksoftirqd+
    12 root      rt   0       0      0      0 S   0,0   0,0 0:00.01 
migration+
    14 root      20   0       0      0      0 S   0,0   0,0 0:00.00 cpuhp/0
    15 root      20   0       0      0      0 S   0,0   0,0 0:00.00 cpuhp/1
    16 root      rt   0       0      0      0 S   0,0   0,0 0:00.01 
migration+

>
>> - whole system becomes nearly unresponsive
>> - system load goes back to normal after > 10 min
> So what likely happens is that the downloaded data is in the pagecache and
> what is causing the stuckage is that we are writing it back to the SD card
> that somehow is much less efficient with mb_optimize_scan=1 for your setup.
> Even if you stop the download, we still have dirty data in the page cache
> which we need to write out so that is the reason why the system takes so
> long to return back to normal.
>
>> - dmesg doesn't show anything suspicious
>>
>> I was able to bisect this issue:
>>
>> ff042f4a9b050895a42cae893cc01fa2ca81b95c good
>> 4b0986a3613c92f4ec1bdc7f60ec66fea135991f bad
>> 25fd2d41b505d0640bdfe67aa77c549de2d3c18a bad
>> b4bc93bd76d4da32600795cd323c971f00a2e788 bad
>> 3fe2f7446f1e029b220f7f650df6d138f91651f2 bad
>> b080cee72ef355669cbc52ff55dc513d37433600 good
>> ad9c6ee642a61adae93dfa35582b5af16dc5173a good
>> 9b03992f0c88baef524842e411fbdc147780dd5d bad
>> aab4ed5816acc0af8cce2680880419cd64982b1d good
>> 14705fda8f6273501930dfe1d679ad4bec209f52 good
>> 5c93e8ecd5bd3bfdee013b6da0850357eb6ca4d8 good
>> 8cb5a30372ef5cf2b1d258fce1711d80f834740a bad
>> 077d0c2c78df6f7260cdd015a991327efa44d8ad bad
>> cc5095747edfb054ca2068d01af20be3fcc3634f good
>> 27b38686a3bb601db48901dbc4e2fc5d77ffa2c1 good
>>
>> commit 077d0c2c78df6f7260cdd015a991327efa44d8ad
>> Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Date:   Tue Mar 8 15:22:01 2022 +0530
>>
>> ext4: make mb_optimize_scan performance mount option work with extents
>>
>> If i revert this commit with Linux 5.19-rc6 the performance regression
>> disappears.
>>
>> Please ask if you need more information.
> Can you run "iostat -x 1" while the download is running so that we can see
> roughly how the IO pattern looks?
>
Here the output during download:

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00     36,00     0,00 0,00   0,00   
0,00    0,00 23189,50  46,38     0,00    18,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00     76,00     0,00 0,00   0,00   
0,00    0,00 46208,50  92,42     0,00    38,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    3,00      0,00     76,00     0,00 0,00   0,00   
0,00    0,00 48521,67 145,56     0,00    25,33 333,33 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    1,00      0,00     32,00     0,00 0,00   0,00   
0,00    0,00 57416,00  57,42     0,00    32,00 1000,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,75    0,00   50,00

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    3,00      0,00    112,00     0,00 0,00   0,00   
0,00    0,00 49107,67 147,32     0,00    37,33 333,33 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    1,00      0,00     12,00     0,00 0,00   0,00   
0,00    0,00 59402,00  59,40     0,00    12,00 1000,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    3,00      0,00    148,00     0,00 0,00   0,00   
0,00    0,00 51140,33 153,42     0,00    49,33 333,33 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    3,00      0,00     68,00     0,00 0,00   0,00   
0,00    0,00 53751,00 161,25     0,00    22,67 333,33 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00     32,00     0,00 0,00   0,00   
0,00    0,00 53363,50 106,73     0,00    16,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00     24,00     0,00 0,00   0,00   
0,00    0,00 39266,00  78,53     0,00    12,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,75    0,00   50,00

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00     80,00     0,00 0,00   0,00   
0,00    0,00 40135,00  80,27     0,00    40,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    5,00      0,00    184,00     0,00 0,00   0,00   
0,00    0,00 51459,80 257,30     0,00    36,80 200,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00     56,00     0,00 0,00   0,00   
0,00    0,00 52412,50 104,83     0,00    28,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    3,00      0,00     80,00     0,00 0,00   0,00   
0,00    0,00 56386,00 169,16     0,00    26,67 333,33 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    5,00      0,00     84,00     0,00 0,00   0,00   
0,00    0,00 53314,20 266,57     0,00    16,80 200,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,50    0,00    0,00   49,50    0,00   50,00

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    4,00      0,00     76,00     0,00 0,00   0,00   
0,00    0,00 58021,00 232,08     0,00    19,00 250,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,25   49,50    0,00   50,00

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    4,00      0,00     72,00     0,00 0,00   0,00   
0,00    0,00 62048,50 248,19     0,00    18,00 250,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,62    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00    116,00     0,00 0,00   0,00   
0,00    0,00 69769,00 139,54     0,00    58,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            6,47    0,00    2,49   59,20    0,00   31,84

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          1,00    4,00    132,00    624,00    32,00 243,00  
96,97  98,38  530,00 30246,50 121,52   132,00   156,00 178,00  89,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,00    0,00    0,00   49,87    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00    296,00     0,00 0,00   0,00   
0,00    0,00 1358,50   2,72     0,00   148,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,00   49,75    0,00   50,00

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    3,00      0,00    124,00     0,00 1,00   0,00  
25,00    0,00 2043,67   6,13     0,00    41,33 333,33 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,25   49,37    0,00   50,13

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    6,00      0,00    412,00     0,00 0,00   0,00   
0,00    0,00 3315,17  19,89     0,00    68,67 166,67 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,51    0,00    0,00   48,47    0,00   51,02

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    1,00      0,00     56,00     0,00 0,00   0,00   
0,00    0,00 4249,00   4,25     0,00    56,00 1000,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,50    0,00    0,75   48,87    0,00   49,87

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    2,00      0,00    248,00     0,00 0,00   0,00   
0,00    0,00 5190,50  10,38     0,00   124,00 500,00 100,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,75    0,00    0,00   49,38    0,00   49,88

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
mmcblk1          0,00    1,00      0,00     24,00     0,00 0,00   0,00   
0,00    0,00 6017,00   6,02     0,00    24,00 1000,00 100,00


Additionally i tried to compare the interrupt count between good and bad 
case. I booted the RPi 4, run rpi-update and dumped /proc/interrupts 
after 60 sec. In bad case the progress stuck somewhere in the half (not 
really deterministic) and in good it's finished or almost. Here is the diff:

--- intr_bad.log    2022-08-06 11:12:23.445661581 +0200
+++ intr_good.log    2022-08-06 11:27:32.104188861 +0200
@@ -1,19 +1,19 @@
             CPU0       CPU1       CPU2       CPU3
   25:          1          0          0          0     GICv2  99 
Level     timer
   26:          0          0          0          0     GICv2  29 
Level     arch_timer
- 27:       4551       3011       3326       2569     GICv2  30 
Level     arch_timer
+ 27:       4532       3367       3381       3439     GICv2  30 
Level     arch_timer
   35:          0          0          0          0     GICv2 175 
Level     PCIe PME
   36:        345          0          0          0     GICv2 112 
Level     DMA IRQ
   37:          0          0          0          0     GICv2 114 
Level     DMA IRQ
   43:         10          0          0          0     GICv2 125 
Level     ttyS1
   44:          0          0          0          0     GICv2 149 
Level     fe205000.i2c, fe804000.i2c
- 45:      34529          0          0          0     GICv2 158 
Level     mmc0, mmc1
- 46:        853          0          0          0     GICv2  65 
Level     fe00b880.mailbox
+ 45:      36427          0          0          0     GICv2 158 
Level     mmc0, mmc1
+ 46:        941          0          0          0     GICv2  65 
Level     fe00b880.mailbox
   47:       6864          0          0          0     GICv2 153 
Level     uart-pl011
   48:          0          0          0          0     GICv2 105 
Level     fe980000.usb, fe980000.usb
- 49:        925          0          0          0  BRCM STB PCIe MSI 
524288 Edge      xhci_hcd
- 50:      46821          0          0          0     GICv2 189 
Level     eth0
- 51:      15199          0          0          0     GICv2 190 
Level     eth0
+ 49:        836          0          0          0  BRCM STB PCIe MSI 
524288 Edge      xhci_hcd
+ 50:      86424          0          0          0     GICv2 189 
Level     eth0
+ 51:      23329          0          0          0     GICv2 190 
Level     eth0
   52:          0          0          0          0     GICv2 129 
Level     vc4 hvs
   53:          0          0          0          0 
interrupt-controller@7ef00100   4 Edge      vc4 hdmi hpd connected
   54:          0          0          0          0 
interrupt-controller@7ef00100   5 Edge      vc4 hdmi hpd disconnected
@@ -22,12 +22,12 @@
   57:          0          0          0          0     GICv2 107 
Level     fe004000.txp
   58:          0          0          0          0     GICv2 141 
Level     vc4 crtc
   59:          0          0          0          0     GICv2 142 
Level     vc4 crtc, vc4 crtc
- 60:         10          0          0          0     GICv2 133 
Level     vc4 crtc
+ 60:         11          0          0          0     GICv2 133 
Level     vc4 crtc
  IPI0:          0          0          0          0  CPU wakeup interrupts
  IPI1:          0          0          0          0  Timer broadcast 
interrupts
-IPI2:        216        252        218        269  Rescheduling interrupts
-IPI3:      16955      16920      16352      16607  Function call interrupts
+IPI2:        265        264        229        248  Rescheduling interrupts
+IPI3:       9865      37517      13414      24022  Function call interrupts
  IPI4:          0          0          0          0  CPU stop interrupts
-IPI5:        826        190        290        204  IRQ work interrupts
+IPI5:        532        245        238        210  IRQ work interrupts
  IPI6:          0          0          0          0  completion interrupts
  Err:          0

