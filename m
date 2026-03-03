Return-Path: <linux-fsdevel+bounces-79135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIgxCH6ypmn9SgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:05:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E216A1EC537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1904B303206E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA405390CA8;
	Tue,  3 Mar 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ILPFjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC15390C80
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532317; cv=pass; b=WU5qaZjj1MUxfeoKUCNVi4bqhKviolPlHQgJBa1Gavx3uAiy63YBiihoIiBiQmkdu2A1JSVl5F2ipQZfkmjN30LkzraY93c4xXpzwMGNzLOsn7V9Fc702sp7k8RgqYBAPmaYUyq5kGKhrsM8XmsJ2QPGaKESqKWnLp052cYjrB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532317; c=relaxed/simple;
	bh=FF5mEIEGh0HZZFyvixB3fMhRNkwoGsnlYjqzgDE2qTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXomUgWbXnj5Es1CeQl7pzVv+dEpMKFRIAj0x0WnWW3qWcBbm4LIi4eVNDkYwpOhk9fC8MRk6Vg/9Go1BJZjm6R2Ntu4rkogHw5DqdWA8CDguM2l58VJ5STqwm2ElAaR9PviK6JO+h3SBR4iR66KRHdZRIywTINK2UZtWd79zpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ILPFjt; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f97c626aaso956978366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 02:05:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532314; cv=none;
        d=google.com; s=arc-20240605;
        b=F1zXVrchtJsXcJdZ1nJ6OmO5V9+xjMHCrbIoXGVKUbzmuZxPCbU1JZYna89TD5Rwv3
         3aJBZeIfuUFv5DXrnFeJhm5IJUL3tDErPxNPADd4xIDXlf+KTqX/AAIIgP0I9TL8X+oM
         k5NmK9yOXeF9znCWpr4omzjaKfZoJW3I+gAAjsWjM+4JGKGGX/sP879UJsUq54hiYm/t
         X4c84o4yoYCaogtI0tCp6Jytpo+2h3yb1d+bkDoCfri25Eo7w8dwUq8QbI7dF/sirodJ
         TVuVOEjI7LukK9sZK+iV6iJIN0UP58zh+BOBzrB1r28/DMMMEoMkSi7ZYEenaVwawHb4
         A8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kHSH1EXHRJ1pRbanfJB4m4S6VzDdBvpxoJUaB+XaYv4=;
        fh=vPJcTsOoNh7XbocZYRPkXyM+t4RHY4J6f5/DS7+O9Ng=;
        b=KDGnPP0otDhqIuJ9qCgAZhowgUr4OZ2Bpl79OrMomqxnGSe1TX49SuBCZkzAPp++ko
         FmRQ6qSRwQXKbZbNlq1nti+OrUwqiI6gNeabv2ufqQBmQ2YxLRlF2IFMFhuzm1TTYWmW
         kQD/TY9eLzDD2TwpL7sYmKkttk8szfDqyqUmfi+w23V97LTMIm7e/thcWevtIlTjtaZD
         awF+w+OFB7fI++Rp44aCXXV3aJ5zzkSp78tOxH8622KFGi0Kwu9TIMcifaMDRNNFZAe8
         FkSdIsGD552nJVdRtBCt1C2hrC31/k2e526aW1mZsCSGmoilGtjs86ObS/T74LsHuZ9e
         wpUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772532314; x=1773137114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHSH1EXHRJ1pRbanfJB4m4S6VzDdBvpxoJUaB+XaYv4=;
        b=N6ILPFjtkWS8qNa0X01jpLGo39WbctzpxNSEnx0muRiL2I4ofdACM3eJaJoTyYaYSK
         8LWjwshfAdKcsqkVEZ3N2lkAjHJ2W/x6waucqzmCITzMVGXg/sO9r6I5R4Q08j+/rIDM
         NiIyx4rTKyQbZQV9wQOcyh9WTx/VxoUQr+6JCWR4EgTRfZj/RfblB1mSvGoxow51Ir/2
         kjgGDhrI0MnHCR45UhioBa0Byb/45qu/q0srYxOvXJ2uu8MSUKMW1Q3eyjI8119/qxL6
         jQsjKSTe7Ziyklhh6F/O95dnK9BwFLFh+jYz7Mmaqs+ciKkE4f1C5YSbNOsvVlOYaxTE
         n1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532314; x=1773137114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHSH1EXHRJ1pRbanfJB4m4S6VzDdBvpxoJUaB+XaYv4=;
        b=Towlm9wU2q5X7Oz703fpyG+MzcYp6fmRigNi1pu7vopkIL8S+ha8ItpCd6T3WK8x/B
         nYjSPZLbjdUfsB6i5Wj19Bk2Lw3dHAlNRkeoOMeSrNjBzhMG3G9Nm6hoYUSGUknePXlw
         Lhoc7qjd0QJh04gCGqNkaq7RjyL6zmRWyH+0U9kRtG04yMNi7S1BNceMU4tcrj67+DzR
         lLwz/V5liZD2eSoOgTLkN8sZ7nxvDRMAAxTZ/CZnefqaJLjzfIYvzRqVLKgPilIdgzgd
         cFZbCWfWA/Rf+N0IZ8bPRsdG/Gp8tiHC+kT5zhS5c+RHAqhK0TEJH7IPsnsscZykneKM
         qSyg==
X-Forwarded-Encrypted: i=1; AJvYcCX4HTu5JRAvPS1Ty4EcZBAq9GSZWTlw1qkOx20Gw1ekqAvQCsW/1s1X6tdaIy/JNVKioapOfp1XzPMgPi8t@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPobgMBMmzb6FpJrlxzMYaN8kjpW/veFyNBgqzYsV52un8Sw/
	i5/ecxTBRt943138099WpuOaU6/SIqlLOnMV6qeIsrdpdudNlUbuzlEfpsPkIA2IH2DYtE3B4j4
	eSP8w/Ps+TM3SWUr+MElv9Vi8gxD4QfY=
X-Gm-Gg: ATEYQzw/0hRMzZYG/3DsswMqz3ed1QNS5+etsdkQxafBmlfnZRuR4mvMOf+AJvLRb3+
	FJBaYHJx2qyeRNHR1C7VJsEHT4z86LoQErBJIING7eF3RYy9ZLpeGHzNTYXn57kFVCipJ/zhVmo
	5z2I02vfmqVmEMVtspnnGo36eBXTZcs4iIRHUXQ1GVjBRHwvLueYXyw6M32qdMOASX7yi03iecJ
	crlEjWD90WWscTvWDy6qZXMJohP5pCQ9nSs54hyGyyRZKkZUO4pAbJ7bQy5MTZsfgvOZRpLiGuS
	axf8JmpSWEXjKZxa1a0eG/tJA/3UttYikgFXEiEYqRJ8HXBwKsE=
X-Received: by 2002:a17:907:1c90:b0:b93:892a:e82b with SMTP id
 a640c23a62f3a-b93892ae9f8mr829328466b.51.1772532313580; Tue, 03 Mar 2026
 02:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302183741.1308767-1-amir73il@gmail.com> <20260302183741.1308767-3-amir73il@gmail.com>
 <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com>
In-Reply-To: <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 11:05:01 +0100
X-Gm-Features: AaiRm50JW8u5aKJRHT2V2yu_EISEop3hPQHSbC7vKTFkKrUro1J3ryi88Jg9bYI
Message-ID: <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: use simple_end_creating helper to consolidate
 fsnotify hooks
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E216A1EC537
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79135-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 11:28=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 3/2/26 1:37 PM, Amir Goldstein wrote:
> > Add simple_end_creating() helper which combines fsnotify_create/mkdir()
> > hook and simple_done_creating().
> >
> > Use the new helper to consolidate this pattern in several pseudo fs
> > which had open coded fsnotify_create/mkdir() hooks:
> > binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
> >
> > For those filesystems, the paired fsnotify_delete() hook is already
> > inside the library helper simple_recursive_removal().
> >
> > Note that in debugfs_create_symlink(), the fsnotify hook was missing,
> > so the missing hook is fixed by this change.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index e9acd2cd602cb..6e600d52b66d0 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -17,7 +17,6 @@
> >  #include <linux/sunrpc/rpc_pipe_fs.h>
> >  #include <linux/sunrpc/svc.h>
> >  #include <linux/module.h>
> > -#include <linux/fsnotify.h>
> >  #include <linux/nfslocalio.h>
> >
> >  #include "idmap.h"
> > @@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentry *p=
arent, struct nfsdfs_client *nc
> >       }
> >       d_make_persistent(dentry, inode);
> >       inc_nlink(dir);
> > -     fsnotify_mkdir(dir, dentry);
> > -     simple_done_creating(dentry);
> > +     simple_end_creating(dentry);
> >       return dentry;  // borrowed
> >  }
> >
> > @@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *parent, =
const char *name,
> >       inode->i_size =3D strlen(content);
> >
> >       d_make_persistent(dentry, inode);
> > -     fsnotify_create(dir, dentry);
> > -     simple_done_creating(dentry);
> > +     simple_end_creating(dentry);
> >  }
> >  #else
> >  static inline void _nfsd_symlink(struct dentry *parent, const char *na=
me,
> > @@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry *roo=
t,
> >                               struct nfsdfs_client *ncl,
> >                               struct dentry **fdentries)
> >  {
> > -     struct inode *dir =3D d_inode(root);
> >       struct dentry *dentry;
> >
> >       for (int i =3D 0; files->name && files->name[0]; i++, files++) {
> > @@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry *ro=
ot,
> >               inode->i_fop =3D files->ops;
> >               inode->i_private =3D ncl;
> >               d_make_persistent(dentry, inode);
> > -             fsnotify_create(dir, dentry);
> >               if (fdentries)
> >                       fdentries[i] =3D dentry; // borrowed
> > -             simple_done_creating(dentry);
> > +             simple_end_creating(dentry);
> >       }
> >       return 0;
> >  }
>
> For the NFSD hunks:
>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>

FWIW, you are technically also CCed for the sunrpc hunk ;)

BTW, forgot to CC Neil and mention this patch:
https://lore.kernel.org/linux-fsdevel/20260224222542.3458677-5-neilb@ownmai=
l.net/

Since simple_done_creating() starts using end_creating()
so should simple_end_creating().
I will change that in v2 after waiting for more feedback on v1.

I don't want to get into naming discussion - I will just say that I wanted
to avoid renaming simple_done_creating() to avoid unneeded churn.

Thanks,
Amir.

