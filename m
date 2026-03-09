Return-Path: <linux-fsdevel+bounces-79838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAiEBRQUr2nJNQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:40:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390123EB80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB88310B08F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F0349B1C;
	Mon,  9 Mar 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+s/szMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7B340A59
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081328; cv=none; b=AGAHGIhg5eyDVNQ/SDzImE+8XQd6zdExtW1re06291/AeBKFnxSpk8XdAYNGH4O8FTZmx6vvw/E0UgcAvuKfb47+3GEQ2hUtahCv4NpBTwxB9vDPkGVLbkv6bKyiNSnfWxtF3wwfnsbdcIsPQi1i+95RUZ2+8sWD6roG8rrQiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081328; c=relaxed/simple;
	bh=nF787sr2BnRi+zUnax+t8uLIU88UGpf/xu/38vFtlX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzYh5+q/jgoRCYSHT+gzHk9WihiS+/Fx8vpXev3/h6SpUzl/8OgB6YguWqELDmFJGIFy0bA9DD+cqDgmsqIBDwDSbU4sOjA48KauHXxG1fdWMR7DiLq6l4MZ2jRp1TTv+sdeQMs/N9BdBd1dLcvsSOquZBsPoBP39khWsborFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+s/szMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5332AC4CEF7;
	Mon,  9 Mar 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773081328;
	bh=nF787sr2BnRi+zUnax+t8uLIU88UGpf/xu/38vFtlX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+s/szMdvL23289PEgDt8IVO0psFvvHsR08z0Z+Ao+Ge0rAeJHV9zfiIAhLXYWXUi
	 xxezrTVRUwSi2GK2Q5BzJWv2SpO3WFF2JZBNI52aim5PmSqTru2J4S9ooszUWDDsQt
	 Tm9Uf8SsTblRLsdzlSbJuqkG6HBeEGrkGYl1x1UiYWISxP3dVD3pVj3CwJnbFLOwfD
	 mCeq8zV9+IiQQz+jwKz8zSUL54GEcttni2etl991QeL8/Kl7+Z3lvMqSNX3CGxs8m+
	 BDQOf98RWF8nRRhinEli0hsP/bdphCMlm6rJVttWl8/yuAkneiYfLeACrWcGHwzQHZ
	 RLffawZcv6V/g==
Date: Mon, 9 Mar 2026 11:35:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260309183527.GB6069@frogsfrogsfrogs>
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
 <20260304232353.GS13829@frogsfrogsfrogs>
 <20260309022710.GA6012@frogsfrogsfrogs>
 <74356338-99d3-41dd-9ec0-12f62a1d7e6a@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74356338-99d3-41dd-9ec0-12f62a1d7e6a@bsbernd.com>
X-Rspamd-Queue-Id: 7390123EB80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79838-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 06:34:32PM +0100, Bernd Schubert wrote:
> Hi Darrick,
> 
> really sorry for mys late reply. To my excuse I have the flu since
> Thursday and until yesterday it got worse every day.

Oh, no worries.  I hope you feel better soon, but take the time to rest
and get well!

> On 3/9/26 03:27, Darrick J. Wong wrote:
> > On Wed, Mar 04, 2026 at 03:23:53PM -0800, Darrick J. Wong wrote:
> >> On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 3/4/26 01:11, Darrick J. Wong wrote:
> >>>> Hi Bernd,
> >>>>
> >>>> Please pull this branch with changes for libfuse.
> >>>>
> >>>> As usual, I did a test-merge with the main upstream branch as of a few
> >>>> minutes ago, and didn't see any conflicts.  Please let me know if you
> >>>> encounter any problems.
> >>>
> >>> Hi Darrick,
> >>>
> >>> quite some problems actually ;)
> >>>
> >>> https://github.com/libfuse/libfuse/pull/1444
> >>>
> >>> Basically everything fails.  Build test with
> >>>
> >>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
> >>> fatal error: 'systemd/sd-daemon.h' file not found
> >>>    24 | #include <systemd/sd-daemon.h>
> >>>
> >>>
> >>> Two issues here:
> >>> a) meson is not testing for sd-daemon.h?
> >>> a.1) If not available needs to disable that service? Because I don't
> >>> think BSD has support for systemd.
> >>>
> >>> b) .github/workflow/*.yml files need to be adjusted to add in the new
> >>> dependency.
> >>>
> >>>
> >>> Please also have a look at checkpatch (which is a plain linux copy) and
> >>> the spelling test failures.
> >>
> >> I have a few questions after running checkpatch.pl (the one in the
> >> libfuse repo):
> >>
> >> 1. What are the error return conventions for libfuse functions?
> >>
> >>    The lowlevel library mostly seems to return 0 for succes or negative
> >>    errno, but not all of them are like that, e.g. fuse_parse_cmdline*.
> >>
> >>    The rest of libfuse mostly seems to return 0 for success or -1 for
> >>    error, though it's unclear if they set errno to anything?
> >>
> >>    This comes up because checkpatch complains about "return ENOTBLK",
> >>    saying that it should be returning -ENOTBLK.  But I'm already sorta
> >>    confused because libfuse and its examples use positive and negative
> >>    errno inconsistently.
> > 
> > Hi Bernd,
> > 
> > Having spent a few days looking through lib/fuse*.c more carefully, I've
> > come to the conclusion that most lowlevel library functions return 0 or
> > negative errno on failure, and they often call fuse_log to complain
> > about whatever failed.  Oddly, fuse_reply_err takes positive errno and
> > ll servers are required to handle sign conversions correctly.  The high
> > level fuse library does this inversion.
> 
> Yeah I know, confusing. But without breaking the API I don't think there
> is much we can do about now.

<nod> I agree, the existing library api can't change unless someone
introduce a new name (e.g. fuse_session_custom_io_317)

> > If that sounds like a reasonable approach for fuse_service.c then I'll
> > convert it to log and return negative errno like the lowlevel library
> > does.  Right now it mostly sets errno and returns -1, and isn't
> > completely consistent about fuse_log().  util/mount_service.c will get
> > changed to fprintf to stderr and return negative errno on failure.
> 
> 
> Sounds good to me. Obviously for expected errors you don't want to

Ok good, will go do that this afternoon.

For logging ... I think what I'm going to do is log communication errors
between the mount helper and the fuse server, but pass errors from the
kernel api calls (e.g. ENOENT for an open()) straight to the fuse server
and let them figure out what they want to do.

Maybe I'll consider negative errno for comms failure and positive errno
for expected errors <shrug>.  Let's see how that goes.

> create logs. Logging is another topic I need to address at some point,
> so that one can set the actual level one wants to print.

Oh, I figured one simply overrode the logging function if they wanted
non-default parameters. ;)

> > For *_service.c functions that pass around fds from files opened on the
> > other side of the service socket, a failure to open a file will result
> > in the negative errno being sent in place of an fd.
> > 
> > How does that sound?
> > 
> > --D
> > 
> >> 2. There's no strscpy, but the check is left on, and there are plenty of
> >>    users in libfuse.
> 
> Hrmm right, I had copied the script from linux to libfuse so that it
> complains about wrong code style. So far it was mostly possible to
> disable checks, in this specific case we probably need to modify
> checkpatch. Pity, that will make it impossible to simply copy over newer
> versions.

Oh I was just extracting the checkpatch.pl command line from
.github/workflows/checkpatch.yml so I think you could just add "STRCPY"
to the --ignore value in that file.

> >>
> >> 3. Comments at the top of files -- checkpatch complains that the
> >>    non-first lines of a multiline C comment should start with " * "but
> >>    not all of them do that.  Should I just do C comments the way
> >>    checkpatch wants?  Or keep going with the existing code?
> 
> I guess here it is better to follow checkpatch and change to the style,
> it expects.

That is the nice thing about running checkpatch as a git hook -- it only
applies to new(ly changed) code. :)

Get well soon!

--D

> 
> 
> Thanks,
> Bernd
> 
> 

