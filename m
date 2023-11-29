Return-Path: <linux-fsdevel+bounces-4157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190C7FD0FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE638282752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F01097A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFhfVJ3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB05170B;
	Tue, 28 Nov 2023 22:47:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so4211834f8f.2;
        Tue, 28 Nov 2023 22:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701240462; x=1701845262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoQz0W1zrsabXG6C9p+w20DAO2gb0rfGAOA6XEqMdok=;
        b=mFhfVJ3l1DvSpGqovl2S6YYC9ePV0URA06pTksM9kq4KT90o3XqG7waOL+biIe+d5E
         E0dDPsqM8cQlvumPzca6R4CILbSD2jUfuOIe06kjMpZ+0ldYWsFGIEAlGWz9ThYuRwhq
         RDL5njc4yzUFu/b90hb7FmhmovsJZKp/46pFifuJm2E/0UYWFnJzW2/277oFIlQi9f1Z
         hh+k+d5mBrYinTmevn0ZMZypCIvwXF9OywubQEo5IG0XxOnBl+RzvpNVCVTE8++rF5Le
         WsahbPA1PSZIDRdFQ9s3LgGu0ll/QzehFsxJmznn8IhmEU8IZka4tf999n5W6s6oOIET
         GP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701240462; x=1701845262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoQz0W1zrsabXG6C9p+w20DAO2gb0rfGAOA6XEqMdok=;
        b=sqQ0GtlZ8D02g6F3oABaYPw2DX5Au+Bd2G/FluFiKhisATmNJBJMwdir+QdmO4lBl4
         pwWT356D+MRga4gHgCFNq5eVnr8xR3Xd1i1OiPPgFCFWh73nHa5dfWnJJWv2cS2BcTEW
         WKSEu9m1Jd4JjfesDcRom1KJ40t9Xrhi29DX9sw4MreLOVHE5F/HVY2NKZAV+l7UtOGr
         JJR8+OQsR0IWVA0W+wOQTgQGDOTy8IFYNolyDlXqrnK4MVyk8T/T4p9kShBSQc/iGrAk
         RaoBnjN+zqBDYNJS85h9ELCU8v074UXLI079cR+d0fiysSVe6R6p7RSGkpRFphdnXc2d
         ohfg==
X-Gm-Message-State: AOJu0YxM3/lg3Xf0q7gLc1eJClELRD5uJaodV/npjZ+dNz4jWIrcwLTD
	5GBb3ApniIxZoMY2h9xEojTDPzcyFo+Swfvu+UNsEKygRdg=
X-Google-Smtp-Source: AGHT+IFN+lb5qvDxfIaWhrx1aSH/XLg8D+DoimtQZ2lwqG3I1fCwH1BzVpWtfsFQfVvr8RIBHZUK6gYVD0WhHS8je20=
X-Received: by 2002:a05:6000:225:b0:332:ce72:d589 with SMTP id
 l5-20020a056000022500b00332ce72d589mr11654697wrz.3.1701240462397; Tue, 28 Nov
 2023 22:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003656.1165061-1-song@kernel.org> <20231129003656.1165061-7-song@kernel.org>
In-Reply-To: <20231129003656.1165061-7-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Nov 2023 22:47:31 -0800
Message-ID: <CAADnVQJb3Ur--A8jaiVqpea1kFXMCd46uP+X4ydcOVG3a5Ve3Q@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 6/6] selftests/bpf: Add test that uses
 fsverity and xattr to sign a file
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, fsverity@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Amir Goldstein <amir73il@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 4:37=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> +char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIGEST_=
SIZE];

when vmlinux is built without CONFIG_FS_VERITY the above fails
in a weird way:
  CLNG-BPF [test_maps] test_sig_in_xattr.bpf.o
progs/test_sig_in_xattr.c:36:26: error: invalid application of
'sizeof' to an incomplete type 'struct fsverity_digest'
   36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) +
SHA256_DIGEST_SIZE];
      |                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~

Is there a way to somehow print a hint during the build what
configs users need to enable to pass the build ?

