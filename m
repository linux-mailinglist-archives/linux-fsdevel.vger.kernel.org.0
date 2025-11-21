Return-Path: <linux-fsdevel+bounces-69393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78DC7B1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4494F4E694C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF62E34E75E;
	Fri, 21 Nov 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrlIEZxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4729BDB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747008; cv=none; b=bZkYHIgFlaDRwiVA3P3YaIBN0NmccbSflQSE8cBiWkCfP8723Axhn+839I/v05ufPPapML5hArBqeRM0s3a895qGTrLfOwvh2oCf151F4w7nXz+vQroFQYpTc+M2PvwSZVUZL1PPVyutdlSUidp1y6BuQMrNYtlpL7JtxbmimcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747008; c=relaxed/simple;
	bh=y62j1qyv7cgXLbtLXC53Pk0kooT7stT3fh5DjyrzJJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akAGdyiI1ks7QTk27/VA7ZHrsKIHYl6jTmvaIE41I6fe+EbVmIPdTJFKtEfW5EqC4QO7Bpbmvgl7CuELwnxttV5yXrHC+kk+qXlcL9la8WQHa1x23CEDdRwrmbOYUXMiH3ncqi45Q6js+xTODmY8PAaUmoqm5QBYnduX8suw0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrlIEZxL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so16299905e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763747005; x=1764351805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DymXmqpOIrcn6HBsb6WiDUl4fGGkTlxCMuKU3m5KUbc=;
        b=ZrlIEZxL2Izo24hLTe+h5TWXYnatSLxVAzBWsxwCcmxdwk+x0eXXxGWJ7pfNgAZCEM
         NTN78O6KsRamILfzFnYmr4fqbe+dxGmJcUQuEaedGAaFgE1gH4MTzOO+JirDZOVqxxqn
         guduqzh3dghy9poZpBlNAPelGvktOntIpyO98aXQBT1Nm64vN2s6RngwKElM6fjBuOFL
         Hh4NYPcdBuX8j5HmQ4YB5IQBoENnt7pc062HrsqXGjAOWz6RqcMjjYtb622guV+kgOqN
         nWCZaETtrl/naXpTnlJR/LOe53uOJbgczQmKXbc4u5vIXWagafmzxpNfR/kcPbbG0vE5
         Jx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747005; x=1764351805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DymXmqpOIrcn6HBsb6WiDUl4fGGkTlxCMuKU3m5KUbc=;
        b=lrdIDMxme88na5Y7U5kYLVFY4BjdMWLduSwDrEn+Kteb2/NtZ8pZnCkmTGiT4T62GK
         L9c9f4lbO23DE9LDKYoiv51QoeFC0g8xiT0rWAMw+3ubxn1CR+Vbm01F4Q/4Y3/tlwqy
         hUYu1SaZ8wvczkF3Sb13s0sbv7cHlf7f423m9Wi7+Kn9wo3IWESBJTJRZPcl3+JkSS14
         Yf+p73MSNgd79qWCmWVEOGzzXRNLdVythmh9ki8b0iDiCW70+IMYGgAB0uqxtweScRxO
         VCE94LuyAv2XHggy+A8tBteG5ovpCc+Qzxek2qptMdhZEOH/eDuS2m3pSVRP5lO+OXr6
         7g3A==
X-Forwarded-Encrypted: i=1; AJvYcCWN7VU06Mmf+cDYOkUZ/yO4xNGT+U/4+rVTLlxm3HsnVQudqG9K8HnHM4I99v9RJvR3zcHD+iEq9wG6Vu4+@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6bC2bLRR6gQwfs2HpMjagPntz08rvNQz8jni0vn6TqCGIkx5
	73LTudJOSK8NcFNPyujwoIczeXI5hyWmu5lP78e2hhFIhU5cY2HN2NEWKtQ0cNhEYDo=
X-Gm-Gg: ASbGncv58mjCDjzGWrwdqb+4Ew5RNcQEZHUTS6fSGoGXhEuD7gO9FoxPSioelickiUa
	83sAk3PkPRiBjJjKwnphmtN+hOdYuxYx7x8J0t5US7+WIMoI5LjBDF/6e1IMzZSuXIABIi35ErD
	rP2x1onjr76R4QPaup99BTeC2rOy4h/Vpn1WhdPRp/oU9GgMVJRsi2tgZkrmifUv6XNGXbhSOS0
	D7bWRiLG7P9bIUNIHomagbcMnGT6TvnHVi4xYqo5EgCu8sDKgmP3PeIHy2En9KP2gX7wwjHUMwA
	q1r26Hdovi00t9l7gFd9npfrzOdlGBstwymO86M+rrws8ccuKTUtw3O0sTLonP0hHdevpp2tjFc
	YK91dqTP/fTOU4lwmIkFugfz2C9+YOZh9qkavopnlWWT5p4axhG0J9N96TbsBUD+rsYDJJE4h32
	EEInG/BNspq94eiSNw
X-Google-Smtp-Source: AGHT+IGFQsvgqlLXjo1LFzfHENKzKFKxBi/jQaStpJz5QhBM3ftqg50gqcC3p5JGniMbhRFFXcSeNQ==
X-Received: by 2002:a05:600c:3b01:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-477c04c357dmr30706095e9.1.1763747004919;
        Fri, 21 Nov 2025 09:43:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf22dfc1sm55987425e9.12.2025.11.21.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:43:24 -0800 (PST)
Date: Fri, 21 Nov 2025 20:43:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] fuse: Uninitialized variable in fuse_epoch_work()
Message-ID: <aSCkt-DZR7A8U1y7@stanley.mountain>
References: <aSBqUPeT2JCLDsGk@stanley.mountain>
 <873467mqz7.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873467mqz7.fsf@wotan.olymp>

On Fri, Nov 21, 2025 at 01:53:48PM +0000, Luis Henriques wrote:
> On Fri, Nov 21 2025, Dan Carpenter wrote:
> 
> > The "fm" pointer is either valid or uninitialized so checking for NULL
> > doesn't work.  Check the "inode" pointer instead.
> 
> Hmm?  Why do you say 'fm' isn't initialised?  That's what fuse_ilookup()
> is doing, isn't it?
> 

I just checked again on linux-next.  fuse_ilookup() only initializes
*fm on the success path.  It's either uninitialized or valid.

regards,
dan carpenter


