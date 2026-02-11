Return-Path: <linux-fsdevel+bounces-76958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFKxOGaxjGkvsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:42:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69D126430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A9D03013248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB91343D91;
	Wed, 11 Feb 2026 16:41:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96133341AA0;
	Wed, 11 Feb 2026 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828116; cv=none; b=eTNAo+4d1/2IrC/Rd9/uQN84XYeceh6UBdPeZyrK5imY/4D/OaU+T/eI74vL4tL9TGlkhIKMCEfQUbVKnqcQN/twHk8QfyIahwBwXbTmIrc4MVpmcRXSNXjf0r+IBcldSXZNPrwEeAqJjg3VradPjTGl1Z60Yv24SsyaPCVGS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828116; c=relaxed/simple;
	bh=83qyWAlFI7Ts9KO5CRGbWlwBIEcbatrnb4b0Z6ARcNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJYeGSDHYXn5d8nkRfskxQRm6D86mjoutZNHRxuSj8L7fduTycK7872MH0ZJlK89pwp5N5wwDGU09yn3nPeqFNIRP5/KzZ8/avK3raKCnS0TC28ScDd1RX3CMNL5+gipQpwITKZUOLj1j/mJ8F4bfvSuDSMEwPU+AbA1h6Zkk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 3F491E060A;
	Wed, 11 Feb 2026 17:35:45 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 11 Feb 2026 17:35:44 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aYysaoP0y4_j9erG@fedora-2.fritz.box>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76958-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedora-2.fritz.box:mid,birthelmer.com:email]
X-Rspamd-Queue-Id: 4D69D126430
X-Rspamd-Action: no action

Hi Miklos,

thanks for taking the time to look at this!

On Wed, Feb 11, 2026 at 05:13:21PM +0100, Miklos Szeredi wrote:
> On Tue, 10 Feb 2026 at 09:46, Horst Birthelmer <horst@birthelmer.com> wrote:
> 
> > +static char *fuse_compound_build_one_op(struct fuse_conn *fc,
> > +                                        struct fuse_args *op_args,
> > +                                        char *buffer_pos)
> > +{
> > +       struct fuse_in_header *hdr;
> > +       size_t needed_size = sizeof(struct fuse_in_header);
> > +       int j;
> > +
> > +       for (j = 0; j < op_args->in_numargs; j++)
> > +               needed_size += op_args->in_args[j].size;
> > +
> > +       hdr = (struct fuse_in_header *)buffer_pos;
> > +       memset(hdr, 0, sizeof(*hdr));
> > +       hdr->len = needed_size;
> > +       hdr->opcode = op_args->opcode;
> > +       hdr->nodeid = op_args->nodeid;
> 
> hdr->unique is notably missing.
> 
> I don't know.  Maybe just fill it with the index?

OK, will do. Since it was never used in libfuse, I didn't notice.

> 
> > +       hdr->uid = from_kuid(fc->user_ns, current_fsuid());
> > +       hdr->gid = from_kgid(fc->user_ns, current_fsgid());
> 
> uid/gid are not needed except for creation ops, and those need idmap
> to calculate the correct values.  I don't think we want to keep legacy
> behavior of always setting these.
> 
> > +       hdr->pid = pid_nr_ns(task_pid(current), fc->pid_ns);
> 
> This will be the same as the value in the compound header, so it's
> redundant.  That might not be bad, but I feel that we're better off
> setting this to zero and letting the userspace server fetch the pid
> value from the compound header if that's needed.
> 
> > +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */
> 
> Don't see a good reason to declare this in the API.   More sensible
> would be to negotiate a max_request_size during INIT.
> 

Wouldn't that make for a very complicated implementation of larger compounds.
If a fuse server negotiates something like 2?

> > +
> > +#define FUSE_COMPOUND_SEPARABLE (1<<0)
> > +#define FUSE_COMPOUND_ATOMIC (1<<1)
> 
> What is the meaning of these flags?

FUSE_COMPOUND_SEPARABLE is a hint for the fuse server that the requests are all
complete and there is no need to use the result of one request to complete the input
of another request further down the line.

Think of LOOKUP+MKNOD+OPEN ... that would never be 'separable'.

At the moment I use this flag to signal libfuse that it can decode the compund 
and execute sequencially completely in the lib and just call the separate requests
of the fuse server.

FUSE_COMPOUND_ATOMIC was an idea to hint to the fuse server that the kernel treats
the compound as one atomic request. This can maybe save us some checks for some
compounds.

> 
> > +
> > +/*
> > + * Compound request header
> > + *
> > + * This header is followed by the fuse requests
> > + */
> > +struct fuse_compound_in {
> > +       uint32_t        count;                  /* Number of operations */
> 
> This is redundant, as the sum of the sub-request lengths is equal to
> the compound request length, hence calculating the number of ops is
> trivial.
> 
> > +       uint32_t        flags;                  /* Compound flags */
> > +
> > +       /* Total size of all results.
> > +        * This is needed for preallocating the whole result for all
> > +        * commands in this compound.
> > +        */
> > +       uint32_t        result_size;
> 
> I don't understand why this is needed.  Preallocation by the userspace
> server?  Why is this different from a simple request?
> 

The reason is the implementation in libfuse.
It makes it a lot easier to know what the sum of the result buffers in the kernel is
and preallocate that in libfuse for compounds that will be decoded and handled in the
library.

> > +       uint64_t        reserved;
> > +};
> > +
> > +/*
> > + * Compound response header
> > + *
> > + * This header is followed by complete fuse responses
> > + */
> > +struct fuse_compound_out {
> > +       uint32_t        count;     /* Number of results */
> 
> Again, redundant.
> 
> Thanks,
> Miklos
> 


