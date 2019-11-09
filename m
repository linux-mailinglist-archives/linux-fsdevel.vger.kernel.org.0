Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79106F6130
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 20:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKITfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Nov 2019 14:35:00 -0500
Received: from mx01-fr.bfs.de ([193.174.231.67]:53442 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfKITe7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:34:59 -0500
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 10EE720341;
        Sat,  9 Nov 2019 20:34:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1573328092; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SudR88lkF+lKSGJMK8+RxHhCApBdq5YQs6jZRSc0iw=;
        b=SdkRUkSagrNMTjlf2lNoy4psNiZfyF+MeMTvYgob7vd96q5DqUIobqQL3gg778mGMVTAPH
        TPFmDTheiHgZR/32jrEoziySqCn/Rb+9LAnZa6keObsD8+CW6n99rUa50DqQc9bRkvzbg8
        +NX+vskYA3yVHhOW0hqigSOa1ET542P2mzIaGoJXLA1veXfCZitg7+SKhbI5qVBjd3QpoM
        O3nwxgPeY5iLM9sygre3yzrqnGKKqP6U16pJ9FTPyoWfmBZMjG++mdOwBsUPtpZf32XBZ+
        SMgc/HUYegliti2K4iu4P2KrUftQ1Fn5twmczL4y4kVWRs/netouVn4GcTOegQ==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 963F8BEEBD;
        Sat,  9 Nov 2019 20:34:51 +0100 (CET)
Message-ID: <5DC714DB.9060007@bfs.de>
Date:   Sat, 09 Nov 2019 20:34:51 +0100
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     linux-man@vger.kernel.org, darrick.wong@oracle.com,
        dhowells@redhat.com, jaegeuk@kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, victorhsieh@google.com
Subject: Re: [man-pages RFC PATCH] statx.2: document STATX_ATTR_VERITY
References: <20191107014420.GD15212@magnolia> <20191107220248.32025-1-ebiggers@kernel.org> <5DC525E8.4060705@bfs.de> <20191108193557.GA12997@gmail.com>
In-Reply-To: <20191108193557.GA12997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.60
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-1.60 / 7.00];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         TO_DN_NONE(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.998,0];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 08.11.2019 20:35, schrieb Eric Biggers:
> On Fri, Nov 08, 2019 at 09:23:04AM +0100, walter harms wrote:
>>
>>
>> Am 07.11.2019 23:02, schrieb Eric Biggers:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> Document the verity attribute for statx().
>>>
>>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>>> ---
>>>  man2/statx.2 | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> RFC since the kernel patches are currently under review.
>>> The kernel patches can be found here:
>>> https://lkml.kernel.org/linux-fscrypt/20191029204141.145309-1-ebiggers@kernel.org/T/#u
>>>
>>> diff --git a/man2/statx.2 b/man2/statx.2
>>> index d2f1b07b8..713bd1260 100644
>>> --- a/man2/statx.2
>>> +++ b/man2/statx.2
>>> @@ -461,6 +461,10 @@ See
>>>  .TP
>>>  .B STATX_ATTR_ENCRYPTED
>>>  A key is required for the file to be encrypted by the filesystem.
>>> +.TP
>>> +.B STATX_ATTR_VERITY
>>> +The file has fs-verity enabled.  It cannot be written to, and all reads from it
>>> +will be verified against a Merkle tree.
>>
>> Using "Merkle tree" opens a can of worm and what will happen when the methode will change ?
>> Does it matter at all ? i would suggest "filesystem" here.
>>
> 
> Fundamentally, fs-verity guarantees that all data read is verified against a
> cryptographic hash that covers the entire file.  I think it will be helpful to
> convey that here, e.g. to avoid confusion with non-cryptographic, individual
> block checksums supported by filesystems like btrfs and zfs.
> 
> Now, the only sane way to implement this model is with a Merkle tree, and this
> is part of the fs-verity UAPI (via the file hash), so that's where I'm coming
> from here.  Perhaps the phrase "Merkle tree" could be interpreted too strictly,
> though, so it would be better to emphasize the more abstract model.  How about
> the following?:
> 
> 	The file has fs-verity enabled.  It cannot be written to, and all reads
> 	from it will be verified against a cryptographic hash that covers the
> 	entire file, e.g. via a Merkle tree.
> 

"feels" better,. but from a programmers perspective it is important at what level
this is actually done. To see my point look at the line before.
"encrypted by the filesystem" mean i have to read the documentation of the fs first
so if encryption is supported at all. Or do i think to complicated ?

jm2c,
re
 wh

