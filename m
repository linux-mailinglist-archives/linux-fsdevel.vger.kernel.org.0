Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011571ED9E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 02:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFDAN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgFDAN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:13:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704EDC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 17:13:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so5014787ljc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2020 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWe2Q0RVzrp4gR0EET85HSpI5Y5evJHsyhPkQ14mL0k=;
        b=bt0TGPg3m1SCTLBdHymXFLfl3E3L3r+udH7rn8D+EBhHjSsJezRKQc5I44quK2Ep95
         n7O9rGE+x0OuzzxK9JDFKVEZNlNil/zWzB2OtsPvSkq3h3Byx+1A/PbyAJD8T+ACtvtF
         KVePdWwwaM3XuFRkXqkGtRQjsVdhDo42Nx8Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWe2Q0RVzrp4gR0EET85HSpI5Y5evJHsyhPkQ14mL0k=;
        b=dpYFUvVOZ6i6sormjEfGyMub2aFCncsxBanIsQV7gdGgpcUpGjgC+IVwhkdcw0aXS6
         Ra2G7HjdMgMUbsDN3lu6GWb4kZszWDzCqgN+mSzBKHZy2CjWYztxfFZEo0dVchH2rCDb
         8YXf8s8oyrocFtI0CribaUbh3Hljw2r1GnkfQtVDl7SA2HK7t8fNlTnuG2z8OJXLFjDr
         y1pzTuf+ummKPT+htqOHE3O4IXIaQGn0Sr2tRourFoVczsOaBQcYtBDxbdHQpo6gYOe4
         PCU31FHd0n7z1C6h9wRovsHM77zHBndIaUgd7Qu9EVpZk3k/WvZShN1Vl9g1EwGPuriF
         eFWQ==
X-Gm-Message-State: AOAM532EX6RV7rey9Pqt1DRmKvpE6v4yvmkGjCqBkJwJuMT7+aaQW9Vk
        Oy2cKrggXboE1HJqB1LD20+6QDMHvUw=
X-Google-Smtp-Source: ABdhPJxXa9Qk7TRUxTwZ/s38UMCBnlHvqdVeoS9h2NQwuGoobBvFH051QJZzr54DUD4orE7szbKJbA==
X-Received: by 2002:a2e:a17a:: with SMTP id u26mr742539ljl.235.1591229635022;
        Wed, 03 Jun 2020 17:13:55 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v23sm210583ljg.122.2020.06.03.17.13.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 17:13:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id z9so5000213ljh.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2020 17:13:52 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr790807ljc.314.1591229631853;
 Wed, 03 Jun 2020 17:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
 <20200602233355.zdwcfow3ff4o2dol@wittgenstein> <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
 <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
In-Reply-To: <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 17:13:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTpLOeMjpLOc8hY7KC6Qv+jR-hBacyBSajJ6iUKasmKA@mail.gmail.com>
Message-ID: <CAHk-=wgTpLOeMjpLOc8hY7KC6Qv+jR-hBacyBSajJ6iUKasmKA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 3, 2020 at 4:24 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Ok, here's what I have. Does the below look somewhat sane?

Probably. Needs lots of testing. But this one looks wrong:

> +int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  {
> +               if ((max_fd + 1) >= cur_max)
> +                       max_unshare_fds = fd;

A normal value for "close everything starting at X" would have a
max_fd value of ~0.

So "max_fd+1" would overflow to 0, and then this would never trigger.

Other than that it looks what what I imagine my feverdreams were about.

              Linus
