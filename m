Return-Path: <linux-fsdevel+bounces-5713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786980F164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE27B20A94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A376DDA;
	Tue, 12 Dec 2023 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iXktvunM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE63F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:43:07 -0800 (PST)
Date: Tue, 12 Dec 2023 10:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702395785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvMNTLJuF3kr1+ws2jSJcTbwqoIZyGIv3oE9wpmnXOU=;
	b=iXktvunM5fxkp6VMlS/7cjIr95ThOXnJuKvoGYlIsr7TLumtkfnx3yKmQRI09Yabop5yH4
	PhriYnHPVZmxcoep8nERCR3zQ8DbDakImJqT6qTVumeSc5plQboz5/+GjB4RhZq0pUQuLv
	jxEFL8Xf8agwP7oi7DjgWxZUaX/qX70=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212154302.uudmkumgjaz5jouw@moria.home.lan>
References: <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 04:38:29PM +0100, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > Other poeple have been finding ways to contribute to the technical
> > discussion; just calling things "ugly and broken" does not.
> 
> Kent, calm down please.  We call things "ugly and broken" all the
> time.  That's just an opinion, you are free to argue it, and no need
> to take it personally.

It's an entirely subjective judgement that has no place in a discussion
where we're trying to decide things on technical merits.

