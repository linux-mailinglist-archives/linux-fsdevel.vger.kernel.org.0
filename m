Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5F6C4A93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCVMav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCVMan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:30:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B1E50FA8
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 05:30:40 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k17so9999364ybm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679488240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIDnRaN9sxd0xnZDEDrl7FwoOB+6T8A94tkf+oMcNsM=;
        b=hwEVw8FNtToCOmLQzJtRNJ/OkEWC4Dguci+blmJcuw5u2JD4IBIE2+21El8yJXYoS4
         xuyDJwhGLwfaZi4e9bgZZGHhFGtOICW8hbt23BhzniyCEPVGOXnYg5c3h5ZbYmsCAqzr
         Ul3z2M8L2Z/jcy8nHggkc/OqzRO00lMvkcrhcmAvsTir82DbqXUWHEi1I0pl9naV+vso
         //rUba+Z/gTIow6PImoH69N7wZehEHDn3oDGDLUfWuVliKEdajCUSZwA9E/tNQddm/fB
         YJA2gkwEYdZDmOzm1TMbsjMExHS//8LA6sjV4vQxVz+tjTXv/wXuRWBAxV6D3ze4hQfa
         7+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679488240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIDnRaN9sxd0xnZDEDrl7FwoOB+6T8A94tkf+oMcNsM=;
        b=zWZY862m2B0grnM8D6Oul29jaiudw2OAGQfPuv9hGHF0ZVUfCTaiuTfbat7wLSwSYE
         eF03lRxDfHCw2ga3siUJK7spenRmGcgoOIoJvD4ZfJ1yq86MpExN0NwCYp1MvwlbAMC3
         RrsYLlD5/hYY6o5xdB0FE+ysCWkbXAtGhJuplX9+ur9X+3fxkLjJPBA2qznba9BOVStr
         0SnJgFejGVtLVinzG40DxSxa3hxgLKOWb84Js2rib3TKd9cnn4Cb8gnVjf99k2dgkKRe
         wr/u1EkmhJ1FdAMf9ZfmvaNAZwwvO7z8cLZSaXMmmZ+1PcqvW7N8Ar0FZzKglvitZpzK
         Mx5Q==
X-Gm-Message-State: AAQBX9ePtMFwIt9+NTA358HfuJjgjb2KO6vaOYFFiSFuPklGtO2MKi77
        QmPFX6IXfupX5agqyBER54Dq9Te+z/Z08OJZzkR9og==
X-Google-Smtp-Source: AKy350brVrs9DIoKaxSl5+ZQ+gEXyG50JHgNzUqBm/HoXTIpFkpBjkTYSzxIQd9ZikPcfWRmDPMlyrDfrlfnAJgtd8I=
X-Received: by 2002:a25:d256:0:b0:a3f:191f:dfb4 with SMTP id
 j83-20020a25d256000000b00a3f191fdfb4mr5148818ybg.58.1679488239630; Wed, 22
 Mar 2023 05:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
In-Reply-To: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
From:   Binder Makin <merimus@google.com>
Date:   Wed, 22 Mar 2023 08:30:27 -0400
Message-ID: <CAANmLtwGS75WJ9AXfmqZv73pNdHJn6zfrrCCWjKK_6jPk9pWRg@mail.gmail.com>
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

Was looking at SLAB removal and started by running A/B tests of SLAB
vs SLUB.  Please note these are only preliminary results.

These were run using 6.1.13 configured for SLAB/SLUB.
Machines were standard datacenter servers.

Hackbench shows completion time, so smaller is better.
On all others larger is better.
https://docs.google.com/spreadsheets/d/e/2PACX-1vQ47Mekl8BOp3ekCefwL6wL8SQi=
v6Qvp5avkU2ssQSh41gntjivE-aKM4PkwzkC4N_s_MxUdcsokhhz/pubhtml

Some notes:
SUnreclaim and SReclaimable shows unreclaimable and reclaimable memory.
Substantially higher with SLUB, but I believe that is to be expected.

Various results showing a 5-10% degradation with SLUB.  That feels
concerning to me, but I'm not sure what others' tolerance would be.

redis results on AMD show some pretty bad degredations.  10-20% range
netpipe on Intel also has issues.. 10-17%


On Tue, Mar 14, 2023 at 4:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> As you're probably aware, my plan is to get rid of SLOB and SLAB, leaving
> only SLUB going forward. The removal of SLOB seems to be going well, ther=
e
> were no objections to the deprecation and I've posted v1 of the removal
> itself [1] so it could be in -next soon.
>
> The immediate benefit of that is that we can allow kfree() (and kfree_rcu=
())
> to free objects from kmem_cache_alloc() - something that IIRC at least xf=
s
> people wanted in the past, and SLOB was incompatible with that.
>
> For SLAB removal I haven't yet heard any objections (but also didn't
> deprecate it yet) but if there are any users due to particular workloads
> doing better with SLAB than SLUB, we can discuss why those would regress =
and
> what can be done about that in SLUB.
>
> Once we have just one slab allocator in the kernel, we can take a closer
> look at what the users are missing from it that forces them to create own
> allocators (e.g. BPF), and could be considered to be added as a generic
> implementation to SLUB.
>
> Thanks,
> Vlastimil
>
> [1] https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz/
>
