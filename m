Return-Path: <linux-fsdevel+bounces-755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6247CFB36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B183A280FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792627466;
	Thu, 19 Oct 2023 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjfIhlfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1922745C;
	Thu, 19 Oct 2023 13:35:53 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E8115;
	Thu, 19 Oct 2023 06:35:50 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ac9573274so8854794276.0;
        Thu, 19 Oct 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697722550; x=1698327350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xt5Vye8wK/4zkBxty0oWsd6dhWU+5KoV2y4KayJDPY=;
        b=kjfIhlfgTl5GXADfFI+54yaHUOzi7925c+/NYSxToCNU0RiJR7z0BBtCGwrEuLhi9o
         h9ThRq4dgnps+MO4o6G0CW08IPG1jndBeJI0WXQefWOCbp2rCY9+L+D5hlwPh3eGkqDz
         5iCLOU8d4JkkQl96/M9zsEoHDnGz1K6b+P+lRRQXrRWzBg1LWNUqm7XUvFIInxQrHAi1
         bGCQGFXqBDTVJofhylqnkbyK51McaseVRIxBOGbgz0pvZugaAG1EQX90EHkl1C7GLNJG
         8U80YZQ+GJ1X5fw0S8oMWMOPPHK3eUJS06KLaGwhanZeI7MtqLsOoFT1p+k/azzRmexr
         mY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697722550; x=1698327350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Xt5Vye8wK/4zkBxty0oWsd6dhWU+5KoV2y4KayJDPY=;
        b=UG6gqppTKQ1Fn6PDM5BDjFUFpZ+4Ojr6Hh2oTgrEdjVZYby4RjShWZN2bgHBZiGOs5
         8ukM5ZxkpwKeC89Plb8XFr4934hPMHEm3/0SlRUCjiPwL8nDd0JkXMBXRJ4+EDwunTrQ
         4/V+YIrte2zDwcNyOAWL1M0KitmdmZ7bqlDB76x8epZy4mjJ3Mux1ZWsGvNg+0lBuPDz
         ZeKWCPHaOtv3bPVkyXa5WnX4AXcO7H1+Q5ZFe4OaQ7mjOIiu6RZGxPSXEMabjYF8wwFw
         iqdhdQ2BBRE/Q2OS+71eG4ShbONa1Wbacp3qA6YGJUgpKNcSzf300cuHhO2e8BMCWtq4
         51iA==
X-Gm-Message-State: AOJu0Yzl3nzZvE0FzlHsVMZpv+f9zGVQlDe5jSDXsqsWxJtvkHzxkM4U
	9qYbaTz2mB1iY0Vk6GfVlK0qjgC/6MU63iyseNM=
X-Google-Smtp-Source: AGHT+IFc5usKfMQseA7R0fZttk69NMKxFfx9f093B6QmASqFJxeIRyDUdqAVrxMBy3xzBMW00ycNonX3swnGZZEotag=
X-Received: by 2002:a25:8201:0:b0:d7b:9211:51a5 with SMTP id
 q1-20020a258201000000b00d7b921151a5mr2257747ybk.44.1697722549616; Thu, 19 Oct
 2023 06:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-12-wedsonaf@gmail.com>
 <jbhv4sp4ojqbfusbqpwxgi3n2wsnnwxeax7tmdvkewwymbofwi@mqdgc7oym2tb>
In-Reply-To: <jbhv4sp4ojqbfusbqpwxgi3n2wsnnwxeax7tmdvkewwymbofwi@mqdgc7oym2tb>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 19 Oct 2023 10:35:38 -0300
Message-ID: <CANeycqq1rWudUE7rc3g_3ziyTVxid2X3-7t6ck5cH2ZGneQGmA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/19] rust: fs: introduce `FileSystem::read_xattr`
To: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct 2023 at 10:06, Ariel Miculas (amiculas)
<amiculas@cisco.com> wrote:

> I think this is not safe. from_raw_parts_mut's documentation says:
> ```
> `data` must be non-null and aligned even for zero-length slices. One
> reason for this is that enum layout optimizations may rely on references
> (including slices of any length) being aligned and non-null to distinguish
> them from other data. You can obtain a pointer that is usable as `data`
> for zero-length slices using [`NonNull::dangling()`].
> ```
>
> `vfs_getxattr_alloc` explicitly calls the `get` handler with `buffer` set
> to NULL and `size` set to 0, in order to determine the required size for
> the extended attributes:
> ```
> error = handler->get(handler, dentry, inode, name, NULL, 0);
> if (error < 0)
>         return error;
> ```
>
> So `buffer` is definitely NULL in the first call to the handler.
>
> When `buffer` is NULL, the first argument to `from_raw_parts_mut` should
> be `NonNull::dangling()`.

Good catch, thanks!

I'll fix this for v2.

