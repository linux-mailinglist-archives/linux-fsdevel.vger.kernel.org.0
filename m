Return-Path: <linux-fsdevel+bounces-1302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F57D8E83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D388A1C20FF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF28C16;
	Fri, 27 Oct 2023 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU1o9hhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667175245
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:12:11 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA51AD;
	Thu, 26 Oct 2023 23:12:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-778a20df8c3so133933785a.3;
        Thu, 26 Oct 2023 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698387128; x=1698991928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyzP9oefUGUKwnDG9roK/NF6C+odBahbrO/Kipz9AGU=;
        b=bU1o9hhGG5wied9ehfB7iQEfraWisxTNRW9wjbqI4ZPqB5B70z3mPucO85nWbRkAuU
         gvnsHc64vcOgu43szZ53Dha4qESYRjN5VsLRfcdLdLqvNrdPf7uHkODz5gtTlKB32wA3
         Y0fmINPWeKFuCxo//UMwLc/cv8GrKMxO0iVAWjzOlLz7LfycTxUR7ynOGrexMZFVFoJd
         10BIwZD9c+jXALz+BrjOnwNMkXE6l38VWYkEGtkYQr/IeOFUr07loJVKw9D0GJM1FYo6
         ShInuXyCh7IKz80wUc3Qm/1ISt7pCR8F2ozo2G8y9VFqM3pfxCgdhxp/EFdH6xqn/UTy
         8rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698387128; x=1698991928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyzP9oefUGUKwnDG9roK/NF6C+odBahbrO/Kipz9AGU=;
        b=BE3xtegYhN3MP491iL+ntJpJqvbrLitF5g9mGbYibHUqdkceK0U2JTw1apaYAc6Nf+
         tpwL6pfzGKH7bWFzVsTBAxAW48fmLOdBiLZCmLegUC/jwEjutMpAKIFNarDBj4PTC7zY
         RQMaKiVWlC+SmND50s9OZ77DKotgHchfeqytegRDF0NRdtKFByIgaJoF2S/reLriejRI
         Uaz+0sfQKiBWJ7z4WyxHpdKr+oLjjRnGh8T1A4GBSS+LhBw1Fx/EJNTO7MmFJuDnlg8Y
         krdDNRXoE+Ujy3lSmam6vMNTJ5nUsIpXXsxqeK0pN3pE/Y2edIOK9bNGOJttmsRcSHHg
         qmCg==
X-Gm-Message-State: AOJu0YzqHFdSNcWqxKPfsRClsqCa0A/6IZxIWFJ9ILwwp6f0DBiDjhzC
	qD9uYfIGgEFNuOI4YqheChcHfftVQ6fH7kSmsKI=
X-Google-Smtp-Source: AGHT+IGamK/5mrwijViAH4KVcrP+3u8iXsQPCjW2MTj4dSlLidN8/jAOS0JEQOnGmGme3xd3u/LdR7vzJkLsqZY4j9w=
X-Received: by 2002:a05:6214:2129:b0:66d:9c9f:c913 with SMTP id
 r9-20020a056214212900b0066d9c9fc913mr2888070qvc.1.1698387128671; Thu, 26 Oct
 2023 23:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026192830.21288-1-rdunlap@infradead.org> <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
 <ZTtSJYVmZ/l3d9wD@infradead.org>
In-Reply-To: <ZTtSJYVmZ/l3d9wD@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Oct 2023 09:11:57 +0300
Message-ID: <CAOQ4uxjxTw0k33XqoEUrT6iHdOWrnyMMF=V19ph=HMvqOfC51w@mail.gmail.com>
Subject: Re: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
To: Christoph Hellwig <hch@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 9:01=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 26, 2023 at 10:46:06PM +0300, Amir Goldstein wrote:
> > I would much rather turn EXPORTFS into a bool config
> > and avoid the unneeded build test matrix.
>
> Yes.  Especially given that the defaul on open by handle syscalls
> require it anyway.

Note that those syscalls depend on CONFIG_FHANDLE and the latter
selects EXPORTFS.

Nevertheless, the EXPORTFS=3Dm config seems useless.
I will send a patch to change it.

The bigger issue is that so many of the filesystems that use the
generic export ops do not select EXPORTFS, so it's easier to
leave the generic helper in libfs.c as Arnd suggested.

Thanks,
Amir.

