Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4DF39EA36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFGXiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 19:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFGXiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:38:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C292C061787
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jun 2021 16:36:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r198so25748240lff.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bj+3pmdBLjat38YzGIwe/LbSm4GNIavhFcUTV5mhCVk=;
        b=Sbo5NkDjodBKpzQgpBDWnnVyo+sOZY4L/bffARKmA/haCwh+jHPisbJEH8wkyItgYD
         q20QmGC4mQZeg0O7HcHaRDzioKDHpaLLl/EA2ocn26ly6NkvA5Xtd+KpbnCRwrd+1ydU
         E0OLAkEREa+xQUjv3yGnFZMGWR69WZVuXaWBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bj+3pmdBLjat38YzGIwe/LbSm4GNIavhFcUTV5mhCVk=;
        b=Tf2g8FvDzwEZX0jRYP/05/ln7DkHIIi5ppjl3WSOr75s4FzFk50xi/ipslgTOe6aS5
         0eTy/6q7zHbPNmK9PazrcfgHSd6a0bdvL1ewwu3eH6Nj5AnKIAtfTLeM9WiLNUbxChax
         dt4GLu8aI+giyl0MwUDAUlD0qlyNb+JxxU6DOvEX3KMGK8eXQZZYQ2C9pZ532JDjvZ2f
         SzL4WkZT0dhKwe3IgvQHlvxVOJoKfmiIrTCPHVP9b0AEd2O4mGWV6VpL7gL9Tk1A7SFm
         1Qrjiw9WxlS+XUBlX39CcH/fQZ7ORvabXzcZV6/vPVsNbWHBrldLzsiKdSmvW95nlQ38
         I/UA==
X-Gm-Message-State: AOAM530Q2po4KhohChydU1Bpep+Kn6u23LAHwPlY8h1RXJx4fGLDX7HT
        zfCrE3jc4Y5UqMLJede1Rk5K2GbXrB7P2HbEqCg=
X-Google-Smtp-Source: ABdhPJxrm8B/2SfunTIkoWcf1iUB252pBhaiScq40RPL99bLPDf/1tRzJsXqUmre3yMAZxc65h0xBA==
X-Received: by 2002:a19:58f:: with SMTP id 137mr13090682lff.188.1623108963668;
        Mon, 07 Jun 2021 16:36:03 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w21sm2025933ljo.41.2021.06.07.16.36.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 16:36:02 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id v22so27741391lfa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 16:36:02 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr13531788lfl.253.1623108962242;
 Mon, 07 Jun 2021 16:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk> <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org> <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
 <YL5CTiR94f5DYPFK@infradead.org> <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk> <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jun 2021 16:35:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
Message-ID: <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 7, 2021 at 3:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (b) on all the common non-SET_FS architectures, kernel threads using
> iov_iter_init() wouldn't work anyway, because on those architectures
> it would always fill the thing in with an iov, not a kvec.

Thinking more about this thing, I think it means that what we *should*
do is simply just

  void iov_iter_init(struct iov_iter *i, unsigned int direction,
                        const struct iovec *iov, unsigned long nr_segs,
                        size_t count)
  {
        WARN_ON_ONCE(direction & ~(READ | WRITE));
        iWARN_ON_ONCE(uaccess_kernel());
        *i = (struct iov_iter) {
                .iter_type = ITER_IOVEC,
                .data_source = direction,
                .iov = iov,
                .nr_segs = nr_segs,
                .iov_offset = 0,
                .count = count
        };
  }

because filling it with a kvec is simply wrong. It's wrong exactly due
to the fact that *if* we have a kernel thread, all the modern
non-SET_FS architectures will just ignore that entirely, and always
use the iov meaning.

So just do that WARN_ON_ONCE() to show that something is wrong (the
exact same way that the direction thing needs to be proper), and then
just fill it in as an ITER_IOVEC.

Because handling that legacy KERNEL_DS case as a KVEC is actively not
right anyway and doesn't match what a kernel thread would do on x86 or
arm64, so don't even try.

                 Linus
