Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9FE3E92D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhHKNlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:41:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhHKNlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:41:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34B5822204;
        Wed, 11 Aug 2021 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628689238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjFqR7vJo7RtWPWOJIW5ZNJ9WTIMNJsq4hJGJ7n5+Ng=;
        b=2e90UVHJ4cWAkzPDXUcQonr8Ovytf6jkP41WiKSpuQfj/cE2omRF2XLEB9IdICMYWfitfS
        04KrdWgzprf07ihbHLGvH5blL+3T1IGDcI+R/KpQaKI+t66qkRjXXiDaPkIkjwQzSn8A01
        nNTgrKlcAe+0OBtdeUBw2hU4xEMXX/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628689238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjFqR7vJo7RtWPWOJIW5ZNJ9WTIMNJsq4hJGJ7n5+Ng=;
        b=NiD5alPFccwMm4BIwO5XErZvAW7y201197szUm8ni9C0Gw5mRJG8+gIN6w+8bLngc+2jfO
        8UU3OIlASrfCLPAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1E9B513969;
        Wed, 11 Aug 2021 13:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FdzWBlbTE2G9PgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:40:38 +0000
Subject: Re: [PATCH v14 048/138] mm/memcg: Add folio_lruvec_lock() and similar
 functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-49-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6041f5c0-cf18-1170-6509-fba5dd1fc029@suse.cz>
Date:   Wed, 11 Aug 2021 15:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-49-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of lock_page_lruvec() and similar
> functions.  Also convert lruvec_memcg_debug() to take a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
