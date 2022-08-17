Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22D597880
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiHQVCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiHQVCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:02:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B6AB429;
        Wed, 17 Aug 2022 14:02:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h78so6365641iof.13;
        Wed, 17 Aug 2022 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=p3kmNNco7c5N9PybUED/NbqPmlZIv5vlXMEqlV8OmdQ=;
        b=C7kohQheIdzIJnlgySCXNEt6bVBDKy83LAC7rreH4sxDFVRECxS6/TsYYeNbWZtesr
         mwXTw/MpURGTNBNibQcNIeJyuD68cTxvE7qcHjxbyLObfmmaeItob6P9/9/FIOVoJQFN
         P4Xmsb/pw8PP7j025oQycBMxP8wqrLAGuBTi7HLJEDFz+RW2Y0c+PGZTH8Wn/t23R+BR
         /PkxN4dHikGFN3Qo5Z5empcUB+7lzxnZuef9EG+LrMZlKRbeXP7RfZohANNfeGc3AUmX
         0uGRcACxIsMT+N01dCQeUkL8driuuyuAngkQpo5sLK8AyzcDQr4IiWAZLqy1k7JCsszg
         E4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p3kmNNco7c5N9PybUED/NbqPmlZIv5vlXMEqlV8OmdQ=;
        b=ruX+iSCy+6+kr87qWSx4iKA06PnHs6NJrxGwmx0V5vQ5jdK3z1Ew+ETcjbVUrk3fBP
         hPuStHYUgoqW3k1K5I7ZH8ct2oesBzh9CB3MQrIDiZ9OiG0xc7zo/qn6tFRu7jrN7bg7
         0FJksgHUkSRadjnlNPoI0Fi8zpaxTdtAU0g5gOqK3nhaRw6wHqRnY49EZfQ8+E+28l3V
         nipbomsODbEpLSG/39ges5IWtJDVVhhmTnihqAiz0absW6rohnzlGtDpa3uBqwmwohL3
         HmhLBOGhFFpu+ekCaFTHk4zgkprwDhb+94/NUzXnBOWHtrZowHwYwFPxZBkJu7w3Dd3U
         Rt8Q==
X-Gm-Message-State: ACgBeo3fiZQfTopP++1OZdo1EbO/UIFaaxccOpME7JPA0AC1oG8QkXlb
        WYoBHK8IEo3bT/tdMaWoxAYARk7PGXcdYxCilt8=
X-Google-Smtp-Source: AA6agR65LjBBgIfnMKzM25ANX/JHE6PHDf9A7mmgpChiz+NhwUHhbZcTvCT1HrVeT3DfvlnuKEXI17eEpsbYn5AqYJA=
X-Received: by 2002:a05:6638:4117:b0:346:b5e1:383a with SMTP id
 ay23-20020a056638411700b00346b5e1383amr33201jab.264.1660770132624; Wed, 17
 Aug 2022 14:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-27-ojeda@kernel.org> <Yu5pUp5mfngAU7da@yadro.com>
In-Reply-To: <Yu5pUp5mfngAU7da@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 23:02:01 +0200
Message-ID: <CANiq72n029==Oc5wbG9pHGrRawRNzYxqZMBK6_S5gMjny5SoQg@mail.gmail.com>
Subject: Re: [PATCH v9 26/27] samples: add first Rust examples
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org,
        jarkko@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@kloenk.de, milan@mdaverde.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        torvalds@linux-foundation.org, wedsonaf@google.com
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

On Sat, Aug 6, 2022 at 3:15 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> I wonder if it would make more sense to implement exit() in
> kernel::Module, just for the sake of uniformity.

Do you mean uniformity with respect to the C side?

Thanks for taking a look!

Cheers,
Miguel
