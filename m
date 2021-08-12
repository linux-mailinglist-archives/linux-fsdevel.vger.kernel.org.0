Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D683EA951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhHLRST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:18:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60206 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhHLRSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:18:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F16F1FD9F;
        Thu, 12 Aug 2021 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628788671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcywJgi9gksH/f5S4hsvkZUN3GTX+1C7qHHK8T8dm/8=;
        b=vEGQomdIec8giJ2tJMGTVgemgawfFjp0SvK+NMMws5NuVqhYQ5toYIFCszBCssKwSaYgy3
        6lXaRz+6XEAT1CVc89/O0i/+JVfnRjyPZI0C0RRP4wsj6/jxYBCNs2c/xEhNcr6hsdum0X
        qiMbGrEfRZdD6rEUBPTrZTFIIjAe3ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628788671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcywJgi9gksH/f5S4hsvkZUN3GTX+1C7qHHK8T8dm/8=;
        b=SZhE+duC6JwS4oL2S9m7ScF0CoS2ScM81QQ8QsiB3DseZ2xZGp7nMfktSFFN4I2rBVOFzb
        LHUPMDwSK1wKZ6DQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8B0C113AC3;
        Thu, 12 Aug 2021 17:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WIJkIb9XFWG5DQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:17:51 +0000
Subject: Re: [PATCH v14 081/138] mm: Add folio_evictable()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-82-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ca03d1e1-a727-fe2f-2653-ad358fb62398@suse.cz>
Date:   Thu, 12 Aug 2021 19:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-82-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_evictable().  Unfortunately, it's
> different from !folio_test_unevictable(), but I think it's used in places
> where you have to be a VM expert and can reasonably be expected to know
> the difference.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
