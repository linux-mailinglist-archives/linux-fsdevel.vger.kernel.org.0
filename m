Return-Path: <linux-fsdevel+bounces-38568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E6CA042AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C377161375
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668911F0E25;
	Tue,  7 Jan 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C81BHnX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA97083A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260539; cv=none; b=XYQhYjaJ9w2UXnuDf0s4kf7G+JmaFB6i9rQ4uLoAhPZDe38i1qrT+qy/o1oxoINOkHISbWppupTCmGyeTRZRkUhaTpzjWk49aGjD4Dw4rxdTQP+ShtN49tso+WTa22fZRmzwPhBNiSjb+A2kBgjHMP/Kr523ObFZHyGlhyykXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260539; c=relaxed/simple;
	bh=tkpwq0zx/yTAMRSxuPhn5Y9mCo5xGFzNLzCNZdg0V+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krBPm9Fqe9oVLlsSMGSmG3lYJQCtoxhT1KQMACuKjbAKdq41gG6roh+hkHyqJPn3byXtaZWc+tnIFVpNMNWHaQO0RM14bvxBSIQVl3qMlD0YTHT+fk7Suh33IFRRtyviKzl7BBhSLws15KkojXv4eXiUc2kVvcSnb7HSm7O8ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C81BHnX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E3AC4CED6;
	Tue,  7 Jan 2025 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736260539;
	bh=tkpwq0zx/yTAMRSxuPhn5Y9mCo5xGFzNLzCNZdg0V+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C81BHnX3Ah1TvXa3O1XHB3WPmTtVxdx/miqcG1F0ismXbq8VG4O2uEjwJVJbh0JO8
	 JOdoA/CaX94b+WmVtdlLckutgf0j2HD+EJe56JY8Lv8g4LoAv56tj3suGUknEqZGrD
	 oMjrMwGTM2XIicMncGvFXK/a6Fzhj+8Z8qNep7X6h+p/ReT+9LjrOIYc6A2pGIfsqM
	 FVSsn+fv1UqyglpWeKFiNtteo/SsUhGKTHW4pWadLofcEaaDWp5+8FoRlxl7lrUT77
	 1mxjnDwUvuMfaKho3Z31oxsXtqrNI/rUkXWqpbevTdCK2Re7a0BgFL3lSKGHxFOhLi
	 uyaztKosfPqJQ==
Date: Tue, 7 Jan 2025 15:35:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <20250107-wahrt-veredeln-84a1838928e8@brauner>
References: <20250106162401.21156-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106162401.21156-1-jack@suse.cz>

On Mon, Jan 06, 2025 at 05:24:01PM +0100, Jan Kara wrote:
> Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> rwlock") the sysv filesystem was doing IO under a rwlock in its
> get_block() function (yes, a non-sleepable lock hold over a function
> used to read inode metadata for all reads and writes).  Nobody noticed
> until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> Just drop it.
> 
> [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  What do people think about this? Or should we perhaps go through a (short)
>  deprecation period where we warn about removal?

Let's try and kill it. We can always put it back if we have to.

