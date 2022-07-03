Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04956474B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiGCMpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCMps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 08:45:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11274E2F
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 05:45:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f85so2829637pfa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1zTTCbaZiy4t3xiCt8tiL8N2DzYy/9mYQpvLnJQEdMI=;
        b=AhyB1VaMCrkl4aKrgO+rqswiofNhl3MTHWL4W5NQD67uUU5Mo9pQGc4IOCo7zaP8px
         IzIXdMIlZoB61bWab6iv4Nuh7dcMTJqlB3QVEMfxcCNgCW1vXraMGCKDufEkqeFeBo8u
         S/z4QzbSVyeyVRD4MtOJq8yUPIMVTyvCkaqre38YWRn81gpEMlgFWtj7tb5j4kxlLa21
         JOxP69XIrNR+mbrNL/s5Tq6GAXAn+p8dald6VALb12FLR4Oyv0TXm/NZhGMJlUlN2kq0
         ngmL57amAaH4bpeJAdmcFJUmOJ2hyA2vZDRZXcEDvwY0bBs1AMxmmeO9zVLjfVQ4coDR
         KUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1zTTCbaZiy4t3xiCt8tiL8N2DzYy/9mYQpvLnJQEdMI=;
        b=vmZHiwERhiap56eL5Oevjdf+DwCaToZgO8cDcGWCxmKzcOa0r+vJzGzVhaIbXSLpHH
         8o7QhpVDRNLNzzC+YPO0KAh7rfZbhr6Ret5SA7MCNvm7Ez31fvp3dc9dr4HD4bJ8SXOp
         r8uLSnS93AhBce8V1R4e1khBOO7WDdovkZPntb4YGHzvCTsSGcO/4YleSHHIItuWHb1L
         /N3C3JeK6vIL13Hdy2H976ykjU5P8Q42dOn2aB5jiiMsicrWemR4z3dLjuNtwJfTC33J
         72xF+cKtchZDL/1DM6vfTNKjqxjZdnlrdv62+oQHzixebGh2VgdJnvNvfnT9sJd1OqKG
         iqNw==
X-Gm-Message-State: AJIora/4aupA/y/bDwl5wg5YG4xNCtYCRRLoe27KSO2Bi921dnWeCh8L
        GCncGLfcJep6FklA0Q5Yk3qCVyCJIXHNhQ==
X-Google-Smtp-Source: AGRyM1u8WfHSYgcVllj0ksl/aoX6LIaOgNV8FCdymGnSe09Y1CliKIVq/ajvsOiJAiPgIaQkfaNY3A==
X-Received: by 2002:a05:6a00:4194:b0:527:f9a4:73b7 with SMTP id ca20-20020a056a00419400b00527f9a473b7mr23346482pfb.61.1656852346463;
        Sun, 03 Jul 2022 05:45:46 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a1d4d00b001e87bd6f6c2sm7751233pju.50.2022.07.03.05.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 05:45:45 -0700 (PDT)
Message-ID: <3e042646-7c3b-ac06-d847-74b3df77fb62@kernel.dk>
Date:   Sun, 3 Jul 2022 06:45:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fs: allow inode time modification with IOCB_NOWAIT
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stefan Roesch <shr@fb.com>
References: <39f8b446-dce3-373f-eb86-e3333b31122c@kernel.dk>
 <Yr/gFLRLBE76enwG@infradead.org>
 <5cfdd462-d21b-cb62-3ad3-3ecd8cbc0a31@kernel.dk>
 <20220703000648.GA3237952@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220703000648.GA3237952@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/2/22 6:06 PM, Dave Chinner wrote:
> On Sat, Jul 02, 2022 at 09:45:23AM -0600, Jens Axboe wrote:
>> On 7/2/22 12:05 AM, Christoph Hellwig wrote:
>>> On Fri, Jul 01, 2022 at 02:09:32PM -0600, Jens Axboe wrote:
>>>> generic/471 complains because it expects any write done with RWF_NOWAIT
>>>> to succeed as long as the blocks for the write are already instantiated.
>>>> This isn't necessarily a correct assumption, as there are other conditions
>>>> that can cause an RWF_NOWAIT write to fail with -EAGAIN even if the range
>>>> is already there.
>>>>
>>>> Since the risk of blocking off this path is minor, just allow inode
>>>> time updates with IOCB_NOWAIT set. Then we can later decide if we should
>>>> catch this further down the stack.
>>>
>>> I think this is broken.  Please just drop the test, the non-blocking
>>> behavior here makes a lot of sense.  At least for XFS, the update
>>> will end up allocating and commit a transaction which involves memory
>>> allocation, a blocking lock and possibly waiting for lock space.
>>
>> I'm fine with that, I've made my opinions on that test case clear in
>> previous emails. I'll drop the patch for now.
>>
>> I will say though that even in low memory testing, I never saw XFS block
>> off the inode time update. So at least we have room for future
>> improvements here, it's wasteful to return -EAGAIN here when the vast
>> majority of time updates don't end up blocking.
> 
> It's not low memory testing that you should be concerned about -
> it's when the journal runs out of space that you'll get long,
> unbound latencies waiting for timestamp updates. Waiting for journal
> space to become available could, in the worst case, entail waiting
> for tens of thousands of small random metadata IOs to be submitted
> and completed....

Right, I know it's not a specifically targeted test. But testing
blocking on a new journal space would certainly be interesting in
itself, if someone where to make xfs_vn_update_time() honor IOCB_NOWAIT
for that.

More realistic is probably just checking SB_LAZYTIME and allowing
IOCB_NOWAIT for that.

>> One issue there too is that, by default, XFS uses a high granularity
>> threshold for when the time should be updated, making the problem worse.
> 
> That's not an XFS issue - we're just following the VFS rules for
> when mtime needs to be changed. If you want to avoid frequent
> transactional (on-disk) mtime updates, then use the lazytime mount
> option to limit on-disk mtime updates to once per day.

Seems like that would be a better default (for anyone, not just XFS),
but that's more likely a bigger can of worms I don't have any interest
in opening :-)

-- 
Jens Axboe

