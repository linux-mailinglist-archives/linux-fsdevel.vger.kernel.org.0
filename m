Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B475977C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiHQUWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiHQUWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:22:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF359858B;
        Wed, 17 Aug 2022 13:22:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z13so7454479ilq.9;
        Wed, 17 Aug 2022 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=95u8lNlnSqCf3nFt5kKj92QXYH3MSbflseNXxb5Fn00=;
        b=OYcQUlqsxAJgqISQCgV3vtZHXpalxDTEAE8J09DLHSEXI4qtBF+wzVSvouAELH+k9w
         L8Jjk3X4U8OPV+0FQDBGxAsiOH/g4GzoQtIO9LrExv8Z7oo0tjeZl0c8+670S9iv9xIG
         3VHN/FP/kUrxQATYNnyMcnJzuQ9HRb/7JMaD8CnA6C3SC0izg6+nZ3Y8yF1T0wBzkG1S
         yk6lDQ9XAsaMI4Ou2XPGIcz5AMTh3h+H4b7w6X0q5TEzfmVVPL5Thz4gggWBJPx0mTeY
         ZrbXvnYp0VFg8erHdWD3GA8WgQLvK/uExgsosHBf9+lxmgnybC590tnbLz5kykLynGLJ
         jkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=95u8lNlnSqCf3nFt5kKj92QXYH3MSbflseNXxb5Fn00=;
        b=FiHSaQvn/JNPHB+uzDpbKkVrLm2y2Tj/svRp2dPa6D61rgRYuPivyIPf5M4//Vyav6
         Kv97MYON8z/O9VvTnBRT5x870MCU64Zcgy3AF3v+fIkdtHgzo/GQw0BS5Nle5TlWW5np
         2CT0EBGntlALQSq+qtqQfuh12TMSAz9jo80LasskT7Gu/C4PvGsaNiMFDJ0F8lAqL7GQ
         hdBRftBUtss1HAJgmXnXpz4h8CALTrSrBVN1LToE/51UwRL7G8kTrvmqJtsbLabMhSRF
         moG7gILZ9QLM1mliBnW4XNODGkNn8mw/mUzae+BtazqGfPsW9dFi0fgayASe+FNiBslO
         c5dA==
X-Gm-Message-State: ACgBeo3yD0Bkj38MFYWKK20jplXvF7/jLLWwbyPR5n6QJKnmq/2OhbmB
        qTes+AlXc+CCv6/wvSRO5F0Tx8VAcdUvs6Ybonk=
X-Google-Smtp-Source: AA6agR6srAwQfsZZ9SbamGt91jriBGl4JS80mCTykIHOHWKu4a1YmyuaMej5D630lBaYsdWmc87I+yEYpkFHIpL2+ug=
X-Received: by 2002:a05:6e02:1522:b0:2e5:9e3c:a7c8 with SMTP id
 i2-20020a056e02152200b002e59e3ca7c8mr8623597ilu.237.1660767768527; Wed, 17
 Aug 2022 13:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-7-ojeda@kernel.org>
 <202208171240.8B10053B9D@keescook>
In-Reply-To: <202208171240.8B10053B9D@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 22:22:37 +0200
Message-ID: <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
Subject: Re: [PATCH v9 06/27] rust: add C helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Wei Liu <wei.liu@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 9:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> "Introduce the source file that will contain forwarders to common C
> macros as inlined Rust functions. Initially this only contains type
> size asserts, but will gain more helpers in subsequent patches."

Yeah, I will reword it, it doesn't make as much sense now that it is trimmed.

> Given the distaste for ever using BUG()[1], why does this helper exist?

We use it exclusively for the Rust panic handler, which does not
return (we use fallible operations as much as possible, of course, but
we need to provide a panic handler nevertheless).

Killing the entire machine is definitely too aggressive for some
setups/situations, so at some point last year we discussed potential
alternatives (e.g. `make_task_dead()` or similar) with, if I recall
correctly, Greg. Maybe we want to make it configurable too. We are
open to suggestions!

Cheers,
Miguel
