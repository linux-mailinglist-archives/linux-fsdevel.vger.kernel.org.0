Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19576C10A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 12:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCTLUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 07:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCTLUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:20:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F8526B;
        Mon, 20 Mar 2023 04:20:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y20so14433882lfj.2;
        Mon, 20 Mar 2023 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2UL4IhRczrMrkP5475LvCds4xNJEhrT8X1HycL9bCM=;
        b=OIKR1gpz9fxP9kEKYvLpG9gFyqB6Ac9wXlzlWqKCzh7tCkMxxd/gjXqirHd1XftHuG
         pl6B14hklTrpuU2MTnq3CG8+AEHgBWss70azrqAcmCjWhsh8hK9RalzOMx+oMOLjV+Kh
         fGEDHO3Cx9qtTbqPt3ksSHa5DMp6dIFFr0PUx7l+Ve4vnJodgdc6Dfon1M8Yv0KZuw8C
         RPU49u3y5rsXo2yToa13w5igQ0YqWyorKvmL35yiO0wAEdmymh5nbOZiIiazFSuXmfdY
         QQzWNqEfPfcLZnU2SACtJd+qUrhDZsRaz48aFt7l9nIkT7/P7dRcnhKu1JPl01ANuHdy
         Wxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2UL4IhRczrMrkP5475LvCds4xNJEhrT8X1HycL9bCM=;
        b=zjLjs6Z3yb8lRMGDzrSO5iu3DC/+Fb2Nq1Cc6g+pbY5m2Er1caeX0AYl3mlmKk+l8X
         QLH8h2XvOq5VY8VC0df6dPUwI+sfI4FLUW/IEswiUy+PC08CJxqjm03LROebkrCirm9K
         m65j/E5Pb7XCGoME6Hn9XE1meR8IK2XbFNDIitRRBX1fOOTYBj9Vj5aiwga45qZQEaxB
         2K+4FGn0delbc/KsrUZZdjv6QP2cs2jgryf2+lkka7MldK942zfYuur3KkIBx1fqfJPi
         k3Ae9k9AA7IipyNyRck796YBDt+7LIDyp8WbEfRnU4i76dgp9dylDpH9uq04kZer1o8v
         Qihw==
X-Gm-Message-State: AO0yUKVXxRBZ+Ws1tCtJPcv3FTTuyWkgC+ADsMHVxE5otWLzuE5/D+Iu
        6nUZ2j4vx83hUBjaZEZ/nVo=
X-Google-Smtp-Source: AK7set9iwMt81SiNTCxVYLtVATbXkAzHAgYDh2+QIEnKRGF458BQJo4CdD5b5KOJsAPUaO9n19BDDQ==
X-Received: by 2002:ac2:494b:0:b0:4b5:b06d:4300 with SMTP id o11-20020ac2494b000000b004b5b06d4300mr5770655lfi.29.1679311206757;
        Mon, 20 Mar 2023 04:20:06 -0700 (PDT)
Received: from pc636 (host-90-235-3-187.mobileonline.telia.com. [90.235.3.187])
        by smtp.gmail.com with ESMTPSA id u1-20020ac248a1000000b004db51387ad6sm1653571lfg.129.2023.03.20.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:20:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 20 Mar 2023 12:20:02 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBhBRCIyc5Scx1Kf@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBgROQ0uAfZCbScg@pc636>
 <413e0dfe-5a68-4cd9-9036-bed741e4cd22@lucifer.local>
 <ZBgaBqareTrUrasp@pc636>
 <cd91527d-e6e0-4900-a368-dfc9812546da@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd91527d-e6e0-4900-a368-dfc9812546da@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:35:11AM +0000, Lorenzo Stoakes wrote:
> On Mon, Mar 20, 2023 at 09:32:06AM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 20, 2023 at 08:25:32AM +0000, Lorenzo Stoakes wrote:
> > > On Mon, Mar 20, 2023 at 08:54:33AM +0100, Uladzislau Rezki wrote:
> > > > > vmalloc() is, by design, not permitted to be used in atomic context and
> > > > > already contains components which may sleep, so avoiding spin locks is not
> > > > > a problem from the perspective of atomic context.
> > > > >
> > > > > The global vmap_area_lock is held when the red/black tree rooted in
> > > > > vmap_are_root is accessed and thus is rather long-held and under
> > > > > potentially high contention. It is likely to be under contention for reads
> > > > > rather than write, so replace it with a rwsem.
> > > > >
> > > > > Each individual vmap_block->lock is likely to be held for less time but
> > > > > under low contention, so a mutex is not an outrageous choice here.
> > > > >
> > > > > A subset of test_vmalloc.sh performance results:-
> > > > >
> > > > > fix_size_alloc_test             0.40%
> > > > > full_fit_alloc_test		2.08%
> > > > > long_busy_list_alloc_test	0.34%
> > > > > random_size_alloc_test		-0.25%
> > > > > random_size_align_alloc_test	0.06%
> > > > > ...
> > > > > all tests cycles                0.2%
> > > > >
> > > > > This represents a tiny reduction in performance that sits barely above
> > > > > noise.
> > > > >
> > > > How important to have many simultaneous users of vread()? I do not see a
> > > > big reason to switch into mutexes due to performance impact and making it
> > > > less atomic.
> > >
> > > It's less about simultaneous users of vread() and more about being able to write
> > > direct to user memory rather than via a bounce buffer and not hold a spinlock
> > > over possible page faults.
> > >
> > > The performance impact is barely above noise (I got fairly widely varying
> > > results), so I don't think it's really much of a cost at all. I can't imagine
> > > there are many users critically dependent on a sub-single digit % reduction in
> > > speed in vmalloc() allocation.
> > >
> > > As I was saying to Willy, the code is already not atomic, or rather needs rework
> > > to become atomic-safe (there are a smattering of might_sleep()'s throughout)
> > >
> > > However, given your objection alongside Willy's, let me examine Willy's
> > > suggestion that we instead of doing this, prefault the user memory in advance of
> > > the vread call.
> > >
> > Just a quick perf tests shows regression around 6%. 10 workers test_mask is 31:
> >
> > # default
> > [  140.349731] All test took worker0=485061693537 cycles
> > [  140.386065] All test took worker1=486504572954 cycles
> > [  140.418452] All test took worker2=467204082542 cycles
> > [  140.435895] All test took worker3=512591010219 cycles
> > [  140.458316] All test took worker4=448583324125 cycles
> > [  140.494244] All test took worker5=501018129647 cycles
> > [  140.518144] All test took worker6=516224787767 cycles
> > [  140.535472] All test took worker7=442025617137 cycles
> > [  140.558249] All test took worker8=503337286539 cycles
> > [  140.590571] All test took worker9=494369561574 cycles
> >
> > # patch
> > [  144.464916] All test took worker0=530373399067 cycles
> > [  144.492904] All test took worker1=522641540924 cycles
> > [  144.528999] All test took worker2=529711158267 cycles
> > [  144.552963] All test took worker3=527389011775 cycles
> > [  144.592951] All test took worker4=529583252449 cycles
> > [  144.610286] All test took worker5=523605706016 cycles
> > [  144.627690] All test took worker6=531494777011 cycles
> > [  144.653046] All test took worker7=527150114726 cycles
> > [  144.669818] All test took worker8=526599712235 cycles
> > [  144.693428] All test took worker9=526057490851 cycles
> >
> 
> OK ouch, that's worse than I observed! Let me try this prefault approach and
> then we can revert back to spinlocks.
> 
> > > >
> > > > So, how important for you to have this change?
> > > >
> > >
> > > Personally, always very important :)
> > >
> > This is good. Personal opinion always wins :)
> >
> 
> The heart always wins ;) well, an adaption here can make everybody's hearts
> happy I think.
> 
Totally agree :)

--
Uladzislau Rezki
