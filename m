Return-Path: <linux-fsdevel+bounces-898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8247D2997
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2019F2814CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 05:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388AB538C;
	Mon, 23 Oct 2023 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Pa9+5evt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71B4C93
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 05:29:57 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64986D5D
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:29:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cab2c24ecdso15700395ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698038996; x=1698643796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pA6hmVfAJV/uW1mtP/POTKyiCL1mpB/iphXnZFNui5E=;
        b=Pa9+5evt2O9FS/RBhPIP3FmRBiViiOFNUZ3SVa2Z3gNh/daHLbVXdNlkkyV29B6o/l
         TmR1jRxEp3izSQV5jsXCem4tAC/TfHZKMAE0yFMFadZabG028XfOOWrfoJe2zwzVTGKb
         C9cpDrcEARRTMsFiL+PrPZz5eL6M4Vu1xgXG2iWLceZlIu4PJS9iyhQl9LueVDgu7yf/
         6oW0DzFK2aE4K+8lEvHKMFbG3PKPdlqb5MXvc1W4eFxl/RkkxyoflqiUhLlrhN/2oLJU
         vbHTVP+ob1KfwTUJK4O6Vnr1Omwlem6lV0UFlPjfpg3QCHHetkBH/8DyjR9h8UbkDQ5M
         b4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698038996; x=1698643796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA6hmVfAJV/uW1mtP/POTKyiCL1mpB/iphXnZFNui5E=;
        b=sp3h192Ph56SoWx4T7bsL/azuGEFWi2wiojqqzbhBYvwKYMFGQF+x3+Mn39WwGRogw
         jdG3/ebIl4uIAJJTy4qTIEAlpgT/YgxbMwNE+e1FOFNj5L2Rc4LYRvwcSqP8FzRE9vao
         yOFdkfpUfkuQJAirEkAG78W2VbK7ok7jfAuHQW83OYzgIW+KvRgHXZkQRPU3zEkbSWIJ
         85YkuAyPFAmOkKElibmeAte4u0UWJNEQ1JoxDoXX+54yEMKbWsCFnw+VD5tBn9TcrQMo
         Tfk6LD+K51dQfDJc52dZJzm7MMhbs/dZW+GLdpi5h0wH2iM8IGRIgwNVt0ycBosrvFXV
         B84A==
X-Gm-Message-State: AOJu0Yzb5cgdtlnpNU32HyzlyR3poOpp+FclaLZyFjH7wKzc6PyEMyrC
	kSDECyElrh0a2Rmot6fwSw0nHQ==
X-Google-Smtp-Source: AGHT+IGr1TX1aoeWNoXlEFhl/SEfwGB6Q5EzrGvo4R2SBtWrIE0uDaB8F16voX3bfOsUOQHFW9XR2g==
X-Received: by 2002:a17:902:ec84:b0:1c7:443d:7419 with SMTP id x4-20020a170902ec8400b001c7443d7419mr7057135plg.29.1698038995793;
        Sun, 22 Oct 2023 22:29:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902eed500b001bfd92ec592sm5185773plb.292.2023.10.22.22.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 22:29:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qunVg-002kOq-0Y;
	Mon, 23 Oct 2023 16:29:52 +1100
Date: Mon, 23 Oct 2023 16:29:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Benno Lossin <benno.lossin@proton.me>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZTYE0PSDwITrWMHv@dread.disaster.area>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux>
 <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>
 <ZTQDztmY0ivPcGO/@casper.infradead.org>
 <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home>

On Sat, Oct 21, 2023 at 12:33:57PM -0700, Boqun Feng wrote:
> On Sat, Oct 21, 2023 at 06:01:02PM +0100, Matthew Wilcox wrote:
> > I'm only an expert on the page cache, not the rest of the VFS.  So
> > what are the rules around modifying i_state for the VFS?
> 
> Agreed, same question here.

inode->i_state should only be modified under inode->i_lock.

And in most situations, you have to hold the inode->i_lock to read
state flags as well so that reads are serialised against
modifications which are typically non-atomic RMW operations.

There is, I think, one main exception to read side locking and this
is find_inode_rcu() which does an unlocked check for I_WILL_FREE |
I_FREEING. In this case, the inode->i_state updates in iput_final()
use WRITE_ONCE under the inode->i_lock to provide the necessary
semantics for the unlocked READ_ONCE() done under rcu_read_lock().

IOWs, if you follow the general rule that any inode->i_state access
(read or write) needs to hold inode->i_lock, you probably won't
screw up. 

-Dave.
-- 
Dave Chinner
david@fromorbit.com

