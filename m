Return-Path: <linux-fsdevel+bounces-5781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087CD8107B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 02:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E0B1F212E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D01109;
	Wed, 13 Dec 2023 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwQHDQFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402DB7;
	Tue, 12 Dec 2023 17:35:20 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f3c4914e5so339471885a.3;
        Tue, 12 Dec 2023 17:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702431319; x=1703036119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lJwnAAHRmDie2pCrUCphBkEu6klu8JgvdhjOopanDfU=;
        b=kwQHDQFrJDzG5yIdpzvzHkJ+CfsKxHX4ExmhczoFuHYuSZsSweICiCrdR4ViSqEHpB
         Q2o3z/IAojOCPhuhYzb6PJmP4RtJzCYMiOGOUuGhRFnPClHJaCu/hjFHdEp4msOokpAw
         D8TVtPF6bZH5uIauiMwj9/++fAkDBo4UgHVNWppPJwRDGbuU7io0O4H+yLx0HJlpi613
         FZE5YvwBSa0H7Y+BwH4Iloko+oHH3LJHoX+6Jlwy780Xe2RD2vW5Nm6gbJLBTl2t5uyG
         eSaHn0k9UFc68EZf9kK7a0YFraP2tHhb3vz5Qqr3yaVT+O8syXq+C/mX7FLlM6mK4qpf
         Pz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431319; x=1703036119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJwnAAHRmDie2pCrUCphBkEu6klu8JgvdhjOopanDfU=;
        b=Co0phw3DhJueEhzJxTyxa+SVgNIl6OMlCtH9Q+2Dq27DrK1ABuvIs8S2Q/7Jr4xvcA
         J5356iLNkMr3vBYqduwX8rZdrf8BX7JYXWNwTfUSLu48CntUFoRR1Ds0Uil/iHp/foPW
         CFNZLYFHLLOLUF6n9rsYmy4GvHMetsL0o8PZHnfU+Zx5CMqzZd3a4+yku5dgjRuxtiVo
         xA91ul0ZkslfcjbwvTyGso+1jxZ66ZkLlvSXD9aaVcN4sE53QR/VFkLz5CPjJ9t7CeEA
         366iLiaPhXODHlmT83vjgfZg+H2qq6LJOctFJ0obXCF0/FxwPGy+73S8Du3HMVd2mUBD
         8z0A==
X-Gm-Message-State: AOJu0YzInz/HAFn4a0jJZT9YB/Nujf9J2arogBGxyVrABxLp4PPOv0ez
	VshfnRoYjZ5/Rw5ZnrXKJps=
X-Google-Smtp-Source: AGHT+IH5uQAhf0dYg8G6GsbP6/h3lRg7sgiDpTWBp+yT+OWEF+BupOCK+goSAt7xUeDoSwMOu4Q2RQ==
X-Received: by 2002:a05:620a:55bb:b0:77e:fba3:4f12 with SMTP id vr27-20020a05620a55bb00b0077efba34f12mr8219438qkn.104.1702431319080;
        Tue, 12 Dec 2023 17:35:19 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a04da00b0077d7557653bsm4156880qks.64.2023.12.12.17.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:35:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id D6AFC27C0054;
	Tue, 12 Dec 2023 20:35:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Dec 2023 20:35:17 -0500
X-ME-Sender: <xms:VAp5ZasDZAqiwGMMW4FVA9DG0JUM-EUgCZDud7s-V7kx3bWxVLhWIQ>
    <xme:VAp5ZfdNeztR4IS8ooDpE3-t9kMz4Ka0OBMqe8KzkcJ1svhWgKDFyd1yyY_m9gKHo
    9XbV55N2f8sHC03_A>
X-ME-Received: <xmr:VAp5ZVx0oCQe2ydAocHbXI7t3Z9j0rjD2uGgMPiWUCooBVhcHunl0sTVhQM6vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:VAp5ZVOfjxJQ39jZxDVGl67RMBKX52XLF2FLmMQHsl6WjUD3hVx-QA>
    <xmx:VAp5Za8sEwdmHXM0Y7HLKlOmFYDsmeS-SQirFy9AflqRXHyQj13FQQ>
    <xmx:VAp5ZdXcibFYGGDhIgOTjSaxngToBMwSun7yg_WgPRf5tR8Quss_cw>
    <xmx:VQp5ZcFKCL_iJ0iIcursLMAHJTW4upGjV-ZW_XfDwE0EV7jwPDWN8w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 20:35:16 -0500 (EST)
Date: Tue, 12 Dec 2023 17:35:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <ZXkKTSTCuQMt2ge6@boqun-archlinux>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-7-af617c0d9d94@google.com>
 <k_vpgbqKAKoTFzJIBCjvgxGhX73kgkcv6w9kru78lBmTjHHvXPy05g8KxAKJ-ODARBxlZUp3a5e4F9TemGqQiskkwFCpTOhzxlvy378tjHM=@proton.me>
 <CAH5fLgiQ-7gbwP2RLoVDfDqoA+nXPboBW6eTKiv45Yam_Vjv_A@mail.gmail.com>
 <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>

On Tue, Dec 12, 2023 at 05:01:28PM +0000, Benno Lossin wrote:
> On 12/12/23 10:59, Alice Ryhl wrote:
> > On Fri, Dec 8, 2023 at 6:53 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >> On 12/6/23 12:59, Alice Ryhl wrote:
> >>> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
> >>> +        let ptr = self.0.get();
> >>> +        // SAFETY: The `ptr` is valid because it originates from a reference, and the `_qproc`
> >>> +        // field is not modified concurrently with this call since we have an immutable reference.
> >>
> >> This needs an invariant on `PollTable` (i.e. `self.0` is valid).
> > 
> > How would you phrase it?
> 
> - `self.0` contains a valid `bindings::poll_table`.
> - `self.0` is only modified via references to `Self`.
> 
> >>> +        unsafe { (*ptr)._qproc }
> >>> +    }
> >>> +
> >>> +    /// Register this [`PollTable`] with the provided [`PollCondVar`], so that it can be notified
> >>> +    /// using the condition variable.
> >>> +    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
> >>> +        if let Some(qproc) = self.get_qproc() {
> >>> +            // SAFETY: The pointers to `self` and `file` are valid because they are references.
> >>
> >> What about cv.wait_list...
> > 
> > I can add it to the list of things that are valid due to references.
> 

Actually, there is an implied safety requirement here, it's about how
qproc is implemented. As we can see, PollCondVar::drop() will wait for a
RCU grace period, that means the waiter (a file or something) has to use
RCU to access the cv.wait_list, otherwise, the synchronize_rcu() in
PollCondVar::drop() won't help.

To phrase it, it's more like:

(in the safety requirement of `PollTable::from_ptr` and the type
invariant of `PollTable`):

", further, if the qproc function in poll_table publishs the pointer of
the wait_queue_head, it must publish it in a way that reads on the
published pointer have to be in an RCU read-side critical section."

and here we can said,

"per type invariant, `qproc` cannot publish `cv.wait_list` without
proper RCU protection, so it's safe to use `cv.wait_list` here, and with
the synchronize_rcu() in PollCondVar::drop(), free of the wait_list will
be delayed until all usages are done."

I know, this is quite verbose, but just imagine some one removes the
rcu_read_lock() and rcu_read_unlock() in ep_remove_wait_queue(), the
poll table from epoll (using ep_ptable_queue_proc()) is still valid one
according to the current safety requirement, but now there is a
use-after-free in the following case:

	CPU 0                        CPU1
	                             ep_remove_wait_queue():
				       struct wait_queue_head *whead;
	                               whead = smp_load_acquire(...);
	                               if (whead) { // not null
	PollCondVar::drop():
	  __wake_pollfree();
	  synchronize_rcu(); // no current RCU readers, yay.
	  <free the wait_queue_head>
	                                 remove_wait_queue(whead, ...); // BOOM, use-after-free

Regards,
Boqun

