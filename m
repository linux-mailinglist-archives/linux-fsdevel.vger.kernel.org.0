Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54988584B35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 07:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiG2FbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 01:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiG2Fap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:30:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46B2252B;
        Thu, 28 Jul 2022 22:30:43 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVdUQ-1nrtva20Yu-00RZCZ; Fri, 29 Jul 2022 07:30:26 +0200
Message-ID: <2217188c-7009-f142-3e7e-b3e61d2c1324@i2se.com>
Date:   Fri, 29 Jul 2022 07:30:25 +0200
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
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <20220728100055.efbvaudwp3ofolpi@quack3>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220728100055.efbvaudwp3ofolpi@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FNwSToRwLJFsGPwaWndrCkF2afnJZmdTz8/LvCWfTqfzb+Wj0fG
 C+5a+Gl7+RwsgqdTkryfEOtAq+3TwLsOpYzpdKf64zVjv61poSLT4WLcW5Ff5BAPCD+lr8r
 +0nFRCM81tCMEuPI8T9N+xJprm01eip07MWJN0p42DGtBJsepV9s259mNUD2kmLohkDDrZP
 mNUCZf6Q2mpB4m1+6NlCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:db/sxB+DMa0=:AkfFhuXq5Uq+wEnTYFMCIM
 zP1mAxYsVg2LrNKjrrYZLTDnv1LdlGNjRCC9eCOEQqy6wEJ+rVcu4lVXZG4zIucRlvfG2PhsI
 rAwinCwvyTy7NJ4I0RY3iFzByfvKdnrvgoy36RLz0URMQVx0x+K+9aZCBnxINdTrTvzsJo6np
 gOlhm+GPqTUQvvDQZRqyEQPggQPSbTmOpfLHFfEpEVgOfiPv/241LgGcGjZSj6fSHYoFhgGww
 z7j0ivYQJZS68lkAncx0O3+zgR+LMuUEuPtCZfKq2CQJdjyv8YFjUvP6Psw8XrjtUnlMHOp/R
 P3IasBIXTKbF3ekElozrNitOX2ThVPdG53NyyWF/UrSTZUyIenwTEiVAFongYwYymHQhmiGGb
 cjnhXJE4psItTLZXeaRfyuLwLhH6ZRir4vnX298tUbbcfYgHav7GzEYoQNwFj5atnXCShSkEW
 IWSEmg1GU0/8xTaBWou/j8fBTdup4JXp41sl05TtLuDXjQOk6cT6d3GK+97ydU5gwvvsUbIEU
 npuQ5dTusXruuBpVCKMcjiIT2trV5LozA8O6QZTLNmGAUG8Z+FZ00bv4PZEUsVo3oowDMN+IT
 wzeOe0M5kje23ToytOQrqAFUQpUpXke5cJ3IGX2312KD9H4eJ2FkZSbMQvMQ/WyBMt9OjWN5q
 eoVRL4J645bG0Q5u1ZG3m2di1dimrtR2JLkUmuDzXx1hupc1e9gtXr8DmhY4OfvoY91pRHpcA
 A7s7xQNY9ykSSb28ZwEBa+QqVQ1H1P8aGCh2OnAb56Fd+5m6xFXFTMfFUgY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

Am 28.07.22 um 12:00 schrieb Jan Kara:
> Hello!
> Can you run "iostat -x 1" while the download is running so that we can see
> roughly how the IO pattern looks?
>
> Also can get filesystem metadata image of your card like:
>    e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz
>
> and put it somewhere for download? The image will contain only fs metadata,
> not data so it should be relatively small and we won't have access to your
> secrets ;). With the image we'd be able to see how the free space looks
> like and whether it perhaps does not trigger some pathological behavior.
>
> My current suspicion is that because the new allocator strategy spreads
> allocations over more block groups, we end up with more open erase blocks
> on the SD card which forces the firmware to do more garbage collection and
> RMW of erase blocks and write performance tanks...
>
> Thanks.
thanks for your feedback. Unfortunately i'm busy the next days, so it 
will take some time to provide this.
> 								Honza
>
