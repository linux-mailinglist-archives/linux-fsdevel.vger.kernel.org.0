Return-Path: <linux-fsdevel+bounces-79109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ITxMuZgpmlVOwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 05:17:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383431E8BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 05:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92CB5300D964
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 04:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89A345752;
	Tue,  3 Mar 2026 04:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3EWrsnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF411F5821
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511404; cv=none; b=N4NECv3YhBqpnHdkQ+axxbaD/4pQcdlcnFBJbqBD901QI/MG6oJiP6uJju1C8QcfqLpQHLwawcLUsigpaOr/nX1YWzgtNd0+5PYpY8OcvIa3sIjdof32QZuvPXSD34JjzmHd2jfH+XAc5+/JGbTM6cU8kwTgB2sHke/+EwdUoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511404; c=relaxed/simple;
	bh=GboE8adBYDYZ9Iy8G9i1hidO0E9rLB3inTAUtWA5mcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjK7U2c6Z0HiZ5UaATap3CgfvU2wXpMYSKg1phqIS6JcmSd+SeuFU9shl+za4MaV3C4VIHN7vpUfLeZZhWOAoYHLVQbHNDxUHClFOkoo4oWfJ9xfqi+tkQIf0vzTuQLmDfu6XM3qHY33u2fDyRTAMZj8vx5ydtaTInPWuwfhmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3EWrsnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB56C19422
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 04:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772511403;
	bh=GboE8adBYDYZ9Iy8G9i1hidO0E9rLB3inTAUtWA5mcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r3EWrsnjfJkcHNjJAUcehh0+peMpX7O/D+CY48ngFpdh2wk9hFRRU+/D0/cb2NMDq
	 vBtc3B+YRW/Xin/Krqn93S7KfKupwnw/+wJhMDiy9JsvS6LsSUn/t23MsXI5o8knnG
	 xhcrZiTkK0ij2jiA+K+ZVbPB5uU/uWqCUGoSm7w0jyaJlDB/YuimNgE794PRsoPTSC
	 XoeFHuuy9pA8nnWVlG1MBvDH6gApu94/gEUHOknpSjLfzfaiLgZFGM5hJNLdYZr8Vw
	 j+U9XGjDa9AYw/0DKpWRXX/eRWj7fWgK32unxHzyQip0bBQtYb1uL/hxWwN6Cnunzs
	 d/S5PEFRsCi3A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b935ff845c8so660012566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 20:16:43 -0800 (PST)
X-Gm-Message-State: AOJu0YxRBft4Fm+PTLcs0tL/4XJO1Ezn3Uz+NSrYApFEh4GQnjV2ZTOI
	P0AquSKXcLQjQHMhCV9kfEtpe+irLwDQTwE/Ic3HFrhmTFXi/y/AXe6Ez67I2g8twxagNCj1Ybx
	w90QKj/p0GUfMXGGu65TC6arqI2uWhcg=
X-Received: by 2002:a17:907:d20:b0:b88:48ba:cdd with SMTP id
 a640c23a62f3a-b937652bdd8mr920463066b.43.1772511402224; Mon, 02 Mar 2026
 20:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd8PmK6jXa+6kbF2Gf2HZ7Ne1-3_ZwBS9kSOY-JwogZTpg@mail.gmail.com>
 <20260302141005.107-1-anmuxixixi@gmail.com>
In-Reply-To: <20260302141005.107-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Mar 2026 13:16:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8J+c4q5_t6dYUi=ASwJVO8TzojT5-mgCPb+TkN--aARA@mail.gmail.com>
X-Gm-Features: AaiRm50iNe1JpWx_wd9hlpFZIH9S56pKMCSrodsjHsTc05jjiAi3UVxuqX_z6KE
Message-ID: <CAKYAXd8J+c4q5_t6dYUi=ASwJVO8TzojT5-mgCPb+TkN--aARA@mail.gmail.com>
Subject: Re: [PATCH] exfat: initialize caching fields during inode allocation
To: Yang Wen <anmuxixixi@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 383431E8BE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79109-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 11:10=E2=80=AFPM Yang Wen <anmuxixixi@gmail.com> wro=
te:
>
> On Mon, 2 Mar 2026 18:58:41 Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> > >diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > >index 83396fd265cd..0c4a22b8d5fa 100644
> > >--- a/fs/exfat/super.c
> > >+++ b/fs/exfat/super.c
> > >@@ -195,6 +195,10 @@ static struct inode *exfat_alloc_inode(struct sup=
er_block *sb)
> > >        if (!ei)
> > >                return NULL;
> > >
> > >+       spin_lock_init(&ei->cache_lru_lock);
> > >+       ei->nr_caches =3D 0;
> > >+       ei->cache_valid_id =3D EXFAT_CACHE_VALID + 1;
> > >+       INIT_LIST_HEAD(&ei->cache_lru);
> > These fields are already initialized in exfat_inode_init_once().
> > Please check exfat_inode_init_once().
> > Thanks.
>
> Thanks for your replay. While it's true that exfat_inode_init_once()
> initializes these fields, that constructor is only invoked when the
> slab object is first created.
>
> In the case of inode reuse (when an object is freed to the slab cache
> and subsequently re-allocated), the fields inherit stale values from
> the previous user of that memory block. If an eviction occurs before
> these fields are re-initialized by the new owner,
> __exfat_cache_inval_inode() sees a non-empty list due to stale
> pointers, leading to a NULL pointer dereference.
>
> We have recently observed kernel panics on mobile devices, which were
> traced back to a NULL pointer dereference in list_del_init()
> within __exfat_cache_inval_inode().
Okay, Do we need to keep the duplicate initialization code in
exfat_inode_init_once()?
Thanks.

