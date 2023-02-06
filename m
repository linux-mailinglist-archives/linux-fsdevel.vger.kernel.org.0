Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C768BE1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 14:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBFN1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 08:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFN1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:27:49 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B02E1BCE;
        Mon,  6 Feb 2023 05:27:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vb39R8H_1675690059;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vb39R8H_1675690059)
          by smtp.aliyun-inc.com;
          Mon, 06 Feb 2023 21:27:40 +0800
Message-ID: <678002cf-f847-d5c3-a79b-5bebd3c1e518@linux.alibaba.com>
Date:   Mon, 6 Feb 2023 21:27:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1674227308.git.alexl@redhat.com>
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
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com>
 <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <CAL7ro1Hc4npP9DQjzuWXJYPTi9H=arLstAJvsBgVKzd8Cx8_tg@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1Hc4npP9DQjzuWXJYPTi9H=arLstAJvsBgVKzd8Cx8_tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/6 20:43, Alexander Larsson wrote:
> On Fri, Feb 3, 2023 at 1:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>>>>> Engineering-wise, merging composefs features into EROFS
>>>>>> would be the simplest option and FWIW, my personal preference.
>>>>>>
>>>>>> However, you need to be aware that this will bring into EROFS
>>>>>> vfs considerations, such as  s_stack_depth nesting (which AFAICS
>>>>>> is not see incremented composefs?). It's not the end of the
>>>>>> world, but this
>>>>>> is no longer plain fs over block game. There's a whole new class
>>>>>> of bugs
>>>>>> (that syzbot is very eager to explore) so you need to ask
>>>>>> yourself whether
>>>>>> this is a direction you want to lead EROFS towards.
>>>>>
>>>>> I'd like to make a seperated Kconfig for this.  I consider this
>>>>> just because
>>>>> currently composefs is much similar to EROFS but it doesn't have
>>>>> some ability
>>>>> to keep real regular file (even some README, VERSION or Changelog
>>>>> in these
>>>>> images) in its (composefs-called) manifest files. Even its on-disk
>>>>> super block
>>>>> doesn't have a UUID now [1] and some boot sector for booting or
>>>>> some potential
>>>>> hybird formats such as tar + EROFS, cpio + EROFS.
>>>>>
>>>>> I'm not sure if those potential new on-disk features is unneeded
>>>>> even for
>>>>> future composefs.  But if composefs laterly supports such on-disk
>>>>> features,
>>>>> that makes composefs closer to EROFS even more.  I don't see
>>>>> disadvantage to
>>>>> make these actual on-disk compatible (like ext2 and ext4).
>>>>>
>>>>> The only difference now is manifest file itself I/O interface --
>>>>> bio vs file.
>>>>> but EROFS can be distributed to raw block devices as well,
>>>>> composefs can't.
>>>>>
>>>>> Also, I'd like to seperate core-EROFS from advanced features (or
>>>>> people who
>>>>> are interested to work on this are always welcome) and composefs-
>>>>> like model,
>>>>> if people don't tend to use any EROFS advanced features, it could
>>>>> be disabled
>>>>> from compiling explicitly.
>>>>
>>>> Apart from that, I still fail to get some thoughts (apart from
>>>> unprivileged
>>>> mounts) how EROFS + overlayfs combination fails on automative real
>>>> workloads
>>>> aside from "ls -lR" (readdir + stat).
>>>>
>>>> And eventually we still need overlayfs for most use cases to do
>>>> writable
>>>> stuffs, anyway, it needs some words to describe why such < 1s
>>>> difference is
>>>> very very important to the real workload as you already mentioned
>>>> before.
>>>>
>>>> And with overlayfs lazy lookup, I think it can be close to ~100ms or
>>>> better.
>>>>
>>>
>>> If we had an overlay.fs-verity xattr, then I think there are no
>>> individual features lacking for it to work for the automotive usecase
>>> I'm working on. Nor for the OCI container usecase. However, the
>>> possibility of doing something doesn't mean it is the better technical
>>> solution.
>>>
>>> The container usecase is very important in real world Linux use today,
>>> and as such it makes sense to have a technically excellent solution for
>>> it, not just a workable solution. Obviously we all have different
>>> viewpoints of what that is, but these are the reasons why I think a
>>> composefs solution is better:
>>>
>>> * It is faster than all other approaches for the one thing it actually
>>> needs to do (lookup and readdir performance). Other kinds of
>>> performance (file i/o speed, etc) is up to the backing filesystem
>>> anyway.
>>>
>>> Even if there are possible approaches to make overlayfs perform better
>>> here (the "lazy lookup" idea) it will not reach the performance of
>>> composefs, while further complicating the overlayfs codebase. (btw, did
>>> someone ask Miklos what he thinks of that idea?)
>>>
>>
>> Well, Miklos was CCed (now in TO:)
>> I did ask him specifically about relaxing -ouserxarr,metacopy,redirect:
>> https://lore.kernel.org/linux-unionfs/20230126082228.rweg75ztaexykejv@wittgenstein/T/#mc375df4c74c0d41aa1a2251c97509c6522487f96
>> but no response on that yet.
>>
>> TBH, in the end, Miklos really is the one who is going to have the most
>> weight on the outcome.
>>
>> If Miklos is interested in adding this functionality to overlayfs, you are going
>> to have a VERY hard sell, trying to merge composefs as an independent
>> expert filesystem. The community simply does not approve of this sort of
>> fragmentation unless there is a very good reason to do that.
> 
> Yeah, if overlayfs get close to similar performance it does make more
> sense to use that. Lets see what miklos says.
> 
>>> For the automotive usecase we have strict cold-boot time requirements
>>> that make cold-cache performance very important to us. Of course, there
>>> is no simple time requirements for the specific case of listing files
>>> in an image, but any improvement in cold-cache performance for both the
>>> ostree rootfs and the containers started during boot will be worth its
>>> weight in gold trying to reach these hard KPIs.
>>>
>>> * It uses less memory, as we don't need the extra inodes that comes
>>> with the overlayfs mount. (See profiling data in giuseppes mail[1]).
>>
>> Understood, but we will need profiling data with the optimized ovl
>> (or with the single blob hack) to compare the relevant alternatives.
>>
>>>
>>> The use of loopback vs directly reading the image file from page cache
>>> also have effects on memory use. Normally we have both the loopback
>>> file in page cache, plus the block cache for the loopback device. We
>>> could use loopback with O_DIRECT, but then we don't use the page cache
>>> for the image file, which I think could have performance implications.
>>>
>>
>> I am not sure this is correct. The loop blockdev page cache can be used,
>> for reading metadata, can it not?
>> But that argument is true for EROFS and for almost every other fs
>> that could be mounted with -oloop.
>> If the loopdev overhead is a problem and O_DIRECT is not a good enough
>> solution, then you should work on a generic solution that all fs could use.
>>
>>> * The userspace API complexity of the combined overlayfs approach is
>>> much greater than for composefs, with more moving pieces. For
>>> composefs, all you need is a single mount syscall for set up. For the
>>> overlay approach you would need to first create a loopback device, then
>>> create a dm-verity device-mapper device from it, then mount the
>>> readonly fs, then mount the overlayfs.
>>
>> Userspace API complexity has never been and will never be a reason
>> for making changes in the kernel, let alone add a new filesystem driver.
>> Userspace API complexity can be hidden behind a userspace expert library.
>> You can even create a mount.composefs helper that users can use
>> mount -t composefs that sets up erofs+overlayfs behind the scenes.
> 
> I don't really care that it's more work for userspace to set it up,
> that can clearly always be hidden behind some abstraction.
> 
> However, all this complexity is part of the reason why the combination
> use more memory and perform less well. It also gets in the way when
> using the code in more complex, stacked ways. For example, you need
> have /dev/loop and /dev/mapper/control available to be able to
> loopback mount a dm-verify using erofs image. This means it is not by
> default doable in typical sandbox/containers environments without
> adding access to additional global (potentially quite unsafe, in the
> case of dev-mapper) devices.
> 
> Again, not a showstopper, but also not great.
> 
> I guess we could use fs-verity for loopback mounted files though,
> which drops the dependency on dev-mapper. This makes it quite a lot
> better, but loopback is still a global non-namespaced resource. At
> some point loopfs was proposed to make namespaced loopback possible,
> but that seems to have gotten nowhere unfortunately.

Yes, in principle, fsverity could be used as well as long as
those digests are checked before mounting so that dm-verity is not
needed.

> 
>> Similarly, mkfs.composefs can be an alias to mkfs.erofs with a specific
>> set of preset options, much like mkfs.ext* family.
>>
>>> All this complexity has a cost
>>> in terms of setup/teardown performance, userspace complexity and
>>> overall memory use.
>>>
>>
>> This claim needs to be quantified *after* the proposed improvements
>> (or equivalent hack) to existing subsystems.
>>
>>> Are any of these a hard blocker for the feature? Not really, but I
>>> would find it sad to use an (imho) worse solution.
>>>
>>
>> I respect your emotion and it is not uncommon for people to want
>> to see their creation merged as is, but from personal experience,
>> it is often a much better option for you, to have your code merge into
>> an existing subsystem. I think if you knew all the advantages, you
>> would have fought for this option yourself ;)
> 
> I'm gonna do some more experimenting with the erofs+overlayfs approach
> to get a better idea for the complete solution.
> 
> One problem I ran into is that erofs seems to only support mounting
> filesystem images that are created with the native page size. This
> means I can't mount a erofs image created on a 4k page-size machine on
> an arm64 mac with 64k pages. That doesn't seem great. Maybe this
> limitation can be lifted from the erofs code though.

Honestly, EROFS 64k support has been in our roadmap for a quite long
time, and it has been almost done for the uncompressed part apart from
replacing EROFS_BLKSIZ to erofs_blksiz(sb).

Currently it's not urgent just because our Cloud environment always use
4k PAGE_SIZE, but it seems Android will consider 16k pagesize as well, so
yes, we will support !4k page size for the uncompressed part in the near
future.  But it seems that arm64 RHEL 9 switched back to 4k page size?

> 
>>> The other mentioned approach is to extend EROFS with composefs
>>> features.  For this to be interesting to me it would have to include:
>>>
>>>   * Direct reading of the image from page cache (not via loopback)
>>>   * Ability to verify fs-verity digest of that image file
>>>   * Support for stacked content files in a set of specified basedirs
>>>     (not using fscache).
>>>   * Verification of expected fs-verity digest for these basedir files
>>>
>>> Anything less than this and I think the overlayfs+erofs approach is a
>>> better choice.
>>>
>>> However, this is essentially just proposing we re-implement all the
>>> composefs code with a different name. And then we get a filesystem
>>> supporting *both* stacking and traditional block device use, which
>>> seems a bit weird to me. It will certainly make the erofs code more
>>> complex having to support all these combinations. Also, given the harsh
>>> arguments and accusations towards me on the list I don't feel very
>>> optimistic about how well such a cooperation would work.
>>>
>>
>> I understand why you write that  and I am sorry that you feel this way.
>> This is a good opportunity to urge you and Giuseppe again to request
>> an invite to LSFMM [1] and propose composefs vs. erofs+ovl as a TOPIC.
>>
>> Meeting the developers in person is often the best way to understand each
>> other in situations just like this one where the email discussions fail to
>> remain on a purely technical level and our emotions get involved.
>> It is just too hard to express emotions accurately in emails and people are
>> so very often misunderstood when that happens.
>>
>> I guarantee you that it is much more pleasant to argue with people over email
>> after you have met them in person ;)
> 
> I'll try to see if this works in my schedule. But, yeah, in-person
> discussions would probably speed things up.

Jingbo has been investigated in the latest performance numbers, currently,
it seems O_DIRECT loop device vs composefs manifest file is that

   some composefs reads (like inode reads) are used by using kernel_read()
with buffered I/O, so that kernel_read() will have builtin readahead, while
EROFS just uses bdev + page cache sync interface so that it causes some
difference, but EROFS could do readahead as well for dir data/inode read if
needed.

   Consider currently the common manifest files are quite small (~10MB), so
the readahead policy can be adapted honestly.  Jingbo is off work now, but
he could post some latest "ls -lR" numbers tomorrow if needed.

Thanks,
Gao Xiang

> 
