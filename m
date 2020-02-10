Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD4158255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBJSa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgBJSa6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:30:58 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA7920870
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359458;
        bh=omPLg79kMPvUSKiyNNvd0/ylILD31wzwomGJPrNGyQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZmJEdXyo7TiCuP494908+DDQqiXuByAFM/5ZYZdUBh1RBbsjG4Nj8BtvNderACDu
         buUtqSZaMUtzDuCNulwdaDkgV5kqZL7lno4QgAbQ/lGQBv705tgeTFjmzJtXJCSjQ1
         BFRJCZcEs4eVwRoiOiwkJ6JclPVFDKSbcrF3PIR0=
Received: by mail-wr1-f44.google.com with SMTP id k11so9020251wrd.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 10:30:58 -0800 (PST)
X-Gm-Message-State: APjAAAWcHROSf0h5CiREAiUQok5geLwDvLLn45grUJqAzatvDYl9h3B+
        y9JDkpqtqH+bP6TeEXvEiEJ9gUGYKiivqinrNW7nYQ==
X-Google-Smtp-Source: APXvYqzr7b50VDslir7PKIqAsDCapDo139eIqmv/8TM15nWdMYYpgSAHPnXtkGdcaP89mSWD9lXJHS+xhiOGpQ18who=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr3242839wrm.75.1581359456683;
 Mon, 10 Feb 2020 10:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-6-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-6-gladkov.alexey@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Feb 2020 10:30:45 -0800
X-Gmail-Original-Message-ID: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Message-ID: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] proc: add helpers to set and get proc hidepid
 and gid mount options
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This is a cleaning patch to add helpers to set and get proc mount
> options instead of directly using them. This make it easy to track
> what's happening and easy to update in future.

On a cursory inspection, this looks like it obfuscates the code, and I
don't see where it does something useful later in the series.  What is
this abstraction for?

--Andy
