Return-Path: <linux-fsdevel+bounces-38126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE329FC617
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123081882B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6A1B2193;
	Wed, 25 Dec 2024 16:57:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CB2B9A6;
	Wed, 25 Dec 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735145821; cv=none; b=S2eIF3vtxh58X+ib7jbK/ZB0dgeBsbT4MurBugE1V5ocS/jnTNoQERt55wwe73FIhVUa1/pm3YkhPjqnAVW/wBoXmzZ2xmilvt9wFHfaugGZ1Q8rxpHkKOiCGugO3/scdsymJihI+M4bQbpYbEo0013GdEqzjtFg7C29rmQozkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735145821; c=relaxed/simple;
	bh=x4OAGJ4P1bPYtVtXUa8S1IXroYuJrj8fCgyK+dv6XIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owPdOueRD5ePaGMFKW43+3a4AjZ21fNPMOAdrbOnhvf6HbJtcAoWoL81j1DoWuHmHgTtOQDTQp/EV7b6A5v2n/dI/lCxKpAKu0Fe4tRe8vgoQLGvr+sw4rLd4bdHLIVt91Q9PwhYMkLmjxiz9SA7Zo4Mmw0wwt9Sfagx48T7YpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4BPGucMm012370;
	Wed, 25 Dec 2024 17:56:38 +0100
Date: Wed, 25 Dec 2024 17:56:38 +0100
From: Willy Tarreau <w@1wt.eu>
To: WangYuli <wangyuli@uniontech.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Overstreet <kent.overstreet@linux.dev>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241225165638.GA12343@1wt.eu>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <D7FF3455CE14824B+a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
 <20241225160017.GA10283@1wt.eu>
 <9B33A2E79ADF512B+c7748c58-9b1c-4759-8131-1007c08e9f46@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B33A2E79ADF512B+c7748c58-9b1c-4759-8131-1007c08e9f46@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 26, 2024 at 12:32:35AM +0800, WangYuli wrote:
> Hi,
> 
> I've reviewed the Contributor Covenant and the Linux Kernel Contributor
> Covenant Code of Conduct Interpretation, and I couldn't find anything
> suggesting that CCing a large number of people is "unfriendly".

This is unrelated, it's a matter of basic social interactions and respect
of others' time.

> And while I don't believe my actions were malicious, I understand your
> concern.
> 
> Going forward, I'll be more considerate of the recipients when sending
> emails and will avoid CCing more than a hundred people at once in similar
> situations.

"More than a hundred" ? Are you serious ? For what purpose ? I'll explain
you something related to how people consume e-mails: the first thing they
do if they hesitate to process it is to check if someone else in the To
or Cc is more knowledgeable or legitimate than them. If so they often
prefer to let others deal with it. With such a large list, it's impossible
to check all other addresses and virtually *everyone* will consider that
surely one of the hundreds of others is more legitimate. So the more people
you add, the less likely anyone will handle your request.

The common rules that apply here are not made out of nowhere but based on
what works best. Just send to the most relevant outputs of get_maintainer,
wait for one week and if you get no response it's just that these people
were busy and forgot about you, so just kindly ping again to make sure
your message was received. With such a large community it's normal to lose
some messages, and pinging again is normally not considered as an offence
so that's fine. If you get no response after multiple attempts, it might
mean there's something annoying in your message (like sending to tens or
hundreds of people at once).

And really, when a script tells you "send your message to these 3 people"
and you send it to 191, how can you imagine the recipients will think
anything different from "this person feels super important to spam
everyone like this". Why would they even respond if they feel like you
consider you have the right to spam everyone in hope to get your orders
processed immediately ? I'm pretty sure that the majority will just let
it rot by principle.

Good luck,
Willy

