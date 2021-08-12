Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1143EA968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhHLRZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:25:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHLRZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:25:27 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3265A1FF68;
        Thu, 12 Aug 2021 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628789101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkieCM8gHFiQA/zfOvuoQceM8wmzHr2Y9ESa0hqjH0k=;
        b=KvooY0WEwmmdEXfpMS9Gzv9mYbR+WT4gucRhUBy1NgoCprtYA2jT3r3f+wv4wLG5rHPFsA
        mHvnZbrzh9M2cNojHDhGW9+ySB3Xa/YuT1eToWOm2Chc+opwkncNoVeism8vE0cEjtsQx6
        fMaZs7RyR+WVEZUdDV92LtP3M/TwMPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628789101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkieCM8gHFiQA/zfOvuoQceM8wmzHr2Y9ESa0hqjH0k=;
        b=ZLtArrYEhg6E99DN7FB3MZVwWtblZrh8gb7q3F8oN0yBxsKjmDSXu9LBJQNLmTW0d8cAWg
        tU+IugZ1FbnQt4CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1552B13AC3;
        Thu, 12 Aug 2021 17:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0cktBG1ZFWFUDwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:25:01 +0000
Subject: Re: [PATCH v14 084/138] mm/page_alloc: Add folio allocation functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-85-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <89d1ce73-42cc-adef-1bfa-6eafb33e7b1b@suse.cz>
Date:   Thu, 12 Aug 2021 19:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-85-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> The __folio_alloc(), __folio_alloc_node() and folio_alloc() functions
> are mostly for type safety, but they also ensure that the page allocator
> allocates a compound page and initialises the deferred list if the page
> is large enough to have one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
