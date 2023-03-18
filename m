Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4B6BF845
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 07:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCRGJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCRGJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 02:09:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489F3B664;
        Fri, 17 Mar 2023 23:08:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so28161216edo.2;
        Fri, 17 Mar 2023 23:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679119738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV6D6PWuyY+pzJCeIR0JhzUrH+GgDghjB9uU7AntUqA=;
        b=ohCbefDAyCpU7VGBYqZpzJHtlEkbOY7Acj9MBcGEFIKZQ02InFEathyokeRbr/+LRi
         5OaU4RFGmzKS4u7JBelbcT1IDEaXUuEjStkFDpvE45mo2RD1IUSwzC974CU2MgIGXnkI
         g643/nyEUBUMu0xbJDTEJAUR9Syt+GIoMIYgaWga7pFQzMb4AALVIKcH1d+GVExOoZI5
         /jdWvi8OKRx5/UJNVM8SBBJLg2oqE5HHWAS70YjOskmsToTtt2yzbeG7Djhfjm7XlIyk
         qABY68h9/bSktn/pRHowHwANI2c2+bSCdHgZMJa/jupIa6QCDgMnP2IndATSAsbk3CN9
         3Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679119738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV6D6PWuyY+pzJCeIR0JhzUrH+GgDghjB9uU7AntUqA=;
        b=YRMX72YZBCOo+q0UY+4owasXSqitlBxmAKMIljc6TkJOHX+Eu/8hFcIt2/jkVLoPg2
         WMeFNLwrVUfWCK5N0ORSWlhwNkY2jTKhzxt9O8iGnOOEaA4HQ4/7q5i/gc38iB5LdYfP
         otSrwGL+aCwwa9E3SJer7S70jUhPOVvu1lBBt9XNOG7yXLDHeDBhfYTReOW3drE1dTja
         BXnhgfih+7eBE0ZK1AdYjDdtbn87oD4ona3xJfZPYGmt++ila7ol/ZIxMabv6AradPta
         3i9ArrT5OotD7AbWJFbYT0tYpbFD3AVTzV450KzsqUX/BhqCLGPWt45TN5JqiNsXlaFR
         68hA==
X-Gm-Message-State: AO0yUKXgASohUg1A8Tz7HoNJ/BXkasfXOvxzt51q88pOTii5EZhzwn0Q
        SeUeb/i6yI+cKbHafiqml+KCUCVh9SdAKUwbB0E=
X-Google-Smtp-Source: AK7set9vNfDYTp13qC3VLlkv2NKrpoWodSQ81WtPPKmcZNYmxSE0tQmMZA6FKAfCBAih1aFLohvSXIcdvr4MosOWD90=
X-Received: by 2002:a17:906:b4b:b0:931:c1a:b526 with SMTP id
 v11-20020a1709060b4b00b009310c1ab526mr814048ejg.5.1679119738091; Fri, 17 Mar
 2023 23:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
 <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com>
 <ZBPjs1b8crUv4ur6@casper.infradead.org> <CAEf4BzbPa-5b9uU0+GN=iaMGc6otje3iNQd+MOg_byTSYU8fEQ@mail.gmail.com>
 <20230317211403.GZ3390869@ZenIV> <20230317212125.GA3390869@ZenIV>
In-Reply-To: <20230317212125.GA3390869@ZenIV>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 23:08:44 -0700
Message-ID: <CAEf4BzYQ-bktO9s8yhBk7xUoz=2NFrgdGviWsN2=HWPBaGv6hA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 17, 2023 at 2:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Mar 17, 2023 at 09:14:03PM +0000, Al Viro wrote:
> > On Fri, Mar 17, 2023 at 09:33:17AM -0700, Andrii Nakryiko wrote:
> >
> > > > But build IDs are _generally_ available.  The only problem (AIUI)
> > > > is when you're trying to examine the contents of one container from
> > > > another container.  And to solve that problem, you're imposing a co=
st
> > > > on everybody else with (so far) pretty vague justifications.  I rea=
lly
> > > > don't like to see you growing struct file for this (nor struct inod=
e,
> > > > nor struct vm_area_struct).  It's all quite unsatisfactory and I do=
n't
> > > > have a good suggestion.
> > >
> > > There is a lot of profiling, observability and debugging tooling buil=
t
> > > using BPF. And when capturing stack traces from BPF programs, if the
> > > build ID note is not physically present in memory, fetching it from
> > > the BPF program might fail in NMI (and other non-faultable contexts).
> > > This patch set is about making sure we always can fetch build ID, eve=
n
> > > from most restrictive environments. It's guarded by Kconfig to avoid
> > > adding 8 bytes of overhead to struct file for environment where this
> > > might be unacceptable, giving users and distros a choice.
> >
> > Lovely.  As an exercise you might want to collect the stats on the
> > number of struct file instances on the system vs. the number of files
> > that happen to be ELF objects and are currently mmapped anywhere.

That's a good suggestion. I wrote a simple script that uses the drgn
tool ([0]), it enables nice introspection of the state of the kernel
memory for the running kernel. The script is at the bottom ([1]) for
anyone to sanity check. I didn't try to figure out which file is
mmaped as executable and which didn't, so let's do worst case and
assume that none of the file is executable, and thus that 8 byte
pointer is a waste for all of them.

On my devserver I got:

task_cnt=3D15984 uniq_file_cnt=3D56780

On randomly chosen production host I got:

task_cnt=3D6387 uniq_file_cnt=3D22514

So it seems like my devserver is "busier" than the production host. :)

Above numbers suggest that my devserver's kernel has about 57000
*unique* `struct file *` instances. That's 450KB of overhead. That's
not much by any modern standard.

But let's say I'm way off, and we have 1 million struct files. That's
8MB overhead. I'd argue that those 8MB is not a big deal even on a
normal laptop, even less so on production servers. Especially if you
have 1 million active struct file instances created in the system, as
way more will be used for application-specific needs.


> > That does depend upon the load, obviously, but it's not hard to collect=
 -
> > you already have more than enough hooks inserted in the relevant places=
.
> > That might give a better appreciation of the reactions...
>
> One possibility would be a bit stolen from inode flags + hash keyed by
> struct inode address (middle bits make for a decent hash function);
> inode eviction would check that bit and kick the corresponding thing
> from hash if the bit is set.
>
> Associating that thing with inode =3D> hash lookup/insert + set the bit.

This is an interesting idea, but now we are running into a few
unnecessary problems. We need to have a global dynamically sized hash
map in the system. If we fix the number of buckets, we risk either
wasting memory on an underutilized system (if we oversize), or
performance problems due to collisions (if we undersize) if we have a
busy system with lots of executables mapped in memory. If we don't
pre-size, then we are talking about reallocations, rehashing, and
doing that under global lock or something like that. Further, we'd
have to take locks on buckets, which causes further problems for
looking up build ID from this hashmap in NMI context for perf events
and BPF programs, as locks can't be safely taken under those
conditions, and thus fetching build ID would still be unreliable
(though less so than it is today, of course).

All of this is solvable to some degree (but not perfectly and not with
simple and elegant approaches), but seems like an unnecessarily
overcomplication compared to the amount of memory that we hope to
save. It still feels like a Kconfig-guarded 8 byte field per struct
file is a reasonable price for gaining reliable build ID information
for profiling/tracing tools.


  [0] https://drgn.readthedocs.io/en/latest/index.html

  [1] Script I used:

from drgn.helpers.linux.pid import for_each_task
from drgn.helpers.linux.fs import for_each_file

task_cnt =3D 0
file_set =3D set()

for task in for_each_task(prog):
    task_cnt +=3D 1
    try:
        for (fd, file) in for_each_file(task):
            file_set.add(file.value_())
    except:
        pass

uniq_file_cnt =3D len(file_set)
print(f"task_cnt=3D{task_cnt} uniq_file_cnt=3D{uniq_file_cnt}")
