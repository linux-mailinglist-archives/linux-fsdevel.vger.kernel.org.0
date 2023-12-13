Return-Path: <linux-fsdevel+bounces-5825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DA810D87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305B2281828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D520B23;
	Wed, 13 Dec 2023 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BztBqQf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2201EB37;
	Wed, 13 Dec 2023 09:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8F8C433C7;
	Wed, 13 Dec 2023 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702460467;
	bh=1O6MSfrSt69X44+QtFffJJy5vAeC5w5FjpWi7Is60aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BztBqQf2LzyPjacA2eN1b+Ik37XUPfKdAWUsKSs/TgMJGF205qgCXeprR6SRwXmce
	 lCFAnMyjI82KsmaH/4LEU2OBkkvCgj3qrsddCNGhR3tSzgGr0xF/HzshlZln1MOrig
	 pygdnezAxjuMnSIVyrlf2HJ/BrpWzqR0XEocg3/xHjB8jsHOxBIvznMdMp3k6V/aIY
	 0hr2NR2twyo6k/XT3t7puQeCN4XwgZ+BVDmVDJ1PwrJjzLb+wvkET/et9GocU9poZO
	 bqRJuZn0aKbTeq7N6RFr+tY4SJDpq/KXVoPUmICIaiEdehjbWLlee2try45W12hpw3
	 TB219d/NuQzKg==
Date: Wed, 13 Dec 2023 10:41:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231213-unansehnlich-immun-a57123171e9d@brauner>
References: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <20231212154302.uudmkumgjaz5jouw@moria.home.lan>
 <CAJfpegvOEZwZgcbAeivDA+X0qmfGGjOxdvq-xpGQjYuzAJxzkw@mail.gmail.com>
 <20231212160829.vybfdajncvugweiy@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212160829.vybfdajncvugweiy@moria.home.lan>

> But when you show up to a discussion that's been going on for a page,

On the bcachefs mailing list without fsdevel or anyone else Cced.

> where everything's been constructively gathering input, and you start
> namecalling - and crucially, _without giving any technical justification

I didn't namecall at all. I just didn't like the flag and called it
"ugly" and explicitly said that I didn't see the value it brings. And
I'm not the only one.

I've been pretty supportive of the other parts of this. So I truly don't
understand why your turning this into a personal thing.

> for your opinions_ - that's just you being a dick.

Calling me a dick even if just implied is clearly crossing a line.

