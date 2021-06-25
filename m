Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6173B3B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 06:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhFYEVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 00:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhFYEVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:21:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78267C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jun 2021 21:19:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n2so1862487eju.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jun 2021 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q34vFqngnB3t5A6Nz3+eYIAGYGv8OAQnO0GJ9ith6+k=;
        b=YyvepM16teRAmW69CrgpPvH41Kv8BofJj0cnZwPg1pUt8Kynigzda5WiVGgo+EUKSl
         MmN7Bs8/AinjxpLcVb8drAzPGwoEC/8SqEctQaOrgknExBKqugTu3nDd7XqY74F2MnUL
         +aOfvmk2a2zM5gOZvVHKyqfJUj9GoDM5evNKgotF30eKzWH9zKild6AjUCaJxDdxo3/0
         JIVSRc7orj7IUOn29Px1/HUAF2D7/UPboHOswMrNZPwXJ0Ib9KZYxz+XAxuLo/GeSNS5
         6Ws2t1iATvhbQUuJEkMXTiXk+zAp+ud2KhPhyz3bAmKGDboR4fY7Tvr/053rCSMrbt+9
         gKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q34vFqngnB3t5A6Nz3+eYIAGYGv8OAQnO0GJ9ith6+k=;
        b=CeJ7ilEmWSM7uKEXCg9sn6lp8DHNklVn0YOT1LTnsMlqITPEeNR5jaHu0gBXNO83mw
         haCiO1oU24BTDP6YQ2Vn1thCewN1fPj4wCnMZXmMCFlI8uFKlk51N0ldC7fJcDEhOkzB
         DEElJLO1yX3tP3Ki7BJ9KGz//XS0DoY6m6NUT0YAuEAHQAF6E4iBhg0Xr1rJUH1fslWP
         nkmAKiiCYVSJDzESF4dKvalN6RySTgI1gPo2vogpMPr4j0dO0AUajz1q/EvYKgVJ7/He
         5bGBBuUNS/tXQOa7/k2Li177NCFWAy8k6UC1A2aedb0zh7rEjnQrYd3vqtnHTn/0unTu
         Eung==
X-Gm-Message-State: AOAM532oIdvLWCV7tCBkMOZno4A8zRzl3Ro59nFr3z3YWAoif/F8mU+w
        nKSxVKBB9CFQbE4TwQMXV2wdgtDzif5NLqwM7wO3
X-Google-Smtp-Source: ABdhPJwWo7LxCs+JJy5P3HQmX5kV8JvQwPmXrDO588SF0T6G/cjPM3gzbPTywA6iLqaSgqpcRjYDZsFvg/0Ua/XTQNc=
X-Received: by 2002:a17:906:7142:: with SMTP id z2mr8520729ejj.427.1624594765939;
 Thu, 24 Jun 2021 21:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com> <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com> <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com> <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com> <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com> <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com> <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com> <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
In-Reply-To: <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 25 Jun 2021 12:19:15 +0800
Message-ID: <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Jason Wang <jasowang@redhat.com>
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
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:09 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/6/24 =E4=B8=8B=E5=8D=885:16, Yongji Xie =E5=86=99=E9=81=93=
:
> > On Thu, Jun 24, 2021 at 4:14 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> =E5=9C=A8 2021/6/24 =E4=B8=8B=E5=8D=8812:46, Yongji Xie =E5=86=99=E9=
=81=93:
> >>>> So we need to deal with both FEATURES_OK and reset, but probably not
> >>>> DRIVER_OK.
> >>>>
> >>> OK, I see. Thanks for the explanation. One more question is how about
> >>> clearing the corresponding status bit in get_status() rather than
> >>> making set_status() fail. Since the spec recommends this way for
> >>> validation which is done in virtio_dev_remove() and
> >>> virtio_finalize_features().
> >>>
> >>> Thanks,
> >>> Yongji
> >>>
> >> I think you can. Or it would be even better that we just don't set the
> >> bit during set_status().
> >>
> > Yes, that's what I mean.
> >
> >> I just realize that in vdpa_reset() we had:
> >>
> >> static inline void vdpa_reset(struct vdpa_device *vdev)
> >> {
> >>           const struct vdpa_config_ops *ops =3D vdev->config;
> >>
> >>           vdev->features_valid =3D false;
> >>           ops->set_status(vdev, 0);
> >> }
> >>
> >> We probably need to add the synchronization here. E.g re-read with a
> >> timeout.
> >>
> > Looks like the timeout is already in set_status().
>
>
> Do you mean the VDUSE's implementation?
>

Yes.

>
> >   Do we really need a
> > duplicated one here?
>
>
> 1) this is the timeout at the vDPA layer instead of the VDUSE layer.

OK, I get it.

> 2) it really depends on what's the meaning of the timeout for set_status
> of VDUSE.
>
> Do we want:
>
> 2a) for set_status(): relay the message to userspace and wait for the
> userspace to quiescence the datapath
>
> or
>
> 2b) for set_status(): simply relay the message to userspace, reply is no
> needed. Userspace will use a command to update the status when the
> datapath is stop. The the status could be fetched via get_stats().
>
> 2b looks more spec complaint.
>

Looks good to me. And I think we can use the reply of the message to
update the status instead of introducing a new command.

> > And how to handle failure? Adding a return value
> > to virtio_config_ops->reset() and passing the error to the upper
> > layer?
>
>
> Something like this.
>

OK.

Thanks,
Yongji
