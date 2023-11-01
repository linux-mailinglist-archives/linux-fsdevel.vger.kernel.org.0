Return-Path: <linux-fsdevel+bounces-1734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAB7DE169
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7281428129D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614C134A6;
	Wed,  1 Nov 2023 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2CcS3uD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3D12E46
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 13:18:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED68102
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698844724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSv2DzNgtmTMp0Zpn8vNNj88K76tIu0ml3mAsMedefM=;
	b=O2CcS3uDlW1j9n74KpOzUPUxQ9WvgsNI61kzL/BPSIs7Stv7GxrjOIT/eMMBw8jcYElnsX
	AyJ+Sw24h19PDOhAN2vwvtl/w6NneFyw1+fdZisUbtDYxEZslCZHI/x4pTEy3bBjvvUpG1
	AyB3lY/iuoaZ0wddngZ23du29X19O78=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-U58l72FZM-mO_jHV7C2fDg-1; Wed, 01 Nov 2023 09:18:43 -0400
X-MC-Unique: U58l72FZM-mO_jHV7C2fDg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2800b54c461so4052128a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 06:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698844722; x=1699449522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSv2DzNgtmTMp0Zpn8vNNj88K76tIu0ml3mAsMedefM=;
        b=q4dllZZ/R+2DzAPMzMRxAe7/l+9s/Ohq6Cbt1URW7FvsVvtLLGlXl8PEmNq998KTDS
         NeiPYt8BsF35d8H3Wk1G/BSuFFm2c/jL+S5IvJjpDwv/T6HsO5X225noABqaywmbcakO
         6tDPZiRd8Sg2F9+pDJszb8k7Ov01lx+HqrFeiODpF5/UEdZFlcWE+AQmZeLiqFHCOs/I
         GLU06r0SjOEkKX+yt7aQtv0fzWFc4UxHeL9hhnWx+jYKnxm9cGM0zgmJGz6zkAUDhYOF
         xNwabWZo2t7hZYonVpr/Af+q9/Wj/rdQK27zL/p011SfPNhXQ3bAwBM/WPVnwP3uQ98W
         gCzQ==
X-Gm-Message-State: AOJu0YxQzTVe1Zy//Zguo6myNQMDDtRh1G/w/IeqGU8e8DIxaCiwsS1O
	2oVr4YqNme06l8laNuowoXG2F04GZTsmSZVI6XPgIiPtHQHvkvM8MGDU8rvtQnAM7k6pBpknnXB
	5XO/6HKj0O4BRPPFnfmIZbaaUAE2g66Og4+RaRnFfgw==
X-Received: by 2002:a17:90b:23c7:b0:280:1dca:f6a3 with SMTP id md7-20020a17090b23c700b002801dcaf6a3mr10441086pjb.43.1698844722036;
        Wed, 01 Nov 2023 06:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEirGTDasAqUjXQGnKlAtyrPulCGVMINuDBdc2ZYq9ZRuzlBBKwBLe80AwfvqXtV4VYiPlMQ+XXMQ63Z1BoA=
X-Received: by 2002:a17:90b:23c7:b0:280:1dca:f6a3 with SMTP id
 md7-20020a17090b23c700b002801dcaf6a3mr10441056pjb.43.1698844721642; Wed, 01
 Nov 2023 06:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231101-urenkel-banal-b232d7a3cbe8@brauner>
In-Reply-To: <20231101-urenkel-banal-b232d7a3cbe8@brauner>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 1 Nov 2023 14:18:30 +0100
Message-ID: <CAOssrKcf5NQ8pGFWKq2hG9BmFZN-0rhhO+MuYCe7fVfmFO4DAA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] querying mount attributes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 12:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:

> I've renamed struct statmnt to struct statmount to align with statx()
> and struct statx. I also renamed struct stmt_state to struct kstatmount
> as that's how we usually do this. And I renamed struct __mount_arg to
> struct mnt_id_req and dropped the comment. Libraries can expose this in
> whatever form they want but we'll also have direct consumers. I'd rather
> have this struct be underscore free and officially sanctioned.

Thanks.

arch/arm64/include/asm/unistd.h needs this fixup:

-#define __NR_compat_syscalls 457
+#define __NR_compat_syscalls 459

Can you fix inline, or should I send a proper patch?

Thanks,
Miklos


