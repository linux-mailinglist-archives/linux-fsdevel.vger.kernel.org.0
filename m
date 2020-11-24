Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E382C34A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgKXXZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 18:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgKXXZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:25:19 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98764C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 15:25:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so529679lfh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZpDzZfRGW5JQ+z/SLaL70l0Y+Id271dyPmoJFXV3Yg=;
        b=eMtd8miSV5Q4HzVm9lx1snZ252JU2LUG08CXEG9MZekZ6i7RMmkka/lMY+IPVuJ23L
         PqhYtLLZg6ffJmiv3yaDYTznuv3dIQ4YBw1pOJz9r2vKjiack1bfddd/lir5cfbryUH+
         /Jt2/UYsF/gTRVYdgZmuNAbHMgKvTDtyzGHaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZpDzZfRGW5JQ+z/SLaL70l0Y+Id271dyPmoJFXV3Yg=;
        b=e65LfFN3a6ybFcz30rRVVocjUK+S9igsQiqvhDt1NBRYyxlLMxVOFoW7srh/fdQsyg
         uEYMHD1NHNxxWMSIcVntcHjghERw/ZS3iF3MesHfOgu6qGadKtcwcNlPq0hVAuLjLtKp
         rsyUP3QgNTr0UyP7w0MbW9h2JgvSwzBJY53m+PN/OffhxArDNesEKn3KkC9B3LOc7Crc
         HWFIM2xffOnI7vDsF1QK0qAXcKkLNCPz67pz4u2sE+Pm34loqmDis9SeVU3JmJ1a/gL2
         2+v7rDYC7YLYj6Z5Z/D/AoSITQc5SwBR2b7dWVr/w6ZraKPa2mUbbqySOEaZ55J9QtD9
         wNmQ==
X-Gm-Message-State: AOAM5319I1rofLxW3vdxcAM8OFsDsJsYVGjmnr0hhOHUQJJ3Z0jyyIev
        hE5q1CTn/UXH9fTjCU2ld3Q05A6nvH443A==
X-Google-Smtp-Source: ABdhPJy2nL6lD6s6G9VeJWmJO8rVo/sOuRAK/1/AQaeU5MI/iRTIhxeMnG3AjUwmdebKUJDGEsrbig==
X-Received: by 2002:ac2:483c:: with SMTP id 28mr201999lft.242.1606260316728;
        Tue, 24 Nov 2020 15:25:16 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m5sm46680lfc.4.2020.11.24.15.25.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 15:25:15 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id f18so283030ljg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 15:25:13 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr172684lfy.352.1606260312243;
 Tue, 24 Nov 2020 15:25:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
 <20201124201552.GE4327@casper.infradead.org> <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
 <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 15:24:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
Message-ID: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 1:47 PM Hugh Dickins <hughd@google.com> wrote:
>
> I think the unreferenced struct page asks for trouble.

I do agree.

I've applied your second patch (the smaller one that just takes a ref
around the critical section). If somebody comes up with some great
alternative, we can always revisit this.

            Linus
