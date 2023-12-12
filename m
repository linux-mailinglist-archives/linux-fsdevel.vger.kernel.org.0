Return-Path: <linux-fsdevel+bounces-5698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB980EFDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6411F21617
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B175429;
	Tue, 12 Dec 2023 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l0T8itEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B3D3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:16:36 -0800 (PST)
Date: Tue, 12 Dec 2023 10:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702394195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IAvBDqN7URQA7HRlFvKs2d63EJZvcsvm6p9cVChC2Qc=;
	b=l0T8itEeLgP+TeuxTerhTmP7PKg/A2wSuyKw6g6ssdmrwj4LaH4uRcEErtuJzZNTp2lg/p
	L7C1Tyeg37an2pUbmbfFWhdBn5xL5H8Mvth+ImPyMKlJXZcj8worxUm4WNsgiq8uoYtp8E
	WrTFMh8oY55gLZJY+zg54sHAs7tNjgM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
	NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
References: <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-impfung-linden-6f973f2ade19@brauner>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 09:56:45AM +0100, Christian Brauner wrote:
> On Tue, Dec 12, 2023 at 08:32:55AM +0200, Amir Goldstein wrote:
> > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > >                               same inode number
> 
> This is just ugly with questionable value. A constant reminder of how
> broken this is. Exposing the subvolume id also makes this somewhat redundant.

Oh hell no. We finally get a reasonably productive discussion and I wake
up to you calling things ugly and broken, with no reason or
justification or any response to the justification that's already been
given?

Christain, that's not how we do things. Let's not turn what was a
productive discussion into a trainwreck, OK?

