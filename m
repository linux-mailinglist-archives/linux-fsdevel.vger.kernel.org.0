Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8666271637
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Sep 2020 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgITROb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITROa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 13:14:30 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBEFC061755;
        Sun, 20 Sep 2020 10:14:30 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 95so2984354ota.13;
        Sun, 20 Sep 2020 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CvggMFTs+vEMiZp1aSJhey+Z0FQFMf9GP9Mj4SPXr1s=;
        b=YE4LW7cpVdCUnM3X1iKZjTJA+vOjEcSB/TjLpILOqIP9onpcvGWukJ4LA3M0IlxIZm
         w4egKax85tTabDq5J1hfPWlRuQr1vqOC8vdYcAPXPhZoafrvF1ZctQFUe1YcrNUwrY5G
         OAlK5K/UtdpYIgsUvtMeOqlktTSBWjTzOegLvR47WP8ZAwOc+YvLeJ4K4KpblhMFUoJH
         VHsxlow4RnZi63FiX4zKcMTcmJK8Z8mZk2ArnQpPJag2KK1Lin4xYWV4R3pN5JDvVaSG
         xE8wWSqf9vGALgaz+nfghz/gj8I2zLeBJtBvAEHHstP9oIJpxcC4kq3IjvpBnr5/uTcz
         zOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CvggMFTs+vEMiZp1aSJhey+Z0FQFMf9GP9Mj4SPXr1s=;
        b=tohyTHSvQHLSRsJSSm4oW/TfBouSO2HsdSOnsRJ8+CCqGLKUOA9B2PvkGCyHdnbVhV
         HPDfepgtDRDyDFZ3GmCqpY+2nakCO1I6Vm23n8ZKPzILpU4XeB+FKWJfndqPDoceln2u
         fDfz/ckBRGP4cpAWiHZeiJ7stpVaDYkohDIvhxpb7JVQie7Lb4LuPOSy83qM3Lx5gzda
         OMyKkj+BKcpb0Fn0Ev1oDnwffWXK2pO6WRlsIEHrkucvKyKfgZrNwdHlRpN/xcSvf/AA
         R8mk3p1hb7EvXCLyRGnd8qIPwFRCIeSGJiaYzEMuYnf9LhUIoI5hAXpPM/q5s9Avkp5w
         AU7Q==
X-Gm-Message-State: AOAM533O61cKktdIpuX5u6wk4UHiVEIP5VdwPi9nqBZkEwSDO0Mvba8V
        y8hrBhHRMPmbiipI6abxlQDwvIKfgitxEXST9Zc=
X-Google-Smtp-Source: ABdhPJxGlMMNoAOMtsyXjzvMLS7FKZ9Jo95Ty/3sTkwTGDBVWFKP3yxSf+Y0VJ41rRf3alIyfQrApz5yk9NKi1e6ilc=
X-Received: by 2002:a05:6830:13da:: with SMTP id e26mr30715689otq.28.1600622069312;
 Sun, 20 Sep 2020 10:14:29 -0700 (PDT)
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
 <CA+icZUWoktdNKpdgBiojy=ofXhHP+y6Y4tPWm1Y3n4Yi_adjPQ@mail.gmail.com> <CAHk-=wi9x33YvO_=5VOXiNDg7yQU5D5MHReqUNzFrJ9azNx3hg@mail.gmail.com>
In-Reply-To: <CAHk-=wi9x33YvO_=5VOXiNDg7yQU5D5MHReqUNzFrJ9azNx3hg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 20 Sep 2020 19:14:17 +0200
Message-ID: <CA+icZUW=2aaM1X1dfhEbB74pLXekCULXCkU2s7J=qVHHXjxJdQ@mail.gmail.com>
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

On Sun, Sep 20, 2020 at 7:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 18, 2020 at 1:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > do you want me to send a patch for the above typos or do you want to
> > do that yourself?
>
> I was about to do it myself, and then I noticed this email of yours
> and I went "heck yeah, let Sedat send me a patch and get all the glory
> for it".
>

A few minutes ago I logged into my machine and read this.

You had the glory of writing the patch :-).

Of course, I can send a patch if you desire.

- Sedat -
