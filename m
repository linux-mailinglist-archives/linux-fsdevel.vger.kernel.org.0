Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAE3E9379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhHKOUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:20:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhHKOUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:20:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D82B422209;
        Wed, 11 Aug 2021 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628691576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryzwJWAVBGY25h1BYH39QYdUIbta9T+6HGoCPAbW6TI=;
        b=Vh0bC5DCi82XlVPM7M7SAKkfkvJ5WAUpo6S4HH1Qzi8ABuQRuuedJ6GUmCWE9qRHffHTpd
        3sl9fmVntOUr+KVFryNetrLG260GJLPRyHbwY80cquNe1Utiorh+LE4Lj+OpGZj7PnVKbu
        6RcqaPvbtVZQI4x70/+TluXiGTYhmfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628691576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryzwJWAVBGY25h1BYH39QYdUIbta9T+6HGoCPAbW6TI=;
        b=Uluh5BXmW6eZ+IHKpWHzSEK9QSbML7l7lFNXLxz8L8rD4epbArwgchrbPk+Dm8lbUh+1DT
        7y9FuF5/7YHt11Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B8DAC13969;
        Wed, 11 Aug 2021 14:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id d6EcLHjcE2HgSQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 14:19:36 +0000
Subject: Re: [PATCH v14 055/138] mm: Add arch_make_folio_accessible()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-56-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aa09a86d-bd0a-57c5-4627-2df8e7d8aa80@suse.cz>
Date:   Wed, 11 Aug 2021 16:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-56-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> As a default implementation, call arch_make_page_accessible n times.
> If an architecture can do better, it can override this.
> 
> Also move the default implementation of arch_make_page_accessible()
> from gfp.h to mm.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
