Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD177373B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 05:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjHHDBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 23:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHHDBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:01:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0904EE62;
        Mon,  7 Aug 2023 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=awhihqdhuWHeoYd3N+GeqIh75MDzai4L3hYXPN/a5fs=; b=tUST17gLJ8xZ0XM9L8/HrXEzU6
        tZMGClzY4pZ/RImt/bnbB/JZcOjtt5PmKLr+dRTMvmYeQEcUBooY2DNhz58NUerVaQqDC015TRyjc
        g1IssTuWVGi/DL9wssEj8dLTlcAJscsVmNWS5BVgJhme/xZGO0m8ySRFoRMNYJTG4Xl7MxTjTGp7C
        ZalLCKJuEZWuvODxF3D9hPb9kAHImXekJu/C7Hsr+LVqEdAUuRP99EiAC4ltf/mLdEYZHlbcagzl2
        JAzO8s3ORZZCLfmIi6xHnozbVOvMIBfDJ4vQwyENOCQFObn49Nzg3oOA/pzlUucU/MFJhjPm93T0s
        D1w47+5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qTCxh-001bG0-1K;
        Tue, 08 Aug 2023 03:00:45 +0000
Date:   Mon, 7 Aug 2023 20:00:45 -0700
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
Message-ID: <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
 <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:50:44PM -0700, Chris Maness wrote:
> I tried running the current mainline kernel (current Arch Linux) with
> simple single MUX socket (ax0) using LinFBB.  I was a happy camper as
> it seemed to work fine at first, then the system just slowed to a
> crawl.  I am wondering if any of these patches are addressing this
> behavior.

If its a regressio no.

> No kernel panic like before, but not what I was hoping for.
> I have also tried sixpack, and that explodes instantly the last time I
> have checked.   That goes all the way back to the v4 kernels. 

Are you reporting a separate regression that goes all the way back to v4 kernels?

> v2 is fine there.

What does this mean?

  Luis
