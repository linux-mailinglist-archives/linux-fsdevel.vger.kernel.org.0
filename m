Return-Path: <linux-fsdevel+bounces-79439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNzREFafqGmZwAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 22:08:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E1207D37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1F93303FFD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F898372EE9;
	Wed,  4 Mar 2026 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXG1zTL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CE222585
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658503; cv=none; b=Z4IFsR3FNc5ACKWjVC2Win1+ET9sVUmjK1Znb3HCclcFw0ku7GjGx3R84xnAVZeDTxADhdA2oqk68mnD8zu0Hmd6staAhill/Zksx60MMT3VXBOwORVDElFh9dt5KsvK4LQ2iaTvtP9l9PvHUpA+dxFbplkJQlNitgHIaJ5N8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658503; c=relaxed/simple;
	bh=wg7R4/UR78caQfsIgFzc5GgvL2oN0Ns+js7fnZOlBOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6ZmULbQK1ylVxMvXJh2ZTrSSDrTBwQG9KUxogEMex/4ullIgu+gCl4o91J7KY/mCTsw9S/SuYlbfvREQXHJeiIiggq1HTXKxrZvDA5tnr3BAR0/Z0LQMAk2oU+dFr0WFCQLkDTTfNUFoR3CkzHIyjZQ3h2erOVklibLh0HS+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXG1zTL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BDDC4CEF7;
	Wed,  4 Mar 2026 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772658503;
	bh=wg7R4/UR78caQfsIgFzc5GgvL2oN0Ns+js7fnZOlBOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXG1zTL5ZEVfBrd5Uz3PDr4kw/y/YnUkDq64guULTorI97V1bvu0LNpLuM97sQSyZ
	 HmFI6BdN7q7cJlWnvgaeX3Z0RLhQdItoEWh0026S3KObWvEfgP8o06X8t2qlJLys+Z
	 DsxwQP7JMgbjFwOsTlDo1OmFJtBd1k9pTk4INZYxrOGRK4ZL58oghygz5WHHc8NlHD
	 IR8aCSKTvhcfTgfpSvvAXZKTvYIBpkUblnS+JLSi3s9xGgt1hVTFzxThFGWZC9F2px
	 qjluMNzcbnOxhUn8ErBQPuYjKZhg3C8XHpFDjo4zvlzHRAbiIHZrRWnNOvobbYeKSI
	 TCF1mMChGBEGw==
Date: Wed, 4 Mar 2026 13:08:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260304210822.GR13829@frogsfrogsfrogs>
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
 <20260304170652.GP13829@frogsfrogsfrogs>
 <20260304180602.GQ13829@frogsfrogsfrogs>
 <ee584989-d81d-4dea-b953-6acf44d76d13@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee584989-d81d-4dea-b953-6acf44d76d13@bsbernd.com>
X-Rspamd-Queue-Id: 9B1E1207D37
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
	TAGGED_FROM(0.00)[bounces-79439-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:29:35PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/4/26 19:06, Darrick J. Wong wrote:
> > On Wed, Mar 04, 2026 at 09:06:52AM -0800, Darrick J. Wong wrote:
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
> >>
> >> Doh :(
> >>
> >>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
> >>> fatal error: 'systemd/sd-daemon.h' file not found
> >>>    24 | #include <systemd/sd-daemon.h>
> >>>
> >>>
> >>> Two issues here:
> >>> a) meson is not testing for sd-daemon.h?
> >>
> >> Hrm.  meson.build *should* have this clause to detect systemd:
> >>
> >> # Check for systemd support
> >> systemd_system_unit_dir = get_option('systemdsystemunitdir')
> >> if systemd_system_unit_dir == ''
> >>   systemd = dependency('systemd', required: false)
> >>   if systemd.found()
> >>      systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
> >>   endif
> >> endif
> >>
> >> if systemd_system_unit_dir == ''
> >>   warning('could not determine systemdsystemunitdir, systemd stuff will not be installed')
> >> else
> >>   private_cfg.set_quoted('SYSTEMD_SYSTEM_UNIT_DIR', systemd_system_unit_dir)
> >>   private_cfg.set('HAVE_SYSTEMD', true)
> >> endif
> >>
> >> # Check for libc SCM_RIGHTS support (aka Linux)
> >> code = '''
> >> #include <sys/socket.h>
> >> int main(void) {
> >>     int moo = SCM_RIGHTS;
> >>     return moo;
> >> }'''
> >> if cc.links(code, name: 'libc SCM_RIGHTS support')
> >>   private_cfg.set('HAVE_SCM_RIGHTS', true)
> >> endif
> >>
> >> if private_cfg.get('HAVE_SCM_RIGHTS', false) and private_cfg.get('HAVE_SYSTEMD', false)
> >>   private_cfg.set('HAVE_SERVICEMOUNT', true)
> >> endif
> >>
> >>
> >> But apparently it built fuse_service.c anyway?  I'll have to look deeper
> >> into what github ci did, since the pkgconfig fil... oh crikey.
> >>
> >> systemd-dev contains the systemd.pc file, so the systemd.get_variable
> >> call succeeds and returns a path, thereby enabling the build.  However,
> >> the header files are in libsystemd-dev, and neither package depends on
> >> the other.
> >>
> >> So I clearly need to test for the presence of sd-daemon.h in that first
> >> clause that determines if HAVE_SYSTEMD gets set.
> 
> Or link test for systemd

<nod> Hilariously we only need a single #define out of that header file:
SD_LISTEN_FDS_START

> >>
> >>> a.1) If not available needs to disable that service? Because I don't
> >>> think BSD has support for systemd.
> >>
> >> <nod>
> >>
> >>> b) .github/workflow/*.yml files need to be adjusted to add in the new
> >>> dependency.
> >>
> >> Oh, ok.  The 'apt install' lines should probably add in systemd-dev.
> >>
> >>> Please also have a look at checkpatch (which is a plain linux copy) and
> >>> the spelling test failures.
> >>
> >> Ok, will do.
> > 
> > ...and the immediate problem that I run into is that all the logs are
> > hidden behind a login wall so I cannot read them. :(
> > 
> > (It leaked enough about the spelling errors that I can fix those, and
> > I can run checkpatch locally, but I don't know what else went wrong with
> > the bsd build or the abi check.)
> > 
> 
> 
> BSD errors are actually a bit tricky, because it runs them in a VM, one has
> to look at "raw logs". I think ABI checks are failling as the normal build
> test because of the meson issue.
> BSD is this
> 
> 2026-03-04T13:17:20.5979965Z [14/82] cc -Ilib/libfuse3.so.3.19.0.p -Ilib -I../lib -Iinclude -I../include -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/usr/local/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -c ../lib/fuse_service_stub.c
> 2026-03-04T13:17:20.6004021Z FAILED: [code=1] lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o 
> 2026-03-04T13:17:20.6008119Z cc -Ilib/libfuse3.so.3.19.0.p -Ilib -I../lib -Iinclude -I../include -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/usr/local/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -c ../lib/fuse_service_stub.c
> 2026-03-04T13:17:20.6012011Z In file included from ../lib/fuse_service_stub.c:21:
> 2026-03-04T13:17:20.6013206Z ../include/fuse_service_priv.h:12:2: error: unknown type name '__be32'
> 2026-03-04T13:17:20.6013899Z    12 |         __be32 pos;
> 2026-03-04T13:17:20.6014268Z       |         ^
> 2026-03-04T13:17:20.6014789Z ../include/fuse_service_priv.h:13:2: error: unknown type name '__be32'
> 2026-03-04T13:17:20.6015421Z    13 |         __be32 len;
> 2026-03-04T13:17:20.6015779Z       |         ^
> 2026-03-04T13:17:20.6016510Z ../include/fuse_service_priv.h:17:2: error: unknown type name '__be32'
> 2026-03-04T13:17:20.6017130Z    17 |         __be32 magic;
> 2026-03-04T13:17:20.6017506Z       |         ^
> 2026-03-04T13:17:20.6018004Z ../include/fuse_service_priv.h:18:2: error: unknown type name '__be32'
> 2026-03-04T13:17:20.6018615Z    18 |         __be32 argc;
> 2026-03-04T13:17:20.6018988Z       |         ^

Hrmm, well at least on BSD I see that it's building the service stub,
which means that it didn't actually try to build any of the real systemd
service stuff at all.  I think this is due to fuse_service_stub.c
including fuse_service_priv.h unnecessarily.

--D

> 
> 
> Cheers,
> Bernd
> 

