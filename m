Return-Path: <linux-fsdevel+bounces-19476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8F8C5DF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 00:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8CAB2184C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 22:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD62182C85;
	Tue, 14 May 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i88upRl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339B181D1B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727461; cv=none; b=hCBdwUnDgLf+QD4Wr7gk31wY/yO7KsoGDFbEj76Mwaf9XqfPr8aZYsJIo3HIC3GQNgaCcOTIDXfXemu3d27kRGlgTJV6ndr18DTOE+7B8XH64EfYAinZVEVyd1VSFZkNsC2mzR5S3IQUBpzAHR8EbgTnfLN3ClYISbbJpXpyhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727461; c=relaxed/simple;
	bh=2cjS0cYbSeC5UJzWIBncYY8/J5XSzISRztpHP/W8P3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=glh1Lel/31pkl2KRMuD1zSBPYozTY0q+7h03pInIxCMF1tUUvKkpACMmNtD6V41jLamd3sOylgtvCVK2xMXaEhXmnuLZAne3Ty4elZZ6aI+8yWgV9NuNlEaQkwNYtxISr2fX4dVYTFehw0qhRXUEzZIY9lVQ0rTLQB6PFQsIFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i88upRl1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XFu6uHH3N0TkufLy0IIyz2tCo7DvBZqD7vKs5RC9P+g=; b=i88upRl1ySmolg0jja5H2q3nO0
	+u40Jje/RLh50eAZ8lv/kYC2KaiEJSHW35ohA/CDzBPp0deLyZHxXeeGBY8Zph7TCEoAIdYqayOMQ
	WKo44VNX+sGbsecP1jSWDp7mc/s3aENwWWptXUpoERn9w5XuMkV6ILoryvfryUwRn+WzIIGPS+5B2
	kbDb8saUaWYV3JBRutodxAx+ceW9FJOd778Ke3tDXHy2N2WvX7FbA5bjbUc3ZiRzLr8vh0k3vfMCN
	zT+zlyKb2kmqqfcui0A3Xcaj6XUwugtia124zcir7Z1GsMAv5IcvAIPVj+WwvsmwHhlgL1rK6/ILg
	sIYNYxKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s715U-00000009bBX-2jp6;
	Tue, 14 May 2024 22:57:36 +0000
Date: Tue, 14 May 2024 23:57:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-fsdevel@vger.kernel.org
Subject: A fs-next branch
Message-ID: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

At LSFMM we're talking about the need to do more integrated testing with
the various fs trees, the fs infrastructure and the vfs.  We'd like to
avoid that testing be blocked by a bad patch in, say, a graphics driver.

A solution we're kicking around would be for linux-next to include a
'fs-next' branch which contains the trees which have opted into this
new branch.  Would this be tremendously disruptive to your workflow or
would this be an easy addition?


