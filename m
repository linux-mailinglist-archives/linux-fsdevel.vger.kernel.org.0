Return-Path: <linux-fsdevel+bounces-4708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D2E80286C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3F1F20F75
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D61A70C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jLIBnru6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D366AA
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 13:16:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b837d974ecso2260186b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701638205; x=1702243005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TiYnbV92dcL2NhwuNv0UyBt5fqHKv8so2GwfrMVJoi0=;
        b=jLIBnru6Pyn/2Rus0nS4s5JaSHIL7K8f9CnwYEeWE8n3m9AnkSER6Qtlm2LSA28/UD
         UKgmGlYSdfoXJ/B9brFcSNzcD4OzlSoIPYUf7ZHknS8m1vJdRiOK4Z+NoNirnvpYTJlT
         Xrvi/xPeLgMVeOFbvmvyxb2P6T4uSx3NaJlpKBoKY9BbS8nCFm2PS2cYd0gSDrhTA99A
         TM223V4TapUCmsJbrTcYnI1iDbKkGPqY5r+LSi/Jgv4eiBH3cxobwHYSAG19fNqaERrM
         j0cdFDwiHOJmoWA6fbgXjll5HLrZ1NYGkrqbh8H5/BOo8SxVkinoW8hYaNv7RM7Mn+G9
         WcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701638205; x=1702243005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiYnbV92dcL2NhwuNv0UyBt5fqHKv8so2GwfrMVJoi0=;
        b=t/DUdYlAKwNKwUS/Ghl3n/agVFlv3JtSfqopXx/5fu8QpLZn4/mkgPmgScPbNzyEEQ
         GbRB8JJqmtOEqghKdJNSgFD9YWqwdZcyoaLPOsRBtpasTRcFSX1c4iwPh+OrtU2BCdBn
         OCSTMEQyHdNOS/RFQrwSwPz+CcJmV1Can41oi4Umha/neTpRR6rxjbf+8KHMIcS0owT/
         LgAx5bQqhxx0qGLu4TpabHhmCdXBjTdunOtFSGFyVAiLDEtO+8F2d++yswhyrLfaEGAF
         EXDKJurhYApIUdjKH5Iu+OBOO1M+rPIiT2npNiXe2op4waAPLSAevOVyG0VCs2PKiJHG
         IA4A==
X-Gm-Message-State: AOJu0Yz9+hTaPYA/C4powslSqf7D72JtlTlLKdm3xcdqbLCdaU+l/LWc
	WNRyvtQcgIt40bphBUma2g6pQQ==
X-Google-Smtp-Source: AGHT+IFtxUZLmQjnDfRKH38ADEvsUZEuL5msm2HbCatf+v/ld/RAf9F1jYcnlKRqHluBxjU5Am/rMw==
X-Received: by 2002:a05:6359:a2f:b0:170:17eb:9c5d with SMTP id el47-20020a0563590a2f00b0017017eb9c5dmr2570446rwb.62.1701638205314;
        Sun, 03 Dec 2023 13:16:45 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b002867adefbd4sm2413980pjo.48.2023.12.03.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 13:16:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r9tpS-003Rt1-0w;
	Mon, 04 Dec 2023 08:16:42 +1100
Date: Mon, 4 Dec 2023 08:16:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
Message-ID: <ZWzwOmFoGPrtKb8v@dread.disaster.area>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>

On Sun, Dec 03, 2023 at 11:11:14PM +0300, Viacheslav Dubeyko wrote:
> Hi Matthew,
> 
> I believe we have issue in __filemap_get_folio() logic for the case of 8K folio size (order is equal to 1).
> 
> Let’s imagine we have such code and folio is not created yet for index == 0:
> 
> fgf_t fgp_flags = FGP_WRITEBEGIN;
> 
> mapping_set_large_folios(mapping);
> fgp_flags |= fgf_set_order(8192);
> 
> folio = __filemap_get_folio(mapping, 0, fgf_flags, mapping_gfp_mask(mapping));
> 
> As a result, we received folio with size 4K but not 8K as it was expected:

Getting a 4kB folio back in this case is expected behaviour.

> So, why do we correct the order to zero always if order is equal to one?
> It sounds for me like incorrect logic. Even if we consider the troubles
> with memory allocation, then we will try allocate, for example, 16K, exclude 8K,
> and, finally, will try to allocate 4K. This logic puzzles me anyway.
> Do I miss something here?

That a high-order folio requires 3 struct page headers to hold all
the internal state, and there are only two struct page headers
available for an 8kB folio.

Hence order-1 folios don't exist...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

