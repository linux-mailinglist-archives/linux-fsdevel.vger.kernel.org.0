Return-Path: <linux-fsdevel+bounces-1831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52587DF4DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E517281B77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B51BDC6;
	Thu,  2 Nov 2023 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cnNxRUx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EC1B28C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:24:48 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F2186
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:24:42 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cbd1d7e04so5277691cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698935081; x=1699539881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=varkfJCjnH+u3E50Sky0yjh/elja1DPy2fnutdy0fKI=;
        b=cnNxRUx7ccBQGko5c0vAUqTMzOLY8iG/itkdGwAQNJxxzRx753c2aEE9v2rfl1cmot
         flImMkJQKEaV8c8g+Xy4EQx4pA4C6eel7PCYg2fk200NjECcsFdCsA79w7flqdtARnD6
         gZfrddTQcY+ozR50CJ2IcN6VpIuf/Gfd3CrVaVpyVsU1xFyIRvWjM0oejN/mHjbPSVut
         1BBCjBKLU75Yd8pJ+6FZ0vamtAVDLfMsQrpWX/jcFE5MH1kamac7TxMJHbxdsitcg95v
         E/btemoZytAvN7gKyHjZay4oMKqvQS7yBgyNbkyO6Bpncbi6V0/UwVON9Gigsd/4AuOP
         /vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935081; x=1699539881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=varkfJCjnH+u3E50Sky0yjh/elja1DPy2fnutdy0fKI=;
        b=n9LOBinb6P6guT6UqZyP6OCqFel15d/ikZajMTo8ddUo03uA/3v5dPARle/9gxsvEU
         a6/2IoPfjVlcIHghQOSjs1PZ4glBK4rBrgqSZ3F9qtuQd6WBA/SEHGNjz5r/VbOiM/T+
         7irMjiO38ctMHnW3pbQ/gu5W/R2OUOY2EAIx3oJ1Xb7NVoFjDKhH6ByhWuDa7QvWwA1v
         GyKRWLg2OQ2c8C92u/vp0lIkna/j+ZofXg2ePZakpjocDk11snXLpBd3Jpe+DMggvTxA
         MxfVds/+IOmBt6OqRlpbF0IGfzZ1/uheao4rLqOTa1IYXcLPbDiL8xfrN5/Ok1djHNSs
         HjrQ==
X-Gm-Message-State: AOJu0Yw15HnAXG52rDavF8sjM9ePjM1Nfx3MwPR29uobsOHQJZRCDcBM
	UtafiMdavVKIbDq9O+mUuKt2IMami/GXUrJc+vLgzg==
X-Google-Smtp-Source: AGHT+IH0Y68XhZR7psJfRikRrstCfvOIMTxVmiuULLZaDr4XBQoFiKDeDkzTE0NG9ZK0jSv8qPfgX077gTc8xgXgCAA=
X-Received: by 2002:a05:622a:44b:b0:412:3092:feab with SMTP id
 o11-20020a05622a044b00b004123092feabmr21550874qtx.50.1698935081374; Thu, 02
 Nov 2023 07:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <2023110205-enquirer-sponge-4f35@gregkh>
In-Reply-To: <2023110205-enquirer-sponge-4f35@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Nov 2023 10:24:04 -0400
Message-ID: <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 1:42=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> > Adds a new per-node PageMetadata field to
> > /sys/devices/system/node/nodeN/meminfo
>
> No, this file is already an abuse of sysfs and we need to get rid of it
> (it has multiple values in one file.)  Please do not add to the
> nightmare by adding new values.

Hi Greg,

Today, nodeN/meminfo is a counterpart of /proc/meminfo, they contain
almost identical fields, but show node-wide and system-wide views.

Since per-page metadata is added into /proc/meminfo, it is logical to
add into nodeN/meminfo, some nodes can have more or less struct page
data based on size of the node, and also the way memory is configured,
such as use of vmemamp optimization etc, therefore this information is
useful to users.

I am not aware of any example of where a system-wide field from
/proc/meminfo is represented as a separate sysfs file under node0/. If
nodeN/meminfo is ever broken down into separate files it will affect
all the fields in it the same way with or without per-page metadata

> Also, even if you did want to do this, you didn't document it properly
> in Documentation/ABI/ :(

 The documentation for the fields in nodeN/meminfo is only specified
in  Documentation/filesystems/proc.rst, there is no separate sysfs
Documentation for the fields in this file, we could certainly add
that.

Thank you,
Pasha

