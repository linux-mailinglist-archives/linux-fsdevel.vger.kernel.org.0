Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8658B667
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiHFPYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHFPYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:24:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F310558;
        Sat,  6 Aug 2022 08:24:08 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MauFB-1niXj640Zn-00cQBP; Sat, 06 Aug 2022 17:23:56 +0200
Message-ID: <d3d36051-3f7e-ffe3-6991-85614c1384b4@i2se.com>
Date:   Sat, 6 Aug 2022 17:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
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
 <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
In-Reply-To: <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jsGpuA1mHPfP/MeKzoZiAP5VNlKTEaEP1K4aBBwuPNiAQYx+6Ln
 nKhp8wwgv+PBbCE1KHlBKO3ZLmGkd1IkpGWyn0MdY9y3sEjrrq0C3/3jjgku/7zAjqmkZwK
 QzNmC8JOpyuJ82jg6d+nfbsSymGyx5BTP5ijURd/pWidI3z/TdP9UyKWs9u7l5MAUQeMrID
 jlOBJBXllI6QCsLYbe9mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQdPEoSU+10=:mhSBOrbq5u+XX12OonkXA3
 4PSVQcb8Jlwo2N7cv/E7NuuMwQv4lnVgkFOIsnBho+e7V5QwJXOyglmMqpzT380jOlJdF0APj
 +C5P8b1v818Ag2JAOAbXC4qZOZn7YzMXuwLHHdM3eUKTqHZvyIFcAIW+uEH9bXcH5px0qtsvg
 1nedGpkftsEaP+pu3D87hei6m9KGescGjn2dmiJ1NyPfF1WwN+GsYb9JwRRTBsVeDVEQLYUgO
 +1d0YpHMi88ss56uv01lYD1I6c7+04wOFVLKCNj+UCJrBcps+LipvMn7h3zn70u/jFBOyi7pv
 Kjzqi5niHbWQN/s/vV4qf8tOoWC46f102gTSMbCn204uWMP55T2ucwtdwjxbha5XoPHtp6wvR
 WJJciuIyGi+BKE7nk9G01GJS+SdduDyvlmgu0lnLFTYTzvTJ6koGZ2KOEVgvLoecypS99Y3Ws
 x3uZBb0SY6Oc/eHcadjBPXMEikK7iarF4GSKigxVt6xla2fWDPTTRsyvFn8QwfBph6V5+AEwE
 BRNEHo0z+Ax/0uK3uOiuIHqudIl5b2/g4lHUrgssay15EPFsATgZhvGSSNPPp3iDweqRvm3IW
 yXEIEkkcQzt4nfcBv7M1K7MnCkjfpU34tawPTdJicIaDElWT4l0g1oXbc+Q3YruTA8xOz4AGZ
 bORqbzHDOkTq6tnRWg8k2HeU5L9iUL8QqGH2gljtt6YD3XaSyuk7jwZzrg/wQYba/TIV0VFdW
 6qc79QuO1TPnXp5lfg2MndSdJN/9jHE8CNAShlXcfZNiz+o+rvZnDzoAPxw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Am 31.07.22 um 22:42 schrieb Stefan Wahren:
> Hi Jan,
>
> Am 28.07.22 um 12:00 schrieb Jan Kara:
>>
>> Also can get filesystem metadata image of your card like:
>>    e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz
>>
>> and put it somewhere for download? The image will contain only fs 
>> metadata,
>> not data so it should be relatively small and we won't have access to 
>> your
>> secrets ;). With the image we'd be able to see how the free space looks
>> like and whether it perhaps does not trigger some pathological behavior.
> i've problems with this. If i try store uncompressed the metadata of 
> the second SD card partition (/dev/sdb2 = rootfs) the generated image 
> file is nearly big as the whole partition. In compressed state it's 25 
> MB. Is this expected?

This performance regression is also reproducible with 5.19 kernel 
(arm64, defconfig) and 64-bit Raspberry Pi OS. Unfortunately the problem 
with metadata generation is the same, the generated uncompressed file is 
15 GB.

