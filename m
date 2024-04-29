Return-Path: <linux-fsdevel+bounces-18136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C202E8B6031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3371C21545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8118665A;
	Mon, 29 Apr 2024 17:34:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512618627D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412072; cv=none; b=ARFdupo7PP+CjOPlKZzJnr49ZnKUR6k9+JVADSxHOlmjfnpw/qcGq4gsgfsYo8x7bqJKnuCK3lS7cW8LH6tL1EUACq6kF/6C5vhcOvKQf47wd9uPsls8EVdfC9undcXbtY4FrqoRlS9q5beTKzp+ZXRjDd4uL0PHzniBX/qJLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412072; c=relaxed/simple;
	bh=EkPSKv49pNPDE1MKv1JG6ShiA98XxcQawgYaYEZAfgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5P2Gq/qPnHJPUWW94X5sZ/HGZwR64HOmheZHnbcneUhUA6eyBUld26kZHbafy/Rz+TPZYsiIgqjNfVTpV5ClBDSMUKQrpjHUTH67+W62SO35szwQ33IdpyAX3BKtZA4nvE7e+JOHsxK9JWxbN7xh2HbkeDpe82XoDcFH1VA1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so7424376a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 10:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412068; x=1715016868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Mnhr84frKfp8Q+ozh89M+AylhkV35gyu23vGYZQ+g=;
        b=T3Xz4PbsfQkwf9eFWkyabkT05sodZY9zjciXqS3XN/0LPOdgUMeJcyogGuNTOxFuhB
         4DjgA7W4I1EpAUk5HSAHPw/RN3YB1q13aSH7Em09Prs8zGhTg4+mtK1aDAmW6qr9EW+X
         v6DHxsPIKZd5u8TTJeF4gKhQAj6UlqItEtHVKnutbztuXxRYS9wLFmXGUsw9r6cpVySb
         buP+fabk9yDaoXJLg03Kqddka/lbC5XlAezCL2CNbjpGLcwNKAA/LRYELK2daYdvOiKk
         fx4R9Ujj9qM7v+CRdUi9POVxrRb53fCI5nlm/K4w5tUFGIjNcWnHH5DYhvi7Fw2hZ13V
         EmpQ==
X-Gm-Message-State: AOJu0Yxqzf6Ah7U8eRL9t1n/sAgB/rlkQFwzfqa6UDxfPsoVITRR0/0t
	nX3qVC2wBLUAuN8US2pgvIqwAXW5wkVx3kPTPyf8xb05Vl941GqbWfo5SQ==
X-Google-Smtp-Source: AGHT+IGoCqEbOyr0cmPSwdggv7OjSvZCv8a+72JUjJucmZst77qo55d04CLuI7VnClEPV6UXIuLBfw==
X-Received: by 2002:a50:c34d:0:b0:572:4e6b:958 with SMTP id q13-20020a50c34d000000b005724e6b0958mr9679963edb.2.1714412068362;
        Mon, 29 Apr 2024 10:34:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id cs14-20020a0564020c4e00b005723e8610d2sm5095817edb.77.2024.04.29.10.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:34:27 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:34:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: KCSAN in fuse (fuse_request_end <-> fuse_request_end)
Message-ID: <Zi/aIkYRU5N03xEC@gmail.com>
References: <ZivTjbq+bLypnkPc@gmail.com>
 <CAJfpeguNAEH88aKTSFbEdaa4neUbpXVkbr5-XiAkOEH6ZNUoHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguNAEH88aKTSFbEdaa4neUbpXVkbr5-XiAkOEH6ZNUoHQ@mail.gmail.com>

On Mon, Apr 29, 2024 at 04:18:56PM +0200, Miklos Szeredi wrote:
> On Fri, 26 Apr 2024 at 18:18, Breno Leitao <leitao@debian.org> wrote:
> 
> > fuse_request_end() reads and writes to ->num_background while holding
> > the bg_lock, but fuse_readahead() does not hold any lock before reading
> > ->num_background.  That is what KCSAN seems to be complaining about.
> >
> > Should we get ->bg_lock before reading ->num_background?
> 
> Probably not necessary.  Does wrapping that access in READ_ONCE() fix
> the complaint?

Yes, reading ->num_background using READ_ONCE() in the fuse_readahead()
path fix KCSAN complaint.

Should I sent it for review?

Thanks

