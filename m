Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A957F73F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jul 2022 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiGXVnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXVnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 17:43:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D55E0BB;
        Sun, 24 Jul 2022 14:43:51 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.109]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIxFi-1nwXq53hBC-00KQhX; Sun, 24 Jul 2022 23:43:39 +0200
Message-ID: <a9c9a644-cdff-2ef8-11f9-da1d358847af@i2se.com>
Date:   Sun, 24 Jul 2022 23:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
In-Reply-To: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oja2Wt+tcVzeBU9ldED50aSJKmbsFGTzChGtab/VChQfD7/nZR5
 meOAPLlqN6J6B1LGTtTVNQSMghNDHCYkZQdE7c7YXhUSU6pHOoX4HVLcQcvAdh0qnpzQXHG
 aWB2dRl39fDeUCaXGSN2dYHv58MpTIJqVvqKk5gKsk/pB3x6zMn79MX0mOLtsu6tMI9LRNd
 3QlJA7KwaBnmNGpAueXqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cdolft4/8b8=:oBsKyS8kuM/zb0dYfcYz3X
 rE5R0H+FuIaIe+IJbV1ytZn8m3H9bL30HuNlCCl4VD/VJOSnOck/msMku7Yubx0YcRQ/wTraR
 z7cdgqwHg7fOzfiu63ss57MwexNYo1bPuBGhNNNSBVYxEJm1113uGilBp3/C0A8KthwZN2zLM
 bEvptJRx528gL7OrWS5iMfrDcoAsYW7R6GAR/b69PLvC+J0VMmLmftG5vc4Z60weSLPZWIwd1
 WNnbYO/HnmkG9JmCfg13vfM0D+4ZatE6t0n0irmjTspKzGrH1fWJQ5bzGKQeU9Xad5AXgQ3ni
 6xyrrTgTatRriNp80XBWrL8nWEdZqjumcsYrlwopv74wP97PqdXg2r8ZIEaXeDGGbO7UxAL2+
 V2b6xQDIj3xuz7GcvKNbmEifiwp4gQu19OlKpYq+Mt6nUg5T3r8FF6EhSqK1wtgmV0dskYsEe
 Eu3CZ69K+Lhv4rQgjFc8z8fekCzsGwbmwzJ05NX4JjvR/UZweQ52qjNWnp04eRFb9tfIvBbMG
 7SqtWky1MnWXMGamGVIVeJ+WFab6V5PbpFc+vDrp2KuQvEOBk0CLxStpnJK0nL79TnYezCvac
 zvjg1CBwpNAO1v2aOK+9aXaKq8/bwLwZyRU7CZdGpkjO7hzCMObDvqnUff2np7y3vo3FXSdsM
 hWekPMzKor5NZ5hq+SMWEGQUv92Wp/potF3KuSwK+B60WIzwdfR0P2sePK/FYEIhAiuni34h4
 Nnu33FnNoxpVj0/L8jnCvFWDlz+lwChJmyE3iTOfmlRzrjh4I29JTDsb7wo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 18.07.22 um 15:29 schrieb Stefan Wahren:
> Hi,
>
> i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm 
> unable to run "rpi-update" without massive performance regression on 
> my Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 
> 5.17 this tool successfully downloads the latest firmware (> 100 MB) 
> on my development micro SD card (Kingston 16 GB Industrial) with a 
> ext4 filesystem within ~ 1 min. The same scenario on Linux 5.18 shows 
> the following symptoms:
>
FWIW, here some information about the affected ext4 partition:

fc stats:
0 commits
0 ineligible
0 numblks
0us avg_commit_time
Ineligible reasons:
"Extended attributes changed":    0
"Cross rename":    0
"Journal flag changed":    0
"Insufficient memory":    0
"Swap boot":    0
"Resize":    0
"Dir renamed":    0
"Falloc range op":    0
"Data journalling":    0

options:
rw
bsddf
nogrpid
block_validity
dioread_nolock
nodiscard
delalloc
nowarn_on_error
nojournal_checksum
barrier
auto_da_alloc
user_xattr
noquota
resuid=0
resgid=0
errors=continue
commit=5
min_batch_time=0
max_batch_time=15000
stripe=0
data=ordered
inode_readahead_blks=32
init_itable=10
max_dir_size_kb=0

tune2fs 1.44.5 (15-Dec-2018)
Filesystem volume name:   rootfs
Last mounted on:          /
Filesystem UUID:          3857a514-b0f4-49ce-8430-34762068bb6f
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index 
filetype needs_recovery extent flex_bg sparse_super large_file dir_nlink 
extra_isize
Filesystem flags:         unsigned_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              927360
Block count:              3755008
Reserved block count:     158603
Free blocks:              1770208
Free inodes:              731074
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      220
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8064
Inode blocks per group:   504
Flex block group size:    16
Filesystem created:       Fri Mar  5 00:10:14 2021
Last mount time:          Sun Jul 24 22:47:19 2022
Last write time:          Sun Jul 24 22:47:18 2022
Mount count:              4
Maximum mount count:      -1
Last checked:             Tue Jul 19 09:16:29 2022
Check interval:           0 (<none>)
Lifetime writes:          25 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:              256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      4f95e9ae-24e1-4c7f-bb32-f4a9c41649a7
Journal backup:           inode blocks

