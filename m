Return-Path: <linux-fsdevel+bounces-3219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8E7F1879
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506662824E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342281DFF9;
	Mon, 20 Nov 2023 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdFdjMuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4239B93
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 08:20:59 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0c777bf0so14321926d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700497258; x=1701102058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YFNQ0gVDmSmlhzSESFaowTh0PTxhGXSUoKost73/Sg=;
        b=TdFdjMuFvhMjuRdorNLXT84/bO7tJ7q0Vz5bhpe0YCw7C1FGQzPTRcypv0I42Jq9Rr
         IpLC/T/UulWa6lzGV7mmBnIY2NpuDoXhMP+3xDoGXKoOkqaxVFYL810tdkMRR7+4L8HG
         CNkN0kMgPVfO+5PshdCLTPOKAKfc0LRkFrac5CcuwGPzzDqF94UncyFy7BReKjLmRKRs
         4BcZXRNPa3QK6aYPAS7y1ZWKycOwsA78OBO2dLok+NxshSgTBX+o3q+1Zbl7o0Mzrbqh
         U6Anq//Y72Q1aBw7zM0qWfCBW2syhk0gWsCNBDdueWENX8iBx2xLEewqh7JdHHrWqzKt
         5UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497258; x=1701102058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YFNQ0gVDmSmlhzSESFaowTh0PTxhGXSUoKost73/Sg=;
        b=KHaE2NWG8SzX3EDzyJMO9Yvuoj9RBLp2py+kO6xgy5+W8wd6modZ51UnIbA/h5Cws0
         Bw8yhNnS9GAvKwsyWGdgbQf9DJCKf681Su4vfbiP1V6T/b8Dsmwo2m6TxKFKeovlUQ2r
         jtHViPkYMhRPiOBCudNU7aaManCl76QUP1duqxADHpcsGTFXei3QnU3XsNu/gnqMRd5N
         p89/0oKr9PV73o7WQV/iwicUwpHbcMxsFBR4DXIxeSxEfl+JkrCXuciKlaUUcnohW++w
         MB2LRFCkB8dMDGC9aI/PzquQYHyvfNOdezF2omcNiE3TKjYGy2CofH6ECNoJaaKwwo00
         eWWA==
X-Gm-Message-State: AOJu0YwI52nVV1anACrkxXoXszRit0UHlIMc/WNXCxA1VcSBwNW6uE3B
	mS0aDPKU8Whr2i0e3zaLCTm3SVNC0+1K+GY7UX9pc+yB
X-Google-Smtp-Source: AGHT+IHaCMljX8J150IoqYCK0eXB2jtF1Tjldt4KaZPVLRLYYxWmPs7Pgbtnpo4Iobv/KGxcnZkf8P3iYOdX44af1gA=
X-Received: by 2002:ad4:5b82:0:b0:66d:5c10:cab7 with SMTP id
 2-20020ad45b82000000b0066d5c10cab7mr9825524qvp.46.1700497258291; Mon, 20 Nov
 2023 08:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118183018.2069899-1-amir73il@gmail.com> <20231118183018.2069899-3-amir73il@gmail.com>
 <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com> <20231120-langsam-eindecken-2cc8ba9954b6@brauner>
In-Reply-To: <20231120-langsam-eindecken-2cc8ba9954b6@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Nov 2023 18:20:46 +0200
Message-ID: <CAOQ4uxiNan-gtL=WLEA=2O8zL0ttc0sd7UhxTB_95PEcbSsT6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 5:48=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > OOPS, missed fsnotify_put_mark(mark);
> > better add a goto target out_put_mark as this is the second case now.
>
> I want to point out that going forward we should be able to make use of
> scoped cleanup macros. Please see include/linux/cleanup.h. I think we
> should start making liberal use of this. I know that Peter Ziljstra is
> already doing so for kernel/sched/.

Yeh, I like them, but not sure if I would use them in this case.

Thanks,
Amir.

