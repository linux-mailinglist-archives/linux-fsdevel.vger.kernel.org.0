Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2814FF36
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgBBVSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 16:18:20 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39405 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbgBBVST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:18:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6B2BA623;
        Sun,  2 Feb 2020 16:18:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 02 Feb 2020 16:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=Y
        YauA2N+/JraUuA6qvvhlo/yFe2Uz2pyn6+LyWyPsP0=; b=adN/3glPJjvyT3H1P
        ilzmCAb00ZYJad6Jq3mushB1VedNSROnB3qTaZiYVpdgxc+R64ZrenhTNF+DTAn0
        s/p+llhSyXuPHPgCks/CSBsA39dt/cLFD2HJLaIurb6VD0lWz8lJTZzIqfBa+9z6
        uLSfRVIKaxmZvHOmILvTG0KeGFtVdGsrH8x3voj4W6KcyeV7SRyWn5k9A5pZDqZ1
        UfmbFsxYsYbdGiO6P12URNioK8q/bWVvCWnqbD+1GWagiIw4vxXTJGPAdFRp8+ze
        pqWfVbifsjEpqDZZIf6F6SWl7FPzQZ4f75+qTW8cX1xf1IdbrkMRkY9zVsGuYwqn
        OTSVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YYauA2N+/JraUuA6qvvhlo/yFe2Uz2pyn6+LyWyPs
        P0=; b=jJfIc1J8522hjifmSosrUYVMCSeAxtqUL9ddm1y3CnVsTVOcrJ2GLwBRe
        arHEMluFUWyf0qmwH+m8+CcFeWh1dYUKX/0qQbeboY/Q0aC+teuz3v01g3aqskOq
        Ul7Acs4yuj+eJch9i2wTddG8GIU4YutWbINvkCiu5i6Sjo68/K0IWqIQXHcpA/w8
        sX0cSg5F5uxWKq+exqZBk6BRctClOL4PVIqhm7gQrbWxolqfqMbqLgBsZsxiJAA3
        z2aFtCb953SpNSZRr1Ztg4AEAb6YlA61lkUg/UiyIM+MIjxgoKT16NwSw02DyqWl
        Rq9TOEGDO8uUDf5bxCyluiFAi0wyA==
X-ME-Sender: <xms:mDw3XkZP1ACP1neRvYMDM7P6dB4SBLT0oBhArLZpcpbaapMp7XMerg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeehgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecukfhppedujeeirddukeelrdeike
    drudekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:mDw3Xv06xScZ7O_KZXO0U8UxoWf4sBi5Pzdx-B8fwz1hcKcaB83e_g>
    <xmx:mDw3Xl2uB8SR6wf3XylQ4fRa8moveeBpyOEO5-JZuRwYfmJmLSvYtg>
    <xmx:mDw3Xk47vBhu47Xi2KcotdmYfZlVxW75DIsNVUg8UZsh42UiweXVIw>
    <xmx:mjw3XnLNmRc_coylCX0YRVWd63_RIb8NFMF7E8p4WJnS366VqVUWAQ>
Received: from [192.168.1.20] (vol21-h02-176-189-68-189.dsl.sta.abo.bbox.fr [176.189.68.189])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA442328005E;
        Sun,  2 Feb 2020 16:18:15 -0500 (EST)
Subject: Re: [PATCH] fuse: fix inode rwsem regression
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>,
        Matthew Wilcox <willy@infradead.org>
References: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
 <668fc86f-4214-f315-9b41-40368ba91022@fastmail.fm>
 <20200202020817.GA14887@cqw-OptiPlex-7050>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
Autocrypt: addr=bernd.schubert@fastmail.fm; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <aafd8abf-832b-6348-7b74-4d65451a1eb6@fastmail.fm>
Date:   Sun, 2 Feb 2020 22:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202020817.GA14887@cqw-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/2/20 3:08 AM, chenqiwu wrote:
> On Sun, Feb 02, 2020 at 12:09:50AM +0100, Bernd Schubert wrote:
>>
>>
>> On 2/1/20 6:49 AM, qiwuchen55@gmail.com wrote:
>>> From: chenqiwu <chenqiwu@xiaomi.com>
>>>
>>> Apparently our current rwsem code doesn't like doing the trylock, then
>>> lock for real scheme.  So change our direct write method to just do the
>>> trylock for the RWF_NOWAIT case.
>>> This seems to fix AIM7 regression in some scalable filesystems upto ~25%
>>> in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")
>>>
>>> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
>>> ---
>>>  fs/fuse/file.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index ce71538..ac16994 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1529,7 +1529,13 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>  	ssize_t res;
>>>  
>>>  	/* Don't allow parallel writes to the same file */
>>> -	inode_lock(inode);
>>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
>>> +		if (!inode_trylock(inode))
>>> +			return -EAGAIN;
>>> +	} else {
>>> +		inode_lock(inode);
>>> +	}
>>> +
>>>  	res = generic_write_checks(iocb, from);
>>>  	if (res > 0) {
>>>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
>>>
>>
>>
>> I would actually like to ask if we can do something about this lock
>> altogether. Replace it with a range lock?  This very lock badly hurts
>> fuse shared file performance and maybe I miss something, but it should
>> be needed only for writes/reads going into the same file?
>>
> I think replacing the internal inode rwsem with a range lock maybe not
> a good idea, because it may cause potential block for different writes/reads
> routes when this range lock is owned by someone. Using internal inode rwsem
> can avoid this range racy.
> 

So your 2nd patch changes to rw-locks and should solve low read
direct-io performance, but single shared file writes is still an issue.
For network file systems it also common to globally enforce fuse
direct-io to reduce/avoid cache coherency issues - the application
typically doesn't ask for that on its own. And that is where this lock
is badly hurting.  Hmm, maybe we should differentiate between
fuse-internal direct-io and application direct-io requests here? Or we
need a range lock,that supports shared readers (I haven't looked at any
of the proposed range lock patches yet (non has landed yet, right?).

Thanks,
Bernd
