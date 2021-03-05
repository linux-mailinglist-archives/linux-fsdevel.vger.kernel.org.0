Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC032E25E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 07:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCEGkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 01:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCEGko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:40:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA7C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 22:40:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h10so1068729edl.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 22:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rlMC+NCGohYrtFUT53MyD25UTkSWavgfcRQFGg665gM=;
        b=Ag8fIkp03HMTSaamJkFp+Y81vzhcHicjzhao/hF3vJfen6XB7xJVjN29P84N/9iOSq
         l4x7K2LT/HajdOO0BpWJTJZEvU6PF14LQAl3hkXTCvtnB9k3TpKkS6eQl5XmBKQVNwOs
         rEv03bM6DNcxZ6bwu4kVTuwnAEkFxDBpKveGRaQZP0r8/lcfFCMnLBj6hLD076FbHCsg
         ebCPHp4+lsbvrPpNUSS469QK2vavzSqng7ENofCfX0ivBsbgqY26SSuWDjwYtdVazoUh
         4+qIvpwwjvoF09nE7JHFtNhBu8I5ZLqyTEKs+wd/stos/KWYfHnI7xVfatAviDWSMZBD
         r2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rlMC+NCGohYrtFUT53MyD25UTkSWavgfcRQFGg665gM=;
        b=fA5jxC0vXLI0kRHuV3iau9pqHHfPXSUuSe/8lLz0rEqRKZDia9sNqNCywD9z4QWob9
         mBKmEC9YeDMqf1+rZaZsBCfIO/efDR6eXx+hXxI4QXAqxDNYp8J+ybKWwcjCfmqqEPse
         QoHvOF4skmOYy4Mrd4L8RB/FUkJk2nZ8hwyxtp8Fm+BQZx2XGKQVY/vnI1d40/BrFXY2
         oyPkbeq+VdnIT6kjJoRMQjis1NmkPBKpYx0XGPJ1mz2gFda/AX9iKVB3jt+VIq0WAX41
         UMEpt9Yj33Tzvtimp6BSrdgXqgm1sutneOg85pkVGxPM4Wc2mnWKkfOJ301QACj9BYbw
         XlCg==
X-Gm-Message-State: AOAM531Zewgn94KhU1jj73x86qEUZZty1rbbXWFHcbeQbOyFzE1vhi07
        UAG61sK2dsUeiHajf86+vCLIfLz4PrQ7/J72Sqho
X-Google-Smtp-Source: ABdhPJzy5l34Guxnd+JnxGnP9wmnYZwXADgIwoxPy+rQTvVYIIU8FE3hOZyBcfpxFKrrWwJEObadHitMMyKFHiaqQ8o=
X-Received: by 2002:a05:6402:180b:: with SMTP id g11mr7686614edy.195.1614926441210;
 Thu, 04 Mar 2021 22:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-12-xieyongji@bytedance.com>
 <d104a518-799d-c13f-311c-f7a673f9241b@redhat.com> <CACycT3uaOU5ybwojfiSL0kSpW9GUnh82ZeDH7drdkfK72iP8bg@mail.gmail.com>
 <86af7b84-23f0-dca7-183b-e4d586cbcea6@redhat.com> <CACycT3s+eO7Qi8aPayLbfNnLqOK_q1oB6+d+51hudd-zZf7n8w@mail.gmail.com>
 <845bfa68-2ece-81a2-317f-3e0cf4f72cf1@redhat.com>
In-Reply-To: <845bfa68-2ece-81a2-317f-3e0cf4f72cf1@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 5 Mar 2021 14:40:30 +0800
Message-ID: <CACycT3uzHpJbcctPx2ezv6OSX7ZVcLVd0HJcRL6khnxn=w4KTg@mail.gmail.com>
Subject: Re: Re: [RFC v4 11/11] vduse: Support binding irq to the specified cpu
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 5, 2021 at 11:44 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/3/5 11:37 =E4=B8=8A=E5=8D=88, Yongji Xie wrote:
> > On Fri, Mar 5, 2021 at 11:11 AM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On 2021/3/4 4:19 =E4=B8=8B=E5=8D=88, Yongji Xie wrote:
> >>> On Thu, Mar 4, 2021 at 3:30 PM Jason Wang <jasowang@redhat.com> wrote=
:
> >>>> On 2021/2/23 7:50 =E4=B8=8B=E5=8D=88, Xie Yongji wrote:
> >>>>> Add a parameter for the ioctl VDUSE_INJECT_VQ_IRQ to support
> >>>>> injecting virtqueue's interrupt to the specified cpu.
> >>>> How userspace know which CPU is this irq for? It looks to me we need=
 to
> >>>> do it at different level.
> >>>>
> >>>> E.g introduce some API in sys to allow admin to tune for that.
> >>>>
> >>>> But I think we can do that in antoher patch on top of this series.
> >>>>
> >>> OK. I will think more about it.
> >>
> >> It should be soemthing like
> >> /sys/class/vduse/$dev_name/vq/0/irq_affinity. Also need to make sure
> >> eventfd could not be reused.
> >>
> > Looks like we doesn't use eventfd now. Do you mean we need to use
> > eventfd in this case?
>
>
> No, I meant if we're using eventfd, do we allow a single eventfd to be
> used for injecting irq for more than one virtqueue? (If not, I guess it
> should be ok).
>

OK, I see. I think we don't allow that now.

Thanks,
Yongji
