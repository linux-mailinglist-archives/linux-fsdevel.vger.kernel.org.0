Return-Path: <linux-fsdevel+bounces-107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FC7C5B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C6282599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05C2231F;
	Wed, 11 Oct 2023 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6EXS732"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB439955
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 18:21:21 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166293;
	Wed, 11 Oct 2023 11:21:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so16814166b.1;
        Wed, 11 Oct 2023 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048478; x=1697653278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFAlnaB24n8Vccy/pdsjKZDoqB44FpUE4W7kqqRtmzU=;
        b=a6EXS732yZFGZvDVv4+G+aj4vxziXjJFdqY4Jt9IveD7LkPuAiXuQF7LMXg7/cGAWP
         LUO+hyJy/cwxaHI+rR5Du4So18AoGW6bIQXQcCrVeDjAbONM1/IwAqqoXKi9LMbAJz2S
         2mm3OGcF4oYPcgwZoaeV7+2OH0oLEp5VJgi1ltm4u7p3CyfDSy6dlHcbI3h9uzsMp5wm
         Ej9JttSIcGykCCUEhkwp7xnrg75Vt0eDToZjUkNgHYhTuZ+77qumTddyClcoCS4pWTo+
         gRAWLUfrRrybX5rafrSJ9CFcM8jPNVZvE/pIM6B+UXLOHBSMxn63uJ9FAOmaoiHIu1CB
         iKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048478; x=1697653278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFAlnaB24n8Vccy/pdsjKZDoqB44FpUE4W7kqqRtmzU=;
        b=ObKmMmCW619I4XRf2ct+DwRwAqRA6H1/sjihpXJZqRW4RyNucOQwpcWy13yzqPjPPH
         H+AUW7PAhU03snnzMlhLX+VF6bTwUUDqw16yB2sFweh23F2WfAD0Mj7S4zfwayvg+WUr
         SYF6Pkv5F9xyV7nstVzjJ4CxJOP8vYYAkAYPIERLNJDaifXOAcC/yqZw9BHlETKmKHFs
         KJDogtB1nFiAehCywgYbH+P58soPN1FtOQcOH7IU23mpsk1EanuD4+E1Mu2h1FZsRDCV
         WFBhL0gTaUAualz25oppvU5wK9MKrRl8vSgpRVnmSXL1dUZf9g2DoAqW/2Iw3x5QLeqU
         RxkQ==
X-Gm-Message-State: AOJu0Yw05rAw4CPcNXeZ+PHM8PYI1g4tneiunXhg++G0GuPrMgfKjtWo
	6jklao+vwTb6vjO3f1R/yw==
X-Google-Smtp-Source: AGHT+IFBUZ1FgTT/NjM3xlkh/VwwIDFRKcTZ+/cndVuG4iArdU/d8JTUJKgNAxqaaPpeuR5BuTIGtQ==
X-Received: by 2002:a17:906:1db2:b0:9ba:2b14:44fb with SMTP id u18-20020a1709061db200b009ba2b1444fbmr6862093ejh.47.1697048478367;
        Wed, 11 Oct 2023 11:21:18 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709064e9300b00988e953a586sm10044924eju.61.2023.10.11.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:21:17 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:21:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] *: mark stuff as __ro_after_init
Message-ID: <530824e8-3ee1-4919-ad59-1ff4c4ad9089@p183>
References: <4f6bb9c0-abba-4ee4-a7aa-89265e886817@p183>
 <20231011105211.3135013317249184bcc81982@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011105211.3135013317249184bcc81982@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:52:11AM -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2023 19:55:00 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > __read_mostly predates __ro_after_init. Many variables which are marked
> > __read_mostly should have been __ro_after_init from day 1.
> > 
> > Also, mark some stuff as "const" and "__init" while I'm at it.
> 
> I did this:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mark-stuff-as-__ro_after_init-fix
> Date: Wed Oct 11 10:46:42 AM PDT 2023
> 
> revert sysctl_nr_open_min, sysctl_nr_open_max changes due to arm warning

Oops, last minute changes as usual.

But it is for the best, I have better patch.

