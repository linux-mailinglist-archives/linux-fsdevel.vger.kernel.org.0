Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF98764305
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjG0AjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 20:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjG0AjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:39:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60AB19BF;
        Wed, 26 Jul 2023 17:39:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 653CD3200928;
        Wed, 26 Jul 2023 20:39:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 20:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690418339; x=1690504739; bh=fh3vB6m/QoY2U9VBs1nF9rVPAsM1ZirjOA9
        jCYin1fA=; b=S9BVll28ayrYFzYDUCh1260P1RZseML9u3ut4X9vsgyT49tXSpB
        NyeXlYDYLSBeOUZvvSwXFOJpDEli8bvuIsQ/tVNUjtw6xCwxU0UzrI/kTKoTaeTt
        BceCUbo9uIjiv+5hu6+ABKpbD1FRb/bqR1rmBtkxSEi3eiQqkcO0afJuejdwf7cx
        22SFqZN/dI4ebODA4kZ3C3vNjR/OcIWvmhMoGCEEAIHmdNCepe7LQHyEqnt6LSum
        R3gs9Q11qmODr0oLwTYWesVlrbgHifrMZDSyhREvy2clyPPV4PGwOVzKfgy5nnOn
        fQhs9gkyZYOc7JvaOLu1pjypWcSqYZN1uHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690418339; x=1690504739; bh=fh3vB6m/QoY2U9VBs1nF9rVPAsM1ZirjOA9
        jCYin1fA=; b=KmDIyDQVSBYA7Wm+3KqW1r+iszibIyFtypKgxRyp8kJI5II9l5r
        iHcUh3G7jfvBp/Qn97kCF+CatVmnP1t/vRugR99pjczncfmu2ZhddpgR3L0WXiT4
        L/5dbCirbiNUOm6D6midV+OgB2Vtss34w0H4+R8UxVvcHBW5U6ww0eZZ6sj6HTvZ
        sXmizmJYk/WTSM2doGMfLE9e5KGm9zOYgt0s+bjVvU3uHg4wUeB+A6PR+dNVmIL0
        OZ441aWUxW/4JJfGubNGbtXU6ZxU8dO9irU0IjcVz63FSZCjsLvC37Mxdo0XmmnK
        0FH8JCG2AHlqB+TvNchx5n4d6SSct0c2SzQ==
X-ME-Sender: <xms:o7zBZPEAmR4l4Xz7VYWqV7etqlaaM7YHIObO3qTxXCX7K1Py3xMVyw>
    <xme:o7zBZMUIIKKu4v7R75ov6sC51OSPmskY_vdnQhZDNw69BwnYVHt8ZND1FETFIEy_6
    X8ZB005bwnL>
X-ME-Received: <xmr:o7zBZBISgbIbOjzHy4_GfNl1BOKaPEf6KoHRXWiylClsnC5ysNZhl0jF6L_9on-JEMg5z5Jgm8vmTF6HfzHwxxMZxqT5zGGzAjAXt-_4-pE0ayGnPvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieefgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuhffvvehfjggt
    gfesthekredttdefjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvg
    hmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeekgfefgffhfedvhfejkeetteeuueev
    tedukeevkedtudfgfeefleetieehvdejleenucffohhmrghinhepihigrdhiohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnseht
    hhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:o7zBZNFJrIDw3Pbf9oYddMCxwbg5XglVc8mI2rPBiJ42tcNkZKqT-A>
    <xmx:o7zBZFX4nBooxvUU6W5Q2irU4ra6y9mgsb1gT-AxHV26FVXubhkMVA>
    <xmx:o7zBZIO2NIE1KlPuzR6OuiX393qaMDDYSGKk47hQCEs2drH9CUphow>
    <xmx:o7zBZOvmjfdcnuSJ-Ky4Rz3w2ad-lTfgXZc_easlrxEgqEa26VlGog>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 20:38:52 -0400 (EDT)
Message-ID: <15eddad0-e73b-2686-b5ba-eaacc57b8947@themaw.net>
Date:   Thu, 27 Jul 2023 08:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
From:   Ian Kent <raven@themaw.net>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com, imran.f.khan@oracle.com
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
 <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
 <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
 <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
 <db933d76-1432-f671-8712-d94de35277d8@themaw.net> <20230718190009.GC411@mutt>
 <76fcd1fe-b5f5-dd6b-c74d-30c2300f3963@themaw.net>
 <ce407424e98bf5f2b186df5d28dd5749a6cbfa45.camel@themaw.net>
Content-Language: en-US
In-Reply-To: <ce407424e98bf5f2b186df5d28dd5749a6cbfa45.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/7/23 10:03, Ian Kent wrote:
> On Wed, 2023-07-19 at 12:23 +0800, Ian Kent wrote:
>> On 19/7/23 03:00, Anders Roxell wrote:
>>> On 2023-01-23 11:11, Ian Kent wrote:
>>>> On 29/12/22 21:07, Ian Kent wrote:
>>>>> On 29/12/22 17:20, Arnd Bergmann wrote:
>>>>>> On Fri, Dec 23, 2022, at 00:11, Ian Kent wrote:
>>>>>>> On 21/12/22 21:34, Anders Roxell wrote:
>>>>>>>> On 2022-10-31 12:30, Tejun Heo wrote:
>>>>>>>>> On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent
>>>>>>>>> wrote:
>>>>>>>>>> The kernfs write lock is held when the kernfs node
>>>>>>>>>> inode attributes
>>>>>>>>>> are updated. Therefore, when either
>>>>>>>>>> kernfs_iop_getattr() or
>>>>>>>>>> kernfs_iop_permission() are called the kernfs node
>>>>>>>>>> inode attributes
>>>>>>>>>> won't change.
>>>>>>>>>>
>>>>>>>>>> Consequently concurrent kernfs_refresh_inode() calls
>>>>>>>>>> always copy the
>>>>>>>>>> same values from the kernfs node.
>>>>>>>>>>
>>>>>>>>>> So there's no need to take the inode i_lock to get
>>>>>>>>>> consistent values
>>>>>>>>>> for generic_fillattr() and generic_permission(), the
>>>>>>>>>> kernfs read lock
>>>>>>>>>> is sufficient.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>>>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Building an allmodconfig arm64 kernel on yesterdays next-
>>>>>>>> 20221220 and
>>>>>>>> booting that in qemu I see the following "BUG: KCSAN:
>>>>>>>> data-race in
>>>>>>>> set_nlink / set_nlink".
>>>>>>> I'll check if I missed any places where set_link() could be
>>>>>>> called where the link count could be different.
>>>>>>>
>>>>>>>
>>>>>>> If there aren't any the question will then be can writing
>>>>>>> the
>>>>>>> same value to this location in multiple concurrent threads
>>>>>>> corrupt it?
>>>>>> I think the race that is getting reported for set_nlink()
>>>>>> is about this bit getting called simulatenously on multiple
>>>>>> CPUs with only the read lock held for the inode:
>>>>>>
>>>>>>         /* Yes, some filesystems do change nlink from zero to
>>>>>> one */
>>>>>>         if (inode->i_nlink == 0)
>>>>>> atomic_long_dec(&inode->i_sb->s_remove_count);
>>>>>>         inode->__i_nlink = nlink;
>>>>>>
>>>>>> Since i_nlink and __i_nlink refer to the same memory
>>>>>> location,
>>>>>> the 'inode->i_nlink == 0' check can be true for all of them
>>>>>> before the nonzero nlink value gets set, and this results in
>>>>>> s_remove_count being decremented more than once.
>>>>> Thanks for the comment Arnd.
>>>> Hello all,
>>>>
>>>>
>>>> I've been looking at this and after consulting Miklos and his
>>>> pointing
>>>>
>>>> out that it looks like a false positive the urgency dropped off a
>>>> bit. So
>>>>
>>>> apologies for taking so long to report back.
>>>>
>>>>
>>>> Anyway it needs some description of conclusions reached so far.
>>>>
>>>>
>>>> I'm still looking around but in short, kernfs will set
>>>> directories to <# of
>>>>
>>>> directory entries> + 2 unconditionally for directories. I can't
>>>> yet find
>>>>
>>>> any other places where i_nlink is set or changed and if there are
>>>> none
>>>>
>>>> then i_nlink will never be set to zero so the race should not
>>>> occur.
>>>>
>>>>
>>>> Consequently my claim is this is a real false positive.
>>>>
>>>>
>>>> There are the file system operations that may be passed at mount
>>>> time
>>>>
>>>> but given the way kernfs sets i_nlink it pretty much dictates
>>>> those
>>>> operations
>>>>
>>>> (if there were any that modify it and there don't appear to be
>>>> any) leave it
>>>>
>>>> alone.
>>>>
>>>>
>>>> So it just doesn't make sense for users of kernfs to fiddle with
>>>> i_nlink ...
>>> On todays next tag, next-20230718 this KCSAN BUG poped up again.
>>> When I
>>> built an allmodconfig arm64 kernel and booted it in QEMU. Full log
>>> can
>>> be found http://ix.io/4AUd
>>>
>>> [ 1694.987789][  T137] BUG: KCSAN: data-race in inode_permission /
>>> kernfs_refresh_inode
>>> [ 1694.992912][  T137]
>>> [ 1694.994532][  T137] write to 0xffff00000bab6070 of 2 bytes by
>>> task 104 on cpu 0:
>>> [ 1694.999269][ T137] kernfs_refresh_inode
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:171)
>>> [ 1695.002707][ T137] kernfs_iop_permission
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:289)
>>> [ 1695.006148][ T137] inode_permission
>>> (/home/anders/src/kernel/next/fs/namei.c:461
>>> /home/anders/src/kernel/next/fs/namei.c:528)
>>> [ 1695.009420][ T137] link_path_walk
>>> (/home/anders/src/kernel/next/fs/namei.c:1720
>>> /home/anders/src/kernel/next/fs/namei.c:2267)
>>> [ 1695.012643][ T137] path_lookupat
>>> (/home/anders/src/kernel/next/fs/namei.c:2478 (discriminator 2))
>>> [ 1695.015781][ T137] filename_lookup
>>> (/home/anders/src/kernel/next/fs/namei.c:2508)
>>> [ 1695.019059][ T137] vfs_statx
>>> (/home/anders/src/kernel/next/fs/stat.c:238)
>>> [ 1695.022024][ T137] vfs_fstatat
>>> (/home/anders/src/kernel/next/fs/stat.c:276)
>>> [ 1695.025067][ T137] __do_sys_newfstatat
>>> (/home/anders/src/kernel/next/fs/stat.c:446)
>>> [ 1695.028497][ T137] __arm64_sys_newfstatat
>>> (/home/anders/src/kernel/next/fs/stat.c:440
>>> /home/anders/src/kernel/next/fs/stat.c:440)
>>> [ 1695.032080][ T137] el0_svc_common.constprop.0
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:139)
>>> [ 1695.035916][ T137] do_el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:188)
>>> [ 1695.038796][ T137] el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:144
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:648)
>>> [ 1695.041468][ T137] el0t_64_sync_handler
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:666)
>>> [ 1695.044889][ T137] el0t_64_sync
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:591)
>>> [ 1695.047904][  T137]
>>> [ 1695.049511][  T137] 1 lock held by systemd-udevd/104:
>>> [ 1695.052837][ T137] #0: ffff000006681e08 (&root-
>>>> kernfs_iattr_rwsem){++++}-{3:3}, at: kernfs_iop_permission
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:288)
>>> [ 1695.060241][  T137] irq event stamp: 82902
>>> [ 1695.063006][ T137] hardirqs last enabled at (82901):
>>> _raw_spin_unlock_irqrestore
>>> (/home/anders/src/kernel/next/arch/arm64/include/asm/alternative-
>>> macros.h:250
>>> /home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:27
>>> /home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:140
>>> /home/anders/src/kernel/next/include/linux/spinlock_api_smp.h:151
>>> /home/anders/src/kernel/next/kernel/locking/spinlock.c:194)
>>> [ 1695.069673][ T137] hardirqs last disabled at (82902):
>>> el1_interrupt
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:472
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:488)
>>> [ 1695.075474][ T137] softirqs last enabled at (82792):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1791)
>>> [ 1695.082319][ T137] softirqs last disabled at (82790):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/include/linux/bottom_half.h:20
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1784)
>>> [ 1695.089049][  T137]
>>> [ 1695.090659][  T137] read to 0xffff00000bab6070 of 2 bytes by
>>> task 137 on cpu 0:
>>> [ 1695.095374][ T137] inode_permission
>>> (/home/anders/src/kernel/next/fs/namei.c:532)
>>> [ 1695.098655][ T137] link_path_walk
>>> (/home/anders/src/kernel/next/fs/namei.c:1720
>>> /home/anders/src/kernel/next/fs/namei.c:2267)
>>> [ 1695.101857][ T137] path_openat
>>> (/home/anders/src/kernel/next/fs/namei.c:3789 (discriminator 2))
>>> [ 1695.104885][ T137] do_filp_open
>>> (/home/anders/src/kernel/next/fs/namei.c:3820)
>>> [ 1695.108006][ T137] do_sys_openat2
>>> (/home/anders/src/kernel/next/fs/open.c:1418)
>>> [ 1695.111290][ T137] __arm64_sys_openat
>>> (/home/anders/src/kernel/next/fs/open.c:1433)
>>> [ 1695.114825][ T137] el0_svc_common.constprop.0
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:139)
>>> [ 1695.118662][ T137] do_el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:188)
>>> [ 1695.121555][ T137] el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:144
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:648)
>>> [ 1695.124207][ T137] el0t_64_sync_handler
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:666)
>>> [ 1695.127590][ T137] el0t_64_sync
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:591)
>>> [ 1695.130641][  T137]
>>> [ 1695.132241][  T137] no locks held by systemd-udevd/137.
>>> [ 1695.135618][  T137] irq event stamp: 3246
>>> [ 1695.138519][ T137] hardirqs last enabled at (3245):
>>> seqcount_lockdep_reader_access
>>> (/home/anders/src/kernel/next/include/linux/seqlock.h:105)
>>> [ 1695.145825][ T137] hardirqs last disabled at (3246):
>>> el1_interrupt
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:472
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:488)
>>> [ 1695.151942][ T137] softirqs last enabled at (3208):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1791)
>>> [ 1695.158950][ T137] softirqs last disabled at (3206):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/include/linux/bottom_half.h:20
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1784)
>>> [ 1695.166036][  T137]
>>> [ 1695.167621][  T137] Reported by Kernel Concurrency Sanitizer on:
>>> [ 1695.179990][  T137] Hardware name: linux,dummy-virt (DT)
>>> [ 1695.183687][  T137]
>>> ==================================================================
>>
>> This one is different to the original.
>>
>>
>> I can't see where the problem is here, can someone help me out
>>
>> please.
>>
>>
>> I don't see any shared data values used by the call
>>
>> devcgroup_inode_permission(inode, mask) in
>> fs/namei.c:inode_permission()
>>
>> that might be a problem during the read except possibly inode-
>>> i_mode.
>>
>> I'll check on that ... maybe something's been missed when
>> kernfs_rwsem
>>
>> was changed to a separate lock (kernfs_iattr_rwsem).
>>
>>
>>> [...]
>>>
>>> [ 1738.053819][  T104] BUG: KCSAN: data-race in set_nlink /
>>> set_nlink
>>> [ 1738.058223][  T104]
>>> [ 1738.059865][  T104] read to 0xffff00000bab6918 of 4 bytes by
>>> task 108 on cpu 0:
>>> [ 1738.064916][ T104] set_nlink
>>> (/home/anders/src/kernel/next/fs/inode.c:369)
>>> [ 1738.067845][ T104] kernfs_refresh_inode
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:180)
>>> [ 1738.071607][ T104] kernfs_iop_permission
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:289)
>>> [ 1738.075467][ T104] inode_permission
>>> (/home/anders/src/kernel/next/fs/namei.c:461
>>> /home/anders/src/kernel/next/fs/namei.c:528)
>>> [ 1738.078868][ T104] link_path_walk
>>> (/home/anders/src/kernel/next/fs/namei.c:1720
>>> /home/anders/src/kernel/next/fs/namei.c:2267)
>>> [ 1738.082270][ T104] path_lookupat
>>> (/home/anders/src/kernel/next/fs/namei.c:2478 (discriminator 2))
>>> [ 1738.085488][ T104] filename_lookup
>>> (/home/anders/src/kernel/next/fs/namei.c:2508)
>>> [ 1738.089101][ T104] user_path_at_empty
>>> (/home/anders/src/kernel/next/fs/namei.c:2907)
>>> [ 1738.092469][ T104] do_readlinkat
>>> (/home/anders/src/kernel/next/fs/stat.c:477)
>>> [ 1738.095970][ T104] __arm64_sys_readlinkat
>>> (/home/anders/src/kernel/next/fs/stat.c:504
>>> /home/anders/src/kernel/next/fs/stat.c:501
>>> /home/anders/src/kernel/next/fs/stat.c:501)
>>> [ 1738.099529][ T104] el0_svc_common.constprop.0
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:139)
>>> [ 1738.103696][ T104] do_el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:188)
>>> [ 1738.106560][ T104] el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:144
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:648)
>>> [ 1738.109613][ T104] el0t_64_sync_handler
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:666)
>>> [ 1738.113035][ T104] el0t_64_sync
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:591)
>>> [ 1738.116346][  T104]
>>> [ 1738.117924][  T104] 1 lock held by systemd-udevd/108:
>>> [ 1738.121580][ T104] #0: ffff000006681e08 (&root-
>>>> kernfs_iattr_rwsem){++++}-{3:3}, at: kernfs_iop_permission
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:288)
>>> [ 1738.129355][  T104] irq event stamp: 31000
>>> [ 1738.132088][ T104] hardirqs last enabled at (31000):
>>> seqcount_lockdep_reader_access
>>> (/home/anders/src/kernel/next/include/linux/seqlock.h:105)
>>> [ 1738.139417][ T104] hardirqs last disabled at (30999):
>>> seqcount_lockdep_reader_access
>>> (/home/anders/src/kernel/next/include/linux/seqlock.h:104)
>>> [ 1738.146781][ T104] softirqs last enabled at (30973):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1791)
>>> [ 1738.153891][ T104] softirqs last disabled at (30971):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/include/linux/bottom_half.h:20
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1784)
>>> [ 1738.161012][  T104]
>>> [ 1738.162663][  T104] write to 0xffff00000bab6918 of 4 bytes by
>>> task 104 on cpu 0:
>>> [ 1738.167730][ T104] set_nlink
>>> (/home/anders/src/kernel/next/fs/inode.c:372)
>>> [ 1738.170559][ T104] kernfs_refresh_inode
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:180)
>>> [ 1738.174355][ T104] kernfs_iop_permission
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:289)
>>> [ 1738.177829][ T104] inode_permission
>>> (/home/anders/src/kernel/next/fs/namei.c:461
>>> /home/anders/src/kernel/next/fs/namei.c:528)
>>> [ 1738.181403][ T104] link_path_walk
>>> (/home/anders/src/kernel/next/fs/namei.c:1720
>>> /home/anders/src/kernel/next/fs/namei.c:2267)
>>> [ 1738.184738][ T104] path_lookupat
>>> (/home/anders/src/kernel/next/fs/namei.c:2478 (discriminator 2))
>>> [ 1738.188268][ T104] filename_lookup
>>> (/home/anders/src/kernel/next/fs/namei.c:2508)
>>> [ 1738.191865][ T104] vfs_statx
>>> (/home/anders/src/kernel/next/fs/stat.c:238)
>>> [ 1738.196236][ T104] vfs_fstatat
>>> (/home/anders/src/kernel/next/fs/stat.c:276)
>>> [ 1738.200120][ T104] __do_sys_newfstatat
>>> (/home/anders/src/kernel/next/fs/stat.c:446)
>>> [ 1738.204095][ T104] __arm64_sys_newfstatat
>>> (/home/anders/src/kernel/next/fs/stat.c:440
>>> /home/anders/src/kernel/next/fs/stat.c:440)
>>> [ 1738.207676][ T104] el0_svc_common.constprop.0
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52
>>> /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:139)
>>> [ 1738.211820][ T104] do_el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:188)
>>> [ 1738.214815][ T104] el0_svc
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:144
>>> /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:648)
>>> [ 1738.217709][ T104] el0t_64_sync_handler
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:666)
>>> [ 1738.221239][ T104] el0t_64_sync
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:591)
>>> [ 1738.224502][  T104]
>>> [ 1738.226090][  T104] 1 lock held by systemd-udevd/104:
>>> [ 1738.229747][ T104] #0: ffff000006681e08 (&root-
>>>> kernfs_iattr_rwsem){++++}-{3:3}, at: kernfs_iop_permission
>>> (/home/anders/src/kernel/next/fs/kernfs/inode.c:288)
>>> [ 1738.237504][  T104] irq event stamp: 108353
>>> [ 1738.240262][ T104] hardirqs last enabled at (108353):
>>> seqcount_lockdep_reader_access
>>> (/home/anders/src/kernel/next/include/linux/seqlock.h:105)
>>> [ 1738.247443][ T104] hardirqs last disabled at (108352):
>>> seqcount_lockdep_reader_access
>>> (/home/anders/src/kernel/next/include/linux/seqlock.h:104)
>>> [ 1738.254510][ T104] softirqs last enabled at (108326):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1791)
>>> [ 1738.262187][ T104] softirqs last disabled at (108324):
>>> fpsimd_restore_current_state
>>> (/home/anders/src/kernel/next/include/linux/bottom_half.h:20
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242
>>> /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1784)
>>> [ 1738.270239][  T104]
>>> [ 1738.272140][  T104] Reported by Kernel Concurrency Sanitizer on:
>>> [ 1738.285185][  T104] Hardware name: linux,dummy-virt (DT)
>>> [ 1738.288703][  T104]
>>> ==================================================================
>> This looks just like the original except a different lock is being
>>
>> used now.
>>
>>
>> The link count can't be less than two if set_nlink() is called.
>>
>>
>> Maybe I am missing something but the directory count is changed only
>>
>> while holding the root->kernfs_iattr_rwsem so the value used by
>>
>> set_nlink() will not change during concurrent calls to
>> refresh_inode().
>>
>> Still looks like a false positive, I'll check the write operations
>> again just to be sure.
> I do see a problem with recent changes.
>
> I'll send this off to Greg after I've done some testing (primarily just
> compile and function).
>
> Here's a patch which describes what I found.
>
> Comments are, of course, welcome, ;)

Anders I was hoping you would check if/what lockdep trace

you get with this patch.


Imran, I was hoping you would comment on my change as it

relates to the kernfs_iattr_rwsem changes.


Ian

>
> kernfs: fix missing kernfs_iattr_rwsem locking
>
> From: Ian Kent <raven@themaw.net>
>
> When the kernfs_iattr_rwsem was introduced a case was missed.
>
> The update of the kernfs directory node child count was also protected
> by the kernfs_rwsem and needs to be included in the change so that the
> child count (and so the inode n_link attribute) does not change while
> holding the rwsem for read.
>
> Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
> attributes)
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Eric Sandeen <sandeen@sandeen.net>
> ---
>   fs/kernfs/dir.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 45b6919903e6..6e84bb69602e 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node
> *kn)
>   	rb_insert_color(&kn->rb, &kn->parent->dir.children);
>   
>   	/* successfully added, account subdir number */
> +	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>   	if (kernfs_type(kn) == KERNFS_DIR)
>   		kn->parent->dir.subdirs++;
>   	kernfs_inc_rev(kn->parent);
> +	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>   
>   	return 0;
>   }
> @@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct
> kernfs_node *kn)
>   	if (RB_EMPTY_NODE(&kn->rb))
>   		return false;
>   
> +	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>   	if (kernfs_type(kn) == KERNFS_DIR)
>   		kn->parent->dir.subdirs--;
>   	kernfs_inc_rev(kn->parent);
> +	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>   
>   	rb_erase(&kn->rb, &kn->parent->dir.children);
>   	RB_CLEAR_NODE(&kn->rb);
>
