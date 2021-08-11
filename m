Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00D13E8E7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhHKKX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:23:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhHKKX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:23:27 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F01281FD58;
        Wed, 11 Aug 2021 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HYjxVh7GjdSQ9Gt+qe7h+VSNCHHNx5c2pNir/GG7jk=;
        b=NLJYrcNHaiviWZaHmsTIz99lrRU37OdoAJb6Mm/ddsTifP4hEJT7wrZnkHeMqU17/N3xOG
        GMPjo+3N5C2yTeejK4SxXHD2WOneQtj4YeMcRvjzuLwbvo6kUBLoTk4/3q++Q1EsIdVRho
        GhIlTZLUFpInj9IBthWRDUyQM8xG29Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677382;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HYjxVh7GjdSQ9Gt+qe7h+VSNCHHNx5c2pNir/GG7jk=;
        b=IVwMsblQBBxatlvXYtB0Bx+Nh3rKaU0oOcMHzpxUd4NuXwtbodZ/0Rm4eZPubzTlEW980v
        vows3i8wG77rKKCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D9301131F5;
        Wed, 11 Aug 2021 10:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 9JN2NAalE2HhDQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:23:02 +0000
Subject: Re: [PATCH v14 037/138] mm/memcg: Convert memcg_check_events to take
 a node ID
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-38-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <97c033f8-d45d-6e47-90ad-dce5ad86ed52@suse.cz>
Date:   Wed, 11 Aug 2021 12:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-38-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> memcg_check_events only uses the page's nid, so call page_to_nid in the
> callers to make the interface easier to understand.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Acked-by: Vlastimil Babka <vbabka@suse.cz>

