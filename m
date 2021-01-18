Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD842FA808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436703AbhARRyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436729AbhARRxz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:53:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E27D422227;
        Mon, 18 Jan 2021 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610992393;
        bh=2BUVn/G7ZLhzQ7BKdANSYLDJE9+tWZ93amHRzaBmVy4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mS0liz8ZtG5Own/099bZ5X2A2wNMH5QZuZxd+Fmu7bCe+6hkLbY1Ayn1YmyPhqA05
         N2C2CJ4Pqck6/pkECVwQ9XOj49W06S3PF0Bg9B9n81vq84DEwgK6YKDn2saDAkGDFn
         x9tA9f/NS+c+yICAaSokw0nB4iNJW4IroYHqT4CyaFyV/T4Mq/0AI8j9aCszK4+/6g
         x/Osw1OAhwbHLBsJfDCrt+oj3OCnqi7u0+SYVw69PQ+2bUSRLT3PDe+Bl4MJ0s6/7h
         /2YQvHO558YN6bkPMUW0i9mSZvBtVDGEJhs1OWfmTAru+QIxBn1Um+zMgak1pJJmPn
         E8r4pTTfHyF+Q==
Subject: Re: [PATCH 1/2] [v2] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for
 unhashed addresses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-mm <linux-mm@kvack.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210116220950.47078-2-timur@kernel.org>
 <CAHp75Vdk6y8dGNJOswZwfOeva_sqVcw-f=yYgf_rptjHXxfZvw@mail.gmail.com>
 <b39866a4-19cd-879b-1f3e-44126caf9193@kernel.org>
 <20210118171411.GG4077@smile.fi.intel.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <ac04b231-863a-fa7c-08d7-563620d40c29@kernel.org>
Date:   Mon, 18 Jan 2021 11:53:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118171411.GG4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/18/21 11:14 AM, Andy Shevchenko wrote:
> But isn't it good to expose those issues (and fix them)?

I suppose.

>>> Perhaps even add _ADDRESS to DUMP_PREFIX_UNHASHED, but this maybe too
>> long.
>>
>> I think DUMP_PREFIX_ADDRESS_UNHASHED is too long.
> What about introducing new two like these:
> 
> 	DUMP_PREFIX_OFFSET,
> 	DUMP_PREFIX_ADDRESS,
> 	DUMP_PREFIX_ADDR_UNHASHED,
> 	DUMP_PREFIX_ADDR_HASHED,

I think we're approaching bike-shedding.  DUMP_PREFIX_ADDR_HASHED and 
DUMP_PREFIX_ADDRESS are the same thing.

I don't want people to have to move from DUMP_PREFIX_ADDRESS to some 
other enum for no change in functionality.  I'm willing to rearrange the 
code so that it's enumerated more consistently, but I don't think 
there's anything wrong with DUMP_PREFIX_UNHASHED.  It's succinct and clear.
