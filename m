Return-Path: <linux-fsdevel+bounces-79432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I8VEhloqGl3uQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:12:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55006204F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B72430074EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861537A4BD;
	Wed,  4 Mar 2026 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWZWn5uw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF8379EEC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644013; cv=none; b=gU5KkJpWVACN6VYvxKDOVyfRpMhKus9Q5H4pQCe5zA4m4Fq/KPJKBepPTQRXRvbPrSgL7N/1xOLFyeegswle8K9c3AcOaQ7T0/aLxad8Ax4NuGRN4PVG9iWDsOHMsEMhGnDVPGyyybGLfHOc8yxP1i5evp0pyCLRBsJHZ/DQ8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644013; c=relaxed/simple;
	bh=L6pV2eFVyDUs5yCewzlSxnAA+mPZ6VLtibyuX0EKjc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJTtFSSq3xmcx/mK5L4Pux9NouOkmutg43bTFP8HQi9/SA7rofM5xVf9Qyg5qeljaQZer0OEGCiVE6fFiIovenhIhchN2687gdq5Yc4NQh6jnp13UDo1iGqAnKxjAR3znTx/CP9C2IHgJELvPZhHCLTvINjxLQ9gvCbWUbAUb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWZWn5uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4DDC4CEF7;
	Wed,  4 Mar 2026 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772644013;
	bh=L6pV2eFVyDUs5yCewzlSxnAA+mPZ6VLtibyuX0EKjc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWZWn5uwPN5MGqMNn6HRWs2ewzRvaKnTRfzWRyWYTYqQRWv9RBMZDnFy/xbQoxiXZ
	 FhFMVDpEV6bcSLskRQMLpuisZC+JaS0FU2fS9uItS7lS+LdWWph7frFR5YMFKIRiIz
	 tpwOdAGvi4Z/YgecXVtLgL6aoZKrYHpFFquK4vk+ZyMvYAS7MYOJYolM0t+Mwd22Vm
	 Os8Nr8+bgDjbEBOt83uoEZd3anNY+zPOFgzIEAcOSHQbrBfTw+EzTL3kxmkoT9Mm2E
	 mmt/Iml2Uukon/9fTnhDb+/ExtVevl1bVfV+D47gveA4Zyx9OcsyPRFCwLf8IHyRVk
	 q9T7lme63KOFQ==
Date: Wed, 4 Mar 2026 09:06:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260304170652.GP13829@frogsfrogsfrogs>
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
X-Rspamd-Queue-Id: 55006204F47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79432-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meson.build:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/4/26 01:11, Darrick J. Wong wrote:
> > Hi Bernd,
> > 
> > Please pull this branch with changes for libfuse.
> > 
> > As usual, I did a test-merge with the main upstream branch as of a few
> > minutes ago, and didn't see any conflicts.  Please let me know if you
> > encounter any problems.
> 
> Hi Darrick,
> 
> quite some problems actually ;)
> 
> https://github.com/libfuse/libfuse/pull/1444
> 
> Basically everything fails.  Build test with

Doh :(

> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
> fatal error: 'systemd/sd-daemon.h' file not found
>    24 | #include <systemd/sd-daemon.h>
> 
> 
> Two issues here:
> a) meson is not testing for sd-daemon.h?

Hrm.  meson.build *should* have this clause to detect systemd:

# Check for systemd support
systemd_system_unit_dir = get_option('systemdsystemunitdir')
if systemd_system_unit_dir == ''
  systemd = dependency('systemd', required: false)
  if systemd.found()
     systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
  endif
endif

if systemd_system_unit_dir == ''
  warning('could not determine systemdsystemunitdir, systemd stuff will not be installed')
else
  private_cfg.set_quoted('SYSTEMD_SYSTEM_UNIT_DIR', systemd_system_unit_dir)
  private_cfg.set('HAVE_SYSTEMD', true)
endif

# Check for libc SCM_RIGHTS support (aka Linux)
code = '''
#include <sys/socket.h>
int main(void) {
    int moo = SCM_RIGHTS;
    return moo;
}'''
if cc.links(code, name: 'libc SCM_RIGHTS support')
  private_cfg.set('HAVE_SCM_RIGHTS', true)
endif

if private_cfg.get('HAVE_SCM_RIGHTS', false) and private_cfg.get('HAVE_SYSTEMD', false)
  private_cfg.set('HAVE_SERVICEMOUNT', true)
endif


But apparently it built fuse_service.c anyway?  I'll have to look deeper
into what github ci did, since the pkgconfig fil... oh crikey.

systemd-dev contains the systemd.pc file, so the systemd.get_variable
call succeeds and returns a path, thereby enabling the build.  However,
the header files are in libsystemd-dev, and neither package depends on
the other.

So I clearly need to test for the presence of sd-daemon.h in that first
clause that determines if HAVE_SYSTEMD gets set.

> a.1) If not available needs to disable that service? Because I don't
> think BSD has support for systemd.

<nod>

> b) .github/workflow/*.yml files need to be adjusted to add in the new
> dependency.

Oh, ok.  The 'apt install' lines should probably add in systemd-dev.

> Please also have a look at checkpatch (which is a plain linux copy) and
> the spelling test failures.

Ok, will do.

--D

> 
> 
> Thanks,
> Bernd
> 
> 

