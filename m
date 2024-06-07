Return-Path: <linux-fsdevel+bounces-21162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A888FFB4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 07:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AE3287F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 05:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0672D1E886;
	Fri,  7 Jun 2024 05:29:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68531CA8D;
	Fri,  7 Jun 2024 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738173; cv=none; b=esdExUkcAX1yM7yE9PCDeZCDAZWpNCXcw5fGBQgvZ6nfAabmlor+kgdw9RrtOouLd4DwCB2bLw1Bxp/LeJukoxa63/kjh9FAMxPFgaTREyr21JSlNdpKiTC4/LaN5P+8ceQbgn4O64fIbFYvjiLeQSMiCZeYiTpJcJ4aEZjiXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738173; c=relaxed/simple;
	bh=uu6KnvdPQNjZHEaZQRhBcWNI0QJPuofgDHDOp+2+oYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tplgEFgh58ZS4H52XX6yg0q32jbVZ1TISa0Jp3oU/F3LUPhopXAPr7cPsWXYiObhNCSHK/87AEo5QwgM5KjQi6A2UG3SjsgzdGWvBE9QJThu85ejavd2lsiKhDMiYcctAEJF3xezND5qkGiRcp8wwGh657nGvnNfyZcZeUKYsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43B1C68B05; Fri,  7 Jun 2024 07:29:27 +0200 (CEST)
Date: Fri, 7 Jun 2024 07:29:27 +0200
From: "hch@lst.de" <hch@lst.de>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@lst.de" <hch@lst.de>, "anna@kernel.org" <anna@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: support large folios for NFS
Message-ID: <20240607052927.GA3442@lst.de>
References: <20240527163616.1135968-1-hch@lst.de> <777517bda109f0e4a37fdd8a2d4d03479dfbceaf.camel@hammerspace.com> <20240531061443.GA18075@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531061443.GA18075@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 31, 2024 at 08:14:43AM +0200, hch@lst.de wrote:
> On Wed, May 29, 2024 at 09:59:44PM +0000, Trond Myklebust wrote:
> > Which tree did you intend to merge this through? Willy's or Anna and
> > mine? I'm OK either way. I just want to make sure we're on the same
> > page.
> 
> I'm perfectly fine either way too.  If willy wants to get any other
> work for generic_perform_write in as per his RFC patches the pagecache
> tree might be a better place, if not maybe the nfs tree.

That maintainer celebrity death match was a bit boring :)  Any takers?

