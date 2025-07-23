Return-Path: <linux-fsdevel+bounces-55873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE25B0F694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E29AC5B33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4682FA651;
	Wed, 23 Jul 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXRlcFsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F02FA624;
	Wed, 23 Jul 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282811; cv=none; b=gkbOLkh/i7wbnVDxP2HSnABUXEgK6S8fCgrz3WIjZPbdn4IPRxeEoulWEF7zwyFfZc/jS7W0BbTB1cQ9UUbNrP53wqkDAAT9H3sgwOoL23nqp7AQ2kbxC9a+S00GUdgMq6YRre6dqpF9E3k/7xbTaf85VmGNw3Ax5o65+f2W8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282811; c=relaxed/simple;
	bh=OAsFsARwtMGOaLiIPo6dxrAP58hUZjXFtCqKdHYwJ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duBV+GqI/4bDpvBQ2oQgM2YXHBT+oFeo/PvRbvyNFHDfhjRahnqpixEsIkJTa9N34x5x51EdJScuC5cIGN6vkMB79dhmuEdqBNM4BmaD5nLC6kPOmMgygm97NsENdHEkYiwNzxmjtKcUXraCB4xKovgLhTs/wurJsPP2JFxMlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXRlcFsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F0CC4CEE7;
	Wed, 23 Jul 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282807;
	bh=OAsFsARwtMGOaLiIPo6dxrAP58hUZjXFtCqKdHYwJ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXRlcFszFeK9InxStlUrO2eLWEGuUw4dCml9mtR0e7EMUuqcFLqpLczC7TDL7cxk/
	 p5W3XRBPLvyjkN3vl3TL9F7zdJ+CbWl0rvUmB0ZL894FrGChbN6TB7poA/RjeDXtCe
	 1C0KyqEa6LgWfmkdQLY6nHqWwfaezz0KLEi4KnXG+Y/bDiBWinX1JxBsiBjat6kzF8
	 BIZtRZIlOgPn+H2Uw+48dlcDEG2xBuCkdghJbHlqrcVKECrkdp9Ik7u6/loSrIV8ny
	 S1KlGLBpS8NIu5bHRRg/ZBf0NRqMkSN6BYuW7lEeozItyTX+Px5OKr7A0i2IzJ1dyG
	 9pZFzGei7De6g==
Date: Wed, 23 Jul 2025 17:00:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 0/3] fs: Remove old mount API helpers
Message-ID: <20250723-widmung-kegeln-82e0bdc7b2df@brauner>
References: <20250723132156.225410-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723132156.225410-1-pfalcato@suse.de>

On Wed, Jul 23, 2025 at 02:21:53PM +0100, Pedro Falcato wrote:
> Based on linux-next as of 23 July 2025.
> 
> This patchset contains a very small cleanup, where we remove mount_nodev
> (unused since 6.15) and mount_bdev (unused since f2fs converted their
> mount API usage, still in -next). Obviously depends on the f2fs patches
> (maybe should be merged through their tree? I don't know.).
> 
> While we're at it, we also get to removing some stale mount API docs.

Nice, I'll pick that up for v6.18.

