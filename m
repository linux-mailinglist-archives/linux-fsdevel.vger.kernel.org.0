Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075887769A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHIUPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHIUPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:15:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF810CF;
        Wed,  9 Aug 2023 13:15:35 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd066b0fd4so174110a34.2;
        Wed, 09 Aug 2023 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691612134; x=1692216934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mD3lZ+cedaC3uh75ynu2ZL3JyVWBLEXJVSbA+C3K0LU=;
        b=eu8uD+QFcUZ38jGEmySOr/1VMtkfXYu9r93sNp/ePwPq83li5VR93dBVyNgY9L7Cfc
         WgNqkoL2GSmDl/o/6yYY5DTr9hxcezCRzpgSytKFBXwe0lQMnp1kwkQc8p+YxAuz9z1Y
         hxU8EDW8bvGyNjEY3YfY5B3FXr8r/SEmwN49H4G3Kp9VduX3saJOq4wPFF4qBiujEJ2g
         Qh9y2oIUFP/RdFF7M6bQusB5GMBvU1wh0tppVi1KD+Nz5b6/9jq5TM1L1cGsexin5fW+
         tvTXov1jyvcbGi6L7uLvxc9oT7wAnHxa4w1CRCCvU8x+oMNeHHbYfVDO/4gUdiHRuwoG
         wLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612134; x=1692216934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mD3lZ+cedaC3uh75ynu2ZL3JyVWBLEXJVSbA+C3K0LU=;
        b=NHA5px8sTsoIQ4C+/O51lo8h4JPgwyeR2X/vvPLC0CmSlgdWDGsrUMi+42Lunsiw47
         gldv5EXZoreGP1vasJefhJen0/haxcgX53tZy7LJMLcetJAvCo4nuzv6kp2GBWhq2K2l
         +5sz8o9xVZUyikU1AvXqpw5JRSSvUKPmlqLP/UhwFnDQmUIeJN6QzDES3bFqgoBij9G1
         mIBCWIHuP94BCzM0PTjp20BneZ3FJ6Gk4n4iTXovIEZwP+trTiXFgihzsbEiG2rGWpYB
         BvMSu4H7np6ooJ3wHsF/yGiUbaC1l5tL+kE56Tssc5V1Zk0HcWGxvh5s9WQx47Dk+Wun
         tWrw==
X-Gm-Message-State: AOJu0Yx7yPXrIhyvv9PuoWoZWF0DYN4aD/MxLCB/KE4dwMH2lN0ByiZ2
        eNUanveaoJ/dqPWWpJd9tf4=
X-Google-Smtp-Source: AGHT+IGmy/YEk0/6tf7GbIdqdSbviX+FQ1mwJv6DoHjtUIF0cXpMUJL6SRyWRhjyQR8256ApJQZ9WQ==
X-Received: by 2002:a9d:798b:0:b0:6bd:bcd:43f8 with SMTP id h11-20020a9d798b000000b006bd0bcd43f8mr118188otm.21.1691612134452;
        Wed, 09 Aug 2023 13:15:34 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z21-20020a9d7a55000000b006b8ad42654csm14147otm.0.2023.08.09.13.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 13:15:34 -0700 (PDT)
Message-ID: <8313fb24-5fbb-4408-825d-974da33a4353@gmail.com>
Date:   Wed, 9 Aug 2023 17:15:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 5/5] rust: file: add `DeferredFdCloser`
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230720152820.3566078-1-aliceryhl@google.com>
 <20230720152820.3566078-6-aliceryhl@google.com>
 <bee24ff5-444c-44f9-81c8-88ff310b401a@gmail.com>
 <CANiq72mHU7n2jTPFsO=tjfqucrbe2ABSUYPUG6ctEerh4J+U_g@mail.gmail.com>
 <CANiq72m5tbj2_N_s371d5N_4H1xpE2ahTHOUvFtUd+N0Y=0tsA@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72m5tbj2_N_s371d5N_4H1xpE2ahTHOUvFtUd+N0Y=0tsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/23 06:09, Miguel Ojeda wrote:
> On Wed, Aug 9, 2023 at 11:00 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> If you mean for the commit, then we should follow the kernel
>> convention instead. Please see my reply to Alice above.
> 
> One extra note: if it is a external repository, then yes, I would
> definitely recommend adding a `Link` because readers may not be able
> to easily `git show` the hash. But if it is the kernel tree, then it
> is not needed.
> 
> Cheers,
> Miguel

Gotcha

-> Martin
