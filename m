Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710014CFCF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 12:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiCGLdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 06:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiCGLdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:33:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27AB31200
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 03:29:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f8so19392251edf.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T4acKnzVRK53XAhNeOXzw4+hZnnGtqTbL8jwbA7d8Es=;
        b=4zPGDx3wAn33cL2ZPDTE3Vn1srNgVPZzkZ+kXLtEIE9G5f1cclmGtXAunITyuGoSOE
         VHEqxj237Hly6FxpKyBF7eyLmZ80u70BrzsbM4n/8GRtNr4k9CnzcjzLvtsRrwH1XPCl
         sX+fsHe9CmTpu10QjApm7KcqNU0KHEnsK7yKUpocHSKpuFqRs1bwo8abLvSBjgEZtecX
         KDEoqlHwFzX6VSFmPIEZ5TFZBJSX5sp0IgZ6CD7OBXItj42fgVes3VrhGH6hAhrmTWXt
         VXlusoN8Q/TKkLS0pHvaYWme1ZTje5z/ibQ/XGHp7EsdGrhcuiMaTHK0G7Wm9lodXl2t
         8ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T4acKnzVRK53XAhNeOXzw4+hZnnGtqTbL8jwbA7d8Es=;
        b=aTVZU/WgtXXAUKLZ3DSbk5mgH61QK25zwUCxke3KS7k1vOkbUYQR9wkbzYRiBiO/Pd
         tuZHabtdb17GISedaDdPq2XUHxvW8HJcR7dFX7aNFx9THIWndQ71zwoPz/DKztlIUx9I
         4jJmJWQvjBXR6YhbKbyxd3uGIO47dejlnVRF1ZMnZ54ioPVgo600Ae35gPPX3aPuUH0i
         BYzgX3CvRfU3r4W2ccDrSOMAINg8S2m84T8aInhVxkQuwzX8IPpPJPdJ5pczQmlZoBkV
         SWxfZ7nPwPin7LidwmuBigiZBplaS0IpXmYy3vAjZqrxNVlnOqm2cnGfyK06ZBvsld2z
         iopg==
X-Gm-Message-State: AOAM530M0B+CsPzBhIpodArpPSJZoc2dvH10UI5F6lGnGEZJlvriUDX6
        VIED/D0XuJ+SdTnw/6bFxxU0uA==
X-Google-Smtp-Source: ABdhPJy/hppSMSCKvshni7v3R5KpP7hRSUmHGqeJTncIJJlKs3xHUIPHVWiof+HTB3voVflCIsttTw==
X-Received: by 2002:a05:6402:4c6:b0:406:d579:2c4 with SMTP id n6-20020a05640204c600b00406d57902c4mr10592930edw.52.1646652587223;
        Mon, 07 Mar 2022 03:29:47 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm6141013eds.21.2022.03.07.03.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:29:46 -0800 (PST)
Date:   Mon, 7 Mar 2022 12:29:45 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220307112824.ehnnec5xv6fsvkpa@ArmHalley.local>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
 <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
 <20220307071229.GR3927073@dread.disaster.area>
 <BYAPR04MB496845AB3EEC1EAD8C7CE4D9F1089@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB496845AB3EEC1EAD8C7CE4D9F1089@BYAPR04MB4968.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.03.2022 10:27, Matias Bjørling wrote:
>> > I understand that you point to ZoneFS for this. It is true that it was
>> > presented at the moment as the way to do raw zone access from
>> > user-space.
>> >
>> > However, there is no users of ZoneFS for ZNS devices that I am aware
>> > of (maybe for SMR this is a different story).  The main open-source
>> > implementations out there for RocksDB that are being used in
>> > production (ZenFS and xZTL) rely on either raw zone block access or
>> > the generic char device in NVMe (/dev/ngXnY).
>>
>> That's exactly the situation we want to avoid.
>>
>> You're talking about accessing Zoned storage by knowing directly about how
>> the hardware works and interfacing directly with hardware specific device
>> commands.
>>
>> This is exactly what is wrong with this whole conversation - direct access to
>> hardware is fragile and very limiting, and the whole purpose of having an
>> operating system is to abstract the hardware functionality into a generally
>> usable API. That way when something new gets added to the hardware or
>> something gets removed, the applications don't because they weren't written
>> with that sort of hardware functionality extension in mind.
>>
>> I understand that RocksDB probably went direct to the hardware because, at
>> the time, it was the only choice the developers had to make use of ZNS based
>> storage. I understand that.
>>
>> However, I also understand that there are *better options now* that allow
>> applications to target zone storage in a way that doesn't expose them to the
>> foibles of hardware support and storage protocol specifications and
>> characteristics.
>>
>> The generic interface that the kernel provides for zoned storage is called
>> ZoneFS. Forget about the fact it is a filesystem, all it does is provide userspace
>> with a named zone abstraction for a zoned
>> device: every zone is an append-only file.
>>
>> That's what I'm trying to get across here - this whole discussion about zone
>> capacity not matching zone size is a hardware/ specification detail that
>> applications *do not need to know about* to use zone storage. That's
>> something taht Zonefs can/does hide from applications completely - the zone
>> files behave exactly the same from the user perspective regardless of whether
>> the hardware zone capacity is the same or less than the zone size.
>>
>> Expanding access the hardware and/or raw block devices to ensure userspace
>> applications can directly manage zone write pointers, zone capacity/space
>> limits, etc is the wrong architectural direction to be taking. The sort of
>> *hardware quirks* being discussed in this thread need to be managed by the
>> kernel and hidden from userspace; userspace shouldn't need to care about
>> such wierd and esoteric hardware and storage
>> protocol/specification/implementation
>> differences.
>>
>> IMO, while RocksDB is the technology leader for ZNS, it is not the model that
>> new applications should be trying to emulate. They should be designed from
>> the ground up to use ZoneFS instead of directly accessing nvme devices or
>> trying to use the raw block devices for zoned storage. Use the generic kernel
>> abstraction for the hardware like applications do for all other things!
>>
>> > This is because having the capability to do zone management from
>> > applications that already work with objects fits much better.
>>
>> ZoneFS doesn't absolve applications from having to perform zone management
>> to pack it's objects and garbage collect stale storage space.  ZoneFS merely
>> provides a generic, file based, hardware independent API for performing these
>> zone management tasks.
>>
>> > My point is that there is space for both ZoneFS and raw zoned block
>> > device. And regarding !PO2 zone sizes, my point is that this can be
>> > leveraged both by btrfs and this raw zone block device.
>>
>> On that I disagree - any argument that starts with "we need raw zoned block
>> device access to ...." is starting from an invalid premise. We should be hiding
>> hardware quirks from userspace, not exposing them further.
>>
>> IMO, we want writing zone storage native applications to be simple and
>> approachable by anyone who knows how to write to append-only files.  We do
>> not want such applications to be limited to people who have deep and rare
>> expertise in the dark details of, say, largely undocumented niche NVMe ZNS
>> specification and protocol quirks.
>>
>> ZoneFS provides us with a path to the former, what you are advocating is the
>> latter....

I agree with all you say. I can see ZoneFS becoming a generic zone API,
but we are not there yet. Rather than advocating for using raw devices,
I am describing how zone devices are being consumed today. So to me
there are 2 things we need to consider: Support current customers and
improve the way future customers consume these devices.

Coming back to the original topic of the LSF/MM discussion, what I would
like to propose is that we support existing, deployed devices that are
running in Linux and do not have PO2 zone sizes. These can then be
consumed by btrfs or presented to applications through ZoneFS. And for
existing customers, this will mean less headaches.

Note here that if we use ZoneFS and all we care is zone capacities, then
the whole PO2 argument to make applications more efficient does not
apply anymore, as applications would be using the real capacity of the
zone. I very much like this approach.

>+ Hans (zenfs/rocksdb author)
>
>Dave, thank you for your great insight. It is a great argument for why zonefs makes sense. I must admit that Damien has been telling me this multiple times, but I didn't fully grok the benefits until seeing it in the light of this thread.
>
>Wrt to RocksDB support using ZenFS - while raw block access was the initial approach, it is very easy to change to use the zonefs API. Hans has already whipped up a plan for how to do it.

This is great. We have been thinking for some time about aligning with
ZenFS for the in-kernel path. This might be the right time to take
action on this.
