Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FD4615D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhK2NLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 08:11:32 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34276 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhK2NJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:09:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UylJM6I_1638191170;
Received: from 30.240.100.124(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UylJM6I_1638191170)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Nov 2021 21:06:11 +0800
Message-ID: <e06a86b2-1624-986c-9e97-ffac121dc240@linux.alibaba.com>
Date:   Mon, 29 Nov 2021 21:06:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] fs: Eliminate compilation warnings for misc
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
 <941c9239-3b73-c2ae-83aa-f83d4e587fc8@infradead.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <941c9239-3b73-c2ae-83aa-f83d4e587fc8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

On 11/17/21 7:00 AM, Randy Dunlap wrote:
> On 11/16/21 12:06 AM, Tianjia Zhang wrote:
>> Eliminate the following clang compilation warnings by adding or
>> fixing function comment:
> 
> These are from clang?  They all appear to be from scripts/kernel-doc.
> 
> Can someone please clarify?
> 
> thanks.

Yes, compile with W=1, clang will report this warning.

Kind regards,
Tianjia
