Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A433EA958
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhHLRVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:21:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60532 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhHLRVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:21:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCD111FF68;
        Thu, 12 Aug 2021 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628788848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFOkMXUXc2Yo2CGIvdkLteU8MEjRTfgofgAPOXF0g+8=;
        b=BqTg8QyVh50D6CZMlAIqnyM8W/vDp9jk7r0ORSXzogdUTYah6PCO1LNvSbDujLoHcXKswq
        RIH8dh0HH3JVjLeueLezRDc0DpX1nMcLk5g+sWIfV/2D26cBUVgiSEfJ3pfld7d3KaNYAP
        oM4avVj9qR2q9va3bnuApXLtvaaqWCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628788848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFOkMXUXc2Yo2CGIvdkLteU8MEjRTfgofgAPOXF0g+8=;
        b=uyJemG3clLbtK1qiCYfAZHKENc6bgN7uM1+xUlo1liygDQuHjiFxSvUcPICTP2jHIHvrnE
        +k3ybvU/zzg0F6Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9FAB613AC3;
        Thu, 12 Aug 2021 17:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id DKTNJXBYFWFkDgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:20:48 +0000
Subject: Re: [PATCH v14 082/138] mm/lru: Convert __pagevec_lru_add_fn to take
 a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-83-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bbe515d8-c214-183a-9d37-ba9005c03eaf@suse.cz>
Date:   Thu, 12 Aug 2021 19:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-83-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> This saves five calls to compound_head(), totalling 60 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
