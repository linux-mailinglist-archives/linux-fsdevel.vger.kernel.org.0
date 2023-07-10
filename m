Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7999E74CF1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGJHxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjGJHxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:53:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FEE1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 00:53:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f86840c45dso3013e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688975591; x=1691567591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5oH0pdHc/AD7BbguQ+ExRoTK+qQ+GGDnFEytO7M0Ysg=;
        b=D/b8pVSiZ0dxeIVyTNBG/kXk5BuAoTTUhvLuB8mewl8H3Xq/H1raK18eutRDR3ZLTT
         2ntFe0SCXuQDGkNmx8Th/yZFBz0Ncgi5k9RMwVP0aunBHGTmrW5FZ73NsbdzUkqGQchO
         ZE0sp9JySeX+IHneqt8dYNTE6WVOy1bhCkl/jgtUsZlrtwspSztvrgG10dnPpnCeMdwk
         c4VyJCj2TzQA9E53yFqFX9N75F84D+cWSJ0cHypW2o1cvQ9LyYyHbYwxgVmrOBt2cNF8
         E0pUwaWqsTL2u7YJP7Wdw6p8bCfxlASGWqAZiJEXTkZhIGHlIP/W9hCY7ZazgPnXJH08
         o7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975591; x=1691567591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oH0pdHc/AD7BbguQ+ExRoTK+qQ+GGDnFEytO7M0Ysg=;
        b=LlxkK7HdpVgQQETZsjiRKqaNJhQbjIx4MgYBOkpqVv7wbjJGDbzApmIFnOhrBl626s
         xs4u7eQMu5OAzMeH77YjGUwcB/TcOn+UzZVP1OZNMnmG8K1WwO1wY9XxZR9a3/rVfWIH
         4u68rRPiDKVr9T56jFAkCq/XgPaIOoKKlsX7YBoTedXtkbT90A0XetzMkfn/8BO8M0eQ
         Qpyt2jhUTSKTpWcaMCXvVPcqJy4qintRQ8rg/Ge23Uug3Rtdb81gNTnkjZYn8l29xGPE
         Wz9HBATi96mptP8wdCPXUz3LM2lwMqnWgdOLG8pvxjMkVo6yLSxd04nnaN9wPc6NGNZd
         JcEA==
X-Gm-Message-State: ABy/qLYxvAbEHd7+piy3B9yr9Ocva3aqjpYMNBfVzm1iDOfmFS2r1+qd
        sDaNRRWY9QInS9RshEyiEfGhCFYkKW8Z1g94KISk2Q==
X-Google-Smtp-Source: APBJJlGc3lYZALIVe3sVT2b3SJUhc20g3H9PeZrAu3bfJGvs01tzOAQx7gJxAJeiFaeg642Dynrv6K6m+7JlQWZYv/A=
X-Received: by 2002:ac2:42c2:0:b0:4f7:5f7d:2f9b with SMTP id
 n2-20020ac242c2000000b004f75f7d2f9bmr51935lfl.1.1688975590656; Mon, 10 Jul
 2023 00:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002373f005ff843b58@google.com> <1bb83e9d-6d7e-3c80-12f6-847bf2dc865e@google.com>
 <CACT4Y+akPvTGG0WdPdSuUFU6ZuQkRbVZByiROzqwyPVd8Pz8fQ@mail.gmail.com>
 <61032955-4200-662b-ace8-bad47d337cdc@os.amperecomputing.com>
 <CACT4Y+YAyK02ORyzS79ub+XOK6x5LV8_2k4aztwzjP=0dm--RQ@mail.gmail.com> <81008a82-1012-0b3e-134d-cd4a6502482c@suse.cz>
In-Reply-To: <81008a82-1012-0b3e-134d-cd4a6502482c@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Jul 2023 09:52:58 +0200
Message-ID: <CACT4Y+YKhrpWJcngv3ux_gKeFOY2DEGK9qBJ4RZs-QdPr8Embg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [reiserfs?] kernel panic: stack is corrupted in ___slab_alloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Lameter, Christopher" <cl@os.amperecomputing.com>,
        David Rientjes <rientjes@google.com>,
        syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>,
        42.hyeyoo@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, reiserfs-devel@vger.kernel.org,
        roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 10 Jul 2023 at 09:48, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 7/10/23 09:43, Dmitry Vyukov wrote:
> > On Thu, 6 Jul 2023 at 20:33, Lameter, Christopher
> > <cl@os.amperecomputing.com> wrote:
> >>
> >> On Mon, 3 Jul 2023, Dmitry Vyukov wrote:
> >>
> >> >> This is happening during while mounting reiserfs, so I'm inclined to think
> >> >> it's more of a reisterfs issue than a slab allocator issue :/
> >>
> >> Have you tried to run with the "slub_debug" kernel option to figure out
> >> what got corrupted?
> >
> > Can slub_debug detect anything that KASAN can't?
>
> Probably not, KASAN will find out a bad write at the moment it happens,
> while slub_debug only later from corrupted red zone/poison.
>
> > I would assume KASAN can detect more bugs (e.g. stack/globals) and
> > report way better. And it was already enabled in the config.
>
> Anyway this is a stack corruption, not slab layout corruption. It's probably
> hard to distinguish a legitimate stack write from an overrun so even KASAN
> could not catch it immediately?

KASAN can detect stack out-of-bounds writes.
However, use-after-return detection support was never implemented in
KASAN (user-space ASAN can detect them as well).
User-space MSAN can also detect use-after-scope, I think it's not
implemented in KMSAN as well.

If we ever get to the root cause of this bug, it may be useful to
analyze why it wasn't detected and if it's possible to make such bugs
detected.
