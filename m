Return-Path: <linux-fsdevel+bounces-7351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B02823FEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 11:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C881C23E24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23E20DF6;
	Thu,  4 Jan 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="XYZz2KS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8A20DDD
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5569472f775so455481a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 02:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704365609; x=1704970409; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=13tc0pBPhD5uwpbLlXZDiNLNXAB5mfp9UzzPnCfrFY0=;
        b=XYZz2KS+KB/Tbqaf2rnNIDs84WszQwKz/IJPz+YEulncpl06HxPhSmn5LQLZXhtRvQ
         ytFqCMqlHQwst2KL0iE7Nn7UJ+5+pe3WWhKnfnmu5AG2efJ19XucA47QA5yA+AQkDWD6
         kPfSnprFdKLgerD907MRJ5Bj1MO1eYVKNq0bDZKDB9RCQEvG2KOSGahMUeKRj3XmHk/N
         Ae2v9OSy7QF2oBEBeivZka850Di+6i/+V0PBJFg2YeKfp/seY6xIfSYMQh94B2Dj0DQF
         MxRwDu7KPp4YVZ2QO90jvVlhOsWjgxTBENkAopO6oW7WuHc3iB0XatHpDRaOGw1DOr+H
         QPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704365609; x=1704970409;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13tc0pBPhD5uwpbLlXZDiNLNXAB5mfp9UzzPnCfrFY0=;
        b=mpP+QHO2tPDpMu7Jg2X3J7mslNLuw3ZzD622hWd341tbd8P761jr0uDeXuFk2andNB
         XxkoUC52QXsEs1PrOo+E/qCDsXaE0CLIaNoiF4yWW+P/H9lMTcTL0Wl7jm4LR0ude+K3
         DLzvfRSZd4dJHPCWyNNtYowHPFDlVKK7NRHVL6KJzuPrOB/FFBZUo2XVmuT2QygFmdbE
         ciVSlv5Z4IhF3/2Ek5+ObRJqNzAwNy/Waz3fmRXjtRau9ZST970f32ncgqnZYXwRU7YV
         M4lyR+kmkRRq0o4k8OGsOg3RTBTLsooBUrV3lT4gYkk3mE6FBgn7VBl77b0gJWDXihvx
         JEtA==
X-Gm-Message-State: AOJu0YxLOlZNcOhGV4jlcp/7IjJ1Tw2v+I5PwkMHWbe5Nfnmq7/51Tq6
	C0jYjGHaA7RcxqCJ/G2q16muVN96XrL4Vw==
X-Google-Smtp-Source: AGHT+IE+IgC4wLkE6RYjtDFB0pWTDIUdON92Vz+dAWf4DHJtTe+XgSKKAQO0wl9qYVa0qqRnvxdpHg==
X-Received: by 2002:a17:906:44:b0:a27:4f33:96ef with SMTP id 4-20020a170906004400b00a274f3396efmr205330ejg.7.1704365608612;
        Thu, 04 Jan 2024 02:53:28 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id fp17-20020a1709069e1100b00a26b36311ecsm12644649ejc.146.2024.01.04.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 02:53:28 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-6-wedsonaf@gmail.com> <87sf3e5v55.fsf@metaspace.dk>
 <20240104052034.GD3964019@frogsfrogsfrogs>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Date: Thu, 04 Jan 2024 10:57:45 +0100
In-reply-to: <20240104052034.GD3964019@frogsfrogsfrogs>
Message-ID: <87ttnt4bfv.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


"Darrick J. Wong" <djwong@kernel.org> writes:

[...]

>> > +    /// Returns the super-block that owns the inode.
>> > +    pub fn super_block(&self) -> &SuperBlock<T> {
>> > +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
>> > +        // shared reference (&self) to it.
>> > +        unsafe { &*(*self.0.get()).i_sb.cast() }
>> > +    }
>> 
>> I think the safety comment should talk about the pointee rather than the
>> pointer? "The pointee of `i_sb` is immutable, and ..."
>
> inode::i_sb (the pointer) shouldn't be reassigned to a different
> superblock during the lifetime of the inode; but the superblock object
> itself (the pointee) is very much mutable.

Ah, I thought the comment was about why it is sound to create
`&SuperBlock`, but it is referring to why it is sound to read `i_sb`.
Perhaps the comment should state this? Perhaps it is also worth
mentioning why it is OK to construct a shared reference from this
pointer?

Best regards
Andreas

