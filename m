Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11863536E66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiE1UjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiE1UjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 16:39:03 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971846654
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 May 2022 13:39:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b4so7931670iog.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 May 2022 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=U5fkrdm6TsaFizLH62ybW2z40y4ZwknSKbuYY8GwZpQ=;
        b=F3dfbFTN3D6TC6t5jaoEGJXOHBO1yWTAwRj9d38Yy16EmFsaoBcanwLTY35RyhkiXl
         L4DSVeQF9HMGGXbS++BztgStJhSK1eL51tx4tW7nPDuvFb/HMnHWfs8jFd3jfOQzmnKv
         NQBZJ7sFClEF9dY0MWMZ4JECH6+vQPW5wQ6difWfC3ue3CpmsxacOAb7MZM6IwvWvzg6
         i7SSjg8gz9KbHsDkxwquMrUThXoF7y9Z5bC3NgLXWh/7EFRM4rHOa+yDb4CqxEq3f2kc
         FTF3bEzgrGSQnMnIjZUzHxcGO/MhEAeJWVCZ7Ttp9SBd4ZxkEaFkvGxxSuNZWH7uCITB
         94dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=U5fkrdm6TsaFizLH62ybW2z40y4ZwknSKbuYY8GwZpQ=;
        b=Yw51bh/PIZJpixTE0i3+cNFwlD5PcS4VlmC4ErIVpQBpOwRXOPuvRb8cJH8YOqKr79
         XAKvu+1BJwwkpBiaSKRUQ4RvPAQldWAEDXVG0tKJH96oUhug9MlW21mliRIvmjbrVEtB
         9voqZzlAVvCUwoLKeRSA4XZ6xG9RDM/54bYL49nKLkmXVv875BOIOChX6MmZi4NGtq97
         ge6qXtspwQJUKoPhKvgLfSEjfMx+tnOY+/m+5ElYFJ6QvSiSwl38ujSJaCBx/aQpFzp+
         rOBPNTMaT8XyYlUzIf0OENgarlr1ie6QxFcmrF0ZoyBAbhnB2su5p10NHe+s7dgw2ylw
         JZyA==
X-Gm-Message-State: AOAM5313RcZSamfR87SUb3Cl4CNcKz06LWuwiEDGnsqc+AmJ7b1xvZ4t
        Q63bnOuRnnCFI/a8KPtKVq7MzOKKLQGN1ifYG9g=
X-Google-Smtp-Source: ABdhPJyHLfFryuMBfn0PsUswsDRs4m6MwqcJsoHXMhOlzEZ2PIBDzhxkc0c28KpOWqewV7cB48GWResyr2+k2AlyLyI=
X-Received: by 2002:a05:6638:2404:b0:331:48f:bac0 with SMTP id
 z4-20020a056638240400b00331048fbac0mr2385666jat.306.1653770341612; Sat, 28
 May 2022 13:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk> <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk> <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk> <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk> <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
 <Yo+S4JtT6fjwO5GL@zx2c4.com> <YpCjaL9QuuCB23A5@gmail.com> <YpCnMaT823RM3qU5@gmail.com>
In-Reply-To: <YpCnMaT823RM3qU5@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 28 May 2022 22:38:25 +0200
Message-ID: <CA+icZUWf4ww4gXRxnR9P4FTK4ZiAgANQgh+QDK2sAzJx+C4LGQ@mail.gmail.com>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>
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

On Sat, May 28, 2022 at 9:57 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > > On Mon, May 23, 2022 at 10:03:45AM -0600, Jens Axboe wrote:
> > > > clear_user()
> > > > 32        ~96MB/sec
> > > > 64        195MB/sec
> > > > 128       386MB/sec
> > > > 1k        2.7GB/sec
> > > > 4k        7.8GB/sec
> > > > 16k       14.8GB/sec
> > > >
> > > > copy_from_zero_page()
> > > > 32        ~96MB/sec
> > > > 64        193MB/sec
> > > > 128       383MB/sec
> > > > 1k        2.9GB/sec
> > > > 4k        9.8GB/sec
> > > > 16k       21.8GB/sec
> > >
> > > Just FYI, on x86, Samuel Neves proposed some nice clear_user()
> > > performance improvements that were forgotten about:
> > >
> > > https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt=
/
> > > https://lore.kernel.org/lkml/Yk9yBcj78mpXOOLL@zx2c4.com/
> > >
> > > Hoping somebody picks this up at some point...
> >
> > Those ~2x speedup numbers are indeed looking very nice:
> >
> > | After this patch, on a Skylake CPU, these are the
> > | before/after figures:
> > |
> > | $ dd if=3D/dev/zero of=3D/dev/null bs=3D1024k status=3Dprogress
> > | 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s
> > |
> > | $ dd if=3D/dev/zero of=3D/dev/null bs=3D1024k status=3Dprogress
> > | 446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s
> >
> > Patch fell through the cracks & it doesn't apply anymore:
> >
> >   checking file arch/x86/lib/usercopy_64.c
> >   Hunk #2 FAILED at 17.
> >   1 out of 2 hunks FAILED
> >
> > Would be nice to re-send it.
>
> Turns out Boris just sent a competing optimization to clear_user() 3 days=
 ago:
>
>   https://lore.kernel.org/r/YozQZMyQ0NDdD8cH@zn.tnic
>
> Thanks,
>

[ CC Hugh ]

I hope I adapted both patches from Hugh and Samuel against Linux v5.18
correctly.

As I have no "modern CPU" meaning Intel Sandy-Bridge, the patch of
Hugh was not predestined for me (see numbers).

Samuel's patch gave me 15% of speedup with running Hugh's dd test-case
(cannot say if this is a real benchmark for testing).

Patches and latest linux-config attached.

*** Without patch

root# cat /proc/version
Linux version 5.18.0-3-amd64-clang14-lto (sedat.dilek@gmail.com@iniza)
(dileks clang version 14.0.4 (https://github.com/llvm/llvm-project.git
29f1039a7285a5c3a9c353d05
4140bf2556d4c4d), LLD 14.0.4) #3~bookworm+dileks1 SMP PREEMPT_DYNAMIC 2022-=
05-27

root# dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D1M
1048576+0 Datens=C3=A4tze ein
1048576+0 Datens=C3=A4tze aus
1099511627776 Bytes (1,1 TB, 1,0 TiB) kopiert, 97,18 s, 11,3 GB/s

*** With hughd patch

Patch: 0001-x86-usercopy-Use-alternatives-for-clear_user.patch
Link: https://lore.kernel.org/lkml/2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@goo=
gle.com/

root# cat /proc/version
Linux version 5.18.0-4-amd64-clang14-lto (sedat.dilek@gmail.com@iniza)
(dileks clang version 14.0.4 (https://github.com/llvm/llvm-project.git
29f1039a7285a5c3a9c35>

root# dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D1M
1048576+0 Datens=C3=A4tze ein
1048576+0 Datens=C3=A4tze aus
1099511627776 Bytes (1,1 TB, 1,0 TiB) kopiert, 588,053 s, 1,9 GB/s

root# cat /proc/version
Linux version 5.18.0-4-amd64-clang14-lto (sedat.dilek@gmail.com@iniza)
(dileks clang version 14.0.4 (https://github.com/llvm/llvm-project.git
29f1039a7285a5c3a9c353d05
4140bf2556d4c4d), LLD 14.0.4) #4~bookworm+dileks1 SMP PREEMPT_DYNAMIC 2022-=
05-28

*** With sneves patch

Patch: 0001-x86-usercopy-speed-up-64-bit-__clear_user-with-stos-.patch
Link: https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt=
/

root# cat /proc/version
Linux version 5.18.0-5-amd64-clang14-lto (sedat.dilek@gmail.com@iniza)
(dileks clang version 14.0.4 (https://github.com/llvm/llvm-project.git
29f1039a7285a5c3a9c353d05
4140bf2556d4c4d), LLD 14.0.4) #5~bookworm+dileks1 SMP PREEMPT_DYNAMIC 2022-=
05-28

root# dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D1M
1048576+0 Datens=C3=A4tze ein
1048576+0 Datens=C3=A4tze aus
1099511627776 Bytes (1,1 TB, 1,0 TiB) kopiert, 82,697 s, 13,3 GB/s


-dileks // 28-May-2022
