Return-Path: <linux-fsdevel+bounces-691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D97CE6B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9308B20FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C074735E;
	Wed, 18 Oct 2023 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki.org header.i=@mbuki-mvuki.org header.b="lqf2kHeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B347359
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:34:26 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558B11A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:34:24 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a66aa8ebb7so50255039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki.org; s=google; t=1697654064; x=1698258864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJoYW4hKJUW9mcGOvQ3ugfJthKPcw6V99IOrFYVDWkQ=;
        b=lqf2kHeEZmfN9XtIT+mCix9YncxFIl4n+szeWmNiAE5V1uQSfTlKraMA4LLX9bI0Z3
         rVRdSnLYZB/lka7mJZ4ymBCtdpzN3CwvrcwfMoiEKQRVj4HX0o3ty7ieqhyFfRX7YyEH
         Q1LHK5w+ICvE/KlAejnBMIzmBlWlVr2N7lXVZ3WybCTH/VziT00fwmN4KcQjRa1NoLTv
         4b9kGE02si+mKtNpAraGwy10423DYUl8YHTkGoQuMYhSgcbfxWH+/TtbAh5WLLCwrjhj
         PMRf8bjD06a/Kh8WawXfEPeIzs5pZLm9zQfBQ3WxjM425m0+2VdlqK5A5tEmzoS66OIU
         KcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654064; x=1698258864;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJoYW4hKJUW9mcGOvQ3ugfJthKPcw6V99IOrFYVDWkQ=;
        b=RsrEywhsVW2SoOAja8awu7HMIwnWh8+Adqz7YHb0VwC4tEPXDbWrnelwcYOC6w68WW
         h6unAzgqRk/eZUlcbB17mKYLaEu122X/2Ne5PpZkZC91e6Tb5AQKXaO+c0HMFOAnJFgQ
         aTu5dP8qEwyCCuteT3hplJXPAk5HOcs3jJPRrqM4qDo4MZyHAzWKDc5mFYSHr+oA1+Nx
         Tu4J5HsEQ+1HI9lXV8Kto5MhW2ItwSzWWMlrdcb+lcColRcBex8zd84KBUcYfrvR9epn
         4L1rfss6o4idsv5xtIUKFyhudofNePgXwduv9Rf5+i9cAcEFd+5yiqOaYVvOYEugI48w
         iWhQ==
X-Gm-Message-State: AOJu0Yxu8XJTGTxsU1IPWWtDGck1JOBx5y2SPYtxXPqLfGVkf/+NaHFd
	2VjzO/DXnBi+ke4W9jR8qWXSem+OdZ9Pto9A/yahHA==
X-Google-Smtp-Source: AGHT+IFQNLRtRcdZaRmbO8RcVjQWB8tXHQQq0ES98+OyNoSBoO0sehgwYycrjtvWxtjGGFg5Yae0Y2Ffj84pLbaZzbM=
X-Received: by 2002:a5d:9d98:0:b0:794:eaef:f43e with SMTP id
 ay24-20020a5d9d98000000b00794eaeff43emr148212iob.1.1697654064247; Wed, 18 Oct
 2023 11:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Hathaway <jesse@mbuki-mvuki.org>
Date: Wed, 18 Oct 2023 13:34:13 -0500
Message-ID: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
Subject: Re: [PATCH] attr: block mode changes of symlinks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Florian Weimer <fweimer@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> If this holds up without regressions than all LTSes. That's what Amir
> and Leah did for some other work. I can add that to the comment for
> clarity.

Unfortunately, this has not held up in LTSes without causing
regressions, specifically in crun:

Crun issue and patch
 1. https://github.com/containers/crun/issues/1308
 2. https://github.com/containers/crun/pull/1309

Debian bug report
 1. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1053821

I think it should be reverted in LTSes and possibly in upstream.

Yours kindly, Jesse Hathaway

P.S. apologies for not having the correct threading headers. I am not on
the list.

