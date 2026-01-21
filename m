Return-Path: <linux-fsdevel+bounces-74879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM8jNBUncWmqewAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:20:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430B5C08B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD62A803612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869F397AC7;
	Wed, 21 Jan 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3zv/U0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D833345A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012881; cv=pass; b=YRrsAIIuswrshmOG5gCNpudIIZbY6FWQPwbWWAQSmSeb69SbM4/1az5KAam2YKvJdQxvIVL8QGHN/pl5poBdY1EiLPlojYPQZ6L82XtujXvPEw09qs5+ZEiZNUHmTi8/AUSjb8od4AKwbGWbrZ45734QEx+JvdVRo3ShBU0xJUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012881; c=relaxed/simple;
	bh=YV4YGaZ6tXvLAQDtimpgsFbhHpKrjOWXEmIJn7VIURY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6Q73ahaIlhZ3LNXs7NUFi1PgOB6xyX43KK+HTxs87RvmWBPtZO3dsrh8K9XP5Vbp7jRiGlbK6JipIBEav/PJzHJ3a89JtEnXdz/7ksu3ZbBnuryz0IoCTv88zkQ1mozS6+6rH7ZrMo294ZnIGaqwM4BPVlq7hHGZs10c6bz+F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3zv/U0U; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8768225837so958256566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 08:27:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012877; cv=none;
        d=google.com; s=arc-20240605;
        b=UsssRRw4Hy67HJj6OxrxnfeC81vI5l1CVkRlGcXhk9Dz130owjqirizvKknGG4gfov
         1NCSDueVD5Zqh19/RrljWxOEEMkb0XJ7G0gbjSU4ziWfEYP3CJQm5r3AT2ZAHPg69ISM
         ZSy2uWwYljo9W7fJ3RhMs6Y+viOFZvgOVr6gtiIwAwwEDwDqz6uJjLttnQGVQrzKzgOE
         mLofOO3V1ZjU2zs+eudONJ8Tz1qgElQdJjwVg2srqB11ZCiDMXeq8gkSuoIN+4ODxYe+
         aQKxwmqRDKCXi9mWYhZZhq8/Qrqem0LPfmilJcSoEi9QvwGW8eT09twthxR7zR186UJn
         izdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d7AtZypK6sAGowgLFhYLtC1ra9KgYFPv+SrEn+Ct+kY=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=hDCQoq9VSuEQnnaTXQMPG0E9tgQjM5q9EZtNq4089uam+k3BIYKMqXlJpNfhyWmZwc
         OzVoqUv5Rxbt9I6gB+rE4Sn44ZLlAxLsCavtkD66QncVbF5BxOYf8kCRwCj7/FyFtURJ
         lRjxxkaIl9CUaN/QjmvFHko9mirrqWE+orfrM5+py0hTPa7JGfT2URDbnjIGMLhm/O/n
         sRQidap86fl39ydZ2zbZ0GBUm7mNWEwBXp5qJUou1DLjCB+VKOEIuJbqhxn4ELKVbnkP
         MIoCIz+Ry6atG+5dbtyAKXpxEAvVmhdGvCRfu/5lhPYl+1I7UtJiw8UX+uzGwnjg6Zmt
         RBZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012877; x=1769617677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7AtZypK6sAGowgLFhYLtC1ra9KgYFPv+SrEn+Ct+kY=;
        b=O3zv/U0UKMlBkIH21N/JSaXiZCzmtwT+GZH35fkr+P3hTSHp45t/Gl2G4ztdmbARz1
         OpF8M+gfHGr68SUF6Zkn5cj55eIMhmM8OolLxCOBss4iSNoQf4oEdW+FUpPcrWxBmQjc
         KCSZlw9eVWWQoumOVDO4dGtRDJqWGsJQDn4HvmEFDCRRHB5XIlQEAwi1D11opL8wQtOk
         PX2nrWhP8iFOXzQavxIDbMmq3mKdX5N+c3Za8dhYdjPj4eFMS71BDjMFD8seFLBAVabD
         Hbs3/WPSeqopvoYFcyDqGBaGlNt8tuXTztTrRqnp2lPTfCbY7OnwWvPaJplNyy16V/pe
         0IvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012877; x=1769617677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7AtZypK6sAGowgLFhYLtC1ra9KgYFPv+SrEn+Ct+kY=;
        b=Zl00bI6wAOU2d0Jw/2X5s2vc89wkzhRgYAae07KavSUjP1g73+lmJCDFrrHr9EWG0k
         O7sIpvCrq6S0Q6mfpQA4aBJfuVGQCCDm6P6/3QQXjhQ+/xeh14VpyngpGqrW1aHlcORv
         +GgngayD8jgbYHM7RO7qqJ7e5Q7cuDuR+iIUBMiI2jTzGuFBoihtHBAGdTQUgFlazVBW
         zF2x9ZUSf2zSZiTmPp/QN/jlVeZEKLhRqgxYgaztXF/uPw9fbd1wdavIri57n8AwfwLx
         EgCGKCUVcdBGUSOh3DOeEGUCWfRZ78Ixjchpc5GgfvLutD5kM0f370aHxVRRCpt/xNHc
         N5fQ==
X-Gm-Message-State: AOJu0Yw868hcBaVMcMAIWlbfMKmqLNpUTtfmrvS1kUTLiutzXGQf94h2
	i3tJSeORK0PixbcX6vE/lTAjEPUufdyEJFLVeX4WRwEZ5rN8hgfmmv71j+eptO7ez23C2BXZSnn
	9JTipkdgLwhAO14UESujwP+5sLxArmxMR6Y5RuMA=
X-Gm-Gg: AZuq6aKjL+W5Nxckoj2MtfHbGLB1b0T55EG7TGh9V+5cAFLWavRsppyulYNrKV1xuHN
	e7kwyjGXeqZxXUer/7LAyjnPcCwVz2FbMeG51wa7amAaiYZ3NTqB4DH5QLzwHNkyRliiEd+MK0c
	bY8cs+5XSDmZeHlQiU/BKNddyyjBJ9wbeyO0PE3DCZa2L/wyQgt9s18KGLK/3FMYcqxv9XxFYHj
	sCM3WyKJCFGrrn/HzYa6AXA5+9n7DbpKW6N9lmvLhcZkE7jEcvZ36O+OJ/N84lyKTO27MiZqTIl
	GWvutDn2KNeYadqreg1FZfKd8Lw=
X-Received: by 2002:a17:907:d7cb:b0:b86:eda4:f770 with SMTP id
 a640c23a62f3a-b8792e0cda9mr1765044766b.21.1769012877010; Wed, 21 Jan 2026
 08:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121135513.12008-1-jack@suse.cz> <20260121135948.8448-5-jack@suse.cz>
In-Reply-To: <20260121135948.8448-5-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 17:27:45 +0100
X-Gm-Features: AZwV_Qi_YPGtpEQjzRydI_bwm4mylyhC9R_GQN10ABicTqCncQx-ZqcM4iN5fdc
Message-ID: <CAOQ4uxg4HrLqizEdgc8TUaZOUbBTR1if0SBSwxeu5VKAwU5FBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fsnotify: Use connector list for destroying inode marks
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
	TAGGED_FROM(0.00)[bounces-74879-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 7430B5C08B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Instead of iterating all inodes belonging to a superblock to find inode
> marks and remove them on umount, iterate all inode connectors for the
> superblock. This may be substantially faster since there are generally
> much less inodes with fsnotify marks than all inodes. It also removes
> one use of sb->s_inodes list which we strive to ultimately remove.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c | 61 +-------------------------------------------
>  fs/notify/fsnotify.h |  3 +++
>  fs/notify/mark.c     | 41 +++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 60 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 706484fb3bf3..9995de1710e5 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -33,65 +33,6 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mnt=
ns)
>         fsnotify_clear_marks_by_mntns(mntns);
>  }
>
> -/**
> - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched in=
odes.
> - * @sb: superblock being unmounted.
> - *
> - * Called during unmount with no locks held, so needs to be safe against
> - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and C=
AN block.
> - */
> -static void fsnotify_unmount_inodes(struct super_block *sb)
> -{
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
> -               fsnotify_inode(inode, FS_UNMOUNT);
> -
> -               fsnotify_inode_delete(inode);
> -
> -               iput_inode =3D inode;
> -
> -               cond_resched();
> -               spin_lock(&sb->s_inode_list_lock);
> -       }
> -       spin_unlock(&sb->s_inode_list_lock);
> -
> -       iput(iput_inode);
> -}
> -
>  void fsnotify_sb_delete(struct super_block *sb)
>  {
>         struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> @@ -100,7 +41,7 @@ void fsnotify_sb_delete(struct super_block *sb)
>         if (!sbinfo)
>                 return;
>
> -       fsnotify_unmount_inodes(sb);
> +       fsnotify_unmount_inodes(sbinfo);
>         fsnotify_clear_marks_by_sb(sb);
>         /* Wait for outstanding object references from connectors */
>         wait_var_event(fsnotify_sb_watched_objects(sb),
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 6b58d733ceb6..58c7bb25e571 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -77,6 +77,9 @@ extern struct srcu_struct fsnotify_mark_srcu;
>  extern int fsnotify_compare_groups(struct fsnotify_group *a,
>                                    struct fsnotify_group *b);
>
> +/* Destroy all inode marks for given superblock */
> +void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo);
> +
>  /* Destroy all marks attached to an object via connector */
>  extern void fsnotify_destroy_marks(fsnotify_connp_t *connp);
>  /* run the list of all marks associated with inode and destroy them */
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 4a525791a2f3..1b955000ad5b 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -666,6 +666,47 @@ struct fsnotify_inode_mark_connector {
>         struct list_head conns_list;
>  };
>
> +/**
> + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched ino=
des.
> + * @sbinfo: fsnotify info for superblock being unmounted.
> + *
> + * Walk all inode connectors for the superblock and free all associated =
marks.
> + */
> +void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
> +{
> +       struct fsnotify_inode_mark_connector *iconn;
> +       struct inode *inode;
> +
> +restart:
> +       spin_lock(&sbinfo->list_lock);
> +       list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list) =
{
> +               /* All connectors on the list are still attached to an in=
ode */
> +               inode =3D iconn->common.obj;
> +               /*
> +                * For connectors without FSNOTIFY_CONN_FLAG_HAS_IREF
> +                * (evictable marks) corresponding inode may well have 0
> +                * refcount and can be undergoing eviction. OTOH list_loc=
k
> +                * protects us from the connector getting detached and in=
ode
> +                * freed. So we can poke around the inode safely.
> +                */

OK. You convinced me that this is safe.

> +               spin_lock(&inode->i_lock);
> +               if (unlikely(
> +                   inode_state_read(inode) & (I_FREEING | I_WILL_FREE)))=
 {
> +                       spin_unlock(&inode->i_lock);
> +                       continue;
> +               }
> +               __iget(inode);
> +               spin_unlock(&inode->i_lock);
> +               spin_unlock(&sbinfo->list_lock);
> +               fsnotify_inode(inode, FS_UNMOUNT);
> +               fsnotify_clear_marks_by_inode(inode);
> +               iput(inode);
> +               cond_resched();
> +               goto restart;
> +       }

This loop looks odd being a while loop that is always restarted for
the likely branch.

Maybe would be more clear to add some comment like:

find_next_inode:
       /* Find the first non-evicting inodes and free connector and marks *=
/
       spin_lock(&sbinfo->list_lock);
       list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list) {

Just a thought.

Anyway, with or without it, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

