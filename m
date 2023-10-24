Return-Path: <linux-fsdevel+bounces-1019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E2E7D4F2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73931C20BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68BD266B1;
	Tue, 24 Oct 2023 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsplmtvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A528224F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 11:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC6EC433C7;
	Tue, 24 Oct 2023 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698148043;
	bh=JyWAb8ZHZK8jUotbEYIBEzVXIW6FDwpM3jjmNu5/IpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsplmtvZ2nc2w/84Ft8AWcsgZPGZWEJxHBwnP05Wzd7s+ouTLbexdg3TR26Q67/V9
	 9vppMT2kY3KCElBDUOo33kvoEeHQRF7soh5JoUKD2IZ1YlDZUAW/T8MWmGYhysbign
	 EsLLGC76gZ7NDpURzBmTbeIdfi9j02JRVduiF8nWIUeQ5dTkF3IkWJjH40SjBgDEtE
	 efpVonPPGj4nRL3AHyc5xZUahS7wwv7iYoOcKW4awHEN9LjLMzekrpBQfl7D9oBQjW
	 CGHPq6z20FDTl9oiCcx1LLh5uc4ZmnaEzIobFhovRkxFW9L0tMqPaqZEt4y/4IpwWF
	 q8RAodILfHStg==
Date: Tue, 24 Oct 2023 13:47:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, jstancek@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
Message-ID: <20231024-flora-gerodet-8ec178f87fe9@brauner>
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
 <20231023223810.GW3195650@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023223810.GW3195650@frogsfrogsfrogs>

On Mon, Oct 23, 2023 at 03:38:10PM -0700, Darrick J. Wong wrote:
> On Sat, Oct 21, 2023 at 09:46:35AM -0700, Linus Torvalds wrote:
> > On Fri, 20 Oct 2023 at 23:27, Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > Please pull this branch with changes for iomap for 6.6-rc7.
> > >
> > > As usual, I did a test-merge with the main upstream branch as of a few
> > > minutes ago, and didn't see any conflicts.  Please let me know if you
> > > encounter any problems.
> > 
> > .. and as usual, the branch you point to does not actually exist.
> > 
> > Because you *again* pointed to the wrong tree.
> > 
> > This time I remembered what the mistake was last time, and picked out
> > the right tree by hand, but *please* just fix your completely broken
> > scripts or workflow.
> > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5
> > 
> > No.
> > 
> > It's pub/scm/fs/xfs/xfs-linux, once again.
> 
> Sorry about that.  After reviewing the output of git request-pull, I
> have learned that if you provide a $url argument that does not point to
> a repo containing $start, it will print a warning to stderr and emit a
> garbage pull request to stdout anyway.  No --force required or anything.
> Piping stdout to mutt without checking the return code is therefore a
> bad idea.
> 
> I have now updated my wrapper script to buffer the entire pull request
> contents and check the return value before proceeding.
> 
> It is a poor workman who blames his tools, so I declare publicly that
> you have an idiot for a maintainer.
> 
> Christian: Do you have the bandwidth to take over fs/iomap/?

If this helps you I will take iomap over but only if you and Christoph
stay around as main reviewers. There's not much point in me pretending I
can meaningfully review fs/iomap/ and I don't have the bandwith even if
I could. So not without clear reviewers.

But, - and I'm sorry if I may overstep bounds a little bit - I think
this self-castigation is really unwarranted. And we all very much know
that you definitely aren't an idiot. And personally I think we shouldn't
give the impression that we expect this sort of repentance when we make
mistakes.

In other words, if the sole reason you're proposing this is an
objectively false belief then I would suggest to reconsider.

