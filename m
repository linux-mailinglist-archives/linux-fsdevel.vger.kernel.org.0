Return-Path: <linux-fsdevel+bounces-79132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAT3NUeypmn9SgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:04:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 518EA1EC4CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E72863069D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021A438C2C2;
	Tue,  3 Mar 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H1utAUfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E63090C4
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532208; cv=pass; b=kVcMwpl7CEVVxB0k3BP6409vhKWF9xyb1DyiIyypJm2NoVJfqg7KJGkuxVuruhVugGoEJXx8GlibI3dFJVvKWSJfKgzAV0MQag7oeN7oDV8aq82FF3c5mmBtZ+HDgkJE4w32bR0c/tbW0PYwxSUwUSi7/4XsId50SfdKRKgxuss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532208; c=relaxed/simple;
	bh=bJddSQHV3cmyNBdgCt0Tpkb51xqy29f3L8nYqaygHjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eztqlVGyIZxGKpZCrOk8I2/rgu7D8F1NU0LgH1nNn/8aiBTv0UkAFBy/X6u47cTHz76sOxJN4qVw0GrENxm4lUHEInCBL/7XpUm4llZCz4U5Rd+/N6/6xwDGDowVEITl4Yy7v/d/J/y0cstObVnPrYqatG/D2wB4Dg/aRcAJJUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H1utAUfO; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-503347e8715so68457971cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 02:03:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532205; cv=none;
        d=google.com; s=arc-20240605;
        b=G7BP1u9Ny5WzlVfI8FMPJDm9pK1MYEJIav9cedDLXeDexqRhOtHr7BeGjC9xyjAP4D
         omq6ASRlQZhnc2w16fH8YbpiV1de8HkGgdhDp052z6VX5BlOSBURgHAPpRLk9o1YvWu4
         PAuw2LttIH6BIa7oS/BEGTAUEtSDigqvIADoGneho5/ipqJuJIwtr4buXRfIg6hZmTjS
         7MNj8jt1nljItTXKwA9IgVHWZDUquj8X1JD5gycohT9RIphvn64485esoAEPRvyaqHco
         5BLQ4xDLtFhW9IRgKNs9tqLiVrPq6dIeqXYEUStKp/x7im1dqqC8NLBHNc7YOeZD1hb7
         jHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fqKbdCQ8+UdKoJi5n0ECG0VzPITc4UXTWZmmaN0BCgc=;
        fh=KqpBzQ/sAAVGQw/2nXUtRoEDCNKv0AaBh54I64ng1Ds=;
        b=Et6KwE/0wOdrTums6Tggk3Z8vwt3HpW9Nq1sk1SftgafLjCNVssw0/ozxCerJPGVg/
         VYiC4AJFass9LxXQ00eMjR1gC7kAiUrc0VwyfYd88lVsphN/fkXRDtIGWbebQwIaBkzv
         Hkg3u5rh9s3Zh7Zxmx2538f0eG2h2snkdeGOlYPCUFDpPQz46DoLIDHhIpqTRDCZJIIW
         aaYXbrE912koR1vPt3apug8+v4SlO4NQpf9JF3UGPu384/7oma9ALEv83jKdsjlcXLAb
         K7pRN0m+JN1i47UQlEpFiz4KnbehwW4Zqz6FKm0T8144w7nE+lK8EZNh4kxXKAJgOXQp
         yeOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772532205; x=1773137005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fqKbdCQ8+UdKoJi5n0ECG0VzPITc4UXTWZmmaN0BCgc=;
        b=H1utAUfOOaJbfkTBUFkEA/XPLiGclh/XLpjtrkQGQkmYWZSZYJgouIJnTjfV8BkqWR
         /lA8xRrkaauodyihK+JewMqJZnW0d7lO2A1KYl03b+nnH5IuBwlSvy3wBdYqA8ZTxUok
         OeQD+Vy7kVpFF8ueUrEbBNhz0NwGRjSZBRp40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532205; x=1773137005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqKbdCQ8+UdKoJi5n0ECG0VzPITc4UXTWZmmaN0BCgc=;
        b=tneRTMLlS2Hg4RKXJVuGt1B4jmzUloDugfME6aZkAU/uNWjqX4uAyNBaRlF9iTLkdZ
         ABhNIBYhgjh2aInWPIHO2YRQ3hSB1dcj/D1CupFCRH5x7cNza8pbArTcxwNzPVQai4mx
         SeiM87pRX5jdTvvMlkMN7wnLjW15JmHH2vMauomaqGF/sWjY4H+8xHJ4M9HM0Knz3uMH
         fcVNOhsw5hPRbpm/3dI0sOF1p8s8TTbapvR+yoOpflbNAQd9TFuAtMidqELJhUMZ5Ay4
         /CtpuzxO7KbtJX2k1WUSFPou8H4nO3AaVjdOXp844UjZHYpdr1HvWnfteLlUrBTEWt8r
         ZYIg==
X-Forwarded-Encrypted: i=1; AJvYcCXDDT6+Ek+D9YqRm6D7p/ye5DsiWPy/xzTkutKiN1n8F5LSFtxocXv38Flr2wi3mfXpYV1ceN6RxmviO4hf@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxYg7fr0OPtu17Lnj8+XMTWVXfCu00MCQO2YFD0xpQFbLh5tJ
	3DcYbtHK7gJjIcj2QAsKuKakaa2yflfJzh7fGIpMfhdZqpa6aMTSwbl0nhSsDhqhD8Y1J36Sdxd
	ZrQE/JxZe0ywnZKLemuN6IQvbKXdl+XC3mbyYaVueKQ==
X-Gm-Gg: ATEYQzxy62huxr0bYUux/5nB1lifd0OLRzHyKggfUc5h4UXV05FKY+O1miQNGa/oFx/
	3lzIq5ZQoxCMiG8/P0lWC9f+E3tuWht3lfAo3pN9ckhuKfsEhqPgCdlYqU3UdutEc3iyARSF8j0
	UOim83Im8pUbSd8gxer8rT9py/3iaOTes89Vq8yKeJ8x3aErTE7Q95djR0OBmmTbsa6I/8+v+h4
	bABE4kEvxQ+b1MAtOGdLcAxcpgxmTUxduFe7wOmPuwnf1fXM0v3r43y3W9CvL3aUJ6WPsBqzvBI
	BvLQGkZaCa9lOc6fk1K5
X-Received: by 2002:a05:622a:452:b0:4ee:2200:40a0 with SMTP id
 d75a77b69052e-5075273a9d3mr205817531cf.3.1772532205451; Tue, 03 Mar 2026
 02:03:25 -0800 (PST)
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
In-Reply-To: <20260303050614.GO13829@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 3 Mar 2026 11:03:14 +0100
X-Gm-Features: AaiRm53AOzV-PCcqSp2zv05xcrIQwPyzvJuFW4bCPHf-j2PJcUT7kDrZXFeMSP8
Message-ID: <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Horst Birthelmer <horst@birthelmer.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 518EA1EC4CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,birthelmer.de,birthelmer.com,igalia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-79132-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,szeredi.hu:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 at 06:06, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> >
> > On 3/2/26 19:56, Joanne Koong wrote:

> > > The overhead for the server to fetch the attributes may be nontrivial
> > > (eg may require stat()). I really don't think we can assume the data
> > > is locally cached somewhere. Why always compound the getattr to the
> > > open instead of only compounding the getattr when the attributes are
> > > actually invalid?
> > >
> > > But maybe I'm wrong here and this is the preferable way of doing it.
> > > Miklos, could you provide your input on this?

Yes, it makes sense to refresh attributes only when necessary.

> I wonder, since O_APPEND writes supposedly reposition the file position
> to i_size before every write, can we enlarge the write reply so that the
> fuse server could tell the client what i_size is supposed to be after
> every write?  Or perhaps add a notification so a network filesystem
> could try to keep the kernel uptodate after another node appends to a
> file?

This can be done with FUSE_NOTIFY_INVAL_INODE.

Still racy.  If need to have perfect O_APPEND semantics,
FOPEN_DIRECT_IO is currently the only option.

It would be nice to have some sort of delegation/lease mechanism in
the fuse protocol to allow caching when remote is not modifying (which
is the common case usually) but force uncached I/O when there's
concurrent modification.

Thanks,
Miklos

