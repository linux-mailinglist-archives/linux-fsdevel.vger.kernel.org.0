Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81CA361C02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbhDPIoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbhDPIoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:44:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B1C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 01:43:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so40983410ejo.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nZ1FRFDIzSslp5WYUYeFlBBX17UdTlQXsbemICRU/2o=;
        b=HGO0MkBeb0UC7k2w60QVBM3EzdZA53hwbNbcWebu6p3EccSPj820VKps1IS4byzXq6
         xA2MnyEh1zjCw+XTc5F9zWXbYoLk/gjvkDQmr9d5ZP6yFuwKvTydRmlnwEa9Y3hkqPwA
         NHOiGxh6+st5GLGHOcpv8Au12nhxiuhd2HiyNR6vHUj99pxm4XvoLoJO8aVPPCop+0Rh
         2UbuWeZSIyrNRsrXPqcYJ5kyBrbPcF6xwi5/A8lvf+LBWXOxVPqWDFIxPApRLCoUYGPl
         Y6Cz3YCV8KnibnoBYd1x1JrM2swSDGOBXw+w8YmnKtBXAzJ2ug8E77jA8/g9++bJfxtp
         f5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nZ1FRFDIzSslp5WYUYeFlBBX17UdTlQXsbemICRU/2o=;
        b=YnlTtqfsLEd8A1vCBkQnh6WyXF5wtTxZgq2uBOLJmE8fe94NgLz90QAPvbDVXriwio
         nYRAOCstcHiFO2wxi9ljA1GMJNLyCFBSCxQZKIVOkEZeDDxtT74Q+h7oNyhSEKJ/4XIb
         H/eV60ImNxTBpxDEZhnLaMK3qjKqUR8RlRcpX6KpbWwbbzAEUkiUjb904TTDRr3OGszT
         LBluhfUNYTljcibRZ2G9g3jpMRaFr/PmWkxGahi8Ab/tem/pBUNaIsR70kvO7rJ4icqh
         fo3TsW+8KeC19ebUAWYGc5p6e5bxnjVW2qRUdIv82nlU3YDYC43r8Jk0Gybdgxk4lcSp
         Nr2w==
X-Gm-Message-State: AOAM530aIpbKwfvLxOCfrmAJ6VGyPyTGZpL71buU8WktxAE45QGtmT46
        6G89Mxr1KStiYucD6W9iedG09Ef9S116easOgvdR
X-Google-Smtp-Source: ABdhPJyTB7M62F5DqcvOAaZa4vtrH6KUgmABAXyYOE0j8gboTWamM5DbXwOo84AucNDw/Hl83Q09aRyPqqKg7UNh2Uo=
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr7159342eje.427.1618562625328;
 Fri, 16 Apr 2021 01:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210331080519.172-1-xieyongji@bytedance.com> <20210331080519.172-10-xieyongji@bytedance.com>
 <87a54b5e-626d-7e04-93f4-f59eddff9947@redhat.com>
In-Reply-To: <87a54b5e-626d-7e04-93f4-f59eddff9947@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 16 Apr 2021 16:43:33 +0800
Message-ID: <CACycT3vn6PaYGjjd2Uq5ot_YCbyvMzoeU8V_KgGN+cTFx7pg-Q@mail.gmail.com>
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

On Fri, Apr 16, 2021 at 11:24 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/3/31 =E4=B8=8B=E5=8D=884:05, Xie Yongji =E5=86=99=E9=81=93=
:
> > +     }
> > +     case VDUSE_INJECT_VQ_IRQ:
> > +             ret =3D -EINVAL;
> > +             if (arg >=3D dev->vq_num)
> > +                     break;
> > +
> > +             ret =3D 0;
> > +             queue_work(vduse_irq_wq, &dev->vqs[arg].inject);
> > +             break;
>
>
> One additional note:
>
> Please use array_index_nospec() for all vqs[idx] access where idx is
> under the control of userspace to avoid potential spectre exploitation.
>

OK, I see.

Thanks,
Yongji
