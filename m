Return-Path: <linux-fsdevel+bounces-2156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4117E2BBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 19:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3041C20C93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942FE2C86F;
	Mon,  6 Nov 2023 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YvOSE9x7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81B156E1
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 18:13:32 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BCE94
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:13:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40838915cecso35324875e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 10:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699294409; x=1699899209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf3MJg4rdvAfKEuARU7S/KWx4iZciTo315WH3I2AEME=;
        b=YvOSE9x71oou4vR1Xq0Kwp9yKwVbzjBptM4YZKtk0aLG/1XsgfN6cTvYPk56Ivyzdo
         oRmcSuv0THMkgbd76+cqVKHZIppnDrdvPNZ7fazLJOd7JaauAbQ5d1ikujIk/Xr9kg5T
         FBaOF93q7vm9AOSrjBMergZ+RgvYkYjSXdaPYGJS3tXlCEgH8NG639oiil5wNXKL950c
         Z8f7WGXa3rtkS30zD49ohcR+VAMBPAKggpZ/Q/8sX5jc0uLhcnQDPN+RP8TNa+GiOMNT
         JUjTZVG1v4SzmL6PYVVqyhWtqB3v1Lz/PgMZ9ygpzlIqEBjKI4Fy+M2RWWmxCWIFehwQ
         eY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294409; x=1699899209;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lf3MJg4rdvAfKEuARU7S/KWx4iZciTo315WH3I2AEME=;
        b=Zi7tZaGNRJMCP1dvnDEar5M8oDqQrVgLgqghGwpzQSfRELWT2k2ifejxCg4SGFvHXa
         c+YCl7gT7tYZrJC02A+Jsk6NFCVqf8Lcj10M6s5wVdAxQ8vmeY0H/KPIb29MSVTkjaU9
         9jMklRJC3gCpmfUjBNgLHdsuCYSDbHybnQ93xCvT5rXXj++JwsaoYr6OS0zCepdJXeWl
         RVIPesZtYrhFKIznkNfgzoKxIR8LpsMpzrPU+QUtHMnW89MWc05bGelJTyg4fr86Jz5p
         2nlYLbz/gWA+255sSzG1DkSgoTafo7ELuTGsBp15EQoml9W5Y3mklzps42Btwj1SF5ZZ
         3CGw==
X-Gm-Message-State: AOJu0YzR+LDpQ05IWoP98m8xprPt65FJ4jTC5W58vgzW828djzWdyScC
	InvpXflEHlZyZGlQOKVmVHhufw==
X-Google-Smtp-Source: AGHT+IHhmc8NfcxQcDytAzPW3g7ZWI2zbrwLCIsWYH3ZTDXB3uiOIE8LIMAk6YkvN9ycu+MwJS7fFg==
X-Received: by 2002:a05:600c:4754:b0:409:6e0e:e970 with SMTP id w20-20020a05600c475400b004096e0ee970mr399666wmo.23.1699294409015;
        Mon, 06 Nov 2023 10:13:29 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b5c7:0:cc4:fc61:ba1d:d46c? ([2a02:6b6a:b5c7:0:cc4:fc61:ba1d:d46c])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b004083996dad8sm13075526wms.18.2023.11.06.10.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:13:28 -0800 (PST)
Message-ID: <172ab047-0dc7-1704-5f30-ec7cd3632e09@bytedance.com>
Date: Mon, 6 Nov 2023 18:13:27 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From: Usama Arif <usama.arif@bytedance.com>
Subject: Conditions for FOLL_LONGTERM mapping in fsdax
To: dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
 vishal.l.verma@intel.com, dave.jiang@intel.com
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Fam Zheng <fam.zheng@bytedance.com>,
 "liangma@liangbit.com" <liangma@liangbit.com>
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

