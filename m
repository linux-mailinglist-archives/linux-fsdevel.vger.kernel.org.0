Return-Path: <linux-fsdevel+bounces-11976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEEB859C2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 07:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC941F21E7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4B20311;
	Mon, 19 Feb 2024 06:28:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3763C;
	Mon, 19 Feb 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324126; cv=none; b=ZnVHso5pMSZiY81i9/U+rLRUK1uUFRNjT1ZnhvrpV9Qb7E/RKlBXM7omm/uCUHGL+wEVsK5ZkxLvwle1vT3vucOCUwt/eai9Ee6vX/soiHlHC5YWevK3nWeWr+6o/5RrcZi+cwTQhMEl/bWoDJyRKvVY0r0OmIO553Z/AlVmau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324126; c=relaxed/simple;
	bh=h93wyH+gqCZ5aRzPBydEhxUPi+erQO0k366b0EvZwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0IRZrwqF+jQH87j+wVRxFvoN/4wB20OnzoJjrXDFeCop61WN+cKWHnUbZFfvqs2S06cWxWGX/xKPRbumR3ZOTQTdJowSM2cnP0BXN3v05iVdZNSIE3NnhvEknkXioV2JhWxM1tzOmCjIk1sppcTJE1qEICHBDmQwYUJhVFFFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66C2268AFE; Mon, 19 Feb 2024 07:28:41 +0100 (CET)
Date: Mon, 19 Feb 2024 07:28:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: convert write_cache_pages() to an iterator v8
Message-ID: <20240219062841.GA4410@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Now that we've got all the reviews it would be good to think about
queuing up the series.  Look like page-writeback.c usually goes through
the mm tree, and that seems good for this series as well.  Andrew?


