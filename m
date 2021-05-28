Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF06393B0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhE1Bf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 21:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235598AbhE1Bf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 21:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622165634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8EflzxBdWy0wiqxEhDGP+Q2T2EKetKqpgEpZkAeYf/A=;
        b=S4yJIAdo04HShBOeEztagfuSKahh7K8Fs6P3wYnWR3yYdOQycT+MVrrAoZUfJ93bznh5cW
        JnMj6D9FZ/Zfkkw+6343e4kc/73qiP1AixXluONg6+MbYoGrOMQN2dxECYmzxslQ0tnPKU
        CoSeACifCz8qPc/Y4ykVSaIX221zrpc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-rMukT_TYPTqpVW76fmsvqA-1; Thu, 27 May 2021 21:33:53 -0400
X-MC-Unique: rMukT_TYPTqpVW76fmsvqA-1
Received: by mail-pj1-f71.google.com with SMTP id v10-20020a17090a7c0ab029015f673a4c30so1612521pjf.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 18:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8EflzxBdWy0wiqxEhDGP+Q2T2EKetKqpgEpZkAeYf/A=;
        b=eJIxYhWhOIjAbdX8Lb5DGnpuI+1//LP0igVF6qrnm5OABDJ1BfIdKA8kq00HdymBna
         y/kDCP7rfVMzxoBRO2eGinuHU0iCAPrEy0qebpMBbMgNAipfyVSQvmTWI/fe/pjJUKLO
         5kbtrwSGL6LOneMayLdfy0q7l185ZEgGkFpNLP85L4ew8DdZ2fJQzFum3jIBBP/OYqfM
         qJVPh0RYwGxChJ4JhRvu/XqN0Fkgdl5fAWt8r823acoRm/bUKP66o4eXXGxLCi88/HkZ
         l4pMyb9cucTTPbXgWl0h2DFIPqc/m+qFJirxdZuO88zt++OtfzPMpO/x5YImQvrBj0dF
         Z6Aw==
X-Gm-Message-State: AOAM532bJEwM0ANT98haV2HecBbDZ5I6NDlddonTGEVXKbAlQa1iehsE
        2MvQV6QORh63l7bq4Pw6f9ikqzg9iPlQl51N+qQoxwzBx5EYhJ+D55jCp3tJVbwirNgDAOaMukZ
        5Kbc2F8YlHILhQ/+3ABd2iAz5iw==
X-Received: by 2002:a17:90a:4d01:: with SMTP id c1mr1544229pjg.113.1622165631945;
        Thu, 27 May 2021 18:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydC/stmtwVBAw7vn0dDxdtXv7rokRxoXkgRqgTNFUSMcTPVSj5vrj1iqRSI/twfonCL/POEw==
X-Received: by 2002:a17:90a:4d01:: with SMTP id c1mr1544208pjg.113.1622165631682;
        Thu, 27 May 2021 18:33:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g4sm2964265pgu.46.2021.05.27.18.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 18:33:51 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
 <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
 <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <baf0016a-7930-2ae2-399f-c28259f415c1@redhat.com>
Date:   Fri, 28 May 2021 09:33:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/5/27 下午6:14, Yongji Xie 写道:
> On Thu, May 27, 2021 at 4:43 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/27 下午4:41, Jason Wang 写道:
>>> 在 2021/5/27 下午3:34, Yongji Xie 写道:
>>>> On Thu, May 27, 2021 at 1:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>> 在 2021/5/27 下午1:08, Yongji Xie 写道:
>>>>>> On Thu, May 27, 2021 at 1:00 PM Jason Wang <jasowang@redhat.com>
>>>>>> wrote:
>>>>>>> 在 2021/5/27 下午12:57, Yongji Xie 写道:
>>>>>>>> On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com>
>>>>>>>> wrote:
>>>>>>>>> 在 2021/5/17 下午5:55, Xie Yongji 写道:
>>>>>>>>>> +
>>>>>>>>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>>>>>>>>> +                           struct vduse_dev_msg *msg)
>>>>>>>>>> +{
>>>>>>>>>> +     init_waitqueue_head(&msg->waitq);
>>>>>>>>>> +     spin_lock(&dev->msg_lock);
>>>>>>>>>> +     vduse_enqueue_msg(&dev->send_list, msg);
>>>>>>>>>> +     wake_up(&dev->waitq);
>>>>>>>>>> +     spin_unlock(&dev->msg_lock);
>>>>>>>>>> +     wait_event_killable(msg->waitq, msg->completed);
>>>>>>>>> What happens if the userspace(malicous) doesn't give a response
>>>>>>>>> forever?
>>>>>>>>>
>>>>>>>>> It looks like a DOS. If yes, we need to consider a way to fix that.
>>>>>>>>>
>>>>>>>> How about using wait_event_killable_timeout() instead?
>>>>>>> Probably, and then we need choose a suitable timeout and more
>>>>>>> important,
>>>>>>> need to report the failure to virtio.
>>>>>>>
>>>>>> Makes sense to me. But it looks like some
>>>>>> vdpa_config_ops/virtio_config_ops such as set_status() didn't have a
>>>>>> return value.  Now I add a WARN_ON() for the failure. Do you mean we
>>>>>> need to add some change for virtio core to handle the failure?
>>>>> Maybe, but I'm not sure how hard we can do that.
>>>>>
>>>> We need to change all virtio device drivers in this way.
>>>
>>> Probably.
>>>
>>>
>>>>> We had NEEDS_RESET but it looks we don't implement it.
>>>>>
>>>> Could it handle the failure of get_feature() and get/set_config()?
>>>
>>> Looks not:
>>>
>>> "
>>>
>>> The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state
>>> that a reset is needed. If DRIVER_OK is set, after it sets
>>> DEVICE_NEEDS_RESET, the device MUST send a device configuration change
>>> notification to the driver.
>>>
>>> "
>>>
>>> This looks implies that NEEDS_RESET may only work after device is
>>> probed. But in the current design, even the reset() is not reliable.
>>>
>>>
>>>>> Or a rough idea is that maybe need some relaxing to be coupled loosely
>>>>> with userspace. E.g the device (control path) is implemented in the
>>>>> kernel but the datapath is implemented in the userspace like TUN/TAP.
>>>>>
>>>> I think it can work for most cases. One problem is that the set_config
>>>> might change the behavior of the data path at runtime, e.g.
>>>> virtnet_set_mac_address() in the virtio-net driver and
>>>> cache_type_store() in the virtio-blk driver. Not sure if this path is
>>>> able to return before the datapath is aware of this change.
>>>
>>> Good point.
>>>
>>> But set_config() should be rare:
>>>
>>> E.g in the case of virtio-net with VERSION_1, config space is read
>>> only, and it was set via control vq.
>>>
>>> For block, we can
>>>
>>> 1) start from without WCE or
>>> 2) we add a config change notification to userspace or
>>> 3) extend the spec to use vq instead of config space
>>>
>>> Thanks
>>
>> Another thing if we want to go this way:
>>
>> We need find a way to terminate the data path from the kernel side, to
>> implement to reset semantic.
>>
> Do you mean terminate the data path in vdpa_reset().


Yes.


>   Is it ok to just
> notify userspace to stop data path asynchronously?


For well-behaved userspace, yes but no for buggy or malicious ones.

I had an idea, how about terminate IOTLB in this case? Then we're in 
fact turn datapath off.

Thanks


>   Userspace should
> not be able to do any I/O at that time because the iotlb mapping is
> already removed.
>
> Thanks,
> Yongji
>

