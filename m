Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389476D4B2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjDCO4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDCO4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:56:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12218256
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:56:23 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B67A3F239
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533782;
        bh=QKFW1qqDMg7TUFTrK+2Qi6gnM372KB4fmvKMLex5G+Y=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=e9ANU72CTRYwu0GOwrRkAzeD0fZ5jvfAbaNqqfBhxUafmGwWRvWk8TpC2zbke0PT1
         Ngdi5+LTGtzZeGpXpFliLZMZQnKxRJVF2Vzo2eJTYNjZlbCw0NLRZhTHjkDua82z+q
         Cv3aqPBydddHQrtnDhr1BVzuSWJxSo43eBzQOzHHsjun2WPgwZzNqy8gZMEy535WNy
         2sMpDhl34qwrbwI+rJUIZXYY1J8tRgG7mNW7q60ELV+81+4DxejmI60A8FS//1aYHE
         QKLwTlpS6+aMXXLbFrD0WOtO5n0sPIG8TnRWBXw4VXeBUqJKgUt7nrF7R01HujyVDp
         /G3sWBYQzgK7w==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5461fe3163eso163243707b3.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKFW1qqDMg7TUFTrK+2Qi6gnM372KB4fmvKMLex5G+Y=;
        b=y0qZe+o+81sTXJ/RRxi09pjsSZi7ydbzcQNPStLBk8uidsz4Ku8ETY34m+FpH8hrLS
         N/g76G4Wg0A9cCYF7ZU4b2h+vSXkUf70wALwSVuR0JMTjN2l14PmuVYzPj9X2Hms9jYW
         i17ijGRoe1gOyi2cfARZfj9eI87USTXa3YvirqLuGmeQQuYpBv7dWCpcRtK9lHi8nigS
         Rym7YSQCdZK8LbcRCRQ0mK532yyw4vQZzJHg1Z4cv3YhbC38l+X1X7pumGVIKaLJtUXm
         8GuuNTgMgvGarCfnvNXfMfeDg/yUIxOPAr+JZyyR9xQDZyc0JuomXFGhCAF+Zgc3nocj
         noyA==
X-Gm-Message-State: AAQBX9dyVXluw4S3jv7mFmaxeyI8eFqOlGE1gh44tun0gqOn5cNIYMTx
        3Lv3tcqYhGRmpgbpen3nURu1ozz1JjONAWDZWdWyh9UlkAkPqlczEWMGYPfc7HclFD1BcyiPsnq
        KWRaktsKa5q63+W1e92FHbYQMVCJX3bPxKwI6KBf7bQmMsosPyPSTa7aXb4g=
X-Received: by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id w3-20020a05690210c300b00b759519dbcdmr24303924ybu.12.1680533781632;
        Mon, 03 Apr 2023 07:56:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350axreC8nTu/BcJvXVvM3Fw+PAeFxvqfZczuCL4AzTyLhRk1OuU+7a3LYDnOFBj9EHxLe1TMvv7nzHP8/hI9TsA=
X-Received: by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id
 w3-20020a05690210c300b00b759519dbcdmr24303908ybu.12.1680533781406; Mon, 03
 Apr 2023 07:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com> <e49787bc-fd4f-1fdc-e66b-270ea8367a11@fastmail.fm>
In-Reply-To: <e49787bc-fd4f-1fdc-e66b-270ea8367a11@fastmail.fm>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 3 Apr 2023 16:56:10 +0200
Message-ID: <CAEivzxcdGBJeiLX1qRnNpiDxxCwwVCSax3ADzDfNTXwyWO0sYg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 3, 2023 at 8:19=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> > This ioctl aborts fuse connection and then reinitializes it,
> > sends FUSE_INIT request to allow a new userspace daemon
> > to pick up the fuse connection.
> >
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: St=C3=83=C2=A9phane Graber <stgraber@ubuntu.com>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: criu@openvz.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   fs/fuse/dev.c             | 132 +++++++++++++++++++++++++++++++++++++=
+
> >   include/uapi/linux/fuse.h |   1 +
> >   2 files changed, 133 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 737764c2295e..0f53ffd63957 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >   }
> >   EXPORT_SYMBOL_GPL(fuse_abort_conn);
> >
> > +static int fuse_reinit_conn(struct fuse_conn *fc)
> > +{
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_dev *fud;
> > +     unsigned int i;
>
> Assuming you have a malicious daemon that tries to cause bad behavior,
> only allow one ioctl at at time? I.e. add a value that reinit is in
> progress? And unset at the end of the function?

Have done. Thanks!
>
> > +
> > +     if (fc->conn_gen + 1 < fc->conn_gen)
> > +             return -EOVERFLOW;
> > +
>
> Add a comment, like
>
> /* Unsets fc->connected and fiq->connected and ensures that no new
> requests can be queued */
>
> ?

Have done.

>
> > +     fuse_abort_conn(fc);
> > +     fuse_wait_aborted(fc);
> > +
> > +     spin_lock(&fc->lock);
> > +     if (fc->connected) {
> > +             spin_unlock(&fc->lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (fc->conn_gen + 1 < fc->conn_gen) {
> > +             spin_unlock(&fc->lock);
> > +             return -EOVERFLOW;
> > +     }
> > +
> > +     fc->conn_gen++;
> > +
> > +     spin_lock(&fiq->lock);
> > +     if (request_pending(fiq) || fiq->forget_list_tail !=3D &fiq->forg=
et_list_head) {
> > +             spin_unlock(&fiq->lock);
> > +             spin_unlock(&fc->lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (&fuse_dev_fiq_ops !=3D fiq->ops) {
> > +             spin_unlock(&fiq->lock);
> > +             spin_unlock(&fc->lock);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     fiq->connected =3D 1;
> > +     spin_unlock(&fiq->lock);
> > +
> > +     spin_lock(&fc->bg_lock);
> > +     if (!list_empty(&fc->bg_queue)) {
> > +             spin_unlock(&fc->bg_lock);
> > +             spin_unlock(&fc->lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     fc->blocked =3D 0;
> > +     fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
> > +     spin_unlock(&fc->bg_lock);
> > +
> > +     list_for_each_entry(fud, &fc->devices, entry) {
> > +             struct fuse_pqueue *fpq =3D &fud->pq;
> > +
> > +             spin_lock(&fpq->lock);
> > +             if (!list_empty(&fpq->io)) {
> > +                     spin_unlock(&fpq->lock);
> > +                     spin_unlock(&fc->lock);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > +                     if (!list_empty(&fpq->processing[i])) {
> > +                             spin_unlock(&fpq->lock);
> > +                             spin_unlock(&fc->lock);
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +
> > +             fpq->connected =3D 1;
> > +             spin_unlock(&fpq->lock);
> > +     }
> > +
> > +     fuse_set_initialized(fc);
>
> I'm not sure about this, why not the common way via FUSE_INIT reply?

fuse_send_init will fail, if !fc->initialized (see fuse_block_alloc <-
fuse_get_req <- fuse_simple_background).

>
> > +
> > +     /* Background queuing checks fc->connected under bg_lock */
> > +     spin_lock(&fc->bg_lock);
> > +     fc->connected =3D 1;
> > +     spin_unlock(&fc->bg_lock);
> > +
> > +     fc->aborted =3D false;
> > +     fc->abort_err =3D 0;
> > +
> > +     /* nullify all the flags */
> > +     memset(&fc->flags, 0, sizeof(struct fuse_conn_flags));
> > +
> > +     spin_unlock(&fc->lock);
> > +
> > +     down_read(&fc->killsb);
> > +     if (!list_empty(&fc->mounts)) {
> > +             struct fuse_mount *fm;
> > +
> > +             fm =3D list_first_entry(&fc->mounts, struct fuse_mount, f=
c_entry);
> > +             if (!fm->sb) {
> > +                     up_read(&fc->killsb);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             fuse_send_init(fm);
> > +     }
> > +     up_read(&fc->killsb);
> > +
> > +     return 0;
> > +}
> > +
> >   void fuse_wait_aborted(struct fuse_conn *fc)
> >   {
> >       /* matches implicit memory barrier in fuse_drop_waiting() */
> > @@ -2282,6 +2388,32 @@ static long fuse_dev_ioctl(struct file *file, un=
signed int cmd,
> >                       }
> >               }
> >               break;
> > +     case FUSE_DEV_IOC_REINIT:
> > +             struct fuse_conn *fc;
> > +
> > +             if (!checkpoint_restore_ns_capable(file->f_cred->user_ns)=
)
> > +                     return -EPERM;
> > +
> > +             res =3D -EINVAL;
> > +             fud =3D fuse_get_dev(file);
> > +
> > +             /*
> > +              * Only fuse mounts with an already initialized fuse
> > +              * connection are supported
> > +              */
> > +             if (file->f_op =3D=3D &fuse_dev_operations && fud) {
> > +                     mutex_lock(&fuse_mutex);
> > +                     fc =3D fud->fc;
> > +                     if (fc)
> > +                             fc =3D fuse_conn_get(fc);
> > +                     mutex_unlock(&fuse_mutex);
> > +
> > +                     if (fc) {
> > +                             res =3D fuse_reinit_conn(fc);
> > +                             fuse_conn_put(fc);
> > +                     }
> > +             }
> > +             break;
> >       default:
> >               res =3D -ENOTTY;
> >               break;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 1b9d0dfae72d..3dac67b25eae 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -989,6 +989,7 @@ struct fuse_notify_retrieve_in {
> >   /* Device ioctls: */
> >   #define FUSE_DEV_IOC_MAGIC          229
> >   #define FUSE_DEV_IOC_CLONE          _IOR(FUSE_DEV_IOC_MAGIC, 0, uint3=
2_t)
> > +#define FUSE_DEV_IOC_REINIT          _IO(FUSE_DEV_IOC_MAGIC, 0)
> >
> >   struct fuse_lseek_in {
> >       uint64_t        fh;
