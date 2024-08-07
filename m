Return-Path: <linux-fsdevel+bounces-25268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FCE94A5A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71801C210C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A91E287A;
	Wed,  7 Aug 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOyYDgRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB71E212F;
	Wed,  7 Aug 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026856; cv=none; b=BaCY34JTZmgxkgKdCk5WDqw8xtfyILhRz1qbQh4luHz4SD9waqX7HNthlXUR0KAjIm5U4J3GzVfUCqNMRe8m6eaWGZ5IfROdrjpWFU6X/1EPDit8YkVijSn7Ok+Xj4qYsEGwitCmBFaEkD7Dn2Ic5HmLkzP8W07Oluztr90qkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026856; c=relaxed/simple;
	bh=jPLqSGCpRkGnbsXm/cVyoaDc+YcARWTMRLiDm3XWJYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9ay4DXWhdNA118QlcZNiDIjtiM2HCorfdGpjpkHcWlekeoEdw4tNcZwNkvVUqM/q71MWJISZBO67T6wtj5a9/j/+iA79dUcdpE2nz4z3an8qWt3j6UNF9RFWaaPnZ28l4RUzZWfwRZCQxxu//rHjBFLNh3KF0t2Gbo2zigw/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOyYDgRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114E2C4AF0B;
	Wed,  7 Aug 2024 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026856;
	bh=jPLqSGCpRkGnbsXm/cVyoaDc+YcARWTMRLiDm3XWJYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOyYDgRv9UUZ/XR5aF9tjceCkjSMoMc0hh3swpx3bU5UptypyE+MIP7nAiUNJkCDe
	 b5FhyowMHW10igM7fkQuL/3/rZaMX0RQiWIXKJP912qwuxipjLDe6VEzHE97mVFrwi
	 F0xQcPTfWVRy5p+MBJd+T8RGqC9nXKly80Tw0/EtWNrbzxlEYh9v5yIxTL0up3KE46
	 b/fD9qowKmqkSTOA0hwRw7ORV86kN+Jz6xQxJpCnKr4ERUKPYusLory6jzAG0GgOvB
	 DrkaCVS/QTendLEaaGHswP2c611Lwig6PFGgLbtVsK0oFsI6Hw0JiLBxznfidvGkmV
	 XW5JDJq+ztbfw==
Date: Wed, 7 Aug 2024 12:34:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 18/39] bpf maps: switch to CLASS(fd, ...)
Message-ID: <20240807-deutung-distribuieren-e36fb2b86e56@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-18-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-18-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:04AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
>         Calling conventions for __bpf_map_get() would be more convenient
> if it left fpdut() on failure to callers.  Makes for simpler logics
> in the callers.
> 
> 	Among other things, the proof of memory safety no longer has to
> rely upon file->private_data never being ERR_PTR(...) for bpffs files.
> Original calling conventions made it impossible for the caller to tell
> whether __bpf_map_get() has returned ERR_PTR(-EINVAL) because it has found
> the file not be a bpf map one (in which case it would've done fdput())
> or because it found that ERR_PTR(-EINVAL) in file->private_data of a
> bpf map file (in which case fdput() would _not_ have been done).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

