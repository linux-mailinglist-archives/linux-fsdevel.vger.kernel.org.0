Return-Path: <linux-fsdevel+bounces-44167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFCA64109
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A0D1890FB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFB7219A63;
	Mon, 17 Mar 2025 06:16:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE8290F;
	Mon, 17 Mar 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192183; cv=none; b=jGo3A1CS0061k8FKD/dC5tqgb0oZ6eZo4N8CIjAC4Ydyk9YS2DKXyucyu33vvxMqRzfdsjSBbjc8uvzlqTIlWfsaon0B5p0VqvpTXptHbhhXKwSTlTI97Dg7G6vwwkIXgR7J5tXLetGvD8ko17cDK1O7BKJvtTpNRQAfTljNAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192183; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3kfzhkvrZajb3JF3fGOukHLTL/pOa6sevPOJK6GK92qUQemaBnHHSA3+F/oklSoQn4eQGDcItieRJ+rC1fRAomceeDJ7DH2a7YImtQ7jia1li7TA20NguPi/nEOw2Vh2oCaFRnS8p6vlM/Wlj+0UL23dyr0qi9sLtaDzk5+mIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A83368AFE; Mon, 17 Mar 2025 07:16:18 +0100 (CET)
Date: Mon, 17 Mar 2025 07:16:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 05/13] xfs: allow block allocator to take an
 alignment hint
Message-ID: <20250317061618.GE27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-6-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

