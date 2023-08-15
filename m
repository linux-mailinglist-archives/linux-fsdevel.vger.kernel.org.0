Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396CB77D272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjHOSu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjHOStw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:49:52 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD391FDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 11:49:22 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-799761430c2so1555342241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692125347; x=1692730147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7wR14FuAmWjAskT1zInORycemUTsI7W4Ghm2tS27Rc=;
        b=HaJLvroAI1ZmzOuM7TMB5kjpVT/fImjwBMS8IAJox9COsiBLOIZxrV8ECacj8opN6N
         3wTMQxm5JBMO+JrEjpNmk+8O2IAw++5khh2NIvsivOkC2EJ8vVCJV+7iyRR/+9zlQ6ly
         IKEprvUNnwgOxQHQbv5pTGMuqInfMf5MaOUHgJ8O+lfR5zkOwH2i6O1e+EU87M4G96cU
         y9z+qOdBmHK9YQOafGAgcST1SIZYyyHVH0R895A4JEOdNVJjAk72X2hCbpLPvGh15DWA
         ANLa1S/41u4UJwsFL6HP4Qfh9/2RwF6xmHlbM4+oMmkYZLlZqhu4Qg+x2hhkhsPN2Yl4
         wwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125347; x=1692730147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7wR14FuAmWjAskT1zInORycemUTsI7W4Ghm2tS27Rc=;
        b=fsBD5Cq6xm1KrQHDWez14LwzqbaXxmkmHzwTVZYKN2alM1JWm3h1ndXbKx7YHOxfPC
         ZB+ubbbAeO8JcuJzzQoD/N02LBYI+N/xCd52AWnHGwjPLdz8WCZ1xnf+zIxg3Vz5vmPc
         Pl+8R26GQGHTgo4YnleDnXd/XyfzFIjUNflFcEqGLP43mptcvw8+mJzJsUXmLcTTtXSU
         LILA0kr5Sp7mP7AQQLUezqCkWNpf0qi0XD6JHl3ARau+eVDbwxks5j/RGgkdCteWfCMW
         +kpvU0aovEIWyqx9zHT6CDzt6KcbIqiLtD05Y9HL75H7/hrxPtB6rMUsqngAytyxWs/P
         yrIQ==
X-Gm-Message-State: AOJu0YwHLIjZAEARvPFeqWFv1jsq6FacNdi8t7u5jmhZM3cATbiWC0Bf
        gtMVlII0BdMILb37gOr11BHl7n4DM7E+Nr19fKU=
X-Google-Smtp-Source: AGHT+IEJbgSC2YM3ts2Dh2t0vH6Bh77BcnSy3nUI3CMBRJ36+5EsROYjP5pMbhkGGW0pd0sitPdzsrczjBZIVjQ0aX8=
X-Received: by 2002:a67:db19:0:b0:445:1ede:4e7d with SMTP id
 z25-20020a67db19000000b004451ede4e7dmr13429850vsj.21.1692125347053; Tue, 15
 Aug 2023 11:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230815165721.821906-1-amir73il@gmail.com> <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
 <12490760-d3fe-4b9d-b726-be2506eff30b@kernel.dk>
In-Reply-To: <12490760-d3fe-4b9d-b726-be2506eff30b@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 15 Aug 2023 21:48:55 +0300
Message-ID: <CAOQ4uxh4YYs2=mqqZMi-L=a19gmcgi7M+2F7iy2WDUf=iqZtxQ@mail.gmail.com>
Subject: Re: [PATCH] fs: create kiocb_{start,end}_write() helpers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 8:06=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/15/23 11:02 AM, Jens Axboe wrote:
> > On 8/15/23 10:57 AM, Amir Goldstein wrote:
> >> +/**
> >> + * kiocb_start_write - get write access to a superblock for async fil=
e io
> >> + * @iocb: the io context we want to submit the write with
> >> + *
> >> + * This is a variant of file_start_write() for async io submission.
> >> + * Should be matched with a call to kiocb_end_write().
> >> + */
> >> +static inline void kiocb_start_write(struct kiocb *iocb)
> >> +{
> >> +    struct inode *inode =3D file_inode(iocb->ki_filp);
> >> +
> >> +    iocb->ki_flags |=3D IOCB_WRITE;
> >> +    if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
> >> +            return;
> >> +    if (!S_ISREG(inode->i_mode))
> >> +            return;
> >> +    sb_start_write(inode->i_sb);
> >> +    /*
> >> +     * Fool lockdep by telling it the lock got released so that it
> >> +     * doesn't complain about the held lock when we return to userspa=
ce.
> >> +     */
> >> +    __sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> >> +    iocb->ki_flags |=3D IOCB_WRITE_STARTED;
> >> +}
> >> +
> >> +/**
> >> + * kiocb_end_write - drop write access to a superblock after async fi=
le io
> >> + * @iocb: the io context we sumbitted the write with
> >> + *
> >> + * Should be matched with a call to kiocb_start_write().
> >> + */
> >> +static inline void kiocb_end_write(struct kiocb *iocb)
> >> +{
> >> +    struct inode *inode =3D file_inode(iocb->ki_filp);
> >> +
> >> +    if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
> >> +            return;
> >> +    if (!S_ISREG(inode->i_mode))
> >> +            return;
>
> And how would IOCB_WRITE_STARTED ever be set, if S_ISREG() isn't true?

Good point.
I will pass is_reg argument from callers of kiocb_start_write() and
will only check IOCB_WRITE_STARTED in kiocb_end_write().

Thanks,
Amir.
