Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417E73926F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 07:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhE0FmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 01:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE0FmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 01:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622094043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AU/RuY2ymovNRYn9DIYtROZdNQLFTgpR1rexfb2OF3c=;
        b=N1/ocHRmo7AWpG6/7nLrdOYRAd5Uru10vZ6ei9T4zNgzfrbNjdD/3CTsBheXanRxPW2CSU
        Fsa2dqfqhI8XeCvsCa6NVLat7P/lAfXr+ce986tyzHq+dJ3cPuqjIGQUfzda39lsGfD5bz
        h788r12lhHM1nZAtw0hHM4mu8yjmvng=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-W4mpGtN7P2uVvGiCcLExuA-1; Thu, 27 May 2021 01:40:41 -0400
X-MC-Unique: W4mpGtN7P2uVvGiCcLExuA-1
Received: by mail-pg1-f198.google.com with SMTP id s5-20020a63d0450000b029021cb0aff563so2272245pgi.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 22:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AU/RuY2ymovNRYn9DIYtROZdNQLFTgpR1rexfb2OF3c=;
        b=OddY15shIyOLtJexEO9hIZMwSwzZd46JjGYaZQorDm5poaTd/Pv5KV9ledPoi7yKrL
         LCZS0yemsVVs8a1zZ+aXHSaGVm9x0zDOmW1KSoFtNC1hxrB7ycGjLTGdFPF0w27QgD9D
         v3wwucB2ik988OueXpdhw3CcMX7/X9BWLfgC/uMUIgfUFUfFUbwJ37kGerIMxW9qCqwk
         NJYhYivzWLB4kh+nzYsSg1Z16d1bucIE16zspPFPEbtUVQ+XUeHyApSq+5RVbYEgxZ2r
         8F3u2TdVU9PBjScQe7f3+DpYOCZMSsHi46Qsp0+T91Wzq9Qkm1IoQD6yn3hD24uG3mGc
         c2GA==
X-Gm-Message-State: AOAM5324fntKkqp3Q26E86wxacPopDdNBu8repJ2wByHoB4jVMhFGa5Z
        MR+UmdUungz/1ho9XNkx/3O85/gz2U6j1AITIjle6nAxnrQe51YI8jXO9Ej77JFr0AOBU7DaRt+
        Sn0IEwRBnPMSv68v6WdKzFfdcHw==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr7691840pjs.9.1622094040613;
        Wed, 26 May 2021 22:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdvc47LfRqVL36pEPdXD9AUGFkROiA0ecx8aq5qhRtKjUnV9VTluCW50o4cKagpZC5qThkZA==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr7691807pjs.9.1622094040375;
        Wed, 26 May 2021 22:40:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z19sm851114pjq.11.2021.05.26.22.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 22:40:39 -0700 (PDT)
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
Date:   Thu, 27 May 2021 13:40:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/5/27 下午1:08, Yongji Xie 写道:
> On Thu, May 27, 2021 at 1:00 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/27 下午12:57, Yongji Xie 写道:
>>> On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> 在 2021/5/17 下午5:55, Xie Yongji 写道:
>>>>> +
>>>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>>>> +                           struct vduse_dev_msg *msg)
>>>>> +{
>>>>> +     init_waitqueue_head(&msg->waitq);
>>>>> +     spin_lock(&dev->msg_lock);
>>>>> +     vduse_enqueue_msg(&dev->send_list, msg);
>>>>> +     wake_up(&dev->waitq);
>>>>> +     spin_unlock(&dev->msg_lock);
>>>>> +     wait_event_killable(msg->waitq, msg->completed);
>>>> What happens if the userspace(malicous) doesn't give a response forever?
>>>>
>>>> It looks like a DOS. If yes, we need to consider a way to fix that.
>>>>
>>> How about using wait_event_killable_timeout() instead?
>>
>> Probably, and then we need choose a suitable timeout and more important,
>> need to report the failure to virtio.
>>
> Makes sense to me. But it looks like some
> vdpa_config_ops/virtio_config_ops such as set_status() didn't have a
> return value.  Now I add a WARN_ON() for the failure. Do you mean we
> need to add some change for virtio core to handle the failure?


Maybe, but I'm not sure how hard we can do that.

We had NEEDS_RESET but it looks we don't implement it.

Or a rough idea is that maybe need some relaxing to be coupled loosely 
with userspace. E.g the device (control path) is implemented in the 
kernel but the datapath is implemented in the userspace like TUN/TAP.

Thanks

>
> Thanks,
> Yongji
>

