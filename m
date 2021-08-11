Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1C3E9238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhHKNHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:07:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhHKNHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:07:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4F0B221F7;
        Wed, 11 Aug 2021 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628687239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMEqaaybARGsEuv2GgBrFBnuSy83x/SG5H3WT5k8KMM=;
        b=hh4XEiiBRUrB/OYeA0UovCcgMYEvBwcAxwlfP+VMDEs+hJhr2uoGl4rumjgU0ywE/+ykCH
        2sceWZ+By8+zTsKzSV5tDRWBwQNvefVs75ZYUPxRXYZwluDvpR/BwRM038/81kSOL9K9o8
        raDb1q5GzvumxZ5sjzFx936MbRRWxlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628687239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMEqaaybARGsEuv2GgBrFBnuSy83x/SG5H3WT5k8KMM=;
        b=CL9YMNZl+JODHUB2GguNQpydy04NwSxizp/Z/RAYWrWIt1n5LEi9T+9Ieapxo438+FdJ+U
        opoDZbPXvXoZVOAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AEF97136D9;
        Wed, 11 Aug 2021 13:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ftYSKofLE2GLNgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 13:07:19 +0000
Subject: Re: [PATCH v14 044/138] mm/memcg: Convert
 mem_cgroup_track_foreign_dirty_slowpath() to folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-45-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <580af636-58fb-449a-1e43-7a7e97214398@suse.cz>
Date:   Wed, 11 Aug 2021 15:07:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-45-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> The page was only being used for the memcg and to gather trace
> information, so this is a simple conversion.  The only caller of
> mem_cgroup_track_foreign_dirty() will be converted to folios in a later
> patch, so doing this now makes that patch simpler.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
