Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10CD6ADB45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 11:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCGKB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 05:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCGKBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:01:46 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46058C26
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 02:01:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdL1HTi_1678183295;
Received: from 30.97.49.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdL1HTi_1678183295)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 18:01:36 +0800
Message-ID: <1481097f-e534-8587-a86c-bdf22eea8946@linux.alibaba.com>
Date:   Tue, 7 Mar 2023 18:01:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com>
 <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com>
 <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
 <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com>
 <CAL7ro1FPKPWQvHteQq_t=u_LuR4B1Q5c=FBE-tRTN8CfoZCAHw@mail.gmail.com>
 <07b3a7e2-5514-1262-2510-7747337640cc@linux.alibaba.com>
 <CAL7ro1GWQvF+u9eChhDiBcm-YCWiWGSafHJezOSq5K2j-tQfrw@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1GWQvF+u9eChhDiBcm-YCWiWGSafHJezOSq5K2j-tQfrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/7 17:46, Alexander Larsson wrote:
> On Tue, Mar 7, 2023 at 10:26 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> On 2023/3/7 17:07, Alexander Larsson wrote:
>>> On Tue, Mar 7, 2023 at 9:34 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023/3/7 16:21, Alexander Larsson wrote:
>>>>> On Mon, Mar 6, 2023 at 5:17 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>>
>>>>>>>> I tested the performance of "ls -lR" on the whole tree of
>>>>>>>> cs9-developer-rootfs.  It seems that the performance of erofs (generated
>>>>>>>> from mkfs.erofs) is slightly better than that of composefs.  While the
>>>>>>>> performance of erofs generated from mkfs.composefs is slightly worse
>>>>>>>> that that of composefs.
>>>>>>>
>>>>>>> I suspect that the reason for the lower performance of mkfs.composefs
>>>>>>> is the added overlay.fs-verity xattr to all the files. It makes the
>>>>>>> image larger, and that means more i/o.
>>>>>>
>>>>>> Actually you could move overlay.fs-verity to EROFS shared xattr area (or
>>>>>> even overlay.redirect but it depends) if needed, which could save some
>>>>>> I/Os for your workloads.
>>>>>>
>>>>>> shared xattrs can be used in this way as well if you care such minor
>>>>>> difference, actually I think inlined xattrs for your workload are just
>>>>>> meaningful for selinux labels and capabilities.
>>>>>
>>>>> Really? Could you expand on this, because I would think it will be
>>>>> sort of the opposite. In my usecase, the erofs fs will be read by
>>>>> overlayfs, which will probably access overlay.* pretty often.  At the
>>>>> very least it will load overlay.metacopy and overlay.redirect for
>>>>> every lookup.
>>>>
>>>> Really.  In that way, it will behave much similiar to composefs on-disk
>>>> arrangement now (in composefs vdata area).
>>>>
>>>> Because in that way, although an extra I/O is needed for verification,
>>>> and it can only happen when actually opening the file (so "ls -lR" is
>>>> not impacted.) But on-disk inodes are more compact.
>>>>
>>>> All EROFS xattrs will be cached in memory so that accessing
>>>> overlay.* pretty often is not greatly impacted due to no real I/Os
>>>> (IOWs, only some CPU time is consumed).
>>>
>>> So, I tried moving the overlay.digest xattr to the shared area, but
>>> actually this made the performance worse for the ls case. I have not
>>
>> That is much strange.  We'd like to open it up if needed.  BTW, did you
>> test EROFS with acl enabled all the time?
> 
> These were all with acl enabled.
> 
> And, to test this, I compared "ls -lR" and "ls -ZR", which do the same
> per-file syscalls, except the later doesn't try to read the
> system.posix_acl_access xattr. The result is:
> 
> xattr:        inlined | not inlined
> ------------+---------+------------
> ls -lR cold |  708    |  721
> ls -lR warm |  415    |  412
> ls -ZR cold |  522    |  512
> ls -ZR warm |  283    |  279
> 
> In the ZR case the out-of band digest is a win, but not in the lR
> case, which seems to mean the failed lookup of the acl xattr is to
> blame here.
> 
> Also, very interesting is the fact that the warm cache difference for
> these to is so large. I guess that is because most other inode data is
> cached, but the xattrs lookups are not. If you could cache negative
> xattr lookups that seems like a large win. This can be either via a
> bloom cache in the disk format or maybe even just some in-memory
> negative lookup caches for the inode, maybe even special casing the
> acl xattrs.

Yes, agree.  Actually we don't take much time to look that ACL impacts
because almost all generic fses (such as ext4, XFS, btrfs, etc.) all
implement ACLs.  But you could use "-o noacl" to disable it if needed
with the current codebase.

> 
>>> looked into the cause in detail, but my guess is that ls looks for the
>>> acl xattr, and such a negative lookup will cause erofs to look at all
>>> the shared xattrs for the inode, which means they all end up being
>>> loaded anyway. Of course, this will only affect ls (or other cases
>>> that read the acl), so its perhaps a bit uncommon.
>>
>> Yeah, in addition to that, I guess real acls could be landed in inlined
>> xattrs as well if exists...
> 
> Yeah, but that doesn't help with the case where they don't exist.
> 
>> BTW, if you have more interest in this way, we could get in
>> touch in a more effective way to improve EROFS in addition to
>> community emails except for the userns stuff
> 
> I don't really have time to do any real erofs specific work. These are
> just some ideas that i got looking at these results.

I don't want you guys to do any EROFS-specific work.  I just want to
confirm your real requirement (so I can improve this) and the final
goal of this discussion.

At least, on my side after long time discussion and comparison.
EROFS and composefs are much similar (but when EROFS was raised we
don't have a better choice to get a good performance since you've
already partially benchmarked other fses) from many points of views
except for some interfaces, and since composefs doesn't implement
acl now, if you use "-o noacl" to mount EROFS, it could perform
better performance.  So I think it's no needed to discuss "ls -lR"
stuffs here anymore, if you disagree, we could take more time to
investigate on this.

In other words, EROFS on-disk format and loopback devices are not
performance bottlenack even on "ls -lR" workload.  We could improve
xattr negative lookups as a real input of this.

Thanks,
Gao Xiang

> 
