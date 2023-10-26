Return-Path: <linux-fsdevel+bounces-1222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D606E7D7B43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 05:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037A61C20F07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E9BE73;
	Thu, 26 Oct 2023 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj/0YbEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98144646;
	Thu, 26 Oct 2023 03:31:45 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28D194;
	Wed, 25 Oct 2023 20:31:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso325025276.1;
        Wed, 25 Oct 2023 20:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698291102; x=1698895902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GDP4Ji1MuCk3r0rvr3Ck3tuIDn99qjLg2EPnlAxDfI=;
        b=aj/0YbEw0yP9qQ7QfTRz5qIG2TDcC5ABohmOSzlKIUC3RANRtYa4mblxwK8kXjMsXu
         tuNJThNtYoYzCeIDSRrC40XsXWkivt7d/9iTV/d9G9K2DcehZN8z/zPEv9E9/rGTC1nH
         4IXl+/3ORvulLO+GhGRkVv/zWR5Q3HjzrmnfFS7t3iAeJ3lqoPv22tlbI9s7nWS0gQRb
         8Z7yca9eKfFGbO/u8AZEy339yE8EDhjDiZUwLU804MWtNhFYBJfwy/eycemhkON6rb2m
         dZEwwym33n12u5Jx56GGc8+GnJSeOWdKBZBUdoPZwhIGWP0Aboptr5QL/tEO4mcRVlnh
         gpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698291102; x=1698895902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GDP4Ji1MuCk3r0rvr3Ck3tuIDn99qjLg2EPnlAxDfI=;
        b=K08QtJp+rxMU4OLsTqhted7TveJTT8touTl28by7pehvWjsr8QM0Pq5Jn8P9hb+Gk1
         PRtSrnZolpiN/3jOb1CsfSlZs26b8xH5rqx8P/VDnWVXMyj6Syn8t/rwONkAp7XQukKZ
         5DJXuZ1gCrBBghFMvJHSq1MUlDzpy9P8E+Z3xS5zbowoYt6en1qIIyBXdHl7JE5SqytB
         K4R1bn3bwgMUUl2BP1oFjuFU5csMbXBK2PpUHQnsLcvNUS3RZZ4v7NnnvPSoIE9oVXPE
         I2OTC+S1ul+1k/tEDXQ6V8AJh3d3PaOffyXZNiqWR/UVYpj5M9GosjZViWtwqqfXmJwr
         db/g==
X-Gm-Message-State: AOJu0Yy6cduxSzexMIM/br9kYyRDAjGEgQ0UQp1NlGuTGc/XUKnmiG4K
	du0TXNw9cVZXHzZWZX6v3fU=
X-Google-Smtp-Source: AGHT+IE6nWVjaeF4q/0JgTm0tiEMymvKwaOV3OJaUyaEBTfVrh0s6CM2luZevzfv2bUOnfOHijnNPw==
X-Received: by 2002:a25:918e:0:b0:d36:99eb:fc01 with SMTP id w14-20020a25918e000000b00d3699ebfc01mr15701879ybl.15.1698291102146;
        Wed, 25 Oct 2023 20:31:42 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w31-20020a25ac1f000000b00d9ab86bdaffsm4984302ybi.12.2023.10.25.20.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 20:31:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 3B45227C0054;
	Wed, 25 Oct 2023 23:31:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 25 Oct 2023 23:31:40 -0400
X-ME-Sender: <xms:m905ZXHeabl3payzsGhnipr0939fPX1WxlYXtDpPGBitYhhuzVsEdA>
    <xme:m905ZUVYD2YuuzvX0WrBbGOn5IYF7wzv9iuP8I0NfXrxZVCPa6fP7gmRROY4s1l4r
    FxrMeZeluMTg5R2Ew>
X-ME-Received: <xmr:m905ZZLr0mpZlucqGn--iRC_i9zBXh9l9NxoYesfxctvOjI6E6ycdTs-5fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:m905ZVHl7gYAxsC6OQxxI0jqcNrRPp__xknC5IfWjYIw-hYel9CIww>
    <xmx:m905ZdUtrnbZBu41BsfJOKZhpSQNJ0GohEakOq0QmMlAM6gtBAW0Wg>
    <xmx:m905ZQN-mXx_OzXtxWGhLrWAbo0hWFgf1CNJu5jeGVb7iSg9X2xGJw>
    <xmx:nN05ZX3KwPnCn483ZeL7KokyhKS-GhK5quGqZ46tVJYPU14rgOCwSw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 23:31:38 -0400 (EDT)
Date: Wed, 25 Oct 2023 20:31:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	Tom Rix <trix@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Matthew Wilcox <willy@infradead.org>,	Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <ZTndmXEBf37G84X-@Boquns-Mac-mini.home>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
 <VEhpQqgTM0U-aNYRUQ89ICIHW9Eehr66yw92DrmBZcZOah2mLqlz24HxEwDwYPVDOnaigDiZDEVl5mWqZJxoAtRheqTMjzpxuTKe0sr1uZs=@proton.me>
 <ZTmelWlSncdtExXp@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTmelWlSncdtExXp@boqun-archlinux>

On Wed, Oct 25, 2023 at 04:02:45PM -0700, Boqun Feng wrote:
[...]
> > > +/// The counter part of C `READ_ONCE()`.
> > > +///
> > > +/// The semantics is exactly the same as `READ_ONCE()`, especially when used for intentional data
> > > +/// races.
> > 
> > It would be great if these semantics are either linked or spelled out
> > here. Ideally both.
> > 
> 
> Actually I haven't found any document about `READ_ONCE()` races with
> writes is not UB: we do have document saying `READ_ONCE()` will disable
> KCSAN checks, but no document says (explicitly) that it's not a UB.
> 

Apparently I wasn't carefully reading the doc, in
tools/memory-model/Documentation/explanation.txt, there is:

	In technical terms, the compiler is allowed to assume that when the
	program executes, there will not be any data races.  A "data race"
	occurs when there are two memory accesses such that:

	1.      they access the same location,

	2.      at least one of them is a store,

	3.      at least one of them is plain,

	4.      they occur on different CPUs (or in different threads on the
		same CPU), and

	5.      they execute concurrently.

the #3 limits that in LKMM, data races cannot happen if both accesses
are marked (i.e. not plain).

Thank Paul for bringing this to me, and I will update this accordingly
in the next version.

Regards,
Boqun

> > > +///
> > > +/// # Safety
> > > +///
> > > +/// * `src` must be valid for reads.
> > > +/// * `src` must be properly aligned.
> > > +/// * `src` must point to a properly initialized value of value `T`.
> > > +#[inline(always)]
> > > +pub unsafe fn read_once<T: Copy>(src: *const T) -> T {
> > 
> > Why only `T: Copy`?
> > 
[...]

