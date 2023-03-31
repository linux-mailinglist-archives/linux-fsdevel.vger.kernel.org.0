Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F176D27AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjCaSUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 14:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCaSUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:20:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D449CD;
        Fri, 31 Mar 2023 11:19:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so93152982edb.6;
        Fri, 31 Mar 2023 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680286797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptCDsCZ9M1AP2auqMhwxD2e0Wct9w+HUGpQl1ZXGBuE=;
        b=Gw584kuBZB4NgIUzfMojlADjttI/sZS9NQ+lUHsKb0GpFWzrCiX5KxgPEM6YM3wfKb
         L7qyK+P8fd+4VG+CXmujXlxC7BXlewyQ8+k2Te9ebzk+rMzpahTWnav1kHCwZ0u4nDMK
         qSYzdA+/2PNTicJltJMZRFMjFud3XUTM6iTecSpNvUfmcC4NBDmoiTEsW6VNG4voh0Pl
         Dd3fimhzfdzOlXUg1Eycw8horsLfQpEwQdTlxhLhd1mTanssQvPjrFvkfEsYOGyq/O+I
         O9I5u9eAGOgFNajpeowt/EpJIH9cYLLO3sQlQulNKMqZZ9G9hP2k4+Rc4AmRLMzBFnll
         /QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptCDsCZ9M1AP2auqMhwxD2e0Wct9w+HUGpQl1ZXGBuE=;
        b=jCSBCXIgL9Z7jCOL+IrNjMh758tclOOq7YbFS2e0VQCIo9OgvfpMjyNFxbIdAZqOrH
         Aq2yG2FiAKm7dkV7N/lLYy3cg+7qH9W1mdIMuE2Yra8d/89yH9UgIKxAikL5VDNijpTd
         r4mTgPIFfyZKjX1ObirgAhmsTTToKGBb7IBnbY52kYgP02TTbbvi/IFn1MnzTvB2RNaj
         dFyDj8NpED4wnh3mz0AT/CyBYGmz+FXiF1UjfZ+I+zyoZVhK/DdusjohaXmuh6mvJ61P
         S6NwpDd1d7wPQbSi0uUvbw0IjJ+iXYxRHH7Ngl5bKd3FnvGHq6jw/fQmHgsc/uk1BsyY
         6rsA==
X-Gm-Message-State: AAQBX9dUGj5lfghSVmNDTzUVVushyj7o6Hwh/PU18TtK5KJJpPJl4rSS
        +cSQGFPXjsUJ92G7clq/5IWRBv9FGjU+QSosiFtoYRHR
X-Google-Smtp-Source: AKy350Yj+IgRzl/cUwZ8ZsG3CzqlZxtGxVHdl50ppqglRAoEyoUXrbm8X7qBqemI62LpK7yLYFn/NsSgTus1uzv5ngw=
X-Received: by 2002:a50:d694:0:b0:4fc:f0b8:7da0 with SMTP id
 r20-20020a50d694000000b004fcf0b87da0mr14424020edi.1.1680286797322; Fri, 31
 Mar 2023 11:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <ZBV3beyxYhKv/kMp@krava> <ZBXV3crf/wX5D9lo@casper.infradead.org> <ZBsihOYrMCILT2cI@kernel.org>
In-Reply-To: <ZBsihOYrMCILT2cI@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 31 Mar 2023 11:19:45 -0700
Message-ID: <CAEf4BzakHh3qm2JBsWE8qnMmZMeM7w5vZGneKAsLM_vktPbc9g@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 8:45=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Mar 18, 2023 at 03:16:45PM +0000, Matthew Wilcox escreveu:
> > On Sat, Mar 18, 2023 at 09:33:49AM +0100, Jiri Olsa wrote:
> > > On Thu, Mar 16, 2023 at 05:34:41PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > > > > hi,
> > > > > this patchset adds build id object pointer to struct file object.
> > > > >
> > > > > We have several use cases for build id to be used in BPF programs
> > > > > [2][3].
> > > >
> > > > Yes, you have use cases, but you never answered the question I aske=
d:
> > > >
> > > > Is this going to be enabled by every distro kernel, or is it for sp=
ecial
> > > > use-cases where only people doing a very specialised thing who are
> > > > willing to build their own kernels will use it?
> > >
> > > I hope so, but I guess only time tell.. given the response by Ian and=
 Andrii
> > > there are 3 big users already
> >
> > So the whole "There's a config option to turn it off" shtick is just a
> > fig-leaf.  I won't ever see it turned off.  You're imposing the cost of
> > this on EVERYONE who runs a distro kernel.  And almost nobody will see
> > any benefits from it.  Thanks for admitting that.
>
> I agree that build-ids are not useful for all 'struct file' uses, just
> for executable files and for people wanting to have better observability
> capabilities.
>
> Having said that, it seems there will be no extra memory overhead at
> least for a fedora:36 x86_64 kernel:
>
> void __init files_init(void)
> {
>         filp_cachep =3D kmem_cache_create("filp", sizeof(struct file), 0,
>                         SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, N=
ULL);
>         percpu_counter_init(&nr_files, 0, GFP_KERNEL);
> }
>
> [root@quaco ~]# pahole file | grep size: -A2
>         /* size: 232, cachelines: 4, members: 20 */
>         /* sum members: 228, holes: 1, sum holes: 4 */
>         /* last cacheline: 40 bytes */
> [acme@quaco perf-tools]$ uname -a
> Linux quaco 6.1.11-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Feb  9 20:3=
6:30 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]# head -2 /proc/slabinfo
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesp=
erslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_s=
labs> <num_slabs> <sharedavail>
> [root@quaco ~]# grep -w filp /proc/slabinfo
> filp               12452  13056    256   32    2 : tunables    0    0    =
0 : slabdata    408    408      0
> [root@quaco ~]#
>
> so there are 24 bytes on the 4th cacheline that are not being used,
> right?

Well, even better then!

>
> One other observation is that maybe we could do it as the 'struct sock'
> hierachy in networking, where we would have a 'struct exec_file' that
> would be:
>
>         struct exec_file {
>                 struct file file;
>                 char build_id[20];
>         }
>
> say, and then when we create the 'struct file' in __alloc_file() we
> could check some bit in 'flags' like Al Viro suggested and pick a
> different slab than 'filp_cachep', that has that extra space for the
> build_id (and whatever else exec related state we may end up wanting, if
> ever).
>
> No core fs will need to know about that except when we go free it, to
> free from the right slab cache.
>
> In current distro configs, no overhead would take place if I read that
> SLAB_HWCACHE_ALIGN thing right, no?

Makes sense to me as well. Whatever the solution, as long as it's
usable from NMI contexts would be fine for the purposes of fetching
build ID. It would be good to hear from folks that are opposing adding
a pointer field to struct file whether they prefer this way instead?

>
> - Arnaldo
