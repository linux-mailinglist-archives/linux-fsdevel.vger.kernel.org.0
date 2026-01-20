Return-Path: <linux-fsdevel+bounces-74622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PTQDfNYcWkNEwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:53:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5AF5F19B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2D50B0E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D371426EB6;
	Tue, 20 Jan 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/J75fD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC64426EA7
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910682; cv=pass; b=M8ulMA5UbnmX1fgy7UhpzZ6vBRVzpatG/VQECUjW/ooXqfPOIjucuEvLHfacYks5T4CXXcv8ensrwxXrdU3iFUD2IvnzMzgstc7QZECasbIZTJRqpchmilYck/0BaycScryGsHFz1GHc2h7RNYLDA6lvRJsnJC0nEZ8aSpvOQE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910682; c=relaxed/simple;
	bh=oVUJ0GBCvx6KMukf/dZBLNoshwjNmBz2UEqkphuOtFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQtNZS+HQgaOcbp/O8TWjHezoKIL8d1dDLrev+Nn2QtEhLHUXBysyzMZ0IxwrF56E64fCmUzTKtCyniPL72FFkAXKT7vTrNif/JxMeD1o/drwlUAcv1WixIUNE+Ff67k7VPFgXB+w4IZkVk+bXLq4e3hYGlVr/L4FHAEGj5upNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/J75fD5; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso7918171a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768910679; cv=none;
        d=google.com; s=arc-20240605;
        b=b6DuNKUQn20FtsJ5/MlfTbP9rjY9DADE+NjgFa/SUt37/oUPmsrlryL9OfCMi4irJF
         IB6z6v7vinlALCtFzTJSaDK+4Tje/ZAk/QJbvO7LwY3dxSgUCpgj7ZOqsf7vANrBdVTz
         vZgn8MTiJm1I5GzrDpbrk6xIpZqnvuaFHnTaHd3iG3/OVAZW+KeSqpBsYL5XqUiJRxvV
         rhka1BBb/+DtW6a+4tgBahRHeJrwHT00enzK7+7jsOi2dth5fD9BssXg0SPcL+ze5a78
         nsyGorKP3w/A//BbbG76cCU3X+vFpL99HcXISAH0RJ5fes0KPYLZE9xr3vjloEgE5uiY
         AqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=20EQaQt8Z7x9ZJWjyE6ryJrNF/IN+uq85v32Q8fUVsE=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=aD74Wk18Lij72qaxSDJVwxgsWZeiDsbXfg6LA6PB8THREP7QAn/E5ESV5EFoNn30o4
         z1ie/RMvIrriTPXfyJHhuVrsBpglhtWNIA0l669ATTdFYHMfjvAXpTtej5CFvx6+TuZe
         35NHzi784hY/E6/pfHCqsOns8IoBQcS8hyrHqkuuE0Z6mD3GH+/y7DZZIxLViUUH0tWQ
         civmQgPBhBOVAYcObsJ//DyuLz2XHw7a8rSul4KNOn68XNyfMtsnMTK0QFQ+eTvnk1gB
         MiQf4BOtE6qpejNLFjkALa4v9pMnPnQCiNvo97aludMWZweIai6fQn6elCRy3xTNtOSP
         LC4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768910679; x=1769515479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20EQaQt8Z7x9ZJWjyE6ryJrNF/IN+uq85v32Q8fUVsE=;
        b=M/J75fD5kvJ1sfNBoJp7qrXGw7TLgfEG/6/iMWMN4NeSB7w+2FKiGnvLdLCSPHUQBS
         fYH6MUJtRcASBw6mn7iq4hSSJTb89LOmAL8fR34bpih0MX/luHsad1hq6IgV+2vI5wUp
         6o/5OR7Ol8RXkqCFaVw7ZI7PAQLh3KPTwy0/owGRbWNWKynw/SOPgLDF6XcF42H4hMk+
         cAGk3LsKK5s9z9wR3Ud5i93zMmKCA+pueuvWr0bmnDbTR8xIfrgfPvrmQSnjutzOdJkH
         RcxMOppJZ2QzZp7gjr4mumzttUchX05GgmEPMZ4zPUxKvzlmeSfmE4Zd8SWgoBWHYoSG
         akIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910679; x=1769515479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20EQaQt8Z7x9ZJWjyE6ryJrNF/IN+uq85v32Q8fUVsE=;
        b=TCyn+PTH1SfrgfBw3JJn+0Suwx1FwFKS27Mva/hjgr3ZuRShuw5DzhysVOWu/aE6g9
         Md9D9v+AJfwy6k+k5yHK6zrmw3O/Z8hZ4nYKN5TmfLgWSsmnh9ppPlmaLFQgm8yw5ftf
         0g6FS+QN0sn4m2G4qIR2lF5d8n6HgHHByFs5sL9AISlDx9sos/YaNfgik6tBOsgYkkXe
         0fiW0NA85eIR0jvLmKOOY/bcEwqBQqy2dMm9HvJdw/mj8LENmSUDex976v8G2EqaPpFR
         DpTJ/PU2yg0TuNIHRwwhCKRRhRZ5iBrCvqyA3F0LcOQV3lKVPnokL1yDOrDvnol6UZ6b
         EO/w==
X-Gm-Message-State: AOJu0YwBR8HXedaST1WoLHB3TOjySoqbVY4GeBGAw7Vj/pJTpZyKfoy7
	9iN3vbMFPK+UXmxi4AxHoDvnKr+cb12wjM6IpS73O8gqOwa0UsAJOtvH6TJMG0Xxx6Am11B0stn
	xYqO89bkBArdxx4BTWL8yDRs1l8jw8m4=
X-Gm-Gg: AZuq6aJOWcfZVHQh7mGBNfqRe0IOBQyBl3Kd+zktPof0ypTXn4igfNja6+uF6uC9MhC
	3ejet3MIIUVNNi3ZI+Nd7doGJz/ERN468pNOfzpOCuERS20rg/BBW5jHcQXvC75po99xKA2jswU
	k7LQxhlJYhV9T6MUOCaQ8w8OwNvnSIbaEFiAxV/2nSn5X9392bK3A6H/Hu8bktX3vTam6P+s//m
	FsYRhVdkLiFxuUNFpgX5fdKzyJXtCo4hKUYd22uJCVq8V052ktZXOXq36AUoQU+IlMhhvRja/0E
	LjkEdZs+2c+MbXRQ4wAIOkY9rqXah4X2xx25gc3/
X-Received: by 2002:a17:907:702:b0:b87:2cf8:f7b2 with SMTP id
 a640c23a62f3a-b879324c7c0mr1420682266b.56.1768910678795; Tue, 20 Jan 2026
 04:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119161505.26187-1-jack@suse.cz> <20260119171400.12006-4-jack@suse.cz>
In-Reply-To: <20260119171400.12006-4-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 13:04:27 +0100
X-Gm-Features: AZwV_QhQmAmeCelIHXsr53WEk8FCpngaBFrT_JPjH29PlLtMo1aFMxKn69vf-7Y
Message-ID: <CAOQ4uxirm_zApKhBffJiGWgPi3AR-m3m4ruAFVSkQY7x59CEMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fsnotify: Track inode connectors for a superblock
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	DATE_IN_PAST(1.00)[34];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74622-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9C5AF5F19B
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 6:14=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Introduce a linked list tracking all inode connectors for a superblock.
> We will use this list when the superblock is getting shutdown to
> properly clean up all the inode marks instead of relying on scanning all
> inodes in the superblock which can get rather slow.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c             |  8 ++-
>  fs/notify/fsnotify.h             |  5 +-
>  fs/notify/mark.c                 | 97 +++++++++++++++++++++++++++++---
>  include/linux/fsnotify_backend.h |  6 +-
>  4 files changed, 102 insertions(+), 14 deletions(-)
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
> index 55a03bb05aa1..eb26bb8c5c63 100644
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
> @@ -655,20 +661,83 @@ static int fsnotify_attach_info_to_sb(struct super_=
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
> +       iconn->common.flags |=3D FSNOTIFY_CONN_FLAG_TRACKED;
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
> +       if (!(conn->flags & FSNOTIFY_CONN_FLAG_TRACKED))
> +               return;

Is this condition somehow possible?
If not, please add a WARN_ON_ONCE or consider dropping the flag
because it is equivalent to type =3D=3D FSNOTIFY_OBJ_TYPE_INODE,
is it not?
IOW, if conn->obj points to an inode, it is tracked, from alloc() to free()=
.

Unless I missed something?
I have no problem with keeping it as a sanity-explicit flag.

Thanks,
Amir.

