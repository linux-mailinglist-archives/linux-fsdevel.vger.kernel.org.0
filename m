Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58D843DDF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhJ1Jr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhJ1Jr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:47:58 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB9C061570
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 02:45:31 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h4so10382223uaw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wurG6bZCTWtDemH1Pac8iQjbnRro1K9EHAYSZqtL0qQ=;
        b=imXdOUoGJMp6ac0Zc8O/oCD6C5xDcqWj8OmTB+4FM8S1c8LpLflEaHWk3FC+2CPz13
         BAKE0ALssRHLHnY7KhcXYnSqyNUBf5ONx0lwzOWjEIJre3tvr+hRiaeWU3sWviYWgiqK
         Q2/2knAAtFsa+2GnJJa1YD4TMUylU3JAoUcjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wurG6bZCTWtDemH1Pac8iQjbnRro1K9EHAYSZqtL0qQ=;
        b=4KSYSmtfJBwrXsf8ME8TFGbTbDa8ahFaiGM3VrW89D4AoQdTvlJivKBxLofVSz7361
         rLikv5bao/Y++11vGQgEpsD0i3ObCJAoYkgf5gErQRYffGrBb4upp9FE0/bMVMeedU5p
         VABw0n7tU6Dl0fBafle6K0xn3kCDrkAnt0J16uKCIc7+rHyp3g8HtO83teYRFQykPCEU
         g11/HWZmpJFcexyWiY7Z3kArYW6f+pM8SB/JaKay39VbEr21guh3IhK/gQov01U7ApT6
         y4vT5slbvuLAm5TUIxANzt3+0khsptLjS6ijoToy3eZ9oKYiIOv9p35QPMoutZIPhf/y
         DPfw==
X-Gm-Message-State: AOAM531d3Tf4gqcMTk5cI+FCnG5MmnsX8dfr30rIquVd9ZQhrsMWfhdv
        Kia9PgJ41rPFOwu7cE0yWyGijStmH7Zm9dUZCSyWFA==
X-Google-Smtp-Source: ABdhPJxAuUIdzGMLQjP05GpmooZX64lzvO3cOVscFUUVgZp6WJZO+pHB/FH4mu2b3yy+GQ+E6gTsB2IxY4obStvj9tI=
X-Received: by 2002:a05:6102:3e84:: with SMTP id m4mr2677770vsv.51.1635414330372;
 Thu, 28 Oct 2021 02:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmZXrsGg2xsP1CK+cbuEMumtrqdvD-NKnWzhNcvn71RV3c1yw@mail.gmail.com>
 <CAJfpeguXW=Xz-sRUjwOhwinRKpEo8tyxfe_ofhhRPsZreBoQSw@mail.gmail.com> <CAAmZXrtiJcmLzf6eb90RKdCs3Q=mFNCqAD86nZQJmVwr6YwEmA@mail.gmail.com>
In-Reply-To: <CAAmZXrtiJcmLzf6eb90RKdCs3Q=mFNCqAD86nZQJmVwr6YwEmA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Oct 2021 11:45:19 +0200
Message-ID: <CAJfpegvtn-bQZV8-dU+YJYZ7f=3p0gF1966amKGL4k=GHZUcuw@mail.gmail.com>
Subject: Re: fuse: kernel panic while using splice (lru corruption)
To:     Frank Dinoff <fdinoff@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Oct 2021 at 23:27, Frank Dinoff <fdinoff@google.com> wrote:

> Ping, any thoughts on how to fix this?

Looking into it now.

Thanks,
Miklos
