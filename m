Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80F43B3FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhJZO3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhJZO3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:29:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD64C061745;
        Tue, 26 Oct 2021 07:27:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s1so14504724edd.3;
        Tue, 26 Oct 2021 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZkJRL0lPRthFxQ90psMtV6Y2lcv2PWeua158fYiZ2tE=;
        b=VtSn4Qsf+26WNtb9faKkgDJYjE+Y/NifymUBTasTLjEZHV5DjzChjuKMOzrM9ga++F
         +2LSiHWb+HVvmU70Qason5S/qaPC2Av3LXUmXx9QzXYYMpqvfYqHjuSruE/KAZVkvGLz
         InCwl55UA0vUpA8Zc3p3TZQYuF0bBNSrD/hLOC65yHokL8hXfHDe2Npgdq7xFEZOf1Se
         4/aVyntg8sQwpAtHFMH3suBvpy2mQzuIU7IaXbblOMNzfIojyISlS5gqm3pxsJCo83vD
         sPQFh7HLO1dpSUT0fDnNLNAylF8pOb5oG4/g7EvAs0bZXTW8URjYww9v1aRPdQk+83yL
         gY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkJRL0lPRthFxQ90psMtV6Y2lcv2PWeua158fYiZ2tE=;
        b=lgNvgGNIP9Z5TX+uLE6zbrxQKCd18O3hHB915xMgUxs8RYUKUnMh9auayzYQbKUpip
         bcFi9C9BEeBGceOJidCP83kPUVpwm9kq6Q+0nvpAPCEgfW00xOF8rVZOP0Tay6gpW7Em
         T0d2gad/IhpcUZdsAed6eHX4u0u/TowXe2JNC7s49SMjKQOZUnWX24xZVowx2XuaBM2K
         Bca1AVeeVAtheo9UDngNw89Rz1H9uI1PliRH/2yGo8M6IWIBtRs1i16NoI4odaZrSStO
         I8x5tMruOo285aBdPfegE1plnJC1ZVLdm1LdhS7AKC6bT7uFxfLvUzbLFbAxVp6NkB0H
         ZvsQ==
X-Gm-Message-State: AOAM5318A394AgJUMpjmSsj/9Ge9orQLysvDMkDefVuL1671oi3k6pKq
        JcfA0V9ktDWytoF5l6ttXxbNdMKDWKHA7JT/3zo+WW25p/E=
X-Google-Smtp-Source: ABdhPJzAbha01GzhYnNbtdP2nscjIzf9PN4ekdMn/3Fr8Wwd9C8/kUL/KLZ68gKE8NdMa8m5PpRRMxEYjLqzD9/sJ88=
X-Received: by 2002:a17:907:d08:: with SMTP id gn8mr30687462ejc.395.1635258318314;
 Tue, 26 Oct 2021 07:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz> <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan> <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz> <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
 <20211025094841.GA1945@pc638.lan> <163520582122.16092.9250045450947778926@noble.neil.brown.name>
 <YXeraV5idipgWDB+@dhcp22.suse.cz> <163524388152.8576.15706993879941541847@noble.neil.brown.name>
In-Reply-To: <163524388152.8576.15706993879941541847@noble.neil.brown.name>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 26 Oct 2021 16:25:07 +0200
Message-ID: <CA+KHdyWev2RwoO1o9OrAkaE2VdC7iSXnJdBR+qzarqYOse3cXA@mail.gmail.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
To:     NeilBrown <neilb@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 12:24 PM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 26 Oct 2021, Michal Hocko wrote:
> > On Tue 26-10-21 10:50:21, Neil Brown wrote:
> > > On Mon, 25 Oct 2021, Uladzislau Rezki wrote:
> > > > On Fri, Oct 22, 2021 at 09:49:08AM +1100, NeilBrown wrote:
> > > > > However I'm not 100% certain, and the behaviour might change in the
> > > > > future.  So having one place (the definition of memalloc_retry_wait())
> > > > > where we can change the sleeping behaviour if the alloc_page behavour
> > > > > changes, would be ideal.  Maybe memalloc_retry_wait() could take a
> > > > > gfpflags arg.
> > > > >
> > > > At sleeping is required for __get_vm_area_node() because in case of lack
> > > > of vmap space it will end up in tight loop without sleeping what is
> > > > really bad.
> > > >
> > > So vmalloc() has two failure modes.  alloc_page() failure and
> > > __alloc_vmap_area() failure.  The caller cannot tell which...
> > >
> > > Actually, they can.  If we pass __GFP_NOFAIL to vmalloc(), and it fails,
> > > then it must have been __alloc_vmap_area() which failed.
> > > What do we do in that case?
> > > Can we add a waitq which gets a wakeup when __purge_vmap_area_lazy()
> > > finishes?
> > > If we use the spinlock from that waitq in place of free_vmap_area_lock,
> > > then the wakeup would be nearly free if no-one was waiting, and worth
> > > while if someone was waiting.
> >
> > Is this really required to be part of the initial support?
>
> No.... I was just thinking out-loud.
>
alloc_vmap_area() has an retry path, basically if it fails the code
will try to "purge"
areas and repeat it one more time. So we do not need to purge outside some where
else.

-- 
Uladzislau Rezki
