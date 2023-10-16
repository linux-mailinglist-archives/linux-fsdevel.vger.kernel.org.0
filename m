Return-Path: <linux-fsdevel+bounces-502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0A7CB661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424001C20BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166F38F9C;
	Mon, 16 Oct 2023 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZNsRbOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD70381DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 22:14:21 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A19B;
	Mon, 16 Oct 2023 15:14:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso4055113e87.1;
        Mon, 16 Oct 2023 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697494458; x=1698099258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvN8fCLlFe7Jrcf7tnyNS2O/KMreYubvjkRXV3ZF900=;
        b=jZNsRbOSRBEMNnJXAd+I0My/oZyydqs0wjNPcMlv/8bALsBZSfk7rpti63vbfe20Sv
         dkngUZ1vpxkTz+7lrxBsLZ0zvgwF/VuxX5bcJncSEao90kNyyOV9FydZ3GKM15K3/1sB
         HG4XG/JHzfSoPDYY1FXF1R0mtZELyQWV9xJLjrZZeqEcsXql64EJwIStXPlZAdDnZx63
         xoQgKkUhlQ57yAwANd1i2fj4BBdnJGPCbfIXF4tpE4II09PDXQr5StKTJlZdjJGfuaOS
         b9e3a3nnTAw+IzDgOtVkoq3Ynk3aTYCd6Yo3u2PID1Rz9STocQzvjrJsCI85CJRbvagr
         cCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494458; x=1698099258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvN8fCLlFe7Jrcf7tnyNS2O/KMreYubvjkRXV3ZF900=;
        b=TmEFoxeKI9/gHylF5VtL7bStJ2KCux0qEGbKmt/0ED+FVbiB2zXvcwzY3wWsSUZRgG
         /xhcl0uCPvK+W7gJX6nEOUmku1mVp1NGZBWxOVaGEPwBt+fuBuSHvzCIQOGnLyttMDVe
         pMR+ps1KYwXH1DhQYic/AE7R5BZuEGtBaOG3GyF/pgGeE+0aocEy4iFJnVacjC3SZDDl
         3KzYtIcuw0lyqXAiKvtgAA4JwUkmJuIyelnu2RcB4s0le2iOkyBBRc87QpKxbIpB8fdD
         aUDJ8dA5IchasBHf80EUtVKJ3ljFG06IYY1FURa9qnZT1Yw9qvPf+Rb/LgOLxwZqqp1d
         RAww==
X-Gm-Message-State: AOJu0Yycw771QItygW18NUaG6EUsAhXSRYfPvf9uVH2iT0lLRyp/w+2D
	QtmmL4WDH3QfvU0BlswCo+SmrWuI55TpLc8YHDgPGGSAP+bezw==
X-Google-Smtp-Source: AGHT+IFXFt/eaJWjHKduGhvzniZ6R3YYjayeqqEwooMHqMLyF5XD1We0e5s+zndoyLW1kupxy0QwGcfYS3q2cotGUGo=
X-Received: by 2002:ac2:5de2:0:b0:503:1775:fc1 with SMTP id
 z2-20020ac25de2000000b0050317750fc1mr474446lfq.31.1697494458303; Mon, 16 Oct
 2023 15:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mui-uk5XVnJMM2UQ40VJM5dyA=+YChGpDcLAapBTCk4kw@mail.gmail.com>
 <ZS1zSoRwv+yr5BHS@casper.infradead.org>
In-Reply-To: <ZS1zSoRwv+yr5BHS@casper.infradead.org>
From: Steve French <smfrench@gmail.com>
Date: Mon, 16 Oct 2023 17:14:06 -0500
Message-ID: <CAH2r5mvBqqas=qrR+Sxfz2T99B2YbuJRn1O8vdpXhUc1CcnoQw@mail.gmail.com>
Subject: Re: [PATCH][SMB3 client] fix touch -h of symlink
To: Matthew Wilcox <willy@infradead.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 12:30=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Oct 16, 2023 at 12:26:23PM -0500, Steve French wrote:
> > For example:
> >           touch -h -t 02011200 testfile
> >     where testfile is a symlink would not change the timestamp, but
> >           touch -t 02011200 testfile
> >     does work to change the timestamp of the target
> >
> > Looks like some symlink inode operations are missing for other fs as we=
ll
>
> Do we have an xfstests for this?

I was thinking the same thing - would be useful to add an xfstest for
this.  I actually noticed this old bug when someone reported an
unrelated problem (where "find . -type l" doesn't show the symlink but
"ls" and "stat" do) and the other unrelated symlink bug could be
useful to add to the same test

Are there other scenarios we could repro problems to an fs that
doesn't have a .getattr method (like cifs.ko, afs) or .permission
(like nfs and ext4)?


--=20
Thanks,

Steve

