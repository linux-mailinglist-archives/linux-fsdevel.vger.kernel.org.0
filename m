Return-Path: <linux-fsdevel+bounces-3933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E057FA18E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217AD28174D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8B3035E;
	Mon, 27 Nov 2023 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1L+wIxIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBA30349
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 13:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD6C433CD;
	Mon, 27 Nov 2023 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701093283;
	bh=Nr5swYY4gA6xNHt0Z4yplaqReZBU8Yic7S7/xZDwbj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1L+wIxIymXhI5stPgPpsACycTLJJWDPTmv3EFof1rQgFrKKgoNCa64FRgBiKy0rJr
	 xqNdNKTdSKo1zsCdfVINxNhvUPTBhkw/xYukl/UScs2cIJPkWqrRRsB6GDrUfxX1BA
	 a/5/M78PHdt6zVjxCCTMGhe9VgY32oqnl9pGXgIc=
Date: Mon, 27 Nov 2023 13:53:56 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Lahfa <ryan@lahfa.xyz>
Cc: zhengqi.arch@bytedance.com, akpm@linux-foundation.org,
	brauner@kernel.org, cel@kernel.org, david@fromorbit.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	muchun.song@linux.dev, paulmck@kernel.org, roman.gushchin@linux.dev,
	senozhatsky@chromium.org, steven.price@arm.com, tkhai@ya.ru,
	tytso@mit.edu, vbabka@suse.cz, yujie.liu@intel.com
Subject: Re: [PATCH v6 00/45] use refcount+RCU method to implement lockless
 slab shrink
Message-ID: <2023112719-quantum-aside-2294@gregkh>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <oiinfvmshahzzwfjo3bn5zjspuoeei3yg3sutstmzkang4lwfp@m7esnepoxwtc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oiinfvmshahzzwfjo3bn5zjspuoeei3yg3sutstmzkang4lwfp@m7esnepoxwtc>

On Sun, Nov 26, 2023 at 03:27:03PM +0100, Ryan Lahfa wrote:
> Hi there,
> 
> Given that this series removes the old shrinker APIs and re-adds new
> shrinker APIs with `EXPORT_SYMBOL_GPL`, is the intention to prevent any
> out of tree module user which is incompatible with GPL to use the
> shrinker APIs to register callbacks?

We really can't do much about out-of-tree code, sorry.  Please work to
get your out-of-tree code merged into the kernel tree properly, as
that's the normal kernel development model.

thanks,

greg k-h

