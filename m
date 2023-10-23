Return-Path: <linux-fsdevel+bounces-922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0377D36E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504921C209DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D518E1A;
	Mon, 23 Oct 2023 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbV01+O9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DEF4F8;
	Mon, 23 Oct 2023 12:36:49 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19DC4;
	Mon, 23 Oct 2023 05:36:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso2997442276.1;
        Mon, 23 Oct 2023 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698064608; x=1698669408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMa2LQKnhzQaEUeX4h7Oh7Hs7UkOAdqVMTQzjr92Mrs=;
        b=ZbV01+O9v4tQKKPxdN+6h8QQUgUuDGpksJJqjjMW+hkBG2YsGJat14TGOK/NiFKqNG
         DwXPztDOhwKKCNggiIS54vyV52p32aR1Faz5Ky6WDqVWG4baA3FnvNGzt5wxAuMX7OPb
         i2QFFNEwx1lFssu4MdEEyJltdwHDXIlDbKVIx7ti2XUbAbAU20J7te6TUoE6FsMRDIYV
         CLvCdKfs9ZHrZ748hO7bNMmyy5GWNbrWy9FrV0uvjLkJs6izuhZ8arf+sejgT2a70sVG
         T48IO14uWPkkVbi5RSYMgiHXwD6rL8WbkNYXVv7kC4aKiLDgKKpn6eN7by3q5/ZB9oTv
         ci7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064608; x=1698669408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMa2LQKnhzQaEUeX4h7Oh7Hs7UkOAdqVMTQzjr92Mrs=;
        b=rPYDTdjoi4zdeKgmHJ1wATs26zoKnJUOqCeC4jVLWq6OI2V2VKjEWrKBphl3EbvmDy
         FVZP9MfcM0Jq4xT2XmtqU4coA6oXQErajqjq2o5qeNEVMbaWI30Yo0VazsMIhrN5dCQ4
         VcR/ERs3h8eAmkn30V7sq3P+uIL+6AIJ/YdkP9ZVAkM1KuG6JXagbHIdPjg9kKyBnjia
         hGO7ZU9zmFqWeO1h2jj7oHIGtURwVv6ubTcnY4gf1zbN5HGWbaITRxr1FasTUXlsKdf6
         f8nVGITV67C/3tHbq7cPtEeXP4jAJlbOxGb9YmywAMVSC6/AYQz/ZDVJv/U0RVBMkKhS
         e0kA==
X-Gm-Message-State: AOJu0Yyglr4kch0j+npTsoMkcrmXBKCTSgyz17E2UB0h8ltGdJ2oDu9m
	T1eHBqK06J+zDTAMA+zemGmWZw9Ow3RkLVzKphc=
X-Google-Smtp-Source: AGHT+IHAmqvus4+6Me8oX4rNz/AasN0/4r2os8eZZgvKlmS9s1yO1F8VeP1BlFt5MLJY5qpbXrjq2Z13rpq834SMGvI=
X-Received: by 2002:a25:cf03:0:b0:d9a:5394:8557 with SMTP id
 f3-20020a25cf03000000b00d9a53948557mr8763222ybg.7.1698064607898; Mon, 23 Oct
 2023 05:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-7-wedsonaf@gmail.com>
 <ZTHKQdAciXClXnut@boqun-archlinux>
In-Reply-To: <ZTHKQdAciXClXnut@boqun-archlinux>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 23 Oct 2023 09:36:36 -0300
Message-ID: <CANeycqomQ7qPfbccmSDy4X1cB5HMMvpHnPk0dW7F9S7VPDoTwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 21:31, Boqun Feng <boqun.feng@gmail.com> wrote:
> On Wed, Oct 18, 2023 at 09:25:05AM -0300, Wedson Almeida Filho wrote:
> > +        // SAFETY: We are manually destructuring `self` and preventing `drop` from being called.
> > +        Ok(unsafe { (&ManuallyDrop::new(self).0 as *const ARef<INode<T>>).read() })
>
> How do we feel about using transmute here? ;-) I.e.
>
>         // SAFETY: `NewINode` is transparent to `ARef<INode<_>>`, and
>         // the inode has been initialised, so it's safety to change the
>         // object type.
>         Ok(unsafe { core::mem::transmute(self) })
>
> What we actually want here is changing the type of the object (i.e.
> bitwise move from one type to another), seems to me that transmute is
> the best fit here.
>
> Thoughts?

That's much nicer. I'll do this in v2.

