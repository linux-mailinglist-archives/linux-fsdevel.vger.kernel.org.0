Return-Path: <linux-fsdevel+bounces-74717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCrTF/fnb2lhUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:39:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C30404B722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB616A49D6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E93A4AAA;
	Tue, 20 Jan 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm0a1Lv5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F92EAB6F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939140; cv=pass; b=ur1exudXKNYQVHXmshoCC82ROavjWRGlcIxHTnOBV2WSEx328OJ5c3AcPz0zIJLt5D7uHGHmKU4J2wjdtmbys/o7W5XhXJObZ0DwQ0hVTJ7ekq/UAk4oRMY7r98DOO9bZjtw3NWfnFcmgWERXGFFWmvPhYDs1tI3NauK5ChTLtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939140; c=relaxed/simple;
	bh=VdGVHkCP2yehNQBzdQAdY3a4obGs/6GKDsb3Z9gQJfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBB1ajQKH+eE8icc9SZBJRbB2aCwbs5feN+ZU4b6XIq0p/yeIKIN++OTGonmzaax3ooNxmSYe6CImq/rZD+w+84K5nbnAKteCLXJx10PEhrnIu4JR7qmDeotcIt4hs1Zf3eKfhbs8z2ua+NbuZ06JbW5QKVaxQ038Mw2/Tjpzk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm0a1Lv5; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so1725622a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:58:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768939137; cv=none;
        d=google.com; s=arc-20240605;
        b=X0GfmkTU5YkZEjH57Ni4KjsrDCUzyrzjO1dAo9e9U4Vm+dgEI7v6NaFanKfL+Iy3tO
         HV1yBElPoHxxDBoAmVKPP1YW3DhcvskGonFBkQk0zBJClsxaRDAVrjx6IxiwYfdb/oxi
         D5vqL/P3bbeb0QCCShX00vk4cmECDTKyl2NFtD1MtKcRu2lefPzGQOnspwRzkrPnJCp8
         iK2h5GOpFwfncybbBAkQK6+sQCeBl2DhEVCyPIEvQve/lepuFsZiwRgnwsK9ou5SBQHd
         o8sCB/AoD6CUOlz6fISuAkrsllD5qizIch2hadRZG6AmjGkyqGmiN8ZZ0JbkJwVM+Kez
         UDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+On6qFlYykQeaJjpIkA/TDHDKzr6HQgzt99BhBXvj4A=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=DiEzgFdNlskN27hDMjyI1EzJbc9PzrMDmpdRpr2ilLsPL1oV/vbBsdCD1S0zFPJTzB
         VcG99xYG+V41YAijpyIsMcmiAWcrZ56aG3ebBsBlYel1BPSlXU/j2hHMc6XJn2u1rFdl
         AiJtjiXJg9i1YH2UacDxGtQNl1UZ8zdVRAhZGKuZ3sBVZe+IWMxwj+vKX1WFa4iV6Dah
         tY1g1BHPeVc7jQf4PKoI4Mt20GezH3UkZlWrb11x9ygJy2TTjReTcbudLusCXf9Iuo7Q
         ZNktnYWANJfZ6WySrK0wZp6hfA0QCiN7VoSd/ZFNQ3qY0HU0LbdVS4hcBhW2f/dBJZoJ
         MWjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939137; x=1769543937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+On6qFlYykQeaJjpIkA/TDHDKzr6HQgzt99BhBXvj4A=;
        b=Qm0a1Lv5u1BmhUP1+iWwyHFS4TdgPz/1OPqZo2pqi1uyV3Owe89ONnjzkbHzQ3wFUT
         Y1mt4d/P3sv/GqJJxpc/FGCXFncZhcDP3DKDnEw5te8qgGMBp3udjyFE1e0FgFyAqCJy
         Hqmtb7i2WIx1THkevZuS8e1TvezmqEzgyTKFCZ/Zi+rnGkM2iBHnWWgkSRs9a92YOQvs
         8XJFebZtlEMTUn5K7ohA8VRqcSQL/SQPuKKAW/ZFPSFHa8jek0lTi1H9qmwzrIalpScQ
         Hffl5UL5zy6rt0Qnsspw6utH2mYP4mqJ3qCFv6pHGy/XQcjpKrLpqwaJRxjBszOzmLsB
         56GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939137; x=1769543937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+On6qFlYykQeaJjpIkA/TDHDKzr6HQgzt99BhBXvj4A=;
        b=cdY8w0pMQxSwzB9jQhJcX88AQUo1xR/5ISOLKha0i/6C2175BKwNskx8KT1ps/gTU7
         atz9JnwUxGC42fB937dnq3ppZHf62mQzSFXKab31aWSOdH1bVjuwlQLufF9c6IMiLFeF
         1wpIEuw1Bd/U5srbu2Yuht0rjfHoBZ6G1RAJDa4UlY9XzbERn2n+2+q/29SlFEspUNrj
         quu8sF6OchWkUmnlaClbmGBsYDpJjFq7e5VlcHbfEXZ73QF1yjNuhYcuqGqI7xtKmoLN
         MMucdZ7lr+4Ty+NcJF6cMPY50lQixKoTgaFxED76Jg7rFSaaYmrPA0zFBKor9dYeKexM
         fXKA==
X-Gm-Message-State: AOJu0YzQSPjdXhutEm6ZwonDnnWfddpQutkrDGVTSWj9a77ftkdvEE9a
	oaEfgpFF6fs6p6Zui6RKzLUA1wkK08KdhZqvcXdX9tNedCV8XN/lo4aI6eVVhf4Xj+lLJl0F+dB
	jd+Cqwl4qruS/K1n677FOssda7dV6TXM=
X-Gm-Gg: AZuq6aJiDWXotIES5ZbLo1rDuPf4ZVj/gG9L3spm0EdAHmlgaLjVTyflEbZ10ukCPDj
	XyGuYK8/5r/WePb2HdUKMIC3xlFJInRNOyM4BQ7YpSEjpewj9/0TBS6SOgohVv7fVzYIpxIWFeN
	U+aq0F6zjIFy4Fxn4ZyxGhRaJqC3AWD55HmQNzefsM/JHnqO4c6Vhagq4qeMI5LuG6qDaR6UsfU
	bTIFO6xHC4a0lRx3SY+KetaJHPHZGugzWyVU7/PAyg+0Og/T0DPKDDc+MA9e5xd3aAY9mgzRTu2
	0i3HDAnh+QLYKdjWvQYam8tumYRRzA==
X-Received: by 2002:a05:6402:354c:b0:64c:fc09:c956 with SMTP id
 4fb4d7f45d1cf-657ff4d53c4mr2074597a12.29.1768939137271; Tue, 20 Jan 2026
 11:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120131830.21836-1-jack@suse.cz> <20260120132313.30198-5-jack@suse.cz>
In-Reply-To: <20260120132313.30198-5-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 20:58:46 +0100
X-Gm-Features: AZwV_QgnkBr4VUe4FdvOswAb9U3EwGSETdiPlcLIzJmQOuQxDGSOQaAe0Fl1sB0
Message-ID: <CAOQ4uxi-0kM2bYYU9XJ=bbn0TSaHuDVdZ3MvmicnPXarDjEC-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Use connector hash for destroying inode marks
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74717-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: C30404B722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 2:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Instead of iterating all inodes belonging to a superblock to find inode
> marks and remove them on umount, iterate all inode connectors for the
> superblock. This may be substantially faster since there are generally
> much less inodes with fsnotify marks than all inodes. It also removes
> one use of sb->s_inodes list which we strive to ultimately remove.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c | 71 +++++++++++++-------------------------------
>  1 file changed, 20 insertions(+), 51 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 706484fb3bf3..a0cf0a6ffe1d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -34,62 +34,31 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mn=
tns)
>  }
>
>  /**
> - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched in=
odes.
> - * @sb: superblock being unmounted.
> + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched ino=
des.
> + * @sbinfo: fsnotify info for superblock being unmounted.
>   *
> - * Called during unmount with no locks held, so needs to be safe against
> - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and C=
AN block.
> + * Walk all inode connectors for the superblock and free all associated =
marks.
>   */
> -static void fsnotify_unmount_inodes(struct super_block *sb)
> +static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
>  {
> -       struct inode *inode, *iput_inode =3D NULL;
> -
> -       spin_lock(&sb->s_inode_list_lock);
> -       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> -               /*
> -                * We cannot __iget() an inode in state I_FREEING,
> -                * I_WILL_FREE, or I_NEW which is fine because by that po=
int
> -                * the inode cannot have any associated watches.
> -                */
> -               spin_lock(&inode->i_lock);
> -               if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | =
I_NEW)) {
> -                       spin_unlock(&inode->i_lock);
> -                       continue;
> -               }
> -
> -               /*
> -                * If i_count is zero, the inode cannot have any watches =
and
> -                * doing an __iget/iput with SB_ACTIVE clear would actual=
ly
> -                * evict all inodes with zero i_count from icache which i=
s
> -                * unnecessarily violent and may in fact be illegal to do=
.
> -                * However, we should have been called /after/ evict_inod=
es
> -                * removed all zero refcount inodes, in any case.  Test t=
o
> -                * be sure.
> -                */
> -               if (!icount_read(inode)) {
> -                       spin_unlock(&inode->i_lock);
> -                       continue;
> -               }
> -
> -               __iget(inode);
> -               spin_unlock(&inode->i_lock);
> -               spin_unlock(&sb->s_inode_list_lock);
> -
> -               iput(iput_inode);
> -
> -               /* for each watch, send FS_UNMOUNT and then remove it */
> +       struct fsnotify_mark_connector *conn;
> +       struct inode *inode;
> +
> +       spin_lock(&sbinfo->list_lock);
> +       while (!list_empty(&sbinfo->inode_conn_list)) {
> +               conn =3D fsnotify_inode_connector_from_list(
> +                                               sbinfo->inode_conn_list.n=
ext);
> +               /* All connectors on the list are still attached to an in=
ode */
> +               inode =3D conn->obj;
> +               ihold(inode);

Is this safe also without FSNOTIFY_CONN_FLAG_HAS_IREF?
These refs rules now got my brain in a knot..
Maybe it's worth having this explained in a comment.

Thanks,
Amir.

