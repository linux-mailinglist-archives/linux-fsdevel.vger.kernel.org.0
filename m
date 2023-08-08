Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E068774459
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjHHSR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjHHSQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:53 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5631795BA;
        Tue,  8 Aug 2023 10:24:03 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56c8757d45bso3893638eaf.2;
        Tue, 08 Aug 2023 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691515442; x=1692120242;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydoHcaR3qJjLpJCuAxkO8+WkH13peeHQF52+Jhcd9Uk=;
        b=YfUg7ZQjJ6Yrr5NI1qwvSf+/2KGuJCwneosLI1dKkfmo5X+mo0e3b2klj2v9dEkm+h
         9Id72xB06SRDia4snQqWhxgvje7TQ6ANQNRdvVUd4XTQGD45iXMjIbfQ90qEBa0FGZ5V
         i7zwUauzHYT5+uy9v1/Zm0EVr7Um0CnTU4XsG5goTpvijq4sYM4pF1S/VcZcPOyyDnIp
         k0XPpnvDJlqOgVkxaTEdYip2EMi4VEzm5F9Im/94hkuzzZphAIQhNpZT+pP229xjx6YZ
         bLbIzHgh3sTnogp9VNrNif0KcSOxyBlckHTdrw4vwxoJITYUslkUH7P2EHGlHxsD8/S6
         fE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515442; x=1692120242;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydoHcaR3qJjLpJCuAxkO8+WkH13peeHQF52+Jhcd9Uk=;
        b=lVQwEEHQ95WMMxQw20/Ook1LBPVS4DxpulQrhdQrbb4B7JhM8steyXkwM6q1yH0epJ
         BfwnS4LMyWeBHWAVrBWMWQOcXl8LiVGROK/RM2AY6dSSva+mQQjIttUPLJv0H/FGg+/u
         A/r6pOG1HfPbEtYP1lvP13qYHw9kgmJgmo9cI7vJIf/5YpGkXQm6fhBkIiA+KickmvCQ
         c6fhN1TixQgUv3+TWXmLZdmQUwxaQyprVT2DvnGA3z+IXeQpaOoOwWV69bEFserX4Vzr
         dsItr1f+AP/q81JRpTQdE+JIZWldxOECN1ZLhdSwRwIh/U8wJJJCvzdBmQybcPrznvke
         Icpw==
X-Gm-Message-State: AOJu0YwcMT+DU4cLZrlP6A5qPbd5gfjECERc6mDLpdE/XiokmkeM+3/j
        Yl45+uNer25gVm6RTed0mEFACDQfp7DO+caoYWc=
X-Google-Smtp-Source: AGHT+IGujJKZVxfuBSumANHeQtD4AJazgpH0Y35rD479qEKO12ConAjCMLJIM8/YPQjtfSh9cedT45IFTBGhOu2o/c8=
X-Received: by 2002:a4a:3818:0:b0:56c:e856:8b2c with SMTP id
 c24-20020a4a3818000000b0056ce8568b2cmr478061ooa.9.1691515442300; Tue, 08 Aug
 2023 10:24:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:129a:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 10:24:01 -0700 (PDT)
In-Reply-To: <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
 <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com> <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 19:24:01 +0200
Message-ID: <CAGudoHE=jJ+MKduj9-95Nk8_F=fkv2P+akftvFw1fVr46jm8ng@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 8 Aug 2023 at 10:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> Few hours ago I sent another version which very closely resembles what
>> you did :)
>> 2 main differences:
>> - i somehow missed close_fd_get_file so I hacked my own based on close_fd
>> - you need to whack the kthread assert in __fput_sync
>
> Good call on teh __fput_sync() test.
>
> That BUG_ON() made sense ten years ago when this was all re-organized,
> not so much now.
>

Christian proposes a dedicated routine, I have 0 opinion, you guys
sort it out ;)

>> I'm offended you ask, it's all in my opening e-mail.
>
> Heh. I wasn't actually cc'd on that, so I'm going by context and then
> peeking at web links..
>

Here it is again with some typos fixed and slightly reworded, not
necessarily with quality of English improved. Feel free to quote in
whatever extent in your commit message (including none).

[quote]
fs: use __fput_sync in close(2)

close(2) is a special case which guarantees a shallow kernel stack,
making delegation to task_work machinery unnecessary. Said delegation is
problematic as it involves atomic ops and interrupt masking trips, none
of which are cheap on x86-64. Forcing close(2) to do it looks like an
oversight in the original work.

Moreover presence of CONFIG_RSEQ adds an additional overhead as fput()
-> task_work_add(..., TWA_RESUME) -> set_notify_resume() makes the
thread returning to userspace land in resume_user_mode_work(), where
rseq_handle_notify_resume takes a SMAP round-trip if rseq is enabled for
the thread (and it is by default with contemporary glibc).

Sample result when benchmarking open1_processes -t 1 from will-it-scale
(that's an open + close loop) + tmpfs on /tmp, running on the Sapphire
Rapid CPU (ops/s):
stock+RSEQ:     1329857
stock-RSEQ:     1421667 (+7%)
patched:        1523521 (+14.5% / +7%) (with / without rseq)

Patched result is the same regardless of rseq as the codepath is avoided.
[/quote]

-- 
Mateusz Guzik <mjguzik gmail.com>
