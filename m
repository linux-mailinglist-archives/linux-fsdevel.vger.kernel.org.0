Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF3B3E9321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhHKN7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:59:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53060 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhHKN7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:59:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E620222213;
        Wed, 11 Aug 2021 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628690346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xIMLqqj+ACXa30EMHHZHuSRAZbV1Yhwen5eQ3Ve574=;
        b=AfhtDVLLi5FNvHNlaB5Ew1nyvka4XVmzVYmU+M/4xA0c4H9y+DqcxSn5t6SaMKJ+ePMMfj
        pfg3aj7U1kKeBVgmYgxv2DH8oVrxhq5ln05kipgvssq4mdMk969iIAh6slkQIJnYVMDQF3
        mGWDUxxyICXt8P4Do5gx9ycPOjygNRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628690346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xIMLqqj+ACXa30EMHHZHuSRAZbV1Yhwen5eQ3Ve574=;
        b=x1coYBARjAB+eC0nSKfchs83K57x4S3n07TEmWqTTC69fAN1LRccCxdX2p7C188G0wgHGE
        9bDBspiXtR4P7ZCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D391213969;
        Wed, 11 Aug 2021 13:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vIT5MqrXE2F6QwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:59:06 +0000
Subject: Re: [PATCH v14 052/138] mm: Add folio_raw_mapping()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-53-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ceeeaac4-c8c5-3b03-66da-6deec35c501b@suse.cz>
Date:   Wed, 11 Aug 2021 15:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-53-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Convert __page_rmapping to folio_raw_mapping and move it to mm/internal.h.
> It's only a couple of instructions (load and mask), so it's definitely
> going to be cheaper to inline it than call it.  Leave page_rmapping
> out of line.

Maybe mention the page_anon_vma() in changelog too?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

