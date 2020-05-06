Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0642E1C7B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEFUse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 16:48:34 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:51906 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgEFUsd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 16:48:33 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2020 16:48:32 EDT
Received: from venice.bhome ([94.37.193.252])
        by smtp-33.iol.local with ESMTPA
        id WQq5jnZY4rZwsWQq5jrngQ; Wed, 06 May 2020 22:40:22 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1588797622; bh=IX1qh9N0qaPPNnvKbUSWchwftr3A1KbhyZgDuoFdl4k=;
        h=From;
        b=uHzki6glcTesfBTggOaV8zwz9bCGPRIq9YgQEBNda4xSv1wiC4iQPrq7kRyg7Rxwp
         ZmFX9WwMzYb2L8yWNEYZTT3dfnNmcVXzxAOBK8FOFi6kv7P6FVRW5EgwYFsI5iB55u
         x+odhpgt6nv8bVeG003QVl0FzdGqFQZszAJZjjBHbRrwc+UbGPKCssxpTkiZaI2X/x
         uEH9Zvbv9W6WW0hoZoYAQAas4R61YwV7t0bDwzvrmFQ9HB2sQXfZjRBgpWo+LHL1Qz
         hQYSEZH26ygH3hazOnXPYyUIuZ8Qc0EfunFwsQQC653ovaokwnlzXFBwddpyc1osoP
         NkZVHO+i3/59w==
X-CNFS-Analysis: v=2.3 cv=ANbu9Azk c=1 sm=1 tr=0
 a=m9MdMCwkAncLgtUozvdZtQ==:117 a=m9MdMCwkAncLgtUozvdZtQ==:17
 a=IkcTkHD0fZMA:10 a=ifkeKN6-E4AdYMXjE3oA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Reply-To: kreijack@inwind.it
Subject: btree [was Re: [PATCH v2 1/2] btrfs: add authentication support]
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d395520c-0763-8551-ec80-9cde9b39c3cd@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <d649407a-7ca4-e9ee-f291-7845c89c622b@libero.it>
Date:   Wed, 6 May 2020 22:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d395520c-0763-8551-ec80-9cde9b39c3cd@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEyxU0b93HMuwtyrsMdQOLz92eh4cOSw8ejnQBVpKesXrlWhKp0yBULJcPNmd7ip9lS5zt4l7p2Dl74Pf6hRox09LF7xypsPul+CZ+qdi3BLxuJi6eR6
 e3OTEm4s/YsrLYN8ixfRodGtPXQ3d5gHSgXWdtU89/wga9Z+WtCM2rqKuMhwOx5izGJfHgYVAM+EExOJFamExbtbK+eJcVK4VAyNPzyaHHD38bXEacJZ9SbX
 /Rs9DHDn5CpIcHoXXNe7l44JTnbT1sBN6T6MwreP560XfAdcw7M6elcDoGUofAhPzx9uYYXHLjGyGX+erbXS39ut+gaiZK47z1lf80Zq8sT/VWlOGmg7LFVM
 H9A91wqUvk/x5czdhv8UCsvX3iY3iValUocqzap7jCMVK78E+5o=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qu,

I will go a bit off topic, because I am interested more in the understanding of the btrees than the topic of this thread
On 5/5/20 11:26 AM, Qu Wenruo wrote:
[...]
> 
> My personal idea on this swap-tree attack is, the first key, generation,
> bytenr protection can prevent such case.
> 
> The protection chain begins from superblock, and ends at the leaf tree
> blocks, as long as superblock is also protected by hmac hash, it should
> be safe.
> 
> 
> Btrfs protects parent-child relationship by:
> - Parent has the pointer (bytenr) of its child
>    The main protection. If attacker wants to swap one tree block, it must
>    change the parent tree block.
>    The parent is either a tree block (parent node), or root item in root
>    tree, or a super block.
>    All protected by hmac csum. Thus attack can only do such attach by
>    knowing the key.
> 
> - Parent has the first key of its child
>    Unlike previous one, this is just an extra check, no extra protection.
>    And root item doesn't contain the first key.

It always true ? When a key is inserted, we update the key of the parent to be equal to the first of the (right) child. However when a key is removed, this should be not mandatory. Is it enough that the parent key is greater (or equal) than the first key of the left node, and lesser than the last of the right node ?

Supposing to have

              10
            /    \
1 2 3 4 5         10 11 12 13

If you remove 10 in the right child node, is it mandatory to updated the '10' in the parent node (to 11) ?


[...]

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
