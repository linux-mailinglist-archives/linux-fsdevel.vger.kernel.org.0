Return-Path: <linux-fsdevel+bounces-78854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGaEE+WApGliiwUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 19:09:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D671D106F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5093B300C02F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67591338596;
	Sun,  1 Mar 2026 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsItdjbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B13382C7
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388571; cv=pass; b=XvffPBPPjz6HMQLhOQr7UKJF9FNRfmKjU3CHBNy+NNY3qraOggmOr0ryUt6BqZs9VOgOmDXczuvXrtHoSqnPzyf1ChXBY6JYzNhBtC7fi4gpuk+9KxwI3/LB43ZYF0BLY9qwfzVRXN+kzYmBc8EewC4nWff91bIGyP1/kEIpJ6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388571; c=relaxed/simple;
	bh=N1gNLzn+StbNWz6kP8sL5OtfjF7Ha4k3p841ZbIbUU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks8uiv8I29LTLzpqcqoRlzCNa3rxTS/c08AIwTsz3b+G/VK5+IntK8EFZbgSLSpP52eSjCH7v6CXc3+moOPQa/ChozoM9Z1/394qf1GSN+P4cGKNupwGlSlH1dG6C4GqxuqjnFYgIF6kJECk6H72gKbBQ9z1lMrgNyfXqcrsPaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsItdjbT; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9360037cdfso526654766b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 10:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772388568; cv=none;
        d=google.com; s=arc-20240605;
        b=lGBPV9vUGZ5bmYRReYkkoQHIv7HlbPKurF7WP1Ee6W2+MMxnd2mN42r3gG4nmZOqfE
         QPudBNoKZx3aAXZhhcHmfVkbCuKugsxNzJGIAxhkdLjoMe24OoX/CKmixKFqmFXBezxm
         i38/WKMdUvpsSQBfqFMnHicWg0enk8wrAiQksGBpLTAQocaskdx8PIgdzjG9PdJZkT2L
         ZcvlmYYQwEhi21eto2L7EYaq23FHrNBWDKcvep4jXsTaXxAIXvgzYcO/o9Cvg3j7ChSG
         ffDOV97MeBzHNrYCZUNPTcDoW/AVqDaWCxHK3rWR9VVXJ16f+NLA19upd4Z5pkERIfe8
         bnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTvxzmVNL2uTdScc1N3Um8saZmQMDkCbGxh750BPDTw=;
        fh=7Hz07JxA1ER0P7sc37rPcZarDG72QGaAkfE/UPErNMY=;
        b=LY6drWZvFGKeq5FvpHL888DKPuVnSxcfcXii5o33v1voLPqt6GEfypQlmQKdL3zKjc
         wqwWvK5fZwIZy05xSypw6LRbFyB+0Oi9PtSK1T93t6a88npD6RN9eyUmxnWg3YEBcPEC
         eOj7llfkz92GFthpA9ABXF71WUbXshMRAKZzyUjDCavRBQphU/CHDCkZsLjDNWgi2ajs
         EgPlnToIkLV9QpcrZvKWVv4xiYXzSlSdG+9iEB5314FtofeuUMn6CYb2EAgpvpl7syYg
         pilq2npP28Fz5kYtIl6JACsPYkZ8S5/5TH/1MnMqUtqPjNX3wPdsL8C/D5AWKYOzW0WK
         xI6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772388568; x=1772993368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTvxzmVNL2uTdScc1N3Um8saZmQMDkCbGxh750BPDTw=;
        b=SsItdjbTx4SVEpWptDJAf5v4HtQZwFWNh4UQcJjvXD0FYM2HI6J4x1TizaGeUq/FOO
         2njLYWrnkwhEcy9i39v8w299GFz5w1Qoi1oVHPOlE2JsiKTBDJaxtHu9wR/yw51mk/Kn
         /CZQcQURKb05KQ1zwX3hIXjjbrR+6t3SLmiXrXAv5Hmc7nb5Si+XtJsPriG2/kWS3y03
         DGUfzEzCWEP9+l0u5GncxdPCLOdmPq93u1eEoKnSxVMb6VSDyHqMYmAMQpmYNwAQW5M3
         p6e0cxp22FT8uDPFO6zbq7qxG1lSILIj+ouvUTxZv0BRfv2aQsI/vF0NZlOsJieEgwub
         ogdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388568; x=1772993368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTvxzmVNL2uTdScc1N3Um8saZmQMDkCbGxh750BPDTw=;
        b=hCKf5+AVpHXgm87DZa2wtcJjZYmFfFYv8O8GWuWeQQE95p4JTWgjNpc9TP17UK71Qi
         DeARkThtSa6AW1Sojsz07GyvNDxIogHnsVw5rX/RtEiWFRqeJhh47VUugV3wuYIGkrFP
         KNd5PHovqfmd0vtS0nu3iof9YWfftlruAP1TUM3LBNZ9yyBziSevFUx7HbLty6Opq41p
         u8xST3/c70GvFLkXvIYqzRvjSGH61lTq/oDwS6bUeUiw1H78ilsAat2vwwqCO/zsQTWO
         nYw0gasdTcWdA27UMk04KWJaOQzSKplFKeho/Bev34uzHoH0ThwYZpztvhojp0/v9QHC
         60hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfxEcn4jsHT5cEaMYv3ym7f3QLDlpcArw5PyRWQd8f44tdt7xcXAhDETLMUOTr5QnkjfsPF6WgK+RTEPGp@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtolPg5WJlsmAs89DHtz3Czne38p04UXZGDcqjc927UKvtzhS
	A4XAY303yQjT7cgcRAIqx03/vpLqBHa9ksXDy468wt8zzMjm+QDSdck+xhNFU3KUISPM6kwoJZA
	3DWwZxK8mEmWTgsO+Ex6Sthtvd5JEuv8=
X-Gm-Gg: ATEYQzynfjjBn6bj29jrnVgKCBYg9R0NW2iaMvjsif1ckTlSQaGRSPQ2dB6nW2xKV+8
	PudM2ZRLarc+9dXC/mgb09IoLVt+0goTpIXCr5QJR8c78GCRiKGpAJsaIAZDrE2mifapZkog5jl
	mC6v2bTd0GizzmaRFuqe2v2C04dIJimxOmNE9bNCV2tpyW63hispjCwriAz1S5ebftohATYBxTY
	Fb4eBAvtNKIlT/j3NiQUKfjyKKqYJKtxcOPjvk3PcyQKlbGDjcdZzu4WLk1kssUBzHh3MOms8T3
	MU90qoQNWW6Wvi7xEjlpH5gVnUd7aMnDImIC6hV7nA==
X-Received: by 2002:a17:907:785:b0:b93:8d6a:7ed2 with SMTP id
 a640c23a62f3a-b938d6ab669mr364415266b.24.1772388567345; Sun, 01 Mar 2026
 10:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224163908.44060-1-cel@kernel.org> <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner> <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org> <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org> <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
In-Reply-To: <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Mar 2026 19:09:16 +0100
X-Gm-Features: AaiRm53WjEgGdZR3pvwpsev1R0kmLOdjQzY8rrp0rh9BGufqFRNmr7OpW4KfPPg
Message-ID: <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78854-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,suse.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D671D106F
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sun, Mar 1, 2026, at 9:37 AM, Amir Goldstein wrote:
> > On Fri, Feb 27, 2026 at 4:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> On 2/26/26 8:32 AM, Jan Kara wrote:
> >> > On Thu 26-02-26 08:27:00, Chuck Lever wrote:
> >> >> On 2/26/26 5:52 AM, Amir Goldstein wrote:
> >> >>> On Thu, Feb 26, 2026 at 9:48=E2=80=AFAM Christian Brauner <brauner=
@kernel.org> wrote:
> >> >>>> Another thing: These ad-hoc notifiers are horrific. So I'm pitchi=
ng
> >> >>>> another idea and I hope that Jan and Amir can tell me that this i=
s
> >> >>>> doable...
> >> >>>>
> >> >>>> Can we extend fsnotify so that it's possible for a filesystem to
> >> >>>> register "internal watches" on relevant objects such as mounts an=
d
> >> >>>> superblocks and get notified and execute blocking stuff if needed=
.
> >> >>>>
> >> >>>
> >> >>> You mean like nfsd_file_fsnotify_group? ;)
> >> >>>
> >> >>>> Then we don't have to add another set of custom notification mech=
anisms
> >> >>>> but have it available in a single subsystem and uniformely availa=
ble.
> >> >>>>
> >> >>>
> >> >>> I don't see a problem with nfsd registering for FS_UNMOUNT
> >> >>> event on sb (once we add it).
> >> >>>
> >> >>> As a matter of fact, I think that nfsd can already add an inode
> >> >>> mark on the export root path for FS_UNMOUNT event.
> >> >>
> >> >> There isn't much required here aside from getting a synchronous not=
ice
> >> >> that the final file system unmount is going on. I'm happy to try
> >> >> whatever mechanism VFS maintainers are most comfortable with.
> >> >
> >> > Yeah, then as Amir writes placing a mark with FS_UNMOUNT event on th=
e
> >> > export root path and handling the event in
> >> > nfsd_file_fsnotify_handle_event() should do what you need?
> >>
> >> Turns out FS_UNMOUNT doesn't do what I need.
> >>
> >> 1/3 here has a fatal flaw: the SRCU notifier does not fire until all
> >> files on the mount are closed. The problem is that NFSD holds files
> >> open when there is outstanding NFSv4 state. So the SRCU notifier will
> >> never fire, on umount, to release that state.
> >>
> >> FS_UNMOUNT notifiers have the same issue.
> >>
> >> They fire from fsnotify_sb_delete() inside generic_shutdown_super(),
> >> which runs inside deactivate_locked_super(), which runs when s_active
> >> drops to 0. That requires all mounts to be freed, which requires all
> >> NFSD files to be closed: the same problem.
> >>
> >> For any notification approach to actually do what is needed, it needs =
to
> >> fire during do_umount(), before propagate_mount_busy(). Something like=
:
> >>
> >> do_umount(mnt):
> >>     <- NEW: notify subsystems, allow them to release file refs
> >>     retval =3D propagate_mount_busy(mnt, 2)   // now passes
> >>     umount_tree(mnt, ...)
> >>
> >> This is what Christian's "internal watches... execute blocking stuff"
> >> would need to enable. The existing fsnotify plumbing (groups, marks,
> >> event dispatch) provides the infrastructure, but a new notification ho=
ok
> >> in do_umount() is required =E2=80=94 neither fsnotify_vfsmount_delete(=
) nor
> >> fsnotify_sb_delete() fires early enough.
> >>
> >> But a hook in do_umount() fires for every mount namespace teardown, no=
t
> >> just admin-initiated unmounts. NFSD's callback would need to filter
> >> (e.g., only act when it's the last mount of a superblock that NFSD is
> >> exporting).
> >>
> >> This is why I originally went with fs_pin. Not saying the series shoul=
d
> >> go back to that, but this is the basic requirement: NFSD needs
> >> notification of a umount request while files are still open on that
> >> mount, so that it can revoke the NFSv4 state and close those files.
> >>
> >
> > I understand the problem with FS_UNMOUNT, but I fail to understand
> > the desired semantics, specifically the "the last mount of a superblock
> > that NFSD is exporting".
>
> Perhaps that description nails down too much implementation detail,
> and it might be stale. A broader description is this user story:
>
> "As a system administrator, I'd like to be able to unexport an NFSD

Doesn't "unexporting" involve communicating to nfsd?
Meaning calling to svc_export_put() to path_put() the
share root path?

> share that is being accessed by NFSv4 clients, and then unmount it,
> reliably (for example, via automation). Currently the umount step
> hangs if there are still outstanding delegations granted to the NFSv4
> clients."

Can't svc_export_put() be the trigger for nfsd to release all resources
associated with this share?

>
> The discussion here has added some interesting corner cases: NFSD
> can export bind mounts (portions of a local physical file system);
> unprivileged users can create and umount file systems using "share".
>

The basic question is whether nfsd is exporting a mount, a filesystem
or something in between (i.e. a subtree of a filesystem).

AFAIK, the current implementation is that nfsd is actually exporting
one specific mount, so changing the properties of this mount
(e.g. readonly) would affect the exported share.

If nfsd wanted to export a subtree of a filesystem it could
in theory use a cloned private mount as overlayfs does, but
then things like audit logs may not have a full path if the original
path used to export the subtree was unmounted.

> The goal is to make umount behavior more deterministic without
> having to insert additional adminstrative steps.
>

I would say that if svc_export_put() succeeded, umount should
be able to work, but I realize that with automounts, the exports
are not actually administered from userspace all the way (?),
so perhaps the problem needs to be spelled out in more detail.

Thanks,
Amir.

