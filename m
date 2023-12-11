Return-Path: <linux-fsdevel+bounces-5543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0980D3F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018091C21601
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F64E625;
	Mon, 11 Dec 2023 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP3Jq4I1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D8FEA;
	Mon, 11 Dec 2023 09:35:45 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9e2a014e8so3139960b6e.2;
        Mon, 11 Dec 2023 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702316145; x=1702920945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/fg+fv8iUKsYhs2M+RJ0ajm1ojAT51bfa8djh97RvU=;
        b=CP3Jq4I1Y02qHoqb0qWcgX0JAcPeAVZkT/zrigeAZ63XjOtvmaFoaRPOCh8oGdle/E
         659t0Cqq9vwxfVzUnZEYkujXvjenFSymFnF2wn5KMkozGqr5VAEkRG4WlLyW6qSrkJpR
         ZiMwSfge/HSBrgaQeXoCKiaH0gA5DMWKBzfS8IuoYqortNoBw4stEkLTMwT60HdryXyQ
         GeGxxvBtOSCoCwhz/OOw+onOAKkeI1M152kgV3xzm6VeyJpIKtRKIDZBNxKA1PEyGwcf
         sdb6SxfnnbCojImLFcgufskb9jZL4zv0rFZRqHyDh4LTWKrxDisbCacPZ+g8PJQdSCo6
         lc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316145; x=1702920945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/fg+fv8iUKsYhs2M+RJ0ajm1ojAT51bfa8djh97RvU=;
        b=YUhCcYXwQUqIJx4Lkbd/hlMATx7JbBIvW3oOzMq6bHBZUODq5nU5sH05YJK4hzCTbY
         8w3Cas9sOuWDPN/YSVTxDTGJf5xfo0ZwBU80+/yQ5eSQNGhPBQKEp1UxW2kS+5+/ffoZ
         4+5+CN2So8iix7pQTU3+yO9QbnH3ftpEFCtQTEdfXt0gvAICQH10koS8J07vBmsqrkzK
         aFOmgv2gD1/VeOcdBtBBD34vUp+VOOOJz9hSBFw1IVXyKwG36TgXxqzm0fv7jpdLItt4
         133aBOeDtSF3xxD2UELtO+JIKFaFVe8u0nsu7ca8wgClnR7fihy01yA0qg6kvhxj2YIN
         UicA==
X-Gm-Message-State: AOJu0YxnsiFvHrrYl7oFnNwzzIs9/IUe+Gjs5b4wISiEyTr0Qu6CMb8V
	6x9128CNQhUVJhIpn8x0GIQ=
X-Google-Smtp-Source: AGHT+IGbDAuC5iH0V8rKYwviDyoY8ZqTEAItte85iztX5xcFqTiwSYA17QemR1kL/yaaXqa4VTm8ew==
X-Received: by 2002:a05:6359:2d02:b0:16e:29eb:98c8 with SMTP id rl2-20020a0563592d0200b0016e29eb98c8mr2011101rwb.30.1702316144995;
        Mon, 11 Dec 2023 09:35:44 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i19-20020a056214031300b0067aa164861dsm3467797qvu.35.2023.12.11.09.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:35:44 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id E6B6A27C005B;
	Mon, 11 Dec 2023 12:35:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 12:35:43 -0500
X-ME-Sender: <xms:b0h3ZWIE9Yx7UGpn71fZAxZX0HGg4FpbWLeNvatVYsHtlI9MfS2HXw>
    <xme:b0h3ZeIFkXRRQAI4ffLDQBsIVxj7aRkAq9sHq82eX8drH5G_JdRQmPSmxzB4wzmJ0
    EcYzaDSd47NCxaYIQ>
X-ME-Received: <xmr:b0h3ZWvlwExWXMUANLm9vi_qtr7Mr0mpo4kFxAUSQkGozewojwigSVK9NJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:b0h3ZbY8x4kxdTb793RGNUqtreNFBYEDz_Q58q1IHpHp1QJi2cp2wg>
    <xmx:b0h3ZdYhbLLNLQpl40sVkGsURrGwBKMPC0gPqvy8-47u-uUJv-BzNw>
    <xmx:b0h3ZXBIn2Sg4kV8292WFXKiqxnQxTij-1LTv3biM_I2vcAXeTqfLw>
    <xmx:b0h3ZaRVAf13DBbJgyJmPBC7MynptnzRLYnuMgV3gMCc_4nakVOLLg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 12:35:42 -0500 (EST)
Date: Mon, 11 Dec 2023 09:35:40 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <ZXdIbEqSCTO62BHE@boqun-archlinux>
References: <ZXZjoOrO5q7no4or@boqun-archlinux>
 <20231211153429.4161511-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211153429.4161511-1-aliceryhl@google.com>

On Mon, Dec 11, 2023 at 03:34:29PM +0000, Alice Ryhl wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> > On Wed, Dec 06, 2023 at 11:59:47AM +0000, Alice Ryhl wrote:
> > [...]
> > > @@ -151,6 +152,21 @@ pub fn as_ptr(&self) -> *mut bindings::file {
> > >          self.0.get()
> > >      }
> > >  
> > > +    /// Returns the credentials of the task that originally opened the file.
> > > +    pub fn cred(&self) -> &Credential {
> > 
> > I wonder whether it would be helpful if we use explicit lifetime here:
> > 
> >     pub fn cred<'file>(&'file self) -> &'file Credential
> > 
> > It might be easier for people to get. For example, the lifetime of the
> > returned Credential reference is constrainted by 'file, the lifetime of
> > the file reference.
> > 
> > But yes, maybe need to hear others' feedback first.
> > 
> > Regards,
> > Boqun
> 
> That would trigger a compiler warning because the lifetime is
> unnecessary.
> 

We can disable that warning if people need the information. Code is
mostly for reading, less often for compilation and changes.

> The safety comment explains what the signature means. I think that
> should be enough.
> 

For someone who has a good understanding of Rust lifetime (and the
elision), yes. But I'm wondering whether all the people feel the same
way.

Regards,
Boqun

> Alice

