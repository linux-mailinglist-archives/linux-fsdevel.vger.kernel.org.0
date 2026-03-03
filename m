Return-Path: <linux-fsdevel+bounces-79274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLs0L5Uhp2mMegAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 18:59:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED01F4E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 988183031214
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE53D565D;
	Tue,  3 Mar 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji3FbPuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876D366577;
	Tue,  3 Mar 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560786; cv=none; b=C5M+F2Pcc/wih3O5SkKE2ThN6nCzJ5s6KpuafNtPpju8g9O1w+KEyjNKr2tT9FbSoP2QZFah668ilLBIpZxFi/liZ0IonVaGllLMT10E7rQ0qagnAAP9DbmtH+y+aNqzO82BkP4zCMOLP/nCqYAmwrOuwA9IQeJ/M+kAiNtctH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560786; c=relaxed/simple;
	bh=7w4Yv3iEeerca9ZUbPzIO0+RunrJzrs7MoONu9vAzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFhkRCXcE+9CvOXrYyPJEZpIyeHSTiTwP5ISQreHSIJBbZhgdEgyexWvTNsZhgLpGweXEAW2Y2KPFx7GOgjqHnRo489Af+LMnT3G5XU2NbkXQKgENloXarKxO3c8mtnuKTJc3lXDoakDk4byieTAUAs3gFah2sHJszEVkPvHFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji3FbPuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4E9C116C6;
	Tue,  3 Mar 2026 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772560785;
	bh=7w4Yv3iEeerca9ZUbPzIO0+RunrJzrs7MoONu9vAzrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji3FbPuYUcizrCG/pFTd6Ed2+fSE7Gol20eivW+pSW1siolnXkL6ykgYVjZKdnSBy
	 YF4CvJr8tBX+NILNkL5xawompxRfORJFSICOplscgVnxAq0faQvLPITYuwrSMayjDb
	 G8sjRLbCH6/OmyoQGTKO/nKq8dZk+gLqGxMcNMOZkkU43sqE+1zzDj0RxfJ+WfJCOn
	 cGtvCQmnmGvcfK4445BXgcPNJ5fvxHHfY2sIsLuBT0liD2I4J00Js5rWrxWFM7V6Bf
	 lW0CEGUKyQzRvxJV7uPkG4jPeXaOKLX480scoJQ/eK3KolfP7tpRZCrJbh+BBd8K2D
	 0MaZ9TU0ZobmQ==
Date: Tue, 3 Mar 2026 09:59:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gabriel@krisman.be, amir73il@gmail.com, jack@suse.cz,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <20260303175945.GE13843@frogsfrogsfrogs>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <aab2JbAZI8RFq_XE@infradead.org>
 <20260303164901.GJ57948@frogsfrogsfrogs>
 <aacR-EYFd0x_nRz-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacR-EYFd0x_nRz-@infradead.org>
X-Rspamd-Queue-Id: 47ED01F4E2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lst.de,krisman.be,gmail.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79274-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:53:12AM -0800, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 08:49:01AM -0800, Darrick J. Wong wrote:
> > > > +ext4)
> > > > +	# added at the same time as uevents
> > > > +	modprobe fs-$FSTYP
> > > > +	test -e /sys/fs/ext4/features/uevents || \
> > > > +		_notrun "$FSTYP does not support fsnotify ioerrors"
> > > > +	;;
> > > > +*)
> > > > +	_notrun "$FSTYP does not support fsnotify ioerrors"
> > > > +	;;
> > > > +esac
> > > 
> > > Please abstract this out into a documented helper in common/
> > 
> > Ok.  I'm not sure how to check for feature support on ext4 anymore since
> > the uevents patch didn't get merged, and then I clearly forgot to rip
> > that out of this helper here.
> 
> Oh.  Well, drop that then and move the xfs side and the default n
> into a common helper instead of hardcoding it in the test.

/me discovers that Baolin Liu added a "err_report_sec" sysfs knob to
ext4 in 7.0-rc1, so I can just change the helper to look for that.  I'll
move the logic to common/rc.

> > > and add proper error injection to the block code, which has been
> > > somewhere on my todo list forever because dm-error and friends are
> > > so painful to setup.  Maybe I need to expedite that.
> > 
> > I think it's theoretically possible to figure out that there's a zone
> > size and then round outwards the error-target part of the dm table to
> > align with a zone.
> 
> It's the sysfs chunk size.  btrfs/237 harcodes reading that out,
> which could be easily lifted into a helper.
> 
> > I have a lot more doubts about whether or not doing
> > that in bash/awk is a good idea though.  It'd be a lot easier if either
> > the block layer did error injection or if someone just fixes those
> > limitations in dm itself.
> 
> I'll sign up to do the block layer stuff.  Doing so should allow us
> to run a lot more of the error injetion tests on zoned xfs, which
> would be good.  So I guess you should keep it as-is for now,
> and I'll do a sweep later.

Ok, thanks. :)

--D

