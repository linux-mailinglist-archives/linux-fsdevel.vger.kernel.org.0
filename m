Return-Path: <linux-fsdevel+bounces-35299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A269D3842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA531F23B81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2519C561;
	Wed, 20 Nov 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+eMoxnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB4183CA2;
	Wed, 20 Nov 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098192; cv=none; b=tVkEP7b4ma/6qbafXCfstrazFaHayF8PjTG8oW6Ymkb8JZZzBUUUtU420giDXA0SnItLzkWm41RjlaOV2/RVMR9yJdp7vq22EbQuw8wFBcslRC7z1Z338Fj/xFi+XbK5H99vmDEHZjNvtzv/f2ZUYvnd79yTVVEex4feXzWpC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098192; c=relaxed/simple;
	bh=5q2Pm04NgG3SUl9CYckfofHezS5qo6XPMnYe4JiaAPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/KnoI48+UIS9sqWI4bVUFd/L4OiyqyPhgvOrjl3KTYFMrhzOwlXI8tOUyHfDV0hUWtgzJY0o+tODIYvglP4jeXApgLnY9Bh0+pRpk26KWyfkq0F6xlYvRRt8FVzun1qESwSWudiPhRW/73hDNAzIAVXJa4DeDyrPoOWIZEpn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+eMoxnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8C5C4CECD;
	Wed, 20 Nov 2024 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732098192;
	bh=5q2Pm04NgG3SUl9CYckfofHezS5qo6XPMnYe4JiaAPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+eMoxnKvsgyF57x2XplwTqL8m36gjGkgsrRLOvW2sqWfalEXGV0b2eRiDcg5r5eR
	 5MD06NQHwaQbcL8/6VnWISOmQfrjTET0haS5kC1CdYdKcruzHjtFqYy35CU9E3EdxU
	 b2jpPLaBVDY3qLj/NOmFYwN77X0n7Ze9Dla2DQOK9Xe8YifXdbgiuukZJR7KqyvqBz
	 07spjJWSib9Loq7cFHEnIkqSdoxiC0FP43d1k8PY1O7K+puH2xT9BnAUyuQ9CEHAmb
	 M4nygrYlluishdz6apDGLgRBjwK+uo0JU8k+n7sAgG6TiR3gfd6hw1xWHfy1W5bP3z
	 bBAak5s/Zx9Tw==
Date: Wed, 20 Nov 2024 11:23:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH] Documentation: filesystems: update filename extensions
Message-ID: <20241120-packen-popsong-7d5d34c0574c@brauner>
References: <20241120055246.158368-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120055246.158368-1-rdunlap@infradead.org>

On Tue, Nov 19, 2024 at 09:52:46PM -0800, Randy Dunlap wrote:
> Update references to most txt files to rst files.
> Update one reference to an md file to a rst file.
> Update one file path to its current location.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Cc: gfs2@lists.linux.dev
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>
> Cc: fsverity@lists.linux.dev
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

@Jon, should I take this through the vfs tree?

