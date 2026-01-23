Return-Path: <linux-fsdevel+bounces-75315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP3GOEftc2nfzgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:51:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 891907AF9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752E03021738
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7F224AFA;
	Fri, 23 Jan 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeivFwvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FC33985
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205055; cv=pass; b=pDz8gjNKMTN4JNrIT+TxSb7L9/vA6kyLWCaCG4vWMen05xtARC5GCzZGSw+K6/NjeeRIVhxdkjLIHXRiY5PYVaNQM0Ju5XRrGKZwSZmy+jaofEAbVrAANLHAmw7T8U55rzocY9wqrl8o9CnHJpBFwEGlYd6NidqoeCYhtAa08o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205055; c=relaxed/simple;
	bh=6IXzu5urvUpIOvNTmg0w02E+jJ0ffDlI4ifqyZP7KSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6kjXzpvkW8JvckVTAokUtX/qAj2XOVU+90/hiABzXCe+gkUAgEOQgGDF26yGLzD1MbYTlsl11hsBki9Pm62xftJgkydXAHy+W8hwt7OqJsuQAZNuY7wMQw3b0vf4KrppDNeGck2Z1SKJwR5a+S4n4UC0RQk/qR2VNkAg0m0YTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeivFwvd; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-502b698e510so35300881cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 13:50:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769205053; cv=none;
        d=google.com; s=arc-20240605;
        b=T5OaguB9ivvb18mEdus8hF2qygnvTmMu3U7JTm0Fz9d6QCFMSPSBI+cWtCI3OZVPdC
         t2D7xfUAAvgIVGbHyvOLpP65R2dVHGPhNZeiTti+dbN9+BP82KHjUBRbvF4Ty69T7Dgp
         FCdwWc4S9MQ9FvXLcUYcun9RdblsH7ide4/oVzPxZmTijqukSOy4tiNsUXmfXDrSLGs9
         uYcEibL8IG5Ec3nbKMzL4OjqcOSNTv98OfXCV+91S+nUHdTP2PHHLdKvg99LXf8NhAuh
         mlctkF38UM6AdH3WCeCmAknE0ZrqL23iQJqAnYD7FECYRNMBxAEeqrp/SzaHbxAuapc0
         30gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3RsJnPZvrF//Bx+/Oni1yeILddUVVYgZUnr0pj0hvM=;
        fh=bQ2FYYZ1lOMAqS5swvJS55R09WuYyqdWi5OsiTdlpjA=;
        b=kTExAMP+lTt/yMM74a1TW6bRQ5BRK5yU5Z6RzsOqxvWRgdvfNwArwtH9Welcc0lbDC
         cWKXCic7BMBsdLten0+xyzzpgLQppoJblPoi8lk3bblZTjgQzrkLUDiTBcoFXEtMJEVK
         IpCdiz5AuVbqnpodD3q2gxa0NGWhRl9NWKdE+f6B0x1VSv+ZebZBPG1+ha+WYcBk/OmV
         QeMBZvRrB7olv0EQ2DAP4Xm/NwdCyg+fdKun61ff0nl8ftHkY70651mpwjK7hzpGPG8J
         bsN67+eel48ikf7h28k0Loz/ct7W8W2gVxE5ho3xosSyYbyOFrpx25Yl/7u05nQPvZ0N
         RMUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769205053; x=1769809853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3RsJnPZvrF//Bx+/Oni1yeILddUVVYgZUnr0pj0hvM=;
        b=GeivFwvdR1iy1xBwOhVxI5ankoPxaRHi/ers7RP5h7Wf+YKTA5HEUNLaOW1RnsjmEf
         43Fc7ejW5dzZWy4ir4KudAhUyXwHFHD9EP0+sKH120WYkxkzN4ksEKkS3pA84zZYhoFf
         F/QKBtbZrZsby544iDycPEtKXN6vYveh6ne469CJT8UaHF1BIjhMkX4o/p1fggxkU7K1
         BpwnFUHTdZfIhhFse/8ZNbTjltrqJkPbKL19yzrQJmKQ6a8H0btzqNsmbT+fhNXxNhEf
         veCXb8637DiAKLRWrqnJG9lAcRRCid3CuaIBe577RQMksbmwYR9+2MOKkuf9rTs/naut
         Aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769205053; x=1769809853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3RsJnPZvrF//Bx+/Oni1yeILddUVVYgZUnr0pj0hvM=;
        b=Lpk9HhVaa7a6K5gRyDuJx7Q6wz7fbOUJ/lOOViD85qN//5ycSmjFV/uEvn22Ex/8Dx
         OS2xwg7lhtrd5wT/trFAWwtvm5NEoKFZN148FSDOXDRBGclxag3tluUu111bHtLO8VTv
         CfoH66crmoMQ6TGNOKjz49OtyBtWrT66/ZdzN1XTD3ZVyf0JlbNnztfW8N4UHG3unvrV
         FR85SIw/ycmjCQsCXnBMuvuhX8XBv7e/E3LpHzdDoTdmsjoHBpY537X+StWojMxIj2hu
         SOrOowyVLD9ot9ovO5Fvm6hFUXJW6bZa8lCm2kYLcQK6ChFfWGdOc0w4Hd1Gp/M6Uvnn
         0DLg==
X-Forwarded-Encrypted: i=1; AJvYcCXKHnkUdUhmfV+SVg4YdsTzKsN4wk0p7/LINIzZoCO+6NHdvzMFbJbR+GS3xNhQNVrJ+f/zzuZcaLyK04vP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XQWf8XvOld6Eu85lFQQmA1MtK0dH5AYlgA1y3pcJ2F3TiTy3
	q8tLu+K0GDLlmQ/gWVfInnmmojhlc77pOq0YJIopGy6ngSDgK6NbZT3UHv1SCm9jK2/w6xKRD4C
	w9M2onuYtnxYgMMgts5i4YsDFBMeFQFM=
X-Gm-Gg: AZuq6aIE13L0+QdJXSe1YD7IkaBDDHLpGv+ZRGpf3m8lKBI8NbLXXBzomZBLo0gisP2
	HsLSU9mSd6obj0SGiNWDtMZRmLQ6VWvGoifYI92jKLKRbN8s9c/TnUJJ4wek7cLbznq+fHtcBu/
	C6E3lqVy/NGInNFwd1LrHPnR0K8x1WAlcoJfTleHwKAG8PBTWWoXtbOLGd4NLh/cpHG+M7/TiGP
	f5m8SCS9gjM3ZfchYFfFrBv4i05Co3VutT8nsvUyjNGO9imH9dhzJmgudsVODcqg4pdRA==
X-Received: by 2002:ac8:7c55:0:b0:4f1:ab79:fb18 with SMTP id
 d75a77b69052e-502f7747aa4mr55300201cf.25.1769205052741; Fri, 23 Jan 2026
 13:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810700.1424854.5753715202341698632.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810700.1424854.5753715202341698632.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Jan 2026 13:50:41 -0800
X-Gm-Features: AZwV_QiX4hOk_3lPAHP4zgVxbMS4JU0Q0fRA5UCPS5O3nWxaluH3IssYOZyADgE
Message-ID: <CAJnrk1bymmhei7X15980THz8gnQCgm2ik2nLBOWkZ3NF5MXNXA@mail.gmail.com>
Subject: Re: [PATCH 16/31] fuse: implement large folios for iomap pagecache files
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75315-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 891907AF9C
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Use large folios when we're using iomap.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file_iomap.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
>
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index 897a07f197c797..0bae356045638b 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -1380,12 +1380,18 @@ static const struct address_space_operations fuse=
_iomap_aops =3D {
>  static inline void fuse_inode_set_iomap(struct inode *inode)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       unsigned int min_order =3D 0;
>
>         inode->i_data.a_ops =3D &fuse_iomap_aops;
>
>         INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
>         INIT_LIST_HEAD(&fi->ioend_list);
>         spin_lock_init(&fi->ioend_lock);
> +
> +       if (inode->i_blkbits > PAGE_SHIFT)
> +               min_order =3D inode->i_blkbits - PAGE_SHIFT;
> +
> +       mapping_set_folio_min_order(inode->i_mapping, min_order);
>         set_bit(FUSE_I_IOMAP, &fi->state);
>  }
>
>

