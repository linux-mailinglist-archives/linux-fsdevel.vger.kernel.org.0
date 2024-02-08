Return-Path: <linux-fsdevel+bounces-10743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BE84DC41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAD11C2652B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557886BB25;
	Thu,  8 Feb 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI1H1J7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112D67E9E;
	Thu,  8 Feb 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382873; cv=none; b=i51Yj5GpiQlyDAoo3dslTit2Sb/BDgIgGVDNlQmueV3ELywuXel7oK4/hxLZpOCjON90q8/kCA+rTMlFDU6rGSxyBt9gL1KF38K9rCTU8wC72TDKu2nc6CBx9tXXTQs+lEJIKq7HEXSlOm3BF8/QWwIyxsHlEClwpy2rtxQmktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382873; c=relaxed/simple;
	bh=kyhgLLfEmFSyGFkdHbP3ms0xd4TZ8gGDCe7KEd1FyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOkGpL0akfc6pehJQZIthdOBGnOTmsMOYsgRZwhlE/spEYhZSH0ZhBitz24GY3H2QrCU9OitarfGv+NOfWZJQEuVa25xvMiTRHzzStO9ScL/UdWJ9DmbjV6qsWtm/jSeHbw+ckatxhoZb81vSUK30yRjFB4M2eZQvaAAVcm6mvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI1H1J7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D445C433C7;
	Thu,  8 Feb 2024 09:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707382873;
	bh=kyhgLLfEmFSyGFkdHbP3ms0xd4TZ8gGDCe7KEd1FyV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WI1H1J7jkweyMdeHBFzWOkUML1n+0DorRwze23LcyCsWdTJlBebpWowClhT85VoXf
	 ou6im09OyNkkD34Uri9Qv0AWqDBQwZfls5F6h8+2AJyhAnxgjjCDLweEraBuuat3Mo
	 u0ixueoiWw4DYKQNweb3ddUAnawqWEzBASQjiA3r176qr0BQlOd3K+qhAGcLLdvqR9
	 ZAqiK3tsaM8OIsX03MXuB+GIAZYd9C6p27KmCFvKRGeyUluEsHhsrTmwYNd6u7CRja
	 JZDwMB6pq9jk5TdruWd2Xt0zZr8oWrxOGbqcMNHN86Zz2ef6YsG5MA1yUWCNCesdw1
	 veOq53+kbtKMw==
Date: Thu, 8 Feb 2024 10:01:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <20240208-androhung-wutanfall-160937914396@brauner>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240207174009.GF119530@mit.edu>
 <kq2mh37o6goojweon37kct4r3oitiwmrbjigurc566djrdu5hd@u56irarzd452>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kq2mh37o6goojweon37kct4r3oitiwmrbjigurc566djrdu5hd@u56irarzd452>

> don't think other filesystems will want to deal with the hassle of
> changing UUIDs at runtime, since that's effectively used for API access
> via sysfs and debugfs.

/me nods.

