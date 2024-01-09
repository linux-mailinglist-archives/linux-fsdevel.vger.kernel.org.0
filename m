Return-Path: <linux-fsdevel+bounces-7670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C2828FD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 23:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B61A1F28E94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8C63FB01;
	Tue,  9 Jan 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wS/ghTx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809E3F8F1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3606c7a4cb5so26419575ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 14:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704838782; x=1705443582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlpQaJR/+hAPI/VS+xZdW9f3X8aLNp3sZ6CbQfs8wlY=;
        b=wS/ghTx0bI5CN+eXYHBkWAQwOYC2IEumXq4xx3NhzMS8fCwqMm6iEfnT3lpfbtHMh6
         VNiCwnrwbh4rCAB89uESj+mzBDFEoIcuCTAhnW81k+XwJRF4dNTruxY9OIwkmz+q4nV0
         16AjTT/VWw1l7vBCF8gmcF0KOeY+ZgvDk4V9K1LwRQJJn1HrZTPoP8KTybbXQvSMQCyS
         L7wTTala9xRHwRonCrK1u0yo4yLjByubi4jmLRV16uuampjjSbuZoMv90+EFX6uKFuKA
         eEhuKwsjvZQYNYi0Nk511l/xGnfoTzDcrSblKT/hUyDNIAvIG+r15VTjB2yDk4KD5kS4
         GUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704838782; x=1705443582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlpQaJR/+hAPI/VS+xZdW9f3X8aLNp3sZ6CbQfs8wlY=;
        b=IgOQuV8CYLjunnrxze1UFf0ysU3f8q4QaAq/RABs9AHZPbv2lpt1/qXspxdrvfd94d
         VhmkTT+N9FFGZKIE0JtAZHjI/5lcf9cAMZGtDbWgVjEfX02YC1j59WhdO/AzINd+6fb5
         x6XfLsMhwkAMquhnlPq8Z4v65KEFYr8aU75T713bTky7Kp0KAG+MvEsgfJGVeQVc9HxP
         B2frLGL0+imt0StgDQoaeeTIm9cNlB4vEXrNuJHChGEINuyhIX6pe8OCQG1ws6pKUrO8
         3DQlPToD0U3GX8S37cs04N6CAJDvznK3SEgrsHzZfVaY2DCComfZaEFMfDQsfCE0y/Ah
         8rtQ==
X-Gm-Message-State: AOJu0YxHhpVwwnxDSild9Rk1wbhox8zobMi11Ufhi9tB/w4NbJFWsyO3
	FF6NH1ovjbc92EwAceCHGfzcyi80UFNUag==
X-Google-Smtp-Source: AGHT+IG+b6oIkAtEz3NRqiiBJuxWb8ZC6b6qa3qfjTIDC5Kx4A2aWK3f8jzZ+7bKYgvyu8k3nOkwQw==
X-Received: by 2002:a92:c243:0:b0:35f:d89e:da44 with SMTP id k3-20020a92c243000000b0035fd89eda44mr109004ilo.78.1704838781752;
        Tue, 09 Jan 2024 14:19:41 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id x6-20020a63fe46000000b005ccf10e73b8sm2107862pgj.91.2024.01.09.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:19:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNKRd-008FbT-2W;
	Wed, 10 Jan 2024 09:19:37 +1100
Date: Wed, 10 Jan 2024 09:19:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZZ3GeehAw/78gZJk@dread.disaster.area>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV>
 <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
 <ZZ2dsiK77Se65wFY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2dsiK77Se65wFY@casper.infradead.org>

On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 09, 2024 at 04:13:15PM -0300, Wedson Almeida Filho wrote:
> > On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > No.  This "cleaner version on the Rust side" is nothing of that sort;
> > > this "readdir doesn't need any state that might be different for different
> > > file instances beyond the current position, because none of our examples
> > > have needed that so far" is a good example of the garbage we really do
> > > not need to deal with.
> > 
> > What you're calling garbage is what Greg KH asked us to do, namely,
> > not introduce anything for which there are no users. See a couple of
> > quotes below.
> > 
> > https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
> > The best feedback is "who will use these new interfaces?"  Without that,
> > it's really hard to review a patchset as it's difficult to see how the
> > bindings will be used, right?
> > 
> > https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
> > And I'd recommend that we not take any more bindings without real users,
> > as there seems to be just a collection of these and it's hard to
> > actually review them to see how they are used...
> 
> You've misunderstood Greg.  He's saying (effectively) "No fs bindings
> without a filesystem to use them".  And Al, myself and others are saying
> "Your filesystem interfaces are wrong because they're not usable for real
> filesystems".

And that's why I've been saying that the first Rust filesystem that
should be implemented is an ext2 clone. That's our "reference
filesystem" for people who want to learn how filesystems should be
implemented in Linux - it's relatively simple but fully featured and
uses much of the generic abstractions and infrastructure.

At minimum, we need a filesystem implementation that is fully
read-write, supports truncate and rename, and has a fully functional
userspace and test infrastructure so that we can actually verify
that the Rust code does what it says on the label. ext2 ticks all of
these boxes....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

