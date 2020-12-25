Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61692E2982
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 03:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgLYCiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 21:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgLYCiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 21:38:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810DC061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Dec 2020 18:37:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id q22so5173833eja.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Dec 2020 18:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqkIxCDpSgmf+ywAW/RU+ir7SxhE5sjbn3awllN6Ic4=;
        b=jBMvQ9wRfhO5hrlEakK4OGhVJNdaA6GaDDtuiii6dPEGkb7Ara1axsPFjgjXofR9Sk
         +BBMjijnVcwhW3HubcQD15HeNO4Xm+y3rBwX3l/FMDuGD+fJsyB2PQ3a0tPG2VeE1edt
         U/LybiPxAa/vzKmXBH/XEM1jWnPhsNRDLgW9BdiMDVV0ISs1FX2UippCopEiIcHAnL2e
         6s7IudeZNpVdBJi6YiYnINPrkLFRhJHs1HJsrb/gm715qO4NPsZ+EPoKCMgzjgV8lqKA
         YP0nc/2MSVI+wxptZ0DOHHIygdkd8OAs/vAKpSqhddaW8nk1OuA5b/c+QTpMfZtR1kPP
         D+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqkIxCDpSgmf+ywAW/RU+ir7SxhE5sjbn3awllN6Ic4=;
        b=kaQxoZMZq8PoFvtrDePoatoOx7Dxqi/SKFTbtM/Dvtze+XyrBklDuu7cbNzYSGIw+q
         RWlMSykBje96ZfGRrVDloZdFb0dcma5lCEeF4zQ4VkFIEqb2Cqik0F8t+Xy6ei8Hybma
         QOV/AgnnIoJTEuztTZwR/R24RFE5GdO9pMIQFCBCl1mnWNdrgfxW6ug6dPLTdvLfaGCs
         zztj9RH3pEIFPQ/AgFia2gopAUQUM/f3uT36cJLA8+Ci9f0skX3lhkkBMghaLbxj77rj
         d5YHOJ0GFVGnwRm4CIz/5w56yCjjO0CcUdq/0dN5B4DLRk+GhbXJO7o7798wgUSjMcbn
         dzXA==
X-Gm-Message-State: AOAM531aPRSUaXVYKiOO3uGvOqWqOnUR9IjLsbP6R+3x7ciMXFhEIX4J
        W3j/7Og073b4rX8xbTHnYYfKv9NpsYMzb2jmFydH
X-Google-Smtp-Source: ABdhPJzAOvsh+74+7qyHZ/RAXiRGOfEf6qPMm/Z2ZCv5btNnN4vJYG5QQV/FLliYRFf+S03u0vhXIUhQVzM+SGfHsKQ=
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr30294797ejb.247.1608863838459;
 Thu, 24 Dec 2020 18:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20201222145221.711-1-xieyongji@bytedance.com> <20201222145221.711-10-xieyongji@bytedance.com>
 <6818a214-d587-4f0b-7de6-13c4e7e94ab6@redhat.com> <CACycT3vVU9vg6R6UujSnSdk8cwxWPVgeJJs0JaBH_Zg4xC-epQ@mail.gmail.com>
 <595fe7d6-7876-26e4-0b7c-1d63ca6d7a97@redhat.com> <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
In-Reply-To: <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 25 Dec 2020 10:37:07 +0800
Message-ID: <CACycT3tLG=13fDdY0YPzViK2-AUy5F+uJor2cmVDFOGjXTOaYA@mail.gmail.com>
Subject: Re: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb message
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, akpm@linux-foundation.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 24, 2020 at 3:37 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Dec 24, 2020 at 10:41 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2020/12/23 =E4=B8=8B=E5=8D=888:14, Yongji Xie wrote:
> > > On Wed, Dec 23, 2020 at 5:05 PM Jason Wang <jasowang@redhat.com> wrot=
e:
> > >>
> > >> On 2020/12/22 =E4=B8=8B=E5=8D=8810:52, Xie Yongji wrote:
> > >>> To support vhost-vdpa bus driver, we need a way to share the
> > >>> vhost-vdpa backend process's memory with the userspace VDUSE proces=
s.
> > >>>
> > >>> This patch tries to make use of the vhost iotlb message to achieve
> > >>> that. We will get the shm file from the iotlb message and pass it
> > >>> to the userspace VDUSE process.
> > >>>
> > >>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > >>> ---
> > >>>    Documentation/driver-api/vduse.rst |  15 +++-
> > >>>    drivers/vdpa/vdpa_user/vduse_dev.c | 147 +++++++++++++++++++++++=
+++++++++++++-
> > >>>    include/uapi/linux/vduse.h         |  11 +++
> > >>>    3 files changed, 171 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/Documentation/driver-api/vduse.rst b/Documentation/dri=
ver-api/vduse.rst
> > >>> index 623f7b040ccf..48e4b1ba353f 100644
> > >>> --- a/Documentation/driver-api/vduse.rst
> > >>> +++ b/Documentation/driver-api/vduse.rst
> > >>> @@ -46,13 +46,26 @@ The following types of messages are provided by=
 the VDUSE framework now:
> > >>>
> > >>>    - VDUSE_GET_CONFIG: Read from device specific configuration spac=
e
> > >>>
> > >>> +- VDUSE_UPDATE_IOTLB: Update the memory mapping in device IOTLB
> > >>> +
> > >>> +- VDUSE_INVALIDATE_IOTLB: Invalidate the memory mapping in device =
IOTLB
> > >>> +
> > >>>    Please see include/linux/vdpa.h for details.
> > >>>
> > >>> -In the data path, VDUSE framework implements a MMU-based on-chip I=
OMMU
> > >>> +The data path of userspace vDPA device is implemented in different=
 ways
> > >>> +depending on the vdpa bus to which it is attached.
> > >>> +
> > >>> +In virtio-vdpa case, VDUSE framework implements a MMU-based on-chi=
p IOMMU
> > >>>    driver which supports mapping the kernel dma buffer to a userspa=
ce iova
> > >>>    region dynamically. The userspace iova region can be created by =
passing
> > >>>    the userspace vDPA device fd to mmap(2).
> > >>>
> > >>> +In vhost-vdpa case, the dma buffer is reside in a userspace memory=
 region
> > >>> +which will be shared to the VDUSE userspace processs via the file
> > >>> +descriptor in VDUSE_UPDATE_IOTLB message. And the corresponding ad=
dress
> > >>> +mapping (IOVA of dma buffer <-> VA of the memory region) is also i=
ncluded
> > >>> +in this message.
> > >>> +
> > >>>    Besides, the eventfd mechanism is used to trigger interrupt call=
backs and
> > >>>    receive virtqueue kicks in userspace. The following ioctls on th=
e userspace
> > >>>    vDPA device fd are provided to support that:
> > >>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > >>> index b974333ed4e9..d24aaacb6008 100644
> > >>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > >>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > >>> @@ -34,6 +34,7 @@
> > >>>
> > >>>    struct vduse_dev_msg {
> > >>>        struct vduse_dev_request req;
> > >>> +     struct file *iotlb_file;
> > >>>        struct vduse_dev_response resp;
> > >>>        struct list_head list;
> > >>>        wait_queue_head_t waitq;
> > >>> @@ -325,12 +326,80 @@ static int vduse_dev_set_vq_state(struct vdus=
e_dev *dev,
> > >>>        return ret;
> > >>>    }
> > >>>
> > >>> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, struct fi=
le *file,
> > >>> +                             u64 offset, u64 iova, u64 size, u8 pe=
rm)
> > >>> +{
> > >>> +     struct vduse_dev_msg *msg;
> > >>> +     int ret;
> > >>> +
> > >>> +     if (!size)
> > >>> +             return -EINVAL;
> > >>> +
> > >>> +     msg =3D vduse_dev_new_msg(dev, VDUSE_UPDATE_IOTLB);
> > >>> +     msg->req.size =3D sizeof(struct vduse_iotlb);
> > >>> +     msg->req.iotlb.offset =3D offset;
> > >>> +     msg->req.iotlb.iova =3D iova;
> > >>> +     msg->req.iotlb.size =3D size;
> > >>> +     msg->req.iotlb.perm =3D perm;
> > >>> +     msg->req.iotlb.fd =3D -1;
> > >>> +     msg->iotlb_file =3D get_file(file);
> > >>> +
> > >>> +     ret =3D vduse_dev_msg_sync(dev, msg);
> > >>
> > >> My feeling is that we should provide consistent API for the userspac=
e
> > >> device to use.
> > >>
> > >> E.g we'd better carry the IOTLB message for both virtio/vhost driver=
s.
> > >>
> > >> It looks to me for virtio drivers we can still use UPDAT_IOTLB messa=
ge
> > >> by using VDUSE file as msg->iotlb_file here.
> > >>
> > > It's OK for me. One problem is when to transfer the UPDATE_IOTLB
> > > message in virtio cases.
> >
> >
> > Instead of generating IOTLB messages for userspace.
> >
> > How about record the mappings (which is a common case for device have
> > on-chip IOMMU e.g mlx5e and vdpa simlator), then we can introduce ioctl
> > for userspace to query?
> >
>
> If so, the IOTLB UPDATE is actually triggered by ioctl, but
> IOTLB_INVALIDATE is triggered by the message. Is it a little odd? Or
> how about trigger it when userspace call mmap() on the device fd?
>

Oh sorry, looks like mmap() needs to be called in IOTLB UPDATE message
handler. Is it possible for the vdpa device to know which vdpa bus it
is attached to? So that we can generate this message during probing.
Otherwise, we don't know whether the iova domain of MMU-based IOMMU is
needed.

Thanks,
Yongji
