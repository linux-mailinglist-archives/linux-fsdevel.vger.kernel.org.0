Return-Path: <linux-fsdevel+bounces-74718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N/XArfib2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:16:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5F4B21B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53A27A4B93D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE077369231;
	Tue, 20 Jan 2026 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTEth8gr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D53019B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939239; cv=pass; b=GV4snrMgsc4yABX5OtgEIpfNJ4opA42K4TKD/l6S7DAUXYN5cTDWYHJsV03Vt5R+66+5Nkss5RsYdyOzF2wuKHkuW5S6FOHw7NvORgMo1A65giLsqYaTjYWiy8sQpEYyCaYex6t0Y12HKGAKLrVQKdKDe1AFXn1Yzwb9R8PIzrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939239; c=relaxed/simple;
	bh=daBrfrfljVu6UdlMybcqXqdwMqOkuQcCh2tla9nfcdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjWQ3IoYdhSJXEmI1qMZUu0o095oT+MxG0dwFXzunjtgQy+0Xd/w2PFJRx9ohRKfO6FtaRlUKe+N9qlwa3qF9tMENVU+vnM23yg2ti5nV+erEQZhli0eWjtqoJZjHPTQuISulF+JFfvBV4sGFiLGWXs/5zpIaz40FNsZEJQcliU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTEth8gr; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so8577031a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:00:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768939235; cv=none;
        d=google.com; s=arc-20240605;
        b=bUuWtRXp0KIb7ybkNi4vq6c+RZek//9kc2m32gX3HFjZrpXAJ5q5+fv2she2W6CNwy
         YOddsZ5VEmOx/E00he0MllO0H7dmklco9j8KYXwhoGaSXywMILxKe4La/KQOZgT3/SE7
         a4DymT46ETlNecfBLFtUKspopS1jVCHKyjwnAndMoGBDQniI/wFLk0mXRyjHJCHEyQz/
         Smg1n8mCBDUf/rq4nHmHv4nQJGHvRX8uh7iG2IhjYgKlYW526xRs9pGDL4dhJc6VVjR6
         ofWW5fh216gjCd0ALsgEVF2BxtOoZQ4qb/XogK268xOZ0yqEXJp1uF+1hpm6EeRN0WLA
         +OHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBMuXh3vgW6QOtS208m0iq19gc5b4+LbXLHQ8y8mSbc=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=RRnoNQzVQAEQX4o2w6nIt23idSO990qG8bHJUASpSf0aWoVZ2fSnHBD4oItmLi4JUc
         tNjmMTZaKGgUknXtK7M41izbWDfkHpX+PJZ4ST/LLPOP7pbrOy7jPrGAKV4jDvRUQiQE
         Dd7fAAfNNNCsew207MylLUWuk4MYFYW6PAJlcx/+AbSmS+M+Ygqq/KixuwyfCJAaBsbh
         ilEilosvNS0OCpxbTYX227OPFypuM41yihYWoMBh6+g8fMcm3YxU7NMKN+Ry0p0xxRNi
         gGt1IjW0EBE9H/lTxKTk5/s8cjZBlRpGyFu/sNV2NgnEfmbagDxRVbVfgyIra2MBLr0D
         uElw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939235; x=1769544035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBMuXh3vgW6QOtS208m0iq19gc5b4+LbXLHQ8y8mSbc=;
        b=OTEth8grIy1CU0NHQV2qQQTbxr6oBlAqjTj4hVxl5D4Qya2Qy0V8/taFTKt2Myxwao
         Pk4SZLjPo2BetRapEC3Oh9y2QzhARfBkA0yOoR0T0DjcVzDEoFbmIfpuwzVLl2WNjXv/
         qhXQXP1fMjTEVuPkaOt87XnuIyLdL9aN4mFHWPjIiiuNRJOemMLve3k9P8VofxG6xFqY
         WyRsPpLhbD/Mx6B7w42As9kHQkjM2fJAM8/8fNAhykQZr94BJ9AC8YzW+yAwgks0flqN
         eEzdRjEiBuTPulPVSyxH9gWIncBf+Sp0gn7UN68BaNuj6/uqZFcV87swPxQb9lVFQLi+
         gDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939235; x=1769544035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBMuXh3vgW6QOtS208m0iq19gc5b4+LbXLHQ8y8mSbc=;
        b=l1air5vGdxIcFgXNB1tnvPF8FE574lGaPs8AhIF4nBboEir5t90HFs9P7KtR5C61nA
         Y3ADDw3yFQ7H+Pbc3o60whJTDU7mfnIYYjzxHIFDoYgaW6e/z0s6QjHHsjP+/P/d6Ocb
         mEyJvLiin+Uuq0qYIDmxIRT/hczyIlDYD2eRtvAYPpPrnAgql6Pls3P4no9CkKx1j3kW
         fOh/F+n/bIqkJ7/iykQqG5nLhvZX2V7QVSb4JwVfQNEVKMVZI/cSSI3h2ykKfcjxNCGz
         bQ275eeZjrjnFfu0tcG9UJhKw50QTspknCLcl2obB5ZsJirsrsq3OdDb0mJ3rpj/pgyZ
         DJNw==
X-Gm-Message-State: AOJu0Yy3jP6DVdYjhBYU+PO7e4oTBhiWQwd0HgmarCrr3stkysDyDO4a
	+MxHLfW2it41lXzuxz6gCHZ775vt5j+DkXAYKXK5gG37dDB1+F0onC+YrLLFCa89dR5eeKivqgm
	xgD8WlBybLreSxnG6NX3m+A4dllV8BiM=
X-Gm-Gg: AZuq6aLJuryG2EA2HidM30sVsuzmy80zhOyBTteNKe5wqjaya3oQNcQBN3NYwoAPbV3
	tKtkkRhgtoLXnHvuKIkiE/cGD4zEU3zCHks+NTKXx5nWjwsMNmnz4N/MHNxYZcHLr4hTl8sclah
	ZsOMSrvNNPDtUhNLRnBCIG9ZCdSb+khSj1jNVB/gWf7Y7pcX0WEaSs/beSlDjc5nKf5u7pdpGMb
	ko/i8euEfWDKYb6pJs9zHPTqLqFK4rNFGvrwt2Pv/eWt7KYGMkRvj9d9x2dAfL+flpbgE1sTR9d
	kUVNESO+N2Jj0kd2bPGBpfvUAMbLrw==
X-Received: by 2002:a05:6402:2801:b0:649:cec4:2173 with SMTP id
 4fb4d7f45d1cf-657ff2a5c6cmr2067993a12.9.1768939234274; Tue, 20 Jan 2026
 12:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120131830.21836-1-jack@suse.cz> <20260120132313.30198-4-jack@suse.cz>
In-Reply-To: <20260120132313.30198-4-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 21:00:22 +0100
X-Gm-Features: AZwV_QjN8l4xQp3O_sofcLEGK2lK8DAoUKiOctTpBcUmBOzymu3nQ3PqEsv5Ark
Message-ID: <CAOQ4uxgVfXT+BBUNB8YO=_rwQSK=Ux2Si+d0cG0tOsneAACRsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fsnotify: Track inode connectors for a superblock
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
	TAGGED_FROM(0.00)[bounces-74718-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7CC5F4B21B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 2:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Introduce a linked list tracking all inode connectors for a superblock.
> We will use this list when the superblock is getting shutdown to
> properly clean up all the inode marks instead of relying on scanning all
> inodes in the superblock which can get rather slow.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fsnotify.c             |  8 ++-
>  fs/notify/fsnotify.h             |  5 +-
>  fs/notify/mark.c                 | 94 +++++++++++++++++++++++++++++---
>  include/linux/fsnotify_backend.h |  5 +-
>  4 files changed, 98 insertions(+), 14 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 71bd44e5ab6d..706484fb3bf3 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -112,7 +112,10 @@ void fsnotify_sb_delete(struct super_block *sb)
>
>  void fsnotify_sb_free(struct super_block *sb)
>  {
> -       kfree(sb->s_fsnotify_info);
> +       if (sb->s_fsnotify_info) {
> +               WARN_ON_ONCE(!list_empty(&sb->s_fsnotify_info->inode_conn=
_list));
> +               kfree(sb->s_fsnotify_info);
> +       }
>  }
>
>  /*
> @@ -777,8 +780,7 @@ static __init int fsnotify_init(void)
>         if (ret)
>                 panic("initializing fsnotify_mark_srcu");
>
> -       fsnotify_mark_connector_cachep =3D KMEM_CACHE(fsnotify_mark_conne=
ctor,
> -                                                   SLAB_PANIC);
> +       fsnotify_init_connector_caches();
>
>         return 0;
>  }
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 5950c7a67f41..4e271875dcad 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -67,6 +67,9 @@ static inline fsnotify_connp_t *fsnotify_sb_marks(struc=
t super_block *sb)
>         return sbinfo ? &sbinfo->sb_marks : NULL;
>  }
>
> +struct fsnotify_mark_connector *fsnotify_inode_connector_from_list(
> +                                               struct list_head *head);
> +
>  /* destroy all events sitting in this groups notification queue */
>  extern void fsnotify_flush_notify(struct fsnotify_group *group);
>
> @@ -106,6 +109,6 @@ static inline void fsnotify_clear_marks_by_mntns(stru=
ct mnt_namespace *mntns)
>   */
>  extern void fsnotify_set_children_dentry_flags(struct inode *inode);
>
> -extern struct kmem_cache *fsnotify_mark_connector_cachep;
> +void fsnotify_init_connector_caches(void);
>
>  #endif /* __FS_NOTIFY_FSNOTIFY_H_ */
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 55a03bb05aa1..bef5c06112f0 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -79,7 +79,8 @@
>  #define FSNOTIFY_REAPER_DELAY  (1)     /* 1 jiffy */
>
>  struct srcu_struct fsnotify_mark_srcu;
> -struct kmem_cache *fsnotify_mark_connector_cachep;
> +static struct kmem_cache *fsnotify_mark_connector_cachep;
> +static struct kmem_cache *fsnotify_inode_mark_connector_cachep;
>
>  static DEFINE_SPINLOCK(destroy_lock);
>  static LIST_HEAD(destroy_list);
> @@ -323,10 +324,12 @@ static void fsnotify_connector_destroy_workfn(struc=
t work_struct *work)
>         while (conn) {
>                 free =3D conn;
>                 conn =3D conn->destroy_next;
> -               kmem_cache_free(fsnotify_mark_connector_cachep, free);
> +               kfree(free);
>         }
>  }
>
> +static void fsnotify_untrack_connector(struct fsnotify_mark_connector *c=
onn);
> +
>  static void *fsnotify_detach_connector_from_object(
>                                         struct fsnotify_mark_connector *c=
onn,
>                                         unsigned int *type)
> @@ -342,6 +345,7 @@ static void *fsnotify_detach_connector_from_object(
>         if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_INODE) {
>                 inode =3D fsnotify_conn_inode(conn);
>                 inode->i_fsnotify_mask =3D 0;
> +               fsnotify_untrack_connector(conn);
>
>                 /* Unpin inode when detaching from connector */
>                 if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
> @@ -644,6 +648,8 @@ static int fsnotify_attach_info_to_sb(struct super_bl=
ock *sb)
>         if (!sbinfo)
>                 return -ENOMEM;
>
> +       INIT_LIST_HEAD(&sbinfo->inode_conn_list);
> +       spin_lock_init(&sbinfo->list_lock);
>         /*
>          * cmpxchg() provides the barrier so that callers of fsnotify_sb_=
info()
>          * will observe an initialized structure
> @@ -655,20 +661,80 @@ static int fsnotify_attach_info_to_sb(struct super_=
block *sb)
>         return 0;
>  }
>
> -static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
> -                                              void *obj, unsigned int ob=
j_type)
> +struct fsnotify_inode_mark_connector {
> +       struct fsnotify_mark_connector common;
> +       struct list_head conns_list;
> +};
> +
> +struct fsnotify_mark_connector *fsnotify_inode_connector_from_list(
> +                                               struct list_head *head)
>  {
> -       struct fsnotify_mark_connector *conn;
> +       return &list_entry(head, struct fsnotify_inode_mark_connector,
> +                         conns_list)->common;
> +}
>
> -       conn =3D kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KER=
NEL);
> -       if (!conn)
> -               return -ENOMEM;
> +static void fsnotify_init_connector(struct fsnotify_mark_connector *conn=
,
> +                                   void *obj, unsigned int obj_type)
> +{
>         spin_lock_init(&conn->lock);
>         INIT_HLIST_HEAD(&conn->list);
>         conn->flags =3D 0;
>         conn->prio =3D 0;
>         conn->type =3D obj_type;
>         conn->obj =3D obj;
> +}
> +
> +static struct fsnotify_mark_connector *
> +fsnotify_alloc_inode_connector(struct inode *inode)
> +{
> +       struct fsnotify_inode_mark_connector *iconn;
> +       struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(inode->i_sb)=
;
> +
> +       iconn =3D kmem_cache_alloc(fsnotify_inode_mark_connector_cachep,
> +                                GFP_KERNEL);
> +       if (!iconn)
> +               return NULL;
> +
> +       fsnotify_init_connector(&iconn->common, inode, FSNOTIFY_OBJ_TYPE_=
INODE);
> +       spin_lock(&sbinfo->list_lock);
> +       list_add(&iconn->conns_list, &sbinfo->inode_conn_list);
> +       spin_unlock(&sbinfo->list_lock);
> +
> +       return &iconn->common;
> +}
> +
> +static void fsnotify_untrack_connector(struct fsnotify_mark_connector *c=
onn)
> +{
> +       struct fsnotify_inode_mark_connector *iconn;
> +       struct fsnotify_sb_info *sbinfo;
> +
> +       if (conn->type !=3D FSNOTIFY_OBJ_TYPE_INODE)
> +               return;
> +
> +       iconn =3D container_of(conn, struct fsnotify_inode_mark_connector=
, common);
> +       sbinfo =3D fsnotify_sb_info(fsnotify_conn_inode(conn)->i_sb);
> +       spin_lock(&sbinfo->list_lock);
> +       list_del(&iconn->conns_list);
> +       spin_unlock(&sbinfo->list_lock);
> +}
> +
> +static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
> +                                              void *obj, unsigned int ob=
j_type)
> +{
> +       struct fsnotify_mark_connector *conn;
> +
> +       if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_INODE) {
> +               struct inode *inode =3D obj;
> +
> +               conn =3D fsnotify_alloc_inode_connector(inode);
> +       } else {
> +               conn =3D kmem_cache_alloc(fsnotify_mark_connector_cachep,
> +                                       GFP_KERNEL);
> +               if (conn)
> +                       fsnotify_init_connector(conn, obj, obj_type);
> +       }
> +       if (!conn)
> +               return -ENOMEM;
>
>         /*
>          * cmpxchg() provides the barrier so that readers of *connp can s=
ee
> @@ -676,7 +742,8 @@ static int fsnotify_attach_connector_to_object(fsnoti=
fy_connp_t *connp,
>          */
>         if (cmpxchg(connp, NULL, conn)) {
>                 /* Someone else created list structure for us */
> -               kmem_cache_free(fsnotify_mark_connector_cachep, conn);
> +               fsnotify_untrack_connector(conn);
> +               kfree(conn);
>         }
>         return 0;
>  }
> @@ -1007,3 +1074,12 @@ void fsnotify_wait_marks_destroyed(void)
>         flush_delayed_work(&reaper_work);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_wait_marks_destroyed);
> +
> +__init void fsnotify_init_connector_caches(void)
> +{
> +       fsnotify_mark_connector_cachep =3D KMEM_CACHE(fsnotify_mark_conne=
ctor,
> +                                                   SLAB_PANIC);
> +       fsnotify_inode_mark_connector_cachep =3D KMEM_CACHE(
> +                                       fsnotify_inode_mark_connector,
> +                                       SLAB_PANIC);
> +}
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 0d954ea7b179..95985400d3d8 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -553,7 +553,7 @@ struct fsnotify_mark_connector {
>                 /* Used listing heads to free after srcu period expires *=
/
>                 struct fsnotify_mark_connector *destroy_next;
>         };
> -       struct hlist_head list;
> +       struct hlist_head list; /* List of marks */
>  };
>
>  /*
> @@ -562,6 +562,9 @@ struct fsnotify_mark_connector {
>   */
>  struct fsnotify_sb_info {
>         struct fsnotify_mark_connector __rcu *sb_marks;
> +       /* List of connectors for inode marks */
> +       struct list_head inode_conn_list;
> +       spinlock_t list_lock;   /* Lock protecting inode_conn_list */
>         /*
>          * Number of inode/mount/sb objects that are being watched in thi=
s sb.
>          * Note that inodes objects are currently double-accounted.
> --
> 2.51.0
>

