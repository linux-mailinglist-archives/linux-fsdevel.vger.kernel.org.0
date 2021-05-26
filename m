Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D70390E65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 04:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhEZCpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 22:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhEZCpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 22:45:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B116C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 19:43:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l1so27783ejb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cyqKIBrVaRZ0+l7SzJYRtSgO5kugLUClFhe3a16fIks=;
        b=xKidA34PKHbdo2S/y22PDRHuVMfazORIWEYHJGkmXyiAr04A+1NKfCILQLnwTFsJTw
         lRVUQruT7CSfwCc2cJ2LKYGi325kEZ4NNyjn0UtAMMopoI0WzAE5ZrPqYsCmv/lbWb0c
         z7ZqeM601wal6FC3dk9EhBre/t358GYPWlBkbbUdYNaKqlAK5vqVByIYmyXwX/y93vzO
         bRNWCBb4JkU4DGAkIgbl4WTCvgU7CxcbWXya1+zo+mLJ+4sIWFlH/9XI6s69LnYlT6TH
         Md+EyrgGTL9No0zpG2C/7ZHuO/606d+nruZSCbn/IOzSAExbb+3m94kMbAuqlPQ0irwx
         J8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cyqKIBrVaRZ0+l7SzJYRtSgO5kugLUClFhe3a16fIks=;
        b=SSb4Z5TpDeEYHLDS9YjsFWzoC9XBfYnwhSEY78fWyikaYwXbd5HY7uS8n43OmIik6n
         ahwEd3Hg4Z1dz/paQIy1amKQwAfjoJ05k2Q41qenPz/qC+I6+r0RB7fAjZpI380tKVlc
         P65IHTEXsbpfFUbo6a2b7/JoJBvr1wCZfry3/Q4lnb+Fa/su2qcn8LKlGfpKSVIAf1Zo
         z3mJMGFrrGPuOzuhhKiu6sVydZEi2ehuDTgaayYpa4D9V/XFqKKO7Qv4Ub25Bj0W53dw
         Hp6hbxI8vCgj9qD9T8pjsLOerG0KVtFtVYbPGgZ+a362GrOJ6dyj+kHOoLcavIxnQ3LK
         Uwqg==
X-Gm-Message-State: AOAM5303tlhct9fiIWvrNSyfM7IDFq0YqwUpdDA+HXuHCIxVzwqNhSul
        bSD29/sHaZuHj3i4jmVKzNTl6VQMyhd3z00ReVK26h9Gcg==
X-Google-Smtp-Source: ABdhPJzi0wHuPmnuk+fERsSUwpHSaQvSPFz85+F584XY7DhSy3CxdOjcgz0J1YNwvp5PC9EH+9a60IN41oTUEUABAxo=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr31013766eja.427.1621997023688;
 Tue, 25 May 2021 19:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com> <20210517095513.850-2-xieyongji@bytedance.com>
 <6ca337fe-2c8c-95c9-672e-0d4f104f66eb@redhat.com>
In-Reply-To: <6ca337fe-2c8c-95c9-672e-0d4f104f66eb@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 26 May 2021 10:43:33 +0800
Message-ID: <CACycT3sA7jYr1TbBT+Q4wkiiqvk-sJppwzXvffeEUAgBMXOxfA@mail.gmail.com>
Subject: Re: Re: [PATCH v7 01/12] iova: Export alloc_iova_fast()
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
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 10:36 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/17 =E4=B8=8B=E5=8D=885:55, Xie Yongji =E5=86=99=E9=81=93=
:
> > Export alloc_iova_fast() so that some modules can use it
> > to improve iova allocation efficiency.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/iommu/iova.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index e6e2fa85271c..317eef64ffef 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -450,6 +450,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned=
 long size,
> >
> >       return new_iova->pfn_lo;
> >   }
> > +EXPORT_SYMBOL_GPL(alloc_iova_fast);
> >
> >   /**
> >    * free_iova_fast - free iova pfn range into rcache
>
>
> Interesting, do we need export free_iova_fast() as well?
>

Oh, yes. I missed this commit 6e1ea50a06 ("iommu: Stop exporting
free_iova_fast()"). Will rebase on the newest kernel tree.

Thanks,
Yongji
