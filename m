Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89943EA83E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhHLQHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:07:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhHLQHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:07:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3191F222AC;
        Thu, 12 Aug 2021 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628784426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+oIb/f55c+3egx/QhP8HshNAhJJ04qmEMqONaepnbu8=;
        b=WDMMlHYCLY1XN65yO+0Pq+Vsd6reljX6jQm0SCfllsJc6Mhk000r/P9qocNxFkUfW2G0mX
        SKvBBLq2u6zWLYA/NmI9jlHhwu9Fx9MhibEDi8cUYTty7TJcBh5Mrw17fJA6qBTkBELKtJ
        ZLYF28c/7LyvRkYqhr5Uwd2BhQBVBRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628784426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+oIb/f55c+3egx/QhP8HshNAhJJ04qmEMqONaepnbu8=;
        b=FpUSDrG2VlF2ApljuXOkh75NupRm4mN1igl0LD+W9yvYGnLst63PIbgTyVkg7dh22u8ZpA
        EOahwVRyJuwFG6Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1CA2813ACC;
        Thu, 12 Aug 2021 16:07:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7HhaBipHFWGCfAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:07:06 +0000
Subject: Re: [PATCH v14 071/138] mm/writeback: Add filemap_dirty_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-72-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e393b874-eb35-7b78-8919-838a8149d259@suse.cz>
Date:   Thu, 12 Aug 2021 18:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-72-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Reimplement __set_page_dirty_nobuffers() as a wrapper around
> filemap_dirty_folio().

I assume it becomes obvious later why the new "mapping" parameter instead of
taking it from the folio, but maybe the changelog should say it here?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
