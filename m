Return-Path: <linux-fsdevel+bounces-3857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BA7F93BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7D1C20AB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93639DDD3;
	Sun, 26 Nov 2023 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lahfa.xyz header.i=@lahfa.xyz header.b="oX9lc5II"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Nov 2023 08:25:46 PST
Received: from kurisu.lahfa.xyz (unknown [IPv6:2001:bc8:38ee::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C5D7;
	Sun, 26 Nov 2023 08:25:46 -0800 (PST)
Date: Sun, 26 Nov 2023 15:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lahfa.xyz; s=kurisu;
	t=1701015603; bh=aGwI/sBkDJ0eK/6IECx5Wa1kB+sn3pxbBYSXU/jYCvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oX9lc5IID8jnjVdZDgFCx623A1+LrRDd62f6m3d0mQnlX3jUhEN3ySBkO2ryopJT9
	 J1L/BzMViOY7JonATvFnGOJvX356RMN0rb3gUXZhjlV/hsQrYzpMKLEOoaYKsp34/C
	 M2uirTsKAErlwpNoh06qcpXkNl0CAN2/zw3wmxfw=
From: Ryan Lahfa <ryan@lahfa.xyz>
To: zhengqi.arch@bytedance.com
Cc: akpm@linux-foundation.org, brauner@kernel.org, cel@kernel.org, 
	david@fromorbit.com, djwong@kernel.org, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	muchun.song@linux.dev, paulmck@kernel.org, roman.gushchin@linux.dev, 
	senozhatsky@chromium.org, steven.price@arm.com, tkhai@ya.ru, tytso@mit.edu, vbabka@suse.cz, 
	yujie.liu@intel.com
Subject: Re: [PATCH v6 00/45] use refcount+RCU method to implement lockless
 slab shrink
Message-ID: <oiinfvmshahzzwfjo3bn5zjspuoeei3yg3sutstmzkang4lwfp@m7esnepoxwtc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>

Hi there,

Given that this series removes the old shrinker APIs and re-adds new
shrinker APIs with `EXPORT_SYMBOL_GPL`, is the intention to prevent any
out of tree module user which is incompatible with GPL to use the
shrinker APIs to register callbacks?

Or is there an alternative I was not able to find out by reading this
series?

Thank you for your work,
Kind regards,
-- 
Ryan Lahfa

