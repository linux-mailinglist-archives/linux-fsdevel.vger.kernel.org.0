Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3272F904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbjFNJ0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbjFNJ0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:26:36 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946D1FD4;
        Wed, 14 Jun 2023 02:26:33 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 1EFF9422C4;
        Wed, 14 Jun 2023 05:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1686734788;
        bh=TrwuhYcstPik75UcplGmnA0hgEPNnuFfFZc3d9G7byk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=W3a5lkq5kxpezhv3wFI+XM203PRzZQ1+sZJij4aCENw/bd0T8yGdPVvn9vyxYmAyG
         ek98R3IRPtJ5DB9PBJKc9YGB4YGnKoHBMBxINqgF0hSi8h1fSkwaxIu4oQ27fdXN1e
         GKJrVLaNGB7mdnNeOuvjUeHvYuW78lKCDMGSa19LeC3vIaJ2Rt9+HARWZc6vzp/Nvq
         PAhSFfyhuVFNGMviFWy0/2JMNQbKoFiqhxZYoVtGRg83ICXIOa3u3pp6tLTkjhEupY
         wd6c7d6Z0lg+BZr8c53Qeb+7vfAjOSN6Mu8JNgov83tEnAErmNgyP8TXY++Oh6lwU8
         USTS0e2ROpbBA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 14 Jun
 2023 11:26:26 +0200
Message-ID: <733f591e-0e8f-8668-8298-ddb11a74df81@veeam.com>
Date:   Wed, 14 Jun 2023 11:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <snitzer@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dchinner@redhat.com>, <willy@infradead.org>, <dlemoal@kernel.org>,
        <linux@weissschuh.net>, <jack@suse.cz>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <ZIjsywOtHM5nIhSr@dread.disaster.area> <ZIldkb1pwhNsSlfl@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <ZIldkb1pwhNsSlfl@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D7063
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/14/23 08:26, Christoph Hellwig wrote:
> Subject:
> Re: [PATCH v5 04/11] blksnap: header file of the module interface
> From:
> Christoph Hellwig <hch@infradead.org>
> Date:
> 6/14/23, 08:26
> 
> To:
> Dave Chinner <david@fromorbit.com>
> CC:
> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
> 
> 
> On Wed, Jun 14, 2023 at 08:25:15AM +1000, Dave Chinner wrote:
>>> + * Return: 0 if succeeded, negative errno otherwise.
>>> + */
>>> +#define IOCTL_BLKSNAP_SNAPSHOT_APPEND_STORAGE					\
>>> +	_IOW(BLKSNAP, blksnap_ioctl_snapshot_append_storage,			\
>>> +	     struct blksnap_snapshot_append_storage)
>> That's an API I'm extremely uncomfortable with. We've learnt the
>> lesson *many times* that userspace physical mappings of underlying
>> file storage are unreliable.
>>
>> i.e.  This is reliant on userspace telling the kernel the physical
>> mapping of the filesystem file to block device LBA space and then
>> providing a guarantee (somehow) that the mapping will always remain
>> unchanged. i.e. It's reliant on passing FIEMAP data from the
>> filesystem to userspace and then back into the kernel without it
>> becoming stale and somehow providing a guarantee that nothing (not
>> even the filesystem doing internal garbage collection) will change
>> it.
> Hmm, I never thought of this API as used on files that somewhere
> had a logical to physical mapping applied to them.
> 
> Sergey, is that the indtended use case?  If so we really should
> be going through the file system using direct I/O.
> 

Hi!
Thank you, Dave, for such a detailed comment. 
Yes, everything is really as you described.

This code worked quite successfully for the veeamsnap module, on the
basis of which blksnap was created. Indeed, such an allocation of an
area on a block device using a file does not look safe.

We've already discussed this with Donald Buczek <buczek@molgen.mpg.de>.
Link: https://github.com/veeam/blksnap/issues/57#issuecomment-1576569075
And I have planned work on moving to a more secure ioctl in the future.
Link: https://github.com/veeam/blksnap/issues/61

Now, thanks to Dave, it becomes clear to me how to solve this problem best.
swapfile is a good example of how to do it right.

Fixing this vulnerability will entail transferring the algorithm for
allocating the difference storage from the user-space to the blksnap code.
The changes are quite significant. The UAPI will be changed.

So I agree that the blksnap module is not good enough for upstream yet.
