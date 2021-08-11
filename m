Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66673E9426
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhHKPAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 11:00:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60904 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhHKPAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:00:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A22F9221BF;
        Wed, 11 Aug 2021 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628693999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MciToW3SFUh+Fm8yPjWHXnDJfhQxrSPXbDGjkDcJjIU=;
        b=T2jopGmElVX5HHcg6MVQqGTHem4aEPi/TYzg0HO9JBSCcTpDMJugMz52Voctr68lF4/zFN
        21JGiJqaz/Jk8tfyt6TmAww+DrNuYOwOSeGJZCY6VMOHnglvNu4ukUjrxiFdYORRNnzwiZ
        IajSUbamGFAY+slF8Nsdasx652it0B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628693999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MciToW3SFUh+Fm8yPjWHXnDJfhQxrSPXbDGjkDcJjIU=;
        b=ob/f2cK6yraH9NykvMqpK+NziI5y0mr5Xcr9z3otBhLXhhuiA3xml/n7G/w+Jq6LF0RKSj
        nIviqPxNoozVYoBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 82949136D9;
        Wed, 11 Aug 2021 14:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SzKSHu/lE2HeUwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 14:59:59 +0000
Subject: Re: [PATCH v14 060/138] mm/migrate: Add folio_migrate_mapping()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-61-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0c1cfbd5-9e1c-b801-642b-1eb313533252@suse.cz>
Date:   Wed, 11 Aug 2021 16:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-61-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Reimplement migrate_page_move_mapping() as a wrapper around
> folio_migrate_mapping().  Saves 193 bytes of kernel text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
