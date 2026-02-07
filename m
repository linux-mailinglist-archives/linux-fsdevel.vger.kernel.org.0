Return-Path: <linux-fsdevel+bounces-76661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGjAMKKOhmlTOwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 02:00:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325E10463C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 02:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74504302C92C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754D23EA94;
	Sat,  7 Feb 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftFUyuIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7C19E97B
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426010; cv=pass; b=pwnej+nD1n0SFguYnrmjeVDjBm4LKYdmYZR5J+lujWFaPFWgzu1tfN7Fj0XAbHxRIOmqPUeksx2gYqJdOagi8Vwd6T3zKnEy1spZmKIh3D2r+642EdjzZHWB9dOvm0t4TNE2PKdmxravxbCrGER+nBEyKn9q/QfTdg+Zibgwny4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426010; c=relaxed/simple;
	bh=GOl+yzQfvJ81Mb6nX6vbSK9P6JDhNobzBh6AGciU+3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZKEz9LjHshAVec+tcCLK92zaNQObgoeJw9aEuxSxsMuFNBCLpBjSWHrU6TbfPfeTJG++jpMWO4dozY+Lc+3hS8s0uzPYUNp9b6mK2hSFhsrphh9DKigFNVTIjP299oVhJXNR4+lu8Xj5pps8wO8fImhl/sgqXj4qFZnSCbpyls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftFUyuIH; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502acd495feso15573511cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 17:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770426009; cv=none;
        d=google.com; s=arc-20240605;
        b=d8+tZS3xNw/4b/7a9bP09NvGSq1xqs77zr4yiy9sJcx8nKlTVCE6+1QHsxktsrzkaM
         MxbVqcynxBUAeacqDVaXEZ+5V/f9iKFVmb/lZ9WRoVrY2wAth662owvhyrarBSPfxTN2
         r/N8WQseNAnf4adnGlM+vAkhWrXX5X278VU+17YxA+l7lM5d6RGhXHkMhd9ONiwoDq+b
         4bf1BbBjAmhP85rKMHzX+tKJ03IFqTH+DYj3hOwsU8+zpHB7YHFMPkpXYHAH4GlRPPCX
         knvWQB50UhocyPgrAsnMWVZQ+Dld3ex8rZ90DPCqWIiQ9fe5KvrCdnzv4M1sPVstxkiK
         SN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1LvKaDQsF5i0nG7aNyREL0Jo4Gh027d3YlThpa0ie0=;
        fh=1kV8FyHbtz3r/fQo90zZPf7znk536kVruebHK6CuhxQ=;
        b=bYkVGN23IIRQn5jpQKpgimDDME4kdgAAHhw11J+1G1fCy5gtEQ+FS/VHrC2Jemnbup
         TlZ7mDCcLknxRqknlThRoVIQH1CddZIZKA7sYixuqVVfh50mtYiMw6vZlQCB6JhN2mn1
         FEKEtI4+zGtftBXLUHuZU9advcFVn8CFUkeg1ptjaSlPzdxZ1rYc63ipYXxg20eA+Wvv
         5aLVmaysIo22RThZBcngX1bDx1qngs7dgOTF98Ult4/omrg2XA4OcRHlxBjszOLPhG69
         LCtnKSAj/8rGNUMPQcFM2e5YcoNTdLvZl66dd184HKFlS0iQ4YYtb42WKmr+wOsDhxtR
         oZJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426009; x=1771030809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1LvKaDQsF5i0nG7aNyREL0Jo4Gh027d3YlThpa0ie0=;
        b=ftFUyuIHtbW8iG/0qpCNsiz+dSjRRCZK9YZ32Rz3nqw1s7U/3v+dFLu+lDrV+xXUWx
         RKN7ZBkW/0AFI1gi3/LgmnhRAF67FIqKipVJgwWCPW4f6Ip/iC8ypG8eJrJNMYk+RJ1t
         1AU4/YMg9nqFXmPll9z6Db8zSD/oUcZLgi92pOhE1lcqMzcqg/t9wbHDLsxDTgEvpoc5
         h/gxdCnrodO0eMisRNXt2KPGLcNSePpzfStOI0paXGD165FdPygLl1HHccL8VoimV/D7
         gnEDwy1zy3Hk5xh7GTuwxT/5anXr8S5XAHc9YML5W316dQx5HYJ+PZT97rlH0oCpwOma
         VFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426009; x=1771030809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1LvKaDQsF5i0nG7aNyREL0Jo4Gh027d3YlThpa0ie0=;
        b=ahT2ziPpFLegREs6X9cpMfWtQNyUVArxF4Q4mphWnkkLKnjXL+SB0jn2WOzKQtQhyM
         wU9DOlfGWHYcDQkz6WpguJvRNWH26fyWAUibBn8Mguauliwzf0Ej2FtGd05DRIOUGSXd
         509RBHSd7CEedzDm4rV4044jNeGxOm4QX2Z9Whd3fpkt2tYs1AsHFg+WSImoDIMtTlTK
         TH7ha4r1sQGjxU7fF03JZ1UXWJeak6msWe7Ur878PYAFZEvCnPLZActF4HO9yAXW/3c0
         PGYDu31VJbrU/saqNyiTH0bAtvg+xNbyQR6NcLL1OIYZ7kTPG3DNBVwffxC4MaixPzL7
         03LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYzShdaZguiKROhihNHxnMpojT5HZvqMakrBeZQOWY26r2NSLohAWvm71tNDjXnIlTTEjrILDjIQRvtQg/@vger.kernel.org
X-Gm-Message-State: AOJu0YxsI1Eal15ZkMxk1Th6cYvO2eeeKsSi8evrFRLebQ+FpMilJMDD
	BSQgxgT4u5tRmQHUkhpdqffgRTqHe9f4OPfW9bxuIq+dcUMjA+M3NUcIAaNSRbqq3TV1oqvU9Cv
	f/u6HA7if7nZWcqfXd1ATgF3CJbJeyqQ=
X-Gm-Gg: AZuq6aJ+YKnggM67FTtDHFvaHioUgWGXm3nUw/ggDtgi958iG2AP6qg9TOILDPLDTLM
	WDBY62ei7Z6Q2VcwDQvJQfgR2zVtjxC9ToMvM/B9IiCScVs992xz48e0LwkPe/WerERYpyLwG4r
	O9qs3e+eKXrhIFpc4GLfqc/CBLufejs7znVF/vNpmpewrVeN+N+9hNgwybt6GNCmFB3KxA7vPXi
	lI51dTw82GCV7WIOeWUXZmWrP1Rn4uHMvXYLaad1MAcWXuzZwCsVH/+clePG+BI6m4onA==
X-Received: by 2002:a05:622a:11c4:b0:506:1edb:2cdc with SMTP id
 d75a77b69052e-5063985d90cmr74178351cf.6.1770426008435; Fri, 06 Feb 2026
 17:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-4-joannelkoong@gmail.com> <aYWeErf9bgQJANRF@infradead.org>
In-Reply-To: <aYWeErf9bgQJANRF@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Feb 2026 16:59:57 -0800
X-Gm-Features: AZwV_QjA22_fkxfGyhpbiz3lWbfC4zoePSjfcxG5s9BV6ISHh6yLvJ0zx7a8uAM
Message-ID: <CAJnrk1Z7PDBEEOmwABCPisvX+-zFGvVvw118vBGUq3J4n0Kgag@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, 
	csander@purestorage.com, krisman@suse.de, io-uring@vger.kernel.org, 
	asml.silence@gmail.com, xiaobing.li@samsung.com, safinaskar@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76661-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email]
X-Rspamd-Queue-Id: 2325E10463C
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:53=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jan 16, 2026 at 03:30:22PM -0800, Joanne Koong wrote:
> > The implementation follows the same pattern as pbuf ring registration,
> > reusing the validation and buffer list allocation helpers introduced in
> > earlier refactoring. The IOBL_KERNEL_MANAGED flag marks buffer lists as
> > kernel-managed for appropriate handling in the I/O path.
>
> Do you have a man page or other documentation for the uapi somewhere?

No, but I will tidy up the liburing side changes I have for this and
add the documentation to liburing/man.
>
> > +int io_register_kmbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
> > +{
> > +     struct io_uring_buf_reg reg;
> > +     struct io_buffer_list *bl;
> > +     int ret;
> > +
> > +     lockdep_assert_held(&ctx->uring_lock);
> > +
> > +     if (copy_from_user(&reg, arg, sizeof(reg)))
> > +             return -EFAULT;
> > +
> > +     ret =3D io_validate_buf_reg(&reg, 0);
> > +     if (ret)
> > +             return ret;
>
> Probably more a comment for patch 1, but wouldn't it make sense
> to combine copy from user and vaidation into a single helper?

I'll rename this function to io_copy_and_validate_buf_reg() and move
the copying into that.

>
> > +     ret =3D io_alloc_new_buffer_list(ctx, &reg, &bl);
> > +     if (ret)
> > +             return ret;
>
> Return the buffer list from io_alloc_new_buffer_list or an ERR_PTR
> to simplify this a bit?

Sounds good, I'll make this change.

>
> > +     ret =3D io_setup_kmbuf_ring(ctx, bl, &reg);
> > +     if (ret) {
> > +             kfree(bl);
> > +             return ret;
> > +     }
> > +
> > +     bl->flags |=3D IOBL_KERNEL_MANAGED;
>
> Should io_setup_kmbuf_ring set IOBL_KERNEL_MANAGED as it is the one
> creating the kernel managed buffers?

That's a good point, I'll move this line into io_setup_kmbuf_ring()
(and do the same for moving pbuf's IOBL_INC flag setting to
io_setup_pbuf_ring()).
>
> > +{
> > +     gfp_t gfp =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
>
> Isn't this really a GFP_USER allocation and should account towardas the
> callers memory cgroup limit?

I think __GFP_ACCOUNT is what accounts the memory towards the caller's
mem cgroup limit and GFP_KERNEL_ACCOUNT sets that whereas GFP_USER
doesn't. GFP_USER sets __GFP_HARDWALL though which seems like it's
also useful, but elsewhere in the io uring code, GFP_KERNEL_ACCOUNT is
used for other userspace-facing allocations (eg pbufring's buffer
metadata). But maybe this should be GFP_USER | __GFP_ACCOUNT.

>
> > +     if (WARN_ON_ONCE(mr->pages || mr->ptr || mr->nr_pages))
> > +             return -EFAULT;
> > +
> > +     if (WARN_ON_ONCE(!nr_bufs || !buf_size))
> > +             return -EINVAL;
> > +
> > +     nr_pages =3D ((size_t)buf_size * nr_bufs) >> PAGE_SHIFT;
> > +     if (nr_pages > UINT_MAX)
> > +             return -E2BIG;
>
> This looks overflow prone, and probably should use check_mul_overflow.

Okay yeah I think you're right that the (size_t) casting only protects
against overflow on 64-bit systems but could still overflow 32-bit
systems. I'll change this to use check_mul_overflow.

Thanks,
Joanne
>

