Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6772AAB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 11:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFJJlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:41:04 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595102717;
        Sat, 10 Jun 2023 02:41:03 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc5402aaf13so233512276.2;
        Sat, 10 Jun 2023 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686390062; x=1688982062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zIC5ZgEXgktuPZa4JBqKMZrDinNOfIFKdwiJnFXNSk=;
        b=Y4tIp8Qcuc4q82Tr9F6BzYdgIKfNZhYUuWbtlj/lcTx0SqrJDYax/fzSi4Fkv3TgfK
         jKIf0ycZiA7MVtz3czctLItYBdYA92Ehd/2jzE9Rh4xtjCZ7+PhY04uH9mWXJ8Ul1dhz
         Qy/z0m0gjOF3IdfXipC24g4q3+ZZQE43VRVX0iF2j6GcBTLZLNbUDosALw5KRbU/d6+y
         HFL/0Xa+REbMNUjqMjZMKk7+znajI3fVx2cRhyMkyn6nf3PhRr5ZoLTwsOnCUfuFNsTK
         mG+0LuNAeshfFAGwMSkCwUSSEzdvcORPY8TF5U7mlau8yaRn4pSflFajk9Uo8jRQ4ZKg
         grhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686390062; x=1688982062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zIC5ZgEXgktuPZa4JBqKMZrDinNOfIFKdwiJnFXNSk=;
        b=G1qCgAjVC/L/s/dFWlte7wT2ROWqMfxBg8TETGforzRlYT/2kkpPB6lP0vsW3xcJC0
         u080rTnRDmfk2LXvuahbQVeNqNWF8MK1tRADR+ytO1vtOCVJ+yImO57drr/CWUhpl1+i
         Kb16o+RXZ6pQeQOSDo1lG8A9YyAy79FGIMxkkjHmhX6o6EapRajB4kgzjRFh1nLc0t3H
         N8vjtoJWxPlXGTt8qxjQ7PO85dKzIghiU2xfB6mC5YgUwureHey6dgl66Xbn5AuIc5ij
         ce4KA6HqKDwpUu0wAAMP8LrW373IkU9J2oD1gzEotz/Hr0Oh58wZOMmBh0WE0AxbyvDT
         ap6A==
X-Gm-Message-State: AC+VfDxxKe8aMMCoK6+QPmt5vY3sZr7z2n7C/oaCU5avh2Z+K1szekR2
        1Vmch3KioOztvgXu8SZ+ypQCx3co4Np+MWhC30k=
X-Google-Smtp-Source: ACHHUZ5JrT3axbrosB4UESa5IECBdUJIwlIgOGvDREtn8P03EG549DmqdGdWx0CRvKQ5+B1LqpSssVHJLliKT0fzxvQ=
X-Received: by 2002:a25:8481:0:b0:bc6:3fbc:1180 with SMTP id
 v1-20020a258481000000b00bc63fbc1180mr208146ybk.41.1686390062528; Sat, 10 Jun
 2023 02:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <ZIO7U4A1rkIXlDeO@moria.home.lan>
In-Reply-To: <ZIO7U4A1rkIXlDeO@moria.home.lan>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 10 Jun 2023 11:40:50 +0200
Message-ID: <CANiq72mGmeuERPjJLE-=crpjrB3qav5fOJ_dxGe-oK_y6h+7-A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christian Brauner <brauner@kernel.org>,
        Ariel Miculas <amiculas@cisco.com>,
        linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-mm@kvack.org
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

On Sat, Jun 10, 2023 at 2:12=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> I'm of the opinion that Rust wrappers should generally live in the same
> directories as the code they're wrapping. The Rust wrappers are unsafe
> code that is intimately coupled with the C code they're creating safe
> interfaces for, and the organizational structure should reflect that.

+1, that is the plan, which also means `MAINTAINERS` does not need
extra `F` fields etc.

Cheers,
Miguel
