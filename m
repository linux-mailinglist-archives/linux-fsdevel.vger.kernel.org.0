Return-Path: <linux-fsdevel+bounces-20487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A638D400D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E43228872D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7DC1C8FC7;
	Wed, 29 May 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rDT+dDr/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994F16937B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016970; cv=none; b=PehbiFzpcZXjZ/kPKP9SLTerwh0IRc7Ai+pf73p/wXeKGx2uqFzQZKmiZjVUXBbWK1AbuLPCnDjQFi8JR1NkQXfmfuGcyeilsNl90eAaYi/hwtVrzVyc6MmEDg49FB7+FJL/kKVLhilhjc+RMsSm9mNB6XFU1psZvtsQ97xSi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016970; c=relaxed/simple;
	bh=+g7pnhoqp9imQ85u2efPA5UpNgCf5e2YCm5QJNP0Qjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjfA7eKbVVLS5/oBxchNGtCLNV93Z1cQMmjTbTTPO3tdjFwT/TcXpGxeQDrhSkw9eAL4Z0EdnwDrjQPisBkBEe25xVVhc9y/91dHCM9qW8SFwJH9/nQEiBIaf9YcZ2CMjQi2mNP1DSC1bmj78PL8vJ/Dp9VLJLXA2ptDz8yIa30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rDT+dDr/; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ad7d743147so939536d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717016968; x=1717621768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OREcrVpZfXSItf7Gog4GNRWigmZXNALdZxAR5NkPqaQ=;
        b=rDT+dDr/XZDmLrPxDkpJG9nEMIinSYna9TunTR4b+C+FeVZfEfczZlGBTv1TZPlP2d
         faQk3UsmB/6I5hxgNHXg8N5sMSODJ1jAe34fC9R4tnipn/+7Lkfgj6RsIYBWCg7+Vw5N
         RktOKCa/ntghy6/4PCs1i1GlWLgh2gM6YLds2uiNzlgsrETftP+z9STyIUOSCTJM5Bh+
         E8sUdT7JYZs7UDKI5F13ktI4hd2nbsDqWmUEQGG4bGV+2cpwIoqqHkXh34vomqBYypY+
         7LwZsnmfkupFuNzCLj0pdtKuCxJ2w9QcPIRNvLBNGOXlwk0CYhehYQHTcK8FVvIVyxaB
         /PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717016968; x=1717621768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OREcrVpZfXSItf7Gog4GNRWigmZXNALdZxAR5NkPqaQ=;
        b=sn5iQ1X/17hsj1ua8BwMKBfa0uN36lNTi0B5YhogSV4rupCozw/XSz7ALb5h/wA1X7
         gA1E9YICIhawMoIPr4Q6ZLpmUpTvNfD9phiXJZVIMjh038hLB7WWIWAd+CgLZjbdxQ0Q
         5i2cwWnlNglfWU9BlAJ79jSkAwuU8N2WP12KK1/Ibo0fAlC+jKNINdLkq10MW1MsLxHc
         3p29Q/+jGaikoDYt/NQdarn4UyrwClhFqTybjufzlrQ4VO6wJGJZYocEj7KzF0GA2u8n
         Jokn3Ru0jxUMVhlaxn5WLS9a8TjsQXe1baRGUjfIuVr2Vr7GIdrrJOyl2qbfCFqqTjdo
         t8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWF6HHcBsD8G+F7qkgz5llghCvdO1hE5qtn26e754orioUp8NGa/lx5mQXscJhJ2WJPEmN4sckZeTLHAYaTjKUjuaLoQNmIldcetAqfeQ==
X-Gm-Message-State: AOJu0Yzy2hVRxxDpdoNt5CGBY/T7/ZMcccMJq+RsIUaXrJRcBnazeNX6
	P0RDjuv2u1FaAp6NoWUOtNKGTiNcjf7DkomUoXXumZHUx4eXD0SeVWIxugHl6mU=
X-Google-Smtp-Source: AGHT+IH6t1YRmTmlEUO9J2qzCyOqaw3TIWNR3q3wh6++2A+q5ysjfbVDcz+6Hm5CrEy44nB95Hz+Tg==
X-Received: by 2002:a05:6214:450b:b0:6ad:79d7:a1a4 with SMTP id 6a1803df08f44-6ae0cce2c8emr2486266d6.65.1717016967695;
        Wed, 29 May 2024 14:09:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad7850b408sm39251546d6.58.2024.05.29.14.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:09:27 -0700 (PDT)
Date: Wed, 29 May 2024 17:09:26 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 01/19] fuse: rename to fuse_dev_end_requests and
 make non-static
Message-ID: <20240529210926.GA2182086@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-1-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-1-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:36PM +0200, Bernd Schubert wrote:
> This function is needed by fuse_uring.c to clean ring queues,
> so make it non static. Especially in non-static mode the function
> name 'end_requests' should be prefixed with fuse_
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

