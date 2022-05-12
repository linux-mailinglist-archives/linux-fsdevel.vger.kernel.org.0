Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D67524EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354613AbiELNsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 09:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbiELNsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 09:48:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85316338A
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 06:48:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C3BF21C5F;
        Thu, 12 May 2022 13:48:18 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76E8513A84;
        Thu, 12 May 2022 13:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RbI3HCIQfWIIQAAAMHmgww
        (envelope-from <caster@gentoo.org>); Thu, 12 May 2022 13:48:18 +0000
Message-ID: <31c3d9d1-ad82-e500-da09-0d1d345cfcbc@gentoo.org>
Date:   Thu, 12 May 2022 15:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Appoint myself page cache maintainer
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202849.666756-1-willy@infradead.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>
From:   Vlastimil Babka <caster@gentoo.org>
In-Reply-To: <20220508202849.666756-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/22 22:28, Matthew Wilcox (Oracle) wrote:
> This feels like a sufficiently distinct area of responsibility to be
> worth separating out from both MM and VFS.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d47c5e7c6ae..5871ec2e1b3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14833,6 +14833,18 @@ F:	Documentation/core-api/padata.rst
>  F:	include/linux/padata.h
>  F:	kernel/padata.c
>  
> +PAGE CACHE
> +M:	Matthew Wilcox (Oracle) <willy@infradead.org>
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Supported
> +T:	git git://git.infradead.org/users/willy/pagecache.git
> +F:	Documentation/filesystems/locking.rst
> +F:	Documentation/filesystems/vfs.rst
> +F:	include/linux/pagemap.h
> +F:	mm/filemap.c
> +F:	mm/page-writeback.c
> +F:	mm/readahead.c
> +
>  PAGE POOL
>  M:	Jesper Dangaard Brouer <hawk@kernel.org>
>  M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>

