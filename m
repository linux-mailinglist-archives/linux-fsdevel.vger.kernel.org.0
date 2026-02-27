Return-Path: <linux-fsdevel+bounces-78757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAmYL3raoWlcwgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:55:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B51BBAB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7705310B358
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D1363C4C;
	Fri, 27 Feb 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTctlDHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A2348479
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214720; cv=pass; b=XDzSVmNt4+s0PSjMJFVD3u/LxviZEDqZpT5YLolqOm6LOJZc/ZnxZCwbXC2c2o9k4b1927n2AxcJbhckRqUTFnwe8f8J/dZGLCfui4bsk+smySkqEi2msWhJl8OXkcqT0Q/6bqdTp0F56YP0pLiWjhkk8ANh9nlsdsxg5NRo0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214720; c=relaxed/simple;
	bh=tgzVE1rjSd/A8Hk5AZF2BlXQFV3QNLuGxVhbODFemDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYWTwuntVm3/KCCybRSOTm+YlmosBepxxbPrUTf+QSu1ao5kDT2teqVK//ibBvcijP52ZBPE0p2cIWQIe/NQX4M//ewebNEsmhFict9yOZerq1SPZmlncPRnT/MrGu4aZB2oFPDlSxORec7LvwxvtEMD9p9+QIh45KDjDMPuE10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTctlDHP; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5033387c80aso43704221cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 09:51:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772214717; cv=none;
        d=google.com; s=arc-20240605;
        b=Le8+fkgC2Kn6eBi8aUPFI6TFRC39WIl1n18S/jRsusikoXv5mAlBjUGLK9OdMQVirt
         VbiBUNLjUrezZY6bcHoeR1R0voBAZH/dTFk+p4sGrwdarNu4ZWjaXj2uGMeyE+9YubTW
         S1D6bvx4LtzxMXEZax3AkGH1mPW60zlJg2O8uwng38Df/J8PZgbgAimjIAgFbqCSSy5u
         xub+RIwITnucTHajq4vhgOJHbFCy0bwnSFxKrXawGEE0ewkOLqDfvCWgyB2HdTAxsa82
         FG6V3XcYcKEVM4scDXPCooZAhGFIRZqNhc4xNu8xRCzJ9ZfoKRhtlaR64ESQBYpYNAe2
         tZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igWa6B8iPvI7G5l5PLI3eqI5QazD5La3xn3aQDAiRi8=;
        fh=A6Sa46Lg/HHjibLZnybZhb48zPFnn+7OXRcLdzFkHWs=;
        b=hsxpw1URzD7blmVp/XUfNHzdWcP0NXU5Q0wENM53xJGKIDVl2IcbeHw8Bc6bW4dnEG
         5YI+bnGhd8fQKNqwWVSdDA+I226VgktUwyXgR1+hfpYhcDJmG7mT+sfx8ntjFOOShBIg
         aKu3CkcMnC6k08Ffk9RJ7qQ+A9n7IHSMprEwfnFBMDttJ0mGuRitgGxrTTEgfOMwKY9r
         8kaS509TRCOacqbz2EfP+l1X7HspqLofzWIhKUMrkEHsZNqndZoPTF1cerOjdHOTmXdy
         rJBRtX0ymaSjb5mU9i7+X81e6ZYW7GCdzUzjgAqmpZaj+vziaAMIDLM6xt2me7i2wFVb
         bfkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772214717; x=1772819517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igWa6B8iPvI7G5l5PLI3eqI5QazD5La3xn3aQDAiRi8=;
        b=MTctlDHP3F+aRdBwqORAgIR3X0Rxw3+UUZXwz2yHXk6bBUU3ZC3tDRNU7psIMO8Y8m
         mhpP9yKCzM1zmN9qoajAJc1635hjgr6Ji5FBF9irVL91sw/3h6pMa9DRlxfYM9w2sUMg
         bo9Mqxpgopw1X122lH7I5b2dX877N/442sGN3di0QRXOhXQIUXZ0HH4MfGV/2aL1z4TB
         eUIp5ggE7kb9CxWfNBj++mKM92DgGQueRwTVq7q5eStKoXr2lbEDICUg0ukXBtoHsFUy
         /QZwZoW2flZJbMebBggVoDfGe4aOfyJMapkMUKtiC9Cg+wGK3SUMMFScvW1n9OP643MS
         lruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214717; x=1772819517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igWa6B8iPvI7G5l5PLI3eqI5QazD5La3xn3aQDAiRi8=;
        b=n6HL8sZhA30VZkfsEr4uvXVNHVnAXkA6/GEMq6beBTysLjMS8PDOpuLU+I36l2dQHp
         6535v7DknahK8FaYJm4MGbeZSA5rqkE2EE2/AEQLy5cnTFl6lX+r07I7bT5TfkOTHqnA
         AjZXzEWLLxYy5O0z2/CNfpgRgXvYNlqG7GpCdK53jrkc8m1E4H9q5XuiT76EEMXbSLeI
         8J8A83X84nZ/p1wA2vw/9Mt9odelXLk6kcVMxHaMwnWo723CaLogdv8d/kT7+s1agknE
         ZxzQQkOLNlzjgax+3CfhKjv5ymB/xFJp0/93ZQcN5lUXGXAZ9DDSuupHZBioWmURFOGc
         4saA==
X-Forwarded-Encrypted: i=1; AJvYcCUkADEbi8fbkN4COucxXPIKfwZlqC/BCC+aV7LkSd4aPEW5Kr+H+ui+N6wkXlIFJkC4uC3fVfQ9cwyG8J8x@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lhrW5osXlH7RwXsyrTloZv7zu/8l4+CLxeCB5pLT/n1i91d9
	0n0EpvIv65QfHYz100BPk0HsS8Nc8CMYc9YPsDI4pZS5nUVbxbcyA7Jv5IHx9/lisXxMEVpD8r5
	DE+jwub9h7OL1+fhShmHwbelFJ2/oZ2M=
X-Gm-Gg: ATEYQzwP+jgZWDu6+/3LhRgBcQeJamSOP7dhACwZTeHMOszP4J8YDv3bJOG3wIGIvBf
	GQmCjGRT0I2n+UIXh/fadJlwtN86WJR6cvnVtPlpClcOX1umnQHsYKo96Rt4mj7U6Df/qLsrGwT
	DL2o0Io5FAAhfYiL/vJcfMmT3w1oEYWIFgnkxXfgDoZvlq7KUdi6NteJVuW2ncrEu7AXjgXGQkC
	mgjvoaQLSxjLOCZSI6/UmIAimTj24cQ0fCmFIM43eOGR8K+VmGQ+ZcCr0nn7VHhRpHkYQLPwkW9
	VjP+ew==
X-Received: by 2002:a05:622a:1822:b0:506:1e25:c0d3 with SMTP id
 d75a77b69052e-5075241d82cmr40213351cf.30.1772214717390; Fri, 27 Feb 2026
 09:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com> <aaFJEeeeDrdqSEX9@fedora.fritz.box>
In-Reply-To: <aaFJEeeeDrdqSEX9@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Feb 2026 09:51:45 -0800
X-Gm-Features: AaiRm52aiNkUX5cWNvfeGGJDfcCOArsRq7-XJ75Cc1p_gAQR4h7u0UDf1y3ExA4
Message-ID: <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
Subject: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78757-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ddn.com:email,birthelmer.com:email]
X-Rspamd-Queue-Id: 248B51BBAB3
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:48=E2=80=AFPM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> > On Thu, Feb 26, 2026 at 8:43=E2=80=AFAM Horst Birthelmer <horst@birthel=
mer.com> wrote:
> > >
> > > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > >
> > > The discussion about compound commands in fuse was
> > > started over an argument to add a new operation that
> > > will open a file and return its attributes in the same operation.
> > >
> > > Here is a demonstration of that use case with compound commands.
> > >
> > > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > > ---
> > >  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++=
++--------
> > >  fs/fuse/fuse_i.h |   4 +-
> > >  fs/fuse/ioctl.c  |   2 +-
> > >  3 files changed, 99 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241=
bdf727e00a2bc714f35 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > >  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> > > -                                unsigned int open_flags, bool isdir)
> > > +                               struct inode *inode,
> >
> > As I understand it, now every open() is a opengetattr() (except for
> > the ioctl path) but is this the desired behavior? for example if there
> > was a previous FUSE_LOOKUP that was just done, doesn't this mean
> > there's no getattr that's needed since the lookup refreshed the attrs?
> > or if the server has reasonable entry_valid and attr_valid timeouts,
> > multiple opens() of the same file would only need to send FUSE_OPEN
> > and not the FUSE_GETATTR, no?
>
> So your concern is, that we send too many requests?
> If the fuse server implwments the compound that is not the case.
>

My concern is that we're adding unnecessary overhead for every open
when in most cases, the attributes are already uptodate. I don't think
we can assume that the server always has attributes locally cached, so
imo the extra getattr is nontrivial (eg might require having to
stat()).

Thanks,
Joanne

