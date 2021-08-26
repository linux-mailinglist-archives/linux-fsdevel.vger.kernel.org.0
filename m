Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CCA3F8213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhHZFcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 01:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhHZFcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 01:32:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BD6C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8Slox0DXtX4G3EzLJYcYPHSokzvNrtEPb8S4JT389+Y=; b=EEPK+FyKWPD1LssqMEg24ruykN
        +LUENU6its3jCmDxeGOG6JCbd3RMljg62Vq8ncpHyJRHKmmAEXtH++P/Xmy9dQGP3sGqw1uspEx3o
        3TBNrQ9m76mC+amGv9Y+J/zwPhqYyraaqp8mHj3ALQK0vWCOGnte4DGSYqYyp2GLbfCr9P3e3T1EL
        X6pCpXOufBepAO+gkofFECoa+1cSKezbdlq8u3HDck7/N21od9kdgY+Bf14Jjoxygu/mlXMPTm2y3
        +xEf+daS2cisNJdI8A7PD3FivfaueMFSaboAMy1lko3oAbLcE6EPIbZO6r+nJtAAXYLlxKoPmx5ef
        ZI3H6V4w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJ7zZ-009DIg-HQ; Thu, 26 Aug 2021 05:31:57 +0000
Subject: Re: [PATCH 1/1] exec: fix typo and grammar mistake in comment
To:     Huang Adrian <adrianhuang0701@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Adrian Huang <ahuang12@lenovo.com>
References: <20210826031451.611-1-adrianhuang0701@gmail.com>
 <eb28d8e8-3e7d-0120-a1a7-6e43b0bb05bb@infradead.org>
 <CAHKZfL1H2LKnOw1EfNA-xri0EPDF-hYwXa1u_39ttoMZHvSOGg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <465a5f46-59e2-9999-9176-77ba63731dd7@infradead.org>
Date:   Wed, 25 Aug 2021 22:31:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHKZfL1H2LKnOw1EfNA-xri0EPDF-hYwXa1u_39ttoMZHvSOGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/25/21 10:25 PM, Huang Adrian wrote:
> On Thu, Aug 26, 2021 at 11:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 8/25/21 8:14 PM, Adrian Huang wrote:
>>> From: Adrian Huang <ahuang12@lenovo.com>
>>>
>>> 1. backwords -> backwards
>>> 2. Remove 'and'
>>
>>     3. correct the possessive form of "process"
>>
>>>
>>> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
>>> ---
>>>    fs/exec.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/exec.c b/fs/exec.c
>>> index 38f63451b928..7178aee0d781 100644
>>> --- a/fs/exec.c
>>> +++ b/fs/exec.c
>>> @@ -533,7 +533,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>>>                if (!valid_arg_len(bprm, len))
>>>                        goto out;
>>>
>>> -             /* We're going to work our way backwords. */
>>
>> That could just be a pun. Maybe Al knows...
> 
> Another comment in line 615 has the same sentence with 'backwards'.
> (https://github.com/torvalds/linux/blob/master/fs/exec.c#L615).
> 
> So, one of them should be corrected.

OK.

>>
>>> +             /* We're going to work our way backwards. */
>>>                pos = bprm->p;
>>>                str += len;
>>>                bprm->p -= len;
>>> @@ -600,7 +600,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>>>    }
>>>
>>>    /*
>>> - * Copy and argument/environment string from the kernel to the processes stack.
>>> + * Copy argument/environment strings from the kernel to the processe's stack.

I think this one should be:
       * Copy an argument/environment string from the kernel to the process's stack.

>> Either process's stack or process' stack. Not what is typed there.
>> I prefer process's, just as this reference does:
>>     https://forum.wordreference.com/threads/process-or-processs.1704502/
> 
> Oh, my bad. I should have deleted the letter 'e'. Thanks for this.
> 
> After Al confirms 'backwords', I'll also change "processes's" to
> "process's" in v2.
> (https://github.com/torvalds/linux/blob/master/fs/exec.c#L507)
> 
>>>     */
>>>    int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>>>    {


-- 
~Randy

