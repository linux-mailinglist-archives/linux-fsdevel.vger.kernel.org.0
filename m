Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FAD2FC905
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 04:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbhATC34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 21:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbhATC0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:26:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088A2C061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 18:26:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id by1so24970193ejc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBePnOAwZBQb0dFg0gQ+d7YGVLbKQhuKKUpxdihg8xw=;
        b=LB6kDMOtqkpE7gTzQl38DEPBvXbLSTBlsbJxXoOYf8YjfF5k3es63847L/iApG8tyu
         GU79SOybW0byS1xGi1kEI42XZfpf5a4JhXNwXYGsmvehOvqkt2M9KFWzQm/uSqrVJhAj
         CaHl8G12wqKvSw5Ox8KrDo5kFWFoFzZ6TYbSCth/TKonjHa0KVF6wdLBdwnINl87uExX
         d6VMJOWD1vrRgAkrABgI/Oatatd6mW+xjawoN0FSYtgjVllaRBZCRApdd0CN+A8rqUaZ
         a2F50mlbMVLmPyeG7goZTEvELwU9kDZOzBR9f9D3VFpRZuBktM+Cm4UDvgUEU8CFnmH6
         BGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBePnOAwZBQb0dFg0gQ+d7YGVLbKQhuKKUpxdihg8xw=;
        b=ZiJUdrogSYa2mxZUQrsgQ6csDB0p+6wR5CCRXYv281fXxFlNVupgRgqPUrUJQUn/qI
         K/TjDMaPS+0A/L7WfBczlHw9NALiF/AP0JRCzNKk1ou+epvhP/iVpCkO2FVT44juZ378
         W0Aq6W3hgN1t9P+Lfy8BdIxqZ3PB3YneAgaHCWlI4AqmeQU7Ls11fFlvFGn/oj76lwFt
         +25BRHNRl/VTEwsZaHR1q+qCW9r9HLJSXtQCTkdFDkgJXHibvGL66LAG5firwke1mdJI
         7+SKxcNaA9GRM648csPtbjNFyRU/I2X5n2qZ0cZdywnDrOx4n21lrY6QoLQbO+QT2fek
         0e1A==
X-Gm-Message-State: AOAM5300IokSNXIPEB9Bf4AdJ5FKFudOaGXs1tskxKmxG7IcnFDnC59c
        5HOJ0DeEc1Vzo0C4pGXAsWBAaWxj0501LvHF17xj
X-Google-Smtp-Source: ABdhPJzbiYr+nq4JjIVaAfFEWXYt26uUaLS8YnaaZ4H3bL6ASL47qMuMWg0GdgC4s7ZNiHZxzUxSwnHbPEPhV9hKXNw=
X-Received: by 2002:a17:906:5254:: with SMTP id y20mr4656020ejm.174.1611109567772;
 Tue, 19 Jan 2021 18:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119050756.600-1-xieyongji@bytedance.com>
 <20210119050756.600-2-xieyongji@bytedance.com> <20210119075359.00204ca6@lwn.net>
In-Reply-To: <20210119075359.00204ca6@lwn.net>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 20 Jan 2021 10:25:57 +0800
Message-ID: <CACycT3uN+CJ8x_9mqA9oNzXBB+XojkMVibk_sP-ug3QGJP7yUw@mail.gmail.com>
Subject: Re: Re: [RFC v3 08/11] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 10:54 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> X-Gm-Spam: 0
> X-Gm-Phishy: 0
>
> On Tue, 19 Jan 2021 13:07:53 +0800
> Xie Yongji <xieyongji@bytedance.com> wrote:
>
> > diff --git a/Documentation/driver-api/vduse.rst b/Documentation/driver-api/vduse.rst
> > new file mode 100644
> > index 000000000000..9418a7f6646b
> > --- /dev/null
> > +++ b/Documentation/driver-api/vduse.rst
> > @@ -0,0 +1,85 @@
> > +==================================
> > +VDUSE - "vDPA Device in Userspace"
> > +==================================
>
> Thanks for documenting this feature!  You will, though, need to add this
> new document to Documentation/driver-api/index.rst for it to be included
> in the docs build.
>
> That said, this would appear to be documentation for user space, right?
> So the userspace-api manual is probably a more appropriate place for it.
>

Will do it. Thanks for the reminder!

Thanks,
Yongji
