Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCDF3EA989
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhHLRer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:34:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhHLRep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:34:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65F991FF4A;
        Thu, 12 Aug 2021 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628789659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06GmSfQsAK9oLEGik2U0DJxXrFXaSTZV4A3CmiVPa7Q=;
        b=p+TrInmgZkHgc5Y4Z9V0K6o8XVhs2SWFQsr0QtwR22ZHW933zn0quX32ZxYevb40o9lQNZ
        iaHQTU03mgS4r6hWmMVv0DMpk4G+XOZuXjYh0wY/6HGAspAmdMkm4FlpyQKsTa7ZOj5F00
        4lkAuQIytr7ckQ2QQ6BqzvYddrMlp0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628789659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06GmSfQsAK9oLEGik2U0DJxXrFXaSTZV4A3CmiVPa7Q=;
        b=9EhAcKPhi/6v1C97GOJJAJ9p+J9/fA7wkS6KAtHOzRL20KA4K9AUkj5UNqzOSxiiIxK/sA
        LAvyviAixNh7f7AA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5226813AC3;
        Thu, 12 Aug 2021 17:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BVxxE5tbFWFUEQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:34:19 +0000
Subject: Re: [PATCH v14 086/138] mm/filemap: Add filemap_add_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-87-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2505404b-9a4a-55eb-6c0a-3c084c3430c5@suse.cz>
Date:   Thu, 12 Aug 2021 19:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-87-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Convert __add_to_page_cache_locked() into __filemap_add_folio().
> Add an assertion to it that (for !hugetlbfs), the folio is naturally
> aligned within the file.  Move the prototype from mm.h to pagemap.h.
> Convert add_to_page_cache_lru() into filemap_add_folio().  Add a
> compatibility wrapper for unconverted callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
