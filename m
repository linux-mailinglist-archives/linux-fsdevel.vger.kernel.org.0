Return-Path: <linux-fsdevel+bounces-79806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMY0OVPxrmkWKQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:12:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F9923C820
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 112CF306240E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994223BFE2A;
	Mon,  9 Mar 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0WVw+EJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF882236EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072424; cv=pass; b=peZZ7xCpNpcYEtYEkeNyFFrrtlUfEJFe6nXGHKaNvz/pebHYPaxWX2+fj2By6NeN4xk5cqGCJLsleXk/GfIQ4L42Dti+aqoJJstlgif4bONSu/6FRJnYoLkZfN6vHDBlPqO1L5b96subXaCqsDqyk+6i6C93ZzhI7fK18gH1/sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072424; c=relaxed/simple;
	bh=tnJEXQi0QMLuGskG5kwVEd82dGxbwaji6bCS8GssTUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQhLS7iA2tH4JBYw18oQlMJDaoRm6BTJbZ4wlav2TwDRl5DPxoqwugkdAe5Hz/IwPo0ZdPvqQzXZywJqU1W07W8x9V5TtasOORtFqWwa+rFOBJOu5t/e7oPD3Tprtq0FiIX55w0qY7xFseZxtmLoT2vX6CODVPqC4bcFyvw06eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0WVw+EJ; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661169cd6d8so14074a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 09:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773072421; cv=none;
        d=google.com; s=arc-20240605;
        b=VqmozXXMeNGpjWJfI4orMKNZmHv2ikZDBE1FZh2V4H+rdHhj+/ySKJu34Co6EkyI5v
         4oHi2NXN5VrxW36FCPm+zzfeqnTl/OJgNBenpAJTXmSNoXQJe0lW7zmwJTgIy4sngts3
         3EeZiFQrewx5WjIGEwbQPsQy+Lz/hhDss67kr+Kw3qvwvYRjb57sv98ydi4BTVcsJzMe
         TL4INLMTfc+2NsQEiqF8Fs2iFzM9G2/6tKVXdtHXOK0pRUBp/f2fAXdSYD2OaqagH1r+
         zL3jCtKbnbuKaNcXEp4yDWwzvQZ/qO5BJZpyc0TGg/8oL73jrd4+kSfc95NLxIRAzpMl
         Ku0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pImyNInQryg7ScSI7a4TcEjYTJDRJ/H8m7YcY6WOvR8=;
        fh=+/WjqGOODrJjRWEFHLCYnr7yJLLuUBSws8YhyjZh+N8=;
        b=OmqZDDVFXn2nbj/dHCYaurIStdN5+rZYwRahv1C5SIbiuHbFEkVB4SZJv0M8QFjN7x
         Y3v9zJoUZ6RNZ8mpEwf2kU/CK21xq3HrbV2SYgFXTg6yHZd67soRLHOtbTj45VyrbQ/i
         c0+oV3Hl/VGTR2/P57qrDJq63yVMmTwR90jfsXj2Lhi6PygfgmeM9DuBudb4Qy/7I047
         cJPSLF++lo9osyXcUVdcy+eQF09BQA4kwBFTYswVWx/hHdi4mTeNEY0bHyykwhnL2D9p
         IQoAeKXxrSovOMFvTok8XgqrwDEX6tDBEo8rOAUNm9RTCzhFhG0yiLBHnOoXko6NuTrE
         h1Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773072421; x=1773677221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pImyNInQryg7ScSI7a4TcEjYTJDRJ/H8m7YcY6WOvR8=;
        b=h0WVw+EJ3nb0FtYEjgdH57fSAo120DhUqXIUQLaHTuQYBkYtvepadYcEhGzse22rKo
         hutHtCUbdl2Zoh4PpXqzXkshprgKID//IixfoPg2j1zn+mq038FqtGXo4d7rBPjRyzsP
         G30jIAXsJAdx9GnFvQoPO2BUBc+/aXdbuyKwuBKAFhkj98QKGj1riG4zfpE2SkiVgHUu
         mfaKrtNjimM6fjPrGn1QW7gjwfba2GLkG1mtECLblp3CbSVZA3SbfI6VXtYyHl85PwvO
         YRVFL9xvuDeSWekq1YczpkrnHjGGoVg+NQwOUKRu8DjVcqTAvZgebQ+m7dEOBbnlu/j7
         BIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773072421; x=1773677221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pImyNInQryg7ScSI7a4TcEjYTJDRJ/H8m7YcY6WOvR8=;
        b=EOvpZqIkdtb6m6y/nbMsncvS+LPgeF+v63ZAht7PjP/rUR3vwDp/XSfs/BVSd2i94h
         Jg+l5mDan9JaH8RwR5Gn9j5oTcbkv10RADfODobDlkDWefk4uPXm49EtA7lwqe+dxCr4
         UKleZSMCyhOvj/zPzi9Vtcz01AR84Cxg6STDW3rv7f7I3omkXwMLX58nTC2hdYIDtuXs
         TXmkLAE7AY1cJgkTEcNigjDPJ8UVwOFStr4SGacRR5s/k83X8tXmllhaOZshIsqwWnKd
         Csj5DgE3ZQuaFgzdg5yDN/28FZm8L3CoOTR04dUjojyyZykPvFACAVQHo4/9lSkhVjJE
         wDFg==
X-Gm-Message-State: AOJu0YxeQ8bfuhOVPSw4Kb+S8TC5bgUOgEFQb9fHjuUfjH2ORt3ivchx
	TosQ5uFAD0LdvDclBiKN2qEns6ENujkWo4xAeZKTyyU63ayV24te1uGw5qGBA7eaL6puHxgvpjk
	v6LfOl69lQE63Ov8UKFZQOTwGADfMCpdrWZzxM916
X-Gm-Gg: ATEYQzy3dEKoOTbwSra6EBFNAvWuLSCOcGUKdx/htvevFdxPzvEkKhX5pXKtfECVtSY
	OqGBT82yyHMZWZEH5oVS+UZjsQ72hMG6Og5D+zGLVjVVd9yXVTrIKDK5XTPmKDsrlQcBsj8CsNK
	xCPsDgZeeMiR4COIhaxhUiigUVE4g+kkt7KcfNXp3YQ9X3JR94keliIn2/WZdGcaeSQE2rd0Pik
	53fMG+h5bqviW7NLkl8j0y+fBSC/xuB6CojQ5XrrmgtwhfSjzHzItCPdAfNbmRBdR1i2s9MEsNm
	yKX+3x2q7R4tVfcDd45+888FCgo4BrM2/fzFSg==
X-Received: by 2002:a05:6402:3254:20b0:662:a565:cb41 with SMTP id
 4fb4d7f45d1cf-662a565cf01mr18194a12.6.1773072420879; Mon, 09 Mar 2026
 09:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org> <20260306-work-kthread-nullfs-v2-18-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-18-ad1b4bed7d3e@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Mar 2026 17:06:24 +0100
X-Gm-Features: AaiRm53Q95hj2azeXcgcreHeoxAMVLzWfUEJ3sSaaRFPh4Xdn7psa1tH2zr5jFM
Message-ID: <CAG48ez3Oei55q_b4Wbh5Z4R81ZjOvfKcJhZe1QVudbxMw3TAsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 18/23] fs: add umh argument to struct kernel_clone_args
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 65F9923C820
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79806-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 12:31=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Add a umh field to struct kernel_clone_args. When set, copy_fs() copies
> from pid 1's fs_struct instead of the kthread's fs_struct. This ensures
> usermodehelper threads always get init's filesystem state regardless of
> their parent's (kthreadd's) fs.
>
> Usermodehelper threads are not allowed to create mount namespaces
> (CLONE_NEWNS), share filesystem state (CLONE_FS), or be started from
> a non-initial mount namespace. No usermodehelper currently does this so
> we don't need to worry about this restriction.
>
> Set .umh =3D 1 in user_mode_thread(). At this stage pid 1's fs points to
> rootfs which is the same as kthreadd's fs, so this is functionally
> equivalent.
[...]
> -static int copy_fs(u64 clone_flags, struct task_struct *tsk)
> +static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
>  {
> -       struct fs_struct *fs =3D current->fs;
> +       struct fs_struct *fs;
> +
> +       /*
> +        * Usermodehelper may use userspace_init_fs filesystem state but
> +        * they don't get to create mount namespaces, share the
> +        * filesystem state, or be started from a non-initial mount
> +        * namespace.
> +        */
> +       if (umh) {
> +               if (clone_flags & (CLONE_NEWNS | CLONE_FS))
> +                       return -EINVAL;
> +               if (current->nsproxy->mnt_ns !=3D &init_mnt_ns)
> +                       return -EINVAL;
> +               fs =3D userspace_init_fs;
> +       } else {
> +               fs =3D current->fs;
> +       }
>
>         VFS_WARN_ON_ONCE(current->fs !=3D current->real_fs);

Should that VFS_WARN_ON_ONCE() be in the else {} block?

I don't know if it could happen that a VFS operation that happens with
overwritten current->fs calls back into firmware loading or such, or
if that is anyway impossible for locking reasons or such...

