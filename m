Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB1386C4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhEQVeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQVeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 17:34:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F4C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 14:33:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v6so9017240ljj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiJZ32oScv7m1zG+HAZWQ025LTPY+uZIZxxPrDNtO68=;
        b=CX90tBycAt/a9ap0XhQ5a2CbhLjIYmXx/RbWktAmmGtyKUdNqMXIDLXg9tktJ93U/1
         6e41uY2jKeGuZZYpoIZe5zo87ZhLQu9fL9tImW+3DGJmNzxHnwhQj+EXTY7UQ/5JFfG7
         1VWuVB9RrkhYPVoJyq+rF8H0HM19LRTTPwqkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiJZ32oScv7m1zG+HAZWQ025LTPY+uZIZxxPrDNtO68=;
        b=PLgNcPpXRF112xMGaaefUPR4VaUSxhWvvN+zMbnXZhpS7EoxXrp/moIfy1X2QAGQyK
         22Jxkl72jBBj5mACf5Hi22EavaiT7/nn0edug/umKi7wFX0LPFF04ye4NecREoav/rC1
         QRbmL+BXZ5TEKbfgRaUlxHn6fVZqY1Qbuu/lwtORQgkIB9PFK9hRcsWFfQnzevKssCMQ
         lXJRCTX5HZdTx3MzKH5Ja0hcmC5P3/kVamLCG5TNd8++41EEekZnVQ7BSl/w6iPqssEr
         7xGpND+QZTUTwL7C5M465Ub1zZgLQbJS/z+D6ZqMOyRAb530qTC0Jzi8bij/IUI2HvBI
         6uWQ==
X-Gm-Message-State: AOAM5319M4OPRO5vijDXvJvTW/1mAeJfaysyZyeektmGLkiXZAwAbwXq
        zFzuSgbj3xWk97IZPZ5SV5YlRs5aQAFfoj09
X-Google-Smtp-Source: ABdhPJxiLB+LOr2ueFsGgpVDPit4jDx1Ncytj/uz6LKCmBhu1dxWclIYfgnh+EWEqCRH8xBd7IInbA==
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr1110208ljp.209.1621287184954;
        Mon, 17 May 2021 14:33:04 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id f10sm3050002lja.83.2021.05.17.14.33.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 14:33:03 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e11so8986645ljn.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 14:33:03 -0700 (PDT)
X-Received: by 2002:a2e:968e:: with SMTP id q14mr1065866lji.507.1621287183341;
 Mon, 17 May 2021 14:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621276134.git.osandov@fb.com>
In-Reply-To: <cover.1621276134.git.osandov@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 May 2021 14:32:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
Message-ID: <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 11:35 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> patch 9 adds Btrfs encoded write support.

I don't love the RWF_ENCODED flag, but if that's the way people think
this should be done, as a model this looks reasonable to me.

I'm not sure what the deal with the encryption metadata is. I realize
there is currently only one encryption type ("none") in this series,
but it's not clear how any other encryption type would actually ever
be described. It's not like you can pass in the key (well, I guess
passing in the key would be fine, but passing it back out certainly
would not be).  A key ID from a keyring?

So there's presumably some future plan for it, but it would be good to
verify that that plan makes sense..

                            Linus
