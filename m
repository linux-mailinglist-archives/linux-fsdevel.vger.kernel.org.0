Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1439336541E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhDTIaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:30:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhDTIaj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:30:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618907407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gc2OYO7Gop4pXOyn2eMOrNhPvb4JX9AiP/LihACJjrQ=;
        b=BCNcFuuvbhFnjxTxkMtniV6iWAWam2IqyWerccUoN/HC6fZYKEpWY2rM4gXw/GDh0DIDxX
        7LkSj6Fje6422drCh/GTOBK9zvwW19pEVV9/TN8slkM9hK3/2AmLZN+j3iji2Ohk0CsFvB
        ZDwJHGFz/U5maxLX/pucXx1QLqZm9no=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D66A1AE38;
        Tue, 20 Apr 2021 08:30:06 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:30:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Feng Tang <feng.tang@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2 V6]Add dma-buf counter
Message-ID: <YH6RDgoJTPWsULDs@dhcp22.suse.cz>
References: <20210420082220.7402-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420082220.7402-1-peter.enderborg@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-04-21 10:22:18, Peter Enderborg wrote:
> The dma-buf counter is a metric for mapped memory used by it's clients.
> It is a shared buffer that is typically used for interprocess communication
> or process to hardware communication. In android we used to have ION,. but
> it is now replaced with dma-buf. ION had some overview metrics that was similar.

The discussion around the previous version is still not over and as it
seems your proposed approach is not really viable. So please do not send
new versions until that is sorted out.

Thanks!
-- 
Michal Hocko
SUSE Labs
