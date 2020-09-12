Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18B267889
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILH2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 03:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILH2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:28:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91EC061573;
        Sat, 12 Sep 2020 00:28:40 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z13so13441857iom.8;
        Sat, 12 Sep 2020 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWM/BlJ5lkpI9BMfKBa6hZGyhtApyVDWJyrk/aitlds=;
        b=oWJRaW0xjb6uXGeEDfmpsb+0YnplVIfxtrfkxVnsh1jajHUJDtLzvjXWXe1vjUQEXJ
         5QzV0iXVQf79LmNZCUatukj2oK4UAcDA+Pdknx/uXEagofUR5kMyzys2cR9GJ12k9Jo4
         EDVK+trpHWWGo2FGFmP+bcfy6titTSvu6Qf+fAZrfWBSnPiXm5lg/s4f1cz/aViYhbdf
         X/bJQSpAUEQdH9Yf/RG/LEBweKvDomEgh7itYvkV80KCfDwkzBe/MlOdITX8JuR8+kBh
         XSKDh7dg9kPC4b3//ffsZuWh9AsmEZ6gQa+kibg9IVybfUS7dgRIBdO8s+vdPO8AHAdG
         iDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWM/BlJ5lkpI9BMfKBa6hZGyhtApyVDWJyrk/aitlds=;
        b=G/POzbUYnZ0U5Cy58zfNr9U/VK9aRu/jTMU5wouL4cg4bMZ1VGKYXczm3buAA/ltDk
         +KH33Mg/jwtzkI6+D6fy1AmQKTpNL50dTUc+ZuLHn6fwu0F9lQ7Uk0ZOX3tf8XXtjmeF
         rYDJb5PiotF7cLKXlcnPsWUQKZgU4Zde89e0zU6TXWUmPHeI2WBObySUNgbxtWuvTETT
         gRW52/TCFLn4k8g7QVLuZHkPR4W8qEhPQCzZqoveKXJfc4upFvefHtx9MfMQnFWenhnq
         ZF/eKBmzm1XYKgxTNhD5naOatL8mIQatBKM4CiGk2FHxjnjehKGCxjf3/2oSdyZ5fE6Y
         sYbw==
X-Gm-Message-State: AOAM533AeyESD4Z2NGcXuBQ6f7eLVmfENl92HkHPbbDs7Vn8saxwR1Ze
        Jb6KEPersoLteVf5XV53kDWjj+Ymd6WJFeF2D7ylQiWIu9M=
X-Google-Smtp-Source: ABdhPJzcIEA2izrpfz1Zt2L3RKjgIePE+Kq72U1Uk5Jzs9aRYfclCJ5PHCohgUbJD5UvJVBm3io0Omz5CHr+09Ub0Pc=
X-Received: by 2002:a02:ca12:: with SMTP id i18mr5236345jak.30.1599895720089;
 Sat, 12 Sep 2020 00:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com> <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com> <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com> <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com> <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com> <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
In-Reply-To: <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Sep 2020 10:28:29 +0300
Message-ID: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 1:40 AM Michael Larabel
<Michael@michaellarabel.com> wrote:
>
> On 9/11/20 5:07 PM, Linus Torvalds wrote:
> > On Fri, Sep 11, 2020 at 9:19 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> Ok, it's probably simply that fairness is really bad for performance
> >> here in general, and that special case is just that - a special case,
> >> not the main issue.
> > Ahh. It turns out that I should have looked more at the fault path
> > after all. It was higher up in the profile, but I ignored it because I
> > found that lock-unlock-lock pattern lower down.
> >
> > The main contention point is actually filemap_fault(). Your apache
> > test accesses the 'test.html' file that is mmap'ed into memory, and
> > all the threads hammer on that one single file concurrently and that
> > seems to be the main page lock contention.
> >
> > Which is really sad - the page lock there isn't really all that
> > interesting, and the normal "read()" path doesn't even take it. But
> > faulting the page in does so because the page will have a long-term
> > existence in the page tables, and so there's a worry about racing with
> > truncate.
> >
> > Interesting, but also very annoying.
> >
> > Anyway, I don't have a solution for it, but thought I'd let you know
> > that I'm still looking at this.
> >
> >                  Linus
>
> I've been running your EXT4 patch on more systems and with some
> additional workloads today. While not the original problem, the patch
> does seem to help a fair amount for the MariaDB database sever. This
> wasn't one of the workloads regressing on 5.9 but at least with the
> systems tried so far the patch does make a meaningful improvement to the
> performance. I haven't run into any apparent issues with that patch so
> continuing to try it out on more systems and other database/server
> workloads.
>

Michael,

Can you please add a reference to the original problem report and
to the offending commit? This conversation appeared on the list without
this information.

Are filesystems other than ext4 also affected by this performance
regression?

Thanks,
Amir.
