Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A943EA943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhHLRQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:16:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhHLRQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:16:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03070222A8;
        Thu, 12 Aug 2021 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628788581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9SAsYIoDHG5K0UlAd6yx51Dzm/eMC3YEULS2iCENOg=;
        b=xNL1kWk1xcUGl1T/J5MTUWu3omDEjpMRi7dlYmvkNdSzA9YQOyeofue70mCffr4nwtAUzL
        EQy6qoESvN+d8Hy862v87M+kqgz2f1tN7gKaAnA+VTNLafvtQ0ZUPhnYlbm3AjOEVdssq5
        dIPyE95IBxj5LBdZtM8QUyWS5RHY5bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628788581;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9SAsYIoDHG5K0UlAd6yx51Dzm/eMC3YEULS2iCENOg=;
        b=kZLSMAeUuCq8ZLTc39JZfTwGuFBv5fxMyX089Z1y2SWloaHdIDjKZKOXZRFvL/mrv5bU3g
        s0fFGstx2gXaEwAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D568713AC3;
        Thu, 12 Aug 2021 17:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nXwkM2RXFWFzDQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:16:20 +0000
Subject: Re: [PATCH v14 080/138] mm/workingset: Convert workingset_refault()
 to take a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-81-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e85f5d04-a780-622d-d6e3-80369896e7e1@suse.cz>
Date:   Thu, 12 Aug 2021 19:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-81-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> This nets us 178 bytes of savings from removing calls to compound_head.
> The three callers all grow a little, but each of them will be converted
> to use folios soon, so that's fine.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
