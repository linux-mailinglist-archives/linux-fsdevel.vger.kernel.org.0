Return-Path: <linux-fsdevel+bounces-6600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378E281A706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 19:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41ADB2291C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE747771;
	Wed, 20 Dec 2023 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYYEpceB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0B48784;
	Wed, 20 Dec 2023 18:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417D3C433C7;
	Wed, 20 Dec 2023 18:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703098145;
	bh=EhXgjG7+EUDOv7kYFn750L9bS+qzkfjHftlOJIsTvsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYYEpceB7ehjxDatAJ3/xEhCo9M6ofKR59kGxRLlRU9mAGdyCEbbZfs/CiSL8XpwM
	 O6ysrvKL92PJXgpS5t9f1znkr0r0oP+pxyePBKvIn5G/voqm0GXs+XbJmFIqTWwTu6
	 gCS15GlTkxcHQykdTs9m2EBppgcOj5t0dRvslSJlOEIDOV/IQONuESUqc24WDasDYl
	 Z4N1v5I7wKCAD+hazZpQobZBAoyYoNsZVz4kSrZu56xTuZkNUx+XRsYavOEqwglfBI
	 /1ymAbz5zYLapAfP6slbm2wM8tJ1hd1W6PWQhJVTXZMUaqT2xxqzg3Btn9xnPGfV4Z
	 kLnpO3v99CgaQ==
Date: Wed, 20 Dec 2023 12:48:59 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
Message-ID: <20231220184859.GB119068@quark.localdomain>
References: <20230906102557.3432236-1-alpic@google.com>
 <20231219090909.2827497-1-alpic@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>

On Tue, Dec 19, 2023 at 10:09:09AM +0100, Alfred Piccioni wrote:
> 
> base-commit: 196e95aa8305aecafc4e1857b7d3eff200d953b6
> -- 

Where can I get this base commit?

- Eric

