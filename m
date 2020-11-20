Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741B32BB84C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 22:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgKTV2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 16:28:11 -0500
Received: from www2.webmail.pair.com ([66.39.3.96]:50402 "EHLO
        www2.webmail.pair.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgKTV2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:28:10 -0500
Received: from rc.webmail.pair.com (localhost [127.0.0.1])
        by www2.webmail.pair.com (Postfix) with ESMTP id 3283A1C010D;
        Fri, 20 Nov 2020 16:28:09 -0500 (EST)
MIME-Version: 1.0
Date:   Fri, 20 Nov 2020 15:28:09 -0600
From:   "K.R. Foley" <kr@cybsft.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: BUG triggers running lsof
In-Reply-To: <d070f189-d8ee-73e5-5502-6618080e64bc@infradead.org>
References: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
 <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
 <x49im9zn6wb.fsf@segfault.boston.devel.redhat.com>
 <5310969ec0c67c25ae2eff16f1e904d5@cybsft.com>
 <d070f189-d8ee-73e5-5502-6618080e64bc@infradead.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <55e19a5d6a64d24280c3eb82ef7cf183@cybsft.com>
X-Sender: kr@cybsft.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-11-20 15:13, Randy Dunlap wrote:
> On 11/20/20 12:59 PM, K.R. Foley wrote:
>> 
>> 
>> 
>> On 2020-11-20 13:51, Jeff Moyer wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>> 
>>>> On 11/20/20 11:16 AM, K.R. Foley wrote:
>>>>> I have found an issue that triggers by running lsof. The problem is
>>>>> reproducible, but not consistently. I have seen this issue occur on
>>>>> multiple versions of the kernel (5.0.10, 5.2.8 and now 5.4.77). It
>>>>> looks like it could be a race condition or the file pointer is 
>>>>> being
>>>>> corrupted. Any pointers on how to track this down? What additional
>>>>> information can I provide?
>>>> 
>>>> Hi,
>>>> 
>>>> 2 things in general:
>>>> 
>>>> a) Can you test with a more recent kernel?
>>>> 
>>>> b) Can you reproduce this without loading the proprietary & 
>>>> out-of-tree
>>>> kernel modules?  They should never have been loaded after bootup.
>>>> I.e., don't just unload them -- that could leave something bad 
>>>> behind.
>>> 
>>> Heh, the EIP contains part of the name of one of the modules:
>>> 
>>>> 
>>>>> [ 8057.297159] BUG: unable to handle page fault for address: 
>>>>> 31376f63
>>>                                                                 
>>> ^^^^^^^^
> 
> Thanks for noticing that, Jeff.  I should have seen it.
> 
>>>>> [ 8057.297219] Modules linked in: ITXico7100Module(O)
>>>                                          ^^^^
>> 
>> Perhaps this is a dumb question, but how could this happen?
> 
> 
> We don't know what is in that loadable kernel module, so we can't
> give a definitive answer to your question, other than it's buggy.
> Or maybe it was just written for an older kernel version.
> Or a kernel with different build options/settings.

I am starting to look at this now. It was written for an older kernel by 
someone else. Thank you for the tips.

> 
> Have you contacted IT support?
> 
> It would (will) be interesting to see if you can reproduce the problem
> without these modules being loaded...
> I kind of doubt it, but if it does still fail, it will give us 
> something
> to look at.

Knowing a little more now. I doubt it will be reproducible without the 
module.

-- 
Regards,
K.R. Foley
