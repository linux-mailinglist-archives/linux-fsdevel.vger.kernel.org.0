Return-Path: <linux-fsdevel+bounces-32666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873169ACB4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF01BB218F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19A1AE016;
	Wed, 23 Oct 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3LXRHN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A581A76AC;
	Wed, 23 Oct 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690358; cv=none; b=LamelyHjYHv/GH6wbbGySYrkU9AA33nL+RYR+7xXQ8jZg7l/oEuNilAH5kaxbbb3Jk6Ze5qw1pS9v8OCShGBRJjHTg/W2wY/S94enFPEGJj8yZQsiiDOM8BxD3JncLWFYcUxtsfBbqDDr20wn8UpicdDgtg9IkgkWmWJpCnh95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690358; c=relaxed/simple;
	bh=EH8DsJw0YuwFnYgpzTQ7yT+NT9OHyZWlXQ/YLZ7FX9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNsaAV4hgKrd4RdDJZbLR3o+gvm9g1/XJ2P264RR8FCAunm944Z45MQjQx1auVoqDv3qmwduAyfDN8P4dEJh8NG+i8pBj9aIQi1O/4Xw9859tTa4PUocmzF3iVqMd09TkXG8FUD6oy4DxowBGChACtFmGEDQi2RPUzCJjrm2A5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3LXRHN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB3C4CEC6;
	Wed, 23 Oct 2024 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690358;
	bh=EH8DsJw0YuwFnYgpzTQ7yT+NT9OHyZWlXQ/YLZ7FX9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3LXRHN9KRmUNbwlo0MBLti6w6xeiNe/74jueWnIVUVcLiVaWjiiO2KDrcbWSrvwq
	 fcr+CWP111UxhAfmsq7iPsr67+sFSqiC+W4ZaO1sGPqdW+oys3fVuGNHQHvepmz/b0
	 ibeQA0RCe1243ZRtxlIaTHNwm0j1506VF8NN3O7pDvc6kpJjaW1wlTbczmp8zMjxc2
	 eBrJ09Rx7lEU+bGu259a1R/kvn6USaISJikE8CKX/JwAa9ulflpr6HSBCzFWSKn46D
	 y2iXENoBpFCB2AJz/OEyeypsfJA4Jc8jK8/KdygRDR+KrWuUmRJHs2MWUIJ6A8p7w3
	 BJbqb0WjZp4RQ==
Date: Wed, 23 Oct 2024 15:32:33 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: update comments to new registration APIs
Message-ID: <4kzqsvfdk6w3ype3icdx6ticqpjn5rfioa5qj7k7xwoetddrcr@be4m6r3w3wps>
References: <20240810-sysctl-procname-null-comment-v1-1-816cd335de1b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810-sysctl-procname-null-comment-v1-1-816cd335de1b@weissschuh.net>

On Sat, Aug 10, 2024 at 07:00:35PM +0200, Thomas Weißschuh wrote:
> The sysctl registration APIs do not need a terminating table entry
> anymore and with commit acc154691fc7 ("sysctl: Warn on an empty procname element")
> even emit warnings if such a sentinel entry is supplied.
> 
> While at it also remove the mention of "table->de" which was removed in
> commit 3fbfa98112fc ("[PATCH] sysctl: remove the proc_dir_entry member for the sysctl tables")
> back in 2007.

I queued this for next release with a slight change in the line lengths
to make checkpatch happy. Try to make the paragraphs up to 75 chars next
time

Thx

-- 

Joel Granados

