Return-Path: <linux-fsdevel+bounces-1871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDBC7DF9B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1321C20FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECE21340;
	Thu,  2 Nov 2023 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FnYVuw9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA0210ED;
	Thu,  2 Nov 2023 18:13:55 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E4D5A;
	Thu,  2 Nov 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EF1P+qhTkD1fVrPfz+oRkiDrF1SkoAXGdb5N1IjnSOg=; b=FnYVuw9YNSDZynrJoQgqPMdVrC
	dMFvDec5GzfS6kWF2/iUXdRkzh1L5v/b5AjWJU/NWcWdEu17ZEAd7Im49LXryFC7XRnKKF7L37O9d
	7WHvWsFZPfmW+O3a8DsxXWhoYlS9V9Hdy35F5Srq+NnBUP/JkW4dGY1pHxusYWPhPtoG7oDq3+tKn
	PLm+C62H+rmeT+ObTIlbwYzA+NJboGVAv24MpRI6lWGyHpUZuZyO+B2Bzbq1E6gka5O5I+BqW4jYh
	a++vuuZJPnjGH50PZHdf25NsaL/7ejHqctyl5iWs6KjrF2jMsEQStV6A8R+id7AI3Hq3Yz8JMIstI
	HKR3l7vA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qycBt-000mDr-4B; Thu, 02 Nov 2023 18:13:13 +0000
Date: Thu, 2 Nov 2023 18:13:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
	rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, weixugc@google.com
Subject: Re: [PATCH v5 0/1] mm: report per-page metadata information
Message-ID: <ZUPmufo42pJ2i3uw@casper.infradead.org>
References: <20231101230816.1459373-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101230816.1459373-1-souravpanda@google.com>

On Wed, Nov 01, 2023 at 04:08:15PM -0700, Sourav Panda wrote:
> Changelog:
> v5:

SLOW DOWN!

You've sent three versions in two days.  This is bad netiquette.
I don't want to see a new version for at least a week.

