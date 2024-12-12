Return-Path: <linux-fsdevel+bounces-37177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A1E9EEA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D25C188C083
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B0216606;
	Thu, 12 Dec 2024 15:05:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E08215798;
	Thu, 12 Dec 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015957; cv=none; b=cTf4P0Cf6W5oTwJ3QyjH1aoz6nrxMGkof4s0iPdiXLcEi25vpHt/21H00Y5yZNeBYXpZrObA/nY5rAFdv+kaLFwVrZVI6nEvqyM7iDKZKt/oX/kqJVZ9j1QxeLpJb6Q195Hw0xv+4iCWQRRd0Ht5zxbfnyyLFLsPFt5SsCCV8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015957; c=relaxed/simple;
	bh=kDVK3QoZssEv2WHeoXiqfbtLHZAC0V1XffADmHviHvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYFw8KvSB2oVPFdNITF2/bZe0BUvpOkJxS4XBWBIC6rOzPa+yCvMW8izS28mUy0b+l+bpmTsoMXV8fCKuzFZ7FXFl3oqBJiKWQAuXvb5g1gxd/vVQNr+9toEZ+tHyJD8XuDdhRRlF1AOyY4iEEANHPyOCK1+PPTTK7aj5jP2hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F9DB68D32; Thu, 12 Dec 2024 16:05:51 +0100 (CET)
Date: Thu, 12 Dec 2024 16:05:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <20241212150551.GA6840@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-5-hch@lst.de> <Z1rk8YriBRX637h6@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1rk8YriBRX637h6@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 08:28:17AM -0500, Brian Foster wrote:
> It might be useful to add a small comment here to point out this splits
> from the front of the ioend (i.e. akin to bio_split()), documents the
> params, and maybe mentions the ioend relationship requirements (i.e.
> according to bio_split(), the split ioend bio refers to the vectors in
> the original ioend bio).

Sure, I can add that.


