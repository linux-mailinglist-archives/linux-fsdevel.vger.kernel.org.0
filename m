Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021E03B6E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhF2Gnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhF2Gni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:43:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46727C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 23:41:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s15so29659869edt.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=llkKHmBkfnr2e7nGu5wo9NWF1Rvx5VVNTXNZeIaOEY8=;
        b=b6IxjHxgrsOeV79Ht0Ax4/VA7XYqaQCz8mEI89nlODOpkbbNQKkT86lVUMKt1PlsZi
         aO9kArwDvjiDefLm8Gqo0xUt1Mk7mf97PWF41AYIIn47zWADydgm2jEpt5HbuvJNgu5D
         ntPRGt8AK87ZDLLlBie2K5g/5+KlMcWQeGjcg4WsoHO2ksy66nVpAOJnvc90t5QRYxsZ
         lmYM79ne39YAIfMIugI5AFk+AfwA9H9Bbs5SlIVioXOv0ITHb/z3Mum0jibvHXkilmpY
         vBesh85ghF0T5N8Mk3dWMoelFiG83Ubtv9E3WAB1/u1Mox5/MvGtN3SeVQ5/0Ut6/dR8
         OyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=llkKHmBkfnr2e7nGu5wo9NWF1Rvx5VVNTXNZeIaOEY8=;
        b=n2Q3qAqxGgRXTSz+eBYmudJw+Qsk4mXStVmnMa7OZYJTbTHaibK53r/qka3vfnGj+z
         WhJ7bX1dwQwp8w/HmKy1auLc8Hf3A+z4xXdH02S5jUTqINVeZPNVqWuoDF4T6GCiRlMz
         eHJEKSd03eNqxa5X14zUcnM1jIeURtFrK9Be3WTvOFtd2wv7J+HyadqiuGmikEvid7RW
         SNvkyNm2+I1fVWosUwNaS2Uc6MrvHfP+pkSdlN5HmrX1Q5LSOIaLuaeBHRXEG7nVHXzi
         FsL21EMJFIBek/ctYF24bOgAjqOSHOmx8n5QKHn50Rvi1pWx8IaL3FX3fcwqZf/GViYu
         bCfg==
X-Gm-Message-State: AOAM532/RHRQwqrTXcWIkt7t45CLkoC0h+FL3ypNtam+I0h5HQ3qQGXM
        LzMjBqHJ5VUqdK9hwZikOAQHoJn/YuiJgUAspZU7
X-Google-Smtp-Source: ABdhPJztCqFdUxDVPRMjQB4Q3BvYvtgtIsSUG1gu1hpU8fUwWsabUxu+tfnt4bzd/O6vpsvz+4mWTWvqMD3uAaEQxFk=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr37794534edu.253.1624948869940;
 Mon, 28 Jun 2021 23:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com> <20210628103309.GA205554@storage2.sh.intel.com>
 <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com> <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
In-Reply-To: <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 29 Jun 2021 14:40:59 +0800
Message-ID: <CACycT3vVhNdhtyohKJQuMXTic5m6jDjEfjzbzvp=2FJgwup8mg@mail.gmail.com>
Subject: Re: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To:     Jason Wang <jasowang@redhat.com>
Cc:     Yongji Xie <elohimes@gmail.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
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
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        iommu@lists.linux-foundation.org, songmuchun@bytedance.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/6/28 =E4=B8=8B=E5=8D=886:32, Yongji Xie =E5=86=99=E9=81=93=
:
> >> The large barrier is bounce-buffer mapping: SPDK requires hugepages
> >> for NVMe over PCIe and RDMA, so take some preallcoated hugepages to
> >> map as bounce buffer is necessary. Or it's hard to avoid an extra
> >> memcpy from bounce-buffer to hugepage.
> >> If you can add an option to map hugepages as bounce-buffer,
> >> then SPDK could also be a potential user of vduse.
> >>
> > I think we can support registering user space memory for bounce-buffer
> > use like XDP does. But this needs to pin the pages, so I didn't
> > consider it in this initial version.
> >
>
> Note that userspace should be unaware of the existence of the bounce buff=
er.
>

If so, it might be hard to use umem. Because we can't use umem for
coherent mapping which needs physical address contiguous space.

Thanks,
Yongji
