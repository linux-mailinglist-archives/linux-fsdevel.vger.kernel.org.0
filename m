Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9175E3C80D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 10:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhGNI77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 04:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238681AbhGNI77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626253027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b67pj1XjCFcb4vjOC6L9gEcYmcQccLEDJzYb3n+c66I=;
        b=NbM7RsWJIkcbd7Zf5cmO5p7jU5A/21B5nXMLmMABf2kzFBvklDuZeVVCndeSpoPxUfe/QZ
        iu6ZRkJiVpc/afy5fVIVMD4+qqAe008dFOJV9uW6MyXqTj16gc5cL45GSZyjxGq4fZoCr+
        c7NOxY6Tmua2w6uieEJKMkk4qz1OLHg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-VmXBWbZKMF6a5OMR93MiDg-1; Wed, 14 Jul 2021 04:57:06 -0400
X-MC-Unique: VmXBWbZKMF6a5OMR93MiDg-1
Received: by mail-pj1-f70.google.com with SMTP id p22-20020a17090a9316b029016a0aced749so876406pjo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 01:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b67pj1XjCFcb4vjOC6L9gEcYmcQccLEDJzYb3n+c66I=;
        b=YBP2WjLAAvdr9Hg+MN8ke911Pez/1PTl92E3CqNV9UwAe+HoKhIG0beo1ldu6QQQZ8
         3i6Gr7Rw8qDrljAlwPYemN+tALmbbdvAyHgreXaKqxIhw3QWXcptZrnjMk3wStsGq0JS
         70yK36Zlg7BUPZIeeb5WFDcCALN92SJbes14lcUcp5bCXvUk1HGEs0SLNwg8Di2fzREC
         FET6jfse3ObtFw9G6yQXrmUSbnrpAA3WyG+bbJTFqa8ptqc/U/V9rrQ+5vzjlkABwA14
         OAETeGR43Km2dih5oUUKVClg5TlASTm/Kxn0f55o612ASdqTqJMyqkZooAIVUPfD7QUS
         vWJg==
X-Gm-Message-State: AOAM530s+T1w/lkEuqQUhv2unZ93lSnvOI7+VPy3ooBNkkacz9hZQvid
        ri9S3nT4xdoNadKK7xBlD48/JEq5KVzrYC8g8o2/XScL3f40pDaHCWOLLOYVVicEyBoTdrg1aVW
        FhCqQ9BcJW0YcBZDr5q7USiqU9g==
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr2814487pjq.129.1626253025290;
        Wed, 14 Jul 2021 01:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI/UxSDMVXZBsCbO/ysTuOL+td5Krg49S3x+yII+Nt1pi43Zbgr08iKwIXB4LRw/hvEMwy1w==
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr2814452pjq.129.1626253024987;
        Wed, 14 Jul 2021 01:57:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d2sm2127796pgh.59.2021.07.14.01.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 01:57:04 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <20210714014817-mutt-send-email-mst@kernel.org>
 <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
 <YO6IiDIMUjQsA2LS@kroah.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a493bc51-9a5c-05f1-2eac-54cb9e6c9d9b@redhat.com>
Date:   Wed, 14 Jul 2021 16:56:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO6IiDIMUjQsA2LS@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/7/14 下午2:47, Greg KH 写道:
> On Wed, Jul 14, 2021 at 02:02:50PM +0800, Jason Wang wrote:
>> 在 2021/7/14 下午1:54, Michael S. Tsirkin 写道:
>>> On Wed, Jul 14, 2021 at 01:45:39PM +0800, Jason Wang wrote:
>>>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>>>> +			      struct vduse_dev_msg *msg)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	init_waitqueue_head(&msg->waitq);
>>>>> +	spin_lock(&dev->msg_lock);
>>>>> +	msg->req.request_id = dev->msg_unique++;
>>>>> +	vduse_enqueue_msg(&dev->send_list, msg);
>>>>> +	wake_up(&dev->waitq);
>>>>> +	spin_unlock(&dev->msg_lock);
>>>>> +
>>>>> +	wait_event_killable_timeout(msg->waitq, msg->completed,
>>>>> +				    VDUSE_REQUEST_TIMEOUT * HZ);
>>>>> +	spin_lock(&dev->msg_lock);
>>>>> +	if (!msg->completed) {
>>>>> +		list_del(&msg->list);
>>>>> +		msg->resp.result = VDUSE_REQ_RESULT_FAILED;
>>>>> +	}
>>>>> +	ret = (msg->resp.result == VDUSE_REQ_RESULT_OK) ? 0 : -EIO;
>>>> I think we should mark the device as malfunction when there is a timeout and
>>>> forbid any userspace operations except for the destroy aftwards for safety.
>>> This looks like if one tried to run gdb on the program the behaviour
>>> will change completely because kernel wants it to respond within
>>> specific time. Looks like a receipe for heisenbugs.
>>>
>>> Let's not build interfaces with arbitrary timeouts like that.
>>> Interruptible wait exists for this very reason.
>>
>> The problem is. Do we want userspace program like modprobe to be stuck for
>> indefinite time and expect the administrator to kill that?
> Why would modprobe be stuck for forever?
>
> Is this on the module probe path?


Yes, it is called in the device probing path where the kernel forwards 
the device configuration request to userspace and wait for its response.

If it turns out to be tricky, we can implement the whole device inside 
the kernel and leave only the datapath in the userspace (as what TUN did).

Thanks


>

