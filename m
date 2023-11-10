Return-Path: <linux-fsdevel+bounces-2718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89D7E7B67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4161C20E5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF51B286;
	Fri, 10 Nov 2023 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEgapIt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017B1B281;
	Fri, 10 Nov 2023 10:31:21 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21DB28B3A;
	Fri, 10 Nov 2023 02:31:17 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66cfd35f595so11047966d6.2;
        Fri, 10 Nov 2023 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699612277; x=1700217077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4w0upfP4Gegx1Cltl9z8PvXz7R8ShmQI/s6tr6Y6o0=;
        b=gEgapIt3BilFCDQBZQqpwnVHPl2x8Uxy0ZsPpckc8HaNIiQUFQKpKoeGtQMa177uyk
         0TA9nS/viu4zuUFbFigeYFOrpyo4jtcOqeiM/3UKtJvyhXIsAJfVlDcs2DmAa/M+uxxz
         5wFQznY3grYvJC8iCTyGtRe9xNJRTxoALaRMPxbFuQ1G94GnA/QHAfBs0Boa2vj3MgdW
         PqVliQWHjIURN3OjD6dXK416E3jZ3PqOVJzGU2afXfNUol+3EMKo3ptBqesJwbrYHt+e
         Byx9zrDh2MR9RhfrpPytjCFXVCQHCupAGB4gO5gOqdT1osX8UjP/eosFnfxOB9irYD+x
         PeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699612277; x=1700217077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4w0upfP4Gegx1Cltl9z8PvXz7R8ShmQI/s6tr6Y6o0=;
        b=lFElBMso0ai92tvyrbrlJGNjStanD9apRqSE5YDZqz141mAXXubP0gmnXGQ3Bo97Re
         145cfCO0muemtKYAjI5EEuOe87/6TumhlvTXUa3B/fzebWeock2L+LCipp8capCkGh8R
         zSB+3gG2pftrKi7wLI86LhQC+edA2wxEtYbEx11gtDTEWVwkBGT1UpwfhGeW1JUUjcZC
         59U8b6wWvGv1vy/Xdk3hP5JiLmMFlDgpLo/yDpiIZYF9545QjYc/6WgQtnpxKg2fH1xv
         4fJ/uFkyaTBEgkRnvUtX5SvcRSkQw/QQaJXo1fQzLPgJeGesqE8yOL8nceomEYk2S7zN
         0o2w==
X-Gm-Message-State: AOJu0YykpOmsEiEgin3Cb1OaajJ0/toIEUMd7yknWxKjXJ1/IU1b6vsR
	bXXTMnNyEhVZHMqhpPJ79kkJsCESbw3nt61mWIs=
X-Google-Smtp-Source: AGHT+IEwJXEyD4ZuH8H+pGer0ELkw1c19ONVx2xJOuhAtrF7YqHiIFjcbbFgMdFGeaVb+NfgCN0QF2PvDOoJ8KkEcVI=
X-Received: by 2002:a05:6214:4013:b0:66d:4569:9941 with SMTP id
 kd19-20020a056214401300b0066d45699941mr7832547qvb.45.1699612276930; Fri, 10
 Nov 2023 02:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106224210.GA3812457@perftesting> <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org> <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org> <20231108-atemwege-polterabend-694ca7612cf8@brauner>
 <20231108-herleiten-bezwangen-ffb2821f539e@brauner> <ZUyCeCW+BdkiaTLW@infradead.org>
 <20231109-umher-entwachsen-78938c126820@brauner> <ZUzvkQfqEYbjXCMd@infradead.org>
 <20231110-vorleben-unvorbereitet-fe3b302c5079@brauner>
In-Reply-To: <20231110-vorleben-unvorbereitet-fe3b302c5079@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 Nov 2023 12:31:04 +0200
Message-ID: <CAOQ4uxheWsR5EWtCvZq33r1+LLj6ANQLi9OJKYBpDP92a6ZTkw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > you hit a mount point or another (nested) subvolume.  Can't comment
> > on overlayfs.  But if it keeps mixing things forth and back what would
>
> Overlayfs shows that this st_dev switching happens on things other than
> btrfs. It has nothing to do with subvolumes.

IMO, overlayfs is a good example of Pragmatism.

On some filesystems, following POSIX standard verbatim is not possible.
We care more about the users and about how the POSIX standard affects
real life applications, than about actually following the standard.

This table is complex, but it explains the tradeoffs that overlayfs
does when following strict POSIX is not possible:
https://docs.kernel.org/filesystems/overlayfs.html#inode-properties

In the Legacy case, where Uniform st_dev is not possible,
overlayfs preserve these important *practical* rules:
1. Unique st_dev,st_ino
2. Uniform st_dev across all directories (non-persistent st_ino)
3. Persistent st_ino for non-directories (non-uniform st_dev)

Rule #2 is important for traversal boundaries (e.g. find -xdev, du -x)

It's not mentioned in this table, but overlayfs f_fsid is and always
was uniform. Since v6.6, overlayfs f_fsid is also unique among
overlayfs instances.

I don't know of a good way to stop a thread where all that needs
to be said has been said, but my opinion is that this thread has lost
focus a long time ago.

I will post a new patch for fanotify with Jan's proposal to address
Christoph's concerns:
- no ->get_fsid() method
- no sb/mount mark on btrfs subvol

Thanks,
Amir.

