Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD5F3E92F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhHKNrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:47:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59942 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhHKNrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:47:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEF8D2017F;
        Wed, 11 Aug 2021 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628689600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+8kMtwkoX2RUV1prsupDlEHsO0YaxbVunuW77SL5tQ=;
        b=JFRsdkF3hFEAuLmP4Eo43wYpEZug3Svo9PNjDFrA+G2xXbqkelKnC52ZdyOH+axqsWaSfG
        jygAQu5RMuMsVvHgCuFbL/qq/qVhObt6fjaS3kk6Hyw5hrrrdH+h7IO75HIXcA0kPD4C54
        7yVF3JDmQsM1UI8+xjvG4flqlxi+ddg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628689600;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+8kMtwkoX2RUV1prsupDlEHsO0YaxbVunuW77SL5tQ=;
        b=4ax9CSpxvgp66lvXwGfHH2BMx2s2yiPaDx7sDqJM/hCJ+88X8Lc3xb06Ut7YIl9/knVuL8
        uYvs/NdJ91uFimAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B7BC213969;
        Wed, 11 Aug 2021 13:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Td4wLMDUE2EGQAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:46:40 +0000
Subject: Re: [PATCH v14 049/138] mm/memcg: Add folio_lruvec_relock_irq() and
 folio_lruvec_relock_irqsave()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-50-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1456b407-7174-e69a-42ee-dfb4fc0ab246@suse.cz>
Date:   Wed, 11 Aug 2021 15:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-50-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of relock_page_lruvec_irq() and
> folio_lruvec_relock_irqsave().  Also convert page_matches_lruvec()
> to folio_matches_lruvec().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
