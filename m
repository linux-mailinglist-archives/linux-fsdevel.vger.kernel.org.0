Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849A586165
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiGaUnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbiGaUnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:43:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A57FFD2F;
        Sun, 31 Jul 2022 13:43:15 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEVqu-1oFTpL2Yuo-00FyFa; Sun, 31 Jul 2022 22:42:57 +0200
Message-ID: <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
Date:   Sun, 31 Jul 2022 22:42:56 +0200
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
X-Provags-ID: V03:K1:Dcd8RCHyhpHavJXYcw0hQDX5NYRw1s/4sRLNcrD7ilRyJnQ+eOe
 I2GXOt7ObjklURZGQq0007jadzrUxUzw1kcMzl2gv5jlTmU17Y9ZJecZYfQ5mte4hwSBzyw
 tFtMtXB6BDvYY2+SMP1tX1iHwumVsvk6zRCoxlntAr/gLkKR+OgB1cgyPL5EvWBsXBFYMXE
 dDVOaIPd/si0MUBXs+U5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aZq7BjSyy7U=:22e74Qq48gKwrtv3X2UXIw
 AUdFiP5e2GbAb1Hizhf4KNy8b8KMkAZ28cGfeCdqiSwL/zUs7Z0GbiLdwBjlz8uYtO0g8eRyW
 f1bYDyOpSnsrJPRLa/KKJYrKcWsmtqxtFNWOM8482l9PIgMzvVx3qBBGS8nGRO0D4miU71PNt
 CR+PWAcS4NV251fE/Yh9iBv5Xo5pGkYLlKE4meem9KORB//fAk/NAHzIAO4zo28YMR5DCA2Il
 U3igwmdouxxlUqzQCrO7LM9vm9PICNndeBc5dHJUdnZydwL7zWPg9bMcuuOoFwKFUMYQj2Zoy
 LFDD4Rv0TjFubZR+po4LExGoetVZljgWRCPqYfzpf8RrD6Ojjzrlwn70qO8VR8aL1kuUIitnv
 /0C5etsXucvuXIXbWCCI1MTaaNwErzq7c1+WszgnvyF99BwM3DQJopgZKN7joqseANWM+RbEm
 jfF4AdXxIg0KnGxKYw4CKte661FLJQ1JC8eJuUEDE8eoDPcmJ1oMVzMAknlMKiTJPKZm4Btep
 60RyLWEUuw1KwybLFSenGSo4nPW+4TrQDt0AhAt+8CJMaNdxMK3wvMqY5MYPeTc3ZVz6iu/vZ
 /nHvpzvo+l436Y7hivCLoiQFnfos3aP+AkpxSZyC00JVyLyHTVCRi6lqWiJxp2gjePUyhYAIy
 Qtixh/eD8eFmC/fct4e5OgNA1wCU5Ijup9HyfjDn7EemhdwlsCvTY+e+Uk8cwDYUqgWqT/88m
 wj2kB10Wg601jHFKK/0jH8g3kA3CRqvIpYWgCdlqQqD0YL26YPdtWllcBSU=
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
>
> Also can get filesystem metadata image of your card like:
>    e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz
>
> and put it somewhere for download? The image will contain only fs metadata,
> not data so it should be relatively small and we won't have access to your
> secrets ;). With the image we'd be able to see how the free space looks
> like and whether it perhaps does not trigger some pathological behavior.
i've problems with this. If i try store uncompressed the metadata of the 
second SD card partition (/dev/sdb2 = rootfs) the generated image file 
is nearly big as the whole partition. In compressed state it's 25 MB. Is 
this expected?
