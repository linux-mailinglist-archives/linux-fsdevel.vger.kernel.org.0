Return-Path: <linux-fsdevel+bounces-874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C37D1E12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802FEB20F81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E901A5AD;
	Sat, 21 Oct 2023 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+UnAgbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67177D520;
	Sat, 21 Oct 2023 15:57:41 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA7188;
	Sat, 21 Oct 2023 08:57:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d134a019cso13513066d6.3;
        Sat, 21 Oct 2023 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697903856; x=1698508656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu6D5giM4a4Fcre4Qbcdt0ImGLkREJKb4WB09cNMMfQ=;
        b=B+UnAgbWbw9927CWZhBr29y87a+mJ4MFPkqBImoCusXvevbf4ocBsYDHkj3OmA2dQQ
         XGg0V5igG0wfPZVoHjgxInCvHLfdlVMEpjcFtyimxgDeIzSLWVtdRr6RM3vbmsvdIj2T
         tflxYDBVs79BLDiMSB3pVkuE97BRyqalw8IQfZxKnw4xmhIgeCh8IIOfu2Av2JQl0cs3
         +akT9dcpe5qg+QqAZaG82J0I3NjHd9qcJAkRbFgVsUaVKM4kvRHXMUvq7wR3io9TPMBP
         bSp+69DJ43AMRf3JPospHyanOXIC8u8RHrskpVgkWmrtZdzzof6iuYzN6O72OfZaXLuw
         J+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697903856; x=1698508656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu6D5giM4a4Fcre4Qbcdt0ImGLkREJKb4WB09cNMMfQ=;
        b=ECLaWIJBmcziJI4wxOJcoLdXB0lG/powl2qk+14ekp32H44+9nZkKzP+h5hvk/dtaE
         VJiXKyp9BsrAffp3+/pk63tEj4zp0eJjkbZFuoRdGLoFooIh2aQO70Tdr+LvfGgA7XJt
         gJSQrjChBYctNWyUWcJ02qEUEW2VHfLrc2OxHGgBT69aHaFi9m8jgsyQ9TZO3/sQWM1H
         cNj1HL2bIbnFw6Ne0dzmhkdd3HPxIBaxJNaDxrgDuZUcl+ghwMDMS82byWDoSyHvYeWF
         OCAzN3V1nyJmm5o+jMUUxsE2mGkgKLwnmYGZpbNPd9kLeDy3DDMdbuT8Pa+FRxHwroBF
         JnrQ==
X-Gm-Message-State: AOJu0Yx2OjDvoAw6hciSHkuH8SSQbKx1fcJ100SgOerQV/zGFdf3OX5F
	rO5GJfei6FA+VcSQC51EVj0=
X-Google-Smtp-Source: AGHT+IEQMqcTtaZcL+mepL5Fw3EZCrsmdE5GA7MyQNK0vopnH1IRw5NGlxADq4kRZgt0hGBY5RvFUQ==
X-Received: by 2002:a05:6214:212e:b0:656:3407:f45a with SMTP id r14-20020a056214212e00b006563407f45amr8271779qvc.43.1697903855895;
        Sat, 21 Oct 2023 08:57:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dr20-20020a05621408f400b0065af24495easm1555567qvb.51.2023.10.21.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 08:57:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2576627C005B;
	Sat, 21 Oct 2023 11:57:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 21 Oct 2023 11:57:35 -0400
X-ME-Sender: <xms:7fQzZbJGMjZYTdxYNNYaEDqyvCPHJiWaVAdzw1ey99ZixBiKjmkhfg>
    <xme:7fQzZfIh-g4UkpngjO9nEa7yZvgAlHyMFAhxCjcMW211Sxjcya9lZR-gjeIzHjVge
    3c2CScbQg6k2forhQ>
X-ME-Received: <xmr:7fQzZTs4eDn9s7ggSeKAJhgtSAkuteiZx1sk7sOpVcOlkxwqbJ-NkFAdppE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfevvdejheekhffffefhteethffhvdefveejtedtudduvefhtdevgffghfek
    hfegnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:7fQzZUZf_L_H-vlDMDsL-UNkSHAS7fOxACygfPXywWU47k-jCbjGWg>
    <xmx:7fQzZSY52UC10IAAkbOxGTOJ85GtbwZ22S0pj72RcZlSDLqpWN3e1g>
    <xmx:7fQzZYAVxOle8Jy9KgtFX-lwHdzb-a2P_Qg6HJ4JKuogWMJgnfw8hA>
    <xmx:7_QzZfRgON_N47lED8sp_w_Jfa41pmCd-OVZ0efXrKJ5YZxDIfR4Fg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 11:57:33 -0400 (EDT)
Date: Sat, 21 Oct 2023 08:57:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux>
 <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>

On Sat, Oct 21, 2023 at 01:48:28PM +0000, Benno Lossin wrote:
> On 20.10.23 02:52, Boqun Feng wrote:
> > On Thu, Oct 19, 2023 at 02:30:56PM +0000, Benno Lossin wrote:
> > [...]
> >>> +        let inode =
> >>> +            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(), ino) }).ok_or(ENOMEM)?;
> >>> +
> >>> +        // SAFETY: `inode` is valid for read, but there could be concurrent writers (e.g., if it's
> >>> +        // an already-initialised inode), so we use `read_volatile` to read its current state.
> >>> +        let state = unsafe { ptr::read_volatile(ptr::addr_of!((*inode.as_ptr()).i_state)) };
> >>
> >> Are you sure that `read_volatile` is sufficient for this use case? The
> >> documentation [1] clearly states that concurrent write operations are still
> >> UB:
> >>
> >>      Just like in C, whether an operation is volatile has no bearing
> >>      whatsoever on questions involving concurrent access from multiple
> >>      threads. Volatile accesses behave exactly like non-atomic accesses in
> >>      that regard. In particular, a race between a read_volatile and any
> >>      write operation to the same location is undefined behavior.
> >>
> > 
> > Right, `read_volatile` can have data race. I think what we can do here
> > is:
> > 
> > 	// SAFETY: `i_state` in `inode` is `unsigned long`, therefore
> > 	// it's safe to treat it as `AtomicUsize` and do a relaxed read.
> > 	let state = unsafe { *(ptr::addr_of!((*inode.as_ptr()).i_state).cast::<AtomicUsize>()).load(Relaxed) };
> 
> I am not sure if that is enough. What kind of writes happen
> concurrently on the C side? If they are atomic, then this should
> be fine, if they are not synchronized at all, then it could be
> problematic, as miri says that it is still UB:
> https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=aa75fb6805c8d67ade8837531a2096d0
> 

You're not wrong, my suggestion here had the assumption that write part
of ->i_state is atomic (I hadn't look into that). Now a quick look tells
it isn't, for example in fs/f2fs/namei.c, there is:

	inode->i_state |= I_LINKABLE;

so I think we need to take the inode->i_lock here for a data-race free
solution. Or if we have something like:

	https://github.com/rust-lang/unsafe-code-guidelines/issues/321

in Rust.

Benno, notice my reasoning about whether a write is atomic is less
strict, since in C side, in the current rule of the kernel, plain
writes to machine words can be treated as atomic, in case you're
interested CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is the pointer ;-)

While we are at it, adding Marco, could kcsan work for Rust code? If I
understand correctly, as long as Rust compilers could generate these
__tsan_* instrument functions, it should work, right?

Regards,
Boqun

> -- 
> Cheers,
> Benno

