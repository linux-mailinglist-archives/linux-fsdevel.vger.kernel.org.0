Return-Path: <linux-fsdevel+bounces-74868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOysOQT1cGmgbAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:47:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCEF596ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71B2576687F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3A48C3EA;
	Wed, 21 Jan 2026 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlChZSDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A647DFAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006293; cv=none; b=gT7icGPUV2IdCgizXvioL0LIABllzBTk18I2sgglhDimsfDi1zD0zUeMNAsGTe8pdySA89XxHnoq97VZpcUkP0k3JP9NIgTB77IUf7Zpy9sRICdfz1UTBTG3mv5jsw52oIIesKg28bdGcRfXY9M8fY6htXMR+DX6l2urnNIg+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006293; c=relaxed/simple;
	bh=JO/s/6KKvqMhoj8pQ+M8dYm9bOMaDHK5abW2HtiJvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZx/SvkA8+0OP32JGPW3aiLdRi4+guBwzlLptZ/ifm3Z36GX8SptmBWq5sM+a4Xns3nKMC5OoyWQXsvhJUNtAyM0syOMNPDhTYBeDbZgySZLVdstDN2z2hoPnHsmRiwnDuTNCH81CRVEhM3MFTFDVPwMQub4ojpHCaiZwaBxmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlChZSDR; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso13380330eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769006291; x=1769611091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLcZMH22PMLngVZW1Pr6WIQb6BYdcrFZicgkGSpRFnU=;
        b=BlChZSDRpmzr8AW6MexXEgKjDOhEUUqDBL4ju/qh4Nh/3571ZZ0uzyxviAJCpRUX+4
         JT5fDM3yOKhBxE6qif41s8CWMjsi4jEMcpWIQs6EbolOtWlkdYrIopSTXzO+DFTeQiFn
         TubvlZCCuQCpNV9ChOPEMZ/Ax2ZIfydYIgFi2A+bXzHFe/LtWn6yur1i1Ccb+zDb9xoX
         DMQubZt2PS5eEm9pCL57PdiL6hR+33j7fTrq7MgGYiqgIy9jSH6yUhd3OGwKOkLJfzr2
         YbrGFqdtMT3TTEM0FyJlHfUM0qGPK9+YzVtTkWqWCpLlzoEU2y7eiqND6n0j9ITrngjR
         o0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006291; x=1769611091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLcZMH22PMLngVZW1Pr6WIQb6BYdcrFZicgkGSpRFnU=;
        b=QuY16PC2N6md8q6nxQQhU5Gz83N+Mqm22fpddEsMeZsget61p7AqG0m+13EC0Phj41
         slpR6WwiAPWeTKnk1Js14UBM8V1yzTVuNvvtoqLOu6lWtjmShgsnJ/j7F6Jps0cCnDwl
         POj02ZB709q0lslPe3gjyGFV7DvU+up75Ep9YdFGNIKIY4Y7o4K/0BETMOyHLM1ZPm6I
         DMUyjZYxJJVpb7NQh7etW8mBhyvXsNhmYeP0xNXn2JBMTBMNYRwkSuHMXVXaZls0WsVO
         H6SaAJdQkZLwK9AUI0F99fFYa/eQ2ujMMqNZhEdwqUjl0M6jInUMgOLR1dNuzm4KOQv0
         rFRg==
X-Forwarded-Encrypted: i=1; AJvYcCV75r5Ax4qKHt89tRFe0uoOkn0DSrOXnlGaXmVQ92Wgul2F/09FM0/ayZbl9+H4KhyZJ4u2r5yytezd/6WR@vger.kernel.org
X-Gm-Message-State: AOJu0YySMCjpLCvkrL/siC0vWcSnkmH3QDiTWcbBjDELgwD9Im8747pn
	46fxusphTxnhJ6i90JqEK3tNGHj0UJVsF+swMJf/zM5x5CwALSxEmI6s
X-Gm-Gg: AZuq6aKfO3zGbqPxchpbsur/BwiXv3drphMpHhCO7yObrI+K1111JTB2Kp4szkda9oB
	MU8H7v58eFOC692YI92WLsrj+5L7S4h9m6A3XX9NtWQxQf8DgupNC3u/KwAccY9ilqVmM45e/RC
	c73ipWDogDu4g8LxCPqWP2qe/0hgyvP9XifC+HMAlJksgMpYbo7sh+g9dG/cD9LqGRO7NwOImCa
	20/SE1mh7Q+oidsVNnuhivrX3G3JN5FpIXfw7vg+zRAeZgLekLJwIeZ60X5TCOF9BdDcVT6rmjD
	R+bL8D4cvOgdN0ZGVWAxXOAU8ImJGXhBPq7iyKcjA9XCcgsrjUisASgpVCVIteazE2yEHDDr76W
	xdMDn78E5gBbdP4o7X37/WT369cia+WPzS5T17G1TUznkuj7DSejZq3GX9Ag3rINXPN6fBBd3cs
	xUXdxFlM8fBCT/by42uvdieEBi7Io38ERVayrDUaPgv3UDMhNehqehx59HfcCX46LPxgyt1COwI
	GqRJKrh1yX4h+g=
X-Received: by 2002:ac8:5a8a:0:b0:502:9abf:a89f with SMTP id d75a77b69052e-502d85074d8mr56654461cf.41.1769000304933;
        Wed, 21 Jan 2026 04:58:24 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f480sm112557811cf.13.2026.01.21.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:58:24 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9287AF40068;
	Wed, 21 Jan 2026 07:58:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 07:58:23 -0500
X-ME-Sender: <xms:b81waZUXCA5b7_qat5LZqZYJW1NkZrWahIWNw1B9RjoV5gfNEa8DkQ>
    <xme:b81waee_z64k_jmXfpq3dYEMz9KfulJ02ofTqys7ZsWInOcrR750BpxJY9PXWbdtn
    Iqvcu2ueC7hF4T3qzNAxfqGiO67hCJ8vNiyX0udzTXCOj56CF4h>
X-ME-Received: <xmr:b81wad-HHoOir8j-lQk0CLGKoNG0X6zglpvrbgIFjn1BGePx3lYVbVcr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeftdevhfevteettdfgffeigfekieetudejgfdukeeihfffheehueevleffkeef
    vdenucffohhmrghinheplhhptgdrvghvvghnthhsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghlvhgvrhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghsrghnqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgu
    segrrhhmrdgtohhm
X-ME-Proxy: <xmx:b81wadmCqcGj5xTe7itFHc83W1okWdihA5c0cJUg1ni6v3c0mqousA>
    <xmx:b81waWiT25eU8l5WhPNKNLqdLi895cSvJC2kDbHkx_nuWvamYB2oMA>
    <xmx:b81waVYdQFaGJc-eDx6CHOioS55nmBM78Vas1w_LPZO4D_XccSuzbA>
    <xmx:b81waaF6W27Y3C0x1lF0XdDOPxCG-UqTdRcwBdpB7OyWQkBURyQsbg>
    <xmx:b81waSZz55cpaJE_C3npEbNnvh-wgPvRnpertyHamIBoYHwZCFVCI2pV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:58:22 -0500 (EST)
Date: Wed, 21 Jan 2026 20:58:21 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
Message-ID: <aXDNbbvBfTYJD1kJ@tardis-2.local>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
 <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
 <CANpmjNN=ug+TqKdeJu1qY-_-PUEeEGKW28VEMNSpChVLi8o--A@mail.gmail.com>
 <aW_rHVoiMm4ev0e8@tardis-2.local>
 <CANpmjNNpb7FE8usAhyZXxrVSTL8J00M4QyPUhKLmPNKfzqg=Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNpb7FE8usAhyZXxrVSTL8J00M4QyPUhKLmPNKfzqg=Ww@mail.gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[garyguo.net,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-74868-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lpc.events:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8DCEF596ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 01:13:57PM +0100, Marco Elver wrote:
> On Tue, 20 Jan 2026 at 23:29, Boqun Feng <boqun.feng@gmail.com> wrote:
> [..]
> > > > > READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
> > > > > like memory_order_consume than it is memory_order_relaxed. This has, to
> > > > > the best of my knowledge, not changed; otherwise lots of kernel code
> > > > > would be broken.
> >
> > Our C's atomic_long_read() is the same, that is it's like
> > memory_order_consume instead memory_order_relaxed.
> 
> I see; so it's Rust's Atomic::load(Relaxed) -> atomic_read() ->
> READ_ONCE (for most architectures).
> 
> > > > On the Rust-side documentation we mentioned that `Relaxed` always preserve
> > > > dependency ordering, so yes, it is closer to `consume` in the C11 model.
> > >
> > > Alright, I missed this.
> > > Is this actually enforced, or like the C side's use of "volatile",
> > > relies on luck?
> > >
> >
> > I wouldn't call it luck ;-) but we rely on the same thing that C has:
> > implementing by using READ_ONCE().
> 
> It's the age-old problem of wanting dependently-ordered atomics, but
> no compiler actually providing that. Implementing that via "volatile"
> is unsound, and always has been. But that's nothing new.
> 
> [...]
> > > > I think this is a longstanding debate on whether we should actually depend on
> > > > dependency ordering or just upgrade everything needs it to acquire. But this
> > > > isn't really specific to Rust, and whatever is decided is global to the full
> > > > LKMM.
> > >
> > > Indeed, but the implementation on the C vs. Rust side differ
> > > substantially, so assuming it'll work on the Rust side just because
> > > "volatile" works more or less on the C side is a leap I wouldn't want
> > > to take in my codebase.
> > >
> >
> > Which part of the implementation is different between C and Rust? We
> > implement all Relaxed atomics in Rust the same way as C: using C's
> > READ_ONCE() and WRITE_ONCE().
> 
> I should clarify: Even if the source of the load is "volatile"
> (through atomic_read() FFI) and carries through to Rust code, the
> compilers, despite sharing LLVM as the code generator, are different
> enough that making the assumption just because it works on the C side,
> it'll also work on the Rust side, appears to be a stretch for me. Gary
> claimed that Rust is more conservative -- in the absence of any
> guarantees, being able to quantify the problem would be nice though.
> 

I don't disagree and share the similar concern as you do.

> [..]
> > > However, given "Relaxed" for the Rust side is already defined to
> > > "carry dependencies" then in isolation my original comment is moot and
> > > does not apply to this particular patch. At face value the promised
> > > semantics are ok, but the implementation (just like "volatile" for C)
> > > probably are not. But that appears to be beyond this patch, so feel
> >
> > Implementation-wise, READ_ONCE() is used the same as C for
> > atomic_read(), so Rust and C are on the same boat.
> 
> That's fair enough.
> 
> Longer term, I understand the need for claiming "it's all fine", but
> IMHO none of this is fine until compilers (both for C and Rust)
> promise the semantics that the LKMM wants. Nothing new per-se, the
> only new thing here that makes me anxious is that we do not understand
> the real impact of this lack of guarantee on Linux Rust code (the C
> side remains unclear, too, but has a lot more flight miles). Perhaps
> the work originally investigating broken dependency ordering in Clang,
> could be used to do a study on Rust in the kernel, too.

You mean this:

	https://lpc.events/event/16/contributions/1174/

? If so, that'll be great! I believe if we could learn about how Rust
compiler can mess up with dependency ordering, it'll be a very helpful
resource to understand how we can work with Rust compiler to resolve it
in a pratical way.

I believe that work was LLVM-based, so it should apply to Rust code as
well, except that we may need to figure out what optmization the Rust
front end would do at MIR -> LLVM IR time that could affect dependency
orderings.

Regards,
Boqun

