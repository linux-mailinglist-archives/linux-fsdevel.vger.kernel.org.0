Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7EC77C8C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjHOHne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjHOHnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:43:06 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00510CE;
        Tue, 15 Aug 2023 00:43:05 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c4c5375329so1889078fac.2;
        Tue, 15 Aug 2023 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692085384; x=1692690184;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dopEln9VPZxL0Iq2JZLCcr+rwxXbLb8d+hQCQTunBsQ=;
        b=sXpXbQ7X0/LnTySjZDkaO9nHDDYr/pU3abQLw5n+GIKm504OloCtIss+QlRkXMojYd
         lnsMof65iO5zpZY4PDmzq4MvCqh87E7X54BHvQSyyEBEsvQLKlRcO9PFHOwnoC26UxSi
         0EOZolvVtmL/fjRleZjuvqGddQNE1ZoIFWROwVG2UGNYm6q4+PQ4gJr4l2gvaDj98KI7
         LNthh1PBVu5kZzVpkcc4O5PE+NiDnj53oYq5p6Usr6X7mva8914eox15YAr9OxM1pcMm
         bfXnNogduAOX/QmakZMZx8O5v4D5wLTjB0DaOjr43HLmAUvjt7TZ5afaza86l8WrDnrm
         0KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085384; x=1692690184;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dopEln9VPZxL0Iq2JZLCcr+rwxXbLb8d+hQCQTunBsQ=;
        b=bdQXnNepZ4e9BvfawTiXgATk/eX6+aJzblPoBT7uxHIN96XFCtOTS9hJuq5jzzgh6V
         PINNZ+8KqbTjhzrRz5dVfb0ZT9pMVdCBW+WufLwd4x9OgbdQisA/H7oC60O7zvSL39sg
         Zr9765Q/MPboEnMCALSmaIFf4wV9ntbbGfQKvSJhlrLv72u2jIVLd17EiQMT8ZIMLAo6
         2Sdt8HJDO2ZI9SVcW/o4VmTWDR91cMFBVSBXXK1CnftPhfu7gbJfjugYC401LByKx0mq
         tgid0mQUIxCqypu/eu8nnlouIjNSmY9eety4pFuEzz1QF7ATa2L1zvfoYB2WxnBsUe2/
         9/cA==
X-Gm-Message-State: AOJu0YxaP86Um2V+XGj7w+wbBTUhGKxeoAeYgPLaAK8trTxIl3Yz6NYQ
        YPxLUy0dh3Or/XNH1BLHU4DLHXKKyhoA9a7EPwk=
X-Google-Smtp-Source: AGHT+IH21/5w6crwWPD7vIv/j0w3adsBN5eHck6Oh1Qn4awi8woAnlWJm3VwnpYegg1T9u8cFeJOGx/7gnb2bXKv5QE=
X-Received: by 2002:a05:6870:15d5:b0:1bf:9f6:b810 with SMTP id
 k21-20020a05687015d500b001bf09f6b810mr11562135oad.36.1692085384532; Tue, 15
 Aug 2023 00:43:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:745a:0:b0:4f0:1250:dd51 with HTTP; Tue, 15 Aug 2023
 00:43:04 -0700 (PDT)
In-Reply-To: <CAHk-=whbOEhPUL1m8Ua-+-E7kJXED4xa+duzRF-wJKR84NAPWg@mail.gmail.com>
References: <202308151426.97be5bd8-oliver.sang@intel.com> <CAHk-=whbOEhPUL1m8Ua-+-E7kJXED4xa+duzRF-wJKR84NAPWg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 15 Aug 2023 09:43:04 +0200
Message-ID: <CAGudoHFFdFa=0y0XSEMNF4eucngxHKs7tby3rf32A-Wn1cqivQ@mail.gmail.com>
Subject: Re: [linus:master] [locking] c8afaa1b0f: stress-ng.zero.ops_per_sec
 6.3% improvement
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 15 Aug 2023 at 07:12, kernel test robot <oliver.sang@intel.com>
> wrote:
>>
>> kernel test robot noticed a 6.3% improvement of stress-ng.zero.ops_per_sec
>> on:
>
> WTF? That's ridiculous. Why would that even test new_inode() at all?
> And why would it make any difference anyway to prefetch a new inode?
> The 'zero' test claims to just read /dev/zero in a loop...
>
> [ Goes looking ]
>

Ye man, I was puzzled myself but just figured it out and was about to respond ;)

# bpftrace -e 'kprobe:new_inode { @[kstack()] = count(); }'
Attaching 1 probe...

@[
    new_inode+1
    shmem_get_inode+137
    __shmem_file_setup+195
    shmem_zero_setup+46
    mmap_region+1937
    do_mmap+956
    vm_mmap_pgoff+224
    do_syscall_64+46
    entry_SYSCALL_64_after_hwframe+115
]: 2689570

the bench is doing this *A LOT* and this looks so fishy, for the bench
itself and the kernel doing it, but I'm not going to dig into any of
that.

>>      39.35            -0.3       39.09
>> perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.__shmem_file_setup.shmem_zero_setup
>
> Ahh. It also does the mmap side, and the shared case ends up always
> creating a new inode.
>
> And while the test only tests *reading* and the mmap is read-only, the
> /dev/zero file descriptor was opened for writing too, for a different
> part of a test.
>
> So even though the mapping is never written to, MAYWRITE is set, and
> so the /dev/zero mapping is done as a shared memory mapping and we
> can't do it as just a private one.
>
> That's kind of stupid and looks unintentional, but whatever.
>
> End result: that benchmark ends up being at least partly (and a fairly
> noticeable part) a shmem setup benchmark, for no actual good reason.
>
> Oh well. I certainly don't mind the removal apparently then also
> helping some odd benchmark case, but I don't think this translates to
> anything real. Very random.
>
>                     Linus
>


-- 
Mateusz Guzik <mjguzik gmail.com>
