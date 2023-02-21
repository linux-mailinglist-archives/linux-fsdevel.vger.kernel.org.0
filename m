Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD069E808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBUTJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 14:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjBUTJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:09:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA729140;
        Tue, 21 Feb 2023 11:09:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so6251474pjc.0;
        Tue, 21 Feb 2023 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7toiITCf4zEDwukcWIEguEJe64NlPZx5g99K0VzyLdE=;
        b=bdhJMgh91hdqT4luYd5ioY/yBXBRYAcZQsrKyzfveBzI6gQiYch96TORD+AxB6uQk5
         oyAYXLrRF89zBrePntkph1MFBau8LlCFmliyyexlK0j+3mbX1GbnvNgBjezJVVByiuK6
         MBiBBJ+EcGIQp5x7oabLl73LgLF+Cmlz8VfVPinHfxB11/IW9v7uriJCTkaG/CJizM6w
         aDR2n57qZhkpUfLGBKS4SRojyDwEm0mrj+xKqE7p0TryLWAkHhYiKsM+en/HnklvLWF+
         LXwxDNEtUbd1NpX/LR+4xebS+8N9Y4qW8vqOXqDFgwu6S98CGAngdWBGfGOBhpX9kHu5
         FLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7toiITCf4zEDwukcWIEguEJe64NlPZx5g99K0VzyLdE=;
        b=Ox1ca5/By2GgQWq2CF+QLdqmOa83ey1x6F+RT4GSUPx+qCp2vDBboOVxl3DcKhqP3o
         hlCmUnJcMfH8V/ZrzyOIj0jBLn7s+Dgd24GbdQT4Zml4F3hfHaEPyB5xKc373vlEeR7z
         n36pQvzihjcn4RRcbjVPH5MDIOiDSfGYYmwQ3mubXansTDw0Y9rYyOCjcXN+KJ6DgIkO
         hWIQmkUE9Z8MFbmjAllD4e2SQFPKeOgkzSvVNYMxKu3SXzhiqyRkwTCGWJb+PCnzgDVq
         7W9dlA+nNp1UWQ7tZgy1gYWGUBf11V567vUwt+I11GIBfi13+CTkdG0cK9/bjP3zE+DL
         8weQ==
X-Gm-Message-State: AO0yUKWuy+G3rvCmYr7nvdgI+0jO2Yfy5HjNnJ1NDWRJXMsTjjwo8ppx
        7wxSjMlCWTP/2qBe99geqrzu4Fmyy48HcKqE03k=
X-Google-Smtp-Source: AK7set8YEZqM92nnqZUTzt9FzDBxitixBpPf8665l200lnehWpcnu9yFX9pL1BBOzg3ERV6oA+03SYtDiAWrbbJF4no=
X-Received: by 2002:a17:90b:3b92:b0:233:e796:7583 with SMTP id
 pc18-20020a17090b3b9200b00233e7967583mr1597504pjb.1.1677006565041; Tue, 21
 Feb 2023 11:09:25 -0800 (PST)
MIME-Version: 1.0
References: <Y9KtCc+4n5uANB2f@casper.infradead.org> <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
In-Reply-To: <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Feb 2023 11:09:13 -0800
Message-ID: <CAHbLzkqsyv6rw-RRvNcB0PoEE75qS9ZtmywhJYZbVA05d5tj5A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:08 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2023/1/27 00:40, Matthew Wilcox wrote:
> > I'd like to do another session on how the struct page dismemberment
> > is going and what remains to be done.  Given how widely struct page is
> > used, I think there will be interest from more than just MM, so I'd
> > suggest a plenary session.
> >
> > If I were hosting this session today, topics would include:
> >
> > Splitting out users:
> >
> >   - slab (done!)
> >   - netmem (in progress)
> >   - hugetlb (in akpm)
> >   - tail pages (in akpm)
> >   - page tables
> >   - ZONE_DEVICE
> >
> > Users that really should have their own types:
> >
> >   - zsmalloc
> >   - bootmem
> >   - percpu
> >   - buddy
> >   - vmalloc
> >
> > Converting filesystems to folios:
> >
> >   - XFS (done)
> >   - AFS (done)
> >   - NFS (in progress)
> >   - ext4 (in progress)
> >   - f2fs (in progress)
> >   - ... others?
> >
> > Unresolved challenges:
> >
> >   - mapcount
> >   - AnonExclusive
> >   - Splitting anon & file folios apart
> >   - Removing PG_error & PG_private
>
> I'm interested in this topic too, also I'd like to get some idea of the
> future of the page dismemberment timeline so that I can have time to keep
> the pace with it since some embedded use cases like Android are
> memory-sensitive all the time.
>
> Minor, it seems some apis still use ->lru field to chain bulk pages,
> perhaps it needs some changes as well:
> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com

The dm-crypt patches don't use list anymore. The bulk allocator still
supports the list version, but so far there is no user, so it may be
gone soon.

>
> Thanks,
> Gao Xiang
>
> >
> > This will probably all change before May.
> >
> > I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
> > their work to convert various functions from pages to folios.
>
