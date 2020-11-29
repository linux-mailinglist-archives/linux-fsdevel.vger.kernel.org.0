Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0402C7A65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgK2Rxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Nov 2020 12:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2Rxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Nov 2020 12:53:41 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96972C0613CF;
        Sun, 29 Nov 2020 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=lNgu9uRNWqB+M0CUH3J+/Co9o/FaXY3esWLjyE5cLxc=; b=oP07S+ZMNVqcL4QeqGLJLlGHj5
        8mUp5LmGty73c+/g7wICExPGIQyrYU8OHItItlPaIHwiMG7htw/Z1TZNZA0t7n/+pepgHm/oQCW+I
        pPLw45WdzaFUzBLXMEl6AB9w863ynJEdE6HthP02io48eIYLM18UmD8JvTo/xrZ0rnasIyGfiluYN
        xXlr3IDm22DUWwBZxj6Cz5Xzf0TDW2mgyqUAMba7igFCE7+gIFMqCQvGRcoVOd0YCHSp6z/X3k0aI
        xhgW4KsV6q8p11FOLTx9LXEHe0f7BdFMIsGPmBHt4jmUIzZCk5WYlNPdcU9GO50l43Fl/2752y+X9
        AXFAD6WA==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjQsc-0004wD-EM; Sun, 29 Nov 2020 17:52:58 +0000
Subject: Re: [PATCH] locks: remove trailing semicolon in macro definition
To:     Tom Rix <trix@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201127190707.2844580-1-trix@redhat.com>
 <20201127195323.GZ4327@casper.infradead.org>
 <8e7c0d56-64f3-d0b6-c1cf-9f285c59f169@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d65cd737-61a5-4b31-7f25-e72f0a7f4ec2@infradead.org>
Date:   Sun, 29 Nov 2020 09:52:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8e7c0d56-64f3-d0b6-c1cf-9f285c59f169@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/29/20 9:47 AM, Tom Rix wrote:
> 
> On 11/27/20 11:53 AM, Matthew Wilcox wrote:
>> On Fri, Nov 27, 2020 at 11:07:07AM -0800, trix@redhat.com wrote:
>>> +++ b/fs/fcntl.c
>>> @@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
>>>  	(dst)->l_whence = (src)->l_whence;	\
>>>  	(dst)->l_start = (src)->l_start;	\
>>>  	(dst)->l_len = (src)->l_len;		\
>>> -	(dst)->l_pid = (src)->l_pid;
>>> +	(dst)->l_pid = (src)->l_pid
>> This should be wrapped in a do { } while (0).
>>
>> Look, this warning is clearly great at finding smelly code, but the
>> fixes being generated to shut up the warning are low quality.
>>
> Multiline macros not following the do {} while (0) pattern are likely a larger problem.
> 
> I'll take a look.


Could it become a static inline function instead?
or that might expand its scope too much?

-- 
~Randy

