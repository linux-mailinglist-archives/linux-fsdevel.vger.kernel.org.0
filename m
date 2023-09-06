Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC8793BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbjIFL7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 07:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjIFL7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:59:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03655CE6;
        Wed,  6 Sep 2023 04:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54656C433C7;
        Wed,  6 Sep 2023 11:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694001544;
        bh=pijwMKIDO52W6cZE/0X85aqIGtbSV5WMCx6RXvgt2uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVNItZoeKSiQoekiXSj64CWEiqBGBeTm/5SBItzk3R3omHMc0182AoTkoVPw6cU+x
         /huJGeQ0ah7F+xr63aAQpEOdJyOGpX6/uU8BslKlUEKvLeDDCKj7AgNE4NRDc8bFU6
         Dk1cD8lAom+I07mwNGN6d2To3rHLyj8L/Xsx1byoPTJB0IWcq5Y9RK8PISj3WDALHY
         J5LzxHNovhDSFhHzPPyyjw+PUS7yI3nvJKP2m5NKG/DgG1wRv5tH6VJFmRKKv+31Fn
         8TiVCv4rj0v9Eh9NdG7nvVv0MGCNvnFDG21k0yMMYX8i38DSikl7l1o22qWjbq73LR
         kyX8yV+ZRMKcA==
Date:   Wed, 6 Sep 2023 13:58:49 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Granados <joel.granados@gmail.com>,
        linux-fsdevel@vger.kernel.org, rds-devel@oss.oracle.com,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@verge.net.au>,
        Tony Lu <tonylu@linux.alibaba.com>, linux-wpan@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        mptcp@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Will Deacon <will@kernel.org>, Julian Anastasov <ja@ssi.bg>,
        netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>,
        linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-hams@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        coreteam@netfilter.org, Ralf Baechle <ralf@linux-mips.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        keescook@chromium.org, Roopa Prabhu <roopa@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>, josh@joshtriplett.org,
        Alexander Aring <alex.aring@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, lvs-devel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        bridge@lists.linux-foundation.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Mat Martineau <martineau@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: Re: [GIT PULL] sysctl changes for v6.6-rc1
Message-ID: <ZPhpedWW6RwTd9Hf@example.org>
References: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 01:44:55PM -0700, Luis Chamberlain wrote:
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.6-rc1
> 
> for you to fetch changes up to 53f3811dfd5e39507ee3aaea1be09aabce8f9c98:
> 
>   sysctl: Use ctl_table_size as stopping criteria for list macro (2023-08-15 15:26:18 -0700)
> 
> ----------------------------------------------------------------
> sysctl-6.6-rc1
> 
> Long ago we set out to remove the kitchen sink on kernel/sysctl.c arrays and
> placings sysctls to their own sybsystem or file to help avoid merge conflicts.
> Matthew Wilcox pointed out though that if we're going to do that we might as
> well also *save* space while at it and try to remove the extra last sysctl
> entry added at the end of each array, a sentintel, instead of bloating the
> kernel by adding a new sentinel with each array moved.
> 
> Doing that was not so trivial, and has required slowing down the moves of
> kernel/sysctl.c arrays and measuring the impact on size by each new move.
> 
> The complex part of the effort to help reduce the size of each sysctl is being
> done by the patient work of el señor Don Joel Granados. A lot of this is truly
> painful code refactoring and testing and then trying to measure the savings of
> each move and removing the sentinels. Although Joel already has code which does
> most of this work, experience with sysctl moves in the past shows is we need to
> be careful due to the slew of odd build failures that are possible due to the
> amount of random Kconfig options sysctls use.
> 
> To that end Joel's work is split by first addressing the major housekeeping
> needed to remove the sentinels, which is part of this merge request. The rest
> of the work to actually remove the sentinels will be done later in future
> kernel releases.

This is very interesting for me. I'm also refactoring sysctl based on
discussion with Linus a while ago.

Could you please add me to the Cc in the next patches?

> At first I was only going to send his first 7 patches of his patch series,
> posted 1 month ago, but in retrospect due to the testing the changes have
> received in linux-next and the minor changes they make this goes with the
> entire set of patches Joel had planned: just sysctl house keeping. There are
> networking changes but these are part of the house keeping too.
> 
> The preliminary math is showing this will all help reduce the overall build
> time size of the kernel and run time memory consumed by the kernel by about
> ~64 bytes per array where we are able to remove each sentinel in the future.
> That also means there is no more bloating the kernel with the extra ~64 bytes
> per array moved as no new sentinels are created.
> 
> Most of this has been in linux-next for about a month, the last 7 patches took
> a minor refresh 2 week ago based on feedback.
> 
> ----------------------------------------------------------------
> Joel Granados (14):
>       sysctl: Prefer ctl_table_header in proc_sysctl
>       sysctl: Use ctl_table_header in list_for_each_table_entry
>       sysctl: Add ctl_table_size to ctl_table_header
>       sysctl: Add size argument to init_header
>       sysctl: Add a size arg to __register_sysctl_table
>       sysctl: Add size to register_sysctl
>       sysctl: Add size arg to __register_sysctl_init
>       sysctl: Add size to register_net_sysctl function
>       ax.25: Update to register_net_sysctl_sz
>       netfilter: Update to register_net_sysctl_sz
>       networking: Update to register_net_sysctl_sz
>       vrf: Update to register_net_sysctl_sz
>       sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
>       sysctl: Use ctl_table_size as stopping criteria for list macro
> 
>  arch/arm64/kernel/armv8_deprecated.c    |  2 +-
>  arch/s390/appldata/appldata_base.c      |  2 +-
>  drivers/net/vrf.c                       |  3 +-
>  fs/proc/proc_sysctl.c                   | 90 +++++++++++++++++----------------
>  include/linux/sysctl.h                  | 31 +++++++++---
>  include/net/ipv6.h                      |  2 +
>  include/net/net_namespace.h             | 10 ++--
>  ipc/ipc_sysctl.c                        |  4 +-
>  ipc/mq_sysctl.c                         |  4 +-
>  kernel/ucount.c                         |  5 +-
>  net/ax25/sysctl_net_ax25.c              |  3 +-
>  net/bridge/br_netfilter_hooks.c         |  3 +-
>  net/core/neighbour.c                    |  8 ++-
>  net/core/sysctl_net_core.c              |  3 +-
>  net/ieee802154/6lowpan/reassembly.c     |  8 ++-
>  net/ipv4/devinet.c                      |  3 +-
>  net/ipv4/ip_fragment.c                  |  3 +-
>  net/ipv4/route.c                        |  8 ++-
>  net/ipv4/sysctl_net_ipv4.c              |  3 +-
>  net/ipv4/xfrm4_policy.c                 |  3 +-
>  net/ipv6/addrconf.c                     |  3 +-
>  net/ipv6/icmp.c                         |  5 ++
>  net/ipv6/netfilter/nf_conntrack_reasm.c |  3 +-
>  net/ipv6/reassembly.c                   |  3 +-
>  net/ipv6/route.c                        |  9 ++++
>  net/ipv6/sysctl_net_ipv6.c              | 16 ++++--
>  net/ipv6/xfrm6_policy.c                 |  3 +-
>  net/mpls/af_mpls.c                      |  6 ++-
>  net/mptcp/ctrl.c                        |  3 +-
>  net/netfilter/ipvs/ip_vs_ctl.c          |  8 ++-
>  net/netfilter/ipvs/ip_vs_lblc.c         | 10 ++--
>  net/netfilter/ipvs/ip_vs_lblcr.c        | 10 ++--
>  net/netfilter/nf_conntrack_standalone.c |  4 +-
>  net/netfilter/nf_log.c                  |  7 +--
>  net/rds/tcp.c                           |  3 +-
>  net/sctp/sysctl.c                       |  4 +-
>  net/smc/smc_sysctl.c                    |  3 +-
>  net/sysctl_net.c                        | 26 +++++++---
>  net/unix/sysctl_net_unix.c              |  3 +-
>  net/xfrm/xfrm_sysctl.c                  |  8 ++-
>  40 files changed, 222 insertions(+), 113 deletions(-)

-- 
Rgrds, legion

