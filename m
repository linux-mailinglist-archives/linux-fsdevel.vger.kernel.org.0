Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60633E8EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhHKKoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:44:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53626 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbhHKKoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:44:34 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C98E420154;
        Wed, 11 Aug 2021 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628678649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mBNvojtoZo2JWl/cCRXvU08N3B2Jnv5Ah6/y1qeLjI=;
        b=l/8jtUM3wVZlQJZngACo4L3ThNn37kqgkAFB1GhWRRGqtXFRUFIH7XoPfXPHZfJle3uS/n
        uperYESffOXpQMK6YOX8ukkvaVPdfiV91UvVmQkMePmRUfp2ZLOQorqKr8rha7CbYWdKpg
        KAZRKre6zom0dhFnMyfWjHIqsw74il0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628678649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mBNvojtoZo2JWl/cCRXvU08N3B2Jnv5Ah6/y1qeLjI=;
        b=f02aGWx/oqWc4qgKOPfBerg4TEKZMx1sW8LBhTlQbfBLsgirLoUzpVbQn+JQju7O5zZVIf
        ftDE0PN4ypWHurDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A6230131F5;
        Wed, 11 Aug 2021 10:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 01PsJ/mpE2H5EgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:44:09 +0000
Subject: Re: [PATCH v14 039/138] mm/memcg: Convert commit_charge() to take a
 folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-40-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <29af0e12-4294-bd8e-f113-a6df609ab180@suse.cz>
Date:   Wed, 11 Aug 2021 12:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-40-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> The memcg_data is only set on the head page, so enforce that by
> typing it as a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michal Hocko <mhocko@suse.com>


Acked-by: Vlastimil Babka <vbabka@suse.cz>

