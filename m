Return-Path: <linux-fsdevel+bounces-48722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F4AB33C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20D43A2ADB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8714255F5F;
	Mon, 12 May 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsoVG3gX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B425B678
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042113; cv=none; b=vDaifTFeNcjX5GThszyqyPFNeJ3OkDsUK85NlE1wCd7n6wkK6dKpnsqzFcp7DqIzSHXVOfkjYCsYuzqoDS9bErBEJnxDmvwUoUIUNhHKaH58Z/BN21rAPYs16LffFx0PBAdc2q+OE3oT+P6nt1UHrtAoWhvaIAGDLR7TEhAV/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042113; c=relaxed/simple;
	bh=x3lE2fNsTyCJgJhm9cVJ7tAX3oHxqHtjASpG0AqrVuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfCYMdJo05IsV087dCN5xtefw2XKCbsNeru02Vx2weDUAmj2EnB1KfNAO/UkeHYz8mBUBnMAEAGHqcm3DN2j8LCmCTs+XnV+YVsZ2wTcwgbxUsvSbCM1/YO4LxMU8l/+e1g/U7o+W2594Gc82Rls2Fq8qYvwKqjLFzHHBxG7DL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsoVG3gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42079C4CEE9;
	Mon, 12 May 2025 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042112;
	bh=x3lE2fNsTyCJgJhm9cVJ7tAX3oHxqHtjASpG0AqrVuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsoVG3gX87XZXXxenafPB8NLc2uA3CiwR05FAt1PgqS0BtuQm0FizWlupvRZDGq0U
	 +jOTRWYMkuXVWQMQJZQq7g5CVS21wK/NmJOZEhAqvCb6Ti7aN3gPgSWhggeKhofVNj
	 DksH7mB3oC9XgemnyruvUX16FLuyPRrEjoiBRSVMoQKMsuvBwvloTN6lBkSl81FS9r
	 CnA2NNppnpYDIUSCLPzrDJgLXF/cwTOpeZI8uDP6vi3L1Es18dBsrF+5lguklSX8Ky
	 qkK4YWq5n35yl9ROlzVf4vCJa7SH8fdSzi+D20W1fck1VQzfS8oCUSQIz/heZYpKup
	 kczNvU+kVWLrQ==
Date: Mon, 12 May 2025 11:28:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] selftests/filesystems: move wrapper.h out of
 overlayfs subdir
Message-ID: <20250512-ermuntern-dazulernen-073a1be4f9c5@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-2-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:33PM +0200, Amir Goldstein wrote:
> This is not an overlayfs specific header.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Thanks for cleaning this up for me :)
Reviewed-by: Christian Brauner <brauner@kernel.org>

