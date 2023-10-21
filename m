Return-Path: <linux-fsdevel+bounces-880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F67D1F23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 21:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3631C209B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 19:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7EF208BA;
	Sat, 21 Oct 2023 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrgRTYJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D0C2F9;
	Sat, 21 Oct 2023 19:40:53 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D31A4;
	Sat, 21 Oct 2023 12:40:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7788fb06997so137183885a.0;
        Sat, 21 Oct 2023 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697917251; x=1698522051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8/nRaIErbymSTbUM3vkBwNIfx5tFBQe6q37UhFB1B4=;
        b=GrgRTYJgCD8AP82TYhvVJVfA27qqVAwHZILlsFDrTXF8i+NIVaGotfwGgJefazkD1C
         uyOEUWP1yRrmrUn8l1WT4nOCyTmQ4Dfo+SujlqAjL1uUfs12whsw+7t/T3aVXX3bdBbF
         /gZlzfDeyY6rZDj91jqNyISUUhpC7rGJWX3JUL6KO2EcU9MUzsTRs/57mp1V2s2vgIP8
         SKcDzTdoFp/4pDWP48Szph1WxEdRvSdltVm58V3rR/mcvcZMDqKkfqv1g7BoSGcnxSyb
         eIbqWiGfC4tbVXIYVoG6RT2I+IHpL5TozCkRMc6/QZWHSyfz+hy22IABIk/yrFRtNL+X
         pDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697917251; x=1698522051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8/nRaIErbymSTbUM3vkBwNIfx5tFBQe6q37UhFB1B4=;
        b=UoCbJT6MhCvhN0zzW8IoJT+cJrshXEhdpnJKXddYVbniHsZEFZnPhACRmeQGgSWUKb
         BkgEPhrecKOoQj5xmMXm65AHP7c1CWQ67/fHVijJ9fnh7ZhZWSm+gZ1Ur5s9H9xT/bNK
         YDvT4AXVil07eyv3TXr8WjTfyhuAL+PX0rHr12gL7oQ+gfEF6PNx0WCnITVRVGtjoEwx
         2Oo5e2eCKkUHJ2bM4wHU6aHZZSiDV6qwvWqSmcE4NcZ35WTj4ezQSq4gNp6cCZaK0wDQ
         k+aQJISg98XShJZ228f3OYZOz2UZQT/uK5BbU8cw90yVI+n2ZG/YxrJR4ktNUq7czGMX
         LyZg==
X-Gm-Message-State: AOJu0YxJICerwZSg4zFhYWU82yJKhqAoSHRUZCo1dYJPdJ99tFSb7LzY
	R+fx9kV+0hrxBlP3uNKSmny3gzDcHp0=
X-Google-Smtp-Source: AGHT+IGSSTSqkjtpCgddwwrJ9ET+adZ4Yis9BixYfFmzYGct/3j5rpOHpwR+R2CSX1Hb08D4Eb6zlg==
X-Received: by 2002:a05:620a:4686:b0:774:2e8a:ccc6 with SMTP id bq6-20020a05620a468600b007742e8accc6mr6311304qkb.32.1697917250703;
        Sat, 21 Oct 2023 12:40:50 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a131600b007777521dca4sm1544337qkj.21.2023.10.21.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 12:40:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0B7CD27C0067;
	Sat, 21 Oct 2023 15:34:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 21 Oct 2023 15:34:01 -0400
X-ME-Sender: <xms:pyc0ZYtnofEwjLijvrBrj70uPDUAdiJsumVa4K3vwti4Vb9RXHuw0A>
    <xme:pyc0ZVcU2irtn2FoB5FbzOqX3wXGw8jAO0Dmb2B1xC_64UrQ3BPeamEG6daqga3hb
    Vyz4VCKywpCtEhBDw>
X-ME-Received: <xmr:pyc0ZTwrtVZxW0aNfCveH07vj9UcZnCztC2Bfcvqb1qkiwbISM7uA2egY-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pyc0ZbO8Ltj1kGHI7Eaoj0L6j_-xbsEiXjyjP7EdquVoRlIcvK7Usg>
    <xmx:pyc0ZY_utnSfxW0SIXprdI8b73aaSARSkCn4GytjlkHTNz0rUj0h4A>
    <xmx:pyc0ZTWp8nqRywC4bHmrBpdvlWXeDnjPEmD9v9kzvk2fQnZg-ieTCA>
    <xmx:qSc0ZZ1Cglnm6KC3RFzM-tt-Hi_2MPlg_pY6QXpWNH4KVV21faRbxg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 15:33:59 -0400 (EDT)
Date: Sat, 21 Oct 2023 12:33:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Benno Lossin <benno.lossin@proton.me>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux>
 <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>
 <ZTQDztmY0ivPcGO/@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTQDztmY0ivPcGO/@casper.infradead.org>

On Sat, Oct 21, 2023 at 06:01:02PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 21, 2023 at 08:57:30AM -0700, Boqun Feng wrote:
> > You're not wrong, my suggestion here had the assumption that write part
> > of ->i_state is atomic (I hadn't look into that). Now a quick look tells
> > it isn't, for example in fs/f2fs/namei.c, there is:
> > 
> > 	inode->i_state |= I_LINKABLE;
> 
> But it doesn't matter what f2fs does to _its_ inodes.  tarfs will never
> see an f2fs inode.  I don't know what the rules are around inode->i_state;

Well, maybe I choose a bad example ;-) I agree that tarfs will never see
an f2fs inode and since tarfs is the only user right now, the data race
should really depend on tarfs right now. But this is general filesystem
Rust API, so it should in theory work with everything. Plus fs/dcache.c
has something similar:

	inode->i_state &= ~I_NEW & ~I_CREATING;

> I'm only an expert on the page cache, not the rest of the VFS.  So
> what are the rules around modifying i_state for the VFS?
> 

Agreed, same question here.

Regards,
Boqun

> 

