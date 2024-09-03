Return-Path: <linux-fsdevel+bounces-28319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A375969323
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C8FB232BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F121CE711;
	Tue,  3 Sep 2024 05:13:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2A1CE6EA;
	Tue,  3 Sep 2024 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340431; cv=none; b=si5NOJ704wMe+V8NRETu+c5eLvaxNRzjrQPGdf7ruKdxzBqF7eks9OeGthLb0lsJb3xzG7pcE/J4atSVzWhXGltKmOkC976B/OnoI7rO0PQITyW/lBCDbmEcudduCwP45nydQ8KGOkR3wbHYlahcP6xGcHsB7dVhZq9hT1vSlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340431; c=relaxed/simple;
	bh=UTCB+Gvyv58ypWV0P8un7bNHXVqYfBpJxOjR5WL9hiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxyhhU4ItngbAxU/GUL0HRitayA8oO7DBLnKi9OV6aIOYAUjgx2lgp/QDvUm6+JfRXjm0G1kzp9vHrifPc4rvcA0Rl362XIEsCndFdpZ8aT+9i3EcNfIR0OjstwMfhPlaAialbHrjoV+YDdNjB4hPV9/DC/aF80Bhaa6MGbFWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3BD8227A87; Tue,  3 Sep 2024 07:13:42 +0200 (CEST)
Date: Tue, 3 Sep 2024 07:13:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <20240903051342.GA31046@lst.de>
References: <20240902095203.1559361-1-mhocko@kernel.org> <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur> <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 02, 2024 at 02:52:52PM -0700, Andrew Morton wrote:
> It would be helpful to summarize your concerns.

And that'd better be a really good argument for a change that was
pushed directly to Linus bypassing the maintainer after multiple
reviewers pointed out it was broken.  This series simply undoes the
damage done by that, while also keeping the code dependend on it
working.


