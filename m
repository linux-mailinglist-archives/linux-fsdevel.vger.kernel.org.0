Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49953E93D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhHKOoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:44:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40842 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhHKOoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:44:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 617671FED8;
        Wed, 11 Aug 2021 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628693032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPspfE+FbIYzctxtQFGxp/gtyU/q6a3ORCDMirvwdek=;
        b=McZ71LHMYKhjMdSNnS874Px/WT6TLXR1FS1IzwUABAxiPgAT1robaDjLqioD2BNev9AB5K
        uIeNUnpGefmQDDBe87KoD/uvew6YKmyAu1V5O6nJ83Tr1PfV1xHgyEtCVmOn298nBRbVv7
        hDCmbbp1IH5EaEzWUWtMPEwajDcgwHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628693032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPspfE+FbIYzctxtQFGxp/gtyU/q6a3ORCDMirvwdek=;
        b=WqJvWAK2vZN8mhPYZRNJcF2BmOh2tJLUaowPnU3yhZNE9VRDL0H4XV5VKs40cU+Gcw3ZTF
        rv8jRYO6c3/zlNAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 38FC6136D9;
        Wed, 11 Aug 2021 14:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FFUKDCjiE2HfTwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 14:43:52 +0000
Subject: Re: [PATCH v14 057/138] mm/swap: Add folio_activate()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-58-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ec410527-6dda-5ea0-de3a-d66767748f45@suse.cz>
Date:   Wed, 11 Aug 2021 16:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-58-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This replaces activate_page() and eliminates lots of calls to
> compound_head().  Saves net 118 bytes of kernel text.  There are still
> some redundant calls to page_folio() here which will be removed when
> pagevec_lru_move_fn() is converted to use folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
