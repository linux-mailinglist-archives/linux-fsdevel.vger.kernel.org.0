Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E433D343AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 08:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhCVHg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVHgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:36:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4629C061574;
        Mon, 22 Mar 2021 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z4m/M55VB8Y3G3fgFMwYGwqrWcmJ6D4rQW8q9sssEIQ=; b=Gm1IeQnOphMA/G8kD9KPrTLtUx
        UZLZWhe/Az9NvSpDvCHdNBwKdtOaML9q9Jr9CMXdaDRfmMZVNaoDeekw3lP4Iafnd2Br6M0BcwGmw
        RFRjjnAw/l42nFWSVmc1rM3cAzgVTFwHAkODa24iFHiSEgYpdVjHs8p6nEwWh8SItBsXLm1dywA0C
        l9D2BIVkJO0D2IJraVb0UXrxQHTerd8fog2R4VfFGW3lts433OtqT/atxyQDILsOUo/BSUJTqIJOl
        lv78NvyOvS/sFqkNRSw+4hoJjQdxvCxEDDcpygtBxGy41s+JqiWoEVyKbwRPeMjVfzD0wRp0Ai7ld
        zafQ1gtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOF6I-0089ls-9Z; Mon, 22 Mar 2021 07:35:53 +0000
Date:   Mon, 22 Mar 2021 07:35:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fs: document mapping helpers
Message-ID: <20210322073546.GH1719932@casper.infradead.org>
References: <20210320122623.599086-1-christian.brauner@ubuntu.com>
 <20210320122623.599086-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320122623.599086-2-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 01:26:21PM +0100, Christian Brauner wrote:
> +/**
> + * kuid_into_mnt - map a kuid down into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + * @kuid: kuid to be mapped
> + *
> + * Return @kuid mapped according to @mnt_userns.
> + * If @kuid has no mapping INVALID_UID is returned.
> + */

If you could just put the ':' after 'Return', htmldoc would put this into
a nice section for you.

I also like to include a Context: section which lists whether the
function takes locks / requires locks to be held / can be called in
hard or soft interrupt context / may sleep / requires refcounts be held /
...  Generally, what do you expect from your callers, and what your callers
can expect from you.

I don't understand the thing you're documenting, so it may not make sense
to talk about interrupt context, for example.

