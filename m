Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982A93926AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 07:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhE0FBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 01:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhE0FBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 01:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622091621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvNDULJK9zHRMwqe44K4RR3WKdtWUGMATeJjP7wtcZY=;
        b=XP5XSFB4NgedXZyM+YlrkzKEb8sR/Wjxbl8Du6HIlRT1Uq8cqd0QKNg9o+DLRk/mP61mOl
        YKnVamvSQelQUzC9QyfhAVuKkPkVWDusyUWZpALi/QFRWmsHC21p22ACbgVW/ME9xyxPnm
        tf7alhN4x4BamxTkPCuZm6B0UqVonQY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-9JWsWy1TP_K5rfGGJa8uZg-1; Thu, 27 May 2021 01:00:17 -0400
X-MC-Unique: 9JWsWy1TP_K5rfGGJa8uZg-1
Received: by mail-pf1-f198.google.com with SMTP id k24-20020aa797380000b02902deaf46d6fdso2110246pfg.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 22:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WvNDULJK9zHRMwqe44K4RR3WKdtWUGMATeJjP7wtcZY=;
        b=dH0JMHnwq/SJsXOveWlLmnYMGBatdOxIYVy8Mj2Srl0F/cKjykLFMxoDvDzi5ty4gX
         C/zZpAYqEzmpFQs9/CbCFfEaxR1r90vSoKYDo63RV5BcfUSTP9yATcpZPQV9rqclpnLt
         tktNYGM/mrVHb7wgWRJQHpPqlWWw07pzpZo4Q1VWJlgWnfBlDHkYgass6p/CMyUt+89Q
         y5HPjwBTUI+qyBiolqvZLaEiFrzW/qrpIOIRXQZ7R1HiWiKQYlWOxBHPDV/+DbZSptNc
         rehCt2pINnFz7LNi0ep82inPn0gjB4FhSXKu5lx4iqYi1Uq7gYopxzrtBIUZgl+IZxVB
         bHqA==
X-Gm-Message-State: AOAM533K2uMaOLSDxeg4NrJd8Waanyc1iPSE744PlAc97Rh+S1kvqQyy
        HRE1lR4dD1Vf7D+nDra6mowwJO3SpSaDXDY6+3gMW3NnE/DMDcSUQhS24jNvt/6Z40K6s5iXFJn
        nhft5KyuWA2FlKb4u/YmAZ0hwjQ==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr1854489pjb.36.1622091616473;
        Wed, 26 May 2021 22:00:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbQssOI3XI76V4pKYYsFesmyrvxjTc0EKTWn6Zl6xKwlpjIji0dLlRJIWAqJ1uNqyHlcKbWw==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr1854461pjb.36.1622091616242;
        Wed, 26 May 2021 22:00:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u5sm715334pfi.179.2021.05.26.22.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 22:00:15 -0700 (PDT)
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
Date:   Thu, 27 May 2021 13:00:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/5/27 下午12:57, Yongji Xie 写道:
> On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/17 下午5:55, Xie Yongji 写道:
>>> +
>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>> +                           struct vduse_dev_msg *msg)
>>> +{
>>> +     init_waitqueue_head(&msg->waitq);
>>> +     spin_lock(&dev->msg_lock);
>>> +     vduse_enqueue_msg(&dev->send_list, msg);
>>> +     wake_up(&dev->waitq);
>>> +     spin_unlock(&dev->msg_lock);
>>> +     wait_event_killable(msg->waitq, msg->completed);
>>
>> What happens if the userspace(malicous) doesn't give a response forever?
>>
>> It looks like a DOS. If yes, we need to consider a way to fix that.
>>
> How about using wait_event_killable_timeout() instead?


Probably, and then we need choose a suitable timeout and more important, 
need to report the failure to virtio.

Thanks


>
> Thanks,
> Yongji
>

