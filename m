Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E41580445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiGYTKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiGYTKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:10:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34965B0;
        Mon, 25 Jul 2022 12:10:16 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.109]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMoXC-1nxI7N2v1o-00Ij2c; Mon, 25 Jul 2022 21:09:33 +0200
Message-ID: <0840b428-3a77-2339-354f-7fbd3295bb4d@i2se.com>
Date:   Mon, 25 Jul 2022 21:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Content-Language: en-US
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <Yt6xsyy3+qEMn08y@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Yt6xsyy3+qEMn08y@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zkohnzVDX6GEalSLCUMmFbqsJwJxoWATycrIQTqfL65iZiwPMEU
 sy2EqTGJuiWYWrXJisaMISx7068cC556l6CddnfCMdyIvmNbcEYqDoQq++J8tcBtny2QvM2
 nXjQwuWg1bnGKPrhuohz1zn6todYnIPUYKwDr8bDhZQkIupzpGLho1aPm2f6e97bKtmChlk
 NHuZraFoL2SKzcqIpzt6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IUuuotGKt7w=:3t7CcV2l5Kwia56EcLvCgw
 5Vz9s2Y22iHojAn9A/2W0W59LbQlQCAXd7D/TBj9axxgFnBj0VGB6yb9DsKifrLBKqLHBOfFo
 p7TNzv3ZORlKaIGGr0O++Fe50rNQytVVn+nJEwfCu5hAjIGUEfZ6iPRzWi2ZOlNgXVbfr5xMP
 W92w4YM2r+Uide4E/5UUpCA7Qi7ueoRmHUvm5NIY6e/YxPqgVbxFRtBkpCiyXzdXoo7aa1tbd
 El7sgvNeyHzdLGekdUgtflFPO3a3JL/Ve3LkWlz5cSOEyFIr4lda0L1EiC03Tl6S79Nw27a96
 v6OU/8wC1P9oBdi8KeGGOYuZglcWwMhqnOxhjqA39YPHTreoXrFLU8g3EWVK5ZlI+Dr35QDBf
 oIVHfLFa7pGlb2nRcpa4/+fO+AVk3cTeDW7eRo0OUv0svYs/ZjH4iqdI+QHq5aFLZrBPiL6A3
 HgFjHnWvaaSJS786MFgcszzNZpLhbmoGTNVQdmL6e4nBDUIMwx9hLrk850K9lttrpzG4H/Kcu
 PPDSIvjW6OIYLnNk8bxMKmz16R9prlaT+bjlTROqpN67WVufzHx1Jbcb+cyJ3Q7kkm3c0WmO6
 +eCkHD5qnp+HBtRox0QG60M1M0CpRh954K8mUXs/u6CdeazN8Yhvi1mxE1uGA66LlPCCgX+sQ
 g+sc9TF1mhYDqSQG6lIAVPkRJp7j1QOXdt6ohbCrGPTG8liInq9XyvJWPj9g2KI7Byfk1mC6y
 vCzhz0aQvqyJv8HewN3wSzx/Czt5Al79de2aXUG05d8l3KKXlxVjVflJXeY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ojaswin,

Am 25.07.22 um 17:07 schrieb Ojaswin Mujoo:
> On Mon, Jul 18, 2022 at 03:29:47PM +0200, Stefan Wahren wrote:
>> Hi,
>>
>> i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm
>> unable to run "rpi-update" without massive performance regression on my
>> Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 5.17 this
>> tool successfully downloads the latest firmware (> 100 MB) on my development
>> micro SD card (Kingston 16 GB Industrial) with a ext4 filesystem within ~ 1
>> min. The same scenario on Linux 5.18 shows the following symptoms:
>>
>> - download takes endlessly much time and leads to an abort by userspace in
>> most cases because of the poor performance
>> - massive system load during download even after download has been aborted
>> (heartbeat LED goes wild)
>> - whole system becomes nearly unresponsive
>> - system load goes back to normal after > 10 min
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
> Hi Stefan,
>
> Apologies, I had missed this email initially. So this particular patch
> simply changed a typo in an if condition which was preventing the
> mb_optimize_scan option to be enabled correctly (This feature was
> introduced in the following commit [1]). I think with the
> mb_optimize_scan now working, it is somehow causing the firmware
> download/update to take a longer time.
>
> I'll try to investigate this and get back with my findings.

thanks. I wasn't able to reproduce this heavy load symptoms with every 
SD card. Maybe this depends on the write performance of the SD card to 
trigger the situation (used command to measure write performance: dd 
if=/dev/zero of=/boot/test bs=1M count=30 oflag=dsync,direct ).

I tested a Kingston consumer 32 GB which had nearly constant write 
performance of 13 MB/s and didn't had the heavy load symptoms. The 
firmware update was done in a few seconds, so hard to say that at least 
the performance regression is reproducible.

I also tested 2x Kingston industrial 16 GB which had a floating write 
performance between 5 and 10 MB/s (wear leveling?) and both had the 
heavy load symptoms.

All SD cards has been detected as ultra high speed DDR50 by the emmc2 
interface.

Best regards

>
> Regard,
> Ojaswin
>
> [1]
> 	commit 196e402adf2e4cd66f101923409f1970ec5f1af3
> 	From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 	Date: Thu, 1 Apr 2021 10:21:27 -0700
> 	
> 	ext4: improve cr 0 / cr 1 group scanning
>
>> Regards
>>
