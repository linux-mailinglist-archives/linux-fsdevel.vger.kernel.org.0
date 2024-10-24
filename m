Return-Path: <linux-fsdevel+bounces-32824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33579AF53E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 00:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5957A1F21CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54444218D6D;
	Thu, 24 Oct 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NTQQuRnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D82178F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808360; cv=none; b=s+TzdHAp/V0OravtnA8Jxy6ge8PDXrdlx2bk2NCnUVm+PVwClIw5k4PAqXl4DBBFOnJj8JpSKI5e+E8TYcVKg7iG9hu3VZRNI76AwfM/L2Em+o2RIhdAbT/UyPiLeZ3ALH9hKDEwkFU+6It0Sv4z3rW+w4R0HTfW90umigz9MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808360; c=relaxed/simple;
	bh=xiA+f1cnlU406zXgM71RLQpj8FPKXw9TNOVXfqwWjZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jig1RYuNSHhCmGVNG9dxxl2h14628qkmgtVZ4lguVuUJo8Gc7RhWD/EK9YGsVa+rXfQNU0Cs6khtdDsoau6fwXmktXiVoL22OegUbmOCNtConk7PNOwEOEV0dMBONYJPZ5XhDVmEEIqUsLl+OE9T2mcExt3ZDBRkd2Ymaut0jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NTQQuRnp; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 18:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729808354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRN2XvuPczg6eIRqeI5o08GA1KQ3w/NT/PiW4sNw5Eg=;
	b=NTQQuRnpuKJqvwOOrhBQGIoqcO3lxe03hXBSkRWRk+cnHbRTHEotCqQ5yWlYonnZtd86ii
	LQtQF/p9gQrXdkoU1XdwMDim+gpSUGB455qtgMFRPd+rD0kWIObGDa6djlOnSKBqfPqKX0
	BLIjPfiWPbTLXdAnEiDc37YwTJU+iOU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	"Darrick J. Wong" <djwong@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org, hch@infradead.org, broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <n4lt6eghfunnzz4zx4hhy5asyw55mv4q6ew3fusd2lawufgsnl@2c2cai6esxl3>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
 <20241022204931.GL21836@frogsfrogsfrogs>
 <ZxgXO_uhxhZYtuRZ@sashalap>
 <87iktj2j7w.fsf@mail.lhotse>
 <Zxjg7Cvw0qIzl0v6@sashalap>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxjg7Cvw0qIzl0v6@sashalap>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 07:41:32AM -0400, Sasha Levin wrote:
> On Wed, Oct 23, 2024 at 09:42:59PM +1100, Michael Ellerman wrote:
> > Hi Sasha,
> > 
> > This is awesome.
> > 
> > Sasha Levin <sashal@kernel.org> writes:
> > > On Tue, Oct 22, 2024 at 01:49:31PM -0700, Darrick J. Wong wrote:
> > > > On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
> > > > > other information that would be useful?
> > > > 
> > > > As a maintainer I probably would've found this to be annoying, but with
> > > > all my other outside observer / participant hats on, I think it's very
> > > > good to have a bot to expose maintainers not following the process.
> > > 
> > > This was my thinking too. Maybe it makes sense for the bot to shut up if
> > > things look good (i.e. >N days in stable, everything on the mailing
> > > list). Or maybe just a simple "LGTM" or a "Reviewed-by:..."?
> > 
> > I think it has to reply with something, otherwise folks will wonder if
> > the bot has broken or missed their pull request.
> > 
> > But if all commits were in in linux-next and posted to a list, then the
> > only content is the "Days in linux-next" histogram, which is not that long
> > and is useful information IMHO.
> > 
> > It would be nice if you could trim the tail of the histogram below the
> > last populated row, that would make it more concise.
> 
> Makes sense, I'll do that.
> 
> > For fixes pulls it is sometimes legitimate for commits not to have been
> > in linux-next. But I think it's still good for the bot to highlight
> > those, ideally fixes that miss linux-next are either very urgent or
> > minor.
> 
> Right, and Linus said he's okay with those. This is not a "shame" list
> but rather "look a little closer" list.

Ok, that makes me feel better about this. I've got stuff that I hold
back for weeks (or months), and others that I'm fine with sending the
next day, once it's passed my CI.

I'm going to try to be better about talking about which patches have
risks (and why that risk is justified, else I wouldn't be sending it),
or which patches look more involved but I've got reason to be confident
about - that can get quite subtle. That's good for everyone down the
line in terms of knowing what to expect.

I wonder if also some of this is motivated by people concerned about
things in bcachefs moving too fast, and running the risk of regressions?
That's a justifiable concern, and priorities might be worth talking
about a bit.

I'm not currently seeing anything that makes me too concerned about
regressions: users in general aren't complaining about regressions
(previous pull request a user chimed in that he had been seeing less
stability past few kernel releases, and he tried switching back to btrfs
and the issues were still there) and my test dashboard is steadily
improving.

I do still have fairly critical (i.e. downtime causing) user reported
issues coming in that are taking most of my time, although they're
getting off into the weeds - one I've been working on the past few days
was reported by a user with a ~20 drive filesystem where we're
overflowing the maximum number of pointers in an extent, due to keeping
too many cached copies around, and his filesystem goes emergency
read-only. And there still seems to be something not-quite-right with
snapshots and unlinked inodes, possibly a repair issue.

Test dashboard still has a long ways to go before it's anywhere near as
clean as I want (and it needs to be, so that I can easily spot
regressions), but number of test failures have been steadily dropping
and the results are getting more consistent, and none of the test
failures there are scary ones that need to be jumped on.

https://evilpiepirate.org/~testdashboard/ci?user=kmo&branch=bcachefs-testing

(We were at 150-160 failures per full run a few weeks ago, now 100-110.
The full runs also run fstests in 8 different configurations, so lots of
duplicates).

There have been a lot of new syzbot reports recently, and some of those
do look more concerning. I don't think this indicates regressions - this
looks to be like syzbot getting better with its code-coverage-guided
testing at finding interesting codepaths, and for the concerning ones I
don't think the code changed in the right timeframe for it to be a
regressions. I think several of the recent syzbot reports are all due to
the same bug, where it looks like we're not going read-only correctly
and interior btree updates are still happening - I suspect that's been
there for ages and an assert I recently added is making it more visible.

I am still heavily in triage mode, and filesystem repair/recovery bugs
take top priority. In general, my priorities are
- critical user reported bugs first
- failures from my automated test suite second (unless they're
  regressions)
- syzbot last, because there's been basically zero overlap with syzbot
  bugs and user-affecting bugs so far, and because that's been an easy
  place for new people to jump in and help.

