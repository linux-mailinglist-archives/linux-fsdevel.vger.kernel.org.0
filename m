Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF62B422213
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhJEJWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 05:22:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51142 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhJEJWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:22:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59A8B1FFFB;
        Tue,  5 Oct 2021 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633425652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf8VJfVMIA+k3Bsw/G2xHgLY8J7xFCmSVY3uxV1UuE0=;
        b=ousjmab2qPFeIHEyaA7FI4cVaHn6d2U1WkOqmsNx571ZG9fss2RfjzhZ8M2XbZxFeNoJut
        KkYSX089bN7jIbrTgOwwXYFMwvWswTBP/vi8h3HbkHe2KkEykNTk7WTzhHZ5CClMXJP+2e
        0wG6YtaEosgYvr/jFZA+2QKduI2z/d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633425652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf8VJfVMIA+k3Bsw/G2xHgLY8J7xFCmSVY3uxV1UuE0=;
        b=1SXNJ+3yLxZznTYY6j5SXI3wv8HosWt7G25kBydvsEv+oBV7oAdP/MKz5tZF1x3YWKGM2B
        d5dtPPwK3UTu7ZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1753713C1B;
        Tue,  5 Oct 2021 09:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VxndBPQYXGHkfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 09:20:52 +0000
Message-ID: <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
Date:   Tue, 5 Oct 2021 11:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <163184741778.29351.16920832234899124642.stgit@noble.brown>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/21 04:56, NeilBrown wrote:
> __GFP_NOFAIL is documented both in gfp.h and memory-allocation.rst.
> The details are not entirely consistent.
> 
> This patch ensures both places state that:
>  - there is a risk of deadlock with reclaim/writeback/oom-kill
>  - it should only be used when there is no real alternative
>  - it is preferable to an endless loop
>  - it is strongly discourages for costly-order allocations.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 55b2ec1f965a..1d2a89e20b8b 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -209,7 +209,11 @@ struct vm_area_struct;
>   * used only when there is no reasonable failure policy) but it is
>   * definitely preferable to use the flag rather than opencode endless
>   * loop around allocator.
> - * Using this flag for costly allocations is _highly_ discouraged.
> + * Use of this flag may lead to deadlocks if locks are held which would
> + * be needed for memory reclaim, write-back, or the timely exit of a
> + * process killed by the OOM-killer.  Dropping any locks not absolutely
> + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
> + * Using this flag for costly allocations (order>1) is _highly_ discouraged.

We define costly as 3, not 1. But sure it's best to avoid even order>0 for
__GFP_NOFAIL. Advising order>1 seems arbitrary though?

>   */
>  #define __GFP_IO	((__force gfp_t)___GFP_IO)
>  #define __GFP_FS	((__force gfp_t)___GFP_FS)
> 
> 
> 

