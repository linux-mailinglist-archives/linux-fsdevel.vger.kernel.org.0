Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609947743C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjHHSJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjHHSJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:09:13 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3C1B507;
        Tue,  8 Aug 2023 10:10:57 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56c7eb17945so3588016eaf.2;
        Tue, 08 Aug 2023 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514657; x=1692119457;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntk3/pU/XJMzS2h81xC2orLUcyApO86v8jUmF70Ge4U=;
        b=gqVysKwKHQRNbh4Q96VSTPc1A88VlWPkaDnUrpksT7DYjAAieWolVlbUX+8E1gtviz
         aX1WYcFOrUBi/s+qKPJO55HXLwH6UFTNHov6RYWzydJKFrcJs3okorg41s7Cjv0saFA5
         xER8+8t9skWcw4oKEyj+194NpEeyep65SX88/nlF2JOdAN1NlIO5r8iBV2rWna+YBpRv
         e5N9ATzXZArPSKuK3Ck8dWTab8xld5Or5KjJfIC/IoT9nbRWvLA0S5xypA03HN8qLkLN
         5WHNeBdBz25wd3m/Rl5MZZ4NIbVNOkjp888wXOF8xuFcWVBPureS/3N7Ptbu/YK2f/Jb
         LmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514657; x=1692119457;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ntk3/pU/XJMzS2h81xC2orLUcyApO86v8jUmF70Ge4U=;
        b=U6Vavt8b5DtqkVp3IfD65n8uACQwnnK/i015VU6f47lrCUMehsjyDwXVU4AZ4cBXwZ
         yEJfkVy6iuwDvSLx55U8gPqKi2RnOyYijBeB6ImmtOHRglSfG3fWPVCmIQP++tgHkXqB
         I1vvHsJDeaiYRAzesgscSos5aRq/PnpQHIFaFde1sRImbo+2bc2/3CKrulyhpmTq6Vv0
         enfe+Op7yVQPRlC59NdCiwQA/w1ljyVx46qDuxJbSns957zq/4wUAg7kFmQb4KJhPqK+
         DhIOK/pEyMICbFcPPPp8SeW8CFjxOHK72JWwpGTfhlc597XFhA5JHr4Efp4LNTH1OIvL
         Gtcw==
X-Gm-Message-State: AOJu0YwrlNgIRtbMZzyWG0J0MmO6QdV0WZqI8KRqBzIaJc1oS4AxAFup
        fAfMASLNpDzMcF20kwkb5oiajxsaZv1e0EvSfd8=
X-Google-Smtp-Source: AGHT+IH1BvGy3Orja3V6gvGPVu7NP3PuDSxBl3MHlPzbjU/1OP6KAge9xPmROyP+EGt/MFJvnaQLVV51ZlC2mIY8K2A=
X-Received: by 2002:a4a:300d:0:b0:566:f763:8fb7 with SMTP id
 q13-20020a4a300d000000b00566f7638fb7mr565662oof.2.1691514656770; Tue, 08 Aug
 2023 10:10:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:129a:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 10:10:56 -0700 (PDT)
In-Reply-To: <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 19:10:56 +0200
Message-ID: <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
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
> That said, I detest Mateusz' patch. I hate these kinds of "do
> different things based on flags" interfaces. Particularly when it
> spreads out like this.

I agree it is kind of crap, I needed something to test the impact.

> But even if we want to do this - and I have absolutely no objections
> to it conceptually as per above - we need to be a lot more surgical
> about it, and not pass stupid flags around.
>
> Here's a TOTALLY UNTESTED(!) patch that I think effectively does what
> Mateusz wants done, but does it all within just fs/open.c and only for
> the obvious context of the close() system call itself.
>
> All it needs is to just split out the "flush" part from filp_close(),
> and we already had all the other infrastructure for this operation.
>

Few hours ago I sent another version which very closely resembles what
you did :)
2 main differences:
- i somehow missed close_fd_get_file so I hacked my own based on close_fd
- you need to whack the kthread assert in __fput_sync

> Mateusz, two questions:
>
>  (a) does this patch work for you?
>

Well I'm not *testing* patch right now, but it does work for me in the
sense of taking care of the problem (modulo whatever fixups,
definitely the assert thing)

>  (b) do you have numbers for this all?
>

I'm offended you ask, it's all in my opening e-mail.

Copy pasting again from the commit message:
[orig]
fs: use __fput_sync in close(2)

close(2) is a special close which guarantees shallow kernel stack,
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
(that's a open + close loop) + tmpfs on /tmp, running on the Sapphire
Rapid CPU (ops/s):
stock+RSEQ:	1329857
stock-RSEQ:	1421667	(+7%)
patched:	1523521 (+14.5% / +7%) (with / without rseq)

Patched result is the same as it dodges rseq.
[/orig]

Since modulo fixups your patch clearly elides all of this, I don't
think there is a need to re-bench (but I can do it if you ship me a
version you consider committable just to be on the safe side)

-- 
Mateusz Guzik <mjguzik gmail.com>
