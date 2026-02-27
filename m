Return-Path: <linux-fsdevel+bounces-78685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAwVMUZMoWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:48:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8A1B4162
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23E413064937
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172433B6C5;
	Fri, 27 Feb 2026 07:48:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67528150F;
	Fri, 27 Feb 2026 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178496; cv=none; b=lSPUyI4Z2KnVqlZfqueVSNFxvJzUI/0kMtv8YYim0WU6SjWT7ayVlQv/3B3q/xrQ+8NuCBkZ+27+NDxzozPjZS2Y6NMPFBe8huvIcPKW2dU/rbfH+9TNL+S8jCkIbrZIxKki0txiJTlSR0bLJosl6uuXqsl79qI77eQQTpA/p5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178496; c=relaxed/simple;
	bh=QiIibAVxS1HtSHXNlSEgrebtr9i2FOO56gK4AV5TB/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdmnSs1315OGSlC9iPGg9DJlnRX4/zh8vAeV9UgrRIOFFtzQA8huk78yP+lNRVOIdyGqmT0a6+sgFiJTK0vYR2AW+tarCtlMyUzfQkMkpyX5sMJ5U9HCIFOjcWKQYg664eeR49YeACkYKgc9XJWAkA8T4e0UDrbo4lLsNeyO+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 84C17E064D;
	Fri, 27 Feb 2026 08:48:05 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 27 Feb 2026 08:48:04 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
Message-ID: <aaFJEeeeDrdqSEX9@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78685-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44D8A1B4162
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> On Thu, Feb 26, 2026 at 8:43 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > The discussion about compound commands in fuse was
> > started over an argument to add a new operation that
> > will open a file and return its attributes in the same operation.
> >
> > Here is a demonstration of that use case with compound commands.
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> >  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
> >  fs/fuse/fuse_i.h |   4 +-
> >  fs/fuse/ioctl.c  |   2 +-
> >  3 files changed, 99 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241bdf727e00a2bc714f35 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -136,8 +136,71 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
> >         }
> >  }
> >
> > +static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
> > +                                     struct inode *inode, int flags, int opcode,
> > +                                     struct fuse_file *ff,
> > +                                     struct fuse_attr_out *outattrp,
> > +                                     struct fuse_open_out *outopenp)
> > +{
> > +       struct fuse_conn *fc = fm->fc;
> > +       struct fuse_compound_req *compound;
> > +       struct fuse_args open_args = {};
> > +       struct fuse_args getattr_args = {};
> > +       struct fuse_open_in open_in = {};
> > +       struct fuse_getattr_in getattr_in = {};
> > +       int err;
> > +
> > +       compound = fuse_compound_alloc(fm, 2, FUSE_COMPOUND_SEPARABLE);
> > +       if (!compound)
> > +               return -ENOMEM;
> > +
> > +       open_in.flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> > +       if (!fm->fc->atomic_o_trunc)
> > +               open_in.flags &= ~O_TRUNC;
> > +
> > +       if (fm->fc->handle_killpriv_v2 &&
> > +           (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
> > +               open_in.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> 
> Do you think it makes sense to move this chunk of logic into
> fuse_open_args_fill() since this logic has to be done in
> fuse_send_open() as well?
>

Yes, I think that makes sense and would be beneficial to other requests in 
other compounds that will be constructed with that function.

> > +
> > +       fuse_open_args_fill(&open_args, nodeid, opcode, &open_in, outopenp);
> > +
> > +       err = fuse_compound_add(compound, &open_args, NULL);
> > +       if (err)
> > +               goto out;
> > +
> > +       fuse_getattr_args_fill(&getattr_args, nodeid, &getattr_in, outattrp);
> > +
> > +       err = fuse_compound_add(compound, &getattr_args, NULL);
> > +       if (err)
> > +               goto out;
> > +
> > +       err = fuse_compound_send(compound);
> > +       if (err)
> > +               goto out;
> > +
> > +       err = fuse_compound_get_error(compound, 0);
> > +       if (err)
> > +               goto out;
> > +
> > +       ff->fh = outopenp->fh;
> > +       ff->open_flags = outopenp->open_flags;
> 
> It looks like this logic is shared between here and the non-compound
> open path, maybe a bit better to just do this in fuse_file_open()
> instead? That way we also don't need to pass the struct fuse_file *ff
> as an arg either.
> 

Will do that.

> > +
> > +       err = fuse_compound_get_error(compound, 1);
> > +       if (err)
> > +               goto out;
> 
> For this open+getattr case, if getattr fails but the open succeeds,
> should this still succeed the open since they're separable requests? I
> think we had a conversation about it in v4, but imo this case should.
> 
You are right, we had the conversation and other people joined, so I
changed this code but to something else. Sorry about that.

I think your idea will work, since the behavior then is exactly what happens
at the moment with exactly the same drawback.

> > +
> > +       fuse_change_attributes(inode, &outattrp->attr, NULL,
> > +                              ATTR_TIMEOUT(outattrp),
> > +                              fuse_get_attr_version(fc));
> > +
> > +out:
> > +       fuse_compound_free(compound);
> > +       return err;
> > +}
> > +
> >  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> > -                                unsigned int open_flags, bool isdir)
> > +                               struct inode *inode,
> 
> As I understand it, now every open() is a opengetattr() (except for
> the ioctl path) but is this the desired behavior? for example if there
> was a previous FUSE_LOOKUP that was just done, doesn't this mean
> there's no getattr that's needed since the lookup refreshed the attrs?
> or if the server has reasonable entry_valid and attr_valid timeouts,
> multiple opens() of the same file would only need to send FUSE_OPEN
> and not the FUSE_GETATTR, no?

So your concern is, that we send too many requests?
If the fuse server implwments the compound that is not the case.

> 
> 
> > +                               unsigned int open_flags, bool isdir)
> >  {
> >         struct fuse_conn *fc = fm->fc;
> >         struct fuse_file *ff;
> > @@ -163,23 +226,40 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> >         if (open) {
> >                 /* Store outarg for fuse_finish_open() */
> >                 struct fuse_open_out *outargp = &ff->args->open_outarg;
> > -               int err;
> > +               int err = -ENOSYS;
> >
> > -               err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
> > -               if (!err) {
> > -                       ff->fh = outargp->fh;
> > -                       ff->open_flags = outargp->open_flags;
> > -               } else if (err != -ENOSYS) {
> > -                       fuse_file_free(ff);
> > -                       return ERR_PTR(err);
> > -               } else {
> > -                       if (isdir) {
> > +               if (inode) {
> > +                       struct fuse_attr_out attr_outarg;
> > +
> > +                       err = fuse_compound_open_getattr(fm, nodeid, inode,
> > +                                                        open_flags, opcode, ff,
> > +                                                        &attr_outarg, outargp);
> 
> instead of passing in &attr_outarg, what about just having that moved
> to fuse_compound_open_getattr()?
> 

This is a victim of 'code move' already.
I had the code to handle the outarg here before and did not change the functions
signature, which now looks stupid.

> > +               }
> > +
> > +               if (err == -ENOSYS) {
> > +                       err = fuse_send_open(fm, nodeid, open_flags, opcode,
> > +                                            outargp);
> > +                       if (!err) {
> > +                               ff->fh = outargp->fh;
> > +                               ff->open_flags = outargp->open_flags;
> > +                       }
> > +               }
> > +
> > +               if (err) {
> > +                       if (err != -ENOSYS) {
> > +                               /* err is not ENOSYS */
> > +                               fuse_file_free(ff);
> > +                               return ERR_PTR(err);
> > +                       } else {
> >                                 /* No release needed */
> >                                 kfree(ff->args);
> >                                 ff->args = NULL;
> > -                               fc->no_opendir = 1;
> > -                       } else {
> > -                               fc->no_open = 1;
> > +
> > +                               /* we don't have open */
> > +                               if (isdir)
> > +                                       fc->no_opendir = 1;
> > +                               else
> > +                                       fc->no_open = 1;
> 
> kfree(ff->args) and ff->args = NULL should not be called for the
> !isdir case or it leads to the deadlock that was fixed in
> https://lore.kernel.org/linux-fsdevel/20251010220738.3674538-2-joannelkoong@gmail.com/
> 
> I think if you have the "ff->fh = outargp..." and "ff->open_flags =
> ..." logic shared between fuse_compound_open_getattr() and
> fuse_send_open() then the original errorr handling for this could just
> be left as-is.

Very good argument to share the error handling then ...

> 
> Thanks,
> Joanne
> 

Thanks for taking the time,
Horst


