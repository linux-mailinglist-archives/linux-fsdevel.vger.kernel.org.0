Return-Path: <linux-fsdevel+bounces-34635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4089C6F09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D458E284AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB5200CAF;
	Wed, 13 Nov 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chM9bR/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7D200123;
	Wed, 13 Nov 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500832; cv=none; b=oUHK+lpnxW/Heu2aJ/z8Xzrc0Bm64mp8Ex4k7/hJX8hoR2g9Sj20I0NYWThR/gYFIL0lIxxTt9g23IsOCtk1Uhxq6qHHZTzVWqQowFdiCxFxP58J3E/raRla2NySqKHbTxPZghTLahdVuWFVOUQLjVmEAgs2Nw1JtjTUEAYQ2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500832; c=relaxed/simple;
	bh=m5MXBZVJ/+k0YzDIVjxP0Lqd9tst5miAfSw4YNludbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhIooOTNqKD8Q5+8MBrFTcqzK+X3EAIZIcSRFfTx7sTfXAdKHjY+SAYCyIvbcQYEUQM4wOIs43SMe8EYStLI1bBml30G9Gp4rrhW+LTicmIlbN3GMYBKZiW4mZt8Bq8GfE3lbYtgIrJStN4zmvkk3nZTOmcToYleBuHOOEyWgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chM9bR/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C40C4CECD;
	Wed, 13 Nov 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731500832;
	bh=m5MXBZVJ/+k0YzDIVjxP0Lqd9tst5miAfSw4YNludbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chM9bR/g8aNbd1OfMrpbl4mmaPirsGe6485SZuBU9wRzEbeW7ZIl07+meAKoRPeA8
	 FNcFwyIBkiK3pZP6I2pJI1SyIDpEeeYi6LJfY86bWkza4/NPu5yuHi9SAiSyHdxQLP
	 ebw2SD4JoPUYggzbJo4dAjsF8unJ2+wxWOFnQ38P6bgSXYLReVoAhvz5goD1fkV82Y
	 Ce+gGM5DPNzUHZNfkSaVwYtQz8DCCbveKoxlGAr2brfGBmXYqD1TDnhJ+5DbuU975k
	 LKMZoy2+L/k/HNm2GPZkw8nG/6X+lrTz4TUdp1aItab4Va3tlvx/8jrClGT9j3ivps
	 RZGPX40O8SBAw==
Date: Wed, 13 Nov 2024 13:27:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
Message-ID: <20241113-unbeobachtet-unvollendet-36c5443a042d@brauner>
References: <20241112101006.30715-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112101006.30715-1-mszeredi@redhat.com>

On Tue, Nov 12, 2024 at 11:10:04AM +0100, Miklos Szeredi wrote:
> Filesystem options can be retrieved with STATMOUNT_MNT_OPTS, which
> returns a string of comma separated options, where some characters are
> escaped using the \OOO notation.
> 
> Add a new flag, STATMOUNT_OPT_ARRAY, which instead returns the raw
> option values separated with '\0' charaters.
> 
> Since escaped charaters are rare, this inteface is preferable for
> non-libmount users which likley don't want to deal with option
> de-escaping.
> 
> Example code:
> 
> 	if (st->mask & STATMOUNT_OPT_ARRAY) {
> 		const char *opt = st->str + st->opt_array;
> 
> 		for (unsigned int i = 0; i < st->opt_num; i++) {
> 			printf("opt_array[%i]: <%s>\n", i, opt);
> 			opt += strlen(opt) + 1;
> 		}
> 	}
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

I'm likely going to snatch this for v6.13 still. I just need to reflow
the code as the formatting is broken and maybe rename a few variables
and need to wrap my head around the parsing. I'm testing this now.

