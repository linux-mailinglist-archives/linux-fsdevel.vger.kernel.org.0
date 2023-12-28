Return-Path: <linux-fsdevel+bounces-6976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47681F46B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 04:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD241C21A92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 03:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8FA15C3;
	Thu, 28 Dec 2023 03:36:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159711104;
	Thu, 28 Dec 2023 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VzN-31b_1703734564;
Received: from 30.97.48.199(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzN-31b_1703734564)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 11:36:06 +0800
Message-ID: <5e2ad1d3-32cc-4f94-963f-a066d2a21536@linux.alibaba.com>
Date: Thu, 28 Dec 2023 11:36:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress
 (2)
To: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <000000000000321c24060d7cfa1c@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

