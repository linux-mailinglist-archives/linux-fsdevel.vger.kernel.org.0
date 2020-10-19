Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E114292C96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgJSRXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgJSRXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:23:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585FC0613D1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 10:23:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v6so363799lfa.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyXXWfOQa+1d+k4Kfi8s1b5PhoxBW70UL1MRANY5iTA=;
        b=o9jkQBUpkBGEwOPcru1DIzTI4hADMkSZb2pfw2EQWRKUHSYKt6lOgBGbe0/PbjBsyj
         gkCeKyOJfMcHu8JQBuIGXYq2bMyUO23p7qpUH07+K7VJuHC15dj9M6Jixv+0kGJ3I484
         bibfM3wj1lSg02RVEGxrX4Vn06BnYQ9Fkpzq6GOiAp/P6ZC5OVnYSRqS0zxc14K0j6WJ
         cCjXupRPGQ3TQDsCBLaS0PxaOBRob35h4AyY0tvNebkGYNGxcnr2o07kc5d9g5o6COFY
         ILq2uDK4Y0klCUbaiEoIjmZxvz8kx/FNpsGUPC+D11xVFrfoxaJk055Yiql09wfYplO5
         TC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyXXWfOQa+1d+k4Kfi8s1b5PhoxBW70UL1MRANY5iTA=;
        b=GcHzYCwhphf6MTImSio+sOz3655TcwbJ2h/N2ebvy1CNN74oeMuJKuZTibrTx9M6fu
         sPheqa6PgSCBS5N5uiyfzfe6IqM3vrax5ecnfAGS5JagAd48YcSySaH5Nt788VkqEqap
         FAee8qjpXzkzMPB0FRCzFYjtZSUgpAM6ivcAs5G1aKfLRdX3PaxWGC3VY39wqo/onbno
         lUE57GfuZ7qxOO29gU3/A9F4Voh6gHGrngrl2EK9+nmfeEtat2wWcy1m6MarOHhwnCTt
         0cCHfE+xyMV+UF/n0rusWaTMyJEh6RSGuvegv08t56DLXsZVo6IkhJw7dxHMZGEMcZ7N
         BIPw==
X-Gm-Message-State: AOAM531XN3UAVxjKtgvd2JgCCWiy6114fRgwdbJBMO3O5nclHGdj6H0b
        03zcc3Malp9NLQCnachS4rCuFxb14M5uZjDBX4K9eA==
X-Google-Smtp-Source: ABdhPJwSXb1dY6AgaVzNQLt+reDscKrvoARfXRBXfeo2h9MZNArk1CXUTqLg5bs0YhI3mYrfPTwBL8qmTMYBnfbcX4E=
X-Received: by 2002:a19:d10:: with SMTP id 16mr216317lfn.385.1603128217818;
 Mon, 19 Oct 2020 10:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com> <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
 <20201013080906.GD4251@kernel.org> <8d1558e7-cd09-1f9e-edab-5f22c5bfc342@suse.cz>
 <20201016205336.GE1976566@google.com>
In-Reply-To: <20201016205336.GE1976566@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 19 Oct 2020 10:23:26 -0700
Message-ID: <CALvZod78tJDZauFvYfWmMyd+Z3Ci7Lsruyd_-nU00WL0EjN6vQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To:     Minchan Kim <minchan@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Neil Brown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Westphal <fw@strlen.de>, gustavoars@kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Dexuan Cui <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu@xiaomi.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CCed: Paolo Bonzini

On Fri, Oct 16, 2020 at 1:53 PM Minchan Kim <minchan@kernel.org> wrote:
[snip]
> > And there might be others, and adding everything to /proc/meminfo is not
> > feasible. I have once proposed adding a counter called "Unaccounted:" which
> > would at least tell the user easily if a significant portion is occupied by
> > memory not explained by the other meminfo counters, and look for trends
> > (increase = potential memory leak?). For specific prominent consumers not
> > covered by meminfo but that have some kind of internal counters, we could
> > document where to look, such as /proc/net/sockstat or maybe create some
> > /proc/ or /sys directory with file per consumer so that it's still easy to
> > check, but without the overhead of global counters and bloated
> > /proc/meminfo?
>
> What have in my mind is to support simple general sysfs infra from MM for
> driver/subysstems rather than creating each own memory stat. The API
> could support flexible accounting like just global memory consumption and/or
> consmption by key(e.g,. pid or each own special) for the detail.
>
> So, they are all shown under /sys/kernel/mm/misc/ with detail as well as
> /proc/meminfo with simple line for global.

This reminds me of statsfs [1]. I am wondering if this can be another
useful use-case for statsfs.

[1] https://lkml.org/lkml/2020/5/26/332
