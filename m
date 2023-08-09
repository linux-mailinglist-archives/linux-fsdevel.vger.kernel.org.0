Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F067751FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjHIEfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjHIEfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:35:03 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418151BF3;
        Tue,  8 Aug 2023 21:34:55 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bb782974f4so4946612fac.3;
        Tue, 08 Aug 2023 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691555694; x=1692160494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNuO8maW3k3biYUipfRcSFSTTKrtXD3lVQL4G6LBK5w=;
        b=HMNhAZoCzWrw2LiU0SnsgmGnnq7sUGxddlTDeiaWnkPApFKIO1YsxIGzTmlbQ1nhxU
         d/1CUW2Hk88KQp5/6dsDIEqn1WplnEkG7ZCQ8hkHdOFOjwZvo9wvt4oWupSY1ynhANFY
         HpW/pC4icZP7XTSTeUGIM53yvMMBLBW9EherLgpsT8QJQ89pqok75dXaHXE+mRLiwub4
         pulu6FSvp7M0ndW0C2brOfYHRtFw+yk3UW6XX+Ce59ZgbxS9lIAAZurwJ8fEuTaIAU5k
         VCl0n7RAeP8fYe8dhdKzpS1a13EZ4zstAUzcKum1zvHaDWoJosDlFjUB0RUuEKAMw+Yv
         o99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555694; x=1692160494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNuO8maW3k3biYUipfRcSFSTTKrtXD3lVQL4G6LBK5w=;
        b=BgRLw+PlAspGOU0Ov1kwXeOz12dTkUcJAQraZQBK4umfU8ijxEPyGToAuvHgm0GOaj
         5Mag+UhMTCFGKLI+vT7lsQVI4L1zXbmcyTNh2RKz4RXmr/bPlThS+y6AyMHjebTnzoYm
         Ao5mpYD+UMSaDcWpfcJ76vueWouh6EKt+r09Ovmc3RYzW/jYX4W9Anerz1iuLFcmDQXs
         RsatIhWIKRJ9ZnX5n0OdrxF3CG9GVVgaMOPTOcdvub/L3EyMjF0l9lmgMOeNldKX6a56
         lIN5hTnsqrC5HN7AMp8Zx/PboVZPDvS1RuKGodGudxp749CVUrT7DRgBTHhJZ26CFbDd
         a4Iw==
X-Gm-Message-State: AOJu0YzMTDpPYP1l+apjkSMGda7lD1utW3SOydCIumwR4gsiK0g/SQJF
        b5/so5taFGX6M/YMuk6oBtE=
X-Google-Smtp-Source: AGHT+IGWK0eChk1cvzdf8ALQcYWZ6DdPYFNWw7+Hs82Xlsp8oPp+UkPF+d/rvirOwA0Ro9ksVQ0YxA==
X-Received: by 2002:a05:6871:1c6:b0:1bb:8483:a807 with SMTP id q6-20020a05687101c600b001bb8483a807mr1893306oad.44.1691555694018;
        Tue, 08 Aug 2023 21:34:54 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n26-20020a9d741a000000b006b87f593877sm6552031otk.37.2023.08.08.21.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 21:34:53 -0700 (PDT)
Message-ID: <bee24ff5-444c-44f9-81c8-88ff310b401a@gmail.com>
Date:   Wed, 9 Aug 2023 01:33:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 5/5] rust: file: add `DeferredFdCloser`
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230720152820.3566078-1-aliceryhl@google.com>
 <20230720152820.3566078-6-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230720152820.3566078-6-aliceryhl@google.com>
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
> This adds a new type called `DeferredFdCloser` that can be used to close
> files by their fd in a way that is safe even if the file is currently
> held using `fdget`.
> 
> This is done by grabbing an extra refcount to the file and dropping it
> in a task work once we return to userspace.
> 
> See comments on `binder_do_fd_close` and commit `80cd795630d65` for
> motivation.

Please provide links, at least for the doc comment.

> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
>   
> +/// Helper used for closing file descriptors in a way that is safe even if the file is currently
> +/// held using `fdget`.
> +///
> +/// See comments on `binder_do_fd_close` and commit `80cd795630d65`.

Ditto.

> +pub struct DeferredFdCloser {
> +    inner: Box<DeferredFdCloserInner>,
> +}
> +
> [...]
