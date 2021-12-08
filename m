Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD446D5AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 15:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhLHOe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 09:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhLHOe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:34:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7CC061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Dec 2021 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y0M6cxiwSaE2+zuZTiD0gaZuJ5NlzPlLSN3W845cHTE=; b=iFp4HqmuOkECN6423WkPs57X3K
        k1+LAYvq7BUymi9BpoqCZMDxqIXJds5AViNKKRs3ET3jx2IHKU2/gBqfSExwDxiMXAoHVFPG09mTH
        8MQcngO/uKN2cG4z0xd6ctuxuDBfqsf5jVLaz38YgEsP1+0KjX9vbqTKw9Bkmz9LmL53CWP749AOJ
        X5/hJUkjOFloLfNGLJ0GegoYdM46VUmjLa6BYR1dc35obJzJvOgpRMg7ZwuArED3Bf6U5lNa3uV0J
        vMnT10wyMZqSEcK6E8AQVnuQvhMtfDDdrFXvwvaznfJaNrsW+a5ueNHNNSWseG1eGxP+UYdyKS3Mu
        kCdf1LbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muxy9-008Uac-9O; Wed, 08 Dec 2021 14:30:53 +0000
Date:   Wed, 8 Dec 2021 14:30:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH 42/48] mm: Convert find_lock_entries() to use a
 folio_batch
Message-ID: <YbDBncBEhdtuo3zv@casper.infradead.org>
References: <20211208042256.1923824-43-willy@infradead.org>
 <202112081952.NHF8MX2L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112081952.NHF8MX2L-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:29:33PM +0800, kernel test robot wrote:
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112081952.NHF8MX2L-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0

Thanks.  Strangely, it doesn't reproduce on x86 allmodconfig.
