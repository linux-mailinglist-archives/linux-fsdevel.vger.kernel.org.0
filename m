Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC02364624
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbhDSOcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDSOcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:32:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4889C06174A;
        Mon, 19 Apr 2021 07:31:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so8218984wmf.3;
        Mon, 19 Apr 2021 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BukaGkqzntQMa+c7UOYXuyLPXisdJBi9+eUzsglGXps=;
        b=OrRBCi5shSKBHUKdpnUhHjKa/wnl9rM6aPVliawCymCmBIHfeW28CJJkuCH29sj7e4
         S6hA7BjFCKqlbZhqzWZ/3my9d0OzMoF1ARfV63XALb0Oiuj0DbHg8EVXuTtrwX9rCnDo
         2qFk+iJVROw76nztDAZ4p8DfbzxK9jONKc36l5dUTTPLVHwPa2c8vN+qR7dTIPVIeg6Q
         1fBAU77gXDjcXvIGJxtku4y2/0+8B5GO7Q4KViZkk8N5PkmdstacMQKAm2b12ECO73e4
         SR8aRxXRX0Wl8CgYCiiJ9NcAKwjbDzPvViZdsQZRSpSNHYwhU817Q3OAqm/MTsO8pR2P
         dQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BukaGkqzntQMa+c7UOYXuyLPXisdJBi9+eUzsglGXps=;
        b=doqr48ZoXNfa4oD7sbRZn78PkfxipKrXrVd+F2mViHKcBfFZ86mLaPeCvjkkoNeZPR
         88pdcrV3ziI8LlAfAe44OJDVeHs4Aiv4aqBpKjH8Cr2chbujanQO6S9TkmpNjvWwkqrp
         24jCZEsOxq+OuqPVI604QkIWoHVSkn7fuxi8mYScr2XyBpJ7PHbQgqsxBrqUjIBeThsB
         3C6NueggQZM4fWmdA0CuZ0LC5npZypisBeLBPgMpkKXLowFvZv72EwLd7CBv7NyFA14V
         U51JbFb4sjVLqy3BYM4kl8kkF0HihPbXwdOZdCk6pJDphBEEoAHSVjuCwZkz+DCYRD1a
         VAiw==
X-Gm-Message-State: AOAM5321Z/9ry0M5e0yKDOeFFZFgMX7HHVEDjCNJHbJbyeTsQFHQ1GKG
        LMVcNZlOLH84jPTMxPdlR5k=
X-Google-Smtp-Source: ABdhPJyXzJCtNjiK/RNOQVsENTX2/B34lzG8uvXlRcKqHCUuTavrzJjbLayUoY/kcz51nLnQH0BiPQ==
X-Received: by 2002:a05:600c:4ed1:: with SMTP id g17mr21963702wmq.67.1618842701452;
        Mon, 19 Apr 2021 07:31:41 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id x17sm19334170wmi.46.2021.04.19.07.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 07:31:40 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device support
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <alpine.LRH.2.02.2104190840310.9677@file01.intranet.prod.int.rdu2.redhat.com>
 <BL0PR04MB65147D94E7E30C3E1063A282E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
 <alpine.LRH.2.02.2104190951070.17565@file01.intranet.prod.int.rdu2.redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <896ab66c-525a-749f-bf74-42299e028d77@gmail.com>
Date:   Mon, 19 Apr 2021 16:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2104190951070.17565@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/04/2021 15:55, Mikulas Patocka wrote:
> 
> 
> On Mon, 19 Apr 2021, Damien Le Moal wrote:
> 
>>> I would say that it is incompatible with all dm targets - even the linear 
>>> target is changing the sector number and so it may redirect the write 
>>> outside of the range specified in dm-table and cause corruption.
>>
>> DM remapping of BIO sectors is zone compatible because target entries must be
>> zone aligned. In the case of zone append, the BIO sector always point to the
>> start sector of the target zone. DM sector remapping will remap that to another
>> zone start as all zones are the same size. No issue here. We extensively use
>> dm-linear for various test environment to reduce the size of the device tested
>> (to speed up tests). I am confident there are no problems there.
>>
>>> Instead of complicating device mapper with imperfect support, I would just 
>>> disable REQ_OP_ZONE_APPEND on device mapper at all.
>>
>> That was my initial approach, but for dm-crypt only since other targets that
>> support zoned devices are fine. However, this breaks zoned block device
>> requirement that zone append be supported so that users are presented with a
>> uniform interface for different devices. So while simple to do, disabling zone
>> append is far from ideal.
> 
> So, we could enable it for the linear target and disable for all other 
> targets?
> 
> I talked with Milan about it and he doesn't want to add more bloat to the 
> crypt target. I agree with him.

This is all fine even for dm-crypt IF the tweaking is unique for the sector position
(it can be something just derived from the sector offset in principle).

For FDE, we must never allow writing sectors to different positions with the same
tweak (IV) and key - there are real attacks based on this issue.

So zones can do any recalculation and reshuffling it wants if sector tweak
in dm-crypt is unique.
(Another solution would be to use different keys for different areas, but that
is not possible with dm-crypt or FDE in general, but fs encryption can do that.)

If you want dm-crypt to support zones properly, there is a need for emulation
of the real sector offset - because that is what IV expects now.

And I think such emulation should be in DM core, not in dm-crypt itself, because other
targets can need the same functionality (I guess that dm-integrity journal
has a problem with that already, Mikulas will know more).

For online reencryption we also use multiple targets in the table that dynamically moves
(linear combined with dm-crypt), so dm-crypt must support all commands as
dm-linear to make this work.

I hope I understand the problem correctly; all I want is to so avoid patching
the wrong place (dmcrypt crypto) because that problem will appear elsewhere later.
Also for security it would be nice to not add exceptions to encryption
code - it is always recipe for disaster.

Milan
