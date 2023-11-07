Return-Path: <linux-fsdevel+bounces-2211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3669B7E370D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 09:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6769C1C209AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7E10A14;
	Tue,  7 Nov 2023 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4MWIjrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA677CA46;
	Tue,  7 Nov 2023 08:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5EAC433C7;
	Tue,  7 Nov 2023 08:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699347534;
	bh=e8n5pk5j6yUR/09REfBbNOpZ8ZAl3nWVcJlQ20VHesE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4MWIjrkL+AQkWzFjqcZQuntKkwqnMVbsqf+WdFM246GxEMTDieE8xpo9mbN0cA5w
	 k1dMYh6HE+8G1Qp6qVzBGcA5zHmEUjd29+0e8zuazmTsxliKLwJ4GzuTsKMSBzPx5Q
	 LWYtpS9RYQXrURsTEHkOdZdzW/1ReIJEui8K2bEL2/fkcA3xLxnZJn7cixqtvu6U+O
	 K5JQNFYIdB+X13hdb2c1tZSJHUtr0DFatNXGlRsR/owbvjwHv+vigPlG4LUD57nEUy
	 oQTKMTZcpQFjtKx124JKvSyDAB3m8J9k/m6nahFvUIYPu3fFs3++oj//YWtEdMcW69
	 WI2Lo7bDLZxFg==
Date: Tue, 7 Nov 2023 09:58:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231107-herde-konsens-7ee4644e8139@brauner>
References: <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUkeBM1sik1daE1N@infradead.org>

On Mon, Nov 06, 2023 at 09:10:28AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 06, 2023 at 02:05:45PM +0100, Christian Brauner wrote:
> > > > I think spending time engaging this claim isn't worth it. This is just
> > > > easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
> > > > util-linux.
> > > 
> > > Myabe you need to get our of your little bubble.  There is plenty of
> > 
> > Unnecessary personal comment, let alone that I'm not in any specific
> > bubble just because I'm trying to be aware of what is currently going on
> > in userspace.
> 
> Maybe you're just taking it to personal?  A place where systemd, lxc,

Of course I'm taking that personal. It's a personal comment that
unnecessarily accompanies the message that you think I discount software
that isn't all that modern. Which is a fair point. It doesn't have to
come with garnish about me living in a bubble.

Which is also a little insulting because you very well know that I spend
hours each cycle fixing all kinds of weird regressions from software
from the stone age.

> runc, and util-linux are "all software" is a very much a bubble as you
> won't find much userspace that stays more uptodate with particular
> quirks of modern Linux features.

You assume that your solution doesn't break things. And it will. For
btrfs users and for other userspace tools as well. As detailed in other
parts of the thread.

> 
> > Whatever you do here: vfsmounts or any other solution will force changes
> > in userspace on a larger scale and changes to the filesystem itself. If
> > you accommodate tar then you are fscking over other parts of userspace
> > which are equally important. There is no free lunch.
> 
> It works for everything that knows that Linux mountpoint as exposed
> in /proc/mounts and proc/self/mountinfo corresponds to the posix
> definition of a mount point, and that one used on basically every
> other unix system.  It might not work as-is for software that actually
> particularly knows how to manage btrfs subvolumes, but those are, by
> defintion, not the problem anyway.

On current systems and since forever bind-mounts do not change device
numbers unless they are a new filesystem mount. Making subvolumes
vfsmounts breaks that. That'll mean a uapi change for
/proc/<pid>/mountinfo for a start.

It also risks immediately breaking basic stuff such as associating
vfsmounts with the superblock they belong to via device numbers from
parsing /proc/<pid>/mountinfo.

And see other mails for other side-effects of this.              

All of this also discounts the invasive effects that it will have when
you suddenly start plopping automounts into the mount tables of
processes on lookup and propagting subvolumes as vfsmounts into random
mount namespaces. I've detailed problems with automounts that btrfs
would get themselves into elsewhere so I'm not going to repeat it here.

