Return-Path: <linux-fsdevel+bounces-2910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E77EC81B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B39A1C20BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35331742;
	Wed, 15 Nov 2023 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B5jNO081"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B628E1F
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 16:04:58 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE5194
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso9860651e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064294; x=1700669094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=B5jNO081WHszP07ZsBKM1CDWKnvz3FH9mmZUeIJOBeQ4RtSAnsgAlB/4zNCkcM4btj
         yDGuU/TQucx9vY2Jb0NlNiwMLl4aSHjmpEVeUYpX4EA5IB6tvF1LI2LIDmwHGCzJaKYX
         ClTQWQx89VcjPw2bT8IytM4QZ8n5qS0hVIvp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064294; x=1700669094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=mvHY1Lskbax+UpEdF5SfhUy/Y/1JRtsgVgNMrzQzxJTKiZKUS9Nox+fMGJzbAzmYeR
         M6dokLeRfwSt2NMJ9r3zFNikmy0RMhfk2BR4hUNd58ZidtcNiVvJN/eRDZ0HkLJtQUjd
         1KU9GLYAhF7wtw4kzGFQlwqCCV7EPitL7mue43iTthl3Xl1r8s8CLCoxiaJN4ZghxbM+
         xwIrVFsUtbVgJDGKW0kFOuP4XleDIAxQ/I/uTOFmi7aOCm2yNfZaS6PyhkJBIw+NAkws
         bcA23JAlXT/HrHcTw1/EksPJe43GivEkCZ1Ck5XCeIZazABQ677+/124dDHxN7zQV06E
         0/CQ==
X-Gm-Message-State: AOJu0Yxf7OPkXG3mwSkqgX2u3qji1U/foPJCR1ZqVNhYofBTdooqtl2S
	KaSsIWu5twrS2Uj5Kl0r6jt2yW+ZrP6/tQji30pnaQEe
X-Google-Smtp-Source: AGHT+IErTF5U20ix4FPUSjI/UBCpQweE3rbcPfGOhJL/Wx0g7havKmzTBxEGzQRVb3aEr817apF4fg==
X-Received: by 2002:ac2:4907:0:b0:509:8e1b:c932 with SMTP id n7-20020ac24907000000b005098e1bc932mr8832531lfi.50.1700064294212;
        Wed, 15 Nov 2023 08:04:54 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id xo15-20020a170907bb8f00b009ade1a4f795sm7222719ejc.168.2023.11.15.08.04.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:04:53 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-543923af573so10788638a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:53 -0800 (PST)
X-Received: by 2002:a05:6402:34f:b0:540:7a88:ac7c with SMTP id
 r15-20020a056402034f00b005407a88ac7cmr10183276edw.21.1700064293347; Wed, 15
 Nov 2023 08:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:04:36 -0500
X-Gmail-Original-Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] iov_iter: kunit: Cleanup, abstraction and more tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
>  (3) Add a function to set up a userspace VM, attach the VM to the kunit
>      testing thread, create an anonymous file, stuff some pages into the
>      file and map the file into the VM to act as a buffer that can be used
>      with UBUF/IOVEC iterators.
>
>      I map an anonymous file with pages attached rather than using MAP_ANON
>      so that I can check the pages obtained from iov_iter_extract_pages()
>      without worrying about them changing due to swap, migrate, etc..
>
>      [?] Is this the best way to do things?  Mirroring execve, it requires
>      a number of extra core symbols to be exported.  Should this be done in
>      the core code?

Do you really need to do this as a kunit test in the kernel itself?

Why not just make it a user-space test as part of tools/testing/selftests?

That's what it smells like to me. You're doing user-level tests, but
you're doing them in the wrong place, so you need to jump through all
these hoops that you really shouldn't.

                Linus

