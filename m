Return-Path: <linux-fsdevel+bounces-44820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E336A6CE12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 07:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ED216AA8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA02201261;
	Sun, 23 Mar 2025 06:40:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D074501A;
	Sun, 23 Mar 2025 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742712035; cv=none; b=faXo55I4jT9soZ30aMzBid2iYSLDMKnQA9YMAcHFNGFhiHru5uaejbzjdi54Rl2QdfiPZEmo13Vlqo8Jg1rZSceAf3piTbx0m+Jv5DAU4ArY56LeoUVn79bWNORn8CN7ExKLD/6HAtSaj1ZQE2hVxGt4jTinKysVxUdhIN1c/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742712035; c=relaxed/simple;
	bh=fJlim7u0Qnxq0CkRro8QCyNM2Z3KzFNyT4848RNS9mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0/UzShVYZHEsuHbnsjLZSgFOJuwFu2oeLP/QakQBXOYxTUBv0Hjh+1UXNf2vcDedrSs/MOja1flzRIfHnlhmJPUhWzg7/5riO7vJnJrqhUjGUoGxSXFmzlMx3169k338OBVP7TS+71Sq9yJBQ0gkbXpI+0QGKH0KjQEPq6tGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8E3867373; Sun, 23 Mar 2025 07:40:29 +0100 (CET)
Date: Sun, 23 Mar 2025 07:40:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, alx@kernel.org, brauner@kernel.org,
	djwong@kernel.org, dchinner@redhat.com, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <20250323064029.GA30848@lst.de>
References: <20250319114402.3757248-1-john.g.garry@oracle.com> <20250320070048.GA14099@lst.de> <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com> <20250320141200.GC10939@lst.de> <7311545c-e169-4875-bc6c-97446eea2c45@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7311545c-e169-4875-bc6c-97446eea2c45@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 21, 2025 at 10:20:21AM +0000, John Garry wrote:
> Coming back to what was discussed about not adding a new flag to fetch this 
> limit:
>
> > Does that actually work?  Can userspace assume all unknown statx
> > fields are padded to zero?
>
> In cp_statx, we do pre-zero the statx structure. As such, the rule "if 
> zero, just use hard limit unit max" seems to hold.

Ok, canwe document this somewhere?


