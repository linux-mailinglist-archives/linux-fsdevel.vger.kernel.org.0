Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF812592DD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbiHOLFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiHOLEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:04:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17B25C49;
        Mon, 15 Aug 2022 04:03:51 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MJWgK-1o3o6U0UWG-00JsTs; Mon, 15 Aug 2022 13:03:38 +0200
Message-ID: <c08a9f42-e213-fc35-db7b-c95ed6f1fdc8@i2se.com>
Date:   Mon, 15 Aug 2022 13:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
 <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
 <20220815103452.7hjx7ohzx64e5lex@quack3>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220815103452.7hjx7ohzx64e5lex@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AnzB4HAfkIiycFBgKsxTc+sAFq4EiPpS6CLnj6gUwrwjf3I+LJd
 ZhPWjk35dzscPw/FsLRyNQgQnG46MYvk7yRvgG6p+2qL3rE4hUTJfhyW0UqNw7x1bkO07Ru
 3LewU2IeVYUEv0wOBZlMGIMFoDAvnlhZRhOsplyOUnujPYtmS98ZskpF2Sp5zwGAyPPDN7o
 y6+uODWanJ380I5550hqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rLAjXadvhNs=:f8ICrXtGKlHfq2MytpCZ3+
 4EiuqrCf3YhuboCMieAg+vf1IHlbjGW3tBYyezTHRnPA+XqfYR489wcokB6+qaoT33CbzaEUJ
 nUVc0X6FjPLBi8zNrPEtPHDb2DYQbZIM42U6gCkBh6abO9wqOrMWZeECPpOkk6egRFyOjzaXV
 8BDaPyE5tMjkst62shrsg/dg2DJTCD/iAOynsBux6cF2+dwvYBCG7uuK+DamYKbExf4irezsQ
 WpSZToosq0Ydz3ZqGSzsCtyQ/Lcj0t8e5bZ7+aH4rde7OQx7LBIFWwkHrDtOyDMTFjrsvVqo9
 wdwPwvQY0FiZSe5Kh7CDaV8x+D8ZmYMpIj48LTar3a37iwWFGcCQ6en5M+/pfvaRLN2xQ3Lwf
 gxTpb1+s/AjsHFPWNTzKyhCG7uFqO3Pln8oY7hpaAQZp1ddNom/EzoIUxffi9cXktf89GiGzC
 noqR0HqSIYIwItWVIz+QOsYtQtphcTqZN52uP/u8eZCNM+oxH4mEKNyomeXQRy9AZ1yh9pnRI
 AILv9CfDbEFLFa2/8RHLaiAcM/vnxKqV/tbJxWsNM5akJ8iuDbZ6JvL2kR3HYFslOQSj2RUXc
 vXzTnq9HxwpReueQ/cgIYijZaNGRGjKhpBssqsXx+pvkTwqPodj96u2CKcSRI8kgBumGp2abf
 fVu75IZS5ejSUXWsm+iU1kmkxEkdxoevLtdcrL1dRw0hNPnTGRZXPHq0Pww0EyQkEgUdRLGFe
 amZj/nZTkIUeUwaIgp04Aw7yj6/pK13kfah/BWt30MN0487U7Z/9EgFs8seeb2WXbt2HUEx4L
 tpXAB+lB0ir/LpgdJglZEdS/kCnkIRPGIlQ6iVNxAjy1vGvmG0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

Am 15.08.22 um 12:34 schrieb Jan Kara:
> Hi Stefan,
>
> Back from vacation...
>
> On Sun 31-07-22 22:42:56, Stefan Wahren wrote:
>> Hi Jan,
>>
>> Am 28.07.22 um 12:00 schrieb Jan Kara:
>>> Also can get filesystem metadata image of your card like:
>>>     e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz
>>>
>>> and put it somewhere for download? The image will contain only fs metadata,
>>> not data so it should be relatively small and we won't have access to your
>>> secrets ;). With the image we'd be able to see how the free space looks
>>> like and whether it perhaps does not trigger some pathological behavior.
>> i've problems with this. If i try store uncompressed the metadata of the
>> second SD card partition (/dev/sdb2 = rootfs) the generated image file is
>> nearly big as the whole partition. In compressed state it's 25 MB. Is this
>> expected?
> Yes, that is expected. The resulting file is a sparse file that contains
> only metadata blocks that is the reason why it compresses so well but looks
> big.

i've added here:

https://github.com/lategoodbye/mb_optimize_scan_regress/blob/main/Kingston_SDCIT_rootfs_metadata.gz

>
> 								Honza
>
