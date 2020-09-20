Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A60271661
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Sep 2020 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgITRkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgITRkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 13:40:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2149C061755
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 10:40:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so9213271ljk.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uosIaBfV8EILtqdKcJPwj9HQb4A+VUO2Ewb4BaoQ+yc=;
        b=GfS5aOwn7LnsYjlq8ck/DWbIdmlsRpcSpOmdiIHC+5vGmwNGjEb7dgIf0616LI+MFq
         IzQ7ctWVYZSvUI2Oag3HJz7ppBoiq4raHZQ/7jdS5lOz7/UxHgYeuF+yk2+Daig3mZHU
         uWr8ivc3CGxTUYaPyKfmqP7L+BimX1U7H11g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uosIaBfV8EILtqdKcJPwj9HQb4A+VUO2Ewb4BaoQ+yc=;
        b=sBiM2zEcnMu1gnnTq7ivAzsH4NPKW8rzHaDoQ71EOt6jdXDQBUlYaPCVXxwPVEj2XU
         ESRm/+YyknAKGMeaa9uitxCOTmeBjdyC1J1gU0b7kUq9lzOEbC7Q/e9RCp2Y/TwTVb+8
         dfaM1I9V8YOTR587nRYuZ8bTjsRnlmHHY5hXEVzO3MhuqjHBkSc3SOpAzVWDN+MBKXpl
         Xw7THY0ZsG4yez+BDf5OvZiGMnozoHKMaqS6AWsJrTFgdnrHs9WeTX9WuDFqQEZ2fvLv
         Um1p+5VF2ryLUCWGbO/y1V43TidryPFUmOQw+bz+Y3avoomcAhk+GlAOA5URuSTGTaf/
         eFIw==
X-Gm-Message-State: AOAM532Gmm4WobbbrjNKR2SleJ+e+ya41Qke+Iqoclf5Ry1tzVh0xqWS
        0puHboIWpeECMXXdrchHpt6iqd5eV2U0wQ==
X-Google-Smtp-Source: ABdhPJzeeS3saRt4cDORpVhG1ZR9UJNhd7t7yingxDYeTN/9+A4yRCqCaYWCwdTBf5npDIGtpufSjw==
X-Received: by 2002:a2e:8993:: with SMTP id c19mr16019234lji.264.1600623643669;
        Sun, 20 Sep 2020 10:40:43 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id b14sm1904485lfo.257.2020.09.20.10.40.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 10:40:42 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z19so11521783lfr.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 10:40:42 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr12576982lfr.352.1600623642270;
 Sun, 20 Sep 2020 10:40:42 -0700 (PDT)
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
 <CAHk-=wi9x33YvO_=5VOXiNDg7yQU5D5MHReqUNzFrJ9azNx3hg@mail.gmail.com> <CA+icZUW=2aaM1X1dfhEbB74pLXekCULXCkU2s7J=qVHHXjxJdQ@mail.gmail.com>
In-Reply-To: <CA+icZUW=2aaM1X1dfhEbB74pLXekCULXCkU2s7J=qVHHXjxJdQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 10:40:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfWh-b7AHT6TDF2ekq01zFFnzwDUkjNM02hXxN__rTRA@mail.gmail.com>
Message-ID: <CAHk-=wgfWh-b7AHT6TDF2ekq01zFFnzwDUkjNM02hXxN__rTRA@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Sun, Sep 20, 2020 at 10:14 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> You had the glory of writing the patch :-).

Your loss. I know it must hurt to not get the glory of authorship.

             Linus
