Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4334615CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbhK2NKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 08:10:09 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42404 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377554AbhK2NIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:08:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uyjobts_1638191085;
Received: from 30.240.100.124(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Uyjobts_1638191085)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Nov 2021 21:04:46 +0800
Message-ID: <138d5b8d-e189-4203-9bd0-c51f05f97a06@linux.alibaba.com>
Date:   Mon, 29 Nov 2021 21:04:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] fs: Eliminate compilation warnings for misc
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
 <YZPoD0SV8F/QfE1c@casper.infradead.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YZPoD0SV8F/QfE1c@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 11/17/21 1:19 AM, Matthew Wilcox wrote:
> On Tue, Nov 16, 2021 at 04:06:11PM +0800, Tianjia Zhang wrote:
>> Eliminate the following clang compilation warnings by adding or
>> fixing function comment:
> 
> These warnings have nothing to do with clang.  They're produced by
> scripts/kernel-doc:
> 
>                  if (show_warnings($type, $declaration_name) && $param !~ /\./) {
>                          print STDERR
>                                "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
>                          ++$warnings;
>                  }
> 
> They show up in any W=1 build (which tells you that people are not
> checking their patches with W=1)
> 

Yes, there will be this warning when compiling with W=1.

>> +++ b/fs/file.c
>> @@ -645,7 +645,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
>>   
>>   /**
>>    * last_fd - return last valid index into fd table
>> - * @cur_fds: files struct
>> + * @fdt: fdtable struct
> 
> I don't think the word 'struct' there really conveys any meaning.
> 
I think this is already a primitive, or is there any better suggestion?

Kind regards,
Tianjia
