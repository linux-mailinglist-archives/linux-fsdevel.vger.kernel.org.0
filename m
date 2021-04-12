Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2CA35C347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbhDLKDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244378AbhDLKA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:00:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA2C06138D
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 03:00:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x4so14355935edd.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QxwWcvoZimdUpeMmS0ttHFmxJVwAZhHYr74miAUwCbM=;
        b=oFeWl3I0YH45zNyIE2HImZ3isTqDrhfIysj0EQcj9tqRjX1s/IEPFDmkjhYEPJtL4k
         PQiRwPRyWCTGG7FagoelZWJYC2L0CXSqDzZjrPMQibHuOiYlW81mKKgqvrwVMHS74R1u
         Z52Tq560QpgxqmgTCLDAD8q4OyGtnDMGnb2iiak1O/PiF++Xn0u4qT8SY9rHMPzhxnpk
         wpVvtDD7jDg95I+J38e19L6rdWmOqS3yuukdOHX6JFmOG7GwR9VdLTpUGeMt1DKvrmt/
         TLGpIJYKHX1Pia3fnE/wrY39FGK0xHHCh4CmqYedt8oLqL7qUSOAll036rmo6PPJcp7a
         75pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QxwWcvoZimdUpeMmS0ttHFmxJVwAZhHYr74miAUwCbM=;
        b=POBsesm2jxkQAmMtm9/wp/Iio6AEkaAqJwcystCCm5MiVXJe8FqklKKW/kQfb1o9qu
         COidWlZTGmVglu3v1c7fU9NiWbrUDU4Ve9i2FKxB/t6hRyYBKO9x12phJE5alSigNuFK
         dCuYeovuU8WcVog6Gb4+Cki1pTw15aSHidcAJjzG6UKg13zWKN+jPZPNiZtU6u+Yfig6
         rtEUD50BpkkCtIQhXva4a90/mjXNqRWVlCJnHUG9iS/QqJUvXVoFWiefNuZAf1Q7Hw2U
         HhX770Gh/zDbrWvl859Z86RwoCf4+WtzJnZQd97NWHDdqjMBodx5o63/td8u9LWd80Ce
         6Jpg==
X-Gm-Message-State: AOAM532BIk4soZM9l41p71Hu61RXqW45C2ain8/IVn4+jLN0+Puxq2ov
        oTeJvBrgDiG2mwbGwM5ayJAlTiJRooMOqiQN3Ski
X-Google-Smtp-Source: ABdhPJx8wwJ5G14XsvtrAXwDus9VVYn+9LjO6cXjylyaRfLAcGOtTRp6MSESNYsMsqA/2p8s2fGrTXmL0awPsgd/kag=
X-Received: by 2002:a05:6402:4d1:: with SMTP id n17mr27978100edw.118.1618221607011;
 Mon, 12 Apr 2021 03:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210331080519.172-1-xieyongji@bytedance.com> <20210331080519.172-10-xieyongji@bytedance.com>
 <c817178a-2ac8-bf93-1ed3-528579c657a3@redhat.com> <CACycT3v_KFQXoxRbEj8c0Ve6iKn9RbibtBDgBFs=rf0ZOmTBBQ@mail.gmail.com>
 <091dde74-449b-385c-0ec9-11e4847c6c4c@redhat.com> <CACycT3vwATp4+Ao0fjuyeeLQN+xHH=dXF+JUyuitkn4k8hELnA@mail.gmail.com>
 <dc9a90dd-4f86-988c-c1b5-ac606ce5e14b@redhat.com> <CACycT3vxO21Yt6+px2c2Q8DONNUNehdo2Vez_RKQCKe76CM2TA@mail.gmail.com>
 <0f386dfe-45c9-5609-55f7-b8ab2a4abf5e@redhat.com>
In-Reply-To: <0f386dfe-45c9-5609-55f7-b8ab2a4abf5e@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 12 Apr 2021 17:59:56 +0800
Message-ID: <CACycT3vbDhUKM0OX-zo02go09gh2+EEdyZ_YQuz8PXzo3EngXw@mail.gmail.com>
Subject: Re: Re: [PATCH v6 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 5:37 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/4/12 =E4=B8=8B=E5=8D=884:02, Yongji Xie =E5=86=99=E9=81=93=
:
> > On Mon, Apr 12, 2021 at 3:16 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> =E5=9C=A8 2021/4/9 =E4=B8=8B=E5=8D=884:02, Yongji Xie =E5=86=99=E9=81=
=93:
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct vduse_dev_config_data {
> >>>>>>> +     __u32 offset; /* offset from the beginning of config space =
*/
> >>>>>>> +     __u32 len; /* the length to read/write */
> >>>>>>> +     __u8 data[VDUSE_CONFIG_DATA_LEN]; /* data buffer used to re=
ad/write */
> >>>>>> Note that since VDUSE_CONFIG_DATA_LEN is part of uAPI it means we =
can
> >>>>>> not change it in the future.
> >>>>>>
> >>>>>> So this might suffcient for future features or all type of virtio =
devices.
> >>>>>>
> >>>>> Do you mean 256 is no enough here=EF=BC=9F
> >>>> Yes.
> >>>>
> >>> But this request will be submitted multiple times if config lengh is
> >>> larger than 256. So do you think whether we need to extent the size t=
o
> >>> 512 or larger?
> >>
> >> So I think you'd better either:
> >>
> >> 1) document the limitation (256) in somewhere, (better both uapi and d=
oc)
> >>
> > But the VDUSE_CONFIG_DATA_LEN doesn't mean the limitation of
> > configuration space. It only means the maximum size of one data
> > transfer for configuration space. Do you mean document this?
>
>
> Yes, and another thing is that since you're using
> data[VDUSE_CONFIG_DATA_LEN] in the uapi, it implies the length is always
> 256 which seems not good and not what the code is wrote.
>

How about renaming VDUSE_CONFIG_DATA_LEN to VDUSE_MAX_TRANSFER_LEN?

Thanks,
Yongji
