Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B62EC729
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 00:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbhAFX73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 18:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbhAFX72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:59:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBFC06136D
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 15:58:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n3so3185847pjm.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nHM/zNarT82wu+x4lgAdGC2mHx8Guijmtu+f0YBziZs=;
        b=NA3F+XKmnhNi6kzCESfIdsxKS2uZOsStA6v3UFprwRKw/OhFhOWV573G2OwOoRXJ9G
         jpkX1PlTe24W+T6jmj/B9TdYvsqrmput3qZCO1iiRFiYVl8Nq5JykFYmHdH7fIBlGNO9
         CjocitqQhG0jlGmIOTyGy0VGw5YZXa0E2JaYi54EB7YUp+23q3wIVe/ioL3JnNDIXwMW
         0tLRdb8hjdQgj4wze3oBgV1PFShLjU29t90MrOXd5ZFilZTglcaLd7kxppWvJXysCH8b
         CB9pxhKFB7fm4Sue3R5jjV3cX9ZHnG2ftbIES6aCsKS/kx9wrVNWV088nQ8W8BXgVKsT
         hGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nHM/zNarT82wu+x4lgAdGC2mHx8Guijmtu+f0YBziZs=;
        b=blal6seS9AcTyyGS64MJ1TTX3gxlik5hZYqbIkJbDJ8Mc+sBsfeew7jIYVvdK1fXPU
         pk/AB1bXUEdZvvg0c/UrQaA33VVv4WgzRy+1jKX8KCkxBtmMTU0Qjr5zyFnLFeHCl2TS
         xNr8XWdfcfbJkS99oTHGbgAqypBF1MJ3NnusHlqllb75rcG4MWslxUzzhGM/OuXFd+2U
         xEpw86LhqHJpVPY6Yx+hIQVUOFuJOA8su7yIQQTybAELUGdjpRB9fCNN2Q3rRIHNhdYG
         ZAhhfd3OZwqjIAjfqm/ELAcwC+eNVvl4IzGVXiHjBAioi4C7Qb5SKpKFPYROQJvWJsR+
         hWWw==
X-Gm-Message-State: AOAM5323kvVJfeddRbz9qpPdE2xupyI4VK0HqjaMRDnys8FIGAOMpmun
        h8Jk1WkO5qQRZaL8wkTeImp3Vg==
X-Google-Smtp-Source: ABdhPJwv5izWk5XM30g9rPSPMdovHLcTpT0DO/uurwnBAYjc/lVBVQTLqZutGbJkbfaM5c98RBK3cQ==
X-Received: by 2002:a17:90a:1706:: with SMTP id z6mr1080632pjd.0.1609977526924;
        Wed, 06 Jan 2021 15:58:46 -0800 (PST)
Received: from [192.168.10.153] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id d6sm3384801pfo.199.2021.01.06.15.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 15:58:46 -0800 (PST)
Message-ID: <5e6716a6-0314-8360-4fb6-5c959022a24c@ozlabs.ru>
Date:   Thu, 7 Jan 2021 10:58:39 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
Subject: Re: [RFC PATCH kernel] block: initialize block_device::bd_bdi for
 bdev_cache
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210106092900.26595-1-aik@ozlabs.ru>
 <20210106104106.GA29271@quack2.suse.cz>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210106104106.GA29271@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 06/01/2021 21:41, Jan Kara wrote:
> On Wed 06-01-21 20:29:00, Alexey Kardashevskiy wrote:
>> This is a workaround to fix a null derefence crash:
>>
>> [c00000000b01f840] c00000000b01f880 (unreliable)
>> [c00000000b01f880] c000000000769a3c bdev_evict_inode+0x21c/0x370
>> [c00000000b01f8c0] c00000000070bacc evict+0x11c/0x230
>> [c00000000b01f900] c00000000070c138 iput+0x2a8/0x4a0
>> [c00000000b01f970] c0000000006ff030 dentry_unlink_inode+0x220/0x250
>> [c00000000b01f9b0] c0000000007001c0 __dentry_kill+0x190/0x320
>> [c00000000b01fa00] c000000000701fb8 dput+0x5e8/0x860
>> [c00000000b01fa80] c000000000705848 shrink_dcache_for_umount+0x58/0x100
>> [c00000000b01fb00] c0000000006cf864 generic_shutdown_super+0x54/0x200
>> [c00000000b01fb80] c0000000006cfd48 kill_anon_super+0x38/0x60
>> [c00000000b01fbc0] c0000000006d12cc deactivate_locked_super+0xbc/0x110
>> [c00000000b01fbf0] c0000000006d13bc deactivate_super+0x9c/0xc0
>> [c00000000b01fc20] c00000000071a340 cleanup_mnt+0x1b0/0x250
>> [c00000000b01fc80] c000000000278fa8 task_work_run+0xf8/0x180
>> [c00000000b01fcd0] c00000000002b4ac do_notify_resume+0x4dc/0x5d0
>> [c00000000b01fda0] c00000000004ba0c syscall_exit_prepare+0x28c/0x370
>> [c00000000b01fe10] c00000000000e06c system_call_common+0xfc/0x27c
>> --- Exception: c00 (System Call) at 0000000010034890
>>
>> Is this fixed properly already somewhere? Thanks,
>>
>> Fixes: e6cb53827ed6 ("block: initialize struct block_device in bdev_alloc")
> 
> I don't think it's fixed anywhere and I've seen the syzbot report and I was
> wondering how this can happen when bdev_alloc() initializes bdev->bd_bdi
> and it also wasn't clear to me whether bd_bdi is really the only field that
> is problematic - if we can get to bdev_evict_inode() without going through
> bdev_alloc(), we are probably missing initialization of other fields in
> that place as well...
> 
> But now I've realized that probably the inode is a root inode for bdev
> superblock which is allocated by VFS through new_inode() and thus doesn't
> undergo the initialization in bdev_alloc(). 

yup, this is the case.

> And AFAICT the root inode on
> bdev superblock can get only to bdev_evict_inode() and bdev_free_inode().
> Looking at bdev_evict_inode() the only thing that's used there from struct
> block_device is really bd_bdi. bdev_free_inode() will also access
> bdev->bd_stats and bdev->bd_meta_info. So we need to at least initialize
> these to NULL as well.

These are all NULL.

> IMO the most logical place for all these
> initializations is in bdev_alloc_inode()...


This works. We can also check for NULL where it crashes. But I do not 
know the code to make an informed decision...

> 
> 								Honza
> 
>> ---
>>   fs/block_dev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 3e5b02f6606c..86fdc28d565e 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -792,8 +792,10 @@ static void bdev_free_inode(struct inode *inode)
>>   static void init_once(void *data)
>>   {
>>   	struct bdev_inode *ei = data;
>> +	struct block_device *bdev = &ei->bdev;
>>   
>>   	inode_init_once(&ei->vfs_inode);
>> +	bdev->bd_bdi = &noop_backing_dev_info;
>>   }
>>   
>>   static void bdev_evict_inode(struct inode *inode)
>> -- 
>> 2.17.1
>>

-- 
Alexey
