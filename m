Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB98077352C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHGXoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 19:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGXoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:44:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2151736;
        Mon,  7 Aug 2023 16:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R7l6QScXv7U38OrlWS7Mcrb8Q93Tbo+TJ0PZi9bIVzI=; b=lvQhpYkugp8p+MnqK1ZwyEPyPV
        qQ13g/zVYcvPRrYd2noywzgnhct1y5FSUHLn9ld+CBTnhLURNvgr/bgoc4bC5EjlpBpGWWJSfX6T/
        Qmk68ZOOTeEEYcestzUADl5Dpi2gJuWSQGiqWBWdo7zHkuT9gtEQcp0EWL0J2TwWVfknB/pb1efBJ
        /qWuJAAvELKv3Gu45SonJbWc0VbDj+8+j0QZPdUmEmVKMoxo/rXWuGEKo/o2tIRBYi/rELO7VQcCa
        I8mjAfAkS2C8C5SdfIKOYZeY5S9V20FFyb9rMjgiCJ7HvitG7HyaaV+Ort6BR6cHisL1dXBl+Z9Mq
        S3J7uphA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qT9t0-001Fyr-1h;
        Mon, 07 Aug 2023 23:43:42 +0000
Date:   Mon, 7 Aug 2023 16:43:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chris Maness <christopher.maness@gmail.com>
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
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:00:49PM -0700, Chris Maness wrote:
> When are these likely to hit the mainline release code?

linux-next tomorrow. The first 7 patches are scheduled for mainline
as they were merged + tested without any hiccups. These last few patches
I'll wait and see. If nothing blows up on linux-next perhaps I'll
include them to Linux for mainline during the next merge window.

  Luis
