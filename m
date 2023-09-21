Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90F87A9D2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjIUT30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIUT3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1411B6
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:03:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FBE35C0235;
        Thu, 21 Sep 2023 10:44:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Sep 2023 10:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695307478; x=1695393878; bh=1vll0u7F8CXOoj7SK2YnOrudf58FOj8hbWf
        SuC7KD3I=; b=oBgarYxTIwD+1PVef5U0tSauTe795y3LFpD/gp//DcVvFOod+AK
        7GVFeKi8kjsMKHAaTj/tWG/GmmdBUwEtsv5IHwBrB4KiZejxJ/v3RYwmlqrBv7wl
        Hcm6LW73n5OuJOJY15OZicqJlukk+MyDgsgW9siZ2zFwgttHs39sPICME4fEI9l3
        JrO+G5NSM9oeWilLZSLLSQtgjOVxff9zfTAfl5BTcfpuI/Jv1nch4rTiB7V6HRVD
        b4/jZ2mj4vqE0Vw4RaJqqhcsE9UkHn2ZuDjpm5twH9Ys4yLs6qW94STGBXm5Ro/R
        31b9TIfftMMIf+c8F4w7x5wxsnozzNVeDVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695307478; x=1695393878; bh=1vll0u7F8CXOoj7SK2YnOrudf58FOj8hbWf
        SuC7KD3I=; b=jWgE3i9SQNtu56CDpxFUBdcaj9dp7fAh8YzJjzmdK0CMTgNSgtm
        vVXZUnOZkzn4ZLgmFqe+4GffqB9mGosy75spS24X4dhnXA4E5HbxJbqivgllF0Hg
        nM0uILpW6M6qjkHchH8RTIvT2LC2U+dHtWc6Yo7MBHp+2qBKGsSn5TiMlv1ejcKi
        OvbXQPnSzArx7Lpr5FXOP4NGH+amqwJIyd2EnGLJ5deCZGSYm1o0ItkX+1E2ecq+
        aPXlSnzi9TDPMcSo04KkUkPvcdlKg/13YAFHZ0nzVZMfuqfEL/ux++ds0BLGCORC
        nytxf21q+5NMCY+SEm01VO9FaW1v4sbfUCA==
X-ME-Sender: <xms:1VYMZf_VCqbA-Mu1xS5nxfwJeFCCB6nQ5qpoMBV03dcX1VK3tAj05w>
    <xme:1VYMZbtT6h9_6YmpA7JGC3ndAsxyC7zXiAeK8wyhVuGtLqdvE66m_lL-T52dE-yJf
    HxgmVx59URRBm8B>
X-ME-Received: <xmr:1VYMZdAAxG8_t-a6l0y3M-pQssYL7PB7QxT1TwgbeAqYludkBWtejYTh9sj8yNukDAzN7xomdAhW0X-8aFRGiyGck-bHp3fMLK5Eb_szfSnypg3tQRaz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepiefhhfelgeetleeuleehhfffvdegteduleel
    veffkeekjeehhfdtfedvhfegffetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:1VYMZbek0hMjTLu45oc9mwltT0AdUCQXkGH1ThFjFI5LfHgm-GPlIg>
    <xmx:1VYMZUNQpHdhMZc8TyNA-0BanLU8W4ICYmxiu4a3CgofIGZ6MgPF0w>
    <xmx:1VYMZdn6vCl-osExQhtepn_BXtrYjtrg2tJWcgSvnH1wjZWkKR9TDQ>
    <xmx:1lYMZbdCTPLDAjLSBs_cDSBaBIp5qirkdu7l70MzgiVM7nDRkYGFZA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 10:44:36 -0400 (EDT)
Message-ID: <ebf417f0-68ec-466d-8bc4-a382ad6a9501@fastmail.fm>
Date:   Thu, 21 Sep 2023 16:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
To:     Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Horst Birthelmer <hbirthelmer@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <CAOQ4uxi+jk7rv7mtnpH4RXbZJx6N+cWecqd3UyJJHsW8yw_SXg@mail.gmail.com>
 <b22b8760-fca0-4251-b1a8-5989c26e1657@ddn.com>
 <CAOQ4uxgbSFDfgz1vFnDAaJo-36T6UPnUXZnk_y=bZMi0NqzvKQ@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxgbSFDfgz1vFnDAaJo-36T6UPnUXZnk_y=bZMi0NqzvKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/21/23 16:24, Amir Goldstein wrote:
> On Thu, Sep 21, 2023 at 3:00 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 9/21/23 11:33, Amir Goldstein wrote:
>>> On Thu, Sep 21, 2023 at 9:31 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> In FUSE, as of now, uncached lookups are expensive over the wire.
>>>> E.g additional latencies and stressing (meta data) servers from
>>>> thousands of clients. With atomic-open lookup before open
>>>> can be avoided.
>>>>
>>>> Here is the link to performance numbers
>>>> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/
>>>>
>>>> Here is the libfuse pull request
>>>> https://github.com/libfuse/libfuse/pull/813
>>>>
>>>> The patches are passing passthrough_hp xfstests (libfuse part applied),
>>>> although we had to introduce umount retries into xfstests, as recent
>>>> kernels/xfstests fail umount in some tests with
>>>> EBUSY - independent of atomic open. (Although outstanding for v7)
>>>
>>> Hi Bernd!
>>>
>>> I was using xfstests to test passthrough_hp (for FUSE kernel passthrough).
>>> FYI, I have made some improvements to the mount helper
>>> in libfuse [1] to support remount, which helps pass a few tests.
>>
>> Thanks, just asked there to send it separate to upstream.
>>
>>>
>>> So far, I have all the tests in group -g quick.rw pass with the baseline
>>> passthrough_hp (over xfs).
>>>
>>> Do you have a baseline for the entire quick/auto group to share with me?
>>
>> Please find my results attached.
> 
> Not too bad.
> 3 more tests can pass with my mount helper fix for remount ;)
> 
>> I have opened a libfuse issue for generic/477,
>> (open_by_handle_at tests) but I'm not sure if this is passthrough_hp only (it
>> trusts the passed node id, without checking if there is an inode object for it).
>> Possibly fuse.ko passes an invalide node id - this is something for a rainy
>> weekend (or so) to investigate...
> 
> Stale file handles after mount cycle are expected.
> FUSE is not equipped to handle this correctly.

I know and I don't have a problem with that. Issue is that the test triggers a
heap buffer overflow,  see the ASAN report here

https://github.com/libfuse/libfuse/issues/838

A possible reason might be an invalid node id by open_by_handle_at, or
lookup/release is not right. As I said, will investigate once I have a free
minute.

> 
> NFS clients may even get access to the wrong inode
> after FUSE restart/reexport, if FUSE is exported with the same
> NFS fsid.
> 
> See this discussion [3] about how this could be solved hackishly
> with existing FUSE protocol (for fs that know how to open by ino)
> and about the LOOKUP_HANDLE protocol command that is
> needed to solve this in a generic way.

I will read through it later. I would prefer adding support up to
MAX_HANDLE_SZ - our file systems typically exceed 64 bit inode sizes.
Without having it read, I would just expose exportfs methods to userspace
(which might be the LOOKUP_HANDLE protocol).


> 
>>
>>
>>> Can you share the patch that you are using to avoid the EBUSY errors?
>>
>>
>> The simple version to avoid _most_ of EBUSY is this
>>
>>
>> diff --git a/common/rc b/common/rc
>> index 741579af..a40fca3b 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -305,6 +305,7 @@ _scratch_mount_idmapped()
>>
>>    _scratch_unmount()
>>    {
>> +       sync
>>           case "$FSTYP" in
>>           overlay)
>>                   _overlay_scratch_unmount
>>
>>
>>
>> The better version is this
>> https://github.com/kdave/xfstests/commit/33a15af07bb044e2773a83df1c7e0a0df280a4b7
>>
>>>
>>> Note that Chritian has suggested a method to use inotify
>>> IN_UNMOUNT event to wait for sb shutdown in fstests [2].
>>
>> Thanks, I had seen the discussion. Although I (silently) wondered if something
>> like MNT_BLOCk as umount2 flag wouldn't be easier.
>>
> 
> You'd better keep wondering silently unless you want to upset Christian ;)

Ouch, Christian is in CC, inotify is fine ;)


Thanks,
Bernd

