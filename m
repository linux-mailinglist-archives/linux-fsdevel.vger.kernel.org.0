Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531953EA874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhHLQWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:22:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHLQWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:22:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7ECB41FD64;
        Thu, 12 Aug 2021 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628785298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppTMYje51Px+0V+L0Ygr5i3EGkcSrH/dpX1HN2hDd/0=;
        b=YwuBWMZHq6JzJK1VThBUHkluUBZ8Yxpb07g+Ad+YVXm73E7tWYiz6oPpk0vEiKkeecMSni
        eY7DoP+OqKg7Cgzi3mog+v/MNAIHV1N5Wg2TTIIJeRokXiyEMOur0iJYxFRMlwt/EIWe9f
        XbZcNyxWGSNFbihTh9X00EE0pawe3ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628785298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppTMYje51Px+0V+L0Ygr5i3EGkcSrH/dpX1HN2hDd/0=;
        b=5uJlCAvKZZvTPJLi0Ug5Fg0AACkX8+hy8kXXAWA44yftj029lmJZ6765mga699jhJPD2il
        9c2FJB2E0CV4fNAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 695DF13ACC;
        Thu, 12 Aug 2021 16:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xvgRGZJKFWHmfwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:21:38 +0000
Subject: Re: [PATCH v14 073/138] mm/writeback: Add folio_cancel_dirty()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-74-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bc939652-c652-4a49-0d6d-9d0f73a9b756@suse.cz>
Date:   Thu, 12 Aug 2021 18:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-74-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Turn __cancel_dirty_page() into __folio_cancel_dirty() and add wrappers.
> Move the prototypes into pagemap.h since this is page cache functionality.
> Saves 44 bytes of kernel text in total; 33 bytes from __folio_cancel_dirty
> and 11 from two callers of cancel_dirty_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
