Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98782133060
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 21:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAGUMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 15:12:32 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35815 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgAGUMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:12:32 -0500
Received: by mail-wr1-f54.google.com with SMTP id g17so955433wro.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 12:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scWmuV51MzPaZ/5dd+QTYQ1su+cxyZ1p8Ywl9lzrvds=;
        b=zfVzzICDT1ePi3j4lxyWxJ8m/yGu/TyvCvg1kHDSdjarP3Os0zfNVUKwjVE3VPMFL0
         CHJ4h3y6XVKSjHDpaSaQXpa4n/zKXDBq9dggTiU/dIvEagnN7DNLJW1+gXuWzNWWvuxW
         /3GYfZQ+idIVSdilS8U3bP+Uz2f0CD9rjg5OEVGCzpznXplDrLbgeIv6HiE2fykJvahO
         wighp32ldraj0PbYtBtxZ5IADmNpE9rmDUSTzgeICNDTkPWfkUPWbAgwDgvrBNAN7pbM
         KPomjBNryaKTsfsTfotEZ6qDweo1R4v5d3x3lejULkfqV55KKCHDWaeKn3581p86UOsb
         x4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scWmuV51MzPaZ/5dd+QTYQ1su+cxyZ1p8Ywl9lzrvds=;
        b=suUwj22Z4q0Xf7sTXCCxQ6Riil/6TdmKGmRGsTOhcAfZKxYtel0DpvbwmLXXZeXzFi
         kNl13JmT6USRbkFsMHFO7DAU6Iyr7yRqVNzJ3DIHkFGrNQcY6HXXMmRJjynavegelV61
         f3FdIUFJhP9knRNG3SuYtPturB4sGSOyxQQy5vgxznUHYWJ6c2JelmeTLb4a0tOiZL3h
         97TjjLq2vn64s2dGFRCiPO8tfAfI709mxeX02lC2z14gT0QjUdCvKH0y8LLqS7KF/oKU
         HA+9WUduN2mc0q4BX3F993pZP+Nuf1Y0t6WWGVxG4pmCWv4cJ6PJm57trD68S10CFI1O
         yxhQ==
X-Gm-Message-State: APjAAAVPl1ffyCtt85xwUh3dR5cIgsaMKEfJ5jQXHxtLvXJgg/1vWAO7
        zMrYt2frLD8SPlcOnrb1V52v5dzmkjFIdQf3Tq3f0Q==
X-Google-Smtp-Source: APXvYqxnAQtlv87Vbj5eCqS+HQK1EEBmJ2XDT2ZXKZa9dCmzuxUdGF5CQgXp5ZZNQU76oJi1+5IMzIrpewvRCe2PhAc=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr849296wre.390.1578427950469;
 Tue, 07 Jan 2020 12:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20191231125908.GD6788@bombadil.infradead.org> <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area> <CAJCQCtTPtveHb8gJ7EPdck4WLsN6=RbS+kh0bGN_=-hrrWpuow@mail.gmail.com>
 <20200107115345.GG32178@dhcp22.suse.cz>
In-Reply-To: <20200107115345.GG32178@dhcp22.suse.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jan 2020 13:12:13 -0700
Message-ID: <CAJCQCtRqswrUC=kmdL0rKi6802qAxxyxOAQm7JHkAVQgK0GmWg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 4:53 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 07-01-20 01:23:38, Chris Murphy wrote:

> > More helpful
> > would be, what should distributions be doing better to avoid the
> > problem in the first place? User space oom daemons are now popular,
> > and there's talk about avoiding swap thrashing and oom by strict use
> > of cgroupsv2 and PSI. Some people say, oh yeah duh, just don't make a
> > swap device at all, what are you crazy? Then there's swap on ZRAM. And
> > alas zswap too. So what's actually recommended to help with this
> > problem?
>
> I believe this will be workload specific and it is always appreciated to
> report the behavior as mentioned above.

I'll do so in a separate email. But by what mechanism is workload
determined or categorized? And how is the system dynamically
reconfigured to better handle different workloads? These are general
purpose operating systems, of course a user has different workloads
from moment to moment.



--
Chris Murphy
