Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C6D5FF364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJNSFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJNSFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:05:19 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B325F275F3;
        Fri, 14 Oct 2022 11:05:13 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id u10so2915950ilm.5;
        Fri, 14 Oct 2022 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=heX+Vf4ClPZWziY9bX1NMfoFhQNF692mEmPkdTluBtI=;
        b=BZ0YQm3TM80LUGEu/I6xjj9baWntOotGI3JZbxq9/KPD5bc8vmQyk3V3by2cnlzVp6
         KEprpwCXOhFSo7hEfWVuCzK5oiz0jCA6J2lW6AkLmB7FZJ7tVFf+amf1HrGESND5g/x1
         yrJxmk0G0W8KXUTIIM4hOf6YVaDOaQFnSiffMjF1FoYP/cNaXSDKXrO0rjLX2ihh5YNb
         nbuhzOgisGmpmpE9iF9K3/ySYvH+GJfskpiZi60nXSUuq7f9C7Bm5QUEf3rG1bE71njV
         6mKDa2jmT9kjw+QVy566pI8teS4G7grRKZxO1zd24zlxM2p073KMWqH+DpTgN6pn4Fha
         wlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heX+Vf4ClPZWziY9bX1NMfoFhQNF692mEmPkdTluBtI=;
        b=VNGKCQxp7u7fyIuv2NqWxk1RuvA4CH+fUvwLgwWuNuKW3qlSPR/1bwej0f4VGmJVUf
         wyUULiQJ+cjQdMFdapzOO9axvBQHOMekdN71OqBwwv+Z7eXxS6s1bMyfWax9Mjj36/5V
         fmBWN7Q2fI0iH1BzfjOgn7Ef0UooQuhTEjmXYQuKT3udPTmbyHvmT+YTafe4m5tgIYsT
         VlZ223jW/Q3wzxJ4ImikSji1b5trsid0tHFVFdOeYqn8Z4+eJknjXk3mYcR49k46fZ18
         cMBlUSNza9WJeY6WtLhdapuc0BgY3aD146St1EI9Ut2VLkhKV5jG38LNKtIGYinw496z
         H6GA==
X-Gm-Message-State: ACrzQf21T5kiVim9QdtHK43KyLru6giae0lhvGOmjpL26EtZtBJa2XXx
        Yv+wwvdrZXh8VCJvtkbC/57i9yEZLQqlzUYgSXw=
X-Google-Smtp-Source: AMsMyM6s5Rfx2u7/NNT10bG8hjnLthUnRVBOBP4MJcv/JcaVp/vUIfqY38iYUZHZwKjUZcMueSSsRlZ5c2s9/Rfgu1A=
X-Received: by 2002:a05:6e02:1b0a:b0:2fa:1435:a0fa with SMTP id
 i10-20020a056e021b0a00b002fa1435a0famr2920474ilv.321.1665770712014; Fri, 14
 Oct 2022 11:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
In-Reply-To: <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 20:05:00 +0200
Message-ID: <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 1:16 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Rust supports IBT with -Z cf-protection=branch, but I don't see this
> option being enabled in the kernel yet. Cross-language CFI is going to
> require a lot more work though because the type systems are not quite
> compatible:
>
> https://github.com/rust-lang/rfcs/pull/3296

I have pinged Ramon de C Valle as he is the author of the RFC above
and implementation work too; since a month or so ago he also leads the
Exploit Mitigations Project Group in Rust.

Cheers,
Miguel
