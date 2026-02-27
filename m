Return-Path: <linux-fsdevel+bounces-78700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNXJGtJnoWkUsgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 10:45:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3C1B5845
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 10:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DF213027306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412E425B1D2;
	Fri, 27 Feb 2026 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ROzbV/Ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8B1F92E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185550; cv=pass; b=g75B5S6FubrJ2zGVfV/MQAHcAI2qNFI7GJAHj7B9nJCwhB62Vyf8mlPq8waY5eXIZO+U4sHOXziIvHL11jgD/Ck4oSg3ljonZ51B31zoh3nvL730/ZdA78vj5isK407k/FB2wqykqThUKBAbAJ//F90iJnqtzFauoG8rRolGa9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185550; c=relaxed/simple;
	bh=LYfiULYDak1Rrn8KYni7YZG2azduXw9wqGjrHbqc3rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIIohZXkOFUKnzOp+c8IgRhwL8FiBkpG4eV6NrvXcDyY0mtVcvwlOZbFxNaz6qyAxWPe0EuPCa7eV1iyPwaKNKVxYAlC3X2xvrZGuzqSxN/T9cGKWme7Jiyy5UuPaYatg66R/FvP/zbWqssGKndczLoDnyeWf58CiY+TmwYq8Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ROzbV/Ko; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a019a7f3so22728301cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 01:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772185547; cv=none;
        d=google.com; s=arc-20240605;
        b=GcRRQM4jj7Rawe5UO8Jd4sXLdS+OnLLGameDfQ9wfn/2aO8QqhUEy+UGW/InoiOSR3
         iLTkpajBJzrW9CcF8lWe1bXZ2F5k8+5bICfve8OlShtz2/6vV7sQgpywWlV/o5xcW45H
         TrfYGroGd4HXNI7x/F/Tm8CwdOGYojzp8wGJXSEMB3+4FOmyZMHWOjAjvxSxkd3ZZrhC
         k67zv60IS8cbqhex8xJCkMcBB+BtB6420GPiXRC1+oyGlCdMGUDMVBmhL4ZJw0pksb2+
         menLphh0qZ4S68WcWKNYmEajlFHQwhYLQWN7mxc1KX1Hmktnnp8TNviQD/0vJndiSYNZ
         cYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/R6dzqLwhrjl09GaBWFRxJbKtr5PP6qwigk+bP2xpPw=;
        fh=8U43x0bXpVAhJQG3Yily2v0AzsOxnuwWKYniUEObFRs=;
        b=TpZC+SOAdJmHuinqaGdjVrnnaIR26UeImbVnm49gUV3y9oGA07rq/oykui3qYUOx92
         GVGlTZEY2hapQVCQCGYK5tnBOr0ROGg82U0ryyJUJeYFvlUMvP14C+LmxtylCIMqontu
         SRAUJQe7RWkvjlSgLXX1br3n0LDU/FHPOavqJ5azew36DNJNV2vDeXWolmVsgs/qc07Q
         dp3G/tHbw+7ahp4WbfzZ5vP0XhIM9qqH6oAjXutjZaQ1bMZ1dIqbORssY80PxupTGUiT
         bvJjA5xD0fVisETJaZmmjzDQ8jj7kTyrPFNtGczTTJRE63Nwa3rzS+sBt6YlIvop2eGZ
         E78w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772185547; x=1772790347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/R6dzqLwhrjl09GaBWFRxJbKtr5PP6qwigk+bP2xpPw=;
        b=ROzbV/KoS+uwe4PanGGzru5xwuYJKDs6hQJEGCWSbsgbkdNGaq1Y/O1qX0BmfS0cGU
         rglbsmUcmuAqgHjT3vTBFfSu1t6GDocFL/54s/JiN04kl+s4TPOOFa36CKbfjqSkWp8G
         6to0MKIS4nGWm982HAAEE4aRtp+cWqvWzs0X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772185547; x=1772790347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R6dzqLwhrjl09GaBWFRxJbKtr5PP6qwigk+bP2xpPw=;
        b=kS65u9DpROdisYVQ/F48g53DEITnHbwem+QA+spSdiYZbrZwP4TwvI428IoY0dRDxI
         6ab1nCuu73Z5qb/Qv9bNIzsuYJR1/KCfU860nRQ7R7b8CgdhU/woCoYs5itOTsdmsr7R
         H2qj/R59n9IzW6L5iT3NEX/WCEUTnteiEFc5tZTQJ6P49tcGSE0pCYxa/JHZcEjqe7Ov
         NFsjYgJLNmWMsPiyq+DQKCasMKbC5o0lnJxGYhE9STCQi+0KokP+Iz1D977AAws0OTBs
         MrwEOLmQOfesVo2/urT/zp7d8CO94MoE7a4XbUSn97Tafpjc/siF9MnP6WjtpKS51ngz
         d1CA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/L5PtgIudYleARuIVuIqDqTmqZygR0nKkQW7mAVS7klEHdRSfskSsCrl1onBvb+Rq57NefPx8c5TExHO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BVRkQEXXXnqkmyO38oK2y7T7P4GnDGVn5wBQCMramWCQ6cAB
	Cd3SA56hrXW1loNdNB/sV4dzrsq4pnY7b6RNLtw/uD4kKKVSpen8/JcbUTUFj2LEs7UlWTlORiS
	7plcezmpj+hkuOkJWKy2wJ4MRgn9yXbP7onSZKcZXtg==
X-Gm-Gg: ATEYQzwIFBAxw/rbBlgsq7/QQSlKdTvVkJaHoQSTA+hdKSbA2DEI13sGKolGx8/N+sh
	dw2kf//xiaZbhKxLmRoigDjfRy05PVJhycuOSjqzvbgCpn2F1OL8ko8POW65foacPdCC9trLSLu
	C0DX388853WE0VPrKOd1kOlRnu+djdQGPvY4HjheCXmAqApuzpcOUaMtcVDEkrn6s6RmodnO+uO
	bO3Y7et5D2YbIFtuuiB/jzR3I5MVw/PvGQZds3tOqv7CQug+jJ/hCuMJI2pA8207Ow3bvrc0QWu
	9F0MG5QADtWmzvdJ
X-Received: by 2002:a05:622a:452:b0:506:a3b4:357d with SMTP id
 d75a77b69052e-5075273a702mr24458191cf.8.1772185547320; Fri, 27 Feb 2026
 01:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com> <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
In-Reply-To: <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 10:45:36 +0100
X-Gm-Features: AaiRm50KADZJfq0wmqShWUsoC-AvHAVvD2nn1QIG2cUIVTmn-Z4Zyp-h0eRaJ4g
Message-ID: <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,igalia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78700-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1A3C1B5845
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:

> +int fuse_compound_add(struct fuse_compound_req *compound,
> +                       struct fuse_args *args,
> +                       int (*converter)(struct fuse_compound_req *compound,
> +                       unsigned int index))
> +{
> +       if (!compound || compound->count >= compound->max_count)
> +               return -EINVAL;
> +
> +       if (args->in_pages)
> +               return -EINVAL;

WARN_ON()

> +
> +       compound->op_args[compound->count] = args;

This could be done *much* simpler with lists.  Just add a 'struct
list_head list' member to struct fuse_args and pass a 'struct
list_head *compound' to fuse_compound_add().  No need for
fuse_compound_alloc/free().

Alternatively pass a 'void **' to fuse_compound_add(), where the input
args could be copied directly. This has the advantage of not having to
keep the args around, so they could be local to the fill function.
After the request is done the responses would similarly be decoded
into the outargs.

Both approaches have advantages and disadvantages, I don't see a clear winner.

> +       compound->op_converters[compound->count] = converter;

What are these converters?

> +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> +{
> +       struct fuse_conn *fc = compound->fm->fc;
> +       struct fuse_args args = {
> +               .opcode = FUSE_COMPOUND,
> +               .in_numargs = 2,
> +               .out_numargs = 2,
> +               .out_argvar = true,
> +       };
> +       unsigned int req_count = compound->count;
> +       size_t total_expected_out_size = 0;
> +       size_t buffer_size = 0;
> +       void *resp_payload_buffer;
> +       char *buffer_pos;
> +       void *buffer = NULL;
> +       ssize_t ret;
> +       unsigned int i, j;
> +
> +       for (i = 0; i < req_count; i++) {
> +               struct fuse_args *op_args = compound->op_args[i];
> +               size_t needed_size = sizeof(struct fuse_in_header);
> +
> +               for (j = 0; j < op_args->in_numargs; j++)
> +                       needed_size += op_args->in_args[j].size;
> +
> +               buffer_size += needed_size;
> +
> +               for (j = 0; j < op_args->out_numargs; j++)
> +                       total_expected_out_size += op_args->out_args[j].size;
> +       }
> +
> +       buffer = kzalloc(buffer_size, GFP_KERNEL);
> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       buffer_pos = buffer;
> +       for (i = 0; i < req_count; i++) {
> +               if (compound->op_converters[i]) {
> +                       ret = compound->op_converters[i](compound, i);
> +                       if (ret < 0)
> +                               goto out_free_buffer;
> +               }
> +
> +               buffer_pos = fuse_compound_build_one_op(fc,
> +                                                       compound->op_args[i],
> +                                                       buffer_pos, i);
> +       }
> +
> +       compound->compound_header.result_size = total_expected_out_size;
> +
> +       args.in_args[0].size = sizeof(compound->compound_header);
> +       args.in_args[0].value = &compound->compound_header;
> +       args.in_args[1].size = buffer_size;
> +       args.in_args[1].value = buffer;
> +
> +       buffer_size = total_expected_out_size +
> +                     req_count * sizeof(struct fuse_out_header);
> +
> +       resp_payload_buffer = kzalloc(buffer_size, GFP_KERNEL);
> +       if (!resp_payload_buffer) {
> +               ret = -ENOMEM;
> +               goto out_free_buffer;
> +       }
> +
> +       args.out_args[0].size = sizeof(compound->result_header);
> +       args.out_args[0].value = &compound->result_header;
> +       args.out_args[1].size = buffer_size;
> +       args.out_args[1].value = resp_payload_buffer;
> +
> +       ret = fuse_simple_request(compound->fm, &args);
> +       if (ret < 0)
> +               goto fallback_separate;
> +
> +       ret = fuse_handle_compound_results(compound, &args);
> +       if (ret == 0)
> +               goto out;
> +
> +fallback_separate:
> +       /* Kernel tries to fallback to separate requests */
> +       if (!(compound->compound_header.flags & FUSE_COMPOUND_ATOMIC))
> +               ret = fuse_compound_fallback_separate(compound);
> +
> +out:
> +       kfree(resp_payload_buffer);
> +out_free_buffer:
> +       kfree(buffer);
> +       return ret;
> +}

If we go with the list of fuse_args, then all the above logic could go
into the lower layer (dev.c) which already handles fuse_args ->
request -> fuse_args conversion.  What's needed is mostly just a loop
that repeats this for all the sub requests.


> +struct fuse_compound_req {
> +       struct fuse_mount *fm;
> +       struct fuse_compound_in compound_header;
> +       struct fuse_compound_out result_header;
> +
> +       struct fuse_args **op_args;
> +
> +       /*
> +        * Every op can add a converter function to construct the ops args from
> +        * the already received responses.
> +        */
> +       int (**op_converters)(struct fuse_compound_req *compound,
> +                             unsigned int index);
> +       int *op_errors;

Can go into fuse_args.

> +
> +       unsigned int max_count;
> +       unsigned int count;
> +};
> +/*
> + * This is a hint to the fuse server that all requests are complete and it can
> + * use automatic decoding and sequential processing from libfuse.
> + */
> +#define FUSE_COMPOUND_SEPARABLE (1 << 0)

We really need per sub-request flags, not per-compound flags.

I.e:

FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
success (nodeid, filehandle)
FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup

> +/*
> + * This will be used by the kernel to continue on
> + * even after one of the requests fail.
> + */
> +#define FUSE_COMPOUND_CONTINUE (1 << 1)

Again, I think it makes no sense to have compound-global flags, since
it might be possible that there are several sub-requests and there are
different dependencies between for each of them.

Also if there are no examples of a certain flag in this patchset, then
it's better to just leave it out and add it together with the actual
user.

> +/*
> + * This flags the compound as atomic, which
> + * means that the operation has to be interpreted
> + * atomically and be directly supported by the fuse server
> + * itself.
> + */
> +#define FUSE_COMPOUND_ATOMIC (1 << 2)

Why would this be needed?  The VFS provides the locking that ensures
atomicity, even if the implementation is not atomic.  At least for
local filesystems that is always the case.

> +
> +/*
> + * Compound request header
> + *
> + * This header is followed by the fuse requests
> + */
> +struct fuse_compound_in {
> +       uint32_t        flags;                  /* Compound flags */

Not needed.

> +
> +       /* Total size of all results expected from the fuse server.
> +        * This is needed for preallocating the whole result for all
> +        * commands in the fuse server.
> +        */
> +       uint32_t        result_size;

Please drop this.  I think libfuse can allocate separate buffers for
each sub-request's out arg and hand a vector of these to the transport
layer.

> +       uint64_t        reserved;

So it turns out the compound header is empty.   Not a problem, just
make it contain 'uint64_t reserved[2]' for future use.

> +};
> +
> +/*
> + * Compound response header
> + *
> + * This header is followed by complete fuse responses
> + */
> +struct fuse_compound_out {
> +       uint32_t        flags;     /* Result flags */

What is this for?

> +       uint32_t        padding;
> +       uint64_t        reserved;
> +};

Thanks,
Miklos

