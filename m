Return-Path: <linux-fsdevel+bounces-8008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015CB82E283
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27075283721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475FC1B5AC;
	Mon, 15 Jan 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FBARqVa2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3E1B5A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3608bd50cbeso37841495ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705357241; x=1705962041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1e97FCLCiaJtKaM8A2COfDOTaSxHrLETGTHNR2Gz2g0=;
        b=FBARqVa2JLsQfb+4AwwZFMXgfjypoFi68jtIRKd/0W/Z3dPaSL0JpVs2w6J3aV2yFB
         BCfD3GA9BdIDKwDELg3qFrVDvSmu5kei5R04NVpnKRlye5lc5pzQkauMgahGyzQu6b+2
         lu0u+KwsVzxNbZzcPRll1mXfpfNYlH6tktbMf8/UAbEiRjOCD9Uki5qZ+UDvpumujOhh
         wwZnO67WtxWhw/bn010ob/XrBn86idLzdV6eqVegPRZtQdA8KdtS28zsCLpCCSWUp/UN
         LbpPA5jEjfuueirhucY+Mz7Mui4uSQDvno0uEKxcp6kHwIVt9P2HUKbiJf+dQyck/5xn
         Hb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705357241; x=1705962041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e97FCLCiaJtKaM8A2COfDOTaSxHrLETGTHNR2Gz2g0=;
        b=I/x0Cvtu03rNWK/C3srhc20tnasD92IfPNEsSvII1iv0LszZVGqB0SLxFru3pdOFxA
         GjVwyBD7GJYsJQZ7+bNA7EdvEpDEagCbkSQpJjHSjUarMDXUzh0gYN4l3ve5tMZ+tVYZ
         1kxjYPeMcV8Wd8RTMZb1e2Fa2dUcOnBqBYg8K5Baz3p+aTgLp3fZaRBLj/vdk0fXMewW
         Fc+erGZF4jUlDBvAouhquQ7GD/elyT2hN/XSsc03TM0604BRpDl7LIEX2n1fZyKi895c
         z+5yx2rHlqrjFYp3tHg7BJzjHtfK84WeB31SgdbKXCVrHMgb1/f86AJsb7PDPRb01Fu4
         dcMg==
X-Gm-Message-State: AOJu0YzJ9Pnp+ChPbwSx058zgXhYDkle8EUQ/tmvKlfsbIBWodX2KDBw
	F4MhJiBB3aauIdy9IdQOxhgVNbPGPhb9cg==
X-Google-Smtp-Source: AGHT+IEakymELxTP8tP1+uJr4la+L3kGSc1S57KZxO+IjJWRQ7o3tOzQsgoBElifHzj0+fepJu8f5g==
X-Received: by 2002:a92:d981:0:b0:35f:f425:520b with SMTP id r1-20020a92d981000000b0035ff425520bmr5550056iln.42.1705357241458;
        Mon, 15 Jan 2024 14:20:41 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902e98300b001d5dbd68290sm548079plb.246.2024.01.15.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 14:20:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rPVJt-00AsOX-0I;
	Tue, 16 Jan 2024 09:20:37 +1100
Date: Tue, 16 Jan 2024 09:20:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] fs: Remove NTFS classic
Message-ID: <ZaWvtfFMftPXg92X@dread.disaster.area>
References: <20240115072025.2071931-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115072025.2071931-1-willy@infradead.org>

On Mon, Jan 15, 2024 at 07:20:25AM +0000, Matthew Wilcox (Oracle) wrote:
> The replacement, NTFS3, was merged over two years ago.  It is now time to
> remove the original from the tree as it is the last user of several APIs,
> and it is not worth changing.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>

I agree - this is largely untestable code and given the newer,
better featured functionality we have (ntfs3, ntfs3g), we should
just get rid of this old code.

Acked-by: Dave Chinner <david@fromorbit.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

