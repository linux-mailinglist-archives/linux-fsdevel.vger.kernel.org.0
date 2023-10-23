Return-Path: <linux-fsdevel+bounces-923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0E7D3741
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF522815BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F618E1A;
	Mon, 23 Oct 2023 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1ZZjpkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192A15E83;
	Mon, 23 Oct 2023 12:55:21 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F77A4;
	Mon, 23 Oct 2023 05:55:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso3099002276.1;
        Mon, 23 Oct 2023 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698065720; x=1698670520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GEmnLY/y4cnT/cNmjbWbHgeKn48HWvMLTB6wSvznDU=;
        b=c1ZZjpkQdikEDE8GRFFuTltsSnuXa3CSt8lHD/ZH38sOcbopsSeo/R3Uw/yI+PRlTN
         4k8x5ZTtVirmqqFNTRqVMAmBw/x8e4SWDY5m+yUpkZ9RyF7DqtOwsjrv5pe2HIUu8ZSf
         PdD4FcMBB0B9Hz2ER2tpNunp+GXFrt/HefzXsN4Kh+2FWgoacRiW4HPTOAy1pY5ti5KD
         7/SmGq5eeFOZ5XsxKuljPWG5zluU7/RLPFNvrTv5QTtXVl8paHvgZ42VJqZcOPBPr8/M
         zNFaT5yaJlJi5gwCH1nzimVYIMjp7zEbY08i1WwhsULzG9K0BLLqOK+TDINWnCneFbM3
         KGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065720; x=1698670520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GEmnLY/y4cnT/cNmjbWbHgeKn48HWvMLTB6wSvznDU=;
        b=bUXaQ5Q8sJyMBF8ctMhwz3VtxMz4/RtDNHGDPETGg3kr+dqyC7aDfnZxscBscbr0ZK
         k01lSXrLx8LnXRWY8llHtlWToeVRLG/jGGQbn86blBzLCgtxtYOQ5Gw1xYIL+y256Mfe
         loMEmdEAmZmdvXucYdgjIvrYNQxiIjwMIZD1zo+QCBtUC00Kdm/G2MLi5y9yU1w3e83V
         Dwc9tJl82FwbG5hnSAVNniiMct6AmUuD6K66i1RtBLySqzHyYdJi6Ug8TIMaXeRM+zWy
         F8rHhHbQB2M+E1Lcscq223oSk0Qk0hEcn/cPPfGl3zwoXXjkRsiYjhUWUxLSSjK8ide/
         odVw==
X-Gm-Message-State: AOJu0YyKnIh69WHssw5SpT1eiHK4ER0R/sYhnIxfx3pomnAOkRhyetI5
	+S2cg3yz2u57eXHE4tsldBRqbjJybev7Z1bJdyvIAlGqAAM=
X-Google-Smtp-Source: AGHT+IGypnu4eR6g0KW78S6tOCPmJM0twixOTu0jtgKNq5sPrZ7+f4Nnwxi7M/fFF91Mgf8QJ1yO9A2U2pNLvorPixs=
X-Received: by 2002:a25:cc0c:0:b0:d9a:d20d:7d5b with SMTP id
 l12-20020a25cc0c000000b00d9ad20d7d5bmr9776221ybf.19.1698065719747; Mon, 23
 Oct 2023 05:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux> <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home> <ZTQDztmY0ivPcGO/@casper.infradead.org>
 <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home> <ZTYE0PSDwITrWMHv@dread.disaster.area>
In-Reply-To: <ZTYE0PSDwITrWMHv@dread.disaster.area>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 23 Oct 2023 09:55:08 -0300
Message-ID: <CANeycqq49Ubj-3BKcUaMOKeEwFastZzC17z_uk_VE3RDDv2wfw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
To: Dave Chinner <david@fromorbit.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Benno Lossin <benno.lossin@proton.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Oct 2023 at 02:29, Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Oct 21, 2023 at 12:33:57PM -0700, Boqun Feng wrote:
> > On Sat, Oct 21, 2023 at 06:01:02PM +0100, Matthew Wilcox wrote:
> > > I'm only an expert on the page cache, not the rest of the VFS.  So
> > > what are the rules around modifying i_state for the VFS?
> >
> > Agreed, same question here.
>
> inode->i_state should only be modified under inode->i_lock.
>
> And in most situations, you have to hold the inode->i_lock to read
> state flags as well so that reads are serialised against
> modifications which are typically non-atomic RMW operations.
>
> There is, I think, one main exception to read side locking and this
> is find_inode_rcu() which does an unlocked check for I_WILL_FREE |
> I_FREEING. In this case, the inode->i_state updates in iput_final()
> use WRITE_ONCE under the inode->i_lock to provide the necessary
> semantics for the unlocked READ_ONCE() done under rcu_read_lock().
>
> IOWs, if you follow the general rule that any inode->i_state access
> (read or write) needs to hold inode->i_lock, you probably won't
> screw up.

I don't see filesystems doing this though. In particular, see
iget_locked() -- if a new inode is returned, then it is locked, but if
a cached one is found, it's not locked.

So we're in this situation where a returned inode may or may not be
locked. And the way to determine if it's locked or not is to read
i_state.

Here are examples of kernfs, ext2, ext4 and squashfs doing it:
https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/kernfs/inode.c#L252
https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/ext2/inode.c#L1392
https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/ext4/inode.c#L4707
https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/squashfs/inode.c#L82

They all call iget_locked(), and if I_NEW is set, they initialise the
inode and unlock it with unlock_new_inode(); otherwise they just
return the unlocked inode.

