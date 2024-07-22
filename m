Return-Path: <linux-fsdevel+bounces-24081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8939390F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC621C21328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7316DC29;
	Mon, 22 Jul 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKzbptmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F716D30E;
	Mon, 22 Jul 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659767; cv=none; b=XiGZMppc4no2Jhxhh07fACpNg922L/Nt/JkUdKNUQkaKUOdfhobdJeCe3dxrbrQS76iMUAyRlj+ojQrLkG/HlAqQGLHA0LX+8HOsISs0db0gcO/oOVfCV6Ce7Jjm+itLResez8pkAndnQ/0+mr/ArdKSxJqxliAxCVcqGqXS2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659767; c=relaxed/simple;
	bh=8uiNrNGTw2WynMkzOfJLi58fncsfVrLJLHedUgwX7lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzhX6P4x7YzK5Fw1elB9haPXdVSMlgXH8LCIB2L1epSTv/Ci0RqheTgZOvBcXm2dCvfL0ybwBwjnFjzA53rNfuvW8QKd9pD+T+0LqPSpnDa+sluJDC+IWTUjq2F8IEdy8BKU0IcypXvFt2nEotiDCUrvVYQls/kQIgqHtafWuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKzbptmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F7C116B1;
	Mon, 22 Jul 2024 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659767;
	bh=8uiNrNGTw2WynMkzOfJLi58fncsfVrLJLHedUgwX7lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKzbptmOTQz+nezc8V3oYYTnzRjay1hPGK9miHwAx4H3gcjxXet2aC/Z0t6zYQVIn
	 n3qwLSZMSdYotRN/Op4csi28weioBVr0CpHeEWluZ3EF03B7caEOhwzLhGrNMAqqWx
	 k+Oua2sffpSVfGLyTqNuAiW3HuDLSdR9/nRqnZoNJ6LxoqdpWPG144sCCDHnC0u0Q5
	 rVqrHH5J333RpqojkcsTNjaYv38bjkCoQsgZFZr1M98X61fqXGL0nJNOwriRehvgXS
	 m6eJn04mn3xtJ4XHvTJSp8guYm01FNgFxs2Jx9HYhXi+2z7i5XV5h6Gtvy7H1pU9cG
	 LeBcb3qWuMrlQ==
Date: Mon, 22 Jul 2024 16:49:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.11] vfs procfs
Message-ID: <20240722-sonnabend-umwickeln-2f80a1b77dfb@brauner>
References: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
 <CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com>

> But not this horror.

I agree and I didn't like it much myself (as evident from my pr message).

