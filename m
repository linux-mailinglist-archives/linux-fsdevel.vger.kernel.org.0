Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37383E92A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhHKN3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:29:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57708 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhHKN3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:29:50 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8B422017D;
        Wed, 11 Aug 2021 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628688565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dC8hSUv3rSgS/pE9mTgD5GDPSfYgTorxemfkoTlJsv4=;
        b=cIxW15xQRfDnK2noI3aAtq9/3O564gZuuwhQWuK44sjUxhkVcUO4QQ2rPhqyMVSOHLvdmU
        D+RSYsQAD3wXctx7RL1kS1oSqhU0jrb1sL0hwkV+kSVZOxCM/1690e0wUG+a+5jMnLCguw
        VInQZWrbQ+Ha7ATv5q49j/ii7AjVUCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628688565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dC8hSUv3rSgS/pE9mTgD5GDPSfYgTorxemfkoTlJsv4=;
        b=cp/UunZda5cmSkNuKt2wXJveYybAOGhEaGqoc80Fd0K/8MH0QGWNHsswzaW++rZWkmKOQR
        wW2yL90OZGRAJdBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8B245136D9;
        Wed, 11 Aug 2021 13:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KGi5ILXQE2HuOwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:29:25 +0000
Subject: Re: [PATCH v14 046/138] mm/memcg: Convert mem_cgroup_move_account()
 to use a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-47-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <42f018ed-31fc-570c-aeac-fb8a1bb135f5@suse.cz>
Date:   Wed, 11 Aug 2021 15:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-47-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This saves dozens of bytes of text by eliminating a lot of calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
