Return-Path: <linux-fsdevel+bounces-5983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A9811A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB8F282711
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF83A8EA;
	Wed, 13 Dec 2023 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAN56HnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25477D0;
	Wed, 13 Dec 2023 09:05:36 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-425952708afso50251451cf.0;
        Wed, 13 Dec 2023 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702487135; x=1703091935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaZOg6uPTywifNeWY/lhqitjb+T4PmJ5HvOYe4JLoEc=;
        b=fAN56HnYVTBYv89mKu8lHU6DwDhRB0utUi4cTovqijKV0NCXjiJoCaJSbAeV0iwCyy
         dN7ccgDcXzOYJwpEmCii0HuHUqCc/ugge5ZihV9JVGnmy1w6SPYUuoPh5lzrrIhRCKaS
         NOo+AthpA0VcfEz91ViHiTyP3G0jwBfVF6LNa/lhDDBDm+cD0ufX4PjX6C4ZNYU4QKYc
         4wOSUwOwi+j2vb9MzbnQPV756KNoI2JqdvBfvkWBIJdPjXVjhr08ltVm6QBa/6VveiJ6
         I2JLjdIhRQDVWURTtggZTXY7WQCCkEyR3bSk95Su4DbohnyLA2chyEKIrbHF6fPQMQZO
         xcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487135; x=1703091935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaZOg6uPTywifNeWY/lhqitjb+T4PmJ5HvOYe4JLoEc=;
        b=Ae+0TbIoyZMYjWVW3I8Or6P41RsrTs+vlkpzk9VK00RLaFach9GOE9rx8rq/eHfwga
         v5/e9JFcbYWHeU5AR2BoA6uJgo8Fj81R3qhTJwUz8+lbhTUTAYhBWbCeC3Y9xOz6uozU
         uv7KtcS+p2jTth/nM0E50nfYnBWx04dP1G+zmoXgggXlmI3Cw17L2bAUxx9SHks1DrfB
         zafLRrjDRQUFSV1BT4CR/jWos0R4i5HBgSIxNOK/nQT1HFfNHQ4aUYhk6OxrN7lYnEUX
         CAeXPbSfeF1mscoKM1ak+npYXhQ6wf6x86dt3A2ckSNNOLZcNSFOg9UBgSOBYc6xE8uc
         pllQ==
X-Gm-Message-State: AOJu0Ywzgou4diBG0rSnkfGpPerO9uabmlAf+g56ZCT7wyDPTeLEo8zo
	XKGm7AiIuRiGSNuyTZ/AHmQ=
X-Google-Smtp-Source: AGHT+IHtYdP9DEk855hTYxYHeMk1EY6txXkJrmfCGNPHjRbM0uyaFyTnbRsZP54z27JNtYS7Wxnkig==
X-Received: by 2002:a05:622a:252:b0:425:88fc:8abb with SMTP id c18-20020a05622a025200b0042588fc8abbmr12875357qtx.12.1702487135165;
        Wed, 13 Dec 2023 09:05:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e18-20020ac85992000000b004254b465059sm4890154qte.47.2023.12.13.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:05:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1088027C0054;
	Wed, 13 Dec 2023 12:05:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 13 Dec 2023 12:05:34 -0500
X-ME-Sender: <xms:XOR5ZfCZIyAZECwkunnTvOl9-G3WYlajIle5fpkVvUlRn29n7pBttQ>
    <xme:XOR5ZVhHrPzD53EwKugaa0Ukv8Xv-8yhizxlLvJPifeVyBat9XheQFVGc2eNJHH32
    sN5ISTH7e_El1JZbg>
X-ME-Received: <xmr:XOR5ZanI82lXWVbKsflG3_ToDljlbkrzGgQftEau0GrSadQ5t-PFulWuPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XOR5ZRyyw_H9ToCV6YMD2B6K8OVb-iMWFs9IzdGUhO37yFOG80EwzA>
    <xmx:XOR5ZUTCa3jqzin7Nxho19RNwz4iyw7CbYNGzXUcPkX7qRFyFri8aQ>
    <xmx:XOR5ZUZrAaZOmz0hCE2HgWTsmlh_5b-6ctOta8DTP8DPnCoDkzeWQQ>
    <xmx:XuR5ZQp20kcE-tiT3ep6Q3jTPjX3Qd6tZbpZqz9JElX3dLcmynVGSQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 12:05:31 -0500 (EST)
Date: Wed, 13 Dec 2023 09:05:30 -0800
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
Message-ID: <ZXnkWsSvxbFDoDGU@Boquns-Mac-mini.home>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-7-af617c0d9d94@google.com>
 <k_vpgbqKAKoTFzJIBCjvgxGhX73kgkcv6w9kru78lBmTjHHvXPy05g8KxAKJ-ODARBxlZUp3a5e4F9TemGqQiskkwFCpTOhzxlvy378tjHM=@proton.me>
 <CAH5fLgiQ-7gbwP2RLoVDfDqoA+nXPboBW6eTKiv45Yam_Vjv_A@mail.gmail.com>
 <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
 <ZXkKTSTCuQMt2ge6@boqun-archlinux>
 <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>

On Wed, Dec 13, 2023 at 09:12:45AM +0000, Benno Lossin wrote:
[...]
> > 
> > Actually, there is an implied safety requirement here, it's about how
> > qproc is implemented. As we can see, PollCondVar::drop() will wait for a
> > RCU grace period, that means the waiter (a file or something) has to use
> > RCU to access the cv.wait_list, otherwise, the synchronize_rcu() in
> > PollCondVar::drop() won't help.
> 
> Good catch, this is rather important. I did not find the implementation
> of `qproc`, since it is a function pointer. Since this pattern is
> common, what is the way to find the implementation of those in general?
> 

Actually I don't find any. Ping vfs ;-)

Personally, it took me a while to get a rough understanding of the API:
it's similar to `Future::poll` (or at least the registering waker part),
it basically should registers a waiter, so that when an event happens
later, the waiter gets notified. Also the waiter registration can have a
(optional?) cancel mechanism (like an async drop of Future ;-)), and
that's what gives us headache here: cancellation needs to remove the
waiter from the wait_queue_head, which means wait_queue_head must be
valid during the removal, and that means the kfree of wait_queue_head
must be delayed to a state where no one can access it in waiter removal.

> I imagine that the pattern is used to enable dynamic selection of the
> concrete implementation, but there must be some general specification of
> what the function does, is this documented somewhere?
> 
> > To phrase it, it's more like:
> > 
> > (in the safety requirement of `PollTable::from_ptr` and the type
> > invariant of `PollTable`):
> > 
> > ", further, if the qproc function in poll_table publishs the pointer of
> > the wait_queue_head, it must publish it in a way that reads on the
> > published pointer have to be in an RCU read-side critical section."
> 
> What do you mean by `publish`?
> 

Publishing a pointer is like `Send`ing a `&T` (or put pointer in a
global variable), so that other threads can access it. Note that since
the cancel mechanism is optional (best to my knowledge), so a qproc call
may not pushlish the pointer.

Regards,
Boqun

