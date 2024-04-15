Return-Path: <linux-fsdevel+bounces-16914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB428A4C72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C2E1C21FE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551955C13;
	Mon, 15 Apr 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9MLm8bj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7C535CB;
	Mon, 15 Apr 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176431; cv=none; b=TID5UgVQcyCG6/UbtAM8xKkhox8SNXl24OUnhtMmkKxq/dDr6D/KBF8JSonHFrdE/cafHdTg5R48usCTk9nuOvlR4hmjOtZM6dwo8INaMtqyeMQ7vMQPWFMPlTnrypz+8un/bB5NviRi/MFx1xiqXNUCTwLfWol+f0hBntM+AaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176431; c=relaxed/simple;
	bh=6UMiFTsFhYEEGtZ4XEeOJrBgUc9eTGN5FBSgmMG3Te4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rve95AeTkySlfA9wIeGuiGKS75Z2dpaYA45NGQCxrH8BezfvWB9xxmtMkkA62kHckCTVFNc9Daea6B3YaXgBJwRS1GHagGuJwmNJDVKZwWnq8HXUnjFylLSKnq2dOAJqf6muI8A/sKVsEKaQyQWrVCTC7Rvt/n4wbmYR82dYQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9MLm8bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E39FC3277B;
	Mon, 15 Apr 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713176430;
	bh=6UMiFTsFhYEEGtZ4XEeOJrBgUc9eTGN5FBSgmMG3Te4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9MLm8bjt1IxLJ0rEaiffh1+BwyrFVdDPVovgQkJ/ztiIFjIvE9165L6iGaAMpxHj
	 0SuQm/x2Jpmw4EDJyWTYa6/91BIIbG+y7rbzMvOZNSUejURiP6DPMcqC5ZOB5tsIGL
	 uflh5T33PYeBXj6XS8jnSTvV3HXO52Eh2MhjZIg18KBTCljLnNntHb60Duc3QQmGYG
	 N67gob/i31qh1iwDXUE111QPqHC/BD2bIqonRlpkI7ag4/RQLrkHD72DqRZejVuIs5
	 6xN8J+cwR/sURjV7iDUFvojZaIFzEpr3PHAMpmQ6TJ3H2zr9vwzpJq9ei3lPHo05Wg
	 Di84efpLFpMQQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwJRr-000000003Px-1IjG;
	Mon, 15 Apr 2024 12:20:28 +0200
Date: Mon, 15 Apr 2024 12:20:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>

On Mon, Apr 15, 2024 at 11:54:19AM +0200, Johan Hovold wrote:
> On Thu, Apr 11, 2024 at 02:03:52PM +0300, Konstantin Komarov wrote:

> > Messages like this:
> > 
> > diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> > index eb7a8c9fba01..8cc94a6a97ed 100644
> > --- a/fs/ntfs3/inode.c
> > +++ b/fs/ntfs3/inode.c
> > @@ -424,7 +424,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
> >      if (names != le16_to_cpu(rec->hard_links)) {
> >          /* Correct minor error on the fly. Do not mark inode as dirty. */
> > -        ntfs_inode_warn(inode, "Correct links count -> %u.", names);
> >          rec->hard_links = cpu_to_le16(names);
> >          ni->mi.dirty = true;
> >      }
> > 
> > can also be suppressed for the sake of seamless transition from a remote 
> > NTFS driver.
> > However, I believe that file system corrections should be reported to 
> > the user.
> 
> A colleague of mine also tracked down a failed boot to the removal of
> the ntfs driver and reported seeing similar warnings with the ntfs3
> driver.
> 
> We're both accessing an NTFS partition on a Windows on Arm device, but
> it makes you wonder whether these warnings (corrections) are correct or
> indicative of a problem in the driver?

This is what I see with a recursive ls on that partition (I've added
rec->hard_links in parentheses):

[   38.287555] ntfs3: nvme0n1p3: ino=2e1e7, Correct links count -> 1 (2).
[   38.288593] ntfs3: nvme0n1p3: ino=75ff, Correct links count -> 1 (2).
[   38.289887] ntfs3: nvme0n1p3: ino=1b4e1, Correct links count -> 1 (2).
[   38.290144] ntfs3: nvme0n1p3: ino=78c6, Correct links count -> 1 (2).
[   38.291313] ntfs3: nvme0n1p3: ino=8781b, Correct links count -> 1 (2).
[   38.291823] ntfs3: nvme0n1p3: ino=8781e, Correct links count -> 1 (2).
[   38.292289] ntfs3: nvme0n1p3: ino=87820, Correct links count -> 1 (2).
[   38.292978] ntfs3: nvme0n1p3: ino=87823, Correct links count -> 1 (2).
[   38.300531] ntfs3: nvme0n1p3: ino=a324, Correct links count -> 1 (2).
[   38.312235] ntfs3: nvme0n1p3: ino=882c3, Correct links count -> 1 (2).
[   43.286846] ntfs3: 5479 callbacks suppressed
[   43.286856] ntfs3: nvme0n1p3: ino=14aa, Correct links count -> 1 (2).
[   43.286998] ntfs3: nvme0n1p3: ino=14ac, Correct links count -> 1 (2).
[   43.287194] ntfs3: nvme0n1p3: ino=12cc2, Correct links count -> 1 (2).
[   43.287386] ntfs3: nvme0n1p3: ino=12ccd, Correct links count -> 1 (2).
[   43.287576] ntfs3: nvme0n1p3: ino=12d15, Correct links count -> 1 (2).
[   43.287667] ntfs3: nvme0n1p3: ino=12d19, Correct links count -> 1 (2).
[   43.287877] ntfs3: nvme0n1p3: ino=12d3a, Correct links count -> 1 (2).
[   43.288051] ntfs3: nvme0n1p3: ino=12d88, Correct links count -> 1 (2).
[   43.288265] ntfs3: nvme0n1p3: ino=874, Correct links count -> 1 (2).
[   43.288326] ntfs3: nvme0n1p3: ino=875, Correct links count -> 1 (2).
[   48.288211] ntfs3: 7735 callbacks suppressed
[   48.288220] ntfs3: nvme0n1p3: ino=33391, Correct links count -> 1 (2).
[   48.289115] ntfs3: nvme0n1p3: ino=347a4, Correct links count -> 1 (2).
[   48.290214] ntfs3: nvme0n1p3: ino=3553f, Correct links count -> 1 (2).
[   48.291193] ntfs3: nvme0n1p3: ino=35793, Correct links count -> 1 (2).
[   48.292818] ntfs3: nvme0n1p3: ino=358a0, Correct links count -> 1 (2).
[   48.293529] ntfs3: nvme0n1p3: ino=38f54, Correct links count -> 1 (2).
[   48.293901] ntfs3: nvme0n1p3: ino=391f6, Correct links count -> 1 (2).
[   48.294303] ntfs3: nvme0n1p3: ino=39324, Correct links count -> 1 (2).
[   48.294729] ntfs3: nvme0n1p3: ino=394a0, Correct links count -> 1 (2).
[   48.295063] ntfs3: nvme0n1p3: ino=3956a, Correct links count -> 1 (2).
[   53.289392] ntfs3: 11442 callbacks suppressed
[   53.289401] ntfs3: nvme0n1p3: ino=6293e, Correct links count -> 1 (2).
[   53.289972] ntfs3: nvme0n1p3: ino=61df1, Correct links count -> 1 (2).
[   53.290241] ntfs3: nvme0n1p3: ino=61df3, Correct links count -> 1 (2).
[   53.290578] ntfs3: nvme0n1p3: ino=61f3b, Correct links count -> 1 (2).
[   53.290881] ntfs3: nvme0n1p3: ino=62025, Correct links count -> 1 (2).
[   53.291045] ntfs3: nvme0n1p3: ino=629af, Correct links count -> 1 (2).
[   53.291181] ntfs3: nvme0n1p3: ino=61e3c, Correct links count -> 1 (2).
[   53.291463] ntfs3: nvme0n1p3: ino=61e22, Correct links count -> 1 (2).
[   53.291743] ntfs3: nvme0n1p3: ino=62882, Correct links count -> 1 (2).
[   53.292099] ntfs3: nvme0n1p3: ino=61b3d, Correct links count -> 1 (2).
[   58.291790] ntfs3: 5373 callbacks suppressed
[   58.291799] ntfs3: nvme0n1p3: ino=6d5a5, Correct links count -> 1 (2).
[   58.292106] ntfs3: nvme0n1p3: ino=6d7f6, Correct links count -> 1 (2).
[   58.292372] ntfs3: nvme0n1p3: ino=6db43, Correct links count -> 1 (2).
[   58.292653] ntfs3: nvme0n1p3: ino=72557, Correct links count -> 1 (2).
[   58.293244] ntfs3: nvme0n1p3: ino=728d8, Correct links count -> 1 (2).
[   58.294306] ntfs3: nvme0n1p3: ino=72c6e, Correct links count -> 1 (2).
[   58.294944] ntfs3: nvme0n1p3: ino=72ff7, Correct links count -> 1 (2).
[   58.295666] ntfs3: nvme0n1p3: ino=73271, Correct links count -> 1 (2).
[   58.296281] ntfs3: nvme0n1p3: ino=735fd, Correct links count -> 1 (2).
[   58.296991] ntfs3: nvme0n1p3: ino=73880, Correct links count -> 1 (2).
[   63.295009] ntfs3: 13921 callbacks suppressed
[   63.295017] ntfs3: nvme0n1p3: ino=6be65, Correct links count -> 1 (2).
[   63.295902] ntfs3: nvme0n1p3: ino=6c08e, Correct links count -> 1 (2).
[   63.296252] ntfs3: nvme0n1p3: ino=6c2e3, Correct links count -> 1 (2).
[   63.297581] ntfs3: nvme0n1p3: ino=6c610, Correct links count -> 1 (2).
[   63.298321] ntfs3: nvme0n1p3: ino=6c7f9, Correct links count -> 1 (2).
[   63.298730] ntfs3: nvme0n1p3: ino=6cb24, Correct links count -> 1 (2).
[   63.299079] ntfs3: nvme0n1p3: ino=6ceda, Correct links count -> 1 (2).
[   63.299408] ntfs3: nvme0n1p3: ino=6d288, Correct links count -> 1 (2).
[   63.299727] ntfs3: nvme0n1p3: ino=6d533, Correct links count -> 1 (2).
[   63.300080] ntfs3: nvme0n1p3: ino=6d77b, Correct links count -> 1 (2).
[   68.299457] ntfs3: 8228 callbacks suppressed
[   68.299467] ntfs3: nvme0n1p3: ino=3e248, Correct links count -> 1 (2).
[   68.301391] ntfs3: nvme0n1p3: ino=5d7b7, Correct links count -> 1 (2).
[   68.302440] ntfs3: nvme0n1p3: ino=5853d, Correct links count -> 1 (2).
[   68.303123] ntfs3: nvme0n1p3: ino=3ca2e, Correct links count -> 1 (2).
[   68.303722] ntfs3: nvme0n1p3: ino=59a98, Correct links count -> 1 (2).
[   68.304292] ntfs3: nvme0n1p3: ino=59a9b, Correct links count -> 1 (2).
[   68.304981] ntfs3: nvme0n1p3: ino=59a9e, Correct links count -> 1 (2).
[   68.305629] ntfs3: nvme0n1p3: ino=59aa1, Correct links count -> 1 (2).
[   68.306120] ntfs3: nvme0n1p3: ino=3214f, Correct links count -> 1 (2).
[   68.306539] ntfs3: nvme0n1p3: ino=2077b, Correct links count -> 1 (2).
[   73.302727] ntfs3: 8502 callbacks suppressed
[   73.302736] ntfs3: nvme0n1p3: ino=5aa99, Correct links count -> 1 (2).
[   73.303992] ntfs3: nvme0n1p3: ino=50ee9, Correct links count -> 1 (2).
[   73.304744] ntfs3: nvme0n1p3: ino=20420, Correct links count -> 1 (2).
[   73.305080] ntfs3: nvme0n1p3: ino=258c, Correct links count -> 1 (2).
[   73.305470] ntfs3: nvme0n1p3: ino=5a30d, Correct links count -> 1 (2).
[   73.307283] ntfs3: nvme0n1p3: ino=5a54c, Correct links count -> 1 (2).
[   73.307890] ntfs3: nvme0n1p3: ino=5c9de, Correct links count -> 1 (2).
[   73.308495] ntfs3: nvme0n1p3: ino=3d82d, Correct links count -> 1 (2).
[   73.309581] ntfs3: nvme0n1p3: ino=3d839, Correct links count -> 1 (2).
[   73.310016] ntfs3: nvme0n1p3: ino=25c77, Correct links count -> 1 (2).
[   78.304861] ntfs3: 11462 callbacks suppressed
[   78.304868] ntfs3: nvme0n1p3: ino=5c714, Correct links count -> 1 (2).
[   78.305579] ntfs3: nvme0n1p3: ino=57d11, Correct links count -> 1 (2).
[   78.306151] ntfs3: nvme0n1p3: ino=5842d, Correct links count -> 1 (2).
[   78.307412] ntfs3: nvme0n1p3: ino=34e6, Correct links count -> 1 (3).
[   78.307843] ntfs3: nvme0n1p3: ino=5bb23, Correct links count -> 1 (2).
[   78.308509] ntfs3: nvme0n1p3: ino=5c722, Correct links count -> 1 (2).
[   78.310018] ntfs3: nvme0n1p3: ino=5d761, Correct links count -> 1 (2).
[   78.310717] ntfs3: nvme0n1p3: ino=33d18, Correct links count -> 1 (3).
[   78.311179] ntfs3: nvme0n1p3: ino=5d75b, Correct links count -> 1 (3).
[   78.311605] ntfs3: nvme0n1p3: ino=5c708, Correct links count -> 1 (3).

Johan

