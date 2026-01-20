Return-Path: <linux-fsdevel+bounces-74616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCD8CFk2cGl9XAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:13:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D874F939
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A724C62AFF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC4D421F14;
	Tue, 20 Jan 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnV7t5AK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070293B8BA9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909421; cv=pass; b=PiSkljIxzLd6o+ASWK1eb7hs62FJ3yrJsw3nGV5gcxRc8g7jE1yrNMkiJ+yp1Hb78iI+XPFujyvcmLFhg+isZ4PtDQFEiUCAow30dHGr+OiO0RbAZX+O2n0HTAqiE5MjHx/9vVpkm1rr7ReXBcfhfKmOgL9TT9ZJLUfX1TjUF4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909421; c=relaxed/simple;
	bh=1VwsQmLa+K3rhCWbqAjBNdGMMTSK6tG7vq2ITYIvDyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cT/9x/4RyV6TK8iPvolh2wWsYuwzgolY9qhuimlZKX/a7XPTJZ1KbAhRjXdXXJXTGaqxgRGF90ZejGH5cLdOA7yR7t/RuzX8c/rnxhbOiwgaZsSm6T1vwfn2JyZue4A+P+uEfh34HDhYN4yyk5PmDzxxdALiNGW4ns2lU2QzQmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnV7t5AK; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so7229511a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 03:43:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768909418; cv=none;
        d=google.com; s=arc-20240605;
        b=jOZCI+NcN9ykp3URt1SOMcuEUP09y3dTLZVkCj+kk65oWEFNBx1SpxfWWl4kwgg7zJ
         lRMKUe7IhwPPFBiVHBn13NOOHuSlLujT5h/ZvVjedMdEaJFksCv7L73GPgInJfsnGUYU
         0qkfaelFzMwIUyxAlu3YPl3m8mtQOb4yCyD7gRIwRbNwdkjopdszirShsa6TqCJPVjH4
         mPlM450H/ET3nQIEIIm+gIW5rxFOLVU32yjsQwVSO55vvG4BpqBvGrFH4aLgfFCblar/
         sTXj6yvnHVxhccdpWXDonPPcPjthio1MdkQIIbGHr8quzw6ISePC27OxPZBLEwL+0yM7
         +piQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n8tOVxPutWESVDYdOGLQDV2ZFUoU+hPfX08YHeOFUTM=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=kpXfVEJRRR+mNr9Qul9ZURAXKsWcKIFQBIMjr3fT4PfW2mUn4uYIXah+KefCZjUybO
         ka6qn1wZd0hK8wiweyhrco3D80wvYM5p53Q6O4tFSq+K5Waa4599RANE+5Accrwm/dAC
         thvPEcdpJKcwgGRDCmQzjGLLRrzIXdztpYCqGSrTVUXlapcdAHHzII5EQatYc4/qc48W
         rkAPqFVTCLT6CIfHtxYuRO+XYfhEkYK/sZWdCVPHQeuzgMqXjxh5sRi8GpBFzbhyB2ch
         zdqRBABpNWhrVieY/46lOwMM1QvHlcTx8v3GGe8sgGmeR4f0ifuKpV4GXI9/glW5+1l+
         DIBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909418; x=1769514218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8tOVxPutWESVDYdOGLQDV2ZFUoU+hPfX08YHeOFUTM=;
        b=bnV7t5AKM83/9Zq+2cGwj0ULOKmiKVibGEu5ktIAfZ5HZdiTT07QKvOgRUMrlCrcFy
         unzDm9afkwp66GCFUAPxFIWBFOsTJTdzaH/wmPwj8LLOK5+9/fWNKpMA6/eMkvJw3mGP
         rhiP1EL/+CWaYIySbR8Nf8LE5MwcJ4lQdK3TXPGtPo+/i5+CcLfKCfNbm0PqG1X80CNh
         mp1ijVqq96rzyTPZImBhLUcWzfOFBjlMuB+2Pfl2B8XxKKN3HvHChL3RGzbXTSavmiqf
         Pc7xCZhFcob0tUV+dANq0N+8+jai8EOQCnXvGHVPrl1wINYN9C3SkB6nUJ5ZrDKqVG1I
         G6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909418; x=1769514218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n8tOVxPutWESVDYdOGLQDV2ZFUoU+hPfX08YHeOFUTM=;
        b=qVa//BvwrZraE5nPjEIPJs6YYnIZpPzh8mQGJpOaYNyV0TKlcJpZ6BC85rOcPBGOPY
         fKzmKE4cH/Q5ewQZHLP6DFQUIKVZ9DmB0vb0JqzsgtKmeW7JPVAvRWg/XAVUok4EtbqZ
         WEiUJdLiKda4MP8B4PtdlG7EnKPYjG2QuwOBAA6sdkE/ahuqvsmt6OvjUJcR3yu3/dNn
         XZlTLFP4e8FLOpsAvdJft7VslO7S+6pzH7Yvjv5Ga2iUib7k/zWIfnS9YWizbXKWF7ER
         bJSpPCDo6P920CJFv4Qi7uITVpiMscNGA6mWDtnDEfKJE5MCeP6/eWekQY9eSAYIbH8+
         qK1A==
X-Gm-Message-State: AOJu0YxQ4Ti2HGcbfxSlRqKZHUvc4MEpEpKs+LoLZ4QdJ4719g9GSz7k
	Umz0vo9IRNz3Ud45YUGvpNpPZv+4tOeTiS+rpnWL5orMuWqv97wc5e9wJWoHmcVmXZudfL8epAM
	bNilGfTotFKSjC/5Ze8q+Tc39flnYo0oBdBCVJcdDKA==
X-Gm-Gg: AZuq6aLI2UlD2y6eSYWvE8+ihxnSxjKJtZavt4XxdelKhnu0r62p/oMXX2OvCjh3e/O
	kisJqEcDMfnhcotj1pMssxFrKZz7ceLUD/RYYMHenQXLoSaYttoV/DWc0w+j8m0h65dSaF349Su
	c48IPI7JZFHdv0RVVLR5tyRBIrMt9IhwEbrTIkud42TSrt/rYD7WfVElWzLmdmvSaDKdHpUTFu4
	S/a7p5NIaO4dATh80NfFttdwwnUYe7fmOnXR4nHE2fcqH1vwG1YDldDHDsY8cOgRQG05juuq3L4
	iTjclx18uuY72Atuu3gNwToGc3KEqA==
X-Received: by 2002:a05:6402:1e93:b0:64c:fee2:1dc9 with SMTP id
 4fb4d7f45d1cf-65452ad113dmr10273408a12.21.1768909418183; Tue, 20 Jan 2026
 03:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119161505.26187-1-jack@suse.cz> <20260119171400.12006-5-jack@suse.cz>
In-Reply-To: <20260119171400.12006-5-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 12:43:26 +0100
X-Gm-Features: AZwV_QjkKAdNeEGy5HwuM0QpdjznZdr65iO7Yu4QIDxP_xASRwzwyNi_HzKjHZ0
Message-ID: <CAOQ4uxje6rMQGNHKYjjO9_Bw3nZuOTyephS=wcOBJSv+Kh27yQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsnotify: Use connector hash for destroying inode marks
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
	TAGGED_FROM(0.00)[bounces-74616-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:email]
X-Rspamd-Queue-Id: A8D874F939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 6:14=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Instead of iterating all inodes belonging to a superblock to find inode
> marks and remove them on umount, iterate all inode connectors for the
> superblock. This may be substantially faster since there are generally
> much less inodes with fsnotify marks than all inodes. It also removes
> one use of sb->s_inodes list which we strive to ultimately remove.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c | 74 +++++++++++++++-----------------------------
>  1 file changed, 25 insertions(+), 49 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 706484fb3bf3..16a4a537d8c3 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -34,62 +34,38 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mn=
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
> +       int idx;
> +       struct fsnotify_mark_connector *conn;
> +       struct inode *inode;
>
> +       /*
> +        * We hold srcu over the iteration so that returned connectors st=
ay
> +        * allocated until we can grab them in fsnotify_destroy_conn_mark=
s()

fsnotify_destroy_marks()

> +        */
> +       idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> +       spin_lock(&sbinfo->list_lock);
> +       while (!list_empty(&sbinfo->inode_conn_list)) {
> +               conn =3D fsnotify_inode_connector_from_list(
> +                                               sbinfo->inode_conn_list.n=
ext);
> +               /* All connectors on the list are still attached to an in=
ode */
> +               inode =3D conn->obj;
>                 __iget(inode);
> -               spin_unlock(&inode->i_lock);
> -               spin_unlock(&sb->s_inode_list_lock);
> -
> -               iput(iput_inode);
> -
> -               /* for each watch, send FS_UNMOUNT and then remove it */
> +               spin_unlock(&sbinfo->list_lock);
>                 fsnotify_inode(inode, FS_UNMOUNT);
> -
> -               fsnotify_inode_delete(inode);
> -
> -               iput_inode =3D inode;
> -
> +               fsnotify_destroy_marks(&inode->i_fsnotify_marks);
> +               iput(inode);
>                 cond_resched();
> -               spin_lock(&sb->s_inode_list_lock);
> +               spin_lock(&sbinfo->list_lock);

The list could be long.
Do we maybe want to avoid holding srcu read for the entire list walk?

Anyway, with or without, feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

