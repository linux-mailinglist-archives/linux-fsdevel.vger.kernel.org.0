Return-Path: <linux-fsdevel+bounces-6461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AD817FE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0271C22E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 02:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79079746A;
	Tue, 19 Dec 2023 02:42:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DC5C98;
	Tue, 19 Dec 2023 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vyp0Roi_1702953766;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vyp0Roi_1702953766)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 10:42:47 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: shr@devkernel.io,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2 0/2] mm: fix arithmetic for bdi min_ratio and
Date: Tue, 19 Dec 2023 10:42:44 +0800
Message-Id: <20231219024246.65654-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v1:

- split the previous v1 patch into two separate patches with
  corresponding "Fixes" tag (Andrew Morton)
- patch 2: remove "UL" suffix for the "100" constant

v1: https://lore.kernel.org/all/20231218031640.77983-1-jefflexu@linux.alibaba.com/

Jingbo Xu (2):
  mm: fix arithmetic for bdi min_ratio
  mm: fix arithmetic for max_prop_frac when setting max_ratio

 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.19.1.6.gb485710b


