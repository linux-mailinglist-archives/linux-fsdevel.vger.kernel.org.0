Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4A723352
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjFEWrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFEWri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:47:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E64D9;
        Mon,  5 Jun 2023 15:47:37 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso47890381fa.1;
        Mon, 05 Jun 2023 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686005255; x=1688597255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGJG2pCEIUm9YqDZ9+cFvHMaWccaFKhhWqGrHEjRVmE=;
        b=XzfbknodFCv1Jz9zuCJcSVldVJ9ctD2/5GJ6ZhO6SvbzTF/uQgxxR3d9z9Y5Hm09rU
         14agbKYtIk+WeIEg+J+Ow4DQXbqIPtuTbNwYk293tNEu4eTUHdDfy8TJeBBUEBdwthzm
         4YcVCHsg9UlFG6dmAEYgPjAiM84qXRbSrcFhHk6aIdluZ2ZWdKdI8icd6SfA3TCyTWfZ
         EwPS/NrueptFEPdF0eLPO539vkL91PEmUPMMRX9FoW9gYj7Q2E6vY1d7RDZfiEmCMJHj
         qWRKfN4glX90Rknv59Px1Fp5oSXEWP43bg5G2aoxwLjmL7ZKnb2Ym1KQGPHoqFp4MKFm
         qRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005255; x=1688597255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGJG2pCEIUm9YqDZ9+cFvHMaWccaFKhhWqGrHEjRVmE=;
        b=KEnwk4LZCnlna1RG0NGMw0jKs1puQI25D36La2ULWV5lgBp+mHzlbIoMLWhd/jcyMa
         oLziVY7qNY3teITHMCnX6mtvOBvVI+23jt/qyXZYGFMAZtWkUHMqWRzKgYLAJhYh3R1E
         QpPjQcvp1VR291iQF3mYbZAEMlUvnlH/r8qWrlhRRu3fbU8AhwDEjEWp0HMUk910K+kB
         BdETV2tdc5EkZrHPrvDDaW/lrj4umaTkX5U+UyFV78NwmE1Fbi6TV1zZddQYIfpNcCDz
         1NYegIlV70ANN5aP3bQKCc6SFmUABoAc660IqOsK8CZSsKNzSKbeTffZX5Pcipj0RkVz
         Ow4w==
X-Gm-Message-State: AC+VfDxUqdyr5jlWB8Jmhel15h7cd+0cXzqI74jcZjVuzBDSVfT2iLvm
        oOBDFgwUmRoyWsz4tVfmizlEXYCUac210r7j/Y4=
X-Google-Smtp-Source: ACHHUZ64xxACM+x9gJrkZTFGhhgxU4xXzPh/kuz9AIqmLB4+41h+KE2m30gvhPyTDJjoFz8h5WW1qxblFFEKelWjNTw=
X-Received: by 2002:a2e:9d5a:0:b0:2af:1262:e918 with SMTP id
 y26-20020a2e9d5a000000b002af1262e918mr298065ljj.36.1686005255092; Mon, 05 Jun
 2023 15:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230509132433.2FSY_6t7@linutronix.de> <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de> <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de> <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
In-Reply-To: <20230605163733.LD-UCcso@linutronix.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 5 Jun 2023 15:47:23 -0700
Message-ID: <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: Remove in_atomic() from bpf_link_put().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
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

On Mon, Jun 5, 2023 at 9:37=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-05-31 12:00:56 [-0700], Andrii Nakryiko wrote:
> > > On 2023-05-25 10:51:23 [-0700], Andrii Nakryiko wrote:
> > > v2=E2=80=A6v3:
> > >   - Drop bpf_link_put_direct(). Let bpf_link_put() do the direct free
> > >     and add bpf_link_put_from_atomic() to do the delayed free via the
> > >     worker.
> >
> > This seems like an unsafe "default put" choice. I think it makes more
> > sense to have bpf_link_put() do a safe scheduled put, and then having
> > a separate bpf_link_put_direct() for those special cases where we care
> > the most (in kernel/bpf/inode.c and kernel/bpf/syscall.c).
>
> I audited them and ended up with them all being safe except for the one
> from inode.c. I can reverse the logic if you want.

I understand it's safe today, but I'm more worried for future places
that will do bpf_link_put(). Given it's only close() and BPF FS
unlink() that require synchronous semantics, I think it's fine to make
bpf_link_put() to be async, and have bpf_link_put_sync() (or direct,
or whatever suffix) as a conscious special case.

>
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9948b542a470e..2e1e9f3c7f701 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -59,7 +59,10 @@ static void bpf_any_put(void *raw, enum bpf_type t=
ype)
> > >                 bpf_map_put_with_uref(raw);
> > >                 break;
> > >         case BPF_TYPE_LINK:
> > > -               bpf_link_put(raw);
> > > +               if (may_sleep)
> > > +                       bpf_link_put(raw);
> > > +               else
> > > +                       bpf_link_put_from_atomic(raw);
> >
> > Do we need to do this in two different ways here? The only situation
> > that has may_sleep=3Dfalse is when called from superblock->free_inode.
> > According to documentation:
> >
> >   Freeing memory in the callback is fine; doing
> >   more than that is possible, but requires a lot of care and is best
> >   avoided.
> >
> > So it feels like cleaning up link should be safe to do from this
> > context as well? I've cc'ed linux-fsdevel@, hopefully they can advise.
>
> This is invoked from the RCU callback (which is usually softirq):
>         destroy_inode()
>          -> call_rcu(&inode->i_rcu, i_callback);
>
> Freeing memory is fine but there is a mutex that is held in the process.

I think it should be fine for BPF link destruction then?

>
> Sebastian
