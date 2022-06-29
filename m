Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3355F2BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiF2BVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiF2BVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:21:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21429C8C;
        Tue, 28 Jun 2022 18:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656465666;
        bh=HlwfelIiPKIBiEcWQxU9BqTY8RRlQ2xySX28D3PtxwA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=G7K2o+hQ2NpF2BsXOpVfAsdGX5PAfENS3TTzH3lmZtsOgL9YD3QpVfTOttbsqQxqz
         V41iQJ8haPPejjE0LPKzbzFq2+r/DZoXotMpvley6VXk5RHxvZ5dhc390xX/s51RFF
         G6ya4y6NV4w4izR4P/e5Xh0kWGfQa0wVy1hNWyTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1o6MO92Ka8-0001bA; Wed, 29
 Jun 2022 03:21:06 +0200
Message-ID: <b29ee79c-e0d9-7ebe-a563-ca7f33130fc9@gmx.com>
Date:   Wed, 29 Jun 2022 09:20:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de>
 <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
In-Reply-To: <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v7U5ikYaLCMfqFx6UzqJJcwW0pIuHKeGjFIDxIIlhiVcsCz3MKP
 wZqNlqCEcjATdGrUemWyZIb5kGG5XkkvpL2k3LWOCkJ/X8AHzbJBEY1JLgp9KzTKpBoOAHx
 fPqKsMSDuS3u15Hnmk1n4QIuF36h4FF2bdq/RSQbkbS8jRYRVyJWCOnUHhuTQoI0Hf11Hb5
 2sumzilR8AwqkpggHnpmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WBSOXf+nqUM=:xN8Y+rrwaHQld8lB4B2BjY
 zgyr8D8sJaEQAXjUS+rx2J1WPSV5AabP+ufS/l+tDohzNUj/OTccLrPuAyKyQJWGeHTUi5sFI
 KKB5TapSkMMbRqohKEDARil4HP55CHa1LMuUhKhinq+EuT3qVEVy3CkjUgNc4fTEqAK82d62c
 fArhEsYE1yXyW+HfAV1g2zdsv1zylxFvmY+2ngw8jlZEHWR0kAZfX+antIgn+ayhglP5D3OIQ
 jbM876O6n/okMKV5vy/Lszi2QBOrY/Va0SIWwuaKdks+8ftWBoXlM8VQKqgq3qPG2DgT208dJ
 wyA9fUjjzsmXsPL5r2SUcInS8Q534ETNE06aLx4QfmZtHqKXX+zVTsNb8+yKi1uN/8cADIQYM
 OVVMv8e+HbVYiGocP+n3I+y9rcKEpQCbFUWXMeMUHNzcpTAien9IDw8hyK0jpko3jTLL4c7jj
 9ojzeM7jZ9cC+MZlLpzBfgSza5SNTKxyD6gIR0otVH4DStFbT/bEEb3bxooYFIQCnXigUHUEl
 5kmd/1UlFuL2pn5efUfrC/cYKU1lnkIxMnxrEu+L8nFEBLM5L+a9pAkZVawd3EP/0PioFPaMF
 tngrOl2YCqfOB5O0elVaO2SeqWC095CJ1uWEDlhYvsiVsWm5sc551zMPyPfP+CVWx+Jufite8
 jAjPkR1CuB77DMdlbHvm5RSziOQel2ETceTMD9iqDOO41SlJJOhNSxPBz/hMLljqYrMlln0ui
 yWivkKVJGgNjJR7SNszabkHnmERgd67kxvck02EhQPrVJGaM96fAeoltLAFCvo6XK6KAlO8A9
 KJV9077gAUs8wFZT/JXIaJuWN0J1x+ftuDt+KJJVC/1nJbsEDHj785/6Vu0RClDSJvm1VEe97
 /srQQ+xA7l2+3d9MIar6BPyTGt2ZON5kL+HDXsTjFbfyaDHM2xcPHOXMJYtmIOegENgIsjxow
 M6qfHdH6aKG3tiG2dcC98k173Ouc7RSoKJqvBU1ZZ4wjc3rvk7D5SyhsObV3KBZGixFIu+kWg
 toDLexMbyffGrQjW8ngP1skPT6YGLaWu078zk8ek0s0hbjUHeJfI1zUGqxzPuqKu9UHoaS6uE
 J+n66Rr3coOOoSqma9wh95jNHN4ppaCq7UyHDt5smWSvx6g/kbgqADUOQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/28 22:29, Chris Mason wrote:
> On 6/25/22 5:11 AM, Christoph Hellwig wrote:
>> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
>>> I'm not sure I get the context 100% right but pages getting randomly
>>> dirty
>>> behind filesystem's back can still happen - most commonly with RDMA an=
d
>>> similar stuff which calls set_page_dirty() on pages it has got from
>>> pin_user_pages() once the transfer is done. page_maybe_dma_pinned()
>>> should
>>> be usable within filesystems to detect such cases and protect the
>>> filesystem but so far neither me nor John Hubbart has got to
>>> implement this
>>> in the generic writeback infrastructure + some filesystem as a sample
>>> case
>>> others could copy...
>>
>> Well, so far the strategy elsewhere seems to be to just ignore pages
>> only dirtied through get_user_pages.=C2=A0 E.g. iomap skips over pages
>> reported as holes, and ext4_writepage complains about pages without
>> buffers and then clears the dirty bit and continues.
>>
>> I'm kinda surprised that btrfs wants to treat this so special
>> especially as more of the btrfs page and sub-page status will be out
>> of date as well.
>
> As Sterba points out later in the thread, btrfs cares more because of
> stable page requirements to protect data during COW and to make sure the
> crcs we write to disk are correct.

In fact, COW is not that special, even before btrfs or all the other
fses supporting COW, all those old fses has to do something like COW,
when they are writing into holes.

What makes btrfs special is its csum, and in fact csum requires more
stable page status.

If someone can modify a page without waiting for its writeback to
finish, btrfs csum can easily be stale and cause -EIO for future read.

Thus unless we can ensure the procedure marking page dirty to respect
page writeback, going fixup path would be more dangerous than ignoring it.

>
> The fixup worker path is pretty easy to trigger if you O_DIRECT reads
> into mmap'd pages.=C2=A0 You need some memory pressure to power through
> get_user_pages trying to do the right thing, but it does happen.
>
> I'd love a proper fix for this on the *_user_pages() side where
> page_mkwrite() style notifications are used all the time.=C2=A0 It's jus=
t a
> huge change, and my answer so far has always been that using btrfs
> mmap'd memory for this kind of thing isn't a great choice either way.

The same here.

But for now I'm still wondering if the fixup is really the correct
workaround other than ignoring.

Thanks,
Qu

>
> -chris
