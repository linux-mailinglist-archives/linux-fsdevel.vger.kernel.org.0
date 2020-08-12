Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED1242FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHLTx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgHLTx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:53:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF8C061384
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 12:53:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so3618378ejb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmEw2lBQdSo1OmXLViAxouuUh1Sga07TNO5tCBoeOis=;
        b=FSWju80bwOEltiHCw7tX99gPQ4f23rdiK+9U9OE6cbeApFclbDUtAJb8pXkcbF1jw+
         HFVehzWGJbU5PGrV17qiayxw4nQ7+mjz21bnbn/NCLlp+l6uGWSjEXUrTlRlcv99rMA2
         Mdx/PMdKNsGqZFZyedF1Z7kk2Fp7oIFZYcB5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmEw2lBQdSo1OmXLViAxouuUh1Sga07TNO5tCBoeOis=;
        b=DNzKYEIzhsYokdZRB22W8IM2j+ZIUfbYJp0ttDcY2QmPxlmxdIqofm7J7OjUQtxElk
         NfK4Y5hI8PcY4QH3yA7DJ4b1olHzkGnT/rp1kZeCkCXlHLZ9xRBeZOkA8sHU/Pnjg6im
         /RX1gzAyuseAWwJy5A2iLQl0keDwnUzwyB7v9iigveJ2letYm65J3GriNHZ8cOFNPzuU
         JY6tYm6vk5Ni9WOeVqB2Lhy5djk7KQVQLVv/0lEv6OQ3c0lijHKC01DA8/BBFI0UkIfZ
         +TP0NFxe/Rt7/pGm1sngvdh+R6ihBlUX0XPGZ8rhdQe9/X0H6DSa5JPt6EP0pnMy4EvY
         Tx7Q==
X-Gm-Message-State: AOAM532rs+f4hTRisfWMsmB4BynfC5Tst5Ts4hys4caoLjaJrEQHWrAC
        s+Hm0fvoeU5yUii1bOGGKN+iCxFWpfA=
X-Google-Smtp-Source: ABdhPJxXcExnjRnefiePvmGQJEAtJWNnEuwskq4BR0sBPA/ZPRfrETbolMizjDwdcJNvQzlM8TXZ+w==
X-Received: by 2002:a17:906:2c4a:: with SMTP id f10mr1458027ejh.352.1597262005975;
        Wed, 12 Aug 2020 12:53:25 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id q2sm2201526edb.82.2020.08.12.12.53.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:53:24 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id qc22so3618300ejb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 12:53:24 -0700 (PDT)
X-Received: by 2002:a17:906:fa19:: with SMTP id lo25mr1471647ejb.456.1597262004337;
 Wed, 12 Aug 2020 12:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200811222803.3224434-1-zwisler@google.com> <20200812183557.GB17456@casper.infradead.org>
In-Reply-To: <20200812183557.GB17456@casper.infradead.org>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Wed, 12 Aug 2020 13:53:12 -0600
X-Gmail-Original-Message-ID: <CAGRrVHwCYRXixfft1FCnwU-1UzuoUF3iVayRjD8G_QXX2+nOcQ@mail.gmail.com>
Message-ID: <CAGRrVHwCYRXixfft1FCnwU-1UzuoUF3iVayRjD8G_QXX2+nOcQ@mail.gmail.com>
Subject: Re: [PATCH v7] Add a "nosymfollow" mount option.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Aug 11, 2020 at 04:28:03PM -0600, Ross Zwisler wrote:
> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> > index 96a0240f23fed..dd8306ea336c1 100644
> > --- a/include/uapi/linux/mount.h
> > +++ b/include/uapi/linux/mount.h
> > @@ -16,6 +16,7 @@
> >  #define MS_REMOUNT   32      /* Alter flags of a mounted FS */
> >  #define MS_MANDLOCK  64      /* Allow mandatory locks on an FS */
> >  #define MS_DIRSYNC   128     /* Directory modifications are synchronous */
> > +#define MS_NOSYMFOLLOW       256     /* Do not follow symlinks */
> >  #define MS_NOATIME   1024    /* Do not update access times. */
> >  #define MS_NODIRATIME        2048    /* Do not update directory access times */
> >  #define MS_BIND              4096
>
> Does this need to be added to MS_RMT_MASK too?

I don't think so, because IIUC that is only for "superblock flags",
i.e. flags which are part of the sb_flags definition in
do_mount()/path_mount()?

https://github.com/torvalds/linux/blob/master/fs/namespace.c#L3172

With the current code I'm able to remount and flip nosymfollow both
directions without issue.  Similarly, MS_NOEXEC can be turned on and
off at will, and it's not part of MS_RMT_MASK nor sb_flags.

Interestingly, though, if you change MS_RMT_MASK to be 0, I would
expect us to be unable to twiddle all the flags which are currently
part of it, but that isn't the case.   I was still able to change
between RO/RW, and turn on lazytime.

So, I think this flag is working as expected, but that there is
probably a bug in there somewhere WRT the handling of MS_RMT_MASK.
