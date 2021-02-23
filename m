Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED4E32302B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhBWSCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:02:45 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43015 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhBWSCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:02:42 -0500
Received: by mail-oi1-f180.google.com with SMTP id d20so18498565oiw.10;
        Tue, 23 Feb 2021 10:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hr05fO8KOjmWsbPm+ZFI7vyJ8Gmfr+uEbMgTqe1usGE=;
        b=sgeARuG4O56RZbMJgK6quqS4YwrKQsNKFyWkUYKtYIFhIJ/HZot1uYUfkkOcFoLFXh
         fK8Gp1QY1yhyUxMZFSDAmSRIyBpLcDQJzC/Tee0+AhzsNCll3Z6FPfozHeoULfeDGuwe
         fJ1bWASS4UEZ+N7nxDVAOz4S7w8z0ydykN90fMI4oPLBNVAum1K02UkBfqFhJCMbvUpJ
         6aJBUSmFfkO71ED01NLQRAo/vZ3WwQLyhCNnNG/MPCj8of9F0OctpCR9VepJzqv9CBNj
         6pJl0T1jWBa7CZNa/cc0C94SfJETqGecYy14sYDYjt+fICjw0505UYnPSx2XJKvaidxw
         Dw2Q==
X-Gm-Message-State: AOAM532PKzIrJxrd1doko6e9oAaU+YxMDpldtSY8tlM5X5wsrMxOKLHk
        exfuCP21f7Fh2L1Vg7201EbUf17rGcCzMb7EcQY=
X-Google-Smtp-Source: ABdhPJwrwpFr2FQwQpfeP6BA1gpGIIYhMdOoi69PRSdY4DWGPHU2qkE9Uf2//SENA34d4VSlTfbxzpMseSX7CraCA+8=
X-Received: by 2002:aca:744:: with SMTP id 65mr19161636oih.153.1614103320874;
 Tue, 23 Feb 2021 10:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-3-elver@google.com>
In-Reply-To: <20210223143426.2412737-3-elver@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Feb 2021 19:01:49 +0100
Message-ID: <CAMuHMdXVZ+UvNgoaNC-ZZoiuJ=DOsZs4oZzd8DubA7D+4iLCow@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] signal: Introduce TRAP_PERF si_code and si_perf
 to siginfo
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        mascasa@google.com, Peter Collingbourne <pcc@google.com>,
        irogers@google.com, kasan-dev@googlegroups.com,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 3:52 PM Marco Elver <elver@google.com> wrote:
> Introduces the TRAP_PERF si_code, and associated siginfo_t field
> si_perf. These will be used by the perf event subsystem to send signals
> (if requested) to the task where an event occurred.
>
> Signed-off-by: Marco Elver <elver@google.com>

>  arch/m68k/kernel/signal.c          |  3 +++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
