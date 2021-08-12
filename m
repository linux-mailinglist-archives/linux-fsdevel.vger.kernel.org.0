Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9233EA822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhHLP7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:59:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50424 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhHLP7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:59:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FDD21FF60;
        Thu, 12 Aug 2021 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628783919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/Uo2X+ifUdwK1YknZqkDkEjVa5xHLcDRfSTtPdbQxM=;
        b=GzXe5epf/M63UeaqkpVE4gWop8AifrxMTc43gBDSYoSOWUeFQujyAiAI5olQ1wK1T3SPlJ
        uznWA+2mBzqlyvFG7y9Gom3Q31tEJ0yaQ+d8e8aBOx57mJ1ZToNV+w2xUB/g1hbjljurgs
        dB8WHTutS1cwQeu38IXp3M/IkOJFrHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628783919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/Uo2X+ifUdwK1YknZqkDkEjVa5xHLcDRfSTtPdbQxM=;
        b=mfJFPWglDbac66vEFR2TGUYNc8eZ4n7Tt+Qrg5/CF12UiD+k1Hyvnj75no+Hl2t64XBhj3
        kudbHQpGkhNer0AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2635213ACC;
        Thu, 12 Aug 2021 15:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3SAQCC9FFWF2egAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 15:58:39 +0000
Subject: Re: [PATCH v14 069/138] mm/writeback: Add __folio_mark_dirty()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-70-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bf015cd5-cd8a-df51-1c29-1b7d7f8b942d@suse.cz>
Date:   Thu, 12 Aug 2021 17:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-70-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Turn __set_page_dirty() into a wrapper around __folio_mark_dirty().
> Convert account_page_dirtied() into folio_account_dirtied() and account
> the number of pages in the folio to support multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
