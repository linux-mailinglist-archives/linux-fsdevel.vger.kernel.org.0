Return-Path: <linux-fsdevel+bounces-7531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1317826CF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC561F2265A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE814AA1;
	Mon,  8 Jan 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8otowAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5B14AA8;
	Mon,  8 Jan 2024 11:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE592C433C9;
	Mon,  8 Jan 2024 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704713831;
	bh=duXbmeznlLT9bNO4oRsNGojLORWi+9JKhIi4y6rCdXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8otowAyqUF3j8QzHRH+aStB4w6nz3yUONGKDHMfbFKvGcJoLlIfNrD7ml5WYMidp
	 71eso/92UXMS9PRZrjPhRUzMJZE5ngHfyjZC5NTZYVh13eLuTY4nLkYq86DntPc/rJ
	 SHFBWUvWrU1dONiN7gSHwh1EsqwltDR4bqA3thZ3I5JiawyIILw15yYwHjtpBhwx2F
	 As0dBk0gpGJfZZ/F/zuJ8VOsKLhFFbnpJZbPlH1csCQTZdHYdsz1FHHS5EO6rq3XtZ
	 bi28+M6RLj+ZlrCLIPjBfM9s/WgBVXep+mdlox6BbSKHNSqWIMl6k+LQRNToSQhWz0
	 Nz1pVFYnDsVSw==
Date: Mon, 8 Jan 2024 12:37:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in
 fuse_fill_attr_from_inode()
Message-ID: <20240108-ramponiert-lernziel-86f5e0926c3c@brauner>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
 <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>

On Fri, Jan 05, 2024 at 04:21:29PM +0100, Alexander Mikhalitsyn wrote:
> For the sake of consistency, let's use these helpers to extract
> {u,g}id_t values from k{u,g}id_t ones.
> 
> There are no functional changes, just to make code cleaner.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

