Return-Path: <linux-fsdevel+bounces-39768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DEA17CF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FDE3A6213
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3189F1F192A;
	Tue, 21 Jan 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vsbfQ1dV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8331F0E44;
	Tue, 21 Jan 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458512; cv=none; b=txPBk6k94ZRt++5L2Rv0RLHrIeyZSNpBgn1gwyCLwu+uHp3UTJ9QWvGmxzOgpfkoMCWdvGJFJkEV9TwX9MDN7wleqvbfC7mKnWUNKmdWmkX500R3oOuEctZe2mRmlH5FiY0AQG/cNu4QI/ktXErHaiTQL3xNDZ1EaL2A0D4NQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458512; c=relaxed/simple;
	bh=M7EkcgoOPFSUknlNP5qJ44eOOhuypxTHsUp1OrncfhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u88Ikfaaq2eOp6g4rY1sfml8OdcFSKUOek4FEYlYomk/sz8XAKToOezWrIkcd6aZ2OzFVCGFi6h9m1h5IqSzZXfHpO0p8nYEGYiIBl/XKui6LFWCyVIPMYlAsgxwXxOsfxZQIfUejlitszhprgEpTyvVAd3uRp089uyJDtDcvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vsbfQ1dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBE8C4CEDF;
	Tue, 21 Jan 2025 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737458512;
	bh=M7EkcgoOPFSUknlNP5qJ44eOOhuypxTHsUp1OrncfhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vsbfQ1dVwPq9KOtHBp6U6lQRaZL4piNqljyV9VHB15NAM4YmWWwkO9a1LKhzdYbaO
	 rcqdQ/ws55vt3tJUdPICBtK0Vac1QxuswcRA3RWf7yNeeyQSvyJL8ALArRStkox1D9
	 7FlWZ9tqfSq74OoZHGr3Ru7n7b/9f5ZwR9XdVmMs=
Date: Tue, 21 Jan 2025 12:21:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Dmitry Safonov <dima@arista.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6 0/3] Manual backport of overlayfs fixes from v6.6.72
Message-ID: <2025012133-gradually-unsteady-6783@gregkh>
References: <20250121110815.416785-1-amir73il@gmail.com>
 <CAOQ4uxj+LF602e3ypBHLpgWhO46CUaqn+sQ6Fcbq8r2cLJu8iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj+LF602e3ypBHLpgWhO46CUaqn+sQ6Fcbq8r2cLJu8iA@mail.gmail.com>

On Tue, Jan 21, 2025 at 12:14:28PM +0100, Amir Goldstein wrote:
> On Tue, Jan 21, 2025 at 12:08 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Greg,
> >
> > Per your request, here is a manual backport of the overlayfs fixes that
> > were applied in v6.6.72 and reverted in v6.6.73.
> >
> 
> Forgot to mention that I backported one extra patch from 6.12.y.
> It is not an overlayfs patch, but it fixes in a more generic way
> (removing an unneeded assertion) the same bug report that the
> overlayfs patches fix.
> 
> Both fixes are needed, because the assertion could have been hit
> without overlayfs and because the overlayfs fixes are needed to
> fix bugs other than the assertion.

No worries, looks good, thanks for the backports, I'll go queue them up
right now.

greg k-h

