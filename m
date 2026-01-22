Return-Path: <linux-fsdevel+bounces-74948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFDBKg5ycWkPHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:40:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 692045FFCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1419D4F60EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92692FF646;
	Thu, 22 Jan 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4vIhkbw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA492F49FD;
	Thu, 22 Jan 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769042428; cv=none; b=k9OL7QQjPm2rSFilMhY6HBrl3Zq7RYk/tC5VnvQP93TYEtY65bw/07IwYvFX44wejoJ7fHmZqYrajsIYoJbMHkH5lu4N1I9UT2mXNKzvNxsf6EqK5dawamq5Ut/nV1q+9Z1wVp2nOUl2oKmpARi8EnZmU98FRaGdHZnIFhrZLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769042428; c=relaxed/simple;
	bh=wL2tzw4xmEyxKZgDlMMG2UqCQj1lK0Mdm3KHjA3w0Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvA7lweuj14BxMmMFtzg/mIxLarOqguCovm0iAHIq8j72UYERdSMooovb/OcyFIkRSunyNn2ynPHn8RTRSDT5NCEgaeZOTs/vXGqAzEGeFbUDU3XisOTDYJJf5acU7n7DjO4XqD3IsWWBYL47fnAePiMpBCDovGBzwt/AC3HzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4vIhkbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FFAC4CEF1;
	Thu, 22 Jan 2026 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769042427;
	bh=wL2tzw4xmEyxKZgDlMMG2UqCQj1lK0Mdm3KHjA3w0Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4vIhkbwpTf/ZeEuryuSSvhp0hiWyBoyWNAINRKUCuzYb30ErM1HIk1qzYwUvNzP2
	 S38gvAAd8j2OetF2NdW8r8pV4u3F0HuXkLGjGnos4k87Rjfhdsi+kj+DxZQkH4sC0C
	 4/quqzH4DkFbBI+YnsiD1pcLGZaZSCbuEyJIZGGRMghZL7yhUuerRqwQTi+D3nhwSQ
	 2Eq8j9SMyIypMBC0xw6GhJJw3IGfPlfo4Q6eYwETk5ndUp/A8IFMfrz7ym9C/XA4oh
	 14H0vnneF1b0snYxvGWATA2S48WAuUpHCww+hccbsJ0LTJSNPNcf/U1ZM5C5dGLLBo
	 vZwk09couui1Q==
Date: Wed, 21 Jan 2026 16:40:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/31] fuse: make debugging configurable at runtime
Message-ID: <20260122004027.GM5966@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810415.1424854.10373764649459618752.stgit@frogsfrogsfrogs>
 <CAJnrk1ZUbuAER90xbagWnBZ9dWKkdUAqVRa1vmZ5BtL_o=TnnA@mail.gmail.com>
 <20260122000227.GK5966@frogsfrogsfrogs>
 <CAJnrk1Z_M4XP7dApmuLA9Na+7+9OO0he9EcaZJrubTrHKKUk8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z_M4XP7dApmuLA9Na+7+9OO0he9EcaZJrubTrHKKUk8w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74948-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 692045FFCA
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:23:08PM -0800, Joanne Koong wrote:
> On Wed, Jan 21, 2026 at 4:02 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 21, 2026 at 03:42:04PM -0800, Joanne Koong wrote:
> > > On Tue, Oct 28, 2025 at 5:45 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Use static keys so that we can configure debugging assertions and dmesg
> > > > warnings at runtime.  By default this is turned off so the cost is
> > > > merely scanning a nop sled.  However, fuse server developers can turn
> > > > it on for their debugging systems.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/fuse_i.h     |    8 +++++
> > > >  fs/fuse/iomap_i.h    |   16 ++++++++--
> > > >  fs/fuse/Kconfig      |   15 +++++++++
> > > >  fs/fuse/file_iomap.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  fs/fuse/inode.c      |    7 ++++
> > > >  5 files changed, 124 insertions(+), 3 deletions(-)
> > > >
> > > >
> > > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > > index a88f5d8d2bce15..b6fc70068c5542 100644
> > > > --- a/fs/fuse/file_iomap.c
> > > > +++ b/fs/fuse/file_iomap.c
> > > > @@ -8,6 +8,12 @@
> > > >  #include "fuse_trace.h"
> > > >  #include "iomap_i.h"
> > > >
> > > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
> > > > +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> > > > +#else
> > > > +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> > > > +#endif
> > > > +
> > > >  static bool __read_mostly enable_iomap =
> > > >  #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
> > > >         true;
> > > > @@ -17,6 +23,81 @@ static bool __read_mostly enable_iomap =
> > > >  module_param(enable_iomap, bool, 0644);
> > > >  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> > > >
> > > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> > > > +static struct kobject *iomap_kobj;
> > > > +
> > > > +static ssize_t fuse_iomap_debug_show(struct kobject *kobject,
> > > > +                                    struct kobj_attribute *a, char *buf)
> > > > +{
> > > > +       return sysfs_emit(buf, "%d\n", !!static_key_enabled(&fuse_iomap_debug));
> > > > +}
> > > > +
> > > > +static ssize_t fuse_iomap_debug_store(struct kobject *kobject,
> > > > +                                     struct kobj_attribute *a,
> > > > +                                     const char *buf, size_t count)
> > > > +{
> > > > +       int ret;
> > > > +       int val;
> > > > +
> > > > +       ret = kstrtoint(buf, 0, &val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       if (val < 0 || val > 1)
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (val)
> > > > +               static_branch_enable(&fuse_iomap_debug);
> > > > +       else
> > > > +               static_branch_disable(&fuse_iomap_debug);
> > > > +
> > > > +       return count;
> > > > +}
> > > > +
> > > > +#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)                  \
> > > > +{                                                                      \
> > > > +       .attr   = { .name = __stringify(_name), .mode = _mode },        \
> > > > +       .show   = _show,                                                \
> > > > +       .store  = _store,                                               \
> > > > +}
> > > > +
> > > > +#define FUSE_ATTR_RW(_name, _show, _store)                     \
> > > > +       static struct kobj_attribute fuse_attr_##_name =        \
> > > > +                       __INIT_KOBJ_ATTR(_name, 0644, _show, _store)
> > > > +
> > > > +#define FUSE_ATTR_PTR(_name)                                   \
> > > > +       (&fuse_attr_##_name.attr)
> > > > +
> > > > +FUSE_ATTR_RW(debug, fuse_iomap_debug_show, fuse_iomap_debug_store);
> > > > +
> > > > +static const struct attribute *fuse_iomap_attrs[] = {
> > > > +       FUSE_ATTR_PTR(debug),
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +int fuse_iomap_sysfs_init(struct kobject *fuse_kobj)
> > > > +{
> > > > +       int error;
> > > > +
> > > > +       iomap_kobj = kobject_create_and_add("iomap", fuse_kobj);
> > > > +       if (!iomap_kobj)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       error = sysfs_create_files(iomap_kobj, fuse_iomap_attrs);
> > > > +       if (error) {
> > > > +               kobject_put(iomap_kobj);
> > > > +               return error;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
> > > > +{
> > >
> > > Is sysfs_remove_files() also needed here?
> >
> > kobject_put is supposed to tear down the attrs that sysfs_create_files
> > attaches to iomap_kobj.  Though you're right to be suspicious -- there
> > are a lot of places that explicitly call sysfs_remove_files to undo
> > sysfs_create_files; and also a lot of places that just let kobject_put
> > do the dirty work.
> 
> Makes sense, thanks for the context.
> >
> > > > +       kobject_put(iomap_kobj);
> > > > +}
> > > > +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> > > > +
> > > >  bool fuse_iomap_enabled(void)
> > > >  {
> > > >         /* Don't let anyone touch iomap until the end of the patchset. */
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 1eea8dc6e723c6..eec711302a4a13 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -2277,8 +2277,14 @@ static int fuse_sysfs_init(void)
> > > >         if (err)
> > > >                 goto out_fuse_unregister;
> > > >
> > > > +       err = fuse_iomap_sysfs_init(fuse_kobj);
> > > > +       if (err)
> > > > +               goto out_fuse_connections;
> > > > +
> > > >         return 0;
> > > >
> > > > + out_fuse_connections:
> > > > +       sysfs_remove_mount_point(fuse_kobj, "connections");
> > > >   out_fuse_unregister:
> > > >         kobject_put(fuse_kobj);
> > > >   out_err:
> > > > @@ -2287,6 +2293,7 @@ static int fuse_sysfs_init(void)
> > > >
> > > >  static void fuse_sysfs_cleanup(void)
> > > >  {
> > > > +       fuse_iomap_sysfs_cleanup(fuse_kobj);
> > > >         sysfs_remove_mount_point(fuse_kobj, "connections");
> > > >         kobject_put(fuse_kobj);
> > > >  }
> > > >
> > > Could you explain why it's better that this goes through sysfs than
> > > through a module param?
> >
> > You can dynamically enable debugging on a production system.  I (by
> > which I really mean the support org) wishes they could do that with XFS.
> >
> > Module parameters don't come with setter functions so you can't call
> > static_branch_{enable,disable} when the parameter value updates.
> >
> 
> Ohh I thought the "module_param_cb()" stuff does let you do that and
> can be dynamically enabled/disabled as well? I mostly ask because it
> feels like it'd be nicer from a user POV if all the config stuff (eg
> enable uring, enable iomap, etc.) is in one place.

TIL today.

HAH well that's been there since 2.6.0.  Silly me, that's been there
forever.

I'll switch it to a magic module parameter that has a setter.  Much
easier than thinking about /anything/ related to sysfs.

--D

> Thanks,
> Joanne
> 
> > --D
> >
> > > Thanks,
> > > Joanne

