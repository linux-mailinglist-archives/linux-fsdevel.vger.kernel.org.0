Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579603E930F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhHKNw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:52:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhHKNw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:52:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 200171FED5;
        Wed, 11 Aug 2021 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628689953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twhLR3o79XPbMDwUInBg5VcjicjJzvS60Z05Q+fnPnE=;
        b=k4RFQWulATEXYCwV4udZ/mtd+xuyqcsDwfIZ7MRM6pXPYqkHNQ1fU1AdF+EiepqlIBRs8c
        c7hox/0CbSL6hGPPIXCduEflq9Qz/OB4EKGgBAzMy8V1tyME1OW06kayDYY7w0h7lgfKXa
        CqyJ4L/JiBETw1exhKSWw0riCA7343w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628689953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twhLR3o79XPbMDwUInBg5VcjicjJzvS60Z05Q+fnPnE=;
        b=gxifDtuqq5xnOFeKT7L5Xk5wj4nRZawageS3Gl67zsFPNLf27djdXnfVrdHlJnfL0GcJr0
        4WYuwvqOIWcBI9Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0542813969;
        Wed, 11 Aug 2021 13:52:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +qMMACHWE2GAQQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:52:32 +0000
Subject: Re: [PATCH v14 051/138] mm: Add folio_pfn()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-52-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <90afb296-bfc0-451a-9cc2-cd487105a2a0@suse.cz>
Date:   Wed, 11 Aug 2021 15:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-52-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_to_pfn().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
