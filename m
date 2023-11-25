Return-Path: <linux-fsdevel+bounces-3812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C527F8B11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 14:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E0D281774
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EB1094E;
	Sat, 25 Nov 2023 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpM+OA4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BAFBF5
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 13:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D42EC433C8;
	Sat, 25 Nov 2023 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700917560;
	bh=zN2kg7T1x/yzMzUk9rg3IuB3e5b0pJ9xdV6CwEdltlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpM+OA4rGklyAAcdhgUH/8gk6C/5Z/HIGTVF0/t3JWHBPT8aDmVZd02aOUE8QToV0
	 vANr5amDRmH5AxS5lBkRLYnVHscQzYVROW3mIURI252hyNOuyQPGBjEecJI3vZTv48
	 qlhR/If0ZNdUJpaIL/JiKSyEVb28RTsXEJY0E4otGYZrDW2lH+zcaNFw9sRBgXChlt
	 5/SAasKYLa+/Yug+2n7Z4iQnytXEwAE1Uzx6mfERJ6PEkFmBegE1lAQcNX1EN/QuHe
	 TKjtMmG+NrMB+nG3H9aO4qTp/shjo1kTiXscP6vnAbyyJHcKQdNjv9xc3CYXNNOUoH
	 sYT3owJIc4EAQ==
Date: Sat, 25 Nov 2023 14:05:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Omar Sandoval <osandov@fb.com>, David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231125-blitzen-kugel-5159d574881b@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
 <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>

> Because we could just say "read zeroes from KCORE_VMALLOC" and be done
> with it that way.

Let's try to do that and see what happens. If we get away with it then
great, if not we can think about fixing this.

