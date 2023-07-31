Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3A76A073
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGaSai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 14:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGaSag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECB1BC3;
        Mon, 31 Jul 2023 11:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE5061245;
        Mon, 31 Jul 2023 18:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082BDC433C7;
        Mon, 31 Jul 2023 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690828234;
        bh=azdNP8cF85m7UDvgXMTAEEGyM/wWyMIGFgmuwIc8ul0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1VpJucJ8qJ4G6AE1OKV3xdN/xK/FDklzv/nwqYZajcZtRy+LSUQU50X+sHs9AxvB
         xsU2buC2SUK4CZR3jjYJZtrydR9Bbqd9WCPwdG5zMYEjJLfGD0nXQIDtdar/ei7qKh
         Q4AFqyXfVyBH57dywLI4uw0Frcitouu9e42wpiwCGypovk04FOzCfl60zxzFG2eyak
         ANZHJkor5YlN+5saTB/xwrXYhgw16Q93h89m9IIkWKyhNAHwsbqX1ZrfONEa6iuY6k
         btG9dsvLFpB0/w7f/xaTE6xEYGtgYWH7rF7vGs2JSC6YVtwrN6iixwxcTNdpmmdRV2
         wiQHQ/+OXxCxw==
Date:   Mon, 31 Jul 2023 20:30:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     Joel Granados <joel.granados@gmail.com>
Cc:     mcgrof@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
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
Subject: Re: [PATCH v2 03/14] sysctl: Add ctl_table_size to ctl_table_header
Message-ID: <ZMf9vZpGE98oM9W2@kernel.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-4-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731071728.3493794-4-j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:17:17AM +0200, Joel Granados wrote:
> The new ctl_table_size element will hold the size of the ctl_table
> arrays contained in the ctl_table_header. This value should eventually
> be passed by the callers to the sysctl register infrastructure. And
> while this commit introduces the variable, it does not set nor use it
> because that requires case by case considerations for each caller.
> 
> It provides two important things: (1) A place to put the
> result of the ctl_table array calculation when it gets introduced for
> each caller. And (2) the size that will be used as the additional
> stopping criteria in the list_for_each_table_entry macro (to be added
> when all the callers are migrated)
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  include/linux/sysctl.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 59d451f455bf..33252ad58ebe 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -159,12 +159,22 @@ struct ctl_node {
>  	struct ctl_table_header *header;
>  };
>  
> -/* struct ctl_table_header is used to maintain dynamic lists of
> -   struct ctl_table trees. */
> +/**
> + * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
> + * @ctl_table: pointer to the first element in ctl_table array
> + * @ctl_table_size: number of elements pointed by @ctl_table
> + * @used: The entry will never be touched when equal to 0.
> + * @count: Upped every time something is added to @inodes and downed every time
> + *         something is removed from inodes
> + * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
> + * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
> + *
> + */

Hi Joel,

Please consider also adding kernel doc entries for the other fields of
struct ctl_table_header. According to ./scripts/kernel-doc -none
they are:

  unregistering
  ctl_table_arg
  root
  set
  parent
  node
  inodes


>  struct ctl_table_header {
>  	union {
>  		struct {
>  			struct ctl_table *ctl_table;
> +			int ctl_table_size;
>  			int used;
>  			int count;
>  			int nreg;
> -- 
> 2.30.2
> 
