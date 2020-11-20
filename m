Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A532BB807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 22:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgKTU7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 15:59:03 -0500
Received: from www2.webmail.pair.com ([66.39.3.96]:51740 "EHLO
        www2.webmail.pair.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgKTU7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:59:03 -0500
Received: from rc.webmail.pair.com (localhost [127.0.0.1])
        by www2.webmail.pair.com (Postfix) with ESMTP id 098641C0109;
        Fri, 20 Nov 2020 15:59:02 -0500 (EST)
MIME-Version: 1.0
Date:   Fri, 20 Nov 2020 14:59:02 -0600
From:   "K.R. Foley" <kr@cybsft.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: BUG triggers running lsof
In-Reply-To: <x49im9zn6wb.fsf@segfault.boston.devel.redhat.com>
References: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
 <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
 <x49im9zn6wb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <5310969ec0c67c25ae2eff16f1e904d5@cybsft.com>
X-Sender: kr@cybsft.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org




On 2020-11-20 13:51, Jeff Moyer wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 11/20/20 11:16 AM, K.R. Foley wrote:
>>> I have found an issue that triggers by running lsof. The problem is
>>> reproducible, but not consistently. I have seen this issue occur on
>>> multiple versions of the kernel (5.0.10, 5.2.8 and now 5.4.77). It
>>> looks like it could be a race condition or the file pointer is being
>>> corrupted. Any pointers on how to track this down? What additional
>>> information can I provide?
>> 
>> Hi,
>> 
>> 2 things in general:
>> 
>> a) Can you test with a more recent kernel?
>> 
>> b) Can you reproduce this without loading the proprietary & 
>> out-of-tree
>> kernel modules?  They should never have been loaded after bootup.
>> I.e., don't just unload them -- that could leave something bad behind.
> 
> Heh, the EIP contains part of the name of one of the modules:
> 
>> 
>>> [ 8057.297159] BUG: unable to handle page fault for address: 31376f63
>                                                                 
> ^^^^^^^^
> 
>>> [ 8057.297219] Modules linked in: ITXico7100Module(O)
>                                          ^^^^

Perhaps this is a dumb question, but how could this happen?

> -Jeff

kr
