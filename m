Return-Path: <linux-fsdevel+bounces-74380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C3D39F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016293016185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7FC2E8B7C;
	Mon, 19 Jan 2026 07:19:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D82E542A;
	Mon, 19 Jan 2026 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807169; cv=none; b=f8UxJDqeQYhIvXU234CM0ZtMlg0i1XXAme3ZFdbI7XBm5gHKnbHFHopdmVh4V4JmwbvC/36DCQbOHD4euRqaNZv0kvQOfL26p0CVly9g6LSkAKOTLx1h/kjVKhU+fZr9TF3Vum18pnlgPiiMwXai9hE08A7zcxmWqMrVQ2wx4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807169; c=relaxed/simple;
	bh=WYrMV5sIqjwXl/to0O/m88iFelMxykLJ1pj9G00AUQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJwAdRrHMkFQV2kiWt+A7t32lj1V3NGq6K6lCPNi2vnCPVGaGITYn7HxwhjHbJ0f/DHJE+FCOKTNQKjDJnIUovQCoQ5xqUiz+e62vnQjbltsxv8kQmjBuDk2qPuwP3ejOIx5BOnVaGH98J80hMMqjjm098Uq8muevX/WVu1nHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C35EC227A88; Mon, 19 Jan 2026 08:19:23 +0100 (CET)
Date: Mon, 19 Jan 2026 08:19:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v5 13/14] ntfs: add Kconfig and Makefile
Message-ID: <20260119071923.GE1480@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-14-linkinjeon@kernel.org> <20260116093025.GD21396@lst.de> <CAKYAXd9dz_OBkMWcS5OtfU0BhEA1r4hMqtWJ_u+qWYK4Nwk+7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9dz_OBkMWcS5OtfU0BhEA1r4hMqtWJ_u+qWYK4Nwk+7Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 18, 2026 at 02:08:01PM +0900, Namjae Jeon wrote:
> > > +
> > > +       If you don't know what Access Control Lists are, say N.
> >
> > This looks like a new feature over the old driver.  What is the
> > use case for it?
> The POSIX ACLs support is intended to ensure functional parity and ABI
> compatibility with the existing ntfs3 driver, which already supports
> this feature. Since this ntfs aims to be a replacement for ntfs3,
> providing the same mount options and permission model is essential for
> a seamless user transition.

Can you make this more clear in the help text?


> Furthermore, By enabling this feature, we can pass more xfstests test
> cases.

Passing more tests only really matters when they were failing before,
and lack of Posix ACL code should not lead to failures - if it does
we need to improve feature detection in xfstests.


