Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A8773752
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 05:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjHHDHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHHDHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:07:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D722180;
        Mon,  7 Aug 2023 20:07:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5861116fd74so49005587b3.0;
        Mon, 07 Aug 2023 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691464055; x=1692068855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0G2Gm44L7ws5E/quoPqMuJmdghfzOor5wGEa6AaRIig=;
        b=MIB1dRWNV6Yb3HUd1qPb/bgwaoUzAlGVu8CxiiwIDYwN4TMseNzdPMVbuAfPyciWjI
         AZzeBtiA00C4EVQ8EGlp9e8Q3pbBFc8aCRl+HJu3YtRoio8lAQY1qu2UvIE5hChxs5Q1
         PKMC/y7tlRiDWg5YOtPXbZsaYs//GKuhiSEDo5WpI7edOLzGAaAJjqvFIOQWWQAuLo7Z
         JBsPnB5UvxOuJ1p76ZyxSuA7+KQWE3J2jS89kM5pl3PIv+dMsBBD/LquAyRZomdcC7zN
         v+sSG+iPprRQeQoEH+XZP/GEzjEboCjqHBhNwHzm7vxhsHdZplrvrz31A5i2G+xxBQ4/
         u+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464055; x=1692068855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G2Gm44L7ws5E/quoPqMuJmdghfzOor5wGEa6AaRIig=;
        b=cTAhVJDVEwS8pBrL0SXNg3xFgnu4vZIU6lfQn2gDq/eIdolAU9TIC+ou5tokaftI+9
         mtUtgXKRyRudmqhl9YfrHSS43aDD0oD/K37mVVcecuoDRxxbolTEFoZf5vO/ky7XGkXH
         7J3sW/KIiEJvkuaE9Dq5LNGNXhIwCGi1YpPyqDosfSTIRe2oRSicB+02CwgQSwuCwQbN
         KfJwPJEo/DaesAeCnohgFjM6xjNJlKCn7L6seUd6sfmNskz8x1+HOllrVd9Yr9Jf0HoX
         grksd3LcUPDn23cLuTdAeryouLh/sxwbnaOABtHmiMeHIxPe22tDDyD0VPGUus1usR5P
         OL7A==
X-Gm-Message-State: AOJu0YznfGMieNEkSIdc/xYwQunbD1ZgIZuYbs6BDwk+bZMW8qVnrafK
        tMz721jgIzMLSSdVF+/WF+kouKBvwYAulTCE11k=
X-Google-Smtp-Source: AGHT+IHQrIvich9PHSVbgRXTdmB7iIbb8QzxP6y5/ZjBG6gKIk1MkGZwx3L/64MT/J6/QOrL9i/+Y+FD0/7A7U+VjlM=
X-Received: by 2002:a0d:dd4a:0:b0:589:642d:6d84 with SMTP id
 g71-20020a0ddd4a000000b00589642d6d84mr2728002ywe.23.1691464055184; Mon, 07
 Aug 2023 20:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org> <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org> <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
 <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
In-Reply-To: <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
From:   Chris Maness <christopher.maness@gmail.com>
Date:   Mon, 7 Aug 2023 20:07:24 -0700
Message-ID: <CANnsUMGHnurbph9F7mex=1s0mxhwpNgeQbKJ6j1r37Qmd6LAMQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iurii Zaikin <yzaikin@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jan Karcher <jaka@linux.ibm.com>,
        Joel Granados <joel.granados@gmail.com>,
        Joel Granados <j.granados@samsung.com>,
        Joerg Reuter <jreuter@yaina.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Julian Anastasov <ja@ssi.bg>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roopa Prabhu <roopa@nvidia.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Simon Horman <horms@verge.net.au>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Xin Long <lucien.xin@gmail.com>,
        bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        josh@joshtriplett.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        mptcp@lists.linux.dev, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, rds-devel@oss.oracle.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> Are you reporting a separate regression that goes all the way back to v4 kernels?
>

I am not certain what you mean by regression.

> > v2 is fine there.
>
> What does this mean?

I have to go all the way back to kernel version 2 for the serial 6PACK
driver to work.  If I try to use it in Kernel version 4, 5, or 6 the
kernel panics as soon as I attempt to connect to another station.

>
>   Luis

Chris KQ6UP


-- 
Thanks,
Chris Maness
