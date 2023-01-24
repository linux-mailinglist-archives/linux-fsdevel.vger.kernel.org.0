Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA0678E44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjAXCb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:31:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F4CA11;
        Mon, 23 Jan 2023 18:31:52 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZktZ-1pDnzm2aGN-00Wiw9; Tue, 24
 Jan 2023 03:31:50 +0100
Message-ID: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
Date:   Tue, 24 Jan 2023 10:31:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Iyx1PrFreA9p+o88m4Se//lm7GE9UXRQDTqAXCMmTaYxZkdfOyp
 wCSYUjE0rScYrmB51TQRU3PQRyVNuxyOu7emeHeS2uK765RrI+sEk7RrxIOFlT31zdo1Tiz
 VkdPCxy+hhXY83fpzHCQ4ONd8BVDs+/Bv2QswjuXH3UgUs5p++0wXxdf+Q8AvBbrB975/71
 txFWodr2XvInANTTINdgA==
UI-OutboundReport: notjunk:1;M01:P0:LiZ1+r0SKwI=;wIkOBFg+oAlzegDTn1GeIYuKNFr
 5sNB/Y/7S/t+wvd1pn/0nkzjG+z+KNWoEirah2/iJ6FypCzWttJTrEcQMpMkgEjuv8vr9xYL+
 qKsezxi5KWe31vsV+eVCfV2/TZ7WidCdhs5U4uXo4oRWetiPbgCQ6MiL7TiQ1Y+z0w+YFu4gB
 0pCNVSN9gXvwgosQi63ZjXgIVpEqSvOx4hyGrAgWZf9AIBgSNvH/7ShPbw1+zizas7D8NCzFE
 KVsysom/e9YLtbryqIokqW1JFTfeKnBKk0wDt0KdJLwHSg4LjUFhGvCfoCk5Z8vxKZ9afY41P
 rgHYRvQ+BYHTwWn+DTVWhl7qq/7LZoKaNEkm+9SXUTSij27mkayNmgGILozzKrGCUzc8w9wcM
 kEl+l9g0AGinEMzOI5dzlNA0h0SlpcsdMLzjNr6bo4yoBMDS1a3HnBjKa75EP0rdKdBrw+VmJ
 W8VFioXyUDSK6RQxXimNWN1niPiQRgR8GkZWzIkJpLgeTTN7s1RWAp9IAo6+bS49PyA5gKwwb
 mOQR3/aZez1uhPFO/ptdeHePNcYayYJ9bJhoACTunZQfpG5CAJIUyK1kRQwf8iKlozn9i/G3o
 FgYcupDhdUTSI0lizOzbWme0vdREHYsWqwe28MrslJzmIs7cAB8Qi4405KKt6zkve3YcE/hEw
 nB+vpcbSW/sMPicq63KKuQDANM5oHUVfekJmYUhH/XPQlINZ2tvxePXinMn1jFl+/ACaVFD5W
 srOI9Slkq/D/+yxvo+TmB2VNcTfF8k3bSsmp1lyaAO9Xqkypibt2SeQzLWyP7nBdRbSHNuWI+
 4FYbRtKhsLxyCj73nIcuU0P+Bs/oQJQbhKGePZuv142egj4dgjp6ODDlUpuMmpywgL2+ZG8Is
 AkP2PkIJNp9coKzNGdoR0RBHhQhlfNnN8n8jXj4JtEqUJWQ6U4xbzessa83LpMipdBZ0gzubU
 PKK1pZqcsTjBZnKGbWpQb+h+5nY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm wondering what would happen if we submit a read bio containing 
multiple sectors, while the block disk driver/firmware has internal 
checksum and found just one sector is corrupted (mismatch with its 
internal csum)?

For example, we submit a read bio sized 16KiB, and the device is in 4K 
sector size (like most modern HDD/SSD).
The corruption happens at the 2nd sector of the 16KiB.

My instinct points to either of them:

A) Mark the whole 16KiB bio as BLK_STS_IOERR
    This means even we have 3 good sectors, we have to treat them all as
    errors.

B) Ignore the error mark the bio as BLK_STS_OK
    This means higher layer must have extra ways to verify the contents.

But my concern is, if we go path A), it means after a read bio failure, 
we should try read again with much smaller block size, until we hit a 
failure with one sector.

IIRC VFS would do some retry, but otherwise the FS/driver layer needs to 
do some internal work and hit an error, then they need to do the 
split-and-retry manually.

On the other hand path B) seems more straightforward, but the problem is 
also obvious. Thankfully most fses are already doing checksum for their 
metadata at least.


So what's the common solution in real world for device drivers/firmware?
Path A/B or some other solution?

And should the upper layer do extra split-and-retry by themselves?
I know btrfs scrub code and repair is doing such split-and-retry, but 
not 100% sure if this is really needed or helpful in real world.

Thanks,
Qu
