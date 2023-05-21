Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49A70AF15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjEUQt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEUQpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 12:45:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02981A6;
        Sun, 21 May 2023 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=uC6jGaJJ2VqX3k0LhlidsVnf1lRAVscSt3lB+D38MlU=; b=t8vnJtxwvF7/n7siRxuCD1uvNR
        LQLR0Ofki0+/NbtT3HG+2+8oRIK9TQhEDuncmsFE/zbJ91B9FRYIyYSH8rRIkU+rCt0s6fMPR9A7w
        aazmDf58nwcBzFFUmNoPGg1hXl0u6gmt1pkhPk9oX9At77N4LMSgecJP1tDAnY/8cRPDbjRwXh9Qe
        l3ClBIWk+Cs9JAZKzUQQ9CpVNQvtlXCYLkL1xcUk+2kDmrlesrY77yULQMEV8i44Fw84Ef7WNUT+J
        xMpV+YfgvX4EX/hOKs+FjtR4zZn/ckQtMvdoww9KrfV0sn2Wu2VIa2fFJwkx3g5WVY9IX8ITZKQYM
        H8AoHrZA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0m9P-004CJ6-1M;
        Sun, 21 May 2023 16:43:19 +0000
Message-ID: <45792779-dab2-ae63-470b-3c24ab02e1ca@infradead.org>
Date:   Sun, 21 May 2023 09:43:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net,
        jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
References: <20230518144037.3149361-1-mcgrof@kernel.org>
 <ZGdBO6bmbj3sLlzp@debian.me>
 <731a3061-973c-a4ad-2fe5-7981c6c1279b@infradead.org>
 <ZGgFbmdCrlXtNFYS@dread.disaster.area>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZGgFbmdCrlXtNFYS@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 5/19/23 16:25, Dave Chinner wrote:
> On Fri, May 19, 2023 at 08:13:50AM -0700, Randy Dunlap wrote:
>>
>>
>> On 5/19/23 02:28, Bagas Sanjaya wrote:
>>>> +/**
>>>> + * DOC:  Flags reported by the file system from iomap_begin
>>>>   *
>>>> - * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
>>>> - * zeroing for areas that no data is copied to.
>>>> + * * IOMAP_F_NEW: indicates that the blocks have been newly allocated and need
>>>> + *	zeroing for areas that no data is copied to.
>>>>   *
>>>> - * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
>>>> - * written data and requires fdatasync to commit them to persistent storage.
>>>> - * This needs to take into account metadata changes that *may* be made at IO
>>>> - * completion, such as file size updates from direct IO.
>>>> + * * IOMAP_F_DIRTY: indicates the inode has uncommitted metadata needed to access
>>>> + *	written data and requires fdatasync to commit them to persistent storage.
>>>> + *	This needs to take into account metadata changes that *may* be made at IO
>>>> + *	completion, such as file size updates from direct IO.
>>>>   *
>>>> - * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
>>>> - * unshared as part a write.
>>>> + * * IOMAP_F_SHARED: indicates that the blocks are shared, and will need to be
>>>> + *	unshared as part a write.
>>>>   *
>>>> - * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
>>>> - * mappings.
>>>> + * * IOMAP_F_MERGED: indicates that the iomap contains the merge of multiple block
>>>> + *	mappings.
>>>>   *
>>>> - * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
>>>> - * buffer heads for this mapping.
>>>> + * * IOMAP_F_BUFFER_HEAD: indicates that the file system requires the use of
>>>> + *	buffer heads for this mapping.
>>>>   *
>>>> - * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
>>>> - * rather than a file data extent.
>>>> + * * IOMAP_F_XATTR: indicates that the iomap is for an extended attribute extent
>>>> + *	rather than a file data extent.
>>>>   */
>>> Why don't use kernel-doc comments to describe flags?
>>>
>>
>> Because kernel-doc handles functions, structs, unions, and enums.
>> Not defines.
> 
> So perhaps that should be fixed first?
> 
> I seriously dislike the implication here that we should accept
> poorly/inconsistently written comments and code just to work around
> deficiencies in documentation tooling.
> 
> Either modify the code to work cleanly and consistently with the
> tooling (e.g. change the code to use enums rather than #defines), or
> fix the tools that don't work with macro definitions in a way that
> matches the existing code documentation standards.
> 
> Forcing developers, reviewers and maintainers to understand, accept
> and then maintain inconsistent crap in the code just because some
> tool they never use is deficient is pretty much my definition of an
> unacceptible engineering process.

I started looking into this. It looks like Mauro added more support
to scripts/kernel-doc for typedefs and macros while I wasn't looking.
I don't know how well it works, but it's not clear to me how we
would want this to look.

For example, take the first set of defines from <linux/iomap.h> that
Luis modified:

/*
 * Types of block ranges for iomap mappings:
 */
#define IOMAP_HOLE	0	/* no blocks allocated, need allocation */
#define IOMAP_DELALLOC	1	/* delayed allocation blocks */
#define IOMAP_MAPPED	2	/* blocks allocated at @addr */
#define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
#define IOMAP_INLINE	4	/* data inline in the inode */

and Luis changed that to:

/**
 * DOC: iomap block ranges types
 *
 * * IOMAP_HOLE		- no blocks allocated, need allocation
 * * IOMAP_DELALLOC	- delayed allocation blocks
 * * IOMAP_MAPPED	- blocks allocated at @addr
 * * IOMAP_UNWRITTEN	- blocks allocated at @addr in unwritten state
 * * IOMAP_INLINE	- data inline in the inode
 */


How would we want that to look? How would we express it in kernel-doc
format?  Currently it would have to be one macro at a time I think.

/*
 * Types of block ranges for iomap mappings:
 */
/**
 * IOMAP_HOLE - no blocks allocated, need allocation
 */
#define IOMAP_HOLE	0
/**
 * IOMAP_DELALLOC - delayed allocation blocks
 */
#define IOMAP_DELALLOC	1
/**
 * IOMAP_MAPPED - blocks allocated at @addr
 */
#define IOMAP_MAPPED	2
/**
 * IOMAP_UNWRITTEN - blocks allocated at @addr in unwritten state
 */
#define IOMAP_UNWRITTEN	3
/**
 * IOMAP_INLINE - data inline in the inode
 */
#define IOMAP_INLINE	4

That's ugly to my eyes. And it doesn't collect the set of macros
together in any manner.
The modification that Luis made looks pretty good to me ATM.

-- 
~Randy
