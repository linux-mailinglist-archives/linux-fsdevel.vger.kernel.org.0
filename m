Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9D743B5EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhJZPqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhJZPqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:46:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A90C061745;
        Tue, 26 Oct 2021 08:43:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u13so16074695edy.10;
        Tue, 26 Oct 2021 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4M/22FGw7e6SSuR5+lAvRn2uYeHyXsIaqiFpPFs7GM=;
        b=fLE5FaJ7rSAWggLqi5i/+7DBIp3Y1MLINJl7IInXpX/M/SMHMaEnlea8EP/eli4Rbi
         FGnhzsqSa1IHRPlv16Fl3FiQ3037bmP6vCyLIlnT8X9cNn/yERfSSWntfqcBLBZbNBb6
         CG1OGMgcixKEC73YyzjNFhXFsU8enn7tNqODq1d5LSBPPnW+MZRbOpwxJ52WwCNgx/Tt
         6KV4cvLRt69SFEuQ2gqa0nOjaRsv7ApGMvTmxh3hFELX69O97XIZF20Tc4PtOD00462w
         zSraUZQWUCGLDM6RcXBV1tJcX19NTtFcAKhqQ0Tdx2Jo+38EwEuNRCFAPKqcveo5VNb1
         Ts2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4M/22FGw7e6SSuR5+lAvRn2uYeHyXsIaqiFpPFs7GM=;
        b=HnCGDnDJ8Zro5H5qOKn7K2SRCz10/Iydu+XdFIFNZmUUbCZ5c//8vtixJ3LRUN0j+Z
         aNTl0Ck3iST4xs+7SCBjfvIctdNyCkcyJL7UqqRfHjA7dzZwcYodzjcvnn3U9KGg8KW3
         jGxsFFoGooZdQW1rTkmp0vAywug1NBCh55PgIW8cp8XuxsPHZYzHefSR/VwjxiOrlA37
         OuAghle1b6Pw08cL2KZYsgKdwVkVeiCZBVQbj72QKpUETCY9ec36nkYCRwFnkh3p+Kie
         /loQQs/kbN+pcn8GOuppsew7v6h9CC94bHuGR746XQaUlo9pJ668JryfAUQWiOg5W+qX
         rSfg==
X-Gm-Message-State: AOAM531ir1NUNqch2pmgOura8yhlxy5TV9czgeak6Ot+g1d2A/xfZ4Vr
        +39J+FKYgDXFEWMa0E0CJtKzXkxHQiejIv1FidlCsY+zK9J7zQ==
X-Google-Smtp-Source: ABdhPJxHqML5RddOenfRBlL1vPTQYiXn+SaTgxIuuPWFvPtteHluOBrnxEczYR4MVa+OooX2R/p1c7LAPGiSDW7qFUY=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr36306045edc.106.1635262845117;
 Tue, 26 Oct 2021 08:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211020192430.GA1861@pc638.lan> <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz> <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
 <20211025094841.GA1945@pc638.lan> <163520582122.16092.9250045450947778926@noble.neil.brown.name>
 <YXeraV5idipgWDB+@dhcp22.suse.cz> <163524388152.8576.15706993879941541847@noble.neil.brown.name>
 <CA+KHdyWev2RwoO1o9OrAkaE2VdC7iSXnJdBR+qzarqYOse3cXA@mail.gmail.com> <YXgUI33cfWYYrjXw@dhcp22.suse.cz>
In-Reply-To: <YXgUI33cfWYYrjXw@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 26 Oct 2021 17:40:33 +0200
Message-ID: <CA+KHdyV2_s6Jro2JhQ2kNhexN+ktR+fCcMZHW8uq+3X+hak5ow@mail.gmail.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
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

> > > > Is this really required to be part of the initial support?
> > >
> > > No.... I was just thinking out-loud.
> > >
> > alloc_vmap_area() has an retry path, basically if it fails the code
> > will try to "purge"
> > areas and repeat it one more time. So we do not need to purge outside some where
> > else.
>
> I think that Neil was not concerned about the need for purging something
> but rather a waiting event the retry loop could hook into. So that the
> sleep wouldn't have to be a random timeout but something that is
> actually actionable - like somebody freeing an area.
>
I see this point. But sometimes it is not as straightforward as it could be. If
we have lack of vmap space within a specific range, it might be not about
reclaiming(nobody frees to that area and no outstanding areas) thus we
can do nothing.

-- 
Uladzislau Rezki
