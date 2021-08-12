Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E654E3EA95E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhHLRW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:22:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbhHLRW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:22:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB6871FD9F;
        Thu, 12 Aug 2021 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628788921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0p8vmEZNtTc7G27OtHRUgOe8jO1KXKpRv9NbmMzZbA=;
        b=HXIFR+5EDwH78sHuGi8ouJopj48qRV3LXPZOHkQaw/RybV8F2IErD8Izi/k27yTIp5HwqM
        fPvMyDvBNTY1iqIOAjZaX71dCQUmT8MCejllMkngVuO1S9OcAEcg/jdOpqL34LBKqF7GOk
        YsTUVuIsZHm/8DNAKACXsHDep4xrXZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628788921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0p8vmEZNtTc7G27OtHRUgOe8jO1KXKpRv9NbmMzZbA=;
        b=68x+i4qKX2tbv46pB1AHQ+IbafxsaOepEfupi8LmBAlLniOAKMZBrZqPp3VugYl19lj3S4
        6MWFw8nhlSIuHdDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 978BB13AC3;
        Thu, 12 Aug 2021 17:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Sl5uJLlYFWGnDgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:22:01 +0000
Subject: Re: [PATCH v14 083/138] mm/lru: Add folio_add_lru()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-84-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0dbf230b-3d72-a144-21c4-ffa08708fc89@suse.cz>
Date:   Thu, 12 Aug 2021 19:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-84-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Reimplement lru_cache_add() as a wrapper around folio_add_lru().
> Saves 159 bytes of kernel text due to removing calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
