Return-Path: <linux-fsdevel+bounces-76182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MIcEyDRgWl1JwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:42:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6030D7E38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C4E316D2E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076931ED8A;
	Tue,  3 Feb 2026 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOwYUfLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1014284B36
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114699; cv=pass; b=VmRF777tgSvQo4wUmQpJd/R6Kv+SiCYpNqtcGiCq8FCuhubTVUYbGzd2PsJZ/9hdNcqP3nuYDFqnMv+AULgRakPPuQtSTxDVxnUzwmSrsf8JfHw5GPhbBboDgAwM88wB6RjlFVRgl0nRB6yrRd+ghEHH0jXl9vPJYe83ewdzi/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114699; c=relaxed/simple;
	bh=K7jq4EaD90X1uHETjVXhWkG5auNLrek4XJv/dAqIOMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggjZkm+avWXN36ZhfTPFsyDCbz2K1ZgBx+gyj89cWhF6uV057ISqN18bngbLuf+tnC6GfB/3xP11qH0b7J6Txr1e1FnN1H4EXgXP9SBZH6bfYCl6lYTQ9+QRpqIcJ8Gn+gTA+eakNw326kXFuT19xg6WwGTHrsX+UvhZMYtI1ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOwYUfLL; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-659378d356cso1215315a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 02:31:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770114696; cv=none;
        d=google.com; s=arc-20240605;
        b=FrMGK1S/YLqsO5cJ0I2G3Jpl4VsN2zjyT5091aP/M2H6wnQATSxs6trgPGXYcj+5fs
         /W3YVUsI+2INxGup2LUFAErZPPVFmHuv7OJjoiDHKnOOnT9RzcAfCye8AhGBWe7/otnd
         joXgn0+q7s5REi+jH1QqKRSkVJStkQPcnTyjcMU3t5HWyhDhG3VIZ7rDpQDEH51KjL6J
         udDflvu0mVaNYwCvRIbEGDbH7VcIRlNidT/b29aw8tw/OJkumRUjxQSRlMzbPcDdocDl
         Pf3kb1AphIb7dYDhD0/CYFbgLczdDAnS295rIXiJjBlkXf0U7CCWkuQFVdKSBQ320VRW
         6Q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obbvX9n00m2h9S7I0bcHUF5zApc7cQXFXNL1aTznmR4=;
        fh=YHyt7l/ST8wgX9s0Bq7p/EVT0u1xmdqvWHt+JJG8XqM=;
        b=hiY6NiC7KQRZjOnNcXl52EqU1SE/bWLRWbhId1DTWd44IPwpGzYqd0VTNvt46jDhz3
         Qyn5tYWvk+kSGnSeJcI+l+jPO2rCYf9BsNBeVbuv8V7tuYdFWG08ACwByw6U5EO/LKB9
         bgnN8uA1jtWcgNJsHO0ABWoqAnboPv2DBMoPmdjrsU7XERPhMS9xc3Qc3Rj8t7tvEsQY
         gCjYfaUhDF4J9ts13J+whhVVfLGVe5v8oeuoPu8AXo9XtX25OZewjbeNuPhHHbArAcDs
         bzVIxqbZuBqV3XGlH8Z6baxc278hHTYCTRQXuHVnNYEsX9YcF7hoQgxGRrR4yCw0eYev
         JqyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770114696; x=1770719496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obbvX9n00m2h9S7I0bcHUF5zApc7cQXFXNL1aTznmR4=;
        b=WOwYUfLLYa/29D4FdZrA+v+7H2TtdyKMemPqbf4UIJHgwzLYmdQrJzVR6zJMEwhY0r
         WRlRMWzN5YiT2Y1DsvkOkD7ANpaa45nTNNzvyKM7R6GO5yyJxS+v798j+oFfMhU72GNo
         IXdB6t0yfHS7MurRUjNChJ3RTMAZX9kBwNaEd5KKoy++SuzHx026+W6BMfDNCbwexE6M
         09JKKwk/+8R2tzk5kMLZBi5nkS126LKQrls6aC41y00NFatgfdVNxkXmUyFSNiABDZAA
         6vJCaLBqvcGO6qMwB297v2eVYlmsjn+d04AUqm5vppQc/1OoT3oIIe8UlO3sPo0axodK
         FeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114696; x=1770719496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obbvX9n00m2h9S7I0bcHUF5zApc7cQXFXNL1aTznmR4=;
        b=nO+VLRF8rS6YDMtL0XFQNj1lTuRyJvSn4ZF7DTYxCl6IxsxdKnpjQb1wQzGZAZDHnN
         KZjGwkzpStQQYoa4nKYnT/mGhjWVPusb7K5xdtvhsJou24PPTSQEY2Cd0oplvgRRcqvX
         rJ5q8vhq/KxLu5K4KuIV709ia5Rqbi+LHH8He84u/lh690Yx03jFClVjNI2KYjeiKylj
         HBxYAGUK6p+xk6Ahtidn+uDoQvJZbzjmNpzMwPdldb7iw/LeqpNPhUsldcRqroapzOdn
         t4GvjaXtz5f0Uo6lYmmJ8WbbMhwvmfJrH52y1knPnY6dT6LswKnIZkGztPcSz/HP1de/
         dsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCCUQk1UsBjTZVLvB0Uye6mRmdCL1eNqC9QSXpUXzkH5yTofnj10hU3oCVcRRYk+B/bOje2xlp1+0BpoQy@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqm5GDy7LLOOlOd/ev2eI2CSzrJIvMnteZsRKrcnXvZY5vlVS
	eNe7UxCy6LAZTu9zKDQILmhNRGLzvMLIuBJKBz25/zerloKwM113khC/4Bpl3RXRbyZ2+WvRRb2
	+uX5U6hv18rXXV3uyOIt8112k3QzDlsk=
X-Gm-Gg: AZuq6aJfZPsUpYohyCPponpIFuURh8l5nmxPRvuYavM0/bxH1INQBTyZowRKuNKFF1T
	vvb3icf2QaadkAdyppNTrDA2e1XH4E1RuHG6KoG8gBl7iaJOinuafbb9O1UtsXRA3JL+gS2tEG7
	oR5cBqlWKOkXuDFGpPW46t8fLZUUkm209X40NW9YQSyqtHVhe0v3Y6TCna2oxGRWW72MQE83VEl
	7VpxSLwbG5j4U6xzCTpzn9BXvJ2MeBN8yGbq6hY1CnPpvh97TrV9pnZPxBCh3lrdjOf5thvITka
	zirIbFb8Z8aAWK23+uturR9FtmCCWQ==
X-Received: by 2002:a05:6402:3487:b0:658:b8f4:549e with SMTP id
 4fb4d7f45d1cf-658de58b4cfmr8463129a12.19.1770114696198; Tue, 03 Feb 2026
 02:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com> <janl2lzct3nz5zlbhlzaasfi7juy3qvajd2jd53qdcb23dbprd@hignhm2ig7s4>
In-Reply-To: <janl2lzct3nz5zlbhlzaasfi7juy3qvajd2jd53qdcb23dbprd@hignhm2ig7s4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Feb 2026 11:31:24 +0100
X-Gm-Features: AZwV_Qh3QERn6T932vy8F4OKmRk0FlXuKYuYbwdjOJ-VppBOiyiOk_uwvv1AB5U
Message-ID: <CAOQ4uxgpmJOadVOD4hGkeYFzbinmfLvReNndhzcM4WA4LjAoqQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email];
	FREEMAIL_CC(0.00)[szeredi.hu,vger.kernel.org,gmail.com,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-76182-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A6030D7E38
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:19=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 03-02-26 08:55:26, Miklos Szeredi via Lsf-pc wrote:
> > On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:
> > > I think that at least one question of interest to the wider fs audien=
ce is
> > >
> > > Can any of the above improvements be used to help phase out some
> > > of the old under maintained fs and reduce the burden on vfs maintaine=
rs?
> >
> > I think the major show stopper is that nobody is going to put a major
> > effort into porting unmaintained kernel filesystems to a different
> > framework.
>
> There's some interest from people doing vfs maintenance work (as it has
> potential to save their work) and it is actually a reasonable task for
> someone wanting to get acquainted with filesystem development work. So I
> think there are chances of some progress. For example there was some
> interest in doing this for minix. Of course we'll be sure only when it
> happens :)
>
> > Alternatively someone could implement a "VFS emulator" library.  But
> > keeping that in sync with the kernel, together with all the old fs
> > would be an even greater burden...
>
> Full VFS emulator would be too much I think. Maybe some helper library to
> ease some tasks would be useful but I think time for comming up with
> libraries is when someone commits to actually doing some conversion.
>

I think that the concept of a VFS emulator is wrong to apply here.
A VFS emulator would be needed for running the latest uptodate fs driver.

If we want to fork a kernel driver at a point in time and make it into
a FUSE server,
we need a one time conversion from kernel/vfs API to
userspace/lowlevel FUSE API.
LLMs are very good and doing this sort of mechanic conversion and
after the first
few fs have been converted by developers, LLM would learn how to do it bett=
er
for the next fs.

The main challenges I see are verification and package maintenance.
The conversion needs to be tested, so there needs to be a decent
test suite.
If an fs already has a progs/utils package, it would be natural if FUSE
server code could be added to this package, but those packages are not
always maintained.

We can map the most likely candidates that have decent test suites and
a fairly maintained utils package for a start.

Thanks,
Amir.

