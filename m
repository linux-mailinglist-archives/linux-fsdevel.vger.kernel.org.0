Return-Path: <linux-fsdevel+bounces-3910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDF7F9B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821B41C20935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48A5107BB;
	Mon, 27 Nov 2023 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2pZ6x9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB8D9;
	Sun, 26 Nov 2023 23:37:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2855b566683so2635280a91.1;
        Sun, 26 Nov 2023 23:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701070632; x=1701675432; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FUu1ozhNiu4LligkZTn+LqP7bN+oRsiEJ1o1KiSI+R8=;
        b=N2pZ6x9S99NQR+Xc/A4B8y25r5Z4jxCSALqetiAlymBBrbAfSYw/7PgaO+81Sw6zj3
         gDzy17EkdFXkCOGB9G5lH+ZJQhcQsKqI6OhdCOWAc3qKFVAR13lrkJaxvqCO+Aaveewn
         v7flDfjAkxqloap2B1736PeNagZduWNHAyTWIuKKohUupjZyX+4bbOvaE1rfKbmcEj0N
         5nwuy6RXXXiM94bz4BG3We1i+43TM2yLKw3jxShaflyKGsQP4uuFXZfGtk1tpsryBUIU
         R0SaGkHAyInslFiOWyYfO9PV8xUHH6nyIor0y35eFQnvuoMFg250nKKJfKsB7cocQ+Fp
         4yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701070632; x=1701675432;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUu1ozhNiu4LligkZTn+LqP7bN+oRsiEJ1o1KiSI+R8=;
        b=hl+uSG8PpigiQbsMOO+Nar3pPS+zSYBxdoRYicl/7EHtYYGwch8rEu64/ewmbXer37
         U1kHRQtJSkdJ3KQhLaaxaYJwpOIEU8JZKPw/cheSo0qtSfaDHoKbFjasElBzDOI38dH5
         g9qyuH5+yvl/h91P3FgkhAS6oxBLeaDXGNTcrelsOCiR2v9rv7DShzF6M/P6ewZVmbXs
         HyK7NvlFeLqhbjwgs6lpM0thjrfX7khQkk9EyvBEwFTrpydzLima6laOQKD6pE66bQLb
         onp2JVtXsx/AYkrB053GjCayZz0brsMG9vYK/uWnOBSKwe3rxKcwcxsoPYQZln1MFItw
         Si+A==
X-Gm-Message-State: AOJu0YxJ7ZrsFC1RPTXgPrECbb1VUglMuEHLNkBZikhXGF2H+dokiMwk
	oQC9XwrQgF/pbd2f8wZtRDDwQcp8Rqc=
X-Google-Smtp-Source: AGHT+IHsl9riyWM5MyCZZamVaodiOoSb+sGK0ZXI1/KKg0kr38BgB4XXn+daV/ROYTHt+iA+kuypmA==
X-Received: by 2002:a17:90a:43c3:b0:285:eb8:b6f5 with SMTP id r61-20020a17090a43c300b002850eb8b6f5mr18625852pjg.0.1701070613017;
        Sun, 26 Nov 2023 23:36:53 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id rs11-20020a17090b2b8b00b002802d9d4e96sm7104249pjb.54.2023.11.26.23.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 23:36:52 -0800 (PST)
Date: Mon, 27 Nov 2023 13:06:48 +0530
Message-Id: <87wmu3r6jz.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/13] iomap: move all remaining per-folio logic into xfs_writepage_map
In-Reply-To: <20231126124720.1249310-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Move the tracepoint and the iomap check from iomap_do_writepage into
> iomap_writepage_map.  This keeps all logic in one places, and leaves
> iomap_do_writepage just as the wrapper for the callback conventions of
> write_cache_pages, which will go away when that is convertd to an
                                                     ^^^ converted
> iterator.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)

Straight forward refactoring. The change looks good to me. Please feel
free to add - 

Reivewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

