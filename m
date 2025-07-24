Return-Path: <linux-fsdevel+bounces-55923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB0B101BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB00581A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8325A34F;
	Thu, 24 Jul 2025 07:29:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043272586CA;
	Thu, 24 Jul 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342165; cv=none; b=AiFynf8crK2CeCQiB/U28ashmSfg1l5wRYFA0og5qirJwK4L+D79dHLNr9adN1PfHEY/a+sk4F5QtcwilZKmkvXYNrQpEDmqE4NpxyZlgUrQtsG+kA6CBk74l8oy5zL44Nrb9ISOW8RWUAA8qAkXLCkwW0dGQGKk0U9pENWIswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342165; c=relaxed/simple;
	bh=QuBeozCZN2Z5AcyFi8MCot0YCyQPY17ECz4ifGc0DGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRqeK685kkNZ7hlcrzFA4N2xFwb8zLEGdJ3allHhPySPXFq/H3lC7G55Bd3LZBm5/JQ3l+G8ym47vSci/q+OHh/mua/G9pgRLRBJv0zZDnVraAobpB0kIErgjTSjvtk8NbIp+o7QtbTSxHvGC3BH6HYkdKCfymDfVd3J4qax2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67E8D68AFE; Thu, 24 Jul 2025 09:29:18 +0200 (CEST)
Date: Thu, 24 Jul 2025 09:29:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250724072918.GA29512@lst.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de> <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de> <20250722063411.GC15403@lst.de> <20250723090039-b619abd2-ecd2-4e40-aef9-d0bbb1e5875e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723090039-b619abd2-ecd2-4e40-aef9-d0bbb1e5875e@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 23, 2025 at 09:01:16AM +0200, Thomas Weißschuh wrote:
> On Tue, Jul 22, 2025 at 08:34:11AM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Weißschuh wrote:
> > > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
> > 
> > Overly long commit message here.
> 
> 75 characters are allowed, no?

73.


