Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D329A591F67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 12:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiHNKHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Aug 2022 06:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNKH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:07:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5433D1EC71;
        Sun, 14 Aug 2022 03:07:27 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M27ep-1oLEZz0ES9-002VzW; Sun, 14 Aug 2022 12:07:10 +0200
Message-ID: <38333b47-6871-00e2-db54-bde96a74bf00@i2se.com>
Date:   Sun, 14 Aug 2022 12:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
To:     Jan Kara <jack@suse.cz>, kernel-team@lists.ubuntu.com
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
 <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
 <d3d36051-3f7e-ffe3-6991-85614c1384b4@i2se.com>
Content-Language: en-US
In-Reply-To: <d3d36051-3f7e-ffe3-6991-85614c1384b4@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n15zq3ZgBlvJQk8mViiXql5BsfLSMYPXCezwwSv3j/K3e6BQl74
 HMX197C3BfJHdx8d+zWb9I3Lvq6netg+krFBZUCx596RzIVPhRZXX3Aprm+nF8zNTTSAmPc
 sEvN2PUp5/tIX0+7dhwNqD1Z7ewUatn+hBVH/W3MSCwsgQGTNeWSdNWyxX6VZ/8dy64E7DX
 sk9b+GSv3N7logbKAfw3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ffnml0wnutQ=:kxPeYMBCzd1V2QuO2Dm5Oz
 eEVg/y72mTTdpGuFjreonnsHRPFolHZIRK80578nJic9K4ELgZG9wcMAzbDahaQvm+5n8KIvP
 apxWJJjWi6F+pZmYgoZrj5Orfhqxa61oubTX2ZNNqs+w1KddBXY4QNwsK7zT+etPVEvYTmzd4
 BtUQZuf6jW9RQvC4HIf4CzBBNHAqK+VdOq4p9UubdzGePgxVmNponWjNHv2/PpaOKPRwMGOHz
 inaO7tI+zv4x/i8mW10g11B60+RuIdwziHVUQ1pOuK9jpU7YFDs5dIJwRuL7+Y9pmyIQqdGyz
 2xxj+slMeUT2lrvT2YrOlUtSKiVSgS7CQ8fhUzxvyVOO4oA7EMmF5y/r0pThZN378C/GduKRl
 VyiXEtjRsQD+3voNPseLjMGCCZZJiQLyz6s3EvK5i0j5WAEJsWh+8gMl3+gKObiwaMA6Wi1Y9
 yYBl/w/KmXDMTccjH3lvu+XNFC3Pz47hZ1u+9TH5F9ARwnKabS5KTy2eDcs1R494BbKns7Cif
 tOPPcl+FSxNCF4U6ylWP5CScwAgUXqUIxdfoTYRtTGdBs5Lc82n9OrO3StoWbLSfm/YhLxsv2
 FJYLCu0hvi5dpMya/Wrjq6DrETfAw+ggZGOpOrLMLkZ4fprSZQHR+L5mANcLcKajrVK6FPnXo
 KCQKPmnwzEFuo0I35qrufAB8s1Vv2Zns4DTTBZjPvToFEzVdizbxBcsyI/MqBNZnoO4K1HB/2
 gezC/tQLeWbWUT/lCMhcgqX+zxqEdUASpaFtKDQWfCqx+eXbrsNcErmWYiI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Am 06.08.22 um 17:23 schrieb Stefan Wahren:
> Hi,
>
> Am 31.07.22 um 22:42 schrieb Stefan Wahren:
>> Hi Jan,
>>
>> Am 28.07.22 um 12:00 schrieb Jan Kara:
>>>
>>> Also can get filesystem metadata image of your card like:
>>>    e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz
>>>
>>> and put it somewhere for download? The image will contain only fs 
>>> metadata,
>>> not data so it should be relatively small and we won't have access 
>>> to your
>>> secrets ;). With the image we'd be able to see how the free space looks
>>> like and whether it perhaps does not trigger some pathological 
>>> behavior.
>> i've problems with this. If i try store uncompressed the metadata of 
>> the second SD card partition (/dev/sdb2 = rootfs) the generated image 
>> file is nearly big as the whole partition. In compressed state it's 
>> 25 MB. Is this expected?
>
> This performance regression is also reproducible with 5.19 kernel 
> (arm64, defconfig) and 64-bit Raspberry Pi OS. Unfortunately the 
> problem with metadata generation is the same, the generated 
> uncompressed file is 15 GB.
>
recently i upgraded my build machine (Intel Core i7-1260P) which now 
runs Ubuntu 22.04 including a recent 5.15 kernel. On my build machine if 
i try to install my build kernel modules on the mentioned Industrial 
Kingston SD card 16 GB (SDCIT) and call "sync" immediately, the process 
will takes very long with recent LTS kernel (~ 5 minutes) and trigger a 
hung task warning:

[ 1692.880208] INFO: task sync:22272 blocked for more than 120 seconds.
[ 1692.880222]       Not tainted 5.15.0-46-generic #49-Ubuntu
[ 1692.880225] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1692.880228] task:sync            state:D stack:    0 pid:22272 ppid:  
5238 flags:0x00004002
[ 1692.880237] Call Trace:
[ 1692.880240]  <TASK>
[ 1692.880246]  __schedule+0x23d/0x590
[ 1692.880257]  schedule+0x4e/0xc0
[ 1692.880261]  wb_wait_for_completion+0x59/0x90
[ 1692.880269]  ? wait_woken+0x70/0x70
[ 1692.880275]  sync_inodes_sb+0xbe/0x100
[ 1692.880282]  sync_inodes_one_sb+0x19/0x20
[ 1692.880288]  iterate_supers+0xab/0x110
[ 1692.880294]  ? __x64_sys_tee+0xe0/0xe0
[ 1692.880300]  ksys_sync+0x42/0xa0
[ 1692.880304]  __do_sys_sync+0xe/0x20
[ 1692.880307]  do_syscall_64+0x59/0xc0
[ 1692.880312]  ? do_user_addr_fault+0x1e7/0x670
[ 1692.880319]  ? syscall_exit_to_user_mode+0x27/0x50
[ 1692.880324]  ? exit_to_user_mode_prepare+0x37/0xb0
[ 1692.880331]  ? irqentry_exit_to_user_mode+0x9/0x20
[ 1692.880336]  ? irqentry_exit+0x1d/0x30
[ 1692.880340]  ? exc_page_fault+0x89/0x170
[ 1692.880345]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 1692.880353] RIP: 0033:0x7fcbda436abb
[ 1692.880358] RSP: 002b:00007ffc94923968 EFLAGS: 00000246 ORIG_RAX: 
00000000000000a2
[ 1692.880363] RAX: ffffffffffffffda RBX: 00007ffc94923b48 RCX: 
00007fcbda436abb
[ 1692.880366] RDX: 00007fcbda53c101 RSI: 00007ffc94923b48 RDI: 
00007fcbda4f4e29
[ 1692.880369] RBP: 0000000000000001 R08: 0000000000000001 R09: 
0000000000000000
[ 1692.880371] R10: 000055ca76fb4340 R11: 0000000000000246 R12: 
000055ca752c3bc0
[ 1692.880373] R13: 000055ca752c119f R14: 00007fcbda53442c R15: 
000055ca752c1034
[ 1692.880379]  </TASK>

Interestingly if i switch to the older ubuntu kernel version 5.15.25 
(which shouldn't have "ext4: make mb_optimize_scan performance mount 
option work with extents" applied) the write process is much faster (~ 1 
minute) and i never saw the hung task.

Btw i setup a repo [1] to collect information about this issue. The 
first file adds a kernel log in regression case. The kernel was 5.19-rc6 
with multi_v7_defconfig and ARM_LPAE & EXT4_DEBUG enabled.

rpi-update was started before (backup & clean). The actual download 
started at 11:11:29 and is aborted at 11:14:18.

HTH

[1] - https://github.com/lategoodbye/mb_optimize_scan_regress
[2] - 
https://github.com/lategoodbye/mb_optimize_scan_regress/commit/6ff14dd4026d8607290b2727f5a2c3522567fb21

