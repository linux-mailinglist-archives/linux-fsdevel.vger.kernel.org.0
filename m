Return-Path: <linux-fsdevel+bounces-74078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30481D2EC44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6180301D1C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF29357A24;
	Fri, 16 Jan 2026 09:30:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61759356A18;
	Fri, 16 Jan 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555853; cv=none; b=hcz7mNNuZfz6j4f84zYESKB/ihXyJoiO0oDuw0FaG/vJezVymarZD52gssdtjSuMT5CcFZqdXE1hp9sd67PT4u/qS7+yMAaj8y86KP4k1e6w8Hj2hBNwnQTK4CV6P32Bvg+JszdqmYoGhJ99d2LX3MBj4HvPJ6S0KViSHBJ/+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555853; c=relaxed/simple;
	bh=xkUpHoL2Ny71i3ChO523r+ourDh8AfqPs61fuyFlbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhEA47JSZEhd6id7l7yZtjxtYgW1/NMl5GcpxD/gVZsFOPsLfzp/W+8TA+9lrCBOo6tsL4cbB1s4Jb4J4F6TJ1OB14ZoGL3GiDIx7gVP3J8JfzLO18h3cA00IKTBNVGANAS+6bgZ7ImFbVtXZokl8y/bceST3X6JL98e+RysQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3AFF6227A8E; Fri, 16 Jan 2026 10:30:44 +0100 (CET)
Date: Fri, 16 Jan 2026 10:30:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Anton Altaparmakov <anton@tuxera.com>
Subject: Re: [PATCH v5 14/14] MAINTAINERS: update ntfs filesystem entry
Message-ID: <20260116093042.GE21396@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-15-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-15-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 11, 2026 at 11:03:44PM +0900, Namjae Jeon wrote:
> Add myself and Hyunchul Lee as ntfs maintainer.
> Since Anton is already listed in CREDITS, only his outdated information
> is updated here. the web address in the W: field in his entry is no longer
> accessible. Update his CREDITS with the web and email address found in
> the ntfs filesystem entry.
> 
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Acked-by: Christoph Hellwig <hch@lst.de>


