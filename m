Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5780F42490F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 23:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbhJFVkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJFVkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:40:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127CC061746;
        Wed,  6 Oct 2021 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=tg4X4L3elpkm4nMQLNG1D3VF06qVZxJG1TCyclH2NOk=; b=2jaMrD+/+75vd+kikRHG/lPo9x
        BrwIi/WPCWC7/y41ffxfp4dFhq8MrSDv1nBtgl6xbufI48jUQjxM6jF4cI5oTvpoKpLlrF2m8hfW+
        V5jFZ+HG+BaO8bIkTahPJ67/LeGZcl/DkaGgZv+dEmbHSxjPIVp6j+3ltrky3jpNxVrepxcMjMTiL
        cTLopmD/lfqKeVXqyi96sKeDXI7+OsD9mpSV3ScwZ12V+o0QdPbkuycORRsKfY6H4p2HDdwdNAR/E
        EEx4vOTFF9PBCGAkKCfxczs/w5SHLQnqpyz7wjDd73xQLl1oNTMKdEph6YT9FCVte184GlZl55MeO
        ws9digkA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYEcS-00FcJk-MV; Wed, 06 Oct 2021 21:38:33 +0000
Subject: Re: [PATCH v7 1/5] d_path: fix Kernel doc validator complaints
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210715011407.7449-2-justin.he@arm.com>
 <YPAPIsGkom68R1WR@smile.fi.intel.com>
 <92c8b22e-613e-7e8d-8cf9-b995494cf3f3@infradead.org>
Message-ID: <9bb23730-3c1e-4144-2955-99dccacf010f@infradead.org>
Date:   Wed, 6 Oct 2021 14:38:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <92c8b22e-613e-7e8d-8cf9-b995494cf3f3@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/21 3:57 PM, Randy Dunlap wrote:
> On 7/15/21 3:34 AM, Andy Shevchenko wrote:
>> On Thu, Jul 15, 2021 at 09:14:03AM +0800, Jia He wrote:
>>> Kernel doc validator complains:
>>>    Function parameter or member 'p' not described in 'prepend_name'
>>>    Excess function parameter 'buffer' description in 'prepend_name'
>>
>> Yup!
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Can we get someone to merge this, please?

Ho hum.  Justin, please resubmit your patch with Andy's Reviewed-by:
and my Acked-by:.  Send it to Andrew Morton and ask him to merge it.

Thanks.


(cf. https://lore.kernel.org/all/20210628014613.11296-1-rdunlap@infradead.org/
from 2021-06-27)

>>> Fixes: ad08ae586586 ("d_path: introduce struct prepend_buffer")
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: Jia He <justin.he@arm.com>
>>> ---
>>>   fs/d_path.c | 8 +++-----
>>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/d_path.c b/fs/d_path.c
>>> index 23a53f7b5c71..4eb31f86ca88 100644
>>> --- a/fs/d_path.c
>>> +++ b/fs/d_path.c
>>> @@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const char *str, int namelen)
>>>   /**
>>>    * prepend_name - prepend a pathname in front of current buffer pointer
>>> - * @buffer: buffer pointer
>>> - * @buflen: allocated length of the buffer
>>> - * @name:   name string and length qstr structure
>>> + * @p: prepend buffer which contains buffer pointer and allocated length
>>> + * @name: name string and length qstr structure
>>>    *
>>>    * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
>>>    * make sure that either the old or the new name pointer and length are
>>> @@ -108,8 +107,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>>>    * prepend_path - Prepend path string to a buffer
>>>    * @path: the dentry/vfsmount to report
>>>    * @root: root vfsmnt/dentry
>>> - * @buffer: pointer to the end of the buffer
>>> - * @buflen: pointer to buffer length
>>> + * @p: prepend buffer which contains buffer pointer and allocated length
>>>    *
>>>    * The function will first try to write out the pathname without taking any
>>>    * lock other than the RCU read lock to make sure that dentries won't go away.
>>> -- 
> 
> 


-- 
~Randy
