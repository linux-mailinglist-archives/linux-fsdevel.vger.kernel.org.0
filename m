Return-Path: <linux-fsdevel+bounces-8464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FC836F5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBC7290D53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A25A7A6;
	Mon, 22 Jan 2024 17:38:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA65A7B4;
	Mon, 22 Jan 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945096; cv=none; b=FUtUhWkbChgjUPru3N+YNwS4m81yAuj+q+hLkeqXm5suTb3XSOHNpqlxnyQ5AROdBPQdZ4PJDzGuu5ZmAvp/HDYUaOmeGMcWDdG26snOqLsXuA1noVo0S59+KBexk3GayF6vf0gLrQus0APDhY3Na5qSc31n/aqzZKNnUIH9wWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945096; c=relaxed/simple;
	bh=kEYqRdUmZ/YIdF+BwrbC48kweYr85MSwUsecb7lUaYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slpqt0cguopGxLi1VCCuf2Bk0emhzqRXXQ/ugKxOmzrpPbRdbRiTvM1KNXpYHbx5VTv1vzLWakdCNndJoUS9Ha6b6FV5TFUcJBnCiRyqknYtgncdk5CXckltQV9SUFQucTjbVDrUXEdtv9ESblrTr2yfTySlw4gbwcfHYJeyP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FF6C68CFE; Mon, 22 Jan 2024 18:38:09 +0100 (CET)
Date: Mon, 22 Jan 2024 18:38:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <20240122173809.GA5676@lst.de>
References: <20240111073655.2095423-1-hch@lst.de> <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7> <20240122063007.GA23991@lst.de> <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4> <20240122065038.GA24601@lst.de> <3cs7zhkf3gz7fmytpxqjvstr6oegvhy3ehwu3mzomfllvjqlmc@yaq6ophbgbfr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cs7zhkf3gz7fmytpxqjvstr6oegvhy3ehwu3mzomfllvjqlmc@yaq6ophbgbfr>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 22, 2024 at 12:37:10PM -0500, Kent Overstreet wrote:
> Ahh - I misread the bug report (fedora puts out kernels before rc1!?).
> Thanks, your patch is back in :)

Please throw it in your test setup and watch the results carefully.
I'm pretty sure it is correct, but I do not actually have a way to
verify it right now.

