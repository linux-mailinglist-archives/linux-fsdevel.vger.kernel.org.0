Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02E43EA82A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHLQCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:02:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50842 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhHLQCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:02:22 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6C131FF5E;
        Thu, 12 Aug 2021 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628784116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPhnNS5Lt3hTtv5CGAAKeS/ZlOC2oJYMF3VPmbpRxNs=;
        b=NqWnaZRFhvdX7cigxZlNR1ntsE46MTGqPsykjW048Lp6oFkRrvPRzp4HKfDfoA644G5UF3
        FGn53/kGpc3wBl1cZECteWiw3TDRxuNnzmvvqEeqj1FpJk2vYUYknvWXjs+gCjd6AJoGYC
        j97Zgi4PMA/fMttZl165IbLulomfMS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628784116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPhnNS5Lt3hTtv5CGAAKeS/ZlOC2oJYMF3VPmbpRxNs=;
        b=dFVYxGIZgbfmCL++j/MGEfTtVdUOVwNidhCtp0xnUTkd7cxNx7NT4cZ5qI8z8KRrSlB0Xb
        Ab/B7CqcnDIpUyBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9662813ACC;
        Thu, 12 Aug 2021 16:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 9R4kJPRFFWFHewAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:01:56 +0000
Subject: Re: [PATCH v14 070/138] mm/writeback: Convert tracing
 writeback_page_template to folios
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-71-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <401213ec-80be-dfb8-67d9-f368a39bd811@suse.cz>
Date:   Thu, 12 Aug 2021 18:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-71-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Rename writeback_dirty_page() to writeback_dirty_folio() and
> wait_on_page_writeback() to folio_wait_writeback().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
