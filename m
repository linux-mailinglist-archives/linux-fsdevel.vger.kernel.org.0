Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E3B305667
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhA0JEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhA0JBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:01:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9CC061788
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 01:01:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id by1so1596994ejc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CvhPrcroD4ScESfvgvRctMUe8FBLv514keyLyHRZDbY=;
        b=jdd6IZ5rNNH7ay5CWnkO4rDIvKDpbbSemE10InrR25X1zlvICut5ZM0P9AbImglQiu
         xuwnsi4fd/5NATT4++iicCnxpDnXAYMZ3n4hortkfkhH8uaDRveeYhTgh0Dxh6ZXYyKp
         fpki+IDTkloZipAXjHXNiStWUny+GS/Jyy53A1+9mZtGouG4E/C5kTsbj126oyg4uK+7
         9E47fzC+HywTrBk0RdBZU7zBS449AZPU546g1r7tqu8UDekk3hv9ZHnHREtHYjMSasGs
         GRs4IMz/ofdHv4Hy2BsDA1HDyTuQdpbMwqLi0aPiLazFjKvvEk7yH01Tx+WUcQJJ2nzS
         Pwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CvhPrcroD4ScESfvgvRctMUe8FBLv514keyLyHRZDbY=;
        b=aKrLxJl6eo8hrtpP6Hwkb5+NW2XvIlK/kKW+LlL9OWpqEmW7XtDHZ5VdLWbno2t8s9
         REjt7n4ByGmJ19a5FXm0zsoWJ4OybfFKe53/v3fB2VlXzslTakW2bQclDsvJxb3LNjRG
         aE9iW5hp5WVhP5r06X2Akat5aOJCoYrR5UumG6uyUMmnsRHyRC/8W8MPAzjvZBDNb8Ku
         Z7S4j5igVf9tK8BJSbC4j830nwKXErD+TJuG5NnfnEOOeFzI6wlUyKC3XIGpwp+QwbHu
         vTCIh6LGLC5GKlTcNieffkzmv8X/rl+fVtU+l7hvImZ8cbKAr2TLwVANxA8ai7/IWbF2
         OUBg==
X-Gm-Message-State: AOAM532RW3TWMsvMq/6zQnxqsm7BscQSZ+nZF67uOyOWjtPJ8UMZLLUg
        PCfEEY6s7mvRYpO1+0QQ0Gwz+SDgSIi8JuAq//l0
X-Google-Smtp-Source: ABdhPJxtxlsv/zG/t8Q8ZtEe1vLrLr5egbs6sFwRGutMTUs8mWfam54iv13Bg8Ina5lqMbBMMCqZUnnSbBmDjY8Tn1E=
X-Received: by 2002:a17:906:128e:: with SMTP id k14mr5892133ejb.427.1611738063009;
 Wed, 27 Jan 2021 01:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119050756.600-1-xieyongji@bytedance.com>
 <20210119050756.600-5-xieyongji@bytedance.com> <9cacd59d-1063-7a1f-9831-8728eb1d1c15@redhat.com>
In-Reply-To: <9cacd59d-1063-7a1f-9831-8728eb1d1c15@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 27 Jan 2021 17:00:52 +0800
Message-ID: <CACycT3vrN0qZp=KzFuzsbDvPvMeXYPYiHBF0ZWBf3m=e2BCvfw@mail.gmail.com>
Subject: Re: Re: [RFC v3 11/11] vduse: Introduce a workqueue for irq injection
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 4:17 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/1/19 =E4=B8=8B=E5=8D=881:07, Xie Yongji wrote:
> > This patch introduces a dedicated workqueue for irq injection
> > so that we are able to do some performance tuning for it.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> If we want the split like this.
>
> It might be better to:
>
> 1) implement a simple irq injection on the ioctl context in patch 8
> 2) add the dedicated workqueue injection in this patch
>
> Since my understanding is that
>
> 1) the function looks more isolated for readers
> 2) the difference between sysctl vs workqueue should be more obvious
> than system wq vs dedicated wq
> 3) a chance to describe why workqueue is needed in the commit log in
> this patch
>

OK, I will try to do it in v4.

Thanks,
Yongji
