Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5B75F907
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGXN4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjGXN4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:56:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EACE1FCF
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 06:55:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so6520317e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690206933; x=1690811733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuBTJcHgRw5Dz5uIr7zOsQg7JkLL64F6mhAMmK/Urg=;
        b=gvHlyPxpUKDXveeruAvPPnL2uwW7r0Lm6j/W1meQaI6mI9bctOF+FA+qn05a9Sgtx6
         YLUJNCG7B6Bg6YnKGdq4BjFBF218V2BzeuKMNMBnLqM1NwslZsz/em1+PzKJfEko3N5D
         Ki+Xww/RrchuUj/d3YykuEcicj0QjNcfotE4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206933; x=1690811733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLuBTJcHgRw5Dz5uIr7zOsQg7JkLL64F6mhAMmK/Urg=;
        b=B8kwjRtPzY+7t4E9eBA86gmBdrcYLWY3+N3Prt+NXjwexqFpGi9glRzucWypHLsfK1
         nEAqeG7Gv2zS8ZQFFOSaxDCsZZbNIcSOJku6ptVsAO8O7bhJQmtWkPFyweTPIsiYbAQe
         xDijuksDU+zykBl0dqwIxp73xcCb7w5o54PaOOj3kvkXOebv+9xMivRK50XSzz+WaI1A
         iQ2Uvr8FoigynZbzJAn5BtQvNQe87sQ39e+HaDJCVws5+PnL0mEv7OmsHu7Nbz1WWgdX
         EuMf+7NtJXdpUYUOV4AtGbvRJS7GyQ20GvX19xU/OM8tLxiREsMQSH8Uaa6y78gNNWH+
         OKeg==
X-Gm-Message-State: ABy/qLbrZTgzPNNJPQXHH1MCds2WL2aA9f/xaXDeItgQxVrlay7iDpzV
        59PEllwoePddfU3k7njNhyZMMdQKiCcTcpToXUsETA==
X-Google-Smtp-Source: APBJJlFFevIadl9sawEPFI9I5OR2dPQnGvYtXsyb59paj5UKaXjSUkFCIk1mA0a3cy0sEARUqP5jmS4qlpHJ1cAJBSw=
X-Received: by 2002:a05:6512:234c:b0:4fa:5255:4fa3 with SMTP id
 p12-20020a056512234c00b004fa52554fa3mr6246134lfu.5.1690206933287; Mon, 24 Jul
 2023 06:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <63041.1690191864@warthog.procyon.org.uk>
In-Reply-To: <63041.1690191864@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Jul 2023 15:55:21 +0200
Message-ID: <CAJfpegstr2CwC2ZL4-y_bAjS3hqF_vta5e4XQneJYmxz9rhVpA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        netdev@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 11:44, David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > > So what's the API that provides the semantics of _copying_?
> >
> > It's called "read()" and "write()".
>
> What about copy_file_range()?  That seems to fall back to splicing if not
> directly implemented by the filesystem.  It looks like the manpage for that
> needs updating too - or should that actually copy?

Both source and destination of copy_file_range() are regular files and
do_splice_direct() is basically equivalent to write(dest, mmap of
source), no refd buffers remain beyond the end of the syscall.  What
is it that should be updated in the manpage?

Thanks,
Miklos
