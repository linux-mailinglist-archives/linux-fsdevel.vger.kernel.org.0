Return-Path: <linux-fsdevel+bounces-2054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA97E1D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4A1C20AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFA16428;
	Mon,  6 Nov 2023 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqy/RKW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D716413
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 09:41:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF04EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699263679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEnutY17THkNaRY6NyZN3UsULbbbbRlsmNLZIgvxSu4=;
	b=dqy/RKW/rvNcMN7pdrfF0MBrf9Vn4Tn7mTx+IkjafN1Sy3iX7cfUrsB8Y8XGSa3vC79TVa
	m6fs1xKu5Hoxr9m9YRk1Kk8wX/zAUWey8vzd+9Co54KJxXYKMXwP/fouL/+H7pMrwGaAy6
	RRoSz5Mzos+UevxKT4qqReN0ykCJjNI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-aS3A-9plPwq3bOKkJp2H8g-1; Mon, 06 Nov 2023 04:41:13 -0500
X-MC-Unique: aS3A-9plPwq3bOKkJp2H8g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28043db47ebso3138334a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 01:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699263673; x=1699868473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEnutY17THkNaRY6NyZN3UsULbbbbRlsmNLZIgvxSu4=;
        b=Chvaq/nU9oyQUonbOYalfC2AVDqdmkTuN2tsIwy7GuW9/ojEwNNRD/BvHr0c9wCTXS
         Fx24FA9QGWcY8CLU28MUI3QxME2PJytB+BE1hx2t3Vhsodd6rsPgfsSP2WedWWKQjScU
         f2Pp2wZp3eIT87ktCFZ7r6wfL/exPlxT1i/XSZKa2eqKYZqLoHE+qED3YlyeV4UTxuXM
         bBzrMaw7NlYGshS1wGVMWcsz02dULnGpr22joFjC1HMo1d4P6N9i5GWoprIqj5ZEJnL1
         dKEeX76R8/p6F2n46WAgVaRCw8F9XWLqTzxcG0+5bw+q6438IkHpDP5TrwmxgK07d4KX
         rbyw==
X-Gm-Message-State: AOJu0Yy+00hrYMc8HB1NGHY88vKJSpcxz7cBoIcG6vqSl6aTamsoAbOn
	CMK8R6PHpXeLRepPinnJ15fgAcXWuFe7ewSomgLYMcV1R6QBmln5BBELn9Xq4fRJD07vMyDBo8C
	+dlciEx4eohS1NwnmSpeIejhDnEoPiIA6EVq7Ukvswg==
X-Received: by 2002:a17:90b:3597:b0:27d:46e5:2d7c with SMTP id mm23-20020a17090b359700b0027d46e52d7cmr22120465pjb.26.1699263672816;
        Mon, 06 Nov 2023 01:41:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7AXFsZWATs/ZDYo1pTq6d/V+4GcyoNQCcNk+T1vx/PA1ZFED+fVNGEHrg/3IKAo0x8iisobaPTdH8HoGKbms=
X-Received: by 2002:a17:90b:3597:b0:27d:46e5:2d7c with SMTP id
 mm23-20020a17090b359700b0027d46e52d7cmr22120455pjb.26.1699263672500; Mon, 06
 Nov 2023 01:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103173947.GA2059@templeofstupid.com>
In-Reply-To: <20231103173947.GA2059@templeofstupid.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 6 Nov 2023 10:41:01 +0100
Message-ID: <CAOssrKevJL_mBsAuEMFV=J0C9WgRGdZx+jBMTqMjdZ21aePNZQ@mail.gmail.com>
Subject: Re: [resend PATCH v4] fuse: share lookup state between submount and
 its parent
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, German Maglione <gmaglione@redhat.com>, 
	Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 6:39=E2=80=AFPM Krister Johansen <kjlx@templeofstupi=
d.com> wrote:
>
> Fuse submounts do not perform a lookup for the nodeid that they inherit
> from their parent.  Instead, the code decrements the nlookup on the
> submount's fuse_inode when it is instantiated, and no forget is
> performed when a submount root is evicted.

Applied, thanks.

Miklos


