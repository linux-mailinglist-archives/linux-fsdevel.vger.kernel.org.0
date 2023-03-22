Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E536C4B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCVNCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVNCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:02:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2261888;
        Wed, 22 Mar 2023 06:02:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso23564671pjb.0;
        Wed, 22 Mar 2023 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679490164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ViRmkYI1T/q9AleFDZxnzz9BK+OfJL44ohwRmj/wb8E=;
        b=ARhhmfUoXSena1pM+E1Grp6YR3kCOnLV3kdIDePvpVJUQ2dg3kLrsYVgolxTx2noL5
         sog/oqz4IL9fJBM1nyglLa7MRO/EhEoJ1Jeh3J0ytt7mkrOCD8UwWdeQT1ipF6sruQqO
         8HoSJW0OcaX4k2Oua8aRQVmQ9Ik3tWCM1ggl+QRNTG9Rtwm/d5rYvl1QKbtiP5tOw0xQ
         P6vJtMlVTlAXKOnPaESrHNQ3pWA9mdU82lW7FArwmXwdj4ZIm4g9EY9Pt7V/jGiyOJMK
         LzAC9eu83kinbzMQrsKvkoxtmr7rP0u1E5vHvuMSB5TpJW7X0GsZC5srFqvlKwVD38kZ
         gN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViRmkYI1T/q9AleFDZxnzz9BK+OfJL44ohwRmj/wb8E=;
        b=FmPIwVy268HJjO0k5qISDH4v55lo/C3WKroh4RzhE21xDWHKIgwwWZLsk2wCpocf7z
         kreHByBSTiY8v0OTInS5xdpwBAZlxg37m6hwcbbG89/1aIITm4wQs/zyndCUz5Zz8mhz
         POHiPkRNTHru/84c0BQlaAnCdqep5T7fNwVrIHZEU4GrS627t55IO3QkkmxhQ+pe7f9i
         Ju0gIpGoqwrvdwm2g8o0fLitkYrb7UlEbfCLJDSvBKivR+wcKnhzSAyk3UpXQDFk7CZS
         j1Q8YEvVy9AcwpAnXeTROJ8HCM6DmNDMHH5CKdFTL0W0cosOqYd7E1pByiq4QPXnxWq3
         sERw==
X-Gm-Message-State: AO0yUKVGz2v0S9viB+R3/YE7ABNj2QmgEiAtIYBgvVUKQn0O7mYoLQlO
        z35ZI+Q76p/qaQF/82MHKyw=
X-Google-Smtp-Source: AK7set8i0yrjEu/hxv3QebJCfgsiDSAkrFFCBeuESthSVvyA2rynV3aw+/+Dw2F3mR4N9qvZR/IeUQ==
X-Received: by 2002:a17:90b:4d0d:b0:23a:87d1:9586 with SMTP id mw13-20020a17090b4d0d00b0023a87d19586mr3318684pjb.23.1679490164008;
        Wed, 22 Mar 2023 06:02:44 -0700 (PDT)
Received: from hyeyoo ([210.205.188.148])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001a064cff3c5sm10502457plp.43.2023.03.22.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:02:42 -0700 (PDT)
Date:   Wed, 22 Mar 2023 22:02:28 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Binder Makin <merimus@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
Message-ID: <ZBr8Gf53CbJc0b5E@hyeyoo>
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
 <CAANmLtzajny8ZK_QKVYOxLc8L9gyWG6Uu7YyL-CR-qfwphVTzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAANmLtzajny8ZK_QKVYOxLc8L9gyWG6Uu7YyL-CR-qfwphVTzg@mail.gmail.com>
X-Spam-Status: No, score=1.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:15:28AM -0400, Binder Makin wrote:
> Was looking at SLAB removal and started by running A/B tests of SLAB vs
> SLUB.  Please note these are only preliminary results.
> 
> These were run using 6.1.13 configured for SLAB/SLUB.
> Machines were standard datacenter servers.
> 
> Hackbench shows completion time, so smaller is better.
> On all others larger is better.
> https://docs.google.com/spreadsheets/d/e/2PACX-1vQ47Mekl8BOp3ekCefwL6wL8SQiv6Qvp5avkU2ssQSh41gntjivE-aKM4PkwzkC4N_s_MxUdcsokhhz/pubhtml
>
> Some notes:
> SUnreclaim and SReclaimable shows unreclaimable and reclaimable memory.
> Substantially higher with SLUB, but I believe that is to be expected.
> 
> Various results showing a 5-10% degradation with SLUB.  That feels
> concerning to me, but I'm not sure what others' tolerance would be.

Hello Binder,

Thank you for sharing the data on which workloads
SLUB performs worse than SLAB. This information is critical for
improving SLUB and deprecating SLAB.

By the way, it appears that the spreadsheet is currently set to private.
Could you make it public for me to access?

I am really interested in performing similar experiments on my machines
to obtain comparable data that can be utilized to enhance SLUB.

Thanks,
Hyeonggon

> redis results on AMD show some pretty bad degredations.  10-20% range
> netpipe on Intel also has issues.. 10-17%
> 
> On Tue, Mar 14, 2023 at 4:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > As you're probably aware, my plan is to get rid of SLOB and SLAB, leaving
> > only SLUB going forward. The removal of SLOB seems to be going well, there
> > were no objections to the deprecation and I've posted v1 of the removal
> > itself [1] so it could be in -next soon.
> >
> > The immediate benefit of that is that we can allow kfree() (and
> > kfree_rcu())
> > to free objects from kmem_cache_alloc() - something that IIRC at least xfs
> > people wanted in the past, and SLOB was incompatible with that.
> >
> > For SLAB removal I haven't yet heard any objections (but also didn't
> > deprecate it yet) but if there are any users due to particular workloads
> > doing better with SLAB than SLUB, we can discuss why those would regress
> > and
> > what can be done about that in SLUB.
> >
> > Once we have just one slab allocator in the kernel, we can take a closer
> > look at what the users are missing from it that forces them to create own
> > allocators (e.g. BPF), and could be considered to be added as a generic
> > implementation to SLUB.
> >
> > Thanks,
> > Vlastimil
> >
> > [1] https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz/
