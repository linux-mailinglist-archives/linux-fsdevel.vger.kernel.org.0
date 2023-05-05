Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B86F87BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjEERha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjEERh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:37:29 -0400
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8744D1A497
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 10:37:23 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-18.iol.local with ESMTPA
        id uzMvpOVFunRXQuzMvp9fjg; Fri, 05 May 2023 19:37:21 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1683308242; bh=T/9mLaDxPYIUtdStdPhJ5kTqDrjvgqe6d1DkCQBtGRU=;
        h=From;
        b=GD3FwoYxy/t8EPVYa9ZrxjlfEzRQuty1bheBDpOb1agltRuw5tXveIyYRuTwfW3zU
         +vkg0EipHM9GVq8ur8CMWMmw/gVcJ3RpzO2GxjK57gCFlhiQpHZQcUNo3PMgRyH+Q3
         xVfUteG/63USKQ/ciiPlLFKbQfSDmOJbHnCXl/VKaXh7rxL+mApyWCOw7Z6tcx3mWp
         oecRka8bNCyf9dTuRmao9PZe1OSMRh72WCE0iU9Sl4gG7DLLBB1jqpmEvPsz5hDRQe
         diW0DExbLHfRjJ+Q3ezy44iEJ98ZHvzEzgD/vstXf762sx0yw4cIi4tLyJoQ9fuWzB
         q/BpkkS2CRoVQ==
X-CNFS-Analysis: v=2.4 cv=P678xAMu c=1 sm=1 tr=0 ts=64553ed2 cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=V2sgnzSHAAAA:8 a=dysqGvRpkUls-atsRrIA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Z31ocT7rh6aUJxSkT1EX:22
Message-ID: <d804ac0a-57f5-f06b-432c-c053a1109020@libero.it>
Date:   Fri, 5 May 2023 19:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>, johns@valvesoftware.com,
        vivek@collabora.com, ludovico.denittis@collabora.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <b8f55fc3-80b3-be46-933a-4cfbd3c76a71@oracle.com>
 <7320368b-fd62-1482-1043-2f9cb1e2a5b9@igalia.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <7320368b-fd62-1482-1043-2f9cb1e2a5b9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAt5J0GWzvIAl+bMcWqkZzVYv31JrSim+wKKU6Iivwh+VFNaTRP6l6rrkFhtmtRspOmxIm+f/+dSydJoUSVPOTYTALsF+hVW7GuJOD5BLjSpxCs/Ag/D
 VWffa53wlLAN76xz1BRu1SYZcIE7JMvlExAzqUElmxaPnJ6x6J2ishloXDHkirP6iX8Oa1H6BAVC9VapmPXp/dO0O549WBl0UEJxtBpiPWoGLVDwTzQWyxo9
 NhWKYdsCZacuLQN1DxU1YpoGUENj7VV3l7reWT6rr3Hc++vARr1lhvNePKQ4+q7vgd5f3k2zXMjn3UxsDQv7L4jEP1JibvQfdZC8+nXwy86YCOPiHs5V1IB5
 vmCAZWdY0goEPOHa83mgo/cMlnlV+EPklxTRfjPxH7FPWy7G4LlspX+dmm8qIeZpdmy8pHWkV+YTCklhItSKbdUw2kj6sdSidHKKMpV6V2zgxu5Z7R3xNK2E
 IAYJGOl/jGMWhYEwBMOHqP7iPU2nuvdUjZOQGMmnifJEae/outx7Yt3xhZMHCmLGRZPT/uuUNUENo+HbW0neD2S9S+uUJyJtCQwwPw==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 18.27, Guilherme G. Piccoli wrote:
> On 05/05/2023 02:16, Anand Jain wrote:
>> [...]
>>>
>>> https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/
>>
>> Confused about your requirement: 2 identical filesystems mounted
>> simultaneously or just one at a time? Latter works. Bugs were fixed.
> 
> Hi Anand, apologies - in fact, in this old-ish thread I mentioned we
> need to mount one at a time, and this corresponds for the majority of
> the use case. BUT...it seems that for the installing step we require to
> have *both* mounted at the same time for a while, so it was a change in
> the requirement since last analysis, and this is really what we
> implemented here.

What if the different images have different uuid from the begin ?


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

