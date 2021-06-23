Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4663B1D0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 17:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFWPFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 11:05:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWPFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:05:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 188FC21978;
        Wed, 23 Jun 2021 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624460576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obh6DR5mQUaGeW8+twsfq9NZCWFJ7UVHnJN6Unj4B50=;
        b=ru5S6mJesX7ts+46Q0kozXXpii5x5DLinnGzNabivHHrcH9gFwGcUPQRvUVEq/yhzkkglF
        I90n1LgXteRiF5u7ryO0pjdkb4ZinKYai4qdTNZ7xWwEpGKIjyjqXrYWPCt0jqIfrIdO3W
        1xmRm/YFLd07PendD1DugjpShcTGN40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624460576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obh6DR5mQUaGeW8+twsfq9NZCWFJ7UVHnJN6Unj4B50=;
        b=l8OIMDRISqkjUArO6ETApVZUxIJwuG2aFtbHqQWKMw5yNkKwhHKOcTjOQgwPCOFKFoCEPv
        7Lbw5j8BWqw/L1BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 710C411A97;
        Wed, 23 Jun 2021 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624460576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obh6DR5mQUaGeW8+twsfq9NZCWFJ7UVHnJN6Unj4B50=;
        b=ru5S6mJesX7ts+46Q0kozXXpii5x5DLinnGzNabivHHrcH9gFwGcUPQRvUVEq/yhzkkglF
        I90n1LgXteRiF5u7ryO0pjdkb4ZinKYai4qdTNZ7xWwEpGKIjyjqXrYWPCt0jqIfrIdO3W
        1xmRm/YFLd07PendD1DugjpShcTGN40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624460576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obh6DR5mQUaGeW8+twsfq9NZCWFJ7UVHnJN6Unj4B50=;
        b=l8OIMDRISqkjUArO6ETApVZUxIJwuG2aFtbHqQWKMw5yNkKwhHKOcTjOQgwPCOFKFoCEPv
        7Lbw5j8BWqw/L1BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id QDJpGh9N02C/cQAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 23 Jun 2021 15:02:55 +0000
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
 <YNM8T44v5FTViVWM@gardel-login>
 <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
 <YNNBOyUiztf2wxDu@gardel-login>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <adeedcd2-15a7-0655-3b3c-85eec719ed37@suse.de>
Date:   Wed, 23 Jun 2021 17:02:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNNBOyUiztf2wxDu@gardel-login>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/21 4:12 PM, Lennart Poettering wrote:
> On Mi, 23.06.21 16:01, Hannes Reinecke (hare@suse.de) wrote:
> 
>>> Thus: a global instead of local sequence number counter is absolutely
>>> *key* for the problem this is supposed to solve
>>>
>> Well ... except that you'll need to keep track of the numbers (otherwise you
>> wouldn't know if the numbers changed, right?).
>> And if you keep track of the numbers you probably will have to implement an
>> uevent listener to get the events in time.
> 
> Hmm? This is backwards. The goal here is to be able to safely match up
> uevents to specific uses of a block device, given that block device
> names are agressively recycled.
> 
> you imply it was easy to know which device use a uevent belongs
> to. But that's the problem: it is not possible to do so safely. if i
> see a uevent for a block device "loop0" I cannot tell if it was from
> my own use of the device or for some previous user of it.
> 
> And that's what we'd like to see fixed: i.e. we query the block device
> for the seqeno now used and then we can use that to filter the uevents
> and ignore the ones that do not carry the same sequence number as we
> got assigned for our user.
> 

It is notoriously tricky to monitor the intended use-case for kernel 
devices, precisely because we do _not_ attach any additional information 
to it.
I have send a proposal for LSF to implement block-namespaces, the prime 
use-case of which is indeed attaching cgroup/namespace information to 
block devices such that we _can_ match (block) devices to specific contexts.

Which I rather prefer than adding sequence numbers to block devices; 
incidentally you could solve the same problem by _not_ reusing numbers 
aggressively but rather allocate the next free one after the most 
recently allocated one.
Will give you much the same thing without having to burden others with it.

The better alternative here would be to extend the loop ioctl to pass in 
an UUID when allocating the device.
That way you can easily figure out whether the loop device has been 
modified.

But in the end, it's the loop driver and I'm not particular bothered 
with it. I am, though, if you need to touch all drivers just to support 
one particular use-case in one particular device driver.

Incidentally, we don't have this problem in SCSI as we _can_ identify 
devices here. So in the end we couldn't care less on which /dev/sdX 
device it ends up.
And I guess that's what we should attempt for loop devices, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
