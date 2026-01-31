Return-Path: <linux-fsdevel+bounces-75977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB8UIsJPfWnERQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:41:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F0ABFACB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6A9A300A266
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BA3033FC;
	Sat, 31 Jan 2026 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMsEdPnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295A30148B;
	Sat, 31 Jan 2026 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769820083; cv=none; b=IA3cLipRk+Fcu8KNcNl08eC5lfbFcdgby9yQyvSm/+PvfsPgVs+ThHG+dQ7UI8IVF5gmGPfZA8cjdEWNHxKahEDGOAug8C84DzY/UxYiAA3IzM0fYnJwLUPzGwWpSownH34WUvegtqTpWNi72X7TrcsfM1MZnIPgqwiy7PORD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769820083; c=relaxed/simple;
	bh=l9n3mLPGeUos34mQWVNVH+sXbJpO8kREK6u0HCyRDH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMFDwndD8uTwhsIP825L2ifXAQVpF2gt8g4uLDVsQIFcJGgBUE5GRh8KZUUK7Yh9k5sxhmx9yCJygW8tfCLnffdZ2tubo+CxJLKR0gGsaykhGF8z4zND689wxqNrkQVSX/ImSgFoME+zjOuD1xleFtmU/nhmID+lzh8Bemc1xEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMsEdPnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98317C4CEF7;
	Sat, 31 Jan 2026 00:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769820080;
	bh=l9n3mLPGeUos34mQWVNVH+sXbJpO8kREK6u0HCyRDH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMsEdPnphkANsAifUMsiluDLCuBvGpxyU9AkKFfAhE5w7P+4XiRBIGwLGCcG7vifN
	 0e5p5LSgUKdB09L0ZyZhZChMFIzkCf00rqD59kagFHbfCn7wkTc52LAGUyeLSJGWBA
	 yb4Ai5GXz21SJx8SZUJMKZ3ZzoB3S9OlVTLS1R10L76gz/7wOfQToSe1gSAta7OOf5
	 WLAe+9fQctgmRaFwIgr93AITzPyS48CtiZw/r9Lzc6c3ipNrkft3YxD7STpkxA6pim
	 QtWzkdJU5Opa6KH72Xryi4R8MZHvoI52TB8z0UnAKk5ts5h73CFk1W1Vd+H6RFlE+K
	 f6BUC/CZP/9cA==
Date: Fri, 30 Jan 2026 16:41:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>,
	John Groves <jgroves@fastmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
Message-ID: <20260131004119.GA104658@frogsfrogsfrogs>
References: <20260118223516.92753-1-john@jagalactic.com>
 <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
 <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
 <CAJnrk1Z9BuCLZv576Ro9iYUPRDpW=1euG0rQ2wC_19sBcR18pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z9BuCLZv576Ro9iYUPRDpW=1euG0rQ2wC_19sBcR18pw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75977-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[jagalactic.com,groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,jagalactic.com:email]
X-Rspamd-Queue-Id: A6F0ABFACB
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 02:53:13PM -0800, Joanne Koong wrote:
> On Sun, Jan 18, 2026 at 2:35 PM John Groves <john@jagalactic.com> wrote:
> >
> > From: John Groves <john@groves.net>
> >
> > This is copied from include/uapi/linux/fuse.h in 6.19 with no changes.
> >
> > Signed-off-by: John Groves <john@groves.net>
> 
> This LGTM. We could probably just merge this in already.
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
> > ---
> >  include/fuse_kernel.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> > index 94621f6..c13e1f9 100644
> > --- a/include/fuse_kernel.h
> > +++ b/include/fuse_kernel.h
> > @@ -239,6 +239,7 @@
> >   *  7.45
> >   *  - add FUSE_COPY_FILE_RANGE_64
> >   *  - add struct fuse_copy_file_range_out
> > + *  - add FUSE_NOTIFY_PRUNE
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -680,7 +681,7 @@ enum fuse_notify_code {
> >         FUSE_NOTIFY_DELETE = 6,
> >         FUSE_NOTIFY_RESEND = 7,
> >         FUSE_NOTIFY_INC_EPOCH = 8,
> > -       FUSE_NOTIFY_CODE_MAX,
> > +       FUSE_NOTIFY_PRUNE = 9,

This insertion ought to preserve FUSE_NOTIFY_CODE_MAX, right?

--D

> >  };
> >
> >  /* The read buffer is required to be at least 8k, but may be much larger */
> > @@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
> >         uint64_t        dummy4;
> >  };
> >
> > +struct fuse_notify_prune_out {
> > +       uint32_t        count;
> > +       uint32_t        padding;
> > +       uint64_t        spare;
> > +};
> > +
> >  struct fuse_backing_map {
> >         int32_t         fd;
> >         uint32_t        flags;
> > @@ -1131,6 +1138,7 @@ struct fuse_backing_map {
> >  #define FUSE_DEV_IOC_BACKING_OPEN      _IOW(FUSE_DEV_IOC_MAGIC, 1, \
> >                                              struct fuse_backing_map)
> >  #define FUSE_DEV_IOC_BACKING_CLOSE     _IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
> > +#define FUSE_DEV_IOC_SYNC_INIT         _IO(FUSE_DEV_IOC_MAGIC, 3)
> >
> >  struct fuse_lseek_in {
> >         uint64_t        fh;
> > --
> > 2.52.0
> >

