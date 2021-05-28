Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC1393B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 04:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhE1Cct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 22:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233824AbhE1Ccs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 22:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622169074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9EGKgkb8o4xv2IZRZTEVrb1Y1+m/UXhkrrjmtsfSqmQ=;
        b=Dz/+ZFEeytbF90rFAvvFvEM11SvkR+Bzir6ipkQL+h0Qgv1mKT47IvKHXrzKa0L1ZWNaM5
        7G1eFVgEEEZGq/s8kvz7aWmPJCYWWvVv5LYbaXgFrgKJPqb7Zreec26vAJYR3j34WjoTg5
        A/acKWOqXePaQWuxMH/ybMCTL6O4wpA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-4kQUUXNOPge_B-NZLKXTOA-1; Thu, 27 May 2021 22:31:12 -0400
X-MC-Unique: 4kQUUXNOPge_B-NZLKXTOA-1
Received: by mail-pl1-f199.google.com with SMTP id t2-20020a170902d202b02900fee5c3472cso654329ply.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 19:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9EGKgkb8o4xv2IZRZTEVrb1Y1+m/UXhkrrjmtsfSqmQ=;
        b=RhwaSMHEh6tEEwa+pA0DDzMhEY8e3t+0NXk2nJ7Ib9KPmYz33ZuRLsW1lpz302koDx
         jHo4qt+r5UjVhmMoYLbkiUeAzI5Yd/bOLnnqncyuQwfAWBB2TaGRUcir4lf+GGzxzenO
         FxxjmYL3XsanI/HXHLX3f+/jWsFac/uXFFipM0uRezYFCK6InILj947E1cA+h6PH5ttr
         qjRfkkQnLEAJxr5ylAlR/WPmTaqCzKzwzEhfici8mIeelGkrHJ6wkcAJpkfaqtgkb4Vr
         BDJPdabnX5XjJ9f24rz+TiJff3j7YwsuHCY20Y/2QMHJRo7KBYp2I87N2vTNfE1QYvd4
         /jTg==
X-Gm-Message-State: AOAM530pv+KLFH1m379PXE7xctqhVecHMYFZ/Mtqk57ge8oQdgpXYzox
        QcdvUJUdkpmMqMP80f9BzmyZpT8NcG0zGwdhqZL0r4Ec2lbmcWkSDatvd8ZS+UPOhf4EgQpR5VP
        IYga+DKP22PSMFNfVWobYg9MmHQ==
X-Received: by 2002:a17:903:1d0:b029:fd:b754:5b8d with SMTP id e16-20020a17090301d0b02900fdb7545b8dmr6051983plh.76.1622169071557;
        Thu, 27 May 2021 19:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3iJPxs/zsjpLpOcecD0zg+TsVkVvFwUGn6NU1wfATInhZz+P2BUuHZdQCGRFkKA1lSiT38Q==
X-Received: by 2002:a17:903:1d0:b029:fd:b754:5b8d with SMTP id e16-20020a17090301d0b02900fdb7545b8dmr6051955plh.76.1622169071233;
        Thu, 27 May 2021 19:31:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t14sm2733839pfg.168.2021.05.27.19.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 19:31:10 -0700 (PDT)
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
 <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f20edd55-20cb-c016-b347-dd71c5406ed8@redhat.com>
Date:   Fri, 28 May 2021 10:31:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/5/27 下午9:17, Yongji Xie 写道:
> On Thu, May 27, 2021 at 4:41 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/27 下午3:34, Yongji Xie 写道:
>>> On Thu, May 27, 2021 at 1:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> 在 2021/5/27 下午1:08, Yongji Xie 写道:
>>>>> On Thu, May 27, 2021 at 1:00 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>> 在 2021/5/27 下午12:57, Yongji Xie 写道:
>>>>>>> On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>> 在 2021/5/17 下午5:55, Xie Yongji 写道:
>>>>>>>>> +
>>>>>>>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>>>>>>>> +                           struct vduse_dev_msg *msg)
>>>>>>>>> +{
>>>>>>>>> +     init_waitqueue_head(&msg->waitq);
>>>>>>>>> +     spin_lock(&dev->msg_lock);
>>>>>>>>> +     vduse_enqueue_msg(&dev->send_list, msg);
>>>>>>>>> +     wake_up(&dev->waitq);
>>>>>>>>> +     spin_unlock(&dev->msg_lock);
>>>>>>>>> +     wait_event_killable(msg->waitq, msg->completed);
>>>>>>>> What happens if the userspace(malicous) doesn't give a response forever?
>>>>>>>>
>>>>>>>> It looks like a DOS. If yes, we need to consider a way to fix that.
>>>>>>>>
>>>>>>> How about using wait_event_killable_timeout() instead?
>>>>>> Probably, and then we need choose a suitable timeout and more important,
>>>>>> need to report the failure to virtio.
>>>>>>
>>>>> Makes sense to me. But it looks like some
>>>>> vdpa_config_ops/virtio_config_ops such as set_status() didn't have a
>>>>> return value.  Now I add a WARN_ON() for the failure. Do you mean we
>>>>> need to add some change for virtio core to handle the failure?
>>>> Maybe, but I'm not sure how hard we can do that.
>>>>
>>> We need to change all virtio device drivers in this way.
>>
>> Probably.
>>
>>
>>>> We had NEEDS_RESET but it looks we don't implement it.
>>>>
>>> Could it handle the failure of get_feature() and get/set_config()?
>>
>> Looks not:
>>
>> "
>>
>> The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state
>> that a reset is needed. If DRIVER_OK is set, after it sets
>> DEVICE_NEEDS_RESET, the device MUST send a device configuration change
>> notification to the driver.
>>
>> "
>>
>> This looks implies that NEEDS_RESET may only work after device is
>> probed. But in the current design, even the reset() is not reliable.
>>
>>
>>>> Or a rough idea is that maybe need some relaxing to be coupled loosely
>>>> with userspace. E.g the device (control path) is implemented in the
>>>> kernel but the datapath is implemented in the userspace like TUN/TAP.
>>>>
>>> I think it can work for most cases. One problem is that the set_config
>>> might change the behavior of the data path at runtime, e.g.
>>> virtnet_set_mac_address() in the virtio-net driver and
>>> cache_type_store() in the virtio-blk driver. Not sure if this path is
>>> able to return before the datapath is aware of this change.
>>
>> Good point.
>>
>> But set_config() should be rare:
>>
>> E.g in the case of virtio-net with VERSION_1, config space is read only,
>> and it was set via control vq.
>>
>> For block, we can
>>
>> 1) start from without WCE or
>> 2) we add a config change notification to userspace or
> I prefer this way. And I think we also need to do similar things for
> set/get_vq_state().


Yes, I agree.

Thanks


>
> Thanks,
> Yongji
>

