Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2900C34E4BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhC3JuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhC3Jts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:49:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCCC061574;
        Tue, 30 Mar 2021 02:49:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id B13D91F452F3
Subject: Re: [PATCH v5 2/4] fs: unicode: Rename function names from utf8 to
 unicode
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-3-shreeya.patel@collabora.com>
 <YGKEitULkZmMwk3f@gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <b5e09aaf-ed9a-c363-d188-96ca5bb4932c@collabora.com>
Date:   Tue, 30 Mar 2021 15:19:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGKEitULkZmMwk3f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 30/03/21 7:23 am, Eric Biggers wrote:
> On Tue, Mar 30, 2021 at 02:12:38AM +0530, Shreeya Patel wrote:
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions and it is not
>> necessary to carry this large table in the kernel.
>> Goal is to make UTF-8 encoding loadable by converting it into a module
>> and adding a unicode subsystem layer between the filesystems and the
>> utf8 module.
>> This layer will load the module whenever any filesystem that
>> needs unicode is mounted.
>> utf8-core will be converted into this layer file in the future patches,
>> hence rename the function names from utf8 to unicode which will denote the
>> functions as the unicode subsystem layer functions and this will also be
>> the first step towards the transformation of utf8-core file into the
>> unicode subsystem layer file.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>> Changes in v5
>>    - Improve the commit message.
> This didn't really answer my questions about the reason for this renaming.
> Aren't the functions like unicode_casefold() still tied to UTF-8 (as opposed to
> e.g. supporting both UTF-8 and UTF-16)?  Is that something you're trying to
> change?


Currently, layer's functions are still tied to UTF-8 encoding only. But 
in future if we will have UTF-16 support then layer file would have to 
be changed accordingly to support both.
Unicode subsystem layer is a generic layer which connects the 
filesystems and UTF8 module ( and/or UTF16 in future )


>
> - Eric
>
