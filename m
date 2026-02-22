Return-Path: <linux-fsdevel+bounces-77872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOWYN58Qm2lArgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 15:20:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2E16F536
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79AB301F9FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA773502AC;
	Sun, 22 Feb 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nx8KjheQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFB34FF48
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769985; cv=pass; b=aujTMlqBfn9fBpgPoxAEKT1+QuwpjLjrsVDkyeMZVoeAmpWSbhPMFqLyojOiyw2kTu+k6L95SZWFJTAPP/Ox1pIeF/vq+Po8tf5F56W/lY1ZT2onIKqrebkRuCZTZatLFzd0EZn1QiZKoCmcA9TzeFgbHRY+66b46OjVNC3m2VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769985; c=relaxed/simple;
	bh=ln+l2+kKkFDBmSOGuUA2y37XlX40B6GZOr01SweZv58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+j90i9R3kwBGK8rk3UIOTNTcAj3l32EkB5dwXZWR1l6wuI/uNfPq7O1fmID5VGy6MaWDjlF5N/UbZ/wilxJucpUMq+pjRmMx64nDsHXqrpcmqxEgzpyLLDXajQ0bG2wQ9KnUtThk3oe1yOw6J3AJ+MlHchebkfidFlxNMCteZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nx8KjheQ; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1820204b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 06:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771769982; cv=none;
        d=google.com; s=arc-20240605;
        b=Rp6Brpl/39R6bHM/VI4CMSOJK0dMMTEPMZyCqNSaOIjeL9Lpg+Sk7RPm90hI448FO0
         WItctbYrkjgAtdNSE28aXB92LbH4lCTHa50XUHspJSC36PF+Z2kQMJmkmnIzBtlxqHtJ
         jHCAo+/gWBaiQ3bytMg32y/3VnnwRN2N0OBupnHdCTUP4vQaQjUBFM+FXQuaNRin2MDi
         QQSzNZfVQOLC01IT8vfNaWiUHjUl92imf0TbLU0RMeZlDPdAyEbhJHluQH4XiA/648YB
         T0C8JnUecVE7ckb5sOG6XVRt5L2aDJUuGiVZcsne58BQIhTtGjwd0D3LNpJ1kHEic7kI
         DuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        fh=LzBmOhPFI4Y1DOkOn34/9Z1Af7xGL5TqG0RUOZ9u27Y=;
        b=LmnYhF7d5cbi0uqSUb5taK0OODrdvJb91yx+cghfy9Cg81Cx7cAcTS9EHpIEpxQTBh
         B0kLUzRli3yJqdgtaLo73x85HMgIPw+LoMoO+8HXIdx/fJjrMLTH/3rZn2lP++1U/obG
         Mc0PTOY6EiAopC398vN23X2tjJ4Sn0uZx/oFjwN/1EsgDxq8k4YFTFcZ1cliVxMYPzQU
         U9nEG+z0dD8aDpfmuae8lrLdyfYKBul4fH/fdawyyoPm4YK5S9O+WFJD/kRLS7UZS8kg
         KOEahrK+z49orWrYcy2Nua7/IHFx8SBJclSR1+Hk4jdxXuTXNge6MOIgO0cgtR9mZQ37
         uUJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771769982; x=1772374782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=Nx8KjheQqYFoKeSsWjSjDkljl7DeLxDbijMH0TCbUekr4yIocKBCavivrkgn95uFed
         XuSYjq8Pcd+5CapXKZGXMujHyPS8CM2XMsK1VFq/NEU9BlgNRr0AX30vP4yE32dv7A5Y
         Hbv2Gia3NHVN7Dbg7SLniPYX1r0AX1nZqO/QynXl0UmultKmwbPnGnBn1UVWQBCgarfe
         8XAXggaIceD/wiAeYgSlFc6fVQeagqwn9JRq9mELPGKgvBWXjAAEHwqVz4J9E4ZYYqaN
         3M/u7GK2xgYQYx/5yhpHJ3oZznFZe7PrOTMXiMph7pHCPiT63E99Qjf7j/+JE40HxrtR
         KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771769982; x=1772374782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=IVxDemUp2kxhvTSqs1a+zp3mbPBrxjn99ee2BHD/4Gj9H46V0jjB9lDQzJ5H45Abmw
         QnT2rJKYiYrpBl1pRmhzI7Dg8Zw116KJZ9W9Pt/OLFkSlQjsy8bb81EPC3crVg2IzMXb
         8QnusFnJa45O7okuKBComHJJkJ/piF1/BmVMyA9p2P8cNh3HAgcQY70CvSoIXYGz4ian
         B1vuycNq8sHn1JwKSOe7epj0QkYlep4s35BKXwonsJzRBS2Hkjec9/yyn6kr05zyVUZO
         2GmBqZSGYuBXnhnFZl4uSmn9tNDhIegrJCEzyLPiVvS1LyOj5WThyoqqqCXrmd0IrDPA
         KWLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5bWjtVRJCeUSHNNtjiQhrKZtMNCY2/1uY2J5+F39tL0K7H1Dezvra+8reyqk+42CusdeTszXf3oQpHW1l@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6VgzkMgIKeALY/0yC3j0ge9LCCC8VObEn7vD7gyg0IimOpuz
	r1C9cCyF4oJ2IexWDKDJiUPTsSCVdxc48fy3+gNLlmSyrwGAkzjgM1KId/enLmfDrL+cFaYo4eR
	VIG4hhDJ1G5yWeBqbVtciHmKL0S3tE9zuoTvQnlLX
X-Gm-Gg: AZuq6aJt/yWyfCq1ayp2EnegwHeG6Qk4jPKbk3RVsHLJvd6NdkHzb4glZBHdvjCTtOf
	OdzyMNFKToxYyut6ev1Kuev/VW6LizG2286iFJHfKpbOp3CZahN2Umhycv8Hw5y41S9zSHr5zk+
	zvFlNAZCC/GdOn73LiXSSbHryyjoElwdaBCXQOX8dlaUW8eDetJ5o/Nyb7sWGmNA3xoACBKyeyB
	z+7kudbkvw8OjqELcLloIAFmQsrqTREWzx6uI2AMc+rvrrz0VDGUHbIfv7y36pQWlGyEmLHCToL
	h/PReF0=
X-Received: by 2002:a05:6a21:6003:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39545ed5054mr4712151637.27.1771769982592; Sun, 22 Feb 2026
 06:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com> <177171292163.8396.10671162503209732019@noble.neil.brown.name>
In-Reply-To: <177171292163.8396.10671162503209732019@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 09:19:30 -0500
X-Gm-Features: AaiRm50aSxTeiNBHciBrrBXQYNf54mJgxuioR2fz7pTB6PQcKrI6Gq_TY-UauFU
Message-ID: <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77872-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AE2E16F536
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 5:28=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
> On Sat, 21 Feb 2026, Paul Moore wrote:
> > On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Instead of explicitly locking the parent and performing a lookup in
> > > selinux, use simple_start_creating(), and then use
> > > simple_done_creating() to unlock.
> > >
> > > This extends the region that the directory is locked for, and also
> > > performs a lookup.
> > > The lock extension is of no real consequence.
> > > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > > d_make_persistent() is called the dentry will already be hashed.
> > > d_make_persistent() handles this case.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  security/selinux/selinuxfs.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > Unless I'm missing something, there is no reason why I couldn't take
> > just this patch into the SELinux tree once the merge window closes,
> > yes?
>
> Yes - but ...
>
> Once this series lands (hopefully soon - I will resend after -rc1 is
> out) I have another batch which depends on the new start_creating etc
> API being used everywhere ...

Okay, thanks for letting me know.  I was curious about something like
that based on the cover letter, but the timing wasn't clear.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

