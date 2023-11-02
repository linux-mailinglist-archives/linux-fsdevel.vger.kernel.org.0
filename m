Return-Path: <linux-fsdevel+bounces-1804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8B7DEFB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1493281A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52213AC8;
	Thu,  2 Nov 2023 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POQjGVDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B5125B6;
	Thu,  2 Nov 2023 10:19:43 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C633133;
	Thu,  2 Nov 2023 03:19:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso118132366b.2;
        Thu, 02 Nov 2023 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698920380; x=1699525180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuZBj9+EEKQz0q3dUNT5o4x6WbUeH/U0PGQKyAEqkEc=;
        b=POQjGVDce8MjoOmq7BrKKNyeZjm32Z2HzLizBk+qciXNcPXbFhQ97/2USn6EBesqm4
         WrUqiHBnpWDtxUO2IwHKJ9TQ7Y49lxfDZu/PRc7UwRWBR73HsFn4TpKT4WHXOe90bauh
         mSmApu3iFBPtjNG+9fyZuHwIpiqalyGxLQ3EV5B1veW4zDSUQq8p7mn0/vQLbOsg0iFZ
         4OQga69bec5Upq8IzksHnfmXrl+bOjYIaWBFgpn6P1t2BsxV5g4v/ZDykyCVJbR+jy4t
         mru1log3fbF1qZDRxdhiH7e5aU1S7PiMBeqgLWIkRrwUPxt8mlfCQOJi6ssXJknXXDui
         qmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920380; x=1699525180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuZBj9+EEKQz0q3dUNT5o4x6WbUeH/U0PGQKyAEqkEc=;
        b=AxsIarOwF7r6yjaLEt5NGgn/ZfACYN70fXWAVR56c+tyl9x5iFV9kxlHMrEMP5PxSk
         FOfYj6B4I3UmHrKvxpSFhK+Hp0SBJIiQ8LkhtI2K1T22dDkd7+k9GRsmJ+mbYyHCZSgK
         GNb7vi+BGpENbPrQ67Bje9GqzKfQTTTk97nWmAkms6dvzGlHPEXuq2BKFWKRnfjswIy2
         rBuAFCy70W8V7CORxMedhnxW/fyKj4uCmfXtyxie+EyucR+eW20C7qSbanlWmqQuTflf
         98VjjIZgvBmnEmOlgNjzf/OO7799v2Jim0Gt80vfXp5knNlZVTNFHjLuCxsfmHkbCZM0
         rX6w==
X-Gm-Message-State: AOJu0YyiBjsvJJ8Nr1HHEA3foa9+V+hJJz5UaOj1m7lleJUZnkXsaGHM
	WKsP2h3AZb7OncQ+iy3n6g==
X-Google-Smtp-Source: AGHT+IHd1YNak3qXuSJPLwTcxNpWToSodRjeM6x9b8vGCYHp3N6Zam2SmnvSxbcx3tezAdJiKLw5fw==
X-Received: by 2002:a17:907:78b:b0:9d3:8d1e:cf0 with SMTP id xd11-20020a170907078b00b009d38d1e0cf0mr3536377ejb.54.1698920380456;
        Thu, 02 Nov 2023 03:19:40 -0700 (PDT)
Received: from p183 ([46.53.253.86])
        by smtp.gmail.com with ESMTPSA id ch26-20020a170906c2da00b009add084a00csm944494ejb.36.2023.11.02.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:19:39 -0700 (PDT)
Date: Thu, 2 Nov 2023 13:19:36 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
	rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	vbabka@suse.cz, Liam.Howlett@oracle.com, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
	weixugc@google.com
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Message-ID: <8fde83a8-aece-4e99-a9f8-1bcaba7ea246@p183>
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101230816.1459373-2-souravpanda@google.com>

On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> +void __init mod_node_early_perpage_metadata(int nid, long delta);
> +void __init store_early_perpage_metadata(void);

Section markers are useless with prototypes.

