Return-Path: <linux-fsdevel+bounces-79293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIceIiNrp2mWhQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 00:13:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E21F84CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 00:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B43305AD61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6F384244;
	Tue,  3 Mar 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EogVpJeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8336CE0B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579608; cv=pass; b=Jdi4zLzjHMuH2+QTVYK8RIotictjyzv6Lgov5yYZKc+Ih3TcfXnHNHL2GOmPWOSNUFSOlfYZ3a3fIcw/MVTc59nr077qndgVV2K4Hiweh+ocndGYpNMrNCwP5JubxYaiZVoAZUsJT2sJbFUeV9aEAQXlR4rU5MFpHwN3vHUvDOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579608; c=relaxed/simple;
	bh=KRLD3TVfoKGyZ37vG3limE5X0Z+i9YgzePkImUSe6Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDUrqRgcXUOax9mS7vd5gqHwR3lrncsd86/TfRkgHAamYxODho1XDP04DtDtJS/5iwBO1YxWDDWSqymWTqaVrJNzeIbqnAEKpgR2qkSyJXfTZLkDkY59bBZimn7psQBkNSkSz6vbCa/wo8rOTSB/eQkEclRIuiVypCekmWEQHtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EogVpJeG; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-507373bffd9so55561751cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 15:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772579606; cv=none;
        d=google.com; s=arc-20240605;
        b=ByI2p8uXIU41KI77xpORSPZ/EZYQOmdntZCEYFAG97S5vfmu/b0l0v9aTcOxdSlcjY
         3CyF01eV/VUEAMRs1Ca/f68jtkiUCNv+urievKfi0U0T5vNfJYUUz4Zqdhm6Q8gpZ16t
         8hH+N9l1jqAGSNB/m0KJdaThD68fxbQM223AbZ7dkETHhg4dBuHNz+VyI6cgoQ/icDW8
         m+8qZ1zqfqJveTCVq8y3FAew710YLJbysoTOGph47/faBmqxHGgHSI+0VlujBH8UoQTC
         yIBj8phQEW8+UcnfNZhty5FytBTwhOLSLM7eiSq7ESe8zOuCPp7ORN5eAbwvrQgtEuv7
         Okbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8KtFE0Nb5deqO3dx81aXqQ7xHlLbFlqGSS/uoQKdTQ=;
        fh=+hKS5JnBpQcQJUIs2JhAFV6DJ35b3O+8kO0xqZvRs7Y=;
        b=Eb5l4NWy1kNNknIOvv0fhh8jVOJro9nsBHHdKxtsG3bQURLx9zRqFpCAJZMBxi0kQ1
         GlY6FdUozPJrJdz78q5p1BjsumvW4r6rllSuPWp8STi3UmqMSD/KLPU3xmXWgLfKh5IH
         0DGR8qwGNatr2cr7P+nFeg8Yh1ZIZSgA40MVi7A8Of20q4BKLePtlD5uZ1kgtmsrx7ik
         WNlE0uXEA/nM/gTT6pANc4Z5kOPtmgJZqLbHIlHKW7mbbfgRqJLnzP/bdtXZPaCz8226
         9j+Lklb2/HpfmEZmlSu7KHEPBuifQcQdLJR2hDrg8cJ5hKaXWT9VNcXpH/iv0hNdYsGU
         k8Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772579606; x=1773184406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8KtFE0Nb5deqO3dx81aXqQ7xHlLbFlqGSS/uoQKdTQ=;
        b=EogVpJeGpZHih5/8MEgZDp3CIyEhhpGWpN03gzraPQ+SmZeyMOdTP90VuWTbTMeJPC
         Pu0cD4YXqxC+8rETDKx8LpClKiU51cJb9VpEXAMyrDYblOcAGb3SkC0APjF76tMIz3SC
         lIA8efZy/JdS/+hyDj4fXINtvBLHD1Ta5D15z8PmFV1DP0C2/0PrPeefyt5SoOcCq+4C
         DuoZQMuBN5Hj0JamXPyUrJw1Too2RFK1jPWwC1f2v8MyqSefCzi84y5x3zrUtMN+GQXu
         G0tHBUqV6bTJeB/7lLO5dkMWGxFBgcktcYYOvWfdJNVNogINoGyJ/t8+uSPhwhWCse8n
         RHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772579606; x=1773184406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8KtFE0Nb5deqO3dx81aXqQ7xHlLbFlqGSS/uoQKdTQ=;
        b=Kuj+RyCfVBupGnM/G0d/cQdxFHpz8DAL0N/7gL00D47mTU/WXUzwZ1FlbuA3kHscSn
         W2NM4qG+9NYEIdKNcXtCjDAo+2PtkIPFf3RXeg+J9Ff2DvuLSbrEgjUpU9SRL3aO6u1z
         /y45YASnC662HDpn2zvZy0jwMd3AhptDt2+HJ8hQrPpH0MChq7SZTMHeSqb6S4tznqYM
         IDmR/6N0QYVJpWN/Y43vur3IEKkmSuC0lpblA1e4duu7Yh0gr0P2o/UojUdhnuDMhGB4
         3swNUo4SzT8kYcdoimqqn7waEfFelufoo/amSfoBvbirdnidp7jR5tjRaEnchP2kaK/K
         u67g==
X-Forwarded-Encrypted: i=1; AJvYcCV38AfpBHi81aYGk1dPfPfGUjQd+WPqWofmKmqivua2cIlOb05Ff+lWRVjJCzo/icSySNOGjt7vR9FTVJVW@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFmlHmECpDzn9AZajwsIliPCa92aFq78mSuVlNuEVSUXsbX1b
	eCQTQbt5XFBpZLEb69yaoI+NH3Lf4FJ7lgpC2lNI+ucF+VfJ+oSSzeWRawwA16VrY2Cde5lf/Te
	ZfZk1NPzukE2G9blnYKd2UuhlSOlci2Y=
X-Gm-Gg: ATEYQzxPV+i1Wcvf2gzLRPgTglsG0h2d72Etc3U3IfWmXONl51ebWQesG65D/KNO0ut
	VnEBzRJKk4V2y/2BWMHsX7KPnNHBmQE4LLUHHAInZO/+13YdPVK1K4h5KI/AT+JBzQn3kODp6j8
	n9yNiTMjzreYWCBNNvQb3ZUkxLJ4LYBUgIx8jArMnD57k/Y0zkKs4RkHBhxagnfNvqtXRHAtwK3
	n6oiCcgf5ClzodIwdkUKfIZOli7yybqFKkiin/th8VBDsXkRqKDWWxEYr8GDkkP6it2q4Uun+f9
	ZXt5uA==
X-Received: by 2002:ac8:5a10:0:b0:501:3d11:18cb with SMTP id
 d75a77b69052e-508db413ae5mr1156971cf.73.1772579606040; Tue, 03 Mar 2026
 15:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box> <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box> <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com> <20260303050614.GO13829@frogsfrogsfrogs>
 <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>
In-Reply-To: <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Mar 2026 15:13:15 -0800
X-Gm-Features: AaiRm50hz9HLQsc-KhPuOQysOm6sFAhR36yX5Wi7Uvb5VlqywTlPx9IMHa_D6EI
Message-ID: <CAJnrk1bVfeHhdFC_8tpzffKGXtSeGN4GKEtV173D+AymT5uk=w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Horst Birthelmer <horst@birthelmer.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 035E21F84CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79293-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 2:03=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 3 Mar 2026 at 06:06, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> > >
> > > On 3/2/26 19:56, Joanne Koong wrote:
>
> > > > The overhead for the server to fetch the attributes may be nontrivi=
al
> > > > (eg may require stat()). I really don't think we can assume the dat=
a
> > > > is locally cached somewhere. Why always compound the getattr to the
> > > > open instead of only compounding the getattr when the attributes ar=
e
> > > > actually invalid?
> > > >
> > > > But maybe I'm wrong here and this is the preferable way of doing it=
.
> > > > Miklos, could you provide your input on this?
>
> Yes, it makes sense to refresh attributes only when necessary.
>
> > I wonder, since O_APPEND writes supposedly reposition the file position
> > to i_size before every write, can we enlarge the write reply so that th=
e
> > fuse server could tell the client what i_size is supposed to be after
> > every write?  Or perhaps add a notification so a network filesystem
> > could try to keep the kernel uptodate after another node appends to a
> > file?
>
> This can be done with FUSE_NOTIFY_INVAL_INODE.
>
> Still racy.  If need to have perfect O_APPEND semantics,
> FOPEN_DIRECT_IO is currently the only option.

I think FOPEN_DIRECT_IO also uses the stale file size. eg
write_iter()
   fuse_file_write_iter()
      fuse_direct_write_iter()
         generic_write_checks()
            generic_write_checks_count()

which does

        if (iocb->ki_flags & IOCB_APPEND)
                iocb->ki_pos =3D i_size_read(inode);

and uses the locally cached (and stale) i_size.

I think right now the only option is for the fuse server to just
handle append semantics itself if it detects the O_APPEND flag in the
write request and just ignore the kernel-provided offset (assuming the
distributed backend synchronizes access amongst multiple clients). Or
return -ESTALE to open() if it detects the file size is stale, which
will trigger a lookup to fetch the latest attributes.

Thanks,
Joanne

>
> It would be nice to have some sort of delegation/lease mechanism in
> the fuse protocol to allow caching when remote is not modifying (which
> is the common case usually) but force uncached I/O when there's
> concurrent modification.
>
> Thanks,
> Miklos

