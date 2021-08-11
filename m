Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34053E9365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhHKORj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:17:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55470 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhHKORi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:17:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C638C220E8;
        Wed, 11 Aug 2021 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628691433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xl723j198up04BkKn425KjWjCe12u51etMnxGBEI4+g=;
        b=K1FsBpOGGjzV02EWDXDQ4+ryuc6DeHzX59qTWNF0h5JJ7ciFeGp8Kbtru/9Vn3ZppmzUrR
        +eLR5Yj19geEiVVTdUUqSUgkxnrPx/0tIow64qoY6vj2NiIRhAflzEjUaznBB3tNVAhefb
        hYpgEs7lTFP1A3xIdPlf+V5l4bP92tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628691433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xl723j198up04BkKn425KjWjCe12u51etMnxGBEI4+g=;
        b=+aNHMwa4n6002kVNEZAsrd203luLPCVWa1J/3Vgzu63aINrCe683sE2lmhWi6UuwVAGkgU
        HDIwAXTLoioKWtBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B0C9513969;
        Wed, 11 Aug 2021 14:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kdCWKunbE2FDSQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 14:17:13 +0000
Subject: Re: [PATCH v14 054/138] mm: Add kmap_local_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-55-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7644cca0-3858-5238-3566-46a7328ae611@suse.cz>
Date:   Wed, 11 Aug 2021 16:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-55-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This allows us to map a portion of a folio.  Callers can only expect
> to access up to the next page boundary.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
