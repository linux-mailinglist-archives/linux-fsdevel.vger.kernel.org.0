Return-Path: <linux-fsdevel+bounces-1125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014AA7D5EEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 02:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBB0281BE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691423A4;
	Wed, 25 Oct 2023 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0XB9JBw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40680F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 00:02:05 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016ADA;
	Tue, 24 Oct 2023 17:02:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27db9fdec16so3887181a91.2;
        Tue, 24 Oct 2023 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698192123; x=1698796923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Q7n7eEoCIAK2rGAN6IyglN3NhntUutFp1NL35nDz+g=;
        b=m0XB9JBwT8uEhqUPfRW+sSbzbJ7Pocj9QnLs6iOLBfo7WDpDM+LRmh9LnIGe+dKhES
         PPvuI5QdDBNXJJR1hw3EMHoEIe6awV865f6nxNIxKmF54RV+uLAlkSTfDxEIGOiuKPwm
         8bzUJJSahyRoZoDsi45ZJY+U12T3sXXbDjCLq/xUaMr/edmw4wTgBpS/Vdpvy6lu2oQy
         x9Dt4Sw8dlW8K7/OOx9XLOO5mJ39RVOfcuEnl86IG4aO2vHCZGmIwBSAQM34fF+I3ooc
         LLzIR5WlukFmPzU9jQV/JZrWPaQer/YNB0lCuv0Q+ZPbuYBqIF6VcN6Advx399QW6n7R
         qPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698192123; x=1698796923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q7n7eEoCIAK2rGAN6IyglN3NhntUutFp1NL35nDz+g=;
        b=FKSDmqG4ItfTIBmZS1EHZqOxMAvYN9CK1l5xp2bofk4FIRLvKBkUEAbhGRi96/UWZ2
         cR17leQMrXX3F+U5F7NUbMML9ZxGIZODUTHeoj1RkyBSOSSu/KcueoLVuUmxRexGLGbV
         PviDH0XEkH3GSVGfYxVzNcJTEmQJi+DvBxt1nIZSFhagsvtmavNeBTikLn/GRgM9dslp
         XdLRDjaVXmuedpqugIugykE5yywKQceXQCKqZ5U/ypuQHM3XQDX7PIfVIDLVDfMaTpQV
         Figdh9mnxPv6pHGJ78WrSpDkmYTQoFyOn8Njnud9l02nGlrTDwP3VvQp75CrP7XOzKQO
         bJsA==
X-Gm-Message-State: AOJu0YzarhOvfKTy31X5HwJeO6mXO9fhBDcgijrd23fTlFL/YFIERymJ
	WyK95keY0uTMRgBYjTqFzdDUf/n6dQg=
X-Google-Smtp-Source: AGHT+IHqp0fgXno/O+LMjdsIA9+MhoOLdZSecl/wbg0PuSHBIWNGSfBx3I4yfchMij2mH/s+AytZgA==
X-Received: by 2002:a17:90a:df8f:b0:27d:237b:558b with SMTP id p15-20020a17090adf8f00b0027d237b558bmr11985553pjv.5.1698192123380;
        Tue, 24 Oct 2023 17:02:03 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b0027732eb24bbsm10501271pjd.4.2023.10.24.17.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 17:02:02 -0700 (PDT)
Message-ID: <04c51182-97b7-4a10-a6f7-195da19358be@gmail.com>
Date: Wed, 25 Oct 2023 07:01:56 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Memleaks in offset_ctx->xa (shmem)
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, vladbu@nvidia.com
References: <429b452c-2211-436a-9af7-21332f68db7d@gmail.com>
 <f21c7064-dac1-4667-96c6-0d85368300ca@leemhuis.info>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <f21c7064-dac1-4667-96c6-0d85368300ca@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2023 21:18, Linux regression tracking (Thorsten Leemhuis) wrote:
> Bagas, FWIW, before doing so you in the future might want to search lore
> for an abbreviated commit-id with a wildcard (e.g.
> https://lore.kernel.org/all/?q=6faddda6* ) and the bugzilla url (e.g.
> https://lore.kernel.org/all/?q=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D218039).
> Because then in this case you would have noticed that this was already
> discussed on the lists and Chuck asked to bring it to bugzilla for
> further tracking, so forwarding this likely was not worth it:
> https://lore.kernel.org/all/87ttqhq0i7.fsf@nvidia.com/
> 

Thanks for the tip reminder! I always forget it then...

-- 
An old man doll... just what I always wanted! - Clara


