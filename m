Return-Path: <linux-fsdevel+bounces-74608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO8kFFJ7cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:08:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CB05298A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B82AA70A14C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5941322B;
	Tue, 20 Jan 2026 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY1kUPq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C13BC4C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905901; cv=pass; b=etUObwyIJXlj13Mk+cQHpFK/saTU3HqMd3rDvvGrgog5niPbw/17uRddeJwSDNNCuCb7Lnm2U5Abl9CatWE/LSSCiUa+BcVk8mPt5skqg+5U76cQkizOjB7V54eh5FErANpoNkaU/mhtxPAScGTzSq6a3bvGNgphDgujK0YQXKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905901; c=relaxed/simple;
	bh=w2/EAq/4OyBANmitDgSVevKoGP5laqy9KWGVq246aQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIYjOaVC9Md8dE+UnNGiCbotnyABVQ3h03dJt+6erTxNTgZO2kX8hLXDvmlRUobvfepQUAsNh34KBYfS6WZGrb7dZKnRuGSZcIdJeLSupBKHFrw/2GJfUB2WaBQxqxpN2IUziliLDuj+tYHhuTcNNKP053bLcF47vEuNfSH9IN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY1kUPq0; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so10945833a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 02:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768905898; cv=none;
        d=google.com; s=arc-20240605;
        b=kO1r77SR8gmklvnLTr+fK9VqkJaxgJ6hml906CyHPV4FMsbGiin4VwsNPfC7oaU6M3
         6IyAuiIJH1FhWYn64plWqkPEA+mxIiSY3nADhAF8qCD3t70frbPjIxFtLNr345wQbCfT
         zcqtZnLVNpkJcHeDbPcwT74cKxANf/10hXDVNmyD1b6tvwe8de9XZgB7AWAtEj0l/QGi
         fySQDwOdwxnfN23JCmbGnIi+V5+f+TDhkgiZygzIjZ1H9410T/U921V1PFb4ZY0m6ZSM
         GZfxEWC7PkJylO4sD4kJE3oRMK5/A0uBjn82Jw/Ur7UiU4FBFtWwUS+8ufQXU70hgjWt
         6Q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OwRTrwEso+M8NTOmlvO3zKhquLQ21XQC9QMNo469oHo=;
        fh=XHzW5ACC9LcIB/JZv8aJA6SRY/oJCdkxeO+hg3F96FU=;
        b=A3Rp/DTj0IcjF9z82rdfryKAliwpbfuJpdqJYcshxh6keI3mjh8RpTb1v8azNvfF06
         DH8/M9YUvSclyz6+ngWKFDMUpzt/Thg7B2zymHteK/GQg/IMkyjuMDLhXF2nkZjGIKlp
         DppIg1Wli+6mKbBkFaHEBSfvFpehFHxPB05TAmiRYT6FiHTlH/ANkCJtNRr6vdcZpNL1
         +oC2ntbD2L1QPuoNKZj7KWp6aPiR/OCsNG77R37Cn5n3qIDJys1XfDBI4gDQ7dWeUjsE
         rNzT2tnq429aym27Rpz7h/RgqpR20IIxfk7t0XNbWx6cS+l37SG38WfBHTzk5eDlJq3R
         WcVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768905898; x=1769510698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwRTrwEso+M8NTOmlvO3zKhquLQ21XQC9QMNo469oHo=;
        b=TY1kUPq0+piIlCb51CmdDS0lGsy6q1wt/1rxFri4zV2EOifSlHauSxTEUH3EcW3pzA
         XZiYQhLP5g9+2Texvz6XnnYMq9wIa3SOinfjloWcztdhzOqczjwsf0Slm7u3a/fLCVih
         YkntuXTsm8Arz3CPlweCbidlHm/DNV9ln76ONYMNGD79sIOVGtSLSlR2W/xaQAg8uOA3
         NTdfDOlC91nzw3sMrmlUTpe8sNIuwB87mGAhV5QVqJitp9Zw3FWu75kmP1Jam7kRUjet
         xU25cLOGIlVC4++jIQ1Opo1KsUiWIUswlEU1rh0vWBNjg7h1dMcsrfZhb/mHWGkeGvLA
         5x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905898; x=1769510698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwRTrwEso+M8NTOmlvO3zKhquLQ21XQC9QMNo469oHo=;
        b=jQJLDRepOn7MhElTfV20PzgobBef7jA3FoNaa+EGd7J8iruntQ+LYSQGn2bisnM8J7
         qtHOeRFsdoOJ/Pon3dOzxkDXkqGDhYvJiEI/62j6jXcnrfCip7K+cCIss8NK45e1Ouhh
         Y4FJELsVewIF4h38scRyYA8RBPi/U2W0AiIAPGjOVZOvvjghm8ZNADMszbZiMNZyrweq
         ngLIr3Q1YY/ZVBsb1JgqLfqDOFz/kxu2sL/fepVcpNbT/MW1ei19vjaMJIALUI9Iv6xO
         Cc1kHtJ3k7+N4Bcxmd/FFqVEYqiUz3kub6PddXXDABJ/wSGvf85t4ceYME4bfc6QSasZ
         aASw==
X-Forwarded-Encrypted: i=1; AJvYcCXY6mPU3G6CGuhQKZKGpaW4jGdrBj3E4ajYCrEtMKvB/HhQvU1ACuD45CYLoFQviWpPpYRQJqC5EN/GCaro@vger.kernel.org
X-Gm-Message-State: AOJu0YxvTSSjd5AqzdwsLFG34fRTkmRZ9xCaV/nPcagubzWvDSFSeCuW
	lDa+eeUI6SLNCsLQLPDboCLQVjyuZaO0lPI31Rr24rGeV9wnqavbCZHAmGsUJ2M+gs9u45o7Ek0
	ry3LYtOajnqyGoPsAyKc7Gk0xT8nhVII=
X-Gm-Gg: AY/fxX40BufwUjnv7MoCtIoMaNc1vkzGVTdE7oct7xhHvqD1KlmwHg2hk4FU5kRb4+G
	8fzxtivMC/4hAYQlrsnhZ6daU01HOSKKQLMmu+ejetAd/MLAKb+tqRxQ3i0YLJE2I/2HU/A8I+g
	la52lZpuh2Ji9BF8r+nL6OZzUe/Dg/QVBJGTGRwDIQ6a6jnaIUpdGH0eCN2zw/p1G8NsgUvNR+K
	G38FM4471oIZMlgpe8qTStkA3Qe3BlfvipqRA53bM5PvWsO7WPiNi4PsLyxIEad4szrpwkkCTw5
	hrlucsYfhKh/H1/hUeHonjieqa8=
X-Received: by 2002:a17:907:bb49:b0:b87:cf3f:1a39 with SMTP id
 a640c23a62f3a-b87cf3f2646mr588047866b.25.1768905897858; Tue, 20 Jan 2026
 02:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
 <CAGudoHEej7_Q-nkJqBU8Md15ESVtyxZ9Wbq9zwyUEcfT034=xg@mail.gmail.com>
 <20260120-teilhaben-kruste-b947256ed6ab@brauner> <CAGudoHEGUDaToxwhsFHT1vB7Q66-H2UMNpX8KTj-dcEZy4Hz3g@mail.gmail.com>
 <20260120-abladen-batterie-40fe1a4652be@brauner>
In-Reply-To: <20260120-abladen-batterie-40fe1a4652be@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 20 Jan 2026 11:44:46 +0100
X-Gm-Features: AZwV_QiroORiwQ9XbhpSeW-_xWcK_KNTnNGnzquPUcesiEpMlsEYstwvWaOqBHw
Message-ID: <CAGudoHEuos4FdR+ucG7hRWwa8qnD2qaUezZOcb1G6gHX8DcwYw@mail.gmail.com>
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74608-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B8CB05298A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:14=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Jan 20, 2026 at 10:56:40AM +0100, Mateusz Guzik wrote:
> > On Tue, Jan 20, 2026 at 9:17=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, Jan 19, 2026 at 09:51:30PM +0100, Mateusz Guzik wrote:
> > > > Longer term someone(tm) will need to implement lockless alloc_pid (=
in
> > > > the fast path anyway).
> > > >
> > > > In order to facilitate that the pidfs thing needs to get its own
> > > > synchronisation. To my understanding rhashtable covers its own lock=
ing
> > > > just fine, so the thing left to handle is ino allocation.
> > >
> > > I'm very confused why inode allocation would matter. Inode allocation
> > > for pidfs is literally just a plain increment. IOW, it's not using an=
y
> > > atomic at all. So that can happen under pidmap_lock without any issue
> > > and I don't see the need to change to any complex per-cpu allocation
> > > mechanism for this.
> >
> > I am not saying this bit poses a problem as is. I am saying down the
> > road pid allocation will need to be reworked to operate locklessly (or
> > worst case with fine-grained locking) in which case the the pid ino
> > thing wont be able to rely on the pidmap lock.
> >
> > It is easy to sort out as is, so I think it should be sorted out while
> > pidfs support is being patched.
>
> I don't have time for that but I will move pidfs out of pidmap_lock
> completely.
>
> > The nice practical thing about unique 64 bit ids is that you can
> > afford to not free them when no longer used as it is considered
> > unrealistic for the counter to overflow in the lifetime of the box.
>
> I'm still confused what this has to do with pidfd inodes.

the thing is only maintained by pidfd

>
> >
> > Making it scalable is a well known problem with simple approaches and
> > the kernel is already doing something of the sort for 32-bit inos in
> > get_next_ino(). If anything I'm surprised the kernel does not provide
>
> include/linux/cookie.h
>
> is what you want.
>
> > a generic mechanism for 64 bits (at least I failed to find out and
> > when I asked around people could not point me at one either). Getting
> > this done for 64 bit is a matter of implementing a nearly identical
> > routine, except with 64-bit types and with overflow check removed.
> >
> > However, the real compliant about this patch is the re-introduced
> > double acquire of pidmap_lock.
>
> That's easy to sort out:
>
>  fs/pidfs.c   |  4 +++-
>  kernel/pid.c | 13 ++++++-------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index e97931249ba2..ccfab23451b1 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -138,6 +138,7 @@ void pidfs_prepare_pid(struct pid *pid)
>                 pidfs_ino_nr +=3D 2;
>
>         pid->ino =3D pidfs_ino_nr;
> +       pid->pidfs_hash.next =3D NULL;
>         pid->stashed =3D NULL;
>         pid->attr =3D NULL;
>         pidfs_ino_nr++;
> @@ -145,7 +146,8 @@ void pidfs_prepare_pid(struct pid *pid)
>
>  /*
>   * Insert pid into the pidfs hashtable.
> + * @pid: pid to add
> + *
>   * Returns 0 on success, negative error on failure.
>   */
>  int pidfs_add_pid(struct pid *pid)
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 7da2c3e8f79c..e68700de3339 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -313,14 +313,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_=
t *arg_set_tid,
>         retval =3D -ENOMEM;
>         if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
>                 goto out_free;
> -       pidfs_prepare_pid(pid);
> -       spin_unlock(&pidmap_lock);
>
> -       retval =3D pidfs_add_pid(pid);
> -       if (retval)
> -               goto out_free_idr;
> +       pidfs_prepare_pid(pid);
>
> -       spin_lock(&pidmap_lock);
>         for (upid =3D pid->numbers + ns->level; upid >=3D pid->numbers; -=
-upid) {
>                 /* Make the PID visible to find_pid_ns. */
>                 idr_replace(&upid->ns->idr, pid, upid->nr);
> @@ -330,11 +325,15 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid=
_t *arg_set_tid,
>         idr_preload_end();
>         ns_ref_active_get(ns);
>
> +       if (pidfs_add_pid(pid)) {
> +               free_pid(pid);
> +               pid =3D ERR_PTR(-ENOMEM);
> +       }
> +
>         return pid;
>
>  out_free:
>         spin_unlock(&pidmap_lock);
> -out_free_idr:
>         idr_preload_end();
>
>         spin_lock(&pidmap_lock);

I can't review the entirety of pidfs interaction, performance-wise
this looks fine to me.

I booted the combination of both patches and got the expected win of
bumping the rate to over 700K ops/s when messing with threads. So the
approach has my stamp of approval.

