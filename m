Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE5418CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhIZW7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 18:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZW7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 18:59:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C25C061570;
        Sun, 26 Sep 2021 15:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=BQc1AGKyGp6O8sK4Oijci/bl6DWo+e/7Ej7o6TskIdc=; b=HbipvuqyXma60Nm+c9Qr9vxZpk
        Ya0cyfHlboAYE+Go8QlKwYpY/G08VA4TQPF1CH6OI4O5bCIHe6ijdTnXFtx8D09T/BDxjPh3SXNSs
        9P9KSa0cvQL3FmKWEib3GjdKFm+QFOKhw059joSWY3p/sHalhdGJ8DuWKZWAMUb1FrHeR3+9nKkJU
        Pkh3NiaDsCUdGCXZP51S7TDx4NlFAN+araqQy5RAYJ3qNb+KQRzb4qFEXXcHqmHxOpCAZdAOTmw4V
        M8K8kPkKm628Fd6OJgUb7XTRm0GrFT/9v34Cvkd/eCgY+7yz+p1W7cxaNAX0tXC35iPlKiX5FNieV
        UIcnqeXw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUd5G-001D1U-Hv; Sun, 26 Sep 2021 22:57:22 +0000
Subject: Re: [PATCH v7 1/5] d_path: fix Kernel doc validator complaints
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
        Christoph Hellwig <hch@infradead.org>, nd@arm.com
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210715011407.7449-2-justin.he@arm.com>
 <YPAPIsGkom68R1WR@smile.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92c8b22e-613e-7e8d-8cf9-b995494cf3f3@infradead.org>
Date:   Sun, 26 Sep 2021 15:57:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YPAPIsGkom68R1WR@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 3:34 AM, Andy Shevchenko wrote:
> On Thu, Jul 15, 2021 at 09:14:03AM +0800, Jia He wrote:
>> Kernel doc validator complains:
>>    Function parameter or member 'p' not described in 'prepend_name'
>>    Excess function parameter 'buffer' description in 'prepend_name'
> 
> Yup!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Can we get someone to merge this, please?

>> Fixes: ad08ae586586 ("d_path: introduce struct prepend_buffer")
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Jia He <justin.he@arm.com>
>> ---
>>   fs/d_path.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/d_path.c b/fs/d_path.c
>> index 23a53f7b5c71..4eb31f86ca88 100644
>> --- a/fs/d_path.c
>> +++ b/fs/d_path.c
>> @@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const char *str, int namelen)
>>   
>>   /**
>>    * prepend_name - prepend a pathname in front of current buffer pointer
>> - * @buffer: buffer pointer
>> - * @buflen: allocated length of the buffer
>> - * @name:   name string and length qstr structure
>> + * @p: prepend buffer which contains buffer pointer and allocated length
>> + * @name: name string and length qstr structure
>>    *
>>    * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
>>    * make sure that either the old or the new name pointer and length are
>> @@ -108,8 +107,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>>    * prepend_path - Prepend path string to a buffer
>>    * @path: the dentry/vfsmount to report
>>    * @root: root vfsmnt/dentry
>> - * @buffer: pointer to the end of the buffer
>> - * @buflen: pointer to buffer length
>> + * @p: prepend buffer which contains buffer pointer and allocated length
>>    *
>>    * The function will first try to write out the pathname without taking any
>>    * lock other than the RCU read lock to make sure that dentries won't go away.
>> -- 


-- 
~Randy
