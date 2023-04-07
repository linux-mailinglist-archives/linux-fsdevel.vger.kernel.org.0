Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88186DA906
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjDGGm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDGGm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:42:56 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01165FCB;
        Thu,  6 Apr 2023 23:42:55 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id z17so29618828vsf.4;
        Thu, 06 Apr 2023 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680849775; x=1683441775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORI0Nb0EBCw0cSM2p/7ooZHHouYocddDjv9zZfdUt+I=;
        b=J2o/4Ycq1LbUJeuY1/DMJqlbK41yvanateGMhgJCRcDIjZoYU02dMFKxgeKzsxwdGM
         QjdVLPHeW+sgF/pjOfNWsfmSUYSjn964LY7FrVIQ8vaf7+EEcHkJtd3ZQi3xRjAaeu86
         cMU+8M3qZ0ehPeP5XfjZn6AxF6xJU7bNmBfDkis55rxrr2/Ok1VD0OWTKmdrHq8249LZ
         AetOgT3CYHM+QxZi/D0kDTxQ8zbX9iV2xlDJLh9EQNna8mnE1xxJ9qcrnnf1GWsfdAYF
         cFlYT1mklyrOvIE1nYkcr1sYCPrAkGBtxR3NP9eWmAfJm9XeOK2WiTm/a1OKrn6Gz9k3
         Geag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680849775; x=1683441775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORI0Nb0EBCw0cSM2p/7ooZHHouYocddDjv9zZfdUt+I=;
        b=QjkNWQIf6IXxXeYyIUz0NxE8jtEw/jX6+s6XnRlRuxcTWem7Ow9JMbeQ089szOXjXw
         a3z+frxSeRNqHuf9HlRsq1acPXRz2+RFa5dxwgmKGhKfpF5FcNtIu7IJC0vw2B/RYgWr
         vJrgY70rg4RAiefBV5d6PXRSjmxiKKIbNCerDjPtK3L3WTvkeDYYo7kBT/1YVMJsqoaD
         e3OY0wCqWgkHrxl2CoNRbNRmh6a6x9i0c9XVeVkeb+g2x/AU3lvrlk2Ehz3CZ0zF/TR1
         5jWG4J4Yj34tKvwcgyQcAqfdUB6OXffAk4RvCYUlCMogSrJ0YUtTuy998yGUcyxLT//3
         Ylaw==
X-Gm-Message-State: AAQBX9d1QmmnqkFlJtb2L5VpfRFhYxA2anl4/Rpank0SvR1jVhWY5g4K
        BcE/LNHYuiJtrhx+AS/nnCnoIEv/o4NRnvFCJkn9CTlB+Vk=
X-Google-Smtp-Source: AKy350aiJxvHCooewzozXsmKXARhpAB0L47fNUhL40jANTXN6c8HxALaTorTsW7+fopE4GfIBFZFlh/LwyQMVxLoH7k=
X-Received: by 2002:a67:d59c:0:b0:42a:2785:102e with SMTP id
 m28-20020a67d59c000000b0042a2785102emr644152vsj.0.1680849774774; Thu, 06 Apr
 2023 23:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner> <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com> <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
 <20230406-wasser-zwanzig-791bc0bf416c@brauner> <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
 <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com> <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
 <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
In-Reply-To: <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 7 Apr 2023 09:42:43 +0300
Message-ID: <CAOQ4uxgoMsQnoe7VFtTDCGK_FWk==fCa8rfJ0uUr2XeWpKLy=g@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 6, 2023 at 11:23=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 4/6/23 15:37, Jeff Layton wrote:
> > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> >>
> >> On 4/6/23 14:46, Jeff Layton wrote:
> >>> On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> >>>> On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> >>
> >>>
> >>> Correct. As long as IMA is also measuring the upper inode then it see=
ms
> >>> like you shouldn't need to do anything special here.
> >>
> >> Unfortunately IMA does not notice the changes. With the patch provided=
 in the other email IMA works as expected.
> >>
> >
> >
> > It looks like remeasurement is usually done in ima_check_last_writer.
> > That gets called from __fput which is called when we're releasing the
> > last reference to the struct file.
> >
> > You've hooked into the ->release op, which gets called whenever
> > filp_close is called, which happens when we're disassociating the file
> > from the file descriptor table.
> >
> > So...I don't get it. Is ima_file_free not getting called on your file
> > for some reason when you go to close it? It seems like that should be
> > handling this.
>
> I would ditch the original proposal in favor of this 2-line patch shown h=
ere:
>
> https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b22=
1af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
>
>
> The new proposed i_version increase occurs on the inode that IMA sees lat=
er on for
> the file that's being executed and on which it must do a re-evaluation.
>
> Upon file changes ima_inode_free() seems to see two ima_file_free() calls=
,
> one for what seems to be the upper layer (used for vfs_* functions below)
> and once for the lower one.
> The important thing is that IMA will see the lower one when the file gets
> executed later on and this is the one that I instrumented now to have its
> i_version increased, which in turn triggers the re-evaluation of the file=
 post
> modification.
>
> static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> [...]
>         struct fd real;
> [...]
>         ret =3D ovl_real_fdget(file, &real);
>         if (ret)
>                 goto out_unlock;
>
> [...]
>         if (is_sync_kiocb(iocb)) {
>                 file_start_write(real.file);
> -->             ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
>                                      ovl_iocb_to_rwf(ifl));
>                 file_end_write(real.file);
>                 /* Update size */
>                 ovl_copyattr(inode);
>         } else {
>                 struct ovl_aio_req *aio_req;
>
>                 ret =3D -ENOMEM;
>                 aio_req =3D kmem_cache_zalloc(ovl_aio_request_cachep, GFP=
_KERNEL);
>                 if (!aio_req)
>                         goto out;
>
>                 file_start_write(real.file);
>                 /* Pacify lockdep, same trick as done in aio_write() */
>                 __sb_writers_release(file_inode(real.file)->i_sb,
>                                      SB_FREEZE_WRITE);
>                 aio_req->fd =3D real;
>                 real.flags =3D 0;
>                 aio_req->orig_iocb =3D iocb;
>                 kiocb_clone(&aio_req->iocb, iocb, real.file);
>                 aio_req->iocb.ki_flags =3D ifl;
>                 aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
>                 refcount_set(&aio_req->ref, 2);
> -->             ret =3D vfs_iocb_iter_write(real.file, &aio_req->iocb, it=
er);
>                 ovl_aio_put(aio_req);
>                 if (ret !=3D -EIOCBQUEUED)
>                         ovl_aio_cleanup_handler(aio_req);
>         }
>          if (ret > 0)                                           <--- this=
 get it to work
>                  inode_maybe_inc_iversion(inode, false);                <=
--- since this inode is known to IMA

If the aio is queued, then I think increasing i_version here may be prematu=
re.

Note that in this code flow, the ovl ctime is updated in
ovl_aio_cleanup_handler() =3D> ovl_copyattr()
after file_end_write(), similar to the is_sync_kiocb() code patch.

It probably makes most sense to include i_version in ovl_copyattr().
Note that this could cause ovl i_version to go backwards on copy up
(i.e. after first open for write) when switching from the lower inode
i_version to the upper inode i_version.

Jeff's proposal to use vfs_getattr_nosec() in IMA code is fine too.
It will result in the same i_version jump.

IMO it wouldn't hurt to have a valid i_version value in the ovl inode
as well. If the ovl inode values would not matter, we would not have
needed  ovl_copyattr() at all, but it's not good to keep vfs in the dark...

Thanks,
Amir.
