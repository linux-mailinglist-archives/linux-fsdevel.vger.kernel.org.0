Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76C68764F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBBHSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 02:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjBBHSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:18:02 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2739756;
        Wed,  1 Feb 2023 23:17:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VajqMs._1675322276;
Received: from 30.97.49.35(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VajqMs._1675322276)
          by smtp.aliyun-inc.com;
          Thu, 02 Feb 2023 15:17:57 +0800
Message-ID: <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com>
Date:   Thu, 2 Feb 2023 15:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
 <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
 <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com>
 <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/2 14:37, Amir Goldstein wrote:
> On Wed, Feb 1, 2023 at 1:22 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/2/1 18:01, Gao Xiang wrote:
>>>
>>>
>>> On 2023/2/1 17:46, Alexander Larsson wrote:
>>>
>>> ...
>>>
>>>>>
>>>>>                                     | uncached(ms)| cached(ms)
>>>>> ----------------------------------|-------------|-----------
>>>>> composefs (with digest)           | 326         | 135
>>>>> erofs (w/o -T0)                   | 264         | 172
>>>>> erofs (w/o -T0) + overlayfs       | 651         | 238
>>>>> squashfs (compressed)                | 538         | 211
>>>>> squashfs (compressed) + overlayfs | 968         | 302
>>>>
>>>>
>>>> Clearly erofs with sparse files is the best fs now for the ro-fs +
>>>> overlay case. But still, we can see that the additional cost of the
>>>> overlayfs layer is not negligible.
>>>>
>>>> According to amir this could be helped by a special composefs-like mode
>>>> in overlayfs, but its unclear what performance that would reach, and
>>>> we're then talking net new development that further complicates the
>>>> overlayfs codebase. Its not clear to me which alternative is easier to
>>>> develop/maintain.
>>>>
>>>> Also, the difference between cached and uncached here is less than in
>>>> my tests. Probably because my test image was larger. With the test
>>>> image I use, the results are:
>>>>
>>>>                                     | uncached(ms)| cached(ms)
>>>> ----------------------------------|-------------|-----------
>>>> composefs (with digest)           | 681         | 390
>>>> erofs (w/o -T0) + overlayfs       | 1788        | 532
>>>> squashfs (compressed) + overlayfs | 2547        | 443
>>>>
>>>>
>>>> I gotta say it is weird though that squashfs performed better than
>>>> erofs in the cached case. May be worth looking into. The test data I'm
>>>> using is available here:
>>>
>>> As another wild guess, cached performance is a just vfs-stuff.
>>>
>>> I think the performance difference may be due to ACL (since both
>>> composefs and squashfs don't support ACL).  I already asked Jingbo
>>> to get more "perf data" to analyze this but he's now busy in another
>>> stuff.
>>>
>>> Again, my overall point is quite simple as always, currently
>>> composefs is a read-only filesystem with massive symlink-like files.
>>> It behaves as a subset of all generic read-only filesystems just
>>> for this specific use cases.
>>>
>>> In facts there are many options to improve this (much like Amir
>>> said before):
>>>     1) improve overlayfs, and then it can be used with any local fs;
>>>
>>>     2) enhance erofs to support this (even without on-disk change);
>>>
>>>     3) introduce fs/composefs;
>>>
>>> In addition to option 1), option 2) has many benefits as well, since
>>> your manifest files can save real regular files in addition to composefs
>>> model.
>>
>> (add some words..)
>>
>> My first response at that time (on Slack) was "kindly request
>> Giuseppe to ask in the fsdevel mailing list if this new overlay model
>> and use cases is feasable", if so, I'm much happy to integrate in to
>> EROFS (in a cooperative way) in several ways:
>>
>>    - just use EROFS symlink layout and open such file in a stacked way;
>>
>> or (now)
>>
>>    - just identify overlayfs "trusted.overlay.redirect" in EROFS itself
>>      and open file so such image can be both used for EROFS only and
>>      EROFS + overlayfs.
>>
>> If that happened, then I think the overlayfs "metacopy" option can
>> also be shown by other fs community people later (since I'm not an
>> overlay expert), but I'm not sure why they becomes impossible finally
>> and even not mentioned at all.
>>
>> Or if you guys really don't want to use EROFS for whatever reasons
>> (EROFS is completely open-source, used, contributed by many vendors),
>> you could improve squashfs, ext4, or other exist local fses with this
>> new use cases (since they don't need any on-disk change as well, for
>> example, by using some xattr), I don't think it's really hard.
>>
> 
> Engineering-wise, merging composefs features into EROFS
> would be the simplest option and FWIW, my personal preference.
> 
> However, you need to be aware that this will bring into EROFS
> vfs considerations, such as  s_stack_depth nesting (which AFAICS
> is not see incremented composefs?). It's not the end of the world, but this
> is no longer plain fs over block game. There's a whole new class of bugs
> (that syzbot is very eager to explore) so you need to ask yourself whether
> this is a direction you want to lead EROFS towards.

I'd like to make a seperated Kconfig for this.  I consider this just because
currently composefs is much similar to EROFS but it doesn't have some ability
to keep real regular file (even some README, VERSION or Changelog in these
images) in its (composefs-called) manifest files. Even its on-disk super block
doesn't have a UUID now [1] and some boot sector for booting or some potential
hybird formats such as tar + EROFS, cpio + EROFS.

I'm not sure if those potential new on-disk features is unneeded even for
future composefs.  But if composefs laterly supports such on-disk features,
that makes composefs closer to EROFS even more.  I don't see disadvantage to
make these actual on-disk compatible (like ext2 and ext4).

The only difference now is manifest file itself I/O interface -- bio vs file.
but EROFS can be distributed to raw block devices as well, composefs can't.

Also, I'd like to seperate core-EROFS from advanced features (or people who
are interested to work on this are always welcome) and composefs-like model,
if people don't tend to use any EROFS advanced features, it could be disabled
from compiling explicitly.

> 
> Giuseppe expressed his plans to make use of the composefs method
> inside userns one day. It is not a hard dependency, but I believe that
> keeping the "RO efficient verifiable image format" functionality (EROFS)
> separate from "userns composition of verifiable images" (overlayfs)
> may benefit the userns mount goal in the long term.

If that is needed, I'm very happy to get more detailed path of this from
some discussion in LSF/MM/BPF 2023: how we get this (userns) reliably in
practice.

As of code lines, core EROFS on-disk format is quite simple (I don't think
total LOC is a barrier), if you see
   fs/erofs/data.c
   fs/erofs/namei.c
   fs/erofs/dir.c

or
    erofs_super_block
    erofs_inode_compact
    erofs_inode_extended
    erofs_dirent

but for example, fs/erofs/super.c which is just used to enable EROFS advanced
features is almost 1000LOC now.  But most code is quite trivial, I don't think
these can cause any difference to userns plan.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/CAOQ4uxjm7i+uO4o4470ACctsft1m18EiUpxBfCeT-Wyqf1FAYg@mail.gmail.com/

> 
> Thanks,
> Amir.
