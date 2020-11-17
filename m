Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05362B7293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 00:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKQXnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 18:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQXnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:43:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E0C0613CF;
        Tue, 17 Nov 2020 15:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7YHR2e1/LHdcwbDfdQHbOVb5eFvzBWcfcNYNhAMGlwc=; b=Omh9HHcudW9qg6FCeuzA3BMnTT
        WSKVlVHr8w8CYJdKkd+A42tomHgdm/10sLe2wCJaVvNA24LQR5ORrq5zbBso2mhk0Hh7ZioA9QB1+
        cU7h2Y+dRQwcgIzGN42g27nSA5eUpoglHxgDRKuEKdXXa3WoWesnP1B3qzWVi+ZCBXSuk4VYDWlZb
        Wi57htRt0aTL+bxJfFbUxYOBB1RuMpTSUy6pAxSfRLUy9R2nNfsymiyp/aNear1MjdJP8VFTMF5aV
        1stbt+FhLGfRTVrWaeSZ2E/3jrxzN5IW15XYmCpWW04jet7hBK5TW7rFciFenQOAOTUViNLVCLcC2
        PG/I7chw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfAco-000461-8J; Tue, 17 Nov 2020 23:43:02 +0000
Date:   Tue, 17 Nov 2020 23:43:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201117234302.GC29991@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
 <20201117153947.GL29991@casper.infradead.org>
 <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
 <20201117191513.GV29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117191513.GV29991@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> I find both of these functions exceptionally confusing.  Does this
> make it easier to understand?

Never mind, this is buggy.  I'll send something better tomorrow.
