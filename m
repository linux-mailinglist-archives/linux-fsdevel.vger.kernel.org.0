Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1606D8771
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjDETzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjDETzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:55:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7D126
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:54:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x3so8849267iov.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680724497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcYjART6vOTXgshTS0uLbmOyompGa7/lXpaivlpY/VA=;
        b=Q5pH8VZulJ+C6K7kJgwa8mvOZ9ZrOOAVLsmxUjEBWvSwXZS2eYxnn+3CNEFDsgl/FB
         PjfOUoveEnD9PSu/Eywba4OUlZTADegV9S/hQ9fnBWU5k74/LBMblU+lOZZKTg++slTD
         03UU0BISn96pJcY7cmEh/5YQiID+BNXZbn/LtyNdhSCUTcnPySOohUPn1SFbS9xrnAho
         y8FwD0YOjPOgKVlGfYrC+svNxrZfTOuh21opeEKDfTzKowlJOJ6wZADntkTgf6er0ndr
         WzczKJPJqJUu2H5QfN0VjxK2pU1vYQG2Hc0FVxsHg0Zw13iPCjmyqdvSgOMHi62oz+x6
         iUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcYjART6vOTXgshTS0uLbmOyompGa7/lXpaivlpY/VA=;
        b=04HgIvOEJLZg15+NSQ3wt8Zks6rabrwWj0Am56UquF7pBCfVnH9AaFNGj+IaIjEcsd
         Fjmp7N14SAGX5IDyjBEXXiEul5E6qDEgozZJVeiXQdNWatko7yhkVxam+dsly4qRIql6
         K31l76C2to59MSW+t4eoA4ipM9GkMDj0y9LIv7jJUEP9A+tfz9vsARJQi4mm/bwTRuqU
         5ubvnc2v2aTxSyj45yJZmgjOb5X5Pj0HvUlO/oHAVAg+/hT52yXyf3aT2isTAZRKzIfD
         QA3ixFAYOSKn5fcHrvI1jYauQse14bDGlVeWBOejGd/25ojHRGIeFZICNVfcTkALVj5C
         0MHQ==
X-Gm-Message-State: AAQBX9cCVzKOYVi8zGeusJYBxHkgsrFu37kmJAiG44eI0kruzAPFgwmJ
        ezkkmmtr0wwLIaXYXxoep+CuT2+j6wPs6uLfQKQ47Q==
X-Google-Smtp-Source: AKy350aQGUhRBR9nlxvbezaz/UrkSAWRI9gjznAzUIFBqGpVkijBgUKrfga8wmafgeF9lt6YkUUxmVhABC3COYaTN2I=
X-Received: by 2002:a5e:df47:0:b0:74c:7ea1:4f05 with SMTP id
 g7-20020a5edf47000000b0074c7ea14f05mr5543603ioq.2.1680724497235; Wed, 05 Apr
 2023 12:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz> <CAANmLtwGS75WJ9AXfmqZv73pNdHJn6zfrrCCWjKK_6jPk9pWRg@mail.gmail.com>
 <951d364a-05c0-b290-8abe-7cbfcaeb2df7@suse.cz>
In-Reply-To: <951d364a-05c0-b290-8abe-7cbfcaeb2df7@suse.cz>
From:   Binder Makin <merimus@google.com>
Date:   Wed, 5 Apr 2023 15:54:45 -0400
Message-ID: <CAANmLtzQmVN_EWLv1UxXwZu5X=TwpcMQMYArKNUxAJL3PnfO2Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB improvements
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm still running tests to explore some of these questions.
The machines I am using are roughly as follows.

Intel dual socket 56 total cores
192-384GB ram
LEVEL1_ICACHE_SIZE                 32768
LEVEL1_DCACHE_SIZE                 32768
LEVEL2_CACHE_SIZE                  1048576
LEVEL3_CACHE_SIZE                  40370176

Amd dual socket 128 total cores
1TB ram
LEVEL1_ICACHE_SIZE                 32768
LEVEL1_DCACHE_SIZE                 32768
LEVEL2_CACHE_SIZE                  524288
LEVEL3_CACHE_SIZE                  268435456

Arm single socket 64 total cores
256GB rma
LEVEL1_ICACHE_SIZE                 65536
LEVEL1_DCACHE_SIZE                 65536
LEVEL2_CACHE_SIZE                  1048576
LEVEL3_CACHE_SIZE                  33554432

On Tue, Apr 4, 2023 at 12:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/22/23 13:30, Binder Makin wrote:
> > Was looking at SLAB removal and started by running A/B tests of SLAB
> > vs SLUB.  Please note these are only preliminary results.
>
> Thanks, that's very useful.
>
> > These were run using 6.1.13 configured for SLAB/SLUB.
> > Machines were standard datacenter servers.
> >
> > Hackbench shows completion time, so smaller is better.
> > On all others larger is better.
> > https://docs.google.com/spreadsheets/d/e/2PACX-1vQ47Mekl8BOp3ekCefwL6wL=
8SQiv6Qvp5avkU2ssQSh41gntjivE-aKM4PkwzkC4N_s_MxUdcsokhhz/pubhtml
> >
> > Some notes:
> > SUnreclaim and SReclaimable shows unreclaimable and reclaimable memory.
> > Substantially higher with SLUB, but I believe that is to be expected.
> >
> > Various results showing a 5-10% degradation with SLUB.  That feels
> > concerning to me, but I'm not sure what others' tolerance would be.
> >
> > redis results on AMD show some pretty bad degredations.  10-20% range
> > netpipe on Intel also has issues.. 10-17%
>
> I guess one question is which ones are genuine SLAB/SLUB differences and =
not
> e.g. some artifact of different cache layout or something. For example it
> seems suspicious if results are widely different between architectures.
>
> E.g. will-it-scale writeseek3_scalability regresses on arm64 and amd, but
> improves on intel? Or is something wrong with the data, all columns for t=
hat
> whole benchmark suite are identical.
>
> hackbench ("smaller is better") seems drastically better on arm64 (30%
> median time reduction?) and amd (80% reduction?!?), but 10% slower intel?
>
> redis seems a bit improved on arm64, slightly worse on intel but much wor=
se
> on amd.
>
> specjbb similar story, also I thought it was a java focused benchmark,
> should it really be exercising kernel slab allocators in such notable way=
?
>
> I guess netpipe is the least surprising as networking was always mentione=
d
> in SLAB vs SLUB discussions.
>
> > On Tue, Mar 14, 2023 at 4:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> As you're probably aware, my plan is to get rid of SLOB and SLAB, leav=
ing
> >> only SLUB going forward. The removal of SLOB seems to be going well, t=
here
> >> were no objections to the deprecation and I've posted v1 of the remova=
l
> >> itself [1] so it could be in -next soon.
> >>
> >> The immediate benefit of that is that we can allow kfree() (and kfree_=
rcu())
> >> to free objects from kmem_cache_alloc() - something that IIRC at least=
 xfs
> >> people wanted in the past, and SLOB was incompatible with that.
> >>
> >> For SLAB removal I haven't yet heard any objections (but also didn't
> >> deprecate it yet) but if there are any users due to particular workloa=
ds
> >> doing better with SLAB than SLUB, we can discuss why those would regre=
ss and
> >> what can be done about that in SLUB.
> >>
> >> Once we have just one slab allocator in the kernel, we can take a clos=
er
> >> look at what the users are missing from it that forces them to create =
own
> >> allocators (e.g. BPF), and could be considered to be added as a generi=
c
> >> implementation to SLUB.
> >>
> >> Thanks,
> >> Vlastimil
> >>
> >> [1] https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz/
> >>
>
