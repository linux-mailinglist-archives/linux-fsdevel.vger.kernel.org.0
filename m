Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1012D7751F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHIEes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIEeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:34:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658521BC3;
        Tue,  8 Aug 2023 21:34:45 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bd0a0a6766so950535a34.2;
        Tue, 08 Aug 2023 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691555684; x=1692160484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2qfg0WIadQaxwkKNJkFn8ap8YFqlO2fSpQ74DKXH6rI=;
        b=jYl84TsyuM77kswO9vDzgMlUr1RJU00GQ0HoGpndLPQco8KJGeXmKZQhC4pN7Qcuny
         1MfWOJqB4jIiWwtu+aLobCWnEGcemKmjeJeUm0o9/pzgqf4GcgdiSx8l4wQ5BQbJ/XvJ
         KMU6ESHDfqoT2+DCRXp/hiaDiLWtHwwGIuG0fioc1SzXj4UHaa/+VVTxaHGzK6K7gHE1
         5DLk0F1m2SMVasfij4TXX0k1toWpGLVbYGZ7G7haNzw6NPdRtEGgCw6gnIucfZAdar2m
         sWxNZiSmk6Qr3msEoJNKictDNLU1hnQjsRIv7LLLPKrGdC+GBnFO2aEa7rD/Z6WZEqHR
         CscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555684; x=1692160484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qfg0WIadQaxwkKNJkFn8ap8YFqlO2fSpQ74DKXH6rI=;
        b=EEQbdlwZJZF0ANGiV4ZxgdC8XWyQeBXSlfYzuJcIWAPhhgcYGGxRRajxChmMZhb8AK
         bvYhK6/GUxvy4hVkt3nKHTCzLp9FPLrNHjJSdIC/r5RQFtyN8u5c7DKL9mioj7UFsUgx
         ue3W8/FbhteRH+LH8/Wp7MT/Gtsp3dVYO5iku3yO8ABdjWXs3kT3Zpzzns4JRLnorZ+0
         LCpIPwZtCrbAVSlJ2ehm6H47UAb4bPmdbLujYqyVwitpOXzZ6fZ3OJMxs7zfigE7RJqe
         ccSeAH3v0a9V/97hdTE/HpLlgrj3klMifef3YEBMZ75RhTgfZD72VimG/2nM8tco4dJM
         Ka7Q==
X-Gm-Message-State: AOJu0YwtW+ZKcCLf7kVJxWI9wRSEx5LjVtUUTwRpehc5oOuLVnnCWIw5
        xgL8+CTLfmzxx/pgkrE/h63o7I8IrdU=
X-Google-Smtp-Source: AGHT+IH//L5g3jbAjte61tfU8iZCVBXpJcuPCxzhAHTs9tJYQVS6D0cWjx5UAmUGEin7rY3I0cy29g==
X-Received: by 2002:a9d:7f16:0:b0:6b9:304a:e778 with SMTP id j22-20020a9d7f16000000b006b9304ae778mr1628062otq.34.1691555684468;
        Tue, 08 Aug 2023 21:34:44 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n26-20020a9d741a000000b006b87f593877sm6552031otk.37.2023.08.08.21.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 21:34:44 -0700 (PDT)
Message-ID: <94a50510-c539-49d5-bc36-241f1f003172@gmail.com>
Date:   Tue, 8 Aug 2023 23:59:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [RFC PATCH v1 1/5] rust: file: add bindings for `struct file`
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Daniel Xu <dxu@dxuuu.xyz>
References: <20230720152820.3566078-1-aliceryhl@google.com>
 <20230720152820.3566078-2-aliceryhl@google.com>
Content-Language: en-US
In-Reply-To: <20230720152820.3566078-2-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/20/23 12:28, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Using these bindings it becomes possible to access files from drivers
> written in Rust. This patch only adds support for accessing the flags,
> and for managing the refcount of the file.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-Developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> In this patch, I am defining an error type called `BadFdError`. I'd like
> your thoughts on doing it this way vs just using the normal `Error`
> type.
> 
> Pros:
>   * The type system makes it clear that the function can only fail with
>     EBADF, and that no other errors are possible.
>   * Since the compiler knows that `ARef<Self>` cannot be null and that
>     `BadFdError` has only one possible value, the return type of
>     `File::from_fd` is represented as a pointer with null being an error.
> 
> Cons:
>   * Defining additional error types involves boilerplate.
>   * The return type becomes a tagged union, making it larger than a
>     pointer.

These two are kinda passable, as a `impl_null_ptr_err` macro can be opted
to implement error types from nulls. Also if we consider that
`File::from_fd` isn't going to be called a gorillion times a second or a
recursive call is done, then I'd say that the tagged union won't bring
any other problems, except that a compiler optim is skipped.

>   * The question mark operator will only utilize the `From` trait once,
>     which prevents you from using the question mark operator on
>     `BadFdError` in methods that return some third error type that the
>     kernel `Error` is convertible into.

Although, I want this to be mentioned in the doc of `BadFdError` as this
cannot be overlooked when said usage of `?` is done.

> 
>   rust/bindings/bindings_helper.h |   2 +
>   rust/helpers.c                  |   7 ++
>   rust/kernel/file.rs             | 176 ++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs              |   1 +
>   4 files changed, 186 insertions(+)
>   create mode 100644 rust/kernel/file.rs
> 
> [...]
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> [...]
> diff --git a/rust/helpers.c b/rust/helpers.c
> [...]

This one is making my head spin, shouldn't they go first?
