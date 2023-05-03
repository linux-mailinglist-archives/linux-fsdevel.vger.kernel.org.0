Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052796F5FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjECUEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjECUEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:04:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE78699;
        Wed,  3 May 2023 13:04:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f19ab99540so55288575e9.2;
        Wed, 03 May 2023 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683144272; x=1685736272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHU5powRCH79ePrW9PLsNOR73hzLy7pF/AR2cVrEP7A=;
        b=X9cvzf7QfWfANWyiwaBoFAaHPlX2qeqZu2VCK9dHuW20oD3qDZADVWlb+BtBIBdSiO
         2RDzvFggR0cV7IyIeCqHDf9vzAIbh3l8EKnAha85GOqZ/85Z2kV5iHi0HZA5hxN3WCiL
         NDBgwTKeSBh1uBp9ZRn5IcKnZwjB9Xw2FNCu3VPxcgaMe8gKOK7zMR3TIQzUlk13qk0g
         Oy/vqaLM0dX473ikdNYh4d6O6S61SceyugQ5rTKI7IbtLax4XorLUr0QhjWGkIK6Mm8g
         jmi9mu20BH7ourolp1eZoSnL7KPbf6yac3FZz/qPtTH6UuXviA7A9ThzGyGaLUXBvIEp
         nt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144272; x=1685736272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHU5powRCH79ePrW9PLsNOR73hzLy7pF/AR2cVrEP7A=;
        b=aLWXrWQUmDin3LuK3GiSSJw2j1tX7DwrLPhVyWP5AC8MIExcBUBxzSmK7LfMjF9QuA
         UQaa3zBWAbg/J/69kR77ueeBTYFkEWx/RbHWi9UFXhwOCKwWuwFKu0Xrh5BP4ubHqgsi
         d1LP/cSRxXzA5oLwKPhx0kDfkWg9V3Tnegk2GvJVfTgj55+RL1M2eEF5p6HGqmqBriZX
         H2ptovzKmzQQq8oJN2PfI9LIhyEeijcO/9z8NqWbxFy7ZYboP6RLlcVAvyY5VAupZOrO
         r2uWXXtqkj4x+/2hGp1aGueIo15SfAGTxBZcuSQUuNkB1S18MzLpBwd3MGpvzd6rcI3F
         HtEg==
X-Gm-Message-State: AC+VfDyadrRKTNbmBDNvy+M5BelPLUC+dDmcEEAcalS9AjWzfDc3MKqQ
        nMo60JuWyXbiCKnIlmcwqgpjD9NDOorhp9NkyTE=
X-Google-Smtp-Source: ACHHUZ7zpuOeQ2HlbzadDjdNCOqFD0VigwxXNnk7+zHC8ZwW/zidgTFIwlyp+cl7LdT9bLB6cLchW8xym2AySZY+Hm8=
X-Received: by 2002:a5d:5222:0:b0:2fa:27ef:93d7 with SMTP id
 i2-20020a5d5222000000b002fa27ef93d7mr907489wra.42.1683144272448; Wed, 03 May
 2023 13:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan> <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan> <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
In-Reply-To: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date:   Wed, 3 May 2023 22:04:21 +0200
Message-ID: <CAPAsAGxcCJai6PpTVOkqAB-vG+Q71hb1exsK79hJ7Kb2eKAtjA@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Tejun Heo <tj@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
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

On Wed, May 3, 2023 at 6:35=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Kent.
>
> On Wed, May 03, 2023 at 04:05:08AM -0400, Kent Overstreet wrote:
> > No, we're still waiting on the tracing people to _demonstrate_, not
> > claim, that this is at all possible in a comparable way with tracing.
>
> So, we (meta) happen to do stuff like this all the time in the fleet to h=
unt
> down tricky persistent problems like memory leaks, ref leaks, what-have-y=
ou.
> In recent kernels, with kprobe and BPF, our ability to debug these sorts =
of
> problems has improved a great deal. Below, I'm attaching a bcc script I u=
sed
> to hunt down, IIRC, a double vfree. It's not exactly for a leak but leaks
> can follow the same pattern.
>

For leaks there is example bcc
https://github.com/iovisor/bcc/blob/master/tools/memleak.py
