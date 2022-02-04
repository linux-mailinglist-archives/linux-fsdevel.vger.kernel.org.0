Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94B4A950E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352060AbiBDIYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 03:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345213AbiBDIYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:24:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A1C06173D
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Feb 2022 00:24:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id h7so17084766ejf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Feb 2022 00:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+AJzw4pLVP6piQQ8DJ6FcW2rv83/BHBjZGX/F+I/5C4=;
        b=Be5ov5gRTokjg21xyNf+ohGtnsQqDmD5CpogVJAXrnVz7pcHBReU3EKuZVtKt4Tw/w
         RDcn4+ueTA4m3ociZUooQ/VSUz3b9a58vjo7nJ/Hli8DSbbZtEPUvDVwZH40LA/ByK1h
         mkWQHDVpTChQTI+dNdwTriPMcFCGtP4xz0vuE6s8JoGHah/8CmMO+m7uOrLICrWvo7I0
         G0FCSCS1JRJJr87Ow3i8npF6I4zG3xBdyz0bittGNIKmc8CnFGCEP83qtpr4iUUrGgFK
         skH8Hp0XEyEDf/nOhXwfNesNPqOB1Pp2msfiVJJq4EnftBMldbpnYneRb8cxXlSx8a/P
         UWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+AJzw4pLVP6piQQ8DJ6FcW2rv83/BHBjZGX/F+I/5C4=;
        b=eUfJV2fKKMCxGpxgab3TcimY0OUd5SVU/LR3NArPYrQs38GweSWHisQBOJq9f3Ke1X
         wUX8BVlxkU7lRZwizjcuh8lKV2NH5YILK/rkON6ZbiHw5H1nILFMGIiH4EfBWURr0CXF
         kHNV7a+RPnTw9XSzY29Mi/BEgF8j8MrQO9kJxCe0h/PaPKsGKAI9ctrjzDlsHBGr6Cco
         RjPtCzWEuxM7rArM7O67X7h6u0xiCx8o+wB3aceyfzsQtutLmr12bra9OKK/y5SGE5I4
         gkmZFLM9YcxQ8ISL1/5OYGJBv77yfoKGs07QjdvYKCIiVoWiIlGxhwbW7JuoYPC1QH20
         H1uQ==
X-Gm-Message-State: AOAM533F0loUHHp8UmEt9yCIiBKmNhRxYNmSptKVYD9pWawY04fR775k
        c9QSWguiukhUFmnAMurkNw7VCg==
X-Google-Smtp-Source: ABdhPJyAfQjC4kR5eZYldFqWF50m/eUAUll5gwN5OdXOAvaJGO24XxVigDE5qacG6WGLefG1r9JSCg==
X-Received: by 2002:a17:906:9b8e:: with SMTP id dd14mr1449134ejc.6.1643963086917;
        Fri, 04 Feb 2022 00:24:46 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id u3sm409447ejz.99.2022.02.04.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:24:46 -0800 (PST)
Date:   Fri, 4 Feb 2022 09:24:45 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local>
References: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
 <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
 <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.02.2022 07:58, Chaitanya Kulkarni wrote:
>On 2/3/22 22:28, Damien Le Moal wrote:
>> On 2/4/22 12:12, Chaitanya Kulkarni wrote:
>>>
>>>>>> One can instantiate scsi devices with qemu by using fake scsi devices,
>>>>>> but one can also just use scsi_debug to do the same. I see both efforts
>>>>>> as desirable, so long as someone mantains this.
>>>>>>
>>>
>>> Why do you think both efforts are desirable ?
>>
>> When testing code using the functionality, it is far easier to get said
>> functionality doing a simple "modprobe" rather than having to setup a
>> VM. C.f. running blktests or fstests.
>>
>
>agree on simplicity but then why do we have QEMU implementations for
>the NVMe features (e.g. ZNS, NVMe Simple Copy) ? we can just build
>memoery backed NVMeOF test target for NVMe controller features.
>
>Also, recognizing the simplicity I proposed initially NVMe ZNS
>fabrics based emulation over QEMU (I think I still have initial state
>machine implementation code for ZNS somewhere), those were "nacked" for
>the right reason, since we've decided go with QEMU and use that as a
>primary platform for testing, so I failed to understand what has
>changed.. since given that QEMU already supports NVMe simple copy ...

I was not part of this conversation, but as I see it each approach give
a benefit. QEMU is fantastic for compliance testing and I am not sure
you get the same level of command analysis anywhere else; at least not
without writing dedicated code for this in a target.

This said, when we want to test for race conditions, QEMU is very slow.
For a software-only solution, we have experimented with something
similar to the nvme-debug code tha Mikulas is proposing. Adam pointed to
the nvme-loop target as an alternative and this seems to work pretty
nicely. I do not believe there should be many changes to support copy
offload using this.

So in my view having both is not replication and it gives more
flexibility for validation, which I believe it is always good.

>
>> So personally, I also think it would be great to have a kernel-based
>> emulation of copy offload. And that should be very easy to implement
>> with the fabric code. Then loopback onto a nullblk device and you get a
>> quick and easy to setup copy-offload device that can even be of the ZNS
>> variant if you want since nullblk supports zones.
>>
>
>One can do that with creating null_blk based NVMeOF target namespace,
>no need to emulate simple copy memory backed code in the fabrics
>with nvme-loop.. it is as simple as inserting module and configuring
>ns with nvmetcli once we have finalized the solution for copy offload.
>If you remember, I already have patches for that...
>
>>>
>>> NVMe ZNS QEMU implementation proved to be perfect and works just
>>> fine for testing, copy offload is not an exception.
>>>
>>>>>> For instance, blktests uses scsi_debug for simplicity.
>>>>>>
>>>>>> In the end you decide what you want to use.
>>>>>
>>>>> Can we use the nvme-loop target instead?
>>>>
>>>> I am advocating for this approach as well. It presentas a virtual nvme
>>>> controller already.
>>>>
>>>
>>> It does that assuming underlying block device such as null_blk or
>>> QEMU implementation supports required features not to bloat the the
>>> NVMeOF target.
>>>
>>> -ck
>>>
>
>-ck
>
