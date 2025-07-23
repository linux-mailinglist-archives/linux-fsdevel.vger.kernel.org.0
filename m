Return-Path: <linux-fsdevel+bounces-55780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B674CB0EB25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEFC3B6080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94526CE3B;
	Wed, 23 Jul 2025 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxevrJkT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kupMY7K6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE53A95E;
	Wed, 23 Jul 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254080; cv=none; b=pHZhEMnInA1nGx8TxdDBD9KpSioOuy2TyzPtYJeAOIYBCtQNuoyJ6D0GOk4QytaqOIUridN4SS93dYtI0D8INptU0rdBvnupLFoEJSi0cdeIHb4Tncf7lK7DY25Ott7EFzOf9UL3vm49Xbyu9Y5GpTA/BNqXGVOOkO4Lv1Bv5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254080; c=relaxed/simple;
	bh=ScqvYgbymO3m78bqK9XGtJqDp5QxplxAOaGw7+GHFtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdY7wAx9JeYlw3BhSfp98BQ/yBNcH4IYlCp0ONVYyL09fGiVzD/vUb3CFOQSnY9iyywD320gi2buvwUvhD1+82iOMVVAv+lhhjNKvcBpF67GhKCRJN/TfNhomrYIcv5S0GpEMZsMtTRHYHvpfhTNuQxCzeFrMdm32J0qBvF314c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxevrJkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kupMY7K6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 09:01:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753254077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TToHOnGqv2s0a3u8OKmvaBii3a4hbe31bdd/QLS36jk=;
	b=wxevrJkT2nLNlqpE2PFKLBEhHJlTkhngGnk9al0JB+6dUGkiExXWYgl+kmPqNJWNsaPs3M
	rDZ07q8KTt0K77e8aTTZ3+lsqwcFmF9SYt2/49QAo/wEdnIgj0sK7CrLJYYeVo7RWJPI4c
	LgKKzx/Js4CSMO0X9RQrswSMAPuWykFbSdia9NI7WP0TukVEhkCCWEvjzotqBy8kxppQjB
	PScdX+WtFOGsUFZDZ598MVDz+w+UMKS9brwsHdf0PODWG1+b5nl+hHHLCC7vJz7tLJJeYK
	i6S5dCVrgu4ujPWpIcT6kwA2auWHsEdaRU1g0SPFJgYBias6A5Tho/DFBqw/7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753254077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TToHOnGqv2s0a3u8OKmvaBii3a4hbe31bdd/QLS36jk=;
	b=kupMY7K6MiIEw6pWVxKTRQONeoUxlb75II01maVF5QzKFlYPBVqxVVdwWpeGmMtoYP7RGN
	ifPZwQMmhgEuBeDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250723090039-b619abd2-ecd2-4e40-aef9-d0bbb1e5875e@linutronix.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
 <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
 <20250722063411.GC15403@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722063411.GC15403@lst.de>

On Tue, Jul 22, 2025 at 08:34:11AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Weißschuh wrote:
> > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
> 
> Overly long commit message here.

75 characters are allowed, no?

> > remove it.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

