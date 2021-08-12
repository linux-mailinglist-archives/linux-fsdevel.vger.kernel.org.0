Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C373EA886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHLQ2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:28:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43304 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHLQ2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:28:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C36E9212B7;
        Thu, 12 Aug 2021 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628785676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k93sVlUdvzHgoAb48Di7b3b2yeDtL4uyg3kAIfdc3Tc=;
        b=gpSuNaWLIwfLZCdToFJhTEI/Nyl3KJeil0sGyw63bQ3luajDhw+y/WGbvGHHb0xHlAtI6i
        qVq3De4Puy2dmo5aZ0bJ9MieqWSVwYBFvC7kOXHdePjtwQiEEMTckxKUG+KySw4YdIlxVA
        7qOj2M/Q5Y8fhYo04fxg+EvUY2G2Cnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628785676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k93sVlUdvzHgoAb48Di7b3b2yeDtL4uyg3kAIfdc3Tc=;
        b=nQ1kY2yKV+SGzMZDZRMRULKs2fBVnPEa+zovo+52+FMB5Y0DZOeJ5CwJyo9FWqA1WLEdzS
        3R6yuwhrkzcyRxBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A3DD113ACC;
        Thu, 12 Aug 2021 16:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6yKvJgxMFWFxAgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:27:56 +0000
Subject: Re: [PATCH v14 075/138] mm/writeback: Add folio_account_redirty()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-76-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <dc85aacf-782a-d1e6-3075-8439c52f3401@suse.cz>
Date:   Thu, 12 Aug 2021 18:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-76-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Account the number of pages in the folio that we're redirtying.
> Turn account_page_dirty() into a wrapper around it.  Also turn
> the comment on folio_account_redirty() into kernel-doc and
> edit it slightly so it makes sense to its potential callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
