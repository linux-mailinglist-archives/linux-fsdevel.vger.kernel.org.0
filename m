Return-Path: <linux-fsdevel+bounces-46732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBBA9477C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53723B0C64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A51E98FE;
	Sun, 20 Apr 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhO/wmmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E11BF37;
	Sun, 20 Apr 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146400; cv=none; b=Z5gihdFnNLygXqPr5ckL9w6C0jM0ve0TXn/57+KUkr7BAWx9c0xJRLbAgzRYhdukQoyPfcoJloeOOqYCw0BEK7wdqjtzes9wYFALy2onaV3uFmvmjfbGKOlbEzoLMCdiuCf2BZ8xKaDmvWxbIzzBMkD/WIPVvXaEsiQhVHnDEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146400; c=relaxed/simple;
	bh=2JtSp0HfCxJNDl+86dI0/8lLHBCORCFKkM6Oyfjb3pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRaMMpNWtnD58KzhO0j/K41Ys9Qfaf/vaD6p29jmBLdTgj9q2GKPzb9IQ+UCmhCu3vKplJZw3te7MXV+xxxGmjE89i468wtC+GnNMIXrUsyogyWlTj1eFjlLZHwCjNEeenQHnwT2Dj0lIDCYAr1aJz71zDLS5V56dPB2spPJkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhO/wmmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA008C4CEE2;
	Sun, 20 Apr 2025 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745146399;
	bh=2JtSp0HfCxJNDl+86dI0/8lLHBCORCFKkM6Oyfjb3pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhO/wmmZO8s3upAMPcSH/5YVtWifC6PIrSSqxSixq+c+Pka5u+ulRf2hMbLZNtrjz
	 ncf/nbIyctgxueO9xK9TQqUHi85znWQMknPexM1e14DJqYfv77WxaOrN3t+jha2+CN
	 0/gI/yfDMD8+GEaNszC93oTFXk7EAyYGkQYVbndTh72G7FlRZawk8dY6iGeKf3kcfH
	 z1q1eYUM2hqkGxdN/9Zwg0EOsIb4b/pY2eZ377e7YhcGTN+LLUOIeAiE3UyrkulgOf
	 Cwu23VCtuSZZkB7QvBc43ombsjQkQ1jEIUwZ2GzDAwc+mcz0UpykmVZTf4DztzPPF7
	 6qHt0QPqqSVAA==
Date: Sun, 20 Apr 2025 12:53:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10] umount: Allow superblock owners to force
 umount
Message-ID: <20250420-sticken-seehund-9614ddbcad43@brauner>
References: <20250331143234.1667913-1-sashal@kernel.org>
 <aAKDGmxq/snqaYhQ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAKDGmxq/snqaYhQ@duo.ucw.cz>

On Fri, Apr 18, 2025 at 06:51:38PM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > [ Upstream commit e1ff7aa34dec7e650159fd7ca8ec6af7cc428d9f ]
> > 
> > Loosen the permission check on forced umount to allow users holding
> > CAP_SYS_ADMIN privileges in namespaces that are privileged with respect
> > to the userns that originally mounted the filesystem.
> 
> Should we be tweaking permissions in -stable?

Seems fine to me if you'd backport it.

