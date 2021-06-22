Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10D3B092A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhFVPfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhFVPfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:35:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210EFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:32:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so36706985lfj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmjRNaRTsIzZ03uK9rRt/2A93U0PY9kbbj4A/XRT2RE=;
        b=B6yWARmK6avEL61zEXxkktz5rMZ9fVIMLFKMWeX9LV0Sfcd5VNigl3pqQdvVOnT5fc
         wmXE3hK9zOlTCkZFZLMF/QUQ+0cmNYbS2oB34FCfw6eCV15UfYIvGJflzAjcMTMrjE3J
         gE/yWAYAxnnXGInGBg5PdjmBrZOcNgYDrgWts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmjRNaRTsIzZ03uK9rRt/2A93U0PY9kbbj4A/XRT2RE=;
        b=HlUXc/j+RUSEB1qV/gvU1hgi6d3LgGkW36gZmyogkeeTWiGY8XSd9aEDnrotx/O8Oe
         9rN3ffhG4kRQyUXuVJgLI8pcZhPe/HT6XctuNOvnrizXecCtl6cVH6J3nzgXVRDgEYF+
         vgdNnQy/1uU/VHM/SIjiM0Q8uX/lZ4OBrDlhpisaMcJmcJUbDCxprmAP3L+jnaiwBO7G
         bKYBGv3MGNZAg7zp+LZi1iffIuvo5+unSC6XL6C7+0fkEEWIY3u8hH7nA5Gzw53eaVat
         ZIKMUUxIrvyEgAb4kPLGnvahxzEej40BJ+XxBwLziDJ5G5vAlAvppsLWTxPGsvKV2MZx
         HnFA==
X-Gm-Message-State: AOAM531aODZASPkSiiamWe7sP+0SmBTFQp+wqVjF1SHvYZ0UWWSm8Rp1
        PnyIkFHAn5Y4phXucG3Qyh+uDKrzr0r6npbgY1E=
X-Google-Smtp-Source: ABdhPJzvx2/Dh8m16MaCKRwkZgWtkxOEvaXkUsRPMCOyg84Lcjsxke8WnYcMOo2DMOY34Eas65mXhw==
X-Received: by 2002:a05:6512:3047:: with SMTP id b7mr3390723lfb.391.1624375970408;
        Tue, 22 Jun 2021 08:32:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l16sm1279893lfg.36.2021.06.22.08.32.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 08:32:48 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id s22so30745327ljg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:32:47 -0700 (PDT)
X-Received: by 2002:a2e:7813:: with SMTP id t19mr3700308ljc.411.1624375967597;
 Tue, 22 Jun 2021 08:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <3221175.1624375240@warthog.procyon.org.uk>
In-Reply-To: <3221175.1624375240@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 08:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
Message-ID: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note this part:

On Tue, Jun 22, 2021 at 8:20 AM David Howells <dhowells@redhat.com> wrote:
>
>         copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);

The "atomic" is the key thing.

The fault_in_readable is just an optimistic "let's make things be mapped".

But yes, it could get unmapped again before the actual copy happens
with the lock held. But that's why the copy is using that atomic
version, so if that happens, we'll end up repeating.

Honestly, the first part comment above the
iov_iter_fault_in_readable() is a bit misleading (the deadlock would
be real _except_ for the atomic part), and it would logically make
sense to only do this for when the actual atomic copy_from_user_atomic
fails. But then you'd have to fault things twice if you do fault.

            Linus
