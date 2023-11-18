Return-Path: <linux-fsdevel+bounces-3128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D1B7F02FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 22:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB94A1F22243
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A001DFFD;
	Sat, 18 Nov 2023 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FVdgV6gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B90D8;
	Sat, 18 Nov 2023 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+R63ZDAkt//s8UnKB88tVCQVVkQg+YIsVGTYrM8JVJo=; b=FVdgV6gnhRPhSD4xJjKV+YTszY
	44JDYnnMV9+2mOcMiQQoNlzEstszYtRe1p2LsJ0yXqJ0aQJktGwE0wiL5t4vr6NgeRCPxAUur/Cl5
	k4Px/hV24qnLgUqqEVFNatVVgeJnejxtllhC6Pu9pPb9tBR4Xg1Sy0/FjB2xklDqS+6pZ+YGhyBJD
	/Xq+3I29gjw0MZkzpGn0/LULOKcq6nNo3IfFNUsYOnwcKx/F//H09OQkR3sinycIavhdEZakrlmQM
	UzzU9XeIp5v2acvVzkeTqCZRk7q4enCOUUaZsJWi8yyznrRjZW7nB+aWE52Wg3j2QSMePb73IhgDo
	++KcaHhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r4Sh3-00HaNN-2Y;
	Sat, 18 Nov 2023 21:17:33 +0000
Date: Sat, 18 Nov 2023 21:17:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and
 export of d_alloc_anon()?
Message-ID: <20231118211733.GG1957730@ZenIV>
References: <20231111080400.GO1957730@ZenIV>
 <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
 <20231111185034.GP1957730@ZenIV>
 <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
 <CAOQ4uxiJSum4a2F5FEA=a8JKwWh1XhFOpWaH8xas_uWKf+29cw@mail.gmail.com>
 <20231118200247.GF1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118200247.GF1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 18, 2023 at 08:02:47PM +0000, Al Viro wrote:
> On Sun, Nov 12, 2023 at 09:26:28AM +0200, Amir Goldstein wrote:
> 
> > Tested the patch below.
> > If you want to apply it as part of dcache cleanup, it's fine by me.
> > Otherwise, I will queue it for the next overlayfs update.
> 
> OK...  Let's do it that way - overlayfs part goes into never-rebased branch
> (no matter which tree), pulled into dcache series and into your overlayfs
> update, with removal of unused stuff done in a separate patch in dcache
> series.
> 
> That way we won't step on each other's toes when reordering, etc.
> Does that work for you?  I can put the overlayfs part into #no-rebase-overlayfs
> in vfs.git, or you could do it in a v6.7-rc1-based branch in your tree -
> whatever's more convenient for you.

See #no-rebase-overlayfs.

