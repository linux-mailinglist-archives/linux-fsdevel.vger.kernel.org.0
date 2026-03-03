Return-Path: <linux-fsdevel+bounces-79216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK73CSDhpmkPYQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:24:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0591F025C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E1B930F9CDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FC34C9A3;
	Tue,  3 Mar 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQRj1im8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D827E1DC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543944; cv=pass; b=Rog5BRBTJS2hp6L7dpU0yMSR8eaFpvY9+XKJm7RmvJSGuz914IQjgcM/w2jxVlecHtcNPF3+Z+Y7DnRrlNk3u1s/QVeRpJ0fCnMOMvRN8cGv94XXsWbnSMU/xIAekZL+N4i9KYvIRADzNDaTnxxEsswWi61SFMJemXWgeKOqbUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543944; c=relaxed/simple;
	bh=gClzx2r54dD9p1O3EtTde2ZDg7i/3NSLLontuKre6yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyhixZZkn51WyDP4s9TKbNw6XRD5rzhh+lV99mAAtZAz1o+udCzQZYT4Y93OUYZDnY9qAlmMyahKZ5rKdW8HtWIfsep66PDwEHIBZUkCQy3PRw5+OmPUPPZ55BOn49oFlR3SEo7ekvl5GfdZcJvcKYpmx3uPlyYFQ6ilmA91zqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQRj1im8; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b936331787bso910805066b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 05:19:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772543941; cv=none;
        d=google.com; s=arc-20240605;
        b=Bqcpk2NmlfOr4V6YtzQZk0Ojsw/PVm/uknj+Rygmr8sQA46SSogDiXqOyPX5Z/7yJN
         2WdekL+45QPgvWpfgndQbuzDc9vfapjCE0J+faT6etWoB5IGm/9nAGJq7EYLJrQlq1PV
         PY+yWum7nnn1jFYB0gI+FYjPiD95sOD02cbzPatVZ93vmfQZ0G/AGslWfZw3KbHQaE64
         NHYRtjs2vUywOPaICNvYCadZyS7vx/+CCUF82EDtj9DT7JgDXxunurkAyP+9/PjEj5Io
         2M9ys0j2uUXbDyp+6/mRTpa/uuTOCPfroD2iybcxxfLLHjRZitM7OhCR7spAtf1JNfb2
         KLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4pWgvtu/WjdSJ5LGxlyfWC/qFVI7hNkw25HXqvKiE6I=;
        fh=vwNe8XLeE+DeP2Yr4Th8GKpKnNXyhlnvdYexdEAjN4U=;
        b=FYuRsiN+vBbPKID+Lv23nOykLzqkUgSoULG1oIrC3q+HdXQ0BN1E7ZQQzqlWgs+J0G
         6OqUn9E+iEPReG2oS6A1i0kmwNtlyfrcsylkPZAfJx7vNiK5W683SHf0Bb8YMq1AmH+z
         I9kzmjuEbb3Yukog3oJVg8L5jfsF6WOMH8SFb/olVLJdSmQCdRLS+hwRedOhUUEWbSUH
         Fc0ECDYTFfYJugvU7FWUKwxgFO9MH0si5r+rd6b44RYw9kHJOZd7I0XCf+MwSe7NlZuP
         cSjvDRfxGxtmg+aehfVyJDfwu9hvn++pKU2cH6qKoDTvAYJX3mzFGvfztpg6ttQmYHQQ
         tE5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772543941; x=1773148741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pWgvtu/WjdSJ5LGxlyfWC/qFVI7hNkw25HXqvKiE6I=;
        b=HQRj1im80XK2Se2YBzqys/snwRHj/R3np/ltWtSOx4IaHx4XiOSjN67IAQrxE/uhBI
         aYNvO08sNZrheua7kTtULK0s9UTQmhG025A1kamHqfUUyVc7gPTHvZ4pJQaGhEu8BLdk
         QWK5So/y9OQygPAgpQ0T/myPoKuy+yrRYTI5ZGcKcoB+0WSmDn1L7SX6o8Qf2p9UI2wL
         VgvWy9aPzfM4IrrGsbriy9Pfnd0oMgpNhCCJ1mN25RZuWuFhkpnFgDYn7UEYgaCKSpir
         WEN8d/5P6lC5UCz+SujKa8EPCNRsIBsew7Mztlxtz5UrYkp/x57lMljngh4BqlC7X3Az
         TwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543941; x=1773148741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pWgvtu/WjdSJ5LGxlyfWC/qFVI7hNkw25HXqvKiE6I=;
        b=Y7JTYuHpxpOH5LE2oNFzJ1tegyKBcCAmXx6mVm+7aRx7WYMWZA/1eUW0+p+0EF/pHW
         igwFMxPAAVcg0OLwJ30X++5WHOJp9tA3AFkNuWaqB9sU56Wzi+WpDghHWQrEpDcLcl0C
         fevPBeeG/JUaWjI5dFmC81F0xOJC7vgWj2qoUPWnQN8RHIcsKlK4BTQjVzFpWvJuEmSq
         HVsQgmQNtOPdgDeZVAIIJsSNPAXvGcV32Ytv/0xjM0vv7ETNobnXuqvksRdZPADTyHwI
         18+cvtf54as7jRf4IHELsVj9bkLy1dYt2ArWA218x4YPML/D1a7NwYaQ4eDMhSM1+KCb
         h7kA==
X-Forwarded-Encrypted: i=1; AJvYcCUWmEVn/sjEjZMV/YMOjM60EVbt/PppzCtX8XudxxziG7f6ACsQ0NOo1iGzqoMixcNIcI4DwakXcjyrn8Du@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsKwrX1ldWwYJ6T0LXJegESJjocqyDGQIu/ZHFvvH8C0NrmEx
	7glIZr4/KKclYM3VqF4lQELUJ77lziw3AfWj5v/7R1W/8P+Pg1U1kTShoUPXIylaXW+4TyC3n4u
	1GvAm84W+O4jjzvrkzscCyZckxhwWdWE=
X-Gm-Gg: ATEYQzyWNeolW2g1ehxg18LdQqUnSxgv9Qq+5nHi+gVnxhnOZ72HlssDuyaOVrVOg7L
	rCyruFw3myk2IYsbRiUkmSoe/r5I8AzYBJM1IjYZ6n67dkmMlAz1evR/g5OdrInuhlaKs3oTcn2
	hXD+cGeII04sRaVGe83+4oUz4q1FmHdYTCbJJhJPel3GGZcxR4S3sPk+gb/pd5tf/V6JVgIEmk3
	NY2I4ID2P8+/OybsOgZSk2OAyfR8Yo5EHorBcif0Sfz1tOqAmCsPlreUSqQGxupVPwPohGUnrYn
	3/lplfmnQWHztZo6apvUiQ+sBWijgliXIkg2FGMVOg==
X-Received: by 2002:a17:907:1c86:b0:b8f:ccab:a344 with SMTP id
 a640c23a62f3a-b937c69ae85mr902415066b.14.1772543940337; Tue, 03 Mar 2026
 05:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302183741.1308767-1-amir73il@gmail.com> <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
In-Reply-To: <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 14:18:47 +0100
X-Gm-Features: AaiRm510Na4Ds7gEYJZvlrcEh8J7Ee5XVcLWFZUN4TBC1qPcM42G3y-TXtuzEpk
Message-ID: <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsnotify hooks consolidation
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7D0591F025C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79216-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2026-03-02 at 19:37 +0100, Amir Goldstein wrote:
> > Jan,
> >
> > I've found this opportunity to reduce the amount of sprinkled
> > fsnotify hooks.
> >
> > There are still a few fsnotify hooks sprinkled in some pseudo fs,
> > but all those removed by this series are obvious boiler plate code
> > and for most of these fs, this removes all of the custom hooks.
> >
> > I could send a series to convert each fs with its own patch,
> > but to me that seems a bit unnecessary.
> >
> > WDYT?
> > Amir.
> >
> > Amir Goldstein (2):
> >   fsnotify: make fsnotify_create() agnostic to file/dir
> >   fs: use simple_end_creating helper to consolidate fsnotify hooks
> >
> >  drivers/android/binder/rust_binderfs.c | 11 +++--------
> >  drivers/android/binderfs.c             | 10 +++-------
> >  fs/debugfs/inode.c                     |  5 +----
> >  fs/libfs.c                             | 14 ++++++++++++++
> >  fs/nfsd/nfsctl.c                       | 11 +++--------
> >  fs/tracefs/event_inode.c               |  2 --
> >  fs/tracefs/inode.c                     |  5 +----
> >  include/linux/fs.h                     |  1 +
> >  include/linux/fsnotify.h               |  8 +++++++-
> >  net/sunrpc/rpc_pipe.c                  | 10 +++-------
> >  10 files changed, 36 insertions(+), 41 deletions(-)
>
> Conceptually, this all seems fine.
>
> My only gripe is that there is nothing mnemonic about the names
> simple_done_creating() and simple_end_creating(). Since the only
> difference are the notification bits, maybe
> simple_done_creating_notify() is a better name?

I will go with simple_end_creating_notify() because what it does is:

void simple_end_creating_notify(struct dentry *child)
{
        fsnotify_create(child->d_parent->d_inode, child);
        end_creating(child);
}

>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks,
Amir.

