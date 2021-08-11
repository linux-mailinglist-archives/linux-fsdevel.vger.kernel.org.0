Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB523E8E73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhHKKWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:22:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhHKKWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:22:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67B43221CD;
        Wed, 11 Aug 2021 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw8RcVYdn+HS2KkW4ugojlPb+gsAxZmY8HsxFYjxUuM=;
        b=YnAjWE4Ck25X687+o2YGZT26VKo7y6dd+r7z9wHcYMZFiyWvnD6d03UNvv7BGSuWtz1RZ+
        bDDP1kr3z2hQGJeBMHCtQ/h6fF7BDvieRewy40/mYCd//3bonh1msWasB6clQJmJrG5UL5
        xbKJh4cBeeIXfxMiZenqEvT2HgLNLbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677300;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw8RcVYdn+HS2KkW4ugojlPb+gsAxZmY8HsxFYjxUuM=;
        b=2QSzM+/jDOaunbeAmHqHnBTzY0cbhxMvZI1w2OyszUftnJYZNM7tsp3tvypn9uoaLxLRI0
        3lrgBCBibDaY4ZBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4AE9D131F5;
        Wed, 11 Aug 2021 10:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lTecEbSkE2GYDQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:21:40 +0000
Subject: Re: [PATCH v14 036/138] mm/memcg: Remove soft_limit_tree_node()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-37-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <89e066ce-7322-20a2-e105-864838ea51f0@suse.cz>
Date:   Wed, 11 Aug 2021 12:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-37-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Opencode this one-line function in its three callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Acked-by: Vlastimil Babka <vbabka@suse.cz>

