Return-Path: <linux-fsdevel+bounces-3287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF27F2529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E0E1C217AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2718621;
	Tue, 21 Nov 2023 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4kpD4oxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE8ED;
	Mon, 20 Nov 2023 21:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0IQyXB4lFR5QVHXCSZcGjzmyyThMkWKD+nk8D0ijT9w=; b=4kpD4oxlnlflUTPXRGTky1Rbrq
	TXgXHt7jI+pXwCDIHvo9KL7BmAclqhOXsA+GM/gDmiB94fguYgyFfGNiCK2M8oO5TeZLOETSHDthJ
	4E11MN/no4PoG8WTweUICysT3YSbIVyBWREeXJ2t0IiqWnthMqyf+fIrKvRT8K95+rarV+lLLoS22
	tRd+pRD5b+VmXV0ouMb5wKbJHKTkMpyuWmS+cPwWY5ECpw2JZrovMP546MQ3U0KWxq1rp1rxL00BI
	k4YrR/MRchV70bn9gUS1/igjpw4SvNo0HpTzXXWkFRob178m4XbFgfTETGvSBS/nTKI0eluFlPbqq
	XKyLV2JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5J9a-00FfQY-1U;
	Tue, 21 Nov 2023 05:18:30 +0000
Date: Mon, 20 Nov 2023 21:18:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
Message-ID: <ZVw9ppybs8FmIPVc@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just curious where this did end up.  I have some changes that could use
or conflict with this depending on your view.  They aren't time critical
yt, but if we're going to the road in this series I'd appreciate if we'd
get it done rather sooner than later :)


