Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334BE5FA889
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 01:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJJXQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 19:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJJXQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:16:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271974372
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 16:16:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so27777772ejb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKLnyVJ0nNgakFSgUxLr7WhxEeqfhLp9XdGiHhrJ06w=;
        b=Ryi518lVq+timi1Kqu+idgXmjtgi4HCtGXEwjzHDXXl5PQ9749Qk6algii3a0SO5OQ
         W5+ghws/D6+LGX63grCrAsJAZ2X73rWnGpEuNTgF+0sG4sOILzGhkGX1Eatnq4XDuO+X
         4WKk/7sX2kSc1WGM8iPo6ZmmMKzUwbF6T44FNfCuG0gwQwGTs5Cd0CnlMBZ05MB3LQLt
         Z2/G8pNFwZcsBymYsai2ltCRH53PQ0EAi/LOGc4vOAYVbdKHShVKFSmog4D9gs7kJNwO
         DViA4/Du1iDndpYP/18p9ZZjR1R6GgtV0QQVFLT8YhigXRqJo5/XQWzaAym5gYK8HDex
         ABKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKLnyVJ0nNgakFSgUxLr7WhxEeqfhLp9XdGiHhrJ06w=;
        b=FWFDTC8wYkT2peXfH6OUDP64n2KvJdqAKF3LE+FPmAWf/yqIN8bf+gm7NFMy7TJ2Cj
         aZKH4W7mNjnXb4hkP+HaJsKb9yj635wkcvYbJVghgQFWpH4mODg+7KpHNWt0B+eRPFGP
         fQ9QN3W2ykF2RAR2uD05CmgEckZ2KpIcaQJgSqWDsK+vk9958lhJkutV0/gOaSZvayUy
         XzBS55LKOdQLZiG5zVVc+ICyHpyfnuJY7xndZMEGcvnlGuOwlzF00ATnMErdAgxWij7C
         kQewceu7h3jhjVUWcUDTUDeMLqT0wGTLqc8hQlMQ23fQPCDSUbjkTHFS4ni2gBirLuTU
         NNTA==
X-Gm-Message-State: ACrzQf048w1gFNLb+4g1XubYkQaTCoFbuXxyn8jA/OP53SVji/7axGD0
        YCHrgqbizcY8Xqmfoxs8CSn1KsIU0WmaDbjt7RdRnQ==
X-Google-Smtp-Source: AMsMyM5nVE+afZe0F6TrLstl85/eEUpde8vabQOqkBtX4AtcSkFZgO385VJ9f4jwvHK+QMgqc/4r+Z68UcPthxNCAdQ=
X-Received: by 2002:a17:906:5a44:b0:78d:4c17:9856 with SMTP id
 my4-20020a1709065a4400b0078d4c179856mr16889557ejc.477.1665443769407; Mon, 10
 Oct 2022 16:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 10 Oct 2022 16:15:33 -0700
Message-ID: <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 7, 2022 at 10:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 27, 2022 at 03:14:56PM +0200, Miguel Ojeda wrote:
> > Note that only x86_64 is covered and not all features nor mitigations
> > are handled, but it is enough as a starting point and showcases
> > the basics needed to add Rust support for a new architecture.
>
> Does it fail the build if required options are missing? Specifically are
> things like kCFI and IBT enabled? Silently not handling those will
> result in an unbootable image.

Rust supports IBT with -Z cf-protection=branch, but I don't see this
option being enabled in the kernel yet. Cross-language CFI is going to
require a lot more work though because the type systems are not quite
compatible:

https://github.com/rust-lang/rfcs/pull/3296

Sami
