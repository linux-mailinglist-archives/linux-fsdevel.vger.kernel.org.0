Return-Path: <linux-fsdevel+bounces-21524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774DE905164
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 13:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0EB21C2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5ED16C685;
	Wed, 12 Jun 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otdRMRZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D25BAF0;
	Wed, 12 Jun 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191850; cv=none; b=a0+u7SB1sYEuBvaXtXi5YUo0ToTkXNBpg3B8fKLhxvF5lHUSgMVIeYvIfpP8syyCbycJwaudvB0DSg843MzUD1rDF7why/nxgdv/f4ZgEh8ypiLRL9G4VRSaBPuYLxbrKiyGEGTxx7xqXqwOstGdj28ICCFK2V5KArEbC7z+bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191850; c=relaxed/simple;
	bh=w0UrrW92K3dMIZKfYqWKXxgYHtOAHV5s5u1ETmSpD0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtmHgZjo5aQBOHoBzbcN3Qt1uKt2mZx8fU+kjOASMrrtQi3ZJOkG3taWRnuu7GdQ6c5V6RrIXy1GKevN/N4Xnl9SWZShKG4gXj4A5F/fQgV4Go6dCIBHvPnRNzN6BxfFf89D33x1049UC2Yy1kUvKm7ysSJZTnzGwcwOUUp5TOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otdRMRZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ACEC32789;
	Wed, 12 Jun 2024 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718191850;
	bh=w0UrrW92K3dMIZKfYqWKXxgYHtOAHV5s5u1ETmSpD0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otdRMRZquM+DNXqZA3Ri8ZY0ZRCPEtKQGH6HJIXeCdlfn4JbBNARgun25JYgp3czf
	 YC0+VtO7hUZm3Bmfn5441oAMR00NGn2mJoT15AZXoCEEZZYCukrQTHdnfEuGqLzX7l
	 +zJv7uVqWmEFiarKT5B09ZG+kfQqxnua7bIpR+lP+o8ptpQH8bvBztPZwzKt7Bfx57
	 Ov5V7T86HdSJucpWKzunEc/jvbpJcoAistRNlINdLCCQjeI2QcPI7F+86ht2q5EJo/
	 6biRI4G9d+UXECPQJE8wX1QuCUgNaVWS4srqMnDQBkOuYzKRZPle06rF1pEU4UHJZW
	 6Yb4Se43w+cJg==
Date: Wed, 12 Jun 2024 13:30:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20240612-notwehr-mulden-124b0f80d30c@brauner>
References: <20240610-vfs-fixes-a84527e50cdb@brauner>
 <CAHk-=wgojM8mH8Bm3iNL6P+O7qcN24OrhpbpfR02J+ePUp_J9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgojM8mH8Bm3iNL6P+O7qcN24OrhpbpfR02J+ePUp_J9w@mail.gmail.com>

On Tue, Jun 11, 2024 at 12:15:36PM -0700, Linus Torvalds wrote:
> On Mon, 10 Jun 2024 at 07:10, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This contains fixes for this merge window:
> >
> > * Restore debugfs behavior of ignoring unknown mount options.
> [...]
> 
> Note: I organized this a bit differently to make it more obvious what
> areas the fixes were to.
> 
> I tried to be careful, but I may have gotten it wrong.

Everything looks good to me!

> 
> I do like being able to read the merge messages and get more of a
> "toplevel feel" for what changed, though, which is why I did it (as
> opposed to it being a "list of details").
> 
> I'm mentioning this in the hopes that your generally excellent
> summaries would be even more excellent in the future in case you agree
> with my changed merge log.

Noted! I'll do that going forward!

