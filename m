Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496B63E9228
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhHKNEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:04:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54966 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhHKNEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:04:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D4FF1FD5C;
        Wed, 11 Aug 2021 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628687065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKUDqdH+Ck+qA/eO438nPHZ7Xzz7RQuWwVYU7Z2tDts=;
        b=KtUk6FZq1EDf29APsivm4f1BqXSCJ9YfXqia0IsExrUBv1faExu5cqxhCTU9sovrorEHVY
        x2/F8Tx1Cctj2mo63+eG1FGAo/83IYATLoCggoBqkfdDYrHpgkxt++AWGYDv5EKXGIuw5Y
        rYuuzh2dcUFP0Qwmy+DaUaYq4ulwoO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628687065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKUDqdH+Ck+qA/eO438nPHZ7Xzz7RQuWwVYU7Z2tDts=;
        b=yJS78yiyyT1U/9G/2CiRm0SEDspKWYtXrPJJm1TPdrcbPCY0p04YKmf5qIC9+froQWkRff
        W99qo9fp8VzO3ICg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1752C136D9;
        Wed, 11 Aug 2021 13:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lBMRBdnKE2HjNQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:04:25 +0000
Subject: Re: [PATCH v14 042/138] mm/memcg: Convert mem_cgroup_uncharge() to
 take a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-43-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <966f19b6-b548-471f-737d-e27f130af376@suse.cz>
Date:   Wed, 11 Aug 2021 15:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-43-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Convert all the callers to call page_folio().  Most of them were already
> using a head page, but a few of them I can't prove were, so this may
> actually fix a bug.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
