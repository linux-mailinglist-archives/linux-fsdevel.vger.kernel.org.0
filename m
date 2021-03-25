Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A90349405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCYO2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 10:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhCYO1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:27:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C33C061760;
        Thu, 25 Mar 2021 07:27:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id CF8F91F4420E
Subject: Re: [RFC PATCH 4/4] docs: tmpfs: Add casefold options
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-5-andrealmeid@collabora.com>
 <ec9ce4a7-30a9-67a1-90ce-e7709f04eb12@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <5561e50b-8f53-7d99-7981-2fbc77c38bde@collabora.com>
Date:   Thu, 25 Mar 2021 11:27:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ec9ce4a7-30a9-67a1-90ce-e7709f04eb12@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Às 18:58 de 23/03/21, Randy Dunlap escreveu:
> Hi--
> 
> On 3/23/21 12:59 PM, André Almeida wrote:
>> Document mounting options to enable casefold support in tmpfs.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>>   Documentation/filesystems/tmpfs.rst | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
>> index 0408c245785e..84c87c309bd7 100644
>> --- a/Documentation/filesystems/tmpfs.rst
>> +++ b/Documentation/filesystems/tmpfs.rst
>> @@ -170,6 +170,32 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
>>   will give you tmpfs instance on /mytmpfs which can allocate 10GB
>>   RAM/SWAP in 10240 inodes and it is only accessible by root.
>>   
>> +tmpfs has the following mounting options for case-insesitive lookups support:
>> +
>> +=========   ==============================================================
>> +casefold    Enable casefold support at this mount point using the given
>> +            argument as enconding. Currently only utf8 encondings are supported.
> 
>                             encoding.                      encodings
> 
>> +cf_strict   Enable strict casefolding at this mouting point (disabled by
> 
>                                                   mount
> 
>> +            default). This means that invalid strings should be reject by the
> 
>                                                                     rejected
> 
>> +            file system.
>> +=========   ==============================================================
>> +
>> +Note that this option doesn't enable casefold by default, one needs to set
> 
>                                                      default; one needs to set the
> 
>> +casefold flag per directory, setting the +F attribute in an empty directory. New
>> +directories within a casefolded one will inherit the flag.
> 
> 

Thanks for the feedback Randy, all changes applied.
