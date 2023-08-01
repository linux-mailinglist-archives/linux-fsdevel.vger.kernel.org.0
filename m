Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB876A8C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 08:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHAGMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 02:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHAGMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:12:09 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AF219A4;
        Mon, 31 Jul 2023 23:12:06 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 0256B17CA9;
        Tue,  1 Aug 2023 09:12:04 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id DD07D17CA8;
        Tue,  1 Aug 2023 09:12:03 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id D57A13C043A;
        Tue,  1 Aug 2023 09:11:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1690870305; bh=K3ToJDSb0mjMB1NLV0BUwfRmPEJudUn9AtuMI5luR6U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=g8VQ+wTIFGtpegn5u/tW44R2fuNOJ5mdhEOWERlo2uGAwt4jdYY1YoeeDuqFVo4U0
         aNfo6ZYRdJcjGbVx6zImrYA50NgX00UwUU7zEkwQHrQkNmmicTuRpjV7FrGXxh9JhJ
         dK2ADIy7PUVpdMu+utC6V/dK7/xavRUlvurILIL0=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 3716BQUG027447;
        Tue, 1 Aug 2023 09:11:27 +0300
Date:   Tue, 1 Aug 2023 09:11:26 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Joel Granados <joel.granados@gmail.com>
cc:     mcgrof@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bridge@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Joerg Reuter <jreuter@yaina.de>,
        David Ahern <dsahern@kernel.org>,
        netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Simon Horman <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com,
        Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v2 10/14] netfilter: Update to register_net_sysctl_sz
In-Reply-To: <20230731071728.3493794-11-j.granados@samsung.com>
Message-ID: <b8564ac4-ab65-6212-2241-0843413e05de@ssi.bg>
References: <20230731071728.3493794-1-j.granados@samsung.com> <20230731071728.3493794-11-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


	Hello,

On Mon, 31 Jul 2023, Joel Granados wrote:

> Move from register_net_sysctl to register_net_sysctl_sz for all the
> netfilter related files. Do this while making sure to mirror the NULL
> assignments with a table_size of zero for the unprivileged users.
> 
> We need to move to the new function in preparation for when we change
> SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro. Failing to do
> so would erroneously allow ARRAY_SIZE() to be called on a pointer. We
> hold off the SIZE_MAX to ARRAY_SIZE change until we have migrated all
> the relevant net sysctl registering functions to register_net_sysctl_sz
> in subsequent commits.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

	The IPVS part in net/netfilter/ipvs/ looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
>  net/bridge/br_netfilter_hooks.c         |  3 ++-
>  net/ipv6/netfilter/nf_conntrack_reasm.c |  3 ++-
>  net/netfilter/ipvs/ip_vs_ctl.c          |  8 ++++++--
>  net/netfilter/ipvs/ip_vs_lblc.c         | 10 +++++++---
>  net/netfilter/ipvs/ip_vs_lblcr.c        | 10 +++++++---
>  net/netfilter/nf_conntrack_standalone.c |  4 +++-
>  net/netfilter/nf_log.c                  |  7 ++++---
>  7 files changed, 31 insertions(+), 14 deletions(-)
> 

...

> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -4266,6 +4266,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	struct net *net = ipvs->net;
>  	struct ctl_table *tbl;
>  	int idx, ret;
> +	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
>  
>  	atomic_set(&ipvs->dropentry, 0);
>  	spin_lock_init(&ipvs->dropentry_lock);
> @@ -4282,8 +4283,10 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  			return -ENOMEM;
>  
>  		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> +		if (net->user_ns != &init_user_ns) {
>  			tbl[0].procname = NULL;
> +			ctl_table_size = 0;
> +		}
>  	} else
>  		tbl = vs_vars;
>  	/* Initialize sysctl defaults */
> @@ -4353,7 +4356,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  #endif
>  
>  	ret = -ENOMEM;
> -	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
> +	ipvs->sysctl_hdr = register_net_sysctl_sz(net, "net/ipv4/vs", tbl,
> +						  ctl_table_size);
>  	if (!ipvs->sysctl_hdr)
>  		goto err;
>  	ipvs->sysctl_tbl = tbl;
> diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
> index 1b87214d385e..cf78ba4ce5ff 100644
> --- a/net/netfilter/ipvs/ip_vs_lblc.c
> +++ b/net/netfilter/ipvs/ip_vs_lblc.c
> @@ -550,6 +550,7 @@ static struct ip_vs_scheduler ip_vs_lblc_scheduler = {
>  static int __net_init __ip_vs_lblc_init(struct net *net)
>  {
>  	struct netns_ipvs *ipvs = net_ipvs(net);
> +	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
>  
>  	if (!ipvs)
>  		return -ENOENT;
> @@ -562,16 +563,19 @@ static int __net_init __ip_vs_lblc_init(struct net *net)
>  			return -ENOMEM;
>  
>  		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> +		if (net->user_ns != &init_user_ns) {
>  			ipvs->lblc_ctl_table[0].procname = NULL;
> +			vars_table_size = 0;
> +		}
>  
>  	} else
>  		ipvs->lblc_ctl_table = vs_vars_table;
>  	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
>  	ipvs->lblc_ctl_table[0].data = &ipvs->sysctl_lblc_expiration;
>  
> -	ipvs->lblc_ctl_header =
> -		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblc_ctl_table);
> +	ipvs->lblc_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
> +						       ipvs->lblc_ctl_table,
> +						       vars_table_size);
>  	if (!ipvs->lblc_ctl_header) {
>  		if (!net_eq(net, &init_net))
>  			kfree(ipvs->lblc_ctl_table);
> diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
> index ad8f5fea6d3a..9eddf118b40e 100644
> --- a/net/netfilter/ipvs/ip_vs_lblcr.c
> +++ b/net/netfilter/ipvs/ip_vs_lblcr.c
> @@ -736,6 +736,7 @@ static struct ip_vs_scheduler ip_vs_lblcr_scheduler =
>  static int __net_init __ip_vs_lblcr_init(struct net *net)
>  {
>  	struct netns_ipvs *ipvs = net_ipvs(net);
> +	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
>  
>  	if (!ipvs)
>  		return -ENOENT;
> @@ -748,15 +749,18 @@ static int __net_init __ip_vs_lblcr_init(struct net *net)
>  			return -ENOMEM;
>  
>  		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> +		if (net->user_ns != &init_user_ns) {
>  			ipvs->lblcr_ctl_table[0].procname = NULL;
> +			vars_table_size = 0;
> +		}
>  	} else
>  		ipvs->lblcr_ctl_table = vs_vars_table;
>  	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
>  	ipvs->lblcr_ctl_table[0].data = &ipvs->sysctl_lblcr_expiration;
>  
> -	ipvs->lblcr_ctl_header =
> -		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblcr_ctl_table);
> +	ipvs->lblcr_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
> +							ipvs->lblcr_ctl_table,
> +							vars_table_size);
>  	if (!ipvs->lblcr_ctl_header) {
>  		if (!net_eq(net, &init_net))
>  			kfree(ipvs->lblcr_ctl_table);

Regards

--
Julian Anastasov <ja@ssi.bg>

