Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277BC5EE204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiI1QkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiI1QkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:40:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324B659E3;
        Wed, 28 Sep 2022 09:40:09 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p202so10595836iod.6;
        Wed, 28 Sep 2022 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=urdLMOPMUq7F9WjH0EioiT8rQ4CBbbV9/KBUGHS9AVA=;
        b=jmU83kIJIkGdg1zmHRWqZ1AH0T8R5/6s10x9NxEdRjyCnS2eSN9C9gP7aC+llzT3ux
         ZSLawfFu0NqgpEknC1+PHq/2yeBOA7V8eYXdIFzfgCPljHDOkK4wr9pXrHl9W+CPNpGj
         ZaQFSCWLDsWLfi0cpSCBG5V64G/TnZWPw9JtQWL9oAHy83o8v2RxkagVWb6jh8HElpt8
         vGk3G+00+VVpw3H2OBlDafb4NP66XLve5mqy05Eas+lsRBhzhf57LWbLMgOxQFkpFINS
         FbU4iv5SpCc19biR5QbawCsg3UOjFkhO/WK8p9nkOPh7R4Z12R8H2VHtX42O38fLE0qm
         DQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=urdLMOPMUq7F9WjH0EioiT8rQ4CBbbV9/KBUGHS9AVA=;
        b=7gWGV4c5dKbYNCPGr2NjyLwls/AEX2TW+Pxdzga04TWS9HQ7MzTS7NieOcH8/a/H8Q
         K9Fg5uvVUQrpKbRx+LS7tXagqzUdc3pwKEZ7j+Qx+tnfCXeqkBkQFiwUPePJxd7n/Yxp
         0lGC485Ahc5AwUTYATXfDWGsISwrQS/cOtpM+gn9jWtAepoLPdR2O/kfxfXn5+NjF8mP
         kFeTZue7e5N1ikzBOpz7NOdOa91SpCTsWeI5WC+Zszfj9FmapowTAGXE82c3svWnFnjB
         FuWrsbfSOq8OCyTbDZVmg0nWDyOmfVwW4Kk4SYygJ7sgpmMehOGwM+t7rcoLRxf8FeG7
         pVHA==
X-Gm-Message-State: ACrzQf08mh9bnVT9TZKeEg+vOfYw0mMlYYHYN3+ZYruYRMLCnECJg3Kg
        8G76SYn41sqgwyeygnRqGCaBJ48YmNDxUlRYaA0=
X-Google-Smtp-Source: AMsMyM64rUq1Pv1q6n0ivrz3KN1pFP1NrH3qpOx9cBqmktLgiYVrwusr5+CWkNW+CqcEo/peGe5WtBX3XIZFRvKNFOs=
X-Received: by 2002:a6b:6f11:0:b0:69f:db1b:f4a7 with SMTP id
 k17-20020a6b6f11000000b0069fdb1bf4a7mr14316958ioc.177.1664383208508; Wed, 28
 Sep 2022 09:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <YzRa4U9iFMm0FAVf@liuwe-devbox-debian-v2>
In-Reply-To: <YzRa4U9iFMm0FAVf@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Sep 2022 18:39:57 +0200
Message-ID: <CANiq72m+3gfo=L4T7WY5MeSxZckQKeV+kVdvRhEAVtxcz9cC7g@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Wei Liu <wei.liu@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 4:32 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> I do wonder how many more things you will need to list here. As far as
> I can tell there is also other avx512* flags for the x86_64 target.

Yeah, there are a lot of target features, but they are not getting enabled.

Eventually, a stable target spec alternative (e.g. all relevant target
feature flags) should be available, and then we can know what the
guaranteed behavior will be and thus decide better which flags to keep
or not depending on how explicit we want to be with respect to that.

For the moment I went for consistency with the line above, since that
was enough to disable everything we needed, though as you may have
noticed, 3dnow and mmx are not there, because I had to move them back
to the target spec [1].

[1] https://github.com/Rust-for-Linux/linux/commit/c5eae3a6e69c63dc8d69f51f74f74b853831ec71

Cheers,
Miguel
