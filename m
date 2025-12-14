Return-Path: <linux-fsdevel+bounces-71269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32561CBBDB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57263009F91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6422DAFA2;
	Sun, 14 Dec 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSuqg2pz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A8AD24;
	Sun, 14 Dec 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730442; cv=none; b=s0s16+f26Wrjg8W5Rswa6iOWEhxtPNHG5dAwuXdLmydt/v/uPvfzzrFqJr64YpHAUxzDiGcXuItjZlh5HXn6qd9ZRMYkN0njLqcLIvBoUZ4nUsxFyDMvyCFvg4lhtbXhOBlXZH5FuCyaaoVXUdiNLFiXsc+3bxpgOrYmnBe+F6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730442; c=relaxed/simple;
	bh=mgC32Ij7KJZbkdl8IyE8+SATlguaUbXAnH5kG+rLMu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzMNNZDgJEUv3sH44G8dxJhv1F62Mmmq2rC0pqCrzyMD6i+fa0P5GYtfGej+7nYoQ3Fuujh6Ne2+ipGC3AxkLz9N1AbOhpRtNbZFQCh94Eu2BEJ6ImjFrHwVE6HzRN9vqXPfL9lAOohDImOV96/U0MN5+cKZQVbprF6xFoFxeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSuqg2pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278B6C4CEF1;
	Sun, 14 Dec 2025 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765730441;
	bh=mgC32Ij7KJZbkdl8IyE8+SATlguaUbXAnH5kG+rLMu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSuqg2pza++pE/VLNt9BVX2Hu0hDhIHNJzoTlvJU192DhsW7xx6/3fOnFU+kAb6vt
	 SbuX1xziokdQkce5uTOVdFzXG2K6zd8omLA0iYSA6rgvS2lYb1HJHl7ImaSxINVEMS
	 E1ftgjwtHYk1anye5HcX8omLqnAROCB8QZfeJpUu7sIQ7+1yhZnrsVcoo7+ddEvsUS
	 iBVtick+wbAkWjd2A5SRap60+RZoBPAXgt8lXabIrWPLeZA5adFNg3bgiJDrpNyz0A
	 vwKhmZDy6XUeSihs+zFIhxY4e7XEKslJUeOlQlQJ9+KJ3ZKcaKklu4iakPh0vWxrO7
	 Rv86tf4piwfVQ==
Date: Sun, 14 Dec 2025 17:40:36 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Dan Klishch <danilklishch@gmail.com>
Cc: containers@lists.linux-foundation.org, ebiederm@xmission.com,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <aT7ohARHhPEmFlW9@example.org>
References: <aT1ErArrTmp-sAiO@example.org>
 <20251213180040.750109-1-danilklishch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213180040.750109-1-danilklishch@gmail.com>

On Sat, Dec 13, 2025 at 01:00:38PM -0500, Dan Klishch wrote:
> > It is much easier to implement file access
> > restrictions in procfs using an ebpf controller.
> 
> But if we already have a masked /proc from podman/docker/user who
> decided to run `mount --bind /dev/null /proc/smth`, the sandbox will
> not have a choice other than to bail out.

I misunderstood you. I thought you were writing your own container
implementation.

Yes, if you want a nested container inside docker/podman, then file
overmount technique is already used there.

But then, if I understand you correctly, this patch will not be enough
for you. procfs with subset=pid will not allow you to have /proc/meminfo,
/proc/cpuinfo, etc.

> Also, correct me if I am wrong, installing ebpf controller requires
> CAP_BPF in initial userns, so rootless podman will not be able to mask
> /proc "properly" even if someone sends a patch switching it to ebpf.

You can turn on /proc/sys/kernel/unprivileged_bpf_disabled.

-- 
Rgrds, legion


