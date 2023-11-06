Return-Path: <linux-fsdevel+bounces-2157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374CA7E2BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EC81C20D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52602C874;
	Mon,  6 Nov 2023 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ccdgbUu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D72C86B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 18:15:44 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B3BDF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:15:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40806e4106dso29423465e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699294541; x=1699899341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lf3MJg4rdvAfKEuARU7S/KWx4iZciTo315WH3I2AEME=;
        b=ccdgbUu3YwsxnibtlQGaK7uyBsVq0iLDknYeaxe2IHcs+iruLaWRcS12GmvaGhuV45
         QVRz6RJxjfRZWxfiZ+U1CEX/UWOF7nyBNY9G4JLuu91ayWZJi4eOHJ3ACkmGit3M7no0
         a01vqHQnF6V9ImKFOnopAD/gZ82172cmW0SlOe46pxapzxA/a4EbJsP7j4cC/CWV/q0z
         Ft4cxJQbXuWOHZ3uuEj9TWsn1YMSn6BUGkv/Gvu8VRB3G/deLiYMgW2GmPWI8gt8Yj+3
         tOdE/tBOUemfXiKS15MGP5tNHd/kXI4AygwCno2XKI3znAB2P78xNUPcOG1xD2PTyClG
         inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294541; x=1699899341;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lf3MJg4rdvAfKEuARU7S/KWx4iZciTo315WH3I2AEME=;
        b=nqwogtZdDfGTEM/qISrDH7+0TrTBdCg9cISsJ9Zp/we4CMYkuBOU+suWroJpJa84wJ
         RcsDU4Rscq/DHCidwht+o91vcNADc84Qwaz/ldb2yoKpHuj5A63AOm1BlCpLE4ZOO1LP
         J+RhZqzbAAmxWhz69Salw8NkoaFFrNwbrOmVcD50Svqvazasg+jRHE+XpwI9vLSSspiT
         SjCoi+kJ4dwUKRkPB1fjo5s8AO2TlRe75PFajmZpjMWBTJvxdVWPac6uHkMBlA6JKHIc
         /X3CQzL/gU4RKWbeAw7592A49jvGwqoxQwuDNPxZcyyp6dymS0Ozi7iXcHxD94tA7v65
         4XtA==
X-Gm-Message-State: AOJu0Yzp7IUiRnHwaDXkgibK9h1S6CFG7ExQWFStZ6h+JxJqJ3ETyiX0
	fTFPXJQKoDnxZxvD55ZyXpLGXA==
X-Google-Smtp-Source: AGHT+IF3fXq7vHAvazsquZcnkPuD9l44U9V8qAOKm8OzrNTAFXUYFTEP0Ky4PYRkfC5cpWBiMweXEw==
X-Received: by 2002:a05:600c:45c6:b0:405:3924:3cad with SMTP id s6-20020a05600c45c600b0040539243cadmr361508wmo.15.1699294541471;
        Mon, 06 Nov 2023 10:15:41 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b5c7:0:cc4:fc61:ba1d:d46c? ([2a02:6b6a:b5c7:0:cc4:fc61:ba1d:d46c])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040651505684sm13125607wmn.29.2023.11.06.10.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:15:40 -0800 (PST)
Message-ID: <454dbfa1-2120-1e40-2582-d661203decca@bytedance.com>
Date: Mon, 6 Nov 2023 18:15:39 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Conditions for FOLL_LONGTERM mapping in fsdax
Content-Language: en-US
From: Usama Arif <usama.arif@bytedance.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 nvdimm@lists.linux.dev
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Fam Zheng <fam.zheng@bytedance.com>,
 "liangma@liangbit.com" <liangma@liangbit.com>
References: <172ab047-0dc7-1704-5f30-ec7cd3632e09@bytedance.com>
In-Reply-To: <172ab047-0dc7-1704-5f30-ec7cd3632e09@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We wanted to run a VM with a vfio device assigned to it and with its 
memory-backend-file residing in a persistent memory using fsdax (mounted 
as ext4). It doesnt currently work with the kernel as 
vfio_pin_pages_remote ends up requesting pages with FOLL_LONGTERM which 
is currently not supported. From reading the mailing list, what I 
understood was that this is to do with not having DMA supported on fsdax 
due to issues that come up during truncate/hole-punching. But it was 
solved with [1] by deferring fallocate(), truncate() on a dax mode file 
while any page/block in the file is under active DMA.

If I remove the check which fails the gup opertion with the below diff, 
the VM boots and the vfio device works without any issues. If I try to 
truncate the mem file in fsdax, I can see that the truncate command gets 
deferred (waits in ext4_break_layouts) and the vfio device keeps working 
and sending packets without any issues. Just wanted to check what is 
missing to allow FOLL_LONGTERM gup operations with fsdax? Is it just 
enough to remove the check? Thanks!


diff --git a/mm/gup.c b/mm/gup.c
index eb8d7baf9e4d..f77bb428cf9b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1055,9 +1055,6 @@ static int check_vma_flags(struct vm_area_struct 
*vma, unsigned long gup_flags)
         if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
                 return -EFAULT;

-       if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
-               return -EOPNOTSUPP;
-
         if (vma_is_secretmem(vma))
                 return -EFAULT;


[1] 
https://lore.kernel.org/all/152669371377.34337.10697370528066177062.stgit@dwillia2-desk3.amr.corp.intel.com/

Regards,
Usama

