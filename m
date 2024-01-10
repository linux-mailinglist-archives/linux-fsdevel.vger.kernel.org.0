Return-Path: <linux-fsdevel+bounces-7736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF882A036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B01C2238C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1F4D588;
	Wed, 10 Jan 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhdg82t1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A74CE11;
	Wed, 10 Jan 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed85ec5b5so3176483276.3;
        Wed, 10 Jan 2024 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911160; x=1705515960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2H9T1sQ+e+3ib+8sQexYPwrEmXw0YDH+9KrKh8Ug+Q=;
        b=jhdg82t1Hxqtkl3FE75USd+k64rTrYjUCMfzaOnyyJgyTu8NsA5uw0p7GZNQaeFspS
         zlW3MWdg4XNtKCkHyRATf8AmxPseZeVavqdCR8x3RbyCJA1vgwQwLxDh49aNL0R6N/C3
         fsC1J0JFsOH+hIbp6L7p337XQfa0aAv4YYhpyxdwCFqApHzFuJJWgW2ZzOf5RJxXuD4p
         fKChekARr+bgaL9CvhTzV4sWclsHpGxD5TKWnIFGhbY6o0/bC1tQdrEdxaqQCf6jnEXW
         GlGtOwYpQ3cTZSoDUUX85C+NaNyvF1dlQbTJJIOsvJBWDBfSMKXjcWUIw32Po0QsX9nk
         PNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911160; x=1705515960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2H9T1sQ+e+3ib+8sQexYPwrEmXw0YDH+9KrKh8Ug+Q=;
        b=UkNsDzWXZXegvzlH9b8+BNBzY8DDDKFMu6oIA+eLkaAJBIYdcn7/nCoEVb3N17HspX
         CEupPXt4h/c7mElqOE3mKO3prz6jY9Ce6id64pAR/h31kOgAHvTQfyWEEUFW+N72poZ3
         N7bCNGn1fhZ4szZ2xiyTjjgbAzkXlfNjn0z7XFjhaURW8cpitYp1EBQxlV4sCTcfoJ5h
         Gj7iBqM/21TbtrXX5fv0dGCeG8Qscy3aoETAaFHPOjchB/hdiJnmOUyq4SLXfv/lQ0+G
         beYpDsROe0p0G3jcJpSisU6vI+BUwYKDEPhKG2ta4Gucd0EgdRUiYH7x95gJ/5DEUAGo
         3mvA==
X-Gm-Message-State: AOJu0YxFIJUpsXxxy2X2PHHC8C8nELCrhg66Q/ri8fF4Lqa6JHGgPnBZ
	pGYqnSY5WKasv3QRGYP245wvkP6EAk0fhwY79RorJCJl
X-Google-Smtp-Source: AGHT+IHxCV7ETRNtwEBaVOUksTrrHEv33kwlVzPX7TcUZocQppKig2RgD+K01TECjaIe652PgP+nQolU0gvr3CIn52k=
X-Received: by 2002:a25:8609:0:b0:dbe:d072:cc8 with SMTP id
 y9-20020a258609000000b00dbed0720cc8mr57611ybk.20.1704911160131; Wed, 10 Jan
 2024 10:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-4-wedsonaf@gmail.com>
 <0278c96f-7a4a-4a3c-81b8-583f2cc62226@ryhl.io>
In-Reply-To: <0278c96f-7a4a-4a3c-81b8-583f2cc62226@ryhl.io>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 10 Jan 2024 15:25:49 -0300
Message-ID: <CANeycqouuEwFVBogUVDpjN=twnb6O+SzMw3gF6aBX3_9dmNHPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/19] samples: rust: add initial ro file system sample
To: Alice Ryhl <alice@ryhl.io>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Oct 2023 at 13:17, Alice Ryhl <alice@ryhl.io> wrote:
>
> On 10/18/23 14:25, Wedson Almeida Filho wrote:> +kernel::module_fs! {
> > +    type: RoFs,
> > +    name: "rust_rofs",
> > +    author: "Rust for Linux Contributors",
> > +    description: "Rust read-only file system sample",
> > +    license: "GPL",
> > +}
> > +
> > +struct RoFs;
> > +impl fs::FileSystem for RoFs {
> > +    const NAME: &'static CStr = c_str!("rust-fs");
> > +}
>
> Why use two different names here?

I actually wanted the same name, but the string in the module macros
don't accept dashes (they need to be identifiers).

I discussed this with Miguel a couple of years ago but we decided to
wait and see before doing anything. Since then I noticed that Rust
automatically converts dashes to underscores in crate names so that
they can be used as identifiers in the language. So I guess there's a
precedent if we decide to do something similar.

For now I'll change rust-fs to rust_rofs as the fs name.

