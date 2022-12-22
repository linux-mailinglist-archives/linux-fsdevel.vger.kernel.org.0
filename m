Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAD65492A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 00:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLVXLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 18:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLVXLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:11:52 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319CFD24;
        Thu, 22 Dec 2022 15:11:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C86F5C00FF;
        Thu, 22 Dec 2022 18:11:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 22 Dec 2022 18:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1671750708; x=
        1671837108; bh=jzgGZABrhb6m0d0MIpBUlFlMhQcmHmjQfl3qCXRguS0=; b=A
        IrXz8thWuzDLI3IKCCjSIyHbQRcfXUILAKHd3JsUP8FBQHLv3/rfKkm4QLRAerxD
        WOEX3X3qfmjdUCBk1uk3YGOH07ygZUTqipcaiMWKopbZYr9DAx6drN43dQ3D0Jxw
        mvbKtPHkwfegRP7ggPCoeqsh8Uuo66IYYqmc8BgJJKgnhshp/WwVRTWfGsmHtVjv
        zoRetrfO6GFo4hkanHidbL2NEWMotM8iv5bqgsbMpfbh/hkshUtnKb41bRswiO6h
        v+rGp+KH4vbwoCYPfB8SMvW27yojz0VZfCwbTh3Q+RQXJl9P6P7XWBlsdE9hGZx3
        UbuKwujPUtZ9xHpFya6Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671750708; x=
        1671837108; bh=jzgGZABrhb6m0d0MIpBUlFlMhQcmHmjQfl3qCXRguS0=; b=J
        kX1B+MFmYB5arpP7V5ivDRebW7mj/Mk6SrgrX5OVFFnk36xnKkJgvtsCAp+Q5UWO
        NyaG7Ilfouae0nZtYhWarxaW7ExoQEm770EK4pNfUHudf8AaUS1jL/sZFP1vUHVx
        +1TEVPlfHXrbIoIxnMAzMPasheINPVDL3gliZ0hLbhvRufeDtPulbFCrU2qwk+QU
        2IDRg9cuZeeal3aFkam/CStUGCAklFeTX0i47KZCTgMHs42ZfxTd+NgjRrmd4d1L
        UXvcXcD3XcjtAVfFqrjruwH2/H/AAazrvA0fUQtfxmGfw4b+AW2fb8krxG0cy2HP
        LtVVeDlZH40auNKDNYeFA==
X-ME-Sender: <xms:M-SkYy55xsn4C3Fm_yF5YokC-Od6gIC5z7h9CwNBwKSP_yVfw4QXVw>
    <xme:M-SkY74Ivxx9URiTEsYHaeBT67lF8xD8SU57HXz0cYMwOgRA5XgQLge_XuL0B_BfP
    eILnkst_oC7>
X-ME-Received: <xmr:M-SkYxfFuanGV5OYAKhUGGG1GKb-0rdJPhaIvsL2npLYo5gpczdRqcgAjtbJfnEcjkvkxDTvTh_HRu-47ZXPXEPYkLVcX--R7L3VLGxLs1y-KANS2Jk2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrhedugddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:M-SkY_IAQxNNYY34kLCodnEBv3mnejeqjB3UaltlGPBp9VFEONAu0g>
    <xmx:M-SkY2KXvF1t3UThFkiLVVAWWiXAX1J1ntu-fBKR2rDG1u8Rgy25dQ>
    <xmx:M-SkYwwdjWRMJCletO9TUHhzw8AXqThi9xAL1EJJaPIkHx-94IEBnw>
    <xmx:NOSkY8yKFIrhpbCH2vbbsEG4VYmuoAKz9ADafEeKBI8Tj7SwXFVTiw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Dec 2022 18:11:42 -0500 (EST)
Message-ID: <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
Date:   Fri, 23 Dec 2022 07:11:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
To:     Anders Roxell <anders.roxell@linaro.org>, Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com, arnd@arndb.de
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20221221133428.GE69385@mutt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/12/22 21:34, Anders Roxell wrote:
> On 2022-10-31 12:30, Tejun Heo wrote:
>> On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent wrote:
>>> The kernfs write lock is held when the kernfs node inode attributes
>>> are updated. Therefore, when either kernfs_iop_getattr() or
>>> kernfs_iop_permission() are called the kernfs node inode attributes
>>> won't change.
>>>
>>> Consequently concurrent kernfs_refresh_inode() calls always copy the
>>> same values from the kernfs node.
>>>
>>> So there's no need to take the inode i_lock to get consistent values
>>> for generic_fillattr() and generic_permission(), the kernfs read lock
>>> is sufficient.
>>>
>>> Signed-off-by: Ian Kent <raven@themaw.net>
>> Acked-by: Tejun Heo <tj@kernel.org>
> Hi,
>
> Building an allmodconfig arm64 kernel on yesterdays next-20221220 and
> booting that in qemu I see the following "BUG: KCSAN: data-race in
> set_nlink / set_nlink".


I'll check if I missed any places where set_link() could be

called where the link count could be different.


If there aren't any the question will then be can writing the

same value to this location in multiple concurrent threads

corrupt it?


Ian

>
>
> ==================================================================
> [ 1540.388669][  T123] BUG: KCSAN: data-race in set_nlink / set_nlink
> [ 1540.392779][  T123]
> [ 1540.394302][  T123] write to 0xffff00000adcc3e4 of 4 bytes by task 126 on cpu 0:
> [ 1540.398828][ T123] set_nlink (/home/anders/src/kernel/next/fs/inode.c:371)
> [ 1540.401609][ T123] kernfs_refresh_inode (/home/anders/src/kernel/next/fs/kernfs/inode.c:181)
> [ 1540.404925][ T123] kernfs_iop_getattr (/home/anders/src/kernel/next/fs/kernfs/inode.c:194)
> [ 1540.408088][ T123] vfs_getattr_nosec (/home/anders/src/kernel/next/fs/stat.c:133)
> [ 1540.411334][ T123] vfs_statx (/home/anders/src/kernel/next/fs/stat.c:170)
> [ 1540.414224][ T123] vfs_fstatat (/home/anders/src/kernel/next/fs/stat.c:276)
> [ 1540.417166][ T123] __do_sys_newfstatat (/home/anders/src/kernel/next/fs/stat.c:446)
> [ 1540.420539][ T123] __arm64_sys_newfstatat (/home/anders/src/kernel/next/fs/stat.c:440 /home/anders/src/kernel/next/fs/stat.c:440)
> [ 1540.424003][ T123] el0_svc_common.constprop.0 (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:142)
> [ 1540.427648][ T123] do_el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:197)
> [ 1540.430378][ T123] el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:638)
> [ 1540.433053][ T123] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:656)
> [ 1540.436421][ T123] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584)
> [ 1540.439303][  T123]
> [ 1540.440828][  T123] 1 lock held by systemd-udevd/126:
> [ 1540.444055][ T123] #0: ffff00000609b960 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_iop_getattr (/home/anders/src/kernel/next/fs/kernfs/inode.c:193)
> [ 1540.450699][  T123] irq event stamp: 185034
> [ 1540.453373][ T123] hardirqs last enabled at (185034): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/mm/page_alloc.c:5302)
> [ 1540.460087][ T123] hardirqs last disabled at (185033): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/include/linux/seqlock.h:103 (discriminator 4))
> [ 1540.466686][ T123] softirqs last enabled at (185001): fpsimd_restore_current_state (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1780)
> [ 1540.473310][ T123] softirqs last disabled at (184999): fpsimd_restore_current_state (/home/anders/src/kernel/next/include/linux/bottom_half.h:20 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1773)
> [ 1540.479872][  T123]
> [ 1540.481406][  T123] read to 0xffff00000adcc3e4 of 4 bytes by task 123 on cpu 0:
> [ 1540.485893][ T123] set_nlink (/home/anders/src/kernel/next/fs/inode.c:368)
> [ 1540.488663][ T123] kernfs_refresh_inode (/home/anders/src/kernel/next/fs/kernfs/inode.c:181)
> [ 1540.491961][ T123] kernfs_iop_permission (/home/anders/src/kernel/next/fs/kernfs/inode.c:290)
> [ 1540.495260][ T123] inode_permission (/home/anders/src/kernel/next/fs/namei.c:458 /home/anders/src/kernel/next/fs/namei.c:525)
> [ 1540.498450][ T123] link_path_walk (/home/anders/src/kernel/next/fs/namei.c:1715 /home/anders/src/kernel/next/fs/namei.c:2262)
> [ 1540.501552][ T123] path_lookupat (/home/anders/src/kernel/next/fs/namei.c:2473 (discriminator 2))
> [ 1540.504592][ T123] filename_lookup (/home/anders/src/kernel/next/fs/namei.c:2503)
> [ 1540.507740][ T123] user_path_at_empty (/home/anders/src/kernel/next/fs/namei.c:2876)
> [ 1540.511010][ T123] do_readlinkat (/home/anders/src/kernel/next/fs/stat.c:477)
> [ 1540.514097][ T123] __arm64_sys_readlinkat (/home/anders/src/kernel/next/fs/stat.c:504 /home/anders/src/kernel/next/fs/stat.c:501 /home/anders/src/kernel/next/fs/stat.c:501)
> [ 1540.517598][ T123] el0_svc_common.constprop.0 (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:142)
> [ 1540.521319][ T123] do_el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:197)
> [ 1540.524125][ T123] el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:638)
> [ 1540.526795][ T123] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:656)
> [ 1540.530224][ T123] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584)
> [ 1540.533176][  T123]
> [ 1540.534710][  T123] 1 lock held by systemd-udevd/123:
> [ 1540.537977][ T123] #0: ffff00000609b960 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_iop_permission (/home/anders/src/kernel/next/fs/kernfs/inode.c:289)
> [ 1540.544892][  T123] irq event stamp: 216564
> [ 1540.547603][ T123] hardirqs last enabled at (216564): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/mm/page_alloc.c:5302)
> [ 1540.554368][ T123] hardirqs last disabled at (216563): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/include/linux/seqlock.h:103 (discriminator 4))
> [ 1540.561107][ T123] softirqs last enabled at (216533): fpsimd_restore_current_state (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1780)
> [ 1540.567833][ T123] softirqs last disabled at (216531): fpsimd_restore_current_state (/home/anders/src/kernel/next/include/linux/bottom_half.h:20 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1773)
> [ 1540.574496][  T123]
> [ 1540.576050][  T123] Reported by Kernel Concurrency Sanitizer on:
> [ 1540.587925][  T123] Hardware name: linux,dummy-virt (DT)
> [ 1540.591282][  T123] ==================================================================
>
>
> Reverting this patch I don't see the data race anymore.
>
> Cheers,
> Anders
