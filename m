Return-Path: <linux-fsdevel+bounces-77000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOt5CaafjWnv5QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:38:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809912BEDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50FB03079BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498522DE6FA;
	Thu, 12 Feb 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B84ZW2Mz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7517B418
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889118; cv=pass; b=LYe5fAeZnIx7OAWLDvvTehCQtXfN601EnPdC+ATWonewyECwo4wv9RjcVPvaqh8Wxt1/YZglKfsetHKdmxoL+2o7LxTKW23HRDQ0lVNCQea12LOrwXOxkRT6P2ZR/tISedEcOowcquRnOzdLZqLzHEzH3hOQLyp+T3NJnxUz8Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889118; c=relaxed/simple;
	bh=weBJ/Ate0oyfZTm5jdGQ0z4O+qNODLGe/D3eHaDre58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAAwIvG5ufvFITUfl3mI8bHcxDjfaikF7V/A+nKxJ5LHYUCoBRgUTPes6okRYXmhltxLj5rudJRIb56+OsybtIRXUQtfuUgcNu/Lj5avbBRjGMwIYZvNiX0pnpCcQoy0IvBCUWmWFsNEPPedYk3D0v67H2VRMPeju2ZjuEJLPDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B84ZW2Mz; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5069df1d711so668911cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 01:38:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770889116; cv=none;
        d=google.com; s=arc-20240605;
        b=Ur3pqMS1aUM380PDUbkoEyPDQ38gxDoVHbwAJWR6UJmmp2C/VMqi//Iosy4MqYi+Bg
         yOziIIgDKkOEyAysci+vOwuqwAqBJQjzlanW0d30liKwxQb9g2I/p6gEHxu/Q0jp++wd
         DLRUz67kDaDkJR5bZVLlj5cdWpAizL22L9GXvYs/imNZAegOS6SJzAjgr3fsCyVa1BU/
         lSGoMxwCbHE70iinfbfBB4pKlaBAzDvCAqNi8RFKCOL9Z2DyjU4BP+bNku9McM5Ug1gX
         v8jFFBcYmnnYk9tk9lwvFUD0DD8x1zLsVPouzHqMRzeV7r/sby2dShc/3lOGITXy5huI
         xZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FPKVhVDgukhZAdqg6BBIVmLKn9M0CYVBfhfPQxQhylY=;
        fh=CDV9IRiVYZDAgMhZbHAsP05K7i/FPG0wb3c+Jgsh+uY=;
        b=em9AIm8aZft/FWhofVT7ONYFKZc1ItrvSsaAnlx2DQxqUWWgKqtDqrTKo+7glAAB09
         /gAGUMkHW1i7QHlB01x/DF21bwhJE3xidj5JJnfH2T1XMv2vSl5I/M4doxSWzCmdpN/r
         M+OJbYmG+iYGaA9g8O1AxLRNqXomjemQvYzy9pl7AlkqZQFN7E/dEEzDQV8BVaAfmQQ7
         pM+Enzbc3WSemLev93acaMz7QpaElkenJRt0NAW3e4dy67BmQOK3Wz/I82gPG7J1VPSN
         z1E6qsow67Xc6RXG4SRRALuhkw/8OV9q6+Fm+jbyuEksAZ18VRrfzanW1QyiEJTX9USp
         TXZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770889116; x=1771493916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPKVhVDgukhZAdqg6BBIVmLKn9M0CYVBfhfPQxQhylY=;
        b=B84ZW2Mz54imYUJAw/FlYrLGxaDugomiwdZU8TwPqw1Yqwd3h3D4JcLB0V40vsRjV+
         i1D8nv2ggrz6We0c/wySZAv/9GQEaFPbEL+/fd2Oa/XDty5Te970BrNXxP93qGT9/7Sf
         RPcDcuGEnUEPuMS0EIASWYLsSHXdPIkWqkfK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770889116; x=1771493916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPKVhVDgukhZAdqg6BBIVmLKn9M0CYVBfhfPQxQhylY=;
        b=QF4KI35JxsA1saKqVhtA3ZReBDAqvoxl/PO773qdBpbQkoGT7rS4eV8kN0J3jxq7yV
         gPfS8pmhuvTCPNimspngKIJgvUuG0QxrAdEUiLP91KzWznFtLaSbHXZ9pcaZ+otL4s7b
         SR37JbBokl58CP7YWP6lC4edfqakB1LdbcYnjkj2tr/SMed8SxByZiSSXDUGCnJ7zyUS
         2YECM7xglxMlm2Q1bAlBbw6vu/eZSRpToRrVtk9GahB87RNvByadhApIZFRxRTp6hwMd
         PM7YmyCS0CXVjKCFtZ7UlEbjEyIX83XWWzJs0VFd0uwwTtdrzFpYiPyt1vMA9gfh+lPj
         FpXA==
X-Forwarded-Encrypted: i=1; AJvYcCVhFG4dARJUCwKUX5J6wlg3F5sTM72gN2N4TRfLQDOPMGAda1PhLxRjyy2hXoBpUjOZlfW4Uk5sxmDbkAgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6/wPdTrtnkdeklyZl+vyktsxuu42dyyh1dQZpo+k10Gr/uH0
	DODoUBKghblQPbENXsTv1NljL+Bwf3+USMZYeFzQkyn/SMsqzk6axXAgxRM3qE3ZH+Xnqqg04HN
	p47Vf23dWAipyopQy/+hhC0OAMlNUmpcoPsDDUrfXRQ==
X-Gm-Gg: AZuq6aL8j+iBC6CQiJpHQDP5s8D/P6BdPvenju7QT+QQ2yfzjIdZo210XTqBHLgi+fd
	RoLgt6GTcIYEwFn47RSkauVjDYYG3gSJWsvwb26kPgUv7/cfwOOAzuq9g8A4zi3Y1deCU6FPqDa
	K3ioGqWyVB05jCAujU4RNzLEEahB34wf+BCdv+sHmd5haCATrOd3WdeWK1FF2yKQrF3fxEhi44I
	vJE5ndVaQT1GYOaQJ3uuJDLtSsXxeA254YW8E7jUklTMBDU4CrQdOTNl08bq+qaI26D0IITvMjS
	41UGcA==
X-Received: by 2002:a05:622a:1442:b0:501:4701:e9f9 with SMTP id
 d75a77b69052e-50691ccadfbmr29432101cf.26.1770889116533; Thu, 12 Feb 2026
 01:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com> <aYysaoP0y4_j9erG@fedora-2.fritz.box>
In-Reply-To: <aYysaoP0y4_j9erG@fedora-2.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Feb 2026 10:38:25 +0100
X-Gm-Features: AZwV_Qh4ZAeLzmWmgcubhlhJq7qByRwi-QnKnhxBFE-ua8GFA2ZKlgTp3sPapCE
Message-ID: <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
Subject: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77000-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim,birthelmer.com:email]
X-Rspamd-Queue-Id: 7809912BEDC
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 at 17:35, Horst Birthelmer <horst@birthelmer.de> wrote:
>
> Hi Miklos,
>
> thanks for taking the time to look at this!
>
> On Wed, Feb 11, 2026 at 05:13:21PM +0100, Miklos Szeredi wrote:
> > On Tue, 10 Feb 2026 at 09:46, Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > > +static char *fuse_compound_build_one_op(struct fuse_conn *fc,
> > > +                                        struct fuse_args *op_args,
> > > +                                        char *buffer_pos)
> > > +{
> > > +       struct fuse_in_header *hdr;
> > > +       size_t needed_size = sizeof(struct fuse_in_header);
> > > +       int j;
> > > +
> > > +       for (j = 0; j < op_args->in_numargs; j++)
> > > +               needed_size += op_args->in_args[j].size;
> > > +
> > > +       hdr = (struct fuse_in_header *)buffer_pos;
> > > +       memset(hdr, 0, sizeof(*hdr));
> > > +       hdr->len = needed_size;
> > > +       hdr->opcode = op_args->opcode;
> > > +       hdr->nodeid = op_args->nodeid;
> >
> > hdr->unique is notably missing.
> >
> > I don't know.  Maybe just fill it with the index?
>
> OK, will do. Since it was never used in libfuse, I didn't notice.
>
> >
> > > +       hdr->uid = from_kuid(fc->user_ns, current_fsuid());
> > > +       hdr->gid = from_kgid(fc->user_ns, current_fsgid());
> >
> > uid/gid are not needed except for creation ops, and those need idmap
> > to calculate the correct values.  I don't think we want to keep legacy
> > behavior of always setting these.
> >
> > > +       hdr->pid = pid_nr_ns(task_pid(current), fc->pid_ns);
> >
> > This will be the same as the value in the compound header, so it's
> > redundant.  That might not be bad, but I feel that we're better off
> > setting this to zero and letting the userspace server fetch the pid
> > value from the compound header if that's needed.
> >
> > > +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */
> >
> > Don't see a good reason to declare this in the API.   More sensible
> > would be to negotiate a max_request_size during INIT.
> >
>
> Wouldn't that make for a very complicated implementation of larger compounds.
> If a fuse server negotiates something like 2?

I didn't mean negotiating the number of ops, rather the size of the
buffer for the compound.

But let's not overthink this.   If compound doesn't fit in 4k, then it
probably not worth doing anyway.

> > > +
> > > +#define FUSE_COMPOUND_SEPARABLE (1<<0)
> > > +#define FUSE_COMPOUND_ATOMIC (1<<1)
> >
> > What is the meaning of these flags?
>
> FUSE_COMPOUND_SEPARABLE is a hint for the fuse server that the requests are all
> complete and there is no need to use the result of one request to complete the input
> of another request further down the line.

Aha, so it means parallel execution is allowed.

> Think of LOOKUP+MKNOD+OPEN ... that would never be 'separable'.

Right.  I think for the moment we don't need to think about parallel
execution within a compound.

> At the moment I use this flag to signal libfuse that it can decode the compund
> and execute sequencially completely in the lib and just call the separate requests
> of the fuse server.

I think decoding and executing the ops sequentially should always be
possible, and it would be one of the major advantages of the compound
architecture: kernel packs a number of requests that it would do
sequentially, sends to server, server decodes and calls individual
callbacks in filesystem, then replies with the compound result.  This
reduces the number of syscalls/context switches which can be a win
even with an unchanged library API.

The trick in a case like MKNOD + OPEN is to let the server know how to
feed the output of one request to the input of the next.

> FUSE_COMPOUND_ATOMIC was an idea to hint to the fuse server that the kernel treats
> the compound as one atomic request. This can maybe save us some checks for some
> compounds.

Do you have an example?

Thanks,
Miklos

