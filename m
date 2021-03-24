Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB333348313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 21:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhCXUrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhCXUrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:47:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A8AC06174A;
        Wed, 24 Mar 2021 13:47:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 510411F4422D
Subject: Re: [RFC PATCH 4/4] docs: tmpfs: Add casefold options
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, smcv@collabora.com,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-5-andrealmeid@collabora.com>
 <87o8f9bjiw.fsf@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <4058c0b9-d940-f069-8b31-39cd7ae16062@collabora.com>
Date:   Wed, 24 Mar 2021 17:47:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87o8f9bjiw.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

Às 19:19 de 23/03/21, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@collabora.com> writes:
> 
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
>> +cf_strict   Enable strict casefolding at this mouting point (disabled by
>> +            default). This means that invalid strings should be reject by the
>> +            file system.
> 
> strict mode refers to the encoding, not exactly casefold.  Maybe we
> could have a parameter encoding_flags that accepts the flag 'strict'.
> This would make it closer to the ext4 interface.

What are the other enconding flags? Or is this more about having a 
properly extensible interface?

> Alternatively, call this option strict_encoding.
> 

Thanks,
	André
