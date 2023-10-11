Return-Path: <linux-fsdevel+bounces-67-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419F7C5674
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F861C20F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E12031D;
	Wed, 11 Oct 2023 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeQfwUVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF62200BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 14:11:56 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC792
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:11:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27d104fa285so245828a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697033515; x=1697638315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diktmKnZlKDHMlOS1nZy0IHN9HF4FrvTueZRQ1H0Op0=;
        b=WeQfwUVrmCe9F34ZzkNr3CnOvr7OWOjj0/Gydu8lPP5liyqEnjuyX2muRDbdVwtUeD
         WfiKA2qCtXz16mp+knJZVlbjvFT8nLT323OuzFIMrB45oRB/D6cCXkNxD0PWKsEe9lN8
         HIjKTb8k3nrY/LONtTqNJ2Qu5CA7K1lh+fl6HgotPoWZiceWZa7fU1FDSWsmjTGhPT4i
         CXhTO0aRXxW/sccB1EQBubW3FVQKs4zzX2dQhJR4bgv/fuMMsN/x5FNj6rpAmP5MF2GU
         hADQkCgUJDUEFAf4ixPPeTNvTL7nSVTDDstcqdQ3mQ7wffMEL4mOrjjqIg7+3eJFvKDM
         03EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697033515; x=1697638315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diktmKnZlKDHMlOS1nZy0IHN9HF4FrvTueZRQ1H0Op0=;
        b=bA2GmmpG7akjWo88hadoa7aAoxlR6VUh+2QaN5L+VetDFFcwxefL4OocQWtq+aOF/S
         Y2nscTf2Y4Nle38RrtarKBEL54cWjGbafxG6AWYPFsqmJcsJCGJOe3RBbkjUOAUMFuj7
         kfOhK5VIqX7WAMn3RPxmdJde6xgu80hz8NqbutyjQ2yYDnJ9K2gDkGxwDLMTiR+J3CSY
         4TEQMUq7hfHS02Qq6rJe/4KWyjMgA1BvVygkVYfox2cHzQgr2AjIdM87FvOI9T/G+Hs3
         ClKe0QOFdSXQ2am9/n8FhscxM/ukgMsybtug4vInS6i16rwGDr+wwGbsIvtfKOyQcPkd
         Dd6Q==
X-Gm-Message-State: AOJu0YxeDgKejsk0qite4eOJ/pqcMD7L4CwaI7x1SZwLeH73KXMrdvjC
	PR9Eu57ovLs4ceyf/U0Vfde0hd8Pm4dP0Ff9QOwtYs3ebDxB52E=
X-Google-Smtp-Source: AGHT+IFPusr6Q9SYNPa2hcIJrxPzMKrzpV1ZPN99Sjw3INhy9DlwMzgUobW/ybCXdTRr5twHQgPOj7HEtil7EilNPIc=
X-Received: by 2002:a17:90a:9106:b0:261:685:95b6 with SMTP id
 k6-20020a17090a910600b00261068595b6mr20014164pjo.13.1697033514741; Wed, 11
 Oct 2023 07:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011052815.15022-1-lostzoumo@gmail.com> <20231011064608.GU800259@ZenIV>
In-Reply-To: <20231011064608.GU800259@ZenIV>
From: Mo Zou <lostzoumo@gmail.com>
Date: Wed, 11 Oct 2023 22:11:42 +0800
Message-ID: <CAHfrynPiUWiB0Vg3-pTi_yC6cER0wYMmCo_V8HZyWAD5Q_m+jQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fs: fix directory locking proofs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Al Viro <viro@zeniv.linux.org.uk> =E4=BA=8E2023=E5=B9=B410=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=B8=89 14:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 11, 2023 at 01:28:15PM +0800, Mo Zou wrote:
> > Commit 28eceeda130f ("fs: Lock moved directories") acquires locks also =
for
> > directories when they are moved and updates the deadlock-freedom proof
> > to claim "a linear ordering of the objects - A < B iff (A is an ancesto=
r
> > of B) or (B is an ancestor of A and ptr(A) < ptr(B))". This claim,
> > however, is not correct. Because cross-directory rename may acquire two
> > parents (old parent and new parent) and two child directories (source
> > and target) and the ordering between old parent and target (or new pare=
nt
> > and source) may not fall into the above cases, i.e. ptr(old parent) <
> > ptr(target) may not hold. We should revert to previous description that
> > "at any moment we have a partial ordering of the objects - A < B iff A =
is
> > an ancestor of B".
>
> Not quite.  I agree that the proof needs fixing, but your change doesn't
> do it.
>
> The thing is, the ordering in "neither is an ancestor of another" case
> of lock_two_directories() does, unfortunately, matter.  That's new,
> subtle and not adequately discussed.
>
> Another thing is that callers of lock_two_nondirectories() are not
> covered at all.
>
> I'll put something together and post it; it's 2:45am here at the moment,
> and I'd rather get some sleep first.

When trying to write a fix for the proof, I seem to encounter a corner
case that could lead to deadlocks. The key problem is that the code
introduces more inode-pointer orders between directories (originally,
there is at most one such order for cross-directory rename) and
inode-pointer orders are not compatible with ancestor orders, i.e.
they do not give a linear order!

Consider directories objects A, B, C. The pointer orders are that A < B
and C < A. And B is ancestor to C, so B < C. Thus we have A < B < C
< A!

A concrete deadlock  example can be constructed as follows. Suppose
the tree has following edges /A and /B/C and A < B and C < A. There are
three operations forming a deadlock.

rename(/A, /B) executes: lock /; lock A; (about to lock B)
unlink(/B/C) executes: lock B; (about to lock C)
rename(/A/x, /C/y) executes: lock C; (about to lock A)

