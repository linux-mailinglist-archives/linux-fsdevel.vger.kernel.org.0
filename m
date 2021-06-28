Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C7D3B586D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 06:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhF1Em5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 00:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhF1Emy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624855229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHA+LCiynBinIcwBex84PZFjkFyKiA5ldfw47X4q5zo=;
        b=BM3l6mJbwMWJ5ITDrjOTFe6NrBUQ6Ui0nGLmzPdE+NXn+M7SjpPPgKhUDgwslOIUiV2x+d
        dTDZUKAgkB5w3t8OHywv7J8j0Dxfy2xTfceZxXWNO7l+Q9prhfdjQNPoWF08j5zwxnVHIw
        DR9CQzkr8S8d4Cut1kyTeKIRiRuNJjQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-FK7AHJVZMa6mJnakr741kA-1; Mon, 28 Jun 2021 00:40:24 -0400
X-MC-Unique: FK7AHJVZMa6mJnakr741kA-1
Received: by mail-pj1-f69.google.com with SMTP id om5-20020a17090b3a85b029016eb0b21f1dso11209290pjb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Jun 2021 21:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AHA+LCiynBinIcwBex84PZFjkFyKiA5ldfw47X4q5zo=;
        b=fvh7JhhLA053rV172U8wnen/Fq4cjCFrX7fOiyG2+V5SX5KkE8RQwmgNqEdZ+/mg9q
         Oml2S+EJgPzWHOy6ObPXTZ0A2XEU7G4cuqcQXOZJpPb9aV+1qqK+pgRXCPfi1OjkNpIO
         roS6vvOCPa/3FgWviqIAnyn7ldFVGgxbj+dNAOwmpW824UMj0HAO6HMOsxK1FcCv0N3u
         ISjsOSKeXYnyISlGfClDT8GjaY8VqjgaXc25rpDLalz67QikhWmFNHxBg3wu4PPBZB2T
         5VCERyUWI2q/wYIU4le+gt10ULs0uZ4bapQaiaddRkKekYiFbNl9ejQzIaDNf9yA2MN5
         XE0g==
X-Gm-Message-State: AOAM531xF+EFiUSwKMCfpIynRZ0VySoBYsSnPiHsdpuaFZwn1JmKjunS
        3TXejSHrWmO9G4aABEd1iYy7+IIedcX3y4/Wu7CoVqRLf1+mtCWrXmEbvVZ1Yk4WV/Zlq1tXt/J
        Z+8PXh7WUlc0A1SrXmeapahMmXA==
X-Received: by 2002:a17:90a:73ca:: with SMTP id n10mr35061279pjk.16.1624855223792;
        Sun, 27 Jun 2021 21:40:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo0o1s5KBYLlDLTqUhWl2FmmtFdw3BbxmCq5oGFB7ob0lz6rjRGdc+HVA7kjdSm4QccHUIRQ==
X-Received: by 2002:a17:90a:73ca:: with SMTP id n10mr35061255pjk.16.1624855223625;
        Sun, 27 Jun 2021 21:40:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x143sm12654203pfc.6.2021.06.27.21.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 21:40:23 -0700 (PDT)
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
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
Date:   Mon, 28 Jun 2021 12:40:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/6/25 下午12:19, Yongji Xie 写道:
>> 2b) for set_status(): simply relay the message to userspace, reply is no
>> needed. Userspace will use a command to update the status when the
>> datapath is stop. The the status could be fetched via get_stats().
>>
>> 2b looks more spec complaint.
>>
> Looks good to me. And I think we can use the reply of the message to
> update the status instead of introducing a new command.
>

Just notice this part in virtio_finalize_features():

         virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
         status = dev->config->get_status(dev);
         if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {

So we no reply doesn't work for FEATURES_OK.

So my understanding is:

1) We must not use noreply for set_status()
2) We can use noreply for get_status(), but it requires a new ioctl to 
update the status.

So it looks to me we need synchronize for both get_status() and 
set_status().

Thanks


