Return-Path: <linux-fsdevel+bounces-26452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEF995958D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 09:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90981F21015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDE165F05;
	Wed, 21 Aug 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BG2uisKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F2188909;
	Wed, 21 Aug 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224620; cv=none; b=JdUjMl0uhfrkdO3vcbhA09HdtVwZK3Yf9TB+PUW4PnfB1GYidZ91/A5t4bPEjc6n0Cy2uipJPALxXRpN3Dcoe9LWv+gIL+Xn3GHhXlzshxVmCXIyvJLQiVUaEgz47To4sXjo5ToV5VRb7lbErzhDXeLNEWeu07Dvp8g0QsaSyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224620; c=relaxed/simple;
	bh=jqt1gQihFHjYpmPfb0zxSVtjAZIis7swiMpvgCdhod8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT1GIknSIs4l8b/V5VuEfZqc2jD00T0YUN57hvobuYmuuGqoImb1j77+nDjxp69DJeOUYzkGLoDjgOy+c55pzaa1J6y7lRz8S8OvzzKXvYnCUwBcVv/qMyy65CuEuu/WfqvmBxcbLp7b1i5dVDTxQJvIP4XTXBHq05CzC1EfDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BG2uisKp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wpd1f3kprz9sbL;
	Wed, 21 Aug 2024 09:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724224614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COicL3dzsH199VTY45pcXnDs0kBDd9mbwCxNoGj2E1Y=;
	b=BG2uisKpPsVLH52AW2aRd4OqV1POoYNMy0zI0uu79RqnDIJZQznELLzV1EHvTPhfe1a09D
	NldmivH8oPOyYF5EcBoLZ70ApwfFkQXI8B2V4RF1s3Gjz+Fg0zv9LgxFrP16CsYJInVeCT
	o8xct3A9N87M0452iwimATTnuGeELu4ShtrRrVz/SHlUB172FcDex7ZImkji13KW6L8XyW
	LM01BmjIcq1gataPir39gXixFhZptxbarPufzHmo5ySuJEACW0VLOteQgIjCx1vD8RGG7L
	U/Phj97V1AX0vY6QOiROvoMzKbFb/M0yZbFdkBJdrSncC03xOTpM1LxVFtkW4A==
Date: Wed, 21 Aug 2024 07:16:48 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Howells <dhowells@redhat.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Message-ID: <20240821071648.frec5z52frrydkz6@quentin>
References: <20240818165124.7jrop5sgtv5pjd3g@quentin>
 <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
 <3792765.1724196264@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3792765.1724196264@warthog.procyon.org.uk>

On Wed, Aug 21, 2024 at 12:24:24AM +0100, David Howells wrote:
> Okay, I think I've found the bugs in my code and in truncate.  It appears
> they're affected by your code, but exist upstream.  You can add:
> 
> 	Tested-by: David Howells <dhowells@redhat.com>
> 
> to patches 1-5 if you wish.

Thanks David. I will send a new version with your Tested-by and the one
fix in the first patch.

-- 
Pankaj

