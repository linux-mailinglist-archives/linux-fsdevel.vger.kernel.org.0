Return-Path: <linux-fsdevel+bounces-78704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EgjI6Z4oWnJtQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:57:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FDF1B6447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80027312F339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891E3E9F71;
	Fri, 27 Feb 2026 10:56:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4639526C;
	Fri, 27 Feb 2026 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189812; cv=none; b=rD0mP79ZuvMZNNjDTnVND7djYSpIyZFCeMiGbbfgmo+TYuiq2OjTfQ3yhGUuEtKbjgA937k8r66Ebac1XM6/SNOkN+mQq95sFss+oNtE8T0c7SrMrbfM7L8Tn97h3f4Dl59yiLHmnX2VSk2Cl6AnuF+mTgBKrL0FWer9HnM/0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189812; c=relaxed/simple;
	bh=Q+ema5qXtiT4848COynwofT9wMGJrGQwrYBJAJljcgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlK4KhXFYNbZ0oyRl4bPc5K4S0QUc3nXy/OBtxzU12ajH5r5UuIaArruMDtAIImRf46w6vB5K6lXx5ECDDcwRBh/LTcPo11yMhs0EbaRjX0o9bsfFjwxjQmxdbKxC2WChAAVx0+4QVGW/gxh+O2KqocSr+UOPzDIsvshsmJ6Wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 62CEEE0227;
	Fri, 27 Feb 2026 11:48:24 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 27 Feb 2026 11:48:23 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aaFyQX9ZI4KmqtFQ@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78704-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora.fritz.box:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.com:email]
X-Rspamd-Queue-Id: D9FDF1B6447
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:45:36AM +0100, Miklos Szeredi wrote:
> On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:
> 
> > +int fuse_compound_add(struct fuse_compound_req *compound,
> > +                       struct fuse_args *args,
> > +                       int (*converter)(struct fuse_compound_req *compound,
> > +                       unsigned int index))
> > +{
> > +       if (!compound || compound->count >= compound->max_count)
> > +               return -EINVAL;
> > +
> > +       if (args->in_pages)
> > +               return -EINVAL;
> 
> WARN_ON()
> 
> > +
> > +       compound->op_args[compound->count] = args;
> 
> This could be done *much* simpler with lists.  Just add a 'struct
> list_head list' member to struct fuse_args and pass a 'struct
> list_head *compound' to fuse_compound_add().  No need for
> fuse_compound_alloc/free().
> 
> Alternatively pass a 'void **' to fuse_compound_add(), where the input
> args could be copied directly. This has the advantage of not having to
> keep the args around, so they could be local to the fill function.
> After the request is done the responses would similarly be decoded
> into the outargs.
> 
> Both approaches have advantages and disadvantages, I don't see a clear winner.

Will have another go at this.

> > +       compound->op_converters[compound->count] = converter;
> 
> What are these converters?

This was my way of dealing with the interdependencies.
The automatic sequencialization will call this for every request.
So we can copy and manipulate the args for the next request.
No need for any other flags then. We can provide one or more
of this callback functions and be done.

> 
> > +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> > +{
> > +       struct fuse_conn *fc = compound->fm->fc;
> > +       struct fuse_args args = {
> > +               .opcode = FUSE_COMPOUND,
> > +               .in_numargs = 2,
> > +               .out_numargs = 2,
> > +               .out_argvar = true,
> > +       };
> > +       unsigned int req_count = compound->count;
> > +       size_t total_expected_out_size = 0;
> > +       size_t buffer_size = 0;
> > +       void *resp_payload_buffer;
> > +       char *buffer_pos;
> > +       void *buffer = NULL;
> > +       ssize_t ret;
> > +       unsigned int i, j;
> > +
> > +       for (i = 0; i < req_count; i++) {
> > +               struct fuse_args *op_args = compound->op_args[i];
> > +               size_t needed_size = sizeof(struct fuse_in_header);
> > +
> > +               for (j = 0; j < op_args->in_numargs; j++)
> > +                       needed_size += op_args->in_args[j].size;
> > +
> > +               buffer_size += needed_size;
> > +
> > +               for (j = 0; j < op_args->out_numargs; j++)
> > +                       total_expected_out_size += op_args->out_args[j].size;
> > +       }
> > +
> > +       buffer = kzalloc(buffer_size, GFP_KERNEL);
> > +       if (!buffer)
> > +               return -ENOMEM;
> > +
> > +       buffer_pos = buffer;
> > +       for (i = 0; i < req_count; i++) {
> > +               if (compound->op_converters[i]) {
> > +                       ret = compound->op_converters[i](compound, i);
> > +                       if (ret < 0)
> > +                               goto out_free_buffer;
> > +               }
> > +
> > +               buffer_pos = fuse_compound_build_one_op(fc,
> > +                                                       compound->op_args[i],
> > +                                                       buffer_pos, i);
> > +       }
> > +
> > +       compound->compound_header.result_size = total_expected_out_size;
> > +
> > +       args.in_args[0].size = sizeof(compound->compound_header);
> > +       args.in_args[0].value = &compound->compound_header;
> > +       args.in_args[1].size = buffer_size;
> > +       args.in_args[1].value = buffer;
> > +
> > +       buffer_size = total_expected_out_size +
> > +                     req_count * sizeof(struct fuse_out_header);
> > +
> > +       resp_payload_buffer = kzalloc(buffer_size, GFP_KERNEL);
> > +       if (!resp_payload_buffer) {
> > +               ret = -ENOMEM;
> > +               goto out_free_buffer;
> > +       }
> > +
> > +       args.out_args[0].size = sizeof(compound->result_header);
> > +       args.out_args[0].value = &compound->result_header;
> > +       args.out_args[1].size = buffer_size;
> > +       args.out_args[1].value = resp_payload_buffer;
> > +
> > +       ret = fuse_simple_request(compound->fm, &args);
> > +       if (ret < 0)
> > +               goto fallback_separate;
> > +
> > +       ret = fuse_handle_compound_results(compound, &args);
> > +       if (ret == 0)
> > +               goto out;
> > +
> > +fallback_separate:
> > +       /* Kernel tries to fallback to separate requests */
> > +       if (!(compound->compound_header.flags & FUSE_COMPOUND_ATOMIC))
> > +               ret = fuse_compound_fallback_separate(compound);
> > +
> > +out:
> > +       kfree(resp_payload_buffer);
> > +out_free_buffer:
> > +       kfree(buffer);
> > +       return ret;
> > +}
> 
> If we go with the list of fuse_args, then all the above logic could go
> into the lower layer (dev.c) which already handles fuse_args ->
> request -> fuse_args conversion.  What's needed is mostly just a loop
> that repeats this for all the sub requests.
> 
> 
> > +struct fuse_compound_req {
> > +       struct fuse_mount *fm;
> > +       struct fuse_compound_in compound_header;
> > +       struct fuse_compound_out result_header;
> > +
> > +       struct fuse_args **op_args;
> > +
> > +       /*
> > +        * Every op can add a converter function to construct the ops args from
> > +        * the already received responses.
> > +        */
> > +       int (**op_converters)(struct fuse_compound_req *compound,
> > +                             unsigned int index);
> > +       int *op_errors;
> 
> Can go into fuse_args.
> 
> > +
> > +       unsigned int max_count;
> > +       unsigned int count;
> > +};
> > +/*
> > + * This is a hint to the fuse server that all requests are complete and it can
> > + * use automatic decoding and sequential processing from libfuse.
> > + */
> > +#define FUSE_COMPOUND_SEPARABLE (1 << 0)
> 
> We really need per sub-request flags, not per-compound flags.
> 
> I.e:
> 
> FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> success (nodeid, filehandle)
> FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> 

we don't need this if we use my converters from above.

> > +/*
> > + * This will be used by the kernel to continue on
> > + * even after one of the requests fail.
> > + */
> > +#define FUSE_COMPOUND_CONTINUE (1 << 1)
> 
> Again, I think it makes no sense to have compound-global flags, since
> it might be possible that there are several sub-requests and there are
> different dependencies between for each of them.
> 
> Also if there are no examples of a certain flag in this patchset, then
> it's better to just leave it out and add it together with the actual
> user.

actually there is in compound.c

> 
> > +/*
> > + * This flags the compound as atomic, which
> > + * means that the operation has to be interpreted
> > + * atomically and be directly supported by the fuse server
> > + * itself.
> > + */
> > +#define FUSE_COMPOUND_ATOMIC (1 << 2)
> 
> Why would this be needed?  The VFS provides the locking that ensures
> atomicity, even if the implementation is not atomic.  At least for
> local filesystems that is always the case.
> 

we (by we I mean the fuse server I work on) could use the information that
a certain combination of requests should be atomic.

> > +
> > +/*
> > + * Compound request header
> > + *
> > + * This header is followed by the fuse requests
> > + */
> > +struct fuse_compound_in {
> > +       uint32_t        flags;                  /* Compound flags */
> 
> Not needed.
> 
> > +
> > +       /* Total size of all results expected from the fuse server.
> > +        * This is needed for preallocating the whole result for all
> > +        * commands in the fuse server.
> > +        */
> > +       uint32_t        result_size;
> 
> Please drop this.  I think libfuse can allocate separate buffers for
> each sub-request's out arg and hand a vector of these to the transport
> layer.
> 
> > +       uint64_t        reserved;
> 
> So it turns out the compound header is empty.   Not a problem, just
> make it contain 'uint64_t reserved[2]' for future use.
> 

OK, will do.

> > +};
> > +
> > +/*
> > + * Compound response header
> > + *
> > + * This header is followed by complete fuse responses
> > + */
> > +struct fuse_compound_out {
> > +       uint32_t        flags;     /* Result flags */
> 
> What is this for?
> 

This was used for signalling stuff from the fuse server, like e.g. 
did we actually create something etc.

On second glance ... in the spirit of your minimalization, probably
not needed any more.

> > +       uint32_t        padding;
> > +       uint64_t        reserved;
> > +};
> 
> Thanks,
> Miklos

Overall I like your idea to make compounds really minimal.
There is only the part with the interdependencies that I struggle with, since
almost all examples I tried did not have a very simple methodology.
(LOOKUP+MKNOD+OPEN or Luis CREATE_HANDLE+OPEN)

Could you maybe provide some examples of usecases, that I should try to drill the
new logic?
It feels like you have other compounds in mind than I do.

I have used compounds to send groups of semantically linked requests to the fuse server
signalling to it if the kernel expects it to be one atomic operation or a preferred
'group' of requests (like open+getattr, nothing happens if those are not processed atomic
in a distributed file system)

Thanks for taking the time!
Horst

