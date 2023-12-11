Return-Path: <linux-fsdevel+bounces-5455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A980C397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477EDB208A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198020DFC;
	Mon, 11 Dec 2023 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UW5smEd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E631FC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 00:49:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so4379262276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702284562; x=1702889362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owh1Syk0ZNlTmvXNtbwF6wDId1bkrStE1MY5dtkm5mQ=;
        b=UW5smEd7SIjaXJNjNXS9AFmLoaiqjoZ7a6jPjDQRfTU9lB+PJ/WMaDcSRJNZPo/jv6
         HjCUWZbnh329Mk27Ex8y7cSayuP1zrYHdGqxD5i81TMHsK0DPsoisAWrmd8SeAQ7+/87
         6l8bdpY+BA42vB9X+/tiS/efZDHaVH7e+Tng9mAgI2SSNVVpGm/eHbnZmd8N9uT6J133
         TdUEoHwSEemCsjlvaOG49yPD1avZxyJue9srq4zzDajo7Ts8hT1WEyYA5uHUIUY8dVqp
         pUPmVZt4uH/OaafiSN//acjZTDLn9051IyCWvVOBGA7mOkL8Gydn9La0jh7+kyk/cEuK
         ZbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284562; x=1702889362;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Owh1Syk0ZNlTmvXNtbwF6wDId1bkrStE1MY5dtkm5mQ=;
        b=gczGUBVG49e76xD3PvCyRR8FtbIThfv93JSQaop0hChxbhg3abuao7282NJvloX8mK
         uHELgodhmGf3k5scIdp8McOwHrmI1u1IqR5V5bop1QrsN8EjPpZo4bvM9d6YudPXMsCG
         qdCyPcekm9OeqE0rkGxfffpvLXqGmfmc5t859T3LMcjBS4BQRRr6yQ6nMZU6hx6uy9lJ
         nlQR6taZZUcDSXNZHWXjxegylZnM62BObGTELs7zuU+HLoqFm770YDyHLIH7uIuwBWRh
         B8mcTw3MtnfAgScA7Ak1x4AFl4JIjVrmbB+NTcyNOx5Z5BkFYmas1JrfzdHTTNac+0eD
         PPCg==
X-Gm-Message-State: AOJu0YwH106BUH2dFKKDoWMBCR9lUla3p2xmOv6rC8vBdIeAvAh9gmqE
	OPTDSMf1XZ0ji4z4//HcIq7VSqaw0ks=
X-Google-Smtp-Source: AGHT+IHADZNPJ6Lbugm8snOt4emULj590PwI+Vg6wQGfYGAIyDmyPOad+GbNykqrXXlTYnXndQmG8/3HazY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8dfb:6b15:9b0:522a])
 (user=gnoack job=sendgmr) by 2002:a25:4093:0:b0:db5:4766:e365 with SMTP id
 n141-20020a254093000000b00db54766e365mr27097yba.8.1702284561940; Mon, 11 Dec
 2023 00:49:21 -0800 (PST)
Date: Mon, 11 Dec 2023 09:49:14 +0100
In-Reply-To: <20231211.ieZahkeiph1o@digikod.net>
Message-Id: <ZXbNCkzHbvystV8t@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com> <20231208155121.1943775-10-gnoack@google.com>
 <20231211.ieZahkeiph1o@digikod.net>
Subject: Re: [PATCH v8 9/9] landlock: Document IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Micka=C3=ABl!

Thanks for the review!

On Mon, Dec 11, 2023 at 08:04:33AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Dec 08, 2023 at 04:51:21PM +0100, G=C3=BCnther Noack wrote:
> > ++------------------------+-------------+-------------------+----------=
---------+
> > +|                        | ``IOCTL``   | ``IOCTL`` handled | ``IOCTL``=
 handled |
> > +|                        | not handled | and permitted     | and not p=
ermitted |
> > ++------------------------+-------------+-------------------+----------=
---------+
> > +| ``READ_FILE`` not      | allow       | allow             | deny     =
         |
> > +| handled                |             |                   |          =
         |
> > ++------------------------+             +-------------------+----------=
---------+
> > +| ``READ_FILE`` handled  |             | allow                        =
         |
> > +| and permitted          |             |                              =
         |
> > ++------------------------+             +-------------------+----------=
---------+
> > +| ``READ_FILE`` handled  |             | deny                         =
         |
> > +| and not permitted      |             |                              =
         |
> > ++------------------------+-------------+-------------------+----------=
---------+
>=20
> Great! Could you please format this table with the flat-table syntax?
> See https://docs.kernel.org/doc-guide/sphinx.html#tables

This link actually says that =E2=80=9CKernel style for tables is to prefer =
simple table
syntax or grid table syntax=E2=80=9D (instead of the flat-table syntax).

This "visual" style is more cumbersome to edit, but editing documentation
happens less than reading it, so further edits are less likely.  I also fin=
d it
easier to reason about what the cell sizes are that way, rather than having=
 to
wrap my head around special :rspan: and :cspan: syntax.

If you are not strongly opposed to it, I'd prefer to keep the existing styl=
e,
but we can do it either way if you feel strongly about it.  Let me know how
important this is to you.

Thanks,
=E2=80=94G=C3=BCnther

