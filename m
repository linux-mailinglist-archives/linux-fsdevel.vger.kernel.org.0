Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2B2D784F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 15:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405942AbgLKO4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394582AbgLKO4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:56:12 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE1C0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 06:55:32 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id u7so4908001vsg.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qMuLxvVnDHp3uy4PWFqZ6dlsKThKey3XysejxwonVc=;
        b=jBCqJLhhqpWmNYM9gv6n/7oRElgxyilQXQMEYhBlLIagO2t+cpiqg8yQ5G06PdR46X
         hxAq7wNE1/5qUSy6J8ku1Vv41/qOq6C25IqBX9A1WbkaxkOLZZgjTGZjFztNWbThjo/K
         o06O3ghwW+WoXwiZ7MpUAG/PxcCOvabnzbun8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qMuLxvVnDHp3uy4PWFqZ6dlsKThKey3XysejxwonVc=;
        b=oZMuVj4vO1qppBbyCk1mUlHLDoMDDenJUO7slgsuumjq3UHKglLVp5ePoHA0qdjkwv
         dex81MlSt7mc4NgyRrmkUKSPTDo6mTlUAn79hkHYV6L+jsmohJq8jeGtVjRxaLTUyQ4+
         0gxH2Aj2XURCjrz2R5yi+FHCBZXNgfnn08khevLUAO+ln4gplvMKleAgfkMcX2Y9gaci
         xxWqABD4/QpOvtQgMb8sK0e5fBBj61AGAs2CJD5CQ9D5lgI/53JRh0apqqsQ9aiv08Q/
         MtZdGxGLoaqnk6NEfKB6eLKICT4JXZvsLM+cgoTJr0qh7R/OMABTDBkuuhA5XMrOXFrZ
         bFeQ==
X-Gm-Message-State: AOAM532ELRMvIGLMBFXZVcRnhrM+r/XE0pMzmtWNOjLtI+VGP+uJgYYU
        hdf/L1LmbGuou7Us41h785n1ohOsv9WjjjXX1MrJ3w==
X-Google-Smtp-Source: ABdhPJwMNShiSY2MP7gO+rAui8QkCyTNR0rAGwuad5uMGbc0nJuY8BS3bOuh1uYseNFLtouqxbqM41NpF+q/o6s7Eto=
X-Received: by 2002:a67:fa50:: with SMTP id j16mr13417920vsq.9.1607698531177;
 Fri, 11 Dec 2020 06:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-7-mszeredi@redhat.com>
 <CAOQ4uxju9wLCq5mqPLgo0anD+n7DLnmHzJ=SymFTRc0c_uVY4Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxju9wLCq5mqPLgo0anD+n7DLnmHzJ=SymFTRc0c_uVY4Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Dec 2020 15:55:20 +0100
Message-ID: <CAJfpegvzU5y09jxpzq=SSKc67bp-03hpqkQa-m4CZk-p2bEcVw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ovl: user xattr
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 6:37 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Optionally allow using "user.overlay." namespace instead of
> > "trusted.overlay."
>
> There are several occurrences of "trusted.overlay" string in code and
> Documentation, which is fine. But maybe only adjust the comment for
> testing xattr support:
>
>          * Check if upper/work fs supports trusted.overlay.* xattr


Updated documentation and comments.

Pushed new series to:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv-v3

Based on the feedback, I feel it's ready for v5.11, so merged this
into #overlayfs-next as well.

Thanks,
Miklos
