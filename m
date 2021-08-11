Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E13E93FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhHKOxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:53:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhHKOxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:53:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D05B1FED8;
        Wed, 11 Aug 2021 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628693558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eys1WxciEg1/dC1Kxm9kbihHRWLI/mIwKljkXQDaqoY=;
        b=h+7xw3eXEJH/u7ItYpnHWwaVcyK+1cIQddfQyF4duqUtTQTejCze+QpDO9Zl2SUMC8tY0n
        Xc5quF6Sa+9giqfM0OyqRCHQBMWylIppbi+zxVaQWIwYzieV2EseD/VMiFsmjQI/g4cKst
        9XNvVM/3sak5jAvwelxM2PSAlGttmPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628693558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eys1WxciEg1/dC1Kxm9kbihHRWLI/mIwKljkXQDaqoY=;
        b=6W5ZXZYn9nn0SLrEOcyvilpqUqGmcgocIKE8Ghempfy96IFtQjUfNJw+83aGh5hFsJCdOl
        SCw09Ol5q+h/2vDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5E61F136D9;
        Wed, 11 Aug 2021 14:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pA+2FTbkE2EUUgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 14:52:38 +0000
Subject: Re: [PATCH v14 059/138] mm/rmap: Add folio_mkclean()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-60-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bd5a5a0e-711b-21b0-09d4-56a7b496b557@suse.cz>
Date:   Wed, 11 Aug 2021 16:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-60-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Transform page_mkclean() into folio_mkclean() and add a page_mkclean()
> wrapper around folio_mkclean().
> 
> folio_mkclean is 15 bytes smaller than page_mkclean, but the kernel
> is enlarged by 33 bytes due to inlining page_folio() into each caller.
> This will go away once the callers are converted to use folio_mkclean().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
