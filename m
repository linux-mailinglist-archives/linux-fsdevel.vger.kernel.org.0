Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D696FCC58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjEIRHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjEIRHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 13:07:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252983C5;
        Tue,  9 May 2023 10:05:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a7e639656so9296013276.0;
        Tue, 09 May 2023 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651894; x=1686243894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owOMixsqPNTyMBJNKUX/FgFLQqeBQlm+1l2rTnwK/fs=;
        b=JOX0hNsoJ+nxU9HMHvvY9dGTFLfJLh7mmQS+GkpFIK4WwUd39rCAACztJrQ0Lo5Y6/
         DLAb3z5i6KRx9o2dVXq6X33tjCkcBj1JbVQoYT5+iLz2CPUkSsOSX55MMRZymFDcN220
         hMqnW1LxW5XKGdygadMgT+2xCLuAdatcQCbKyilp8lenEYfuWsSUSR293yncexEbj6ji
         LAaV5mhLpwljgj9SKdaWFNLRHFP/5Q85uEVaBHre+UnpFc+0UDA4kvyu6EsJvBDZ5/r4
         /UEYyBW9zrvTxUi9TX1dMElAgEw/YJ7+x2x+sgJokDV2nU+Ltm86CtwgLbWnDglmtS0n
         5JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651894; x=1686243894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owOMixsqPNTyMBJNKUX/FgFLQqeBQlm+1l2rTnwK/fs=;
        b=Z5B970k/68FHZqAks962MF5NxkjrA2hsnC7vXoex2YSHfyFvNDEwKyn2k2jRpV4XDW
         Xrh/ufBlvorQKWkge10pclpbPgahQmYlhr9QUHyCNTQ+LE74EvHvRHhdfV3RvvQTCwd2
         xPS4J4KD2KCGXU0JAsPWrAg/61Yf9vQjHTg8aq8aZqNC7O2Ag7Ta4D2SYGn5IrQH1EZH
         j5wlI4gmMhXJ0kzRoEfZ3oXQzIy24phwPevDNdG9QHsK/P5N2LvC5vrWwMqbdiqVFU/X
         kSjZN9vQxMegrcoL1KaF/OkDZvfZiAG18rW33k2/+Sx6BKqNJfjmLNexLOhDppEaDYxW
         L2fw==
X-Gm-Message-State: AC+VfDzuYc9T95t1dyEYzGFICuFgSNN7R1kbFnCJnrCKZAQghMGYr1jX
        zZ8mOrPm+yz2kvwR3n8MXCgcP/2fd1dh4/goag4=
X-Google-Smtp-Source: ACHHUZ4Ap8lrkdUmK6J87mlrt06sBuonBxyNhWV6PrQXF5/y8Czghn3iJSEmbpcJ2d/Ohw8GgN9pM4qcPala3tWkprA=
X-Received: by 2002:a05:6902:1508:b0:b9e:45e1:3ff with SMTP id
 q8-20020a056902150800b00b9e45e103ffmr17231824ybu.42.1683651894352; Tue, 09
 May 2023 10:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230509165657.1735798-1-kent.overstreet@linux.dev> <20230509165657.1735798-2-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-2-kent.overstreet@linux.dev>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 9 May 2023 19:04:43 +0200
Message-ID: <CANiq72mLmAG1Vus5-r4ynQciyypZbO8ueva2jbiEvaOAQTTzdQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] Compiler Attributes: add __flatten
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 9, 2023 at 6:57=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> This makes __attribute__((flatten)) available, which is used by
> bcachefs.

We already have it in mainline, so I think it is one less patch you
need to care about! :)

Cheers,
Miguel
