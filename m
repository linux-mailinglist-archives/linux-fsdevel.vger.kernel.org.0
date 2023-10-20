Return-Path: <linux-fsdevel+bounces-805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE877D05F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 02:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C89282473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85B39E;
	Fri, 20 Oct 2023 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhjRURgg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF73361;
	Fri, 20 Oct 2023 00:52:38 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F8FA;
	Thu, 19 Oct 2023 17:52:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9beb863816so298353276.1;
        Thu, 19 Oct 2023 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697763156; x=1698367956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgzfp5LbJfR0YnY8IHn9QHYvXqGLG0fdjjho/GjjqQo=;
        b=bhjRURggXuaXkZayDfggSw7AtQpk+SyGANqnJmNq4g/S45Mvc1Nb8tOjwHqUSUEn72
         f2Gwh/6ZdchG3XC+XGcIN5DuSElKL4qP7uW08lnZ7+trbZon2g/FVu2rtY48WN9UT3Fa
         RwdrWPxxcxbNxg3CkThFyJFeiZGuNJADWM+BhkVbUnzrmbkLPwtn2YfyFFGwAXvtLnjv
         xZ3/4CYopIXVBBZtxQVGT4Aak9xda/MsNGZoE7AnM0FHd/lmdjTzIb8uZQuBtWHhBlLW
         dXf087Z45GnC/P1SYsl0ssyGIupV66teX0GLzGUf9f80hLPQdpOZrGceVN+UssBU78eD
         KRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697763156; x=1698367956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgzfp5LbJfR0YnY8IHn9QHYvXqGLG0fdjjho/GjjqQo=;
        b=HdS0hIKzIh7SFxAPW7Dok4kJhC0OE/5wjYM7tA6qplPKEE/WkbEkKBec0HqiiCUzma
         EwPbmUkoKzFRgbK2DpYm+FFNgbDVKRtWm2VR3GM8sxsG9D9LKTOsAdG744ubkkp24M1q
         ISFdioCT0jc4xDW9A+hgPkIeGOG06pcAXAZBWlu/W7SRnMK+8yxnlon7ppERmFZrS+Pp
         MfWsS32Qc9zuoT9R2IeiGK/cCZ1m3qvfsMXcJNm/mnu7d71NTksYhsdCZ1YH08j0R8Qj
         VyWW+aJSqgg2lmInXk9nF45kuH+JHgq5nEJwGhy2+wq8p4jqHGZshauZiuHLnH7cBMCJ
         ztiw==
X-Gm-Message-State: AOJu0Yxg1KTm7J4wUd6+1AUkrmrwC0CD57xZr4bkwmKp2S7rQqr2EUGQ
	ru2TImxrLxPPCHJn0obM7+w=
X-Google-Smtp-Source: AGHT+IGr4CBljgUlj1oAMTPExXWIhzlBiiQhawo9dvh3i4x9mYNTG6jZN1i8G0L6gebdIwNjAzPqRw==
X-Received: by 2002:a25:9384:0:b0:d9a:e6d3:ae1c with SMTP id a4-20020a259384000000b00d9ae6d3ae1cmr396238ybm.53.1697763156198;
        Thu, 19 Oct 2023 17:52:36 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y3-20020ad457c3000000b0066d1e71e515sm269114qvx.113.2023.10.19.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:52:35 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 81B5C27C005A;
	Thu, 19 Oct 2023 20:52:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 19 Oct 2023 20:52:35 -0400
X-ME-Sender: <xms:Us8xZdxR9SjmGliZYdwsp661qDr54stDxmRs-tRrlI1rliLugthT7w>
    <xme:Us8xZdSexV6UsdcJBydP8TTQIWEaI5N8HoUnd11Jf_162B8WkoAdxvR1w6q6fszAG
    uHsgVBUmw8jpAFfqw>
X-ME-Received: <xmr:Us8xZXVwpyE4f3y9tLH0lkUDgKMYsV9-IBIJ4KGnRxJW44DekODM8GCyb9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeei
    hedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Us8xZfhrEyoPzmL27F1Aofh-jTb8sF6ejCNLxq0qqXy5G3NnN-niYw>
    <xmx:Us8xZfCMKTLhbmgJ_NoUiAcLnJVM4_i780kqb-Q5MK-PeKh1sowFdQ>
    <xmx:Us8xZYI-dz7SB1oNiJSTbYqotTrs9Zuz8cpKTC09D8EvkbHvL83beg>
    <xmx:U88xZbt6O9_oxioQlEtQy9H1wcjZgBxbf8lAlGVH8xnhogoHcRMWqQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 20:52:34 -0400 (EDT)
Date: Thu, 19 Oct 2023 17:52:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZTHPOfy4dhj0x5ch@boqun-archlinux>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>

On Thu, Oct 19, 2023 at 02:30:56PM +0000, Benno Lossin wrote:
[...]
> > +        let inode =
> > +            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(), ino) }).ok_or(ENOMEM)?;
> > +
> > +        // SAFETY: `inode` is valid for read, but there could be concurrent writers (e.g., if it's
> > +        // an already-initialised inode), so we use `read_volatile` to read its current state.
> > +        let state = unsafe { ptr::read_volatile(ptr::addr_of!((*inode.as_ptr()).i_state)) };
> 
> Are you sure that `read_volatile` is sufficient for this use case? The
> documentation [1] clearly states that concurrent write operations are still
> UB:
> 
>     Just like in C, whether an operation is volatile has no bearing
>     whatsoever on questions involving concurrent access from multiple
>     threads. Volatile accesses behave exactly like non-atomic accesses in
>     that regard. In particular, a race between a read_volatile and any
>     write operation to the same location is undefined behavior.
> 

Right, `read_volatile` can have data race. I think what we can do here
is:

	// SAFETY: `i_state` in `inode` is `unsigned long`, therefore
	// it's safe to treat it as `AtomicUsize` and do a relaxed read.
	let state = unsafe { *(ptr::addr_of!((*inode.as_ptr()).i_state).cast::<AtomicUsize>()).load(Relaxed) };

Regards,
Boqun

> [1]: https://doc.rust-lang.org/core/ptr/fn.read_volatile.html
> 
> -- 
> Cheers,
> Benno
> 

