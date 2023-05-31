Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91899718071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjEaMzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 08:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjEaMze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 08:55:34 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 05:54:58 PDT
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92473E42
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 05:54:58 -0700 (PDT)
Message-ID: <05aee65c-949b-20e8-5bcd-b8bbcc055c88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685537667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/wLbEP5pngLR8edcWd7vsDKHEfi97/Ys2rGdOFJfdk=;
        b=dtc+I/H2EPdu3vws5BXo90wW2l0+z66ad4DtoPKAcLdivGzieEGO40EvX12pPT4gWolAja
        dW1zuKb/aD6VPTYOFieSS7yvF7oRauPABs0V2wSYgEuPt2QUdy9A5iKVE4iaSp19P7vUUi
        Ozc0f7SwAPpVb8k+yEQ6+F9BYKBJF6k=
Date:   Wed, 31 May 2023 20:54:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] fs: introduce struct
 super_operations::destroy_super() callback
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-6-qi.zheng@linux.dev>
 <20230531-pikiert-jobaussicht-87bbd3da0de5@brauner>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230531-pikiert-jobaussicht-87bbd3da0de5@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/31 19:19, Christian Brauner wrote:
> On Wed, May 31, 2023 at 09:57:39AM +0000, Qi Zheng wrote:
>> From: Kirill Tkhai <tkhai@ya.ru>
>>
>> The patch introduces a new callback, which will be called
>> asynchronous from delayed work.
>>
>> This will allows to make ::nr_cached_objects() safe
>> to be called on destroying superblock in next patches,
>> and to split unregister_shrinker() into two primitives.
>>
>> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   fs/super.c         | 3 +++
>>   include/linux/fs.h | 1 +
>>   2 files changed, 4 insertions(+)
> 
> Misses updates to
> Documentation/filesystems/locking.rst
> Documentation/filesystems/vfs.rst

Will do.

Thanks,
Qi
