Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F53B6D40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhF2EGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 00:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbhF2EGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624939423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+g48Xk6aSFcuGIkt+/DaIL+8u6+RW2FB0ohInQkXMo=;
        b=N/kWuJ9pALnFjAebPxvDYNPT7Ryq6QldUcVo8UT++4pGcHq/bJSclHk33zqT2frczX3F8O
        tPhA558HdqfArUd1FmH3dqD9lCOSsqNot0fkCVvP29F777cxrCI9xciC18X7VOuR1Y+gsv
        kVw61734oKEJt+cv8QxmeTyO5PhHlLc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-SVfNKJxYNYC9cx0jjAY09A-1; Tue, 29 Jun 2021 00:03:39 -0400
X-MC-Unique: SVfNKJxYNYC9cx0jjAY09A-1
Received: by mail-pl1-f197.google.com with SMTP id l10-20020a17090270cab029011dbfb3981aso6672515plt.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 21:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v+g48Xk6aSFcuGIkt+/DaIL+8u6+RW2FB0ohInQkXMo=;
        b=HWs8ZO15zvBVxqCgzsjl4G5o4YC7V6aqSKq5irrP0A/MLDbdCWkX482fFGBgUYiQy3
         joazyzcqEuCorIQAIywLREZYNi819/nbXl6daOiLrZq91USIlu8gqCAS7AZfsfbL0GqO
         RCEfsd6LDRBVbXPmeVNL+1T36BnrzB9u9kc5EhSat2CB73VQrIi2oq3imAR3EEPwnnrk
         DuzVuXUhQT2GUK10yD5csoCoLA8qepf1f9LfU8aQXhyRrAEwhnZGzD9LcjhB69FAPakE
         wMd5lAxpvb384rnGGD2Pn1nedVOe1Sf/XbbJmhRqoQRFQQVfMA16seL5ZsGLXIfRAM5n
         OJZQ==
X-Gm-Message-State: AOAM532St1NXAoZehTGnWKdW0GqDOferqZJqXuKrFXH2YJERRyd2AIL6
        IiPc9K10zVkULMufZ8WqCSraQ5PJaZj6DPDIe7Df9PD8C3UUj2IYVeS3F1+qVxktAFfnBMsnteM
        UfwhEZk/hc7DMOhYKV8L6h4rC2Q==
X-Received: by 2002:a17:90a:3d47:: with SMTP id o7mr41873351pjf.68.1624939418457;
        Mon, 28 Jun 2021 21:03:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKtTxOUZyWPHTglSm78/VChBvM+Z/ZClGizEzsTPbjS/HVYSHDloQPPNl7gVZByIo2yALsfw==
X-Received: by 2002:a17:90a:3d47:: with SMTP id o7mr41873326pjf.68.1624939418245;
        Mon, 28 Jun 2021 21:03:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e2sm16252405pgh.5.2021.06.28.21.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 21:03:37 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
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
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
 <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
 <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
 <CACycT3ucVz3D4Tcr1C6uzWyApZy7Xk4o17VH2gvLO3w1Ra+skg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d30e391f-a900-5182-f732-e7c0089b7cbd@redhat.com>
Date:   Tue, 29 Jun 2021 12:03:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3ucVz3D4Tcr1C6uzWyApZy7Xk4o17VH2gvLO3w1Ra+skg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/6/29 上午11:56, Yongji Xie 写道:
> On Tue, Jun 29, 2021 at 11:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/6/29 上午10:26, Yongji Xie 写道:
>>> On Mon, Jun 28, 2021 at 12:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> 在 2021/6/25 下午12:19, Yongji Xie 写道:
>>>>>> 2b) for set_status(): simply relay the message to userspace, reply is no
>>>>>> needed. Userspace will use a command to update the status when the
>>>>>> datapath is stop. The the status could be fetched via get_stats().
>>>>>>
>>>>>> 2b looks more spec complaint.
>>>>>>
>>>>> Looks good to me. And I think we can use the reply of the message to
>>>>> update the status instead of introducing a new command.
>>>>>
>>>> Just notice this part in virtio_finalize_features():
>>>>
>>>>            virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>>>>            status = dev->config->get_status(dev);
>>>>            if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>>>
>>>> So we no reply doesn't work for FEATURES_OK.
>>>>
>>>> So my understanding is:
>>>>
>>>> 1) We must not use noreply for set_status()
>>>> 2) We can use noreply for get_status(), but it requires a new ioctl to
>>>> update the status.
>>>>
>>>> So it looks to me we need synchronize for both get_status() and
>>>> set_status().
>>>>
>>> We should not send messages to userspace in the FEATURES_OK case. So
>>> the synchronization is not necessary.
>>
>> As discussed previously, there could be a device that mandates some
>> features (VIRTIO_F_RING_PACKED). So it can choose to not accept
>> FEATURES_OK is packed virtqueue is not negotiated.
>>
>> In this case we need to relay the message to userspace.
>>
> OK, I see. If so, I prefer to only use noreply for set_status(). We do
> not set the status bit if the message is failed. In this way, we don't
> need to change lots of virtio core codes to handle the failure of
> set_status()/get_status().


It should work.

Thanks


>
> Thanks,
> Yongji
>

