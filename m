Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2975783B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiGRNac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiGRNaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:30:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC41A388;
        Mon, 18 Jul 2022 06:29:59 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MtO06-1nOMvi0yvG-00usz7; Mon, 18 Jul 2022 15:29:48 +0200
Message-ID: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
Date:   Mon, 18 Jul 2022 15:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9fY30Z9jd9z0wsQphdvwiUzBCnLULQyuNQ0uIByAwsbooQNcfqb
 nKlAGwHxs0c5ASlv6XRDoLl+hDi/3Gp9Sb9X9yAOgc5WfuqRQZiF9sp1OA8kutUAGtP8oC/
 ox0cnH2YpmLwrfrAG+h0eSWfP8aKbduEAmEL14GxyPgWFrONRY7Ea3Djvp83TUerI0XyUre
 irkvwxm217+MRIau00B9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CwKwexPPutM=:ml7nh5Q5lT5cE3anMzqwB+
 5MbPejskWOkTI6L2y9E9elOAAbC48I2y5a4O4G7pTvByLSQRwBCVgTFzVUs3I0FzdFmG40r+u
 LNbaE9BVmWGq/B3s1HX2gF5BBvHuFryJQ8H3jAJmUItanRoeOCx4ODcpPknR2/6o28vWDNOUJ
 QEf/eCz5j9a6PqUU7FSjmyL8s8KSmEN3noMneD7dcvpCnm7OUIDtfZSnf7qPfR3av6AOO0rPE
 wYDoTDaUNtCTyiUbp66641aS7UP8HPq3uczjYA4w6gwGgLnusabxwOXgSLLRnhOjJ7vs47zr5
 e2iDP+9U92CguJsrZ0QAn+ZnuYHkT0I4ENOvE+UU+foMU/l8OJZuHzO5+h640qL4NcSn1RMSQ
 DpfS1aaMJKg2lM6xmR9rix5HVq6mUsIgu4EwKs+CLlC5L5IURWzLkU5gg3eI80sdeF+biFAK9
 XlNNTKA0eaQRn1WXQgCQ/l8z2VRsfPqBh8RW4ZAu6gfOkH9QJemAUMGb20ERhWFBON7qojMFc
 MhoPZsg7JskUI9AI3TGuyf2AGOVWywRmG7KyxJgY3byduJnuTT6ysUNKtIvHt2XyUdvoK0Bnq
 396QDB1pqWAM5X4X047fKbjJoruAMD+H2z90+/uBffSTKK7EBNvrcE9KrzDVBrmvRx6ExSwmB
 J2yUTOcsH9iQ/+rQJD5dLSLq4U4BtAkaA8Ku2p/0SWF6EVbNBGGTtwgwjIHUdGeiUbCtT4QbD
 wyoB7gAnkur27LuTAON7kru1z9sVJK68MkkQRAdRvARclqmavoUX3kEjSR0=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm 
unable to run "rpi-update" without massive performance regression on my 
Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 5.17 
this tool successfully downloads the latest firmware (> 100 MB) on my 
development micro SD card (Kingston 16 GB Industrial) with a ext4 
filesystem within ~ 1 min. The same scenario on Linux 5.18 shows the 
following symptoms:

- download takes endlessly much time and leads to an abort by userspace 
in most cases because of the poor performance
- massive system load during download even after download has been 
aborted (heartbeat LED goes wild)
- whole system becomes nearly unresponsive
- system load goes back to normal after > 10 min
- dmesg doesn't show anything suspicious

I was able to bisect this issue:

ff042f4a9b050895a42cae893cc01fa2ca81b95c good
4b0986a3613c92f4ec1bdc7f60ec66fea135991f bad
25fd2d41b505d0640bdfe67aa77c549de2d3c18a bad
b4bc93bd76d4da32600795cd323c971f00a2e788 bad
3fe2f7446f1e029b220f7f650df6d138f91651f2 bad
b080cee72ef355669cbc52ff55dc513d37433600 good
ad9c6ee642a61adae93dfa35582b5af16dc5173a good
9b03992f0c88baef524842e411fbdc147780dd5d bad
aab4ed5816acc0af8cce2680880419cd64982b1d good
14705fda8f6273501930dfe1d679ad4bec209f52 good
5c93e8ecd5bd3bfdee013b6da0850357eb6ca4d8 good
8cb5a30372ef5cf2b1d258fce1711d80f834740a bad
077d0c2c78df6f7260cdd015a991327efa44d8ad bad
cc5095747edfb054ca2068d01af20be3fcc3634f good
27b38686a3bb601db48901dbc4e2fc5d77ffa2c1 good

commit 077d0c2c78df6f7260cdd015a991327efa44d8ad
Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date:   Tue Mar 8 15:22:01 2022 +0530

ext4: make mb_optimize_scan performance mount option work with extents

If i revert this commit with Linux 5.19-rc6 the performance regression 
disappears.

Please ask if you need more information.

Regards

