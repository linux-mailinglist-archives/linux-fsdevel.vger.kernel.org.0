Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8C3E9261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhHKNRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:17:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56278 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhHKNRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:17:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4AC020178;
        Wed, 11 Aug 2021 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628687849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVCLfCFvwJauS930PmgecQwLOMOK/vjNwnwDUMr16AE=;
        b=odE9maepLGWkNwngSUKZhRC60CXLr8GnRmDdHjc9uU4MAWYUefYWdj9JXQPQDqowGsbMz8
        gGxg7PhpIKE8Ys90EEAtKmX1xcZICsSppPs8HcpyzvCt+QeoqEX3vwMPSJRN9HF1t1Cdb/
        KBACuyNAXkYBS/Wcf+KGgrzwV9iINLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628687849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVCLfCFvwJauS930PmgecQwLOMOK/vjNwnwDUMr16AE=;
        b=GyVBEWsfFC33uvoW9povXLXWMKdv3VptMn3pXiY62/uDYlSt2XOAg9RxVwoco5khpjQe02
        lGRlSkoIR6tl2SAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 96D5A136D9;
        Wed, 11 Aug 2021 13:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vDfJI+nNE2FBOQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:17:29 +0000
Subject: Re: [PATCH v14 045/138] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-46-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a08539d-6a07-02b7-a9b0-a374aa6c88a0@suse.cz>
Date:   Wed, 11 Aug 2021 15:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-46-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of lock_page_memcg() and
> unlock_page_memcg().
> 
> lock_page_memcg() and unlock_page_memcg() have too many callers to be
> easily replaced in a single patch, so reimplement them as wrappers for
> now to be cleaned up later when enough callers have been converted to
> use folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
