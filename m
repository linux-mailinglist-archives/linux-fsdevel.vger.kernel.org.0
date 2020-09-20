Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD9271683
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Sep 2020 20:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgITSAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgITSAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:00:43 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE57C061755;
        Sun, 20 Sep 2020 11:00:43 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id k13so2723360oor.2;
        Sun, 20 Sep 2020 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=M0zggyfFjCAqyNLqtifhyH6zYXreXaBzwic7FAekGto=;
        b=IvMBl3CQ7YZUWY4496ldrNZa4422339Kk8l6pMiyxYGJr7BiSUNqSIzb6cojqhhrKD
         1uevcbwmZYabsvmuu3B7nziQ8W+K+BlgpyFQt6qDtfvNtbLDhSfQxnWFhNGlkf320Clc
         8UkLof7282z+eRy4wztsDPugZgo1rG0mMYftnxtc7Cr04d0GXrZbAzm81ATONn6SuP+A
         ypErX1WR4c7OT2VMrNvdj+7pmWDboEtvC1U1gZKnUbBafs6j06FeUufXinPGG/WE/Tn8
         JAl84WkWSqvg9ekK+3ue7Wqdns7hbId3Ki4hH69pUDvasq4qc8KsZfQi/omW22hXUXxm
         WAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=M0zggyfFjCAqyNLqtifhyH6zYXreXaBzwic7FAekGto=;
        b=mwYIQTaH7hdfvtd5PlavMGTM9Cm9Wdob668gML0AtxW3tvSl7ckvanfKwYeKVvOOYW
         ioX2ogGLIaGNgSkVEEgPmAiUso1XDtkn05B4HO1FBhA9Gis7bLTFmWdD+p4XhASEOZ+I
         871nUm18Io5jyHNqVk0gKn3phk8/q8d85WMTaOqyxg9TSIzOokSTDauvq1hcqFGvEoIL
         GrZ6dSOx9JbWfz/y1Tq4x5AG7CWLG2QmfPXC9kx6vAowPQ+rz87BTWWNVPDQfyGRpir6
         jLgDQ1WbMFhTN0SJ6qp5OCsfWR3ee1p0pqcUhvK5f1R1LJ+c9ZVsHTbAgnCwCanw+bw4
         yT1A==
X-Gm-Message-State: AOAM530a79exvQIKRbCm9Rx/XjdZ/y0RAf9eyGwoQnZuUvSPeyu0EAX1
        ydnYtn9BrQY8NkLt7qAw18Q7EYKwz3qu0ZOzBbI=
X-Google-Smtp-Source: ABdhPJwCdWlu4oiXRdcA1xLGP9lA1AxoYUx+S/5QI6gFG2lM2CVvTeu7Vp0Uu9oNE7bk7NG8JU3CWiulnrCt6QDC9A8=
X-Received: by 2002:a4a:2c02:: with SMTP id o2mr30374645ooo.24.1600624841846;
 Sun, 20 Sep 2020 11:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <CA+icZUWVRordvPzJ=pYnQb1HiPFGxL6Acunkjfwx5YtgUw+wuA@mail.gmail.com>
 <CA+icZUUUkuV-sSEtb6F5Gk=yJ0efKUzEfE-_ko_b8BE3C7PTvQ@mail.gmail.com>
 <CA+icZUWoktdNKpdgBiojy=ofXhHP+y6Y4tPWm1Y3n4Yi_adjPQ@mail.gmail.com>
 <CAHk-=wi9x33YvO_=5VOXiNDg7yQU5D5MHReqUNzFrJ9azNx3hg@mail.gmail.com>
 <CA+icZUW=2aaM1X1dfhEbB74pLXekCULXCkU2s7J=qVHHXjxJdQ@mail.gmail.com> <CAHk-=wgfWh-b7AHT6TDF2ekq01zFFnzwDUkjNM02hXxN__rTRA@mail.gmail.com>
In-Reply-To: <CAHk-=wgfWh-b7AHT6TDF2ekq01zFFnzwDUkjNM02hXxN__rTRA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 20 Sep 2020 20:00:30 +0200
Message-ID: <CA+icZUWH7pqCXQPM_=OqeGxOyB-m6Ww1D6o2oQ+DYTv_ARaBwg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 20, 2020 at 7:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Sep 20, 2020 at 10:14 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > You had the glory of writing the patch :-).
>
> Your loss. I know it must hurt to not get the glory of authorship.
>

No money. No bitcoins. Yelping for credits.

- Sedat -
