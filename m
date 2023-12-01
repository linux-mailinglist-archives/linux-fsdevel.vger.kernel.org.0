Return-Path: <linux-fsdevel+bounces-4570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87505800B14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318171F20F35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694225545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM8IpDg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854510F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 04:27:44 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c9c015af88so24478501fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 04:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701433663; x=1702038463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmL3NKrtBytG8xkjqCE6OTDeK9KHu9/kuk+P+NAf5bc=;
        b=sM8IpDg4lhRNQpQV9+4lu/VZLvSvDdWlxYsN6rekRAnX4/jhJf1YslmGyrsuAQeKel
         PACNKoyffowwY7fhY2apcfXbXGE53id2QFP17nhqisbnYWSm5CHLqkVSSCiNPs8Le/k2
         CtlzYmrbPq25maGEydJyWyegRnW0UFU/uKMWaztwT4lLqdFfnNmYlzx6f8rkLZNfNw8l
         p0gVR1ffuNQtN4vmbhXdLd2T5UAx3q2g8LGynj7Wyf9bz9kZDV/SI1y8mq+7ZasLURHL
         uWL1sXkbi8KpuERpoLDVFrOTVruDHGF4ZsoeP59mmL3DyZxSWVwOhyilpMMXo8sIa6s/
         ZtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433663; x=1702038463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmL3NKrtBytG8xkjqCE6OTDeK9KHu9/kuk+P+NAf5bc=;
        b=REdUsVbBCTZ3kigG6Ybp4gENdt+rDGZTF2S2oVsWmsqp2tnYLNbTp88Tx9tlrJrptD
         KGN5jliDOomeGdpaXcIZ+nMPCTolDezH1joKArSYd2IQKuZZwgHfnQ+SrVjyo9OU2LA2
         8vfW82tXixEV36dO+gOSKHy6QGXVBNTg7cRwcgusC7psGxWd1CLEfeolBEfqX71urXC7
         nmgqnTGeXHh3yeRwHh30jWRD66Q9X5pToiI6bhKW1tU/Yj53Hi6C38m/WiD+UA0GR/Wd
         eLGmMyAHTyXH8ndEr6k0z452RaXZBlS63knQ8iUKQ5VS4r8PyEAzsSOSbWDOMHtLOy6q
         S5Qg==
X-Gm-Message-State: AOJu0YxgDivbZR59DkPPj14sSLByc9ZKvYULNzAjdUaHPt35TTTqF0b/
	usOLtdMzbJmMmnRbbWRLSuxFpRWZlvvBM44=
X-Google-Smtp-Source: AGHT+IFPE9LTRPmOtt53LlVPvzsjsFwgDJAHkeuvqHLFmvaoQveY/d0bandq9Z/njQioenXEfi6gioDooJFlERQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:104e:b0:50b:c543:c4d0 with SMTP
 id c14-20020a056512104e00b0050bc543c4d0mr47295lfb.8.1701433662859; Fri, 01
 Dec 2023 04:27:42 -0800 (PST)
Date: Fri,  1 Dec 2023 12:27:40 +0000
In-Reply-To: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201122740.2214259-1-aliceryhl@google.com>
Subject: RE: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: david.laight@aculab.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, 
	dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, 
	ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	surenb@google.com, tglx@linutronix.de, tkjos@android.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

David Laight <David.Laight@ACULAB.COM> writes:
> > > I don't know about Rust namespacing, but in other languages, how you
> > > have to especify namespaces tend to be ***far*** more verbose than
> > > just adding an O_ prefix.
> > 
> > In this case we already have the `flags` namespace, so I thought about
> > just dropping the `O_` prefix altogether.
> 
> Does rust have a 'using namespace' (or similar) so that namespace doesn't
> have to be explicitly specified each time a value is used?
> If so you still need a hint about which set of values it is from.
> 
> Otherwise you get into the same mess as C++ class members (I think
> they should have been .member from the start).
> Or, worse still, Pascal and multiple 'with' blocks.

Yes.

You can import it with a use statement. For example:

use kernel::file::flags::O_RDONLY;
// use as O_RDONLY

or:

use kernel::file::flags::{O_RDONLY, O_WRONLY, O_RDWR};
// use as O_RDONLY

or:

use kernel::file::flags::*;
// use as O_RDONLY

If you want to specify a namespace every time you use it, then it is
possible: (But often you wouldn't do that.)

use kernel::file::flags;
// use as flags::O_RDONLY

or:

use kernel::file;
// use as file::flags::O_RDONLY

or:

use kernel::file::flags as file_flags;
// use as file_flags::O_RDONLY

And you can also use the full path if you don't want to add a `use`
statement.

Alice

