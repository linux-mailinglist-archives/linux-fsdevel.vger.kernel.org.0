Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E83741DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 03:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjF2BdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 21:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjF2BdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:33:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33901B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 18:33:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-657c4bcad0bso41940b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 18:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688002400; x=1690594400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ThmVfXDix61iURcEU54u819vwIiq46rqbBRlmdFkhc=;
        b=5Mk3qzY+GGwK5f0XG2PEP8F1bOz4F185+PKdeygae6A+UYODLBokJW+GNP3+PWHS8d
         d5zNBixyu6zL01gbv6JgKD7lWAkyUdiTksr/IE/2IKZh4R8mZQMdOELxyyZKXqBTP6iW
         p93JyFDpkAQy/KOLjmDyOR1rD34j2vVE7vTGUvjT/d/jh5WC1JItVDg7pHpjN2cMx10k
         B5eAgCLH446/MgYszcNbhYm8qIdz0XdtO85g/G3S4bzzAxhLTxLZlHoJhJquNYmxuyX/
         lclo4dreHZ+hMU1SiF7FOtsKdoHQEVeBv3t32cpMWtilpicKOC6PI6/V5EKwgq8rH0m7
         0SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002400; x=1690594400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ThmVfXDix61iURcEU54u819vwIiq46rqbBRlmdFkhc=;
        b=J22pfD602dJFKdvW3yPDiTPpJ9DIb7BYsgUcA7roqLRKVEEA6LSuMBFNeikUq+gkYM
         4oagUman+50+P4oPGUA2IfuxwpXieU2bAImGr6E0iJlFIsUGF2KHbwCNTRPHA9wU+JlH
         h1BPg/DVsyP+VvYjR9CaEIP/uDxXj2QQpvBRBjxAaEgQIzWtXe/2EHdxf5+VggtNd9+9
         KjB+TZutl2M1X62lNJugu1kt+oIelRj5y36rZPXCpm+Ef/lIrYbLwbRrPw423YdjqGp1
         CKWXiySjvVJFZ8MA5CvYSNgLdi3lF12rVguhEd8NnaQSxBeEAVF7BhTagl+xJ1bwUKE9
         ZHhw==
X-Gm-Message-State: AC+VfDw3DTX4K8BcvuhGq+IVahDW8oiAzilgjjhP8Opo84YFUdPjrEH6
        tCnZjNyK9vLbf1WncJGksXH72A==
X-Google-Smtp-Source: ACHHUZ53nBn1+S49ohXzs5hHUpTioNTdZHS4ca3a2tM8yu35EDMUNWhK3xLR7CYm6Qbv+lAF238LRQ==
X-Received: by 2002:a05:6a21:9985:b0:127:2dc1:c885 with SMTP id ve5-20020a056a21998500b001272dc1c885mr13915975pzb.4.1688002400208;
        Wed, 28 Jun 2023 18:33:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709027c8b00b001b7e382dcdasm7951139pll.279.2023.06.28.18.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 18:33:19 -0700 (PDT)
Message-ID: <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
Date:   Wed, 28 Jun 2023 19:33:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZJzXs6C8G2SL10vq@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 7:00?PM, Dave Chinner wrote:
> On Wed, Jun 28, 2023 at 07:50:18PM -0400, Kent Overstreet wrote:
>> On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
>>> On 6/28/23 4:55?PM, Kent Overstreet wrote:
>>>>> But it's not aio (or io_uring or whatever), it's simply the fact that
>>>>> doing an fput() from an exiting task (for example) will end up being
>>>>> done async. And hence waiting for task exits is NOT enough to ensure
>>>>> that all file references have been released.
>>>>>
>>>>> Since there are a variety of other reasons why a mount may be pinned and
>>>>> fail to umount, perhaps it's worth considering that changing this
>>>>> behavior won't buy us that much. Especially since it's been around for
>>>>> more than 10 years:
>>>>
>>>> Because it seems that before io_uring the race was quite a bit harder to
>>>> hit - I only started seeing it when things started switching over to
>>>> io_uring. generic/388 used to pass reliably for me (pre backpointers),
>>>> now it doesn't.
>>>
>>> I literally just pasted a script that hits it in one second with aio. So
>>> maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
>>> hit with aio. As demonstrated. The io_uring is not hard to bring into
>>> parity on that front, here's one I posted earlier today for 6.5:
>>>
>>> https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
>>>
>>> Doesn't change the fact that you can easily hit this with io_uring or
>>> aio, and probably more things too (didn't look any further). Is it a
>>> realistic thing outside of funky tests? Probably not really, or at least
>>> if those guys hit it they'd probably have the work-around hack in place
>>> in their script already.
>>>
>>> But the fact is that it's been around for a decade. It's somehow a lot
>>> easier to hit with bcachefs than XFS, which may just be because the
>>> former has a bunch of workers and this may be deferring the delayed fput
>>> work more. Just hand waving.
>>
>> Not sure what you're arguing here...?
>>
>> We've had a long standing bug, it's recently become much easier to hit
>> (for multiple reasons); we seem to be in agreement on all that. All I'm
>> saying is that the existence of that bug previously is not reason to fix
>> it now.
> 
> I agree with Kent here  - the kernel bug needs to be fixed
> regardless of how long it has been around. Blaming the messenger
> (userspace, fstests, etc) and saying it should work around a
> spurious, unpredictable, undesirable and user-undebuggable kernel
> behaviour is not an acceptible solution here...

Not sure why you both are putting words in my mouth, I've merely been
arguing pros and cons and the impact of this. I even linked the io_uring
addition for ensuring that side will work better once the deferred fput
is sorted out. I didn't like the idea of fixing this through umount, and
even outlined how it could be fixed properly by ensuring we flush
per-task deferred puts on task exit.

Do I think it's a big issue? Not at all, because a) nobody has reported
it until now, and b) it's kind of a stupid case. If we can fix it with
minimal impact, should we? Yep. Particularly as the assumptions stated
in the original commit I referenced were not even valid back then.

-- 
Jens Axboe

