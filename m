Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB27751FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHIEey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjHIEev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:34:51 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BD1BC3;
        Tue,  8 Aug 2023 21:34:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcac140aaaso5008149a34.2;
        Tue, 08 Aug 2023 21:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691555689; x=1692160489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrIFCxoQFLt3rBqRXdHfgV9VxVhBqDIM5mI2fCXfaF4=;
        b=c/2Uh2cWsZ7udAAfauq/GjzvN/3uMjvvnG9YOb9MmutQUaDQs5RhLLz42RGuQBduAt
         J+UaHCVD0LKJOubierM1goQOJ+TMPsEPV6DcZXJEvQcA25G+1G5SgDd/qHm0wSYBwGn1
         3sSdJa1BAT2kibEjGrZ8hVse4/5K/YtcSf0z4MOTcJ7f8//W5mL2iBzeT6R2YGyYPhjt
         3zQ2U8BQ1UI/fgPxN7B4cgVpue3F6kVPAYvy+Rs/L9AIxR0YhH+Ua8dsyGm4QyRcpSOI
         MKO1dDVNbeUfuTGBQRUBbVUHMejzqzhpfAcU4BB/5A1aDTf0ASEesepBnYue3S+AUeIL
         vO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555689; x=1692160489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrIFCxoQFLt3rBqRXdHfgV9VxVhBqDIM5mI2fCXfaF4=;
        b=boZUHxqdr1IxoJMVKSHBrWdTdl92PMpPcJuNaqwWdQ8QOo5wd/PCKt+3EVkKvUXfYr
         mr2fnFK0WmCNT2ETNts1fScv01HkUDlMBz6AErhikerR7LbKUMWmNDRRbudDAH7KUllJ
         gaSsMZEJBK/O1pVULzn1OKAQGyvx7y26yb7lmxosTYaPzjVPgC28dbvxwGBM5myv673U
         vIWEDJk5GEkjAUWYDVFXOpSk3TrzWGZnPZVSZFUbOxD49wRauaMoHKZnatrblBH48E3/
         Zk6m7/qc16wp9YwueBK22SwWAiYUxybPh2KBtb0MfCXXbBRLxSyX92vd4vUxw2uX7V2q
         Dq0Q==
X-Gm-Message-State: AOJu0YzLmcNx97UYNeuKQm6fzc/yAlLIa4YCEc4l544xRPNJhhsNbR1i
        JlltBqt+s8/MWs86U3Gqp38=
X-Google-Smtp-Source: AGHT+IGD64zPGlC3vs1oKuT2FH/1je1GCjZMX1il7yzIo+Ecc7zLHE/qDNQ9lQHRx+wy6SimoQSdbg==
X-Received: by 2002:a9d:6c49:0:b0:6bd:a82:8edb with SMTP id g9-20020a9d6c49000000b006bd0a828edbmr1523277otq.10.1691555689218;
        Tue, 08 Aug 2023 21:34:49 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n26-20020a9d741a000000b006b87f593877sm6552031otk.37.2023.08.08.21.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 21:34:48 -0700 (PDT)
Message-ID: <4478c068-9e7a-482a-aee6-bbe3d151202f@gmail.com>
Date:   Wed, 9 Aug 2023 01:02:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/5] rust: file: add `FileDescriptorReservation`
Content-Language: en-US
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
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230720152820.3566078-1-aliceryhl@google.com>
 <20230720152820.3566078-4-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230720152820.3566078-4-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/20/23 12:28, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This allows the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
> 
> Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> +/// A file descriptor reservation.
> +///
> +/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
> +/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
> +/// out of available slots), but commit and drop never fail (and are mutually exclusive).

This "drop" suggests to me that there was a method that it does said
action, and indeed it is `Drop::drop`. But if I look at the doc comment
of `commit` then it doesn't look that these two are mutex.

     /// Commits the reservation.
     ///
     /// The previously reserved file descriptor is bound to `file`.

I'd put a mention that `FileDescriptorReservation` gets forgotten when
`commit` is called so then it clears up that it's mutex with drop.

> +///
> +/// # Invariants
> +///
> +/// The fd stored in this struct must correspond to a reserved file descriptor of the current task.
> +pub struct FileDescriptorReservation {
> [...]
> +}
> [...]
