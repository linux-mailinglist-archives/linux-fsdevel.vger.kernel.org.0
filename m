Return-Path: <linux-fsdevel+bounces-1244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD57D83CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F661281966
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72732E3F8;
	Thu, 26 Oct 2023 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CLtLsYeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F32DF96
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 13:46:18 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3CBD
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 06:46:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cacf449c1aso1714655ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698327975; x=1698932775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLROATgpKb1FdM8rjE+HHDUlfm1XkTpgg5ggK+Xv01Q=;
        b=CLtLsYeMfZG03uklq+VJVXP3GBvAnpY+JyNHYgiNZ6U+ftmeoWGnaoRYBeCYU5ENfe
         NwcL91bCNJ1FHp3DkDEKukt0SU1ovLJFjo2XbEhEF6X/h4sqq/EhzI9YFfLHghOX9JN8
         BXTY+/goPjuyO+otIhFHTauy62YtOWzHqRIgyOqLDJqT+6CqZyMnPeJgkhyxZFwjWN4C
         m5TEy5XVDBuDG4NOacyE7LRz+YARSNZE1De30ENCybdui92aI9gHnO4lz5JWIACTLy4M
         MLSpigZ3JLSJ9/PpRHttDOkDqLqIFmVED7I5Ut6TNpnHLkbH/rk+hScAOJFpDIEkhoIw
         1R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327975; x=1698932775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLROATgpKb1FdM8rjE+HHDUlfm1XkTpgg5ggK+Xv01Q=;
        b=dENdL56ko3M/yHBkMwGu7220fOiCnkfCmGG7q76MsQb/KbSimCDedwnNjw3rCAna+Z
         yAvx/G5AHUdV15HUEcMfdFrPP45PUrbgfuhwrdWonv0Gg7N57t7kSJWy8ZvO39ncWbF7
         NeW4NsrLdtsq+g2gWvCpo0g6GS4ks0t9m0eEGX5kPg/An1e7jSAxXf9/kkIt118QL6Tk
         VxIMC3dZxqaFe9Sh1jeyrVodrcNIf40UMREg3h+/3Yu3yyoIEWChI7NiRQOdbz5VUKhm
         Fexo5H1Ov17M18XDY86TILeH2T32/PjjhqkeBsYvMWTzalbgwfJaGUoizUZ8RswuWwog
         Kfrw==
X-Gm-Message-State: AOJu0YxAH6gjM97ewizctI67Qha+V19DZpCwlVdWIG+XDJqdqIZooQXj
	qKdUVdoAnNMs1QQfW4qRr7uKSq8x+7av+knpN6YYuA==
X-Google-Smtp-Source: AGHT+IFWzBvGrW5B/2sdLf9vkw0D6gKzUHKXqD0bI/aiz0Zh25ULOmpqmQ0IJnvcWmJaq7DiiTjZxg==
X-Received: by 2002:a17:902:e214:b0:1c6:2b3d:d918 with SMTP id u20-20020a170902e21400b001c62b3dd918mr18304965plb.3.1698327975368;
        Thu, 26 Oct 2023 06:46:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902db0b00b001bf11cf2e21sm10956847plx.210.2023.10.26.06.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:46:14 -0700 (PDT)
Message-ID: <d3125a1f-aedd-4443-b498-a2b0208231d5@kernel.dk>
Date: Thu, 26 Oct 2023 07:46:13 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: kiocb_done() should *not* trust ->ki_pos if
 ->{read,write}_iter() failed
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
References: <20231026021840.GJ800259@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231026021840.GJ800259@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/23 8:18 PM, Al Viro wrote:
> [in viro/vfs.git#fixes at the moment]
> ->ki_pos value is unreliable in such cases.  For an obvious example,
> consider O_DSYNC write - we feed the data to page cache and start IO,
> then we make sure it's completed.  Update of ->ki_pos is dealt with
> by the first part; failure in the second ends up with negative value
> returned _and_ ->ki_pos left advanced as if sync had been successful.
> In the same situation write(2) does not advance the file position
> at all.

Looks good, thanks Al:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

or let me know if you want me to pick it up.

-- 
Jens Axboe



