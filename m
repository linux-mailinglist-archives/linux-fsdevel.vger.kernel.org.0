Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FFB389E97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhETHEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 03:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhETHEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 03:04:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10793C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 00:03:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c20so23587530ejm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZuC9MkEtBjxIYtF7kqVL9Ifpq76zVZvowCEWkRzdAs=;
        b=isU1Bu0LYOcmwo2kZ+cxn6aLNagpy/yAVpavSdt0QoSh70Zxzbz5Cbo9vgX0zVM+vf
         tJNWmzAPB2voZMyxrgD0fjafieA+/5wH0Mv8ATKJmh53aalUm9SUQODFqqVPbg+PUdXo
         H9R7EQmWsf3D+ZUsHmp9gvDaJl1QtHo6qQ2vRr8rGBd+2OjYWeVB9bT0M1QVLkN5C8NS
         CmrUJFwCufbKYOtmvdGOBvbocV6hZEeNWi65kA9s7cR0hY6RVWe/Ei7CHfzZxWR5wnd8
         oE71NvDhg8fGP9ZL2M9OYpa+NfrMb0l/lEZ9YFBFN741IDnOTCnHVcEs0BWYU0gIhGb4
         /1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZuC9MkEtBjxIYtF7kqVL9Ifpq76zVZvowCEWkRzdAs=;
        b=aAs+LROSzGxHTViWADn3D4HROXz1ZnmnW6lZu5B4h0txpgwSi43QSISqxDMH5reuPa
         cyHzBR+OMUw2Z23rHVe/oQhrEIHp1o/BAHofztrKBVMNQLEhyQaF+wZQh1mwbQ3agXu3
         Zt5CsWK0Cot8nn6KbotMiLz40izPPBlC8gTt6FEiuqnpPom4PPXWftDrhf9Hrnill+jd
         PRt2zIAXzxI5GVm2LFUBHGjg2d09xRwZrw2pcfvdPAkpMNYN3kmcrUp82T6RUfeeV5Uc
         ucJvHesreZ79me4FvVR8i5NVCXErHjckeC9pODKIHoJLSCnIpbVSl9n38Y8j2V1OhTFI
         eA6g==
X-Gm-Message-State: AOAM532FTRkwkSDnYtVzGW58tQ6TYlCJnyXvRjAucX/OOaekfnS6+moe
        TuBj+Zq04ofJtPaquLlFO8DZCz+NnAk1g7U2IuyS
X-Google-Smtp-Source: ABdhPJxdx8w+fCqswSdKs59iVuZd4vAf9uGIN8nGG/abyN54M6HaotKLEQyMezCx9lo1kEngrpWm4QyOMlEiGHNAl0E=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr3165937ejz.247.1621494192590;
 Thu, 20 May 2021 00:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com> <20210517095513.850-12-xieyongji@bytedance.com>
 <YKYBle/F8aOgHO9p@zeniv-ca.linux.org.uk>
In-Reply-To: <YKYBle/F8aOgHO9p@zeniv-ca.linux.org.uk>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 20 May 2021 15:03:01 +0800
Message-ID: <CACycT3vTvdJN4qnp=O8E5fxR15evMexzsK+V_uFT0LZkRSCitw@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 2:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:
>
> > +     case VDUSE_IOTLB_GET_FD: {
> > +             struct vduse_iotlb_entry entry;
> > +             struct vhost_iotlb_map *map;
> > +             struct vdpa_map_file *map_file;
> > +             struct vduse_iova_domain *domain = dev->domain;
> > +             struct file *f = NULL;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(&entry, argp, sizeof(entry)))
> > +                     break;
>
>                         return -EFAULT;
> surely?
> > +
> > +             ret = -EINVAL;
> > +             if (entry.start > entry.last)
> > +                     break;
>
> ... and similar here, etc.
>

OK.

> > +             spin_lock(&domain->iotlb_lock);
> > +             map = vhost_iotlb_itree_first(domain->iotlb,
> > +                                           entry.start, entry.last);
> > +             if (map) {
> > +                     map_file = (struct vdpa_map_file *)map->opaque;
> > +                     f = get_file(map_file->file);
> > +                     entry.offset = map_file->offset;
> > +                     entry.start = map->start;
> > +                     entry.last = map->last;
> > +                     entry.perm = map->perm;
> > +             }
> > +             spin_unlock(&domain->iotlb_lock);
> > +             ret = -EINVAL;
> > +             if (!f)
> > +                     break;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_to_user(argp, &entry, sizeof(entry))) {
> > +                     fput(f);
> > +                     break;
> > +             }
> > +             ret = receive_fd(f, perm_to_file_flags(entry.perm));
> > +             fput(f);
> > +             break;
>
> IDGI.  The main difference between receive_fd() and plain old
> get_unused_fd_flags() + fd_install() is __receive_sock() call.
> Which does nothing whatsoever in case of non-sockets.  Can you
> get a socket here?
>

Actually what I want here is the security_file_receive() hook in receive_fd().

Thanks,
Yongji
