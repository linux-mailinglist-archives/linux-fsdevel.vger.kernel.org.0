Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740EE3EA974
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhHLRaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:30:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33248 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbhHLRaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:30:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F8681FF4A;
        Thu, 12 Aug 2021 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628789376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k10WcGFA/pe29Ss1b7yju5dG1lUVgc+nusj2i462Y2Q=;
        b=n1acCdxOoHi/hOwK/FykVs8kCYy4loFdbSNHTNSI47OYeD1r4l9uIeeqHU+f7nwKDl1Jcd
        A7FdHaQFu4HL5TFqL6kI8ATmLt5aequNNZzxQmtF+2sK/7EFC4/NZsPGl2T3YdVp5mB2rA
        W0CdOgvtOtpoQqSGAUvb7h/vtP70qjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628789376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k10WcGFA/pe29Ss1b7yju5dG1lUVgc+nusj2i462Y2Q=;
        b=DfHYBGA6jYTl8vF22h8vhgPGSQtgykjP3r+OzQ7HOpLR0ylNtntmuCrIPCSxx2ocxad2Y0
        drKiuNAfJ4FFpGBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E622313AC3;
        Thu, 12 Aug 2021 17:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id bcjkNn9aFWE3EAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:29:35 +0000
Subject: Re: [PATCH v14 085/138] mm/filemap: Add filemap_alloc_folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-86-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6191eee3-5c2b-f866-7943-1c0867b1d068@suse.cz>
Date:   Thu, 12 Aug 2021 19:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-86-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Reimplement __page_cache_alloc as a wrapper around filemap_alloc_folio
> to allow filesystems to be converted at our leisure.  Increases
> kernel text size by 133 bytes, mostly in cachefiles_read_backing_file().
> pagecache_get_page() shrinks by 32 bytes, though.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
