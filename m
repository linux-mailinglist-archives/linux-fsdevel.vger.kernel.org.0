Return-Path: <linux-fsdevel+bounces-4339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA367FEAD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 09:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC15D2841A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F752D606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOyHOwm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F141707
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 00:33:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a06e59384b6so89220666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701333182; x=1701937982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOgB8KDK4JsV5yR7fuyojrmqgdC8qkU46c9n+yXRKdg=;
        b=kOyHOwm4yE/FKv5OUIyF09Rvq4tVju4HHpeqrsODsDdnfwkSn5pXA+UC2OXhNabcBh
         NPs94AR6rkwst2n6xaYRMSrWbFlfH50QHot2v2IO666Z4l5H+RHAFv+L27r6PoseIRPv
         9ReDtLPiu9lw3JuYWL1zCEXXptZlffzdAUyw9Z+Wj1wkK8HvCN6mW7pQCB1vtKtaltER
         Uz8TXH+gFDyX8n9jfuG+oGBuWTTZQX8lu5qDlZu5xQxXjoZqRXfn5ky2/HxyQAeeq39O
         kvVp/4DWnI95YvjJPVAX9A2SwvEfpPbt5jlk3z5bUkhjRRMrnyECBDdyBBzdVUKAKd02
         xHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333182; x=1701937982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOgB8KDK4JsV5yR7fuyojrmqgdC8qkU46c9n+yXRKdg=;
        b=UvlWvcvPJ1BJXEPCxST/+KROqDt7hvIsa//6kc/llpShx6uQ1OB9aoWp7NHKnfDMx/
         V07OoZMtyL/ScFvQMVoaIeZE8tcfF107nDoW49ZirEENB5LzQ2yfL2MmrYmV0kbOND8v
         PjCAfJWL9d86Y+ynCp+xNrdTeqhk/xJYDxgrmFZPUNEqAhArNaBqAZQYRAVAMl6WTj5Y
         33swSn7dLnK7QQr+mhEBMAYf1uoPXjAtr2pRE+LfoqjsNV/B4stlAC4wrWWo+Lzg1Y8y
         IDBCM06wLmWMP/Dy8cTm1w6+PfVsMgiKcLVg421q+fvdAftRvzl00YsN2hzUR7zgYHM6
         +KoA==
X-Gm-Message-State: AOJu0YxUXZVzD7M8PrbgXiOtAJ++5Atzojh1j90pcqRxaHNAAdmvId8O
	QH/eU9d1qJfhVJ34w1hf9Ywv6Sas2K71b55wvCo=
X-Google-Smtp-Source: AGHT+IHxnWjhaUa4zCwQIynsiNsZqnnF7OeMahRp4uxq/bkeEIzpQiJEMnrujexFgpQGTA8Mt2BI0nhGqOkd3CaOmro=
X-Received: by 2002:a17:907:1b1b:b0:9fd:59ea:2dec with SMTP id
 mp27-20020a1709071b1b00b009fd59ea2decmr17409669ejc.73.1701333182053; Thu, 30
 Nov 2023 00:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129200709.3154370-1-amir73il@gmail.com>
In-Reply-To: <20231129200709.3154370-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 10:32:49 +0200
Message-ID: <CAOQ4uxhCC+ZpULkBf_WfsyRBToNxksesBAk5nCsGYWkuNFu6JA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Avert possible deadlock with splice() and fanotify
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Christian,
>
> Josef has helped me see the light and figure out how to avoid the
> possible deadlock, which involves:
> - splice() from source file in a loop mounted fs to dest file in
>   a host fs, where the loop image file is
> - fsfreeze on host fs
> - write to host fs in context of fanotify permission event handler
>   (FAN_ACCESS_PERM) on the splice source file
>
> The first patch should not be changing any logic.
> I only build tested the ceph patch, so hoping to get an
> Acked-by/Tested-by from Jeff.
>
> The second patch rids us of the deadlock by not holding
> file_start_write() while reading from splice source file.
>

OOPS, I missed another corner case:
The COPY_FILE_SPLICE fallback of server-side-copy in nfsd/ksmbd
needs to use the start-write-safe variant of do_splice_direct(),
because in this case src and dst can be on any two fs.
Expect an extra patch in v2.

Thanks,
Amir.

