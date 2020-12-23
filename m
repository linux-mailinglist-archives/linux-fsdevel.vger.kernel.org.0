Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207E92E1D67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 15:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLWOVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 09:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLWOVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:21:52 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A933C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 06:21:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d17so23016767ejy.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 06:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO2qSmrlcvH/Mg353URhHC+az0KYy8E1wxQsqV9SPRQ=;
        b=W2D1X7Mt84Nb5kPnZCeMlcV6/EJ1C1Kf72P5VIvq1kMLdhbP0M0papBa7+vYe8Wi15
         NPFhxbIqrr0t2ILjWlPDIBukPf+/Tm8P0Qjg82ORwp2ZDQ8kPKOOqHV6YCk+z5HoQQR2
         N/sOA8wASeeWRe+9qMULmc2wP5q8YrthdFPb1yAV9z7fpBgJ+t6sqMkYt1BLGseE6Y93
         WaBOyDYrQ0hCPgaVTBoTSiBOFYk2/A4CbS7rh517lN4Df+DtboPsZNaI8UW09LWwapvl
         TqgC9nhiFXq80Wci02GtFXgyiKs0OkkjlcnKMXffPq68JG/1AH9qixjYGvtbrzeX0dKA
         ophA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO2qSmrlcvH/Mg353URhHC+az0KYy8E1wxQsqV9SPRQ=;
        b=G4h/Y9wpUpEtnrgkH75BeidM2SZm2NtI5DUi1fvExSmlOnDChUrh81nDoys+OdIMHA
         kebm/lhWTPT7PM0b50EjYNMI4rI8jPQVHGv32vZ/WF12h2ntlV1l9zfuMIYcAlejXLoh
         OT3Rd7NzaBtYg0Tt0q9Ah+gxfKl357dbx3Rx9PsfoMHmqNLfJT1shSWtU2fNo9pChV7Y
         tppkL7cDWMwJlPtq1wfVIFYCMRXRXdD+T3h15oenKezu8cyXivPAKzdJIuAg+h0iBZtj
         Wf+52Q6Qaft71x6ckbQ90vIMZER+gV+Q28w1WMN6wzR2UFl+adeUqV2dNjBJHhUh2lCS
         X0XQ==
X-Gm-Message-State: AOAM532Mv7VtATRAzBkY32A1fDDP7/rsM3EPKw8V2Joi9J/0d7bRXuKl
        TUJxRO90+P7xM1iPJ1LzTMwQt38+loDn3H9C39Ok
X-Google-Smtp-Source: ABdhPJyDZ7RLosJL1uvsLWRc15zFRYf5SX9dmIgXydDgct+kDOAYD16d+yCEo6mFFoh8eoAMZ1hGPgz68c4IgfcSJZk=
X-Received: by 2002:a17:906:d0c2:: with SMTP id bq2mr24108121ejb.1.1608733270934;
 Wed, 23 Dec 2020 06:21:10 -0800 (PST)
MIME-Version: 1.0
References: <CACycT3vevQQ8cGK_ac-1oyCb9+YPSAhLMue=4J3=2HzXVK7XHw@mail.gmail.com>
 <20201223081324.GA21558@infradead.org>
In-Reply-To: <20201223081324.GA21558@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 23 Dec 2020 22:21:00 +0800
Message-ID: <CACycT3u=1bBWzAN0w-cNxF7DPjsLw=s=kFVfCnMUCtk0vj81-A@mail.gmail.com>
Subject: Re: [External] Re: [RFC v2 01/13] mm: export zap_page_range() for
 driver use
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, akpm@linux-foundation.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 4:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Dec 23, 2020 at 02:32:07PM +0800, Yongji Xie wrote:
> > Now I want to map/unmap some pages in an userland vma dynamically. The
> > vm_insert_page() is being used for mapping. In the unmapping case, it
> > looks like the zap_page_range() does what I want. So I export it.
> > Otherwise, we need some ways to notify userspace to trigger it with
> > madvise(MADV_DONTNEED), which might not be able to meet all our needs.
> > For example, unmapping some pages in a memory shrinker function.
> >
> > So I'd like to know what's the limitation to use zap_page_range() in a
> > module. And if we can't use it in a module, is there any acceptable
> > way to achieve that?
>
> I think the anser is: don't play funny games with unmapped outside of
> munmap.  Especially as synchronization is very hard to get right.

OK, I will try to let userspace do this.

Thanks,
Yongji
