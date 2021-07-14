Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57FD3C7E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 07:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhGNFsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 01:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbhGNFsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:48:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3733C0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 22:45:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so1491996eds.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHZPSlSYGfv/SLrxAM/jOzUDS1kn5mU0G7/MnH+av7w=;
        b=TFIXYmOj7xWCYyEiL8IfX/z7XfVUXzphq5lOB8eXolpRNkYjOSMo0nDnxvLCmz0v0P
         4eGMqbLigvSrkWD5Ktxv46HxIXTFcGk13cG3kVrsNbQzLREMK2CU0ptM1QqPqXW9BxdS
         yI4oyRP0mP48+7gXh6dqlj0high4D9cExctbn2AE52uoOqBY9Swobwxv+2it40H4ayu7
         w3w1GZTkgOOUrnt/2hwL0W/gWDo4Pi9Ue3FoX1Gqies4/s5dcU7t+zv44Y6s1Srs86AZ
         4j0nZgRECcfTY+He18dAroizi7KMqRIvXRIBJ9g/s8NvMcfm0xZ4ZqsIQ2184Hh5NyoU
         dwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHZPSlSYGfv/SLrxAM/jOzUDS1kn5mU0G7/MnH+av7w=;
        b=as/Y2KIhR4s7+o0D0TC/zymDr/H7ppkpLnDeEa/e31rVtxbv39sA9yY7S8dmSkGiL4
         WpCHjApqvi+dncb8vfwfp+f3BDNrZp4GkdTF9Adzx+LnHhu7y9VFw6NwuMbRWp3ecX1i
         YJUpzJq+EsAAXYW+q84kzhjvg56cfEGcMmwxifliwIG7WYt/bkC5R3bFWdb3iBSRrY3T
         mGjKMwDJJMYQ5O59y3GWTxL+q0GgZCui9YFrh+1el7y8UIJuj1yKqbOsB7CLwLmUccxS
         kSNBZBuXGqpOv4ZYOynUfHIWSaI6K6MXAVwVdvTYyUzChlx28U6vaJrtdB3RqPHA0UqG
         Ad4g==
X-Gm-Message-State: AOAM531fX+8SHecNl3N+SXRHSXRTWV/2QYJ2iIKB7GlWO+3AE01hlcGm
        uPQuIzNZg3u3cT4QQyoNLXpnjStlkLu0yvTkUeBj
X-Google-Smtp-Source: ABdhPJxB+DrOBDXuwclE4BqKnRj6flob2oW8SNccGw0iEXIiLGhLEqaAkjs4n04tANFRLCsq6H5lMvNd7tbeRCpkn8s=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr10874200edu.253.1626241521339;
 Tue, 13 Jul 2021 22:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com> <20210713084656.232-17-xieyongji@bytedance.com>
 <20210713132741.GM1954@kadam> <c42979dd-331f-4af5-fda6-18d80f22be2d@redhat.com>
In-Reply-To: <c42979dd-331f-4af5-fda6-18d80f22be2d@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 14 Jul 2021 13:45:10 +0800
Message-ID: <CACycT3vNiAdOLVRhjqUjZGBfPnCti+_5+vdkgtbJ4XyRsYfrPg@mail.gmail.com>
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
        joro@8bytes.org, Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 10:54 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=889:27, Dan Carpenter =E5=86=99=E9=81=
=93:
> > On Tue, Jul 13, 2021 at 04:46:55PM +0800, Xie Yongji wrote:
> >> +static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *nam=
e)
> >> +{
> >> +    struct vduse_vdpa *vdev;
> >> +    int ret;
> >> +
> >> +    if (dev->vdev)
> >> +            return -EEXIST;
> >> +
> >> +    vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >> +                             &vduse_vdpa_config_ops, name, true);
> >> +    if (!vdev)
> >> +            return -ENOMEM;
> > This should be an IS_ERR() check instead of a NULL check.
>
>
> Yes.
>
>
> >
> > The vdpa_alloc_device() macro is doing something very complicated but
> > I'm not sure what.  It calls container_of() and that looks buggy until
> > you spot the BUILD_BUG_ON_ZERO() compile time assert which ensures that
> > the container_of() is a no-op.
> >
> > Only one of the callers checks for error pointers correctly so maybe
> > it's too complicated or maybe there should be better documentation.
>
>
> We need better documentation for this macro and fix all the buggy callers=
.
>
> Yong Ji, want to do that?
>

Sure, I will send the fix soon.

Thanks,
Yongji
