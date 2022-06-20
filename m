Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6665515A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiFTKUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbiFTKTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:19:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B014008
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 03:19:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so14446066edi.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U65sD1RO6KC9zIHsaAh+EyaFvAgiKc478ZRVl8k3cjY=;
        b=Q4EL2dBDKjIQpmszEmwyr9zsU80bYo7tPUUVyg7LFHcX8CI6Ol5fdwnL51WfByAyP+
         gvH9i0ArcbOcP8Qow1FE8Ribb6qtMBFSduCpjQT8ZPItgMo6NEpG/BBdC0CMSz+ymPwq
         1wMpqcXfRXXoPsZtjOXXaOMIg6+YuPx97RqhzdzNMxjBE33zRkJGL3Fvs6PkFGtZNeq3
         SfnkL8UzQUaK1c9t4gEySW50dto5z6WJXsD5ygBg+GhobiuTOl1uUv8gvuJsADH2k9MC
         vQuberct3P4NV3+24n+FnRdNaDY6xiCoFe9FIWbwFXHmL8P1exV9Bz+RPSALOpHLZ97K
         +y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U65sD1RO6KC9zIHsaAh+EyaFvAgiKc478ZRVl8k3cjY=;
        b=O0WOxAH2aQ6ytBOrPpZMqD3Tj7lwBMmW5iIT1OiE3j/4RiGxf3zRiazhR/dmiEsXYf
         WjvqyA3mytxkGBDm+4OQvzmoG4Lze9rTwPWAAw9X82ohP7TunhS/v0WjKOwcIXRZYHFH
         QxKVOEKBMB2ZlcwCUNZD2LDuzHsjT20yZOM/EnDN0g49sciXB29ND36DV4+cbq2KIez5
         yORtpjkbTzDERlRWLt/cri+tCJ2lV/1pZLS09FiAg6eoOn4bDJbPSSl7PrVoUWAzV8ny
         3ReWYnqOco13s0J3cgVsALhNLuUXVhJKgERg+851KPkoET+qT9rFFXTCkBMQOwEie6Bt
         qRlA==
X-Gm-Message-State: AJIora81iyIvHXmQxWCwK9n9hWdB7nz5korgMKHJUIKIfwpFEFeD93r9
        IIJ/WSxFyIBL/yGjOR8a6ZHkJA/iCBQ08nl0Nb02iA==
X-Google-Smtp-Source: AGRyM1v3loEzZn5lCQNqmOyLVmDEpgbjQ28MHr2qrJ0Tw5WoguppyU5q5kmkj9+DYNYOI2kZiD6bH1OO306e/es4Hr8=
X-Received: by 2002:a05:6402:25c2:b0:431:932e:eb6f with SMTP id
 x2-20020a05640225c200b00431932eeb6fmr13332620edb.296.1655720370201; Mon, 20
 Jun 2022 03:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com>
 <165534094600.26404.4349155093299535793@noble.neil.brown.name>
 <CAPt2mGOw_PS-5KY-9WFzGOT=ax6PFhVYSTQG-dpXzV5MeGieYg@mail.gmail.com>
 <165544498126.26404.7712330810213588882@noble.neil.brown.name> <CAPt2mGNJYJ=pTmRRseJdeyvTDw9am6uNUaiZysDvU2bNcNJLQw@mail.gmail.com>
In-Reply-To: <CAPt2mGNJYJ=pTmRRseJdeyvTDw9am6uNUaiZysDvU2bNcNJLQw@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 20 Jun 2022 11:18:54 +0100
Message-ID: <CAPt2mGOmcmJsDBZ1BN0G==u=OSMd91bicFk+-05g44CGbi1PLQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
To:     NeilBrown <neilb@suse.de>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
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

On Fri, 17 Jun 2022 at 16:27, Daire Byrne <daire@dneg.com> wrote:
> This patch does the job for me - no more stack traces and things have
> been stable all day. I'm going to run some production loads over the
> weekend and then I'll do some more artificial scale testing next week.
>
> Thanks again for this work! Improving the parallelism anywhere we can
> for single clients and then nfsd is great for reexport servers
> (especially once you add some "cloud" latency).
>
> Cheers,
>
> Daire

The patch ran without incident with our production re-export workloads
over the weekend (which also helps audit v5.19-rc2).

I ran a couple more synthetic tests and got up to 100 clients of a
re-export server and ~113 creates/s aggregate to a single directory
with 200ms latency to the originating server. This compares well with
the ~121 create/s when using 100 threads on a single patched client
direct to the remote NFS server.

In other words, the NFSD portion of this patch is delivering almost
the same performance as the underlying VFS NFS client performance when
re-exporting that path to hundreds of clients.

Again, without this patch we can only sustain just under 3 create/s in
both cases (VFS/NFSD) with 200ms latency.

This is a great improvement for our batch workloads with varying
amounts of latency >10ms (cloud networking).

Tested-by: Daire Byrne <daire@dneg.com>

Daire
