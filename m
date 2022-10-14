Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D05FF2E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJNRXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJNRXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:23:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B501ACABC;
        Fri, 14 Oct 2022 10:23:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o65so4416251iof.4;
        Fri, 14 Oct 2022 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eE5Ag7RBU3sseMTq/AOwS39S0M38TKiM5Cd+C4qDXCg=;
        b=SelnujiWPnwoqfZh8L8STKGUSxYsQvfporOrGfiFWq7bcOzL0QfdMmL40UKrA+beU+
         PC/2mJpZDykCD2AjqVjwdRgvdWQ7aogtAl+Hq/3RYfuMFqkmdwGX5x9i2EF1LURSEkWe
         UgEVvUzkNVE22tJqIQkviWHhunuxpOVT8D4lwYeRlBXIXcNhM2OyyZ7v+zgA/fL/CmbA
         9QEL0Tn6Z/ZtMi3pOJiB6isnrjoAKhSXEzcs6KLcsD7E9FEePJWKn1u9DAnNcvjIrx4G
         h4G0Z5ct9Vfi0V5ixBdkIMpgsvwCZsWMXka3IgbZiFUUFnJ+QBQQH6oNk4hLFjFvPokK
         5fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE5Ag7RBU3sseMTq/AOwS39S0M38TKiM5Cd+C4qDXCg=;
        b=7pH2SlIfJMhlQ/PLeSkGfJoizVNR36mCL2P2ylvoNCgRc0Ulu00VB90MgTYL3++twE
         6JF7qjvVYftHLp3yvrr/2AJS3S4h7C8dJucKcyN8FxntzPJdpfP1LGaaSpsKiRcvk0yG
         WEgAtssxzbg7fpY/16ED7AA0/FftZC8/wSwADQ0MBDi+6hUrlYr6HiZBmLffzJqiFp+l
         AVfaqA2Hh6UxteFkQDNkvfZvFG0LLTVgoZdIfnP7W8pNghc2osPgmvOp8/E2eqFs8G0k
         RNNTj84BdwmE9wZ9VpZ+xObaJ6TJ1JTR0BQ2hrvQfcdyqtYGozBMtZmZWFw56TDVGCax
         i7XQ==
X-Gm-Message-State: ACrzQf268WsMxsxBDcmyHVZUe+oYiiiu8+w3eefavqO4nK1Jn1mFgwVr
        rT8E5ZnipG5twuWVBRe0HRXyAopVSQo/BM3Ua4w=
X-Google-Smtp-Source: AMsMyM6lT8RhqnU76Cr4PZZfqp6N8r8CcTFMjIHkYpaZhVOM7vxX6chpycRJ9uocxKR25P/3/Yeaz4H/VQ4EpfSIe7c=
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id
 i15-20020a056602134f00b006a4cd047842mr2888358iov.172.1665768209701; Fri, 14
 Oct 2022 10:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <Y0Ujm6a6bV3+FWM3@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0Ujm6a6bV3+FWM3@hirez.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 19:23:18 +0200
Message-ID: <CANiq72nggG_z28Pne7wD=CQfKX3bTUah9vMhvJoWB8Y=uA4j+w@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
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

On Tue, Oct 11, 2022 at 10:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right; so where does that leave us? Are we going to force disable rust
> when kCFI is selected ?

Constraining it via `depends on !...` or similar as needed for the
moment is fine, we have a few others too.

Cheers,
Miguel
