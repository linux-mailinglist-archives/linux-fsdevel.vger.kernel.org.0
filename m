Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23A4FCE4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiDLE6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 00:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiDLE6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:58:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAB5211C07;
        Mon, 11 Apr 2022 21:55:46 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGsxLBlViWOkfAA--.10756S3;
        Tue, 12 Apr 2022 12:55:40 +0800 (CST)
Subject: Re: [PATCH] MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS
 FILESYSTEM
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <1649733686-6128-1-git-send-email-yangtiezhu@loongson.cn>
 <20220412033917.GB16799@magnolia> <20220412035042.GC16799@magnolia>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0d629b54-a29c-aeed-1330-840b1b98a8a3@loongson.cn>
Date:   Tue, 12 Apr 2022 12:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220412035042.GC16799@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxGsxLBlViWOkfAA--.10756S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWDGr47AF48ZrykKF1kAFb_yoWkKwc_CF
        4UCw4kG3yUXry5AFsakF17Zr98tF48Xr48J3W0qw17X3Z8Ja4Fyw40kr93Wr98GryIyr4D
        CFWDWr17try2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26F4j6r4UJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07jnb18UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 04/12/2022 11:50 AM, Darrick J. Wong wrote:
> On Mon, Apr 11, 2022 at 08:39:17PM -0700, Darrick J. Wong wrote:
>> On Tue, Apr 12, 2022 at 11:21:26AM +0800, Tiezhu Yang wrote:
>>> Remove the following section entries of IOMAP FILESYSTEM LIBRARY:
>>>
>>> M:	linux-xfs@vger.kernel.org
>>> M:	linux-fsdevel@vger.kernel.org
>>>
>>> Remove the following section entry of XFS FILESYSTEM:
>>>
>>> M:	linux-xfs@vger.kernel.org
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>
>> WTF?
>>
>>  ▄▄   ▄   ▄▄   ▄    ▄
>>  █▀▄  █   ██   █  ▄▀
>>  █ █▄ █  █  █  █▄█
>>  █  █ █  █▄▄█  █  █▄
>>  █   ██ █    █ █   ▀▄
>
> *OH*, I see, you're getting rid of the M(ail): entry, probably because
> it's redundant with L(ist): or something??  Still... why does it matter?

Yes, the section entries are redundant. Sorry for the unclear description.

The intention of this patch is to clean up the redundant section entries.

>
> Seriously, changelogs need to say /why/ they're changing something, not
> simply restate what's already in the diff.

OK, thank you. Should I send a v2 patch to update the commit message
or just ignore this patch?

Thanks,
Tiezhu

