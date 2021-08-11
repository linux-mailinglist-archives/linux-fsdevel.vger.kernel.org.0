Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1329B3E9307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhHKNuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:50:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60382 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhHKNuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:50:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22F631FED5;
        Wed, 11 Aug 2021 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628689796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1RwMkH/G5AGGvy1Dh9XSu4PN1WkDLHpM6h1JDnu2JY=;
        b=uloM6ZRycUFRyFceks2pPLD/WgBWOkTU+T+gYe0I6bPq0/0FxZCzvZTrJBt74miB87Mf4i
        Qg9Y8qer8SVdJXuw42HbVICgygwW3MOcxIahdTAfzuxAaQSn92EW1LOBx8ofqDAczFat9E
        X3xFJe214Iv27pUI7jVexeJuSmiD7aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628689796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1RwMkH/G5AGGvy1Dh9XSu4PN1WkDLHpM6h1JDnu2JY=;
        b=s0+6c/cnKA7HOyKSM79bQzXkIzrYgerN95dCC8jgnx/Di82uvMwwCnbTy9APK+lOmZeKaj
        hNqIl2mDAqVXqRBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 04ACC13969;
        Wed, 11 Aug 2021 13:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SnhuO4PVE2HgQAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:49:55 +0000
Subject: Re: [PATCH v14 050/138] mm/workingset: Convert workingset_activation
 to take a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-51-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8c733e7d-15cc-64a9-c049-869437e55b41@suse.cz>
Date:   Wed, 11 Aug 2021 15:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-51-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This function already assumed it was being passed a head page.  No real
> change here, except that thp_nr_pages() compiles away on kernels with
> THP compiled out while folio_nr_pages() is always present.  Also convert
> page_memcg_rcu() to folio_memcg_rcu().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
