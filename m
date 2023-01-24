Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1F679252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 08:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjAXHxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 02:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXHxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:53:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6FC44A9;
        Mon, 23 Jan 2023 23:53:01 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1onNXC3C23-00ffqK; Tue, 24
 Jan 2023 08:52:42 +0100
Message-ID: <88b3df41-1a62-a6c8-911c-de8b4bca3196@gmx.com>
Date:   Tue, 24 Jan 2023 15:52:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
 <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
 <08def3ca-ccbd-88c7-acda-f155c1359c3b@gmx.com>
 <Y897ZrBFdfLcHFma@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y897ZrBFdfLcHFma@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1ggwe0DwWqkhD6T2lrbJXFXYeNTc8EyksCMroS3owgQMzDf08JT
 3h/G/XiC3C6ZK9B22zZ8liSCG1QpzAQ6Yr7Ke9KumpMyxRI9nyWNcxDKHE93JZ1spdmqI7H
 90lHSUIeZdUsKeMLEebnRu7Xvlb7N/6CfSmdt60GMJq2kuuCoAQuxa+/MMG8dlIouWHG5rv
 h840o5MJzmfJ8FjqCMPHg==
UI-OutboundReport: notjunk:1;M01:P0:1WVatoXm5Dc=;dp9fzRTpkXxykxzMOxNZobVea/N
 LGQLs8+ere0EUeayQJeRf2rcNajqczQt+qGU9yOsZTnu+xIRd499I/ZqcmtlMp6F2geQecCYH
 Z9917am8TGIw13Oz7p65HNPkO2f8OwLuxYLp5VVwiB/Ie1bVDiLyrGCNWtHJSHHuFsmNLOGqm
 asuAsnLFO61WZKrQS+L9TD18A/f16Qx1o1r/OdaQHSFZfzQuZK8Cm13lMKGl1pPT8GYA044d3
 /zC8kQFQwG1JDJsb54ft1roc320snHvdxDaGtz2rAdhgeAWVe0AO64H0zNiKmRe7cmp49Wpxz
 WkSL6PX4w8GmbBSD+wKJLt6J3rYt9tqBrA+NW8V4Y4V1GVf4xIK1e0QYDQZjtgC5o2CcPVvXk
 aaWFePu2/aT0R1AT/rrZ5ztun4Un9Yl7Y/B2gOCdMQPOrSmJAtT6j9XQ67c8UF3NzfcEhKKzR
 dS44PzXTE1gvM0eTX2UzCG5gEIIpFGOoYA5kY+QOeaIWI2JKHAqpYTM/Tc6RIO4YzKNjg2nfb
 PSuX3B97wIloTtqr8VRG/2QEGnLndGQDQQHzdjRMrlScg/sY8MspyZhMW6/18jiYZlO7ueY9V
 +KlXsGSlStJmPH+d2R8u3qVus26xUfEeHLRnH69bEfKPk9ztvUyBjpBpgnqJnRGl8uC9ITYtC
 NLcdmtI5jyp/C0Hjzdg/RYYB3DlYBd/1eaKNiUBiRLbWHsiTTbF76j53nbtIHWa/9KlQROPHF
 DfLvbOHosyZzJHC0KdGClVo7ImoSEvNBwIwlRBdRu2OGqDNjOI/bZdbDMqwAvHeVLsXdiLDKx
 WIqBSgTUHtffK0wr8QYx5NiAUbgas5dSQF0gh3R5pSnRdLR0capaaoYQYl/1xIt0proC2xDXO
 XCLSZLi9g/nkgb4v+jcUsb0RiCKBI3XthX9/cZM/hlsR9bfFs2viIwnyLvZT/NY8IncKQqP4I
 deWu2N+s979bZ+VWI5OuJYRQANo=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/24 14:32, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 01:38:41PM +0800, Qu Wenruo wrote:
>> The retry for file read is indeed triggered inside VFS, not fs/block/dm
>> layer itself.
> 
> Well, it's really MM code.  If ->readahead fails, we eventually fall
> back to a single-page ->radpage.  That might still be more than one
> sector in some cases, but at least nicely narrows down the range.

This also means, if some internal work (like btrfs scrub) is not 
triggered by MM, then we have to do the split all by ourselves...

Thanks,
Qu
