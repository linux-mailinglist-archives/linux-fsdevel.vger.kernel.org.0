Return-Path: <linux-fsdevel+bounces-12538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39598860A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 06:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEBF5B25943
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6528125A1;
	Fri, 23 Feb 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or7lMs95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F011CB2;
	Fri, 23 Feb 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666318; cv=none; b=XJcl6gI5uIn2IUeq9hND0YJCWaESNYi4e6mOKEMBJ35U0VZHiWRQffcbVjcIbUvv1R6FkbtO+uRzuQpiBJfnS+hiDc+IjhfNAw12B65q7kCbZAfKPXYdUSox9Mxv0ZAnbGl+sLZcAHupJA+9wpSajE8spx1rwMu5cJXT+ypnZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666318; c=relaxed/simple;
	bh=ioGz0rfkt6P7c80jfXIEtr4pYNLI5lj13cFwaKiDS0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSL6UW/2iV9LZYXfHnzz8N8Wnj+Ap6lYR+WcExXbd0x+YN7803eveNYDOz5VhFTo3+m3YFPvpgRBTzHa0sQiJVDHC9S0VWEAULa4H95EXBAlescS5c5VACHBtR1Ui+OY/UgUIhvoEW27eO9RP3ihVTTbG+4KoDwMJmOS8ilRjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or7lMs95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D38C433C7;
	Fri, 23 Feb 2024 05:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708666318;
	bh=ioGz0rfkt6P7c80jfXIEtr4pYNLI5lj13cFwaKiDS0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=or7lMs95fhpV5Ad4xwzxWJ4p0wDm3TPrs9sEobucGZ3bp0q+k97kj/5seBy0k2Ijm
	 McrBYN2pqUmFfYHD/YCMH8mrUWg0X7KemmzT+Sq4mh7C++rn9aNxEII9HVlqkfxF7J
	 gFqJ6FxNLVtWEyKNDKomC9Ww7ptngSd1nAu4+rev1q8CG+H+VEx7NBuz5UI2M/xrmS
	 cO3K8UPwgpIszfXb+kt/0XN4+eFnzIkp6vMlMbi3ENc0WhfUNLO9uWoR1GBc3tzXJ8
	 +MzI1ZNCSbsPmUYybsNGQCE7Jf7aUI8e7wZvPAlcRd300ZzNPUA5e5OLobq9pchLsO
	 yYHZpuRcTRMDw==
Date: Thu, 22 Feb 2024 21:31:56 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 09/25] fsverity: add tracepoints
Message-ID: <20240223053156.GE25631@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-10-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-10-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:06PM +0100, Andrey Albershteyn wrote:
> fs-verity previously had debug printk but it was removed. This patch
> adds trace points to the same places where printk were used (with a
> few additional ones).

Are all of these actually useful?  There's a maintenance cost to adding all of
these.

- Eric

