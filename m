Return-Path: <linux-fsdevel+bounces-7633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1787828AC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49EF1C23C02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4833B1AC;
	Tue,  9 Jan 2024 17:11:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91273B18E;
	Tue,  9 Jan 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso33516145e9.0;
        Tue, 09 Jan 2024 09:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820312; x=1705425112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74pgZ+nMyMyCi7Q0sf1ChPH+6TyfRgWiK4L8xKykjS8=;
        b=GnFrthI2RBRtog0nPtZWOBaNg9bje2KZUGLypvDGOwW2XFCk+uKLUmVE3fA71XyXN0
         l0iLSew9vf6HIHPtSalEz1IkoM3Hyenqu+EwtybxuVNg3UBOQ6ARIj8Jr+VDQXkj3Cwn
         8sSRnaXce04fDK6GtyW19LSPTslynGVOjjr2i+/fE7vPIbTZ3zRHjb6gMFN++99YJ5V8
         xj1TA1HLWE4Upb+YOIjouMTc9sOH/DdLGxJjIEz/Ho0soknB0AX/deNe7wRP8O3TgSOK
         DW7WnPUJF4+jEmXY9lMOu3t/CmAEotaBfwZ/nqZVatBSu4d68eOjT8La0VCYmUgGONFg
         GSdA==
X-Gm-Message-State: AOJu0YzC9c8vfY9J44hgHmCXmpqpev8kAtE5hreOROutPRj9gFhnDLLs
	RBluz/dIjaUAZYvEseTroVZvVqB2VqrEe9fB
X-Google-Smtp-Source: AGHT+IGIJos/i3ipnkFdLmYM2EEGbfIzf/lnl4N7OeDdNGtTp5964SxNKeNBrFk3MQ87L6RBTC7++g==
X-Received: by 2002:a05:600c:4ecc:b0:40e:4b1d:753 with SMTP id g12-20020a05600c4ecc00b0040e4b1d0753mr581661wmq.181.1704820311991;
        Tue, 09 Jan 2024 09:11:51 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id se12-20020a170906ce4c00b00a1d5c52d628sm1236183ejb.3.2024.01.09.09.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:11:51 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a294295dda3so364442366b.0;
        Tue, 09 Jan 2024 09:11:51 -0800 (PST)
X-Received: by 2002:a17:907:1c19:b0:a27:5397:74ed with SMTP id
 nc25-20020a1709071c1900b00a27539774edmr523050ejc.175.1704820311478; Tue, 09
 Jan 2024 09:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109112029.1572463-1-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 9 Jan 2024 13:11:39 -0400
X-Gmail-Original-Message-ID: <CAB9dFdt0haftd1LPo=_GmtcZvFR84w81eaARfUKW2KMSM5gxqg@mail.gmail.com>
Message-ID: <CAB9dFdt0haftd1LPo=_GmtcZvFR84w81eaARfUKW2KMSM5gxqg@mail.gmail.com>
Subject: Re: [PATCH 0/6] netfs, cachefiles: More additional patches
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:20=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Christian, Jeff, Gao,
>
> Here are some additional patches for my netfs-lib tree:
>
>  (1) Mark netfs_unbuffered_write_iter_locked() static as it's only used i=
n
>      the file in which it is defined.
>
>  (2) Display a counter for DIO writes in /proc/fs/netfs/stats.
>
>  (3) Fix the interaction between write-streaming (dirty data in
>      non-uptodate pages) and the culling of a cache file trying to write
>      that to the cache.
>
>  (4) Fix the loop that unmarks folios after writing to the cache.  The
>      xarray iterator only advances the index by 1, so if we unmarked a
>      multipage folio and that got split before we advance to the next
>      folio, we see a repeat of a fragment of the folio.
>
>  (5) Fix a mixup with signed/unsigned offsets when prepping for writing t=
o
>      the cache that leads to missing error detection.
>
>  (6) Fix a wrong ifdef hiding a wait.
>
> David
>
> The netfslib postings:
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.=
com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.=
com/ # v2
> Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.=
com/ # v3
> Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.c=
om/ # v4
> Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.=
com/ # v5
> Link: https://lore.kernel.org/r/20240103145935.384404-1-dhowells@redhat.c=
om/ # added patches
>
> David Howells (6):
>   netfs: Mark netfs_unbuffered_write_iter_locked() static
>   netfs: Count DIO writes
>   netfs: Fix interaction between write-streaming and cachefiles culling
>   netfs: Fix the loop that unmarks folios after writing to the cache
>   cachefiles: Fix signed/unsigned mixup
>   netfs: Fix wrong #ifdef hiding wait
>
>  fs/cachefiles/io.c            | 18 +++++++++---------
>  fs/netfs/buffered_write.c     | 27 ++++++++++++++++++++++-----
>  fs/netfs/direct_write.c       |  5 +++--
>  fs/netfs/fscache_stats.c      |  9 ++++++---
>  fs/netfs/internal.h           |  8 ++------
>  fs/netfs/io.c                 |  2 +-
>  fs/netfs/stats.c              | 13 +++++++++----
>  include/linux/fscache-cache.h |  3 +++
>  include/linux/netfs.h         |  1 +
>  9 files changed, 56 insertions(+), 30 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-cachefs@redhat.com" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-cachefs+unsubscribe@redhat.com.

This passes our kafs tests where a few of the issues fixed here had been se=
en.
I made the framework use 9p and no related issues were seen there either.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc

