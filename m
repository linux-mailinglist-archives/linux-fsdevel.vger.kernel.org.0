Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFA361966
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 07:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhDPFk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 01:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhDPFk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618551601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXR+AvjVGuda7dQOFocgVCv8J9VhytFo6/uOxLJAmq8=;
        b=bHuiAapDUJBk0jCKIETWeFO3bvYefceLHqJHFNYnE1E9wvN90wEAGihHXH065OkfolM3rz
        VC74UB9gY/ETSZ1Ujl5pwSqvEPEgKCDBaf1R+ny0pgKFKNVaY0opCbGsa/TuTKBeXUaNn/
        G67A5mCgggO/94KROTOOIoLR5S5a514=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-lHWnn7OmOVy-u-w2jP_QdQ-1; Fri, 16 Apr 2021 01:40:00 -0400
X-MC-Unique: lHWnn7OmOVy-u-w2jP_QdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6821F107ACC7;
        Fri, 16 Apr 2021 05:39:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com [10.72.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EAD25D9C0;
        Fri, 16 Apr 2021 05:39:47 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] Documentation: Add documentation for VDUSE
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-11-xieyongji@bytedance.com>
 <YHb44R4HyLEUVSTF@stefanha-x1.localdomain>
 <CACycT3uNR+nZY5gY0UhPkeOyi7Za6XkX4b=hasuDcgqdc7fqfg@mail.gmail.com>
 <YHfo8pc7dIO9lNc3@stefanha-x1.localdomain>
 <80b31814-9e41-3153-7efb-c0c2fab44feb@redhat.com>
 <YHhP4i+yXgA2KkVJ@stefanha-x1.localdomain>
 <31aa139a-dd4e-ba8a-c671-a2a1c69c1ffc@redhat.com>
 <CACycT3u_qAE=D_ezLPU9SpXPMACErmpqpH5pMg0TZAb3CZVGdg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fab615ce-5e13-a3b3-3715-a4203b4ab010@redhat.com>
Date:   Fri, 16 Apr 2021 13:39:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACycT3u_qAE=D_ezLPU9SpXPMACErmpqpH5pMg0TZAb3CZVGdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/4/16 上午11:19, Yongji Xie 写道:
> On Fri, Apr 16, 2021 at 10:24 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/4/15 下午10:38, Stefan Hajnoczi 写道:
>>> On Thu, Apr 15, 2021 at 04:36:35PM +0800, Jason Wang wrote:
>>>> 在 2021/4/15 下午3:19, Stefan Hajnoczi 写道:
>>>>> On Thu, Apr 15, 2021 at 01:38:37PM +0800, Yongji Xie wrote:
>>>>>> On Wed, Apr 14, 2021 at 10:15 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>>>>> On Wed, Mar 31, 2021 at 04:05:19PM +0800, Xie Yongji wrote:
>>>>>>>> VDUSE (vDPA Device in Userspace) is a framework to support
>>>>>>>> implementing software-emulated vDPA devices in userspace. This
>>>>>>>> document is intended to clarify the VDUSE design and usage.
>>>>>>>>
>>>>>>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>>>>>>> ---
>>>>>>>>     Documentation/userspace-api/index.rst |   1 +
>>>>>>>>     Documentation/userspace-api/vduse.rst | 212 ++++++++++++++++++++++++++++++++++
>>>>>>>>     2 files changed, 213 insertions(+)
>>>>>>>>     create mode 100644 Documentation/userspace-api/vduse.rst
>>>>>>> Just looking over the documentation briefly (I haven't studied the code
>>>>>>> yet)...
>>>>>>>
>>>>>> Thank you!
>>>>>>
>>>>>>>> +How VDUSE works
>>>>>>>> +------------
>>>>>>>> +Each userspace vDPA device is created by the VDUSE_CREATE_DEV ioctl on
>>>>>>>> +the character device (/dev/vduse/control). Then a device file with the
>>>>>>>> +specified name (/dev/vduse/$NAME) will appear, which can be used to
>>>>>>>> +implement the userspace vDPA device's control path and data path.
>>>>>>> These steps are taken after sending the VDPA_CMD_DEV_NEW netlink
>>>>>>> message? (Please consider reordering the documentation to make it clear
>>>>>>> what the sequence of steps are.)
>>>>>>>
>>>>>> No, VDUSE devices should be created before sending the
>>>>>> VDPA_CMD_DEV_NEW netlink messages which might produce I/Os to VDUSE.
>>>>> I see. Please include an overview of the steps before going into detail.
>>>>> Something like:
>>>>>
>>>>>      VDUSE devices are started as follows:
>>>>>
>>>>>      1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
>>>>>         /dev/vduse/control.
>>>>>
>>>>>      2. Begin processing VDUSE messages from /dev/vduse/$NAME. The first
>>>>>         messages will arrive while attaching the VDUSE instance to vDPA.
>>>>>
>>>>>      3. Send the VDPA_CMD_DEV_NEW netlink message to attach the VDUSE
>>>>>         instance to vDPA.
>>>>>
>>>>>      VDUSE devices are stopped as follows:
>>>>>
>>>>>      ...
>>>>>
>>>>>>>> +     static int netlink_add_vduse(const char *name, int device_id)
>>>>>>>> +     {
>>>>>>>> +             struct nl_sock *nlsock;
>>>>>>>> +             struct nl_msg *msg;
>>>>>>>> +             int famid;
>>>>>>>> +
>>>>>>>> +             nlsock = nl_socket_alloc();
>>>>>>>> +             if (!nlsock)
>>>>>>>> +                     return -ENOMEM;
>>>>>>>> +
>>>>>>>> +             if (genl_connect(nlsock))
>>>>>>>> +                     goto free_sock;
>>>>>>>> +
>>>>>>>> +             famid = genl_ctrl_resolve(nlsock, VDPA_GENL_NAME);
>>>>>>>> +             if (famid < 0)
>>>>>>>> +                     goto close_sock;
>>>>>>>> +
>>>>>>>> +             msg = nlmsg_alloc();
>>>>>>>> +             if (!msg)
>>>>>>>> +                     goto close_sock;
>>>>>>>> +
>>>>>>>> +             if (!genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, famid, 0, 0,
>>>>>>>> +                 VDPA_CMD_DEV_NEW, 0))
>>>>>>>> +                     goto nla_put_failure;
>>>>>>>> +
>>>>>>>> +             NLA_PUT_STRING(msg, VDPA_ATTR_DEV_NAME, name);
>>>>>>>> +             NLA_PUT_STRING(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse");
>>>>>>>> +             NLA_PUT_U32(msg, VDPA_ATTR_DEV_ID, device_id);
>>>>>>> What are the permission/capability requirements for VDUSE?
>>>>>>>
>>>>>> Now I think we need privileged permission (root user). Because
>>>>>> userspace daemon is able to access avail vring, used vring, descriptor
>>>>>> table in kernel driver directly.
>>>>> Please state this explicitly at the start of the document. Existing
>>>>> interfaces like FUSE are designed to avoid trusting userspace.
>>>> There're some subtle difference here. VDUSE present a device to kernel which
>>>> means IOMMU is probably the only thing to prevent a malicous device.
>>>>
>>>>
>>>>> Therefore
>>>>> people might think the same is the case here. It's critical that people
>>>>> are aware of this before deploying VDUSE with virtio-vdpa.
>>>>>
>>>>> We should probably pause here and think about whether it's possible to
>>>>> avoid trusting userspace. Even if it takes some effort and costs some
>>>>> performance it would probably be worthwhile.
>>>> Since the bounce buffer is used the only attack surface is the coherent
>>>> area, if we want to enforce stronger isolation we need to use shadow
>>>> virtqueue (which is proposed in earlier version by me) in this case. But I'm
>>>> not sure it's worth to do that.
>>> The security situation needs to be clear before merging this feature.
>>
>> +1
>>
>>
>>> I think the IOMMU and vring can be made secure. What is more concerning
>>> is the kernel code that runs on top: VIRTIO device drivers, network
>>> stack, file systems, etc. They trust devices to an extent.
>>>
>>> Since virtio-vdpa is a big reason for doing VDUSE in the first place I
>>> don't think it makes sense to disable virtio-vdpa with VDUSE. A solution
>>> is needed.
>>
>> Yes, so the case of VDUSE is something similar to the case of e.g SEV.
>>
>> Both cases won't trust device and use some kind of software IOTLB.
>>
>> That means we need to protect at both IOTLB and virtio drivers.
>>
>> Let me post patches for virtio first.
>>
> Looking forward your patches.
>
> Thanks.
> Yongji
>

Fortuantely, packed ring has already did this since the descriptor talbe 
is expected to be re-wrote by the device. I just need to conver the 
split ring.

Thanks



