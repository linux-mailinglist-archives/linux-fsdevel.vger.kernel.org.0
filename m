Return-Path: <linux-fsdevel+bounces-27365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5C960A48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03643B2367A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749111B5EB0;
	Tue, 27 Aug 2024 12:29:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589519FA8A;
	Tue, 27 Aug 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761766; cv=none; b=OuXjl3dSnBzHDRZoNU2GWOYRAaFUy4a4pO+tNt72l/c+KLgOaUBsX9XOsm4eCXESqOEOzXuIWpzfYaWDIEq4s1ezepBfjO3xVT6AQ4oj88POKeSFuNO6LjWPeo3gG4nMDlDFpSeR4F36yC+EE1DfyhW2NR50tof/5VTyiCEYLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761766; c=relaxed/simple;
	bh=bi3nFhI+Fhvq9QsND92JcMA0j+NqyoBxVUkqIq9xOHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grlcCC7mc/UvWX5HLp4MDsan3EOgg6A6oC7HVWRDRhRIFFnfJZJEUHnTx42X8bVzrw5nM6d4h97uizVyQXkPXTGU2WI/XKqRExI+NsJ6u1ZWsPUQ6VSl1mZo96XQarjHa4w2rEYbxIdR5R2o139Zwyw5iPGPEp277iIw5YqUnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC6F2227A88; Tue, 27 Aug 2024 14:29:20 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:29:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <20240827122920.GB1900@lst.de>
References: <20240826085347.1152675-2-mhocko@kernel.org> <20240827061543.1235703-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827061543.1235703-1-mhocko@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks for fixing this up!

Reviewed-by: Christoph Hellwig <hch@lst.de>

