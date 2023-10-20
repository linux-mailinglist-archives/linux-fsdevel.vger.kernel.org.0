Return-Path: <linux-fsdevel+bounces-804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5737D05D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 02:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0FC1C20F18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35DA1371;
	Fri, 20 Oct 2023 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhmSFgl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2180B;
	Fri, 20 Oct 2023 00:31:27 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D61C0;
	Thu, 19 Oct 2023 17:31:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af957bd7e9so202068b6e.3;
        Thu, 19 Oct 2023 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697761885; x=1698366685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r6n12dcvLAs9ctOBgjIkVIyGgOjKo0m6wllsB7zMSo=;
        b=JhmSFgl9RH1o931YReUBSH6RJDA+IbbZlAk6NQpO4BhZeCpp9et8HQ5ODpM+pSlny2
         ByoyiROScDssgoIjGFH/2gZ2Ko0hmbSoblTSHy2R3KrFvie3F0nlMu3UhPnw6EhdVV8f
         CK138E7prjdQJk+E13wZiDC4/zRQOjc3EFAwgjSqdf9Ho+CMVmjg4UYLPz7wSmU0N9dS
         BDZMLz8wuqlQFdcP3Iw6ZyFbJfppGpESoJXPseLULlD9BfCy49KYZ7P1M+4WqThiw/G0
         9MifS6yZVxoZQpiJ0Trg3Eaw1J7n0e0T3dmO875baQeitFPyLD99MdF7SZLX6XOfpQ1a
         6yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761885; x=1698366685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r6n12dcvLAs9ctOBgjIkVIyGgOjKo0m6wllsB7zMSo=;
        b=uizyMRZ5UEubrrl8U93KPm3m8DKgVq9kKV8LTaMklkHIWH7dAyaId+r4aO58P5z6Ql
         bvU1+1FSsxpYIT6X12g3Zm35jm/YV/7CFQbXX8fsfsc1FcBPiT3kLcK7OXZNe3sOqSZA
         BlfXldLw/VRPecTVJXdjHh4+m2VWpAZVJ9AynH9ZK6WHL7ZF44BzQTooH/SjOXpXb9VW
         V7SLZ7WRLUBTL1LnjbOpF/wsWCib2ktdIUXwmbGgpRAQ/K8TTSGHPwqLaaCoXesSuD/+
         3CdUJAYeEZm++WTchi/+50I9Oo/B5qAS2v/tBWEK5HBlEWUYpEjIQmJjdLbwXU79ccnd
         avsw==
X-Gm-Message-State: AOJu0Yy0olTZYRH2hHF5metn7zAHyD2n6or7QVJnN6NqkXI/6RGHlYss
	GCxO8PWSx+qeF21BhgONAzk=
X-Google-Smtp-Source: AGHT+IEY/0huzIt4M9qHmp3pJrCuA078DjJ4RMTNmKb4LbMojTa+j9VtbdyXS18ZPFndKt1D9yPK9Q==
X-Received: by 2002:a05:6808:1985:b0:3ae:1298:257a with SMTP id bj5-20020a056808198500b003ae1298257amr450011oib.1.1697761885357;
        Thu, 19 Oct 2023 17:31:25 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id jy12-20020a0562142b4c00b0065823d20381sm266957qvb.8.2023.10.19.17.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:31:25 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9FF8827C0067;
	Thu, 19 Oct 2023 20:31:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 19 Oct 2023 20:31:24 -0400
X-ME-Sender: <xms:WsoxZSs-BCawXg6xPOgxzM7x8KoHYbIpDMSffExRSWj_D1rVgCAq5w>
    <xme:WsoxZXc2Q-G04xaDuGVbpI9n2U6JFL9S-NR9InQGBPRmj_-8moa6Efb3OPzoY2v0z
    R6CqBkddErrv9Y_6Q>
X-ME-Received: <xmr:WsoxZdxyoat_MdbwQO_Bd-LIjLUbRUhmvBWm9tarRiwgVyyjYlvo4WtHB64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefhheeukedtvefhtedtvdet
    vedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:WsoxZdP7ohA4VeZYvRn0l2fU-Q5meqt8iYGFNXhNRfm1E2qT3gGIPA>
    <xmx:WsoxZS-PbOBmNwnuXiDXuf_2wKp8OCJVL-fT5uzgvhpaweyK9CSW2Q>
    <xmx:WsoxZVXNF1lpe2YeHKdFHNvEEDEj_aImkB3subKxI2X31sQPglMYdg>
    <xmx:XMoxZWTKQpo_Wl2PEkyy6jhZ0q-iuO_XW5mDFQiOtMoRt_iF7bTyBA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 20:31:22 -0400 (EDT)
Date: Thu, 19 Oct 2023 17:30:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZTHKQdAciXClXnut@boqun-archlinux>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-7-wedsonaf@gmail.com>

On Wed, Oct 18, 2023 at 09:25:05AM -0300, Wedson Almeida Filho wrote:
[...]
> +/// An inode that is locked and hasn't been initialised yet.
> +#[repr(transparent)]
> +pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
> +
> +impl<T: FileSystem + ?Sized> NewINode<T> {
> +    /// Initialises the new inode with the given parameters.
> +    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
> +        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
> +        let inode = unsafe { &mut *self.0 .0.get() };
> +
> +        let mode = match params.typ {
> +            INodeType::Dir => {
> +                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
> +                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
> +
> +                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
> +                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
> +                bindings::S_IFDIR
> +            }
> +        };
> +
> +        inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
> +        inode.i_size = params.size;
> +        inode.i_blocks = params.blocks;
> +
> +        inode.__i_ctime = params.ctime.into();
> +        inode.i_mtime = params.mtime.into();
> +        inode.i_atime = params.atime.into();
> +
> +        // SAFETY: inode is a new inode, so it is valid for write.
> +        unsafe {
> +            bindings::set_nlink(inode, params.nlink);
> +            bindings::i_uid_write(inode, params.uid);
> +            bindings::i_gid_write(inode, params.gid);
> +            bindings::unlock_new_inode(inode);
> +        }
> +
> +        // SAFETY: We are manually destructuring `self` and preventing `drop` from being called.
> +        Ok(unsafe { (&ManuallyDrop::new(self).0 as *const ARef<INode<T>>).read() })

How do we feel about using transmute here? ;-) I.e.

	// SAFETY: `NewINode` is transparent to `ARef<INode<_>>`, and
	// the inode has been initialised, so it's safety to change the
	// object type.
	Ok(unsafe { core::mem::transmute(self) })

What we actually want here is changing the type of the object (i.e.
bitwise move from one type to another), seems to me that transmute is
the best fit here.

Thoughts?

Regards,
Boqun


> +    }
> +}
> +
> +impl<T: FileSystem + ?Sized> Drop for NewINode<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The new inode failed to be turned into an initialised inode, so it's safe (and
> +        // in fact required) to call `iget_failed` on it.
> +        unsafe { bindings::iget_failed(self.0 .0.get()) };
> +    }
> +}
> +
[...]

