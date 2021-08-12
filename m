Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA93EA489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhHLMVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 08:21:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55882 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhHLMVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:21:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D82C222267;
        Thu, 12 Aug 2021 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628770869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0C2zUbxltGUJk1SUgKjpetkRJDpnuUmzosGCKxRTHCQ=;
        b=HT1ZcklwtAWuX3+FcePglJdOXCqU9OXgr6/svgENJd3qke0Fn6TnCM1103YVAWhggLHhcG
        7OzDHITF5eM5Sht3i0l5qW3Ll5ovcPzSkaDY95jaYCuvJ5BDc8BuljG7uReRo/JhtdikCW
        A5eUN6PNKS2V69ghqrj+uxmeZs4f5Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628770869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0C2zUbxltGUJk1SUgKjpetkRJDpnuUmzosGCKxRTHCQ=;
        b=OHtpAb1ihAZ/W9JpmR9k8sf+CvrZFalqDiCWk2SHZmmc2TnphxZNvAJdZng4OuSJsfLOd8
        P4Lo3Qg58KSYEvCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BC50C13846;
        Thu, 12 Aug 2021 12:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id L2qYLDUSFWERRAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 12:21:09 +0000
Subject: Re: [PATCH v14 063/138] mm/writeback: Rename __add_wb_stat() to
 wb_stat_mod()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-64-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4ed4b6a3-bd9a-c308-0c20-b1a3063d7728@suse.cz>
Date:   Thu, 12 Aug 2021 14:21:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-64-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Make this look like the newly renamed vmstat functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/backing-dev.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 44df4fcef65c..a852876bb6e2 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -64,7 +64,7 @@ static inline bool bdi_has_dirty_io(struct backing_dev_info *bdi)
>  	return atomic_long_read(&bdi->tot_write_bandwidth);
>  }
>  
> -static inline void __add_wb_stat(struct bdi_writeback *wb,
> +static inline void wb_stat_mod(struct bdi_writeback *wb,
>  				 enum wb_stat_item item, s64 amount)
>  {
>  	percpu_counter_add_batch(&wb->stat[item], amount, WB_STAT_BATCH);
> @@ -72,12 +72,12 @@ static inline void __add_wb_stat(struct bdi_writeback *wb,
>  
>  static inline void inc_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
>  {
> -	__add_wb_stat(wb, item, 1);
> +	wb_stat_mod(wb, item, 1);
>  }
>  
>  static inline void dec_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
>  {
> -	__add_wb_stat(wb, item, -1);
> +	wb_stat_mod(wb, item, -1);
>  }
>  
>  static inline s64 wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
> 

