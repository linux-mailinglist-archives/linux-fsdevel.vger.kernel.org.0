Return-Path: <linux-fsdevel+bounces-3750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7357F7A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD870281C30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB35381BE;
	Fri, 24 Nov 2023 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=veeam.com header.i=@veeam.com header.b="fCG8Pel2"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 09:18:34 PST
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF41718;
	Fri, 24 Nov 2023 09:18:34 -0800 (PST)
Received: from mail.veeam.com (prgmbx02.amust.local [172.24.128.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.veeam.com (Postfix) with ESMTPS id B83DB400A9;
	Fri, 24 Nov 2023 12:12:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
	s=mx1-2022; t=1700845952;
	bh=nrXhCkGTaOqUdOGnrTj2EvYUPyfJBBoTTlxHnvJ4qkw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=fCG8Pel2PwaEyTHJHhbrJ0SfLKowU22VKykGLlxSR6NQdNzJA5sL4w/E5cFF94vVY
	 v9ZuIdlcX1EJUZC5rIHuWdtRAhukNlb5fgjLQIT1I0WgRUtwL93U6bM6bCUE9wgNMV
	 vsj3+S4oelmJfCqbUFfS7hn667QdD5BmgLQTJDRvE97dN0O2wbOVxZ5rxHDe28P7JX
	 UjWqPsWiJdACzOWykzv23bew4SLG58IucRTBH321om/y3XxfQ4krFcPEg+JOXtY8e1
	 9tTVWJUpSxWvudNXVorn2H79jCWVcrXxUHlxVCykAGYElm4xmJbeLLhKAqh9LRjH7D
	 9WmiacGijFckw==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx02.amust.local
 (172.24.128.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Fri, 24 Nov
 2023 18:12:31 +0100
Message-ID: <14d5d31e-0dbe-8d04-91a6-82a886f8e92a@veeam.com>
Date: Fri, 24 Nov 2023 18:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 00/11] blksnap - block devices snapshots module
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Sergei Shtepa <sergei.shtepa@linux.dev>,
	"hch@infradead.org" <hch@infradead.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"snitzer@kernel.org" <snitzer@kernel.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <7a54a166-56fd-4d6c-a5bf-792aa58a8fe5@kernel.dk>
From: Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <7a54a166-56fd-4d6c-a5bf-792aa58a8fe5@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EsetResult: clean, is OK
X-EsetId: 37303A29F44B155A637662
X-Veeam-MMEX: True

I'm very sorry.

Script get_maintainer.pl returns a very large list.
I get "Error: too many recipients from 86.49.140.21"
when trying to send an email from the smtp.migadu.com.

But it seems that for the third time it was possible to send
a whole set of patches.

I'm sorry for the inconvenience.
Sending patches by mail gives me pain...
It seems that I have already gone through all the rakes,
but there are new ones.

