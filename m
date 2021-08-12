Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5022C3EA9B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhHLRot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:44:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHLRor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:44:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74BD01FF6B;
        Thu, 12 Aug 2021 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628790261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjLy5j1wsZgYsAkLWE9gwStplnP2fdyuvJK9X16Uwc8=;
        b=lIGzCv0I8YlOs2Tk2VETsdI2n1dTG/ArBJfNeNJFTeMjmkytmU7iuhnI4Hah/yIKhWdE28
        gLQyvfbqGHLzxnlKFj9KAEfaJh3iyx6gZqwWDvdHjF1cx0Np6YOSWfDUm3gHF/dJLnXzTy
        ipCbzwnH4F+u5qrGq6VOQm/cMHY0EBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628790261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjLy5j1wsZgYsAkLWE9gwStplnP2fdyuvJK9X16Uwc8=;
        b=I/Uzb8Q04U6W2dEIIemlNVY5uSsyU6ekttk7DxiEItevPv0hjzKqeecSVS9qlZFo8NwDdV
        MRb0px56gIljIiAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5229D13AC3;
        Thu, 12 Aug 2021 17:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id H6AHE/VdFWFcEwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:44:21 +0000
Subject: Re: [PATCH v14 088/138] mm/filemap: Add filemap_get_folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-89-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8117c1fa-deeb-c90e-be11-a445d314caed@suse.cz>
Date:   Thu, 12 Aug 2021 19:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-89-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> filemap_get_folio() is a replacement for find_get_page().
> Turn pagecache_get_page() into a wrapper around __filemap_get_folio().
> Remove find_lock_head() as this use case is now covered by
> filemap_get_folio().
> 
> Reduces overall kernel size by 209 bytes.  __filemap_get_folio() is
> 316 bytes shorter than pagecache_get_page() was, but the new
> pagecache_get_page() is 99 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
