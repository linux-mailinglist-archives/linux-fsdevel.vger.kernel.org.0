Return-Path: <linux-fsdevel+bounces-79725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJnjBRkwrmlrAQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 03:27:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85897233415
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 03:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4A63301302E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 02:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEEE2737F2;
	Mon,  9 Mar 2026 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp/GVCZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1E187FE4
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023232; cv=none; b=XMdyqkY9vaNKMZ8uVZiIWVLDnYEz7u5A+I3k8wNQEs2sXMM4IKB1AsaiDZZQl/HLZBHEDCdjameKnAwg87Mxl0Hr4kQtKHcqQrNbDBjBW88WJqi5tgCpJHMWsrdVN5kJ6L41BanvrJtCjcj7DVtUr8ton4e+21NhDaXBeLkW7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023232; c=relaxed/simple;
	bh=A78duPVA2iyZOarwAbtIOjL15dtEn65lOcUzaC3dyvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT+jzkGl/SGVkeA9E5/8vSqvHIq7aj9LynzxUs+MgJ+l3XzqTZoL/BV2z7LGhum5aFFeT8Rj5RimrR20ORHu0I0aFePEfKdEFhInpfqDEUOhZ+D3QAWK6OxLJo+lSoynGpjdb+v2JX9BPsQ4OYbN2SeWcUmpNqXgwJDr00KNvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp/GVCZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CC9C116C6;
	Mon,  9 Mar 2026 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773023231;
	bh=A78duPVA2iyZOarwAbtIOjL15dtEn65lOcUzaC3dyvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sp/GVCZbKCTV5WdMilSINhoHl2BMXN0nbFBjkwr2T+7KTunUSUq+6I3Woip1dxBiT
	 LNoFh/cQBh5rOiO77+y9J3bwUPwomVitjAzESvUClqhoVzwvTQXozpw4ogN2uQUWen
	 K6nRzbH8ow99AogO4HkJHxNSbcc1vlrYSdT4OaXMQW6CHO2IMcKpeHBq7IVhuBzPZA
	 jVSFIwVrr+7hsMecPQdvD1fwohHSVN9Uz3XkWCVfOig54PsqF3wDmJuoyngfVsZx+M
	 Xff294CdyWsxNX30B/MOvqpGjRIV0t8VILz48JboBRLQRpozn0nFn1I9yJjPy82jMT
	 blUKXwH67CXQw==
Date: Sun, 8 Mar 2026 19:27:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260309022710.GA6012@frogsfrogsfrogs>
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
 <20260304232353.GS13829@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304232353.GS13829@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 85897233415
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79725-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:23:53PM -0800, Darrick J. Wong wrote:
> On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
> > 
> > 
> > On 3/4/26 01:11, Darrick J. Wong wrote:
> > > Hi Bernd,
> > > 
> > > Please pull this branch with changes for libfuse.
> > > 
> > > As usual, I did a test-merge with the main upstream branch as of a few
> > > minutes ago, and didn't see any conflicts.  Please let me know if you
> > > encounter any problems.
> > 
> > Hi Darrick,
> > 
> > quite some problems actually ;)
> > 
> > https://github.com/libfuse/libfuse/pull/1444
> > 
> > Basically everything fails.  Build test with
> > 
> > ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
> > fatal error: 'systemd/sd-daemon.h' file not found
> >    24 | #include <systemd/sd-daemon.h>
> > 
> > 
> > Two issues here:
> > a) meson is not testing for sd-daemon.h?
> > a.1) If not available needs to disable that service? Because I don't
> > think BSD has support for systemd.
> > 
> > b) .github/workflow/*.yml files need to be adjusted to add in the new
> > dependency.
> > 
> > 
> > Please also have a look at checkpatch (which is a plain linux copy) and
> > the spelling test failures.
> 
> I have a few questions after running checkpatch.pl (the one in the
> libfuse repo):
> 
> 1. What are the error return conventions for libfuse functions?
> 
>    The lowlevel library mostly seems to return 0 for succes or negative
>    errno, but not all of them are like that, e.g. fuse_parse_cmdline*.
> 
>    The rest of libfuse mostly seems to return 0 for success or -1 for
>    error, though it's unclear if they set errno to anything?
> 
>    This comes up because checkpatch complains about "return ENOTBLK",
>    saying that it should be returning -ENOTBLK.  But I'm already sorta
>    confused because libfuse and its examples use positive and negative
>    errno inconsistently.

Hi Bernd,

Having spent a few days looking through lib/fuse*.c more carefully, I've
come to the conclusion that most lowlevel library functions return 0 or
negative errno on failure, and they often call fuse_log to complain
about whatever failed.  Oddly, fuse_reply_err takes positive errno and
ll servers are required to handle sign conversions correctly.  The high
level fuse library does this inversion.

If that sounds like a reasonable approach for fuse_service.c then I'll
convert it to log and return negative errno like the lowlevel library
does.  Right now it mostly sets errno and returns -1, and isn't
completely consistent about fuse_log().  util/mount_service.c will get
changed to fprintf to stderr and return negative errno on failure.

For *_service.c functions that pass around fds from files opened on the
other side of the service socket, a failure to open a file will result
in the negative errno being sent in place of an fd.

How does that sound?

--D

> 2. There's no strscpy, but the check is left on, and there are plenty of
>    users in libfuse.
> 
> 3. Comments at the top of files -- checkpatch complains that the
>    non-first lines of a multiline C comment should start with " * "but
>    not all of them do that.  Should I just do C comments the way
>    checkpatch wants?  Or keep going with the existing code?
> 
> --D
> 
> > Thanks,
> > Bernd
> > 
> > 
> 

