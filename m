Return-Path: <linux-fsdevel+bounces-49981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E6AC6D06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0244A80F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604028C851;
	Wed, 28 May 2025 15:41:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F228C5D0;
	Wed, 28 May 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446887; cv=none; b=cOOJscMhYiPvARzA/SkTMOen5PRxGzrurXlxb6k8Zpirex1lIWZn3AtXZlGl/7A6bDmgVl5wtIC09/+SKbkfmTmsTatfI6lqSyHHFWfpdOq3ZzTs0iLbXFmnV2AnpFEmqt1Bk/N/DYYElzKdMX8GNSgokclCJb+k6iu9SALYM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446887; c=relaxed/simple;
	bh=ZoivlCVqrph/MUahm4m/Oxnhfyt3cfki4kCEuld9nAY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=hui+KT0DTpVtHv1GNIgkEIPihnvJ45h2Bdc56OACqFakXnNIA+8Uws78B3f+tuFj0JGckp3/BzjnCAi7hP84itED7HUW7tCnAsxKPAMoRoIsbmz7LVty4UaQMS/uw86DnkY8vdiUamqkqUXnL3Sm3iFW3+z6xRVh1D9eUyLSl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b6tyP6VtLz4x6CZ;
	Wed, 28 May 2025 23:41:17 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 54SFfD8v025796;
	Wed, 28 May 2025 23:41:14 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 28 May 2025 23:41:16 +0800 (CST)
Date: Wed, 28 May 2025 23:41:16 +0800 (CST)
X-Zmail-TransId: 2afa68372e9cffffffffcdf-075ee
X-Mailer: Zmail v1.0
Message-ID: <202505282341166875usqhF9LuBlmx70Sd33jP@zte.com.cn>
In-Reply-To: <b7f41a3d8a8538d73610ace3e85f92bb20f8eb42.1747844463.git.lorenzo.stoakes@oracle.com>
References: cover.1747844463.git.lorenzo.stoakes@oracle.com,b7f41a3d8a8538d73610ace3e85f92bb20f8eb42.1747844463.git.lorenzo.stoakes@oracle.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <lorenzo.stoakes@oracle.com>
Cc: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <jack@suse.cz>, <Liam.Howlett@oracle.com>,
        <vbabka@suse.cz>, <jannh@google.com>, <pfalcato@suse.de>,
        <david@redhat.com>, <chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <shr@devkernel.io>, <wang.yaxin@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzRdIG1tOiBrc206IGhhdmUgS1NNIFZNQSBjaGVja3Mgbm90IHJlcXVpcmUgYSBWTUEgcG9pbnRlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54SFfD8v025796
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68372E9D.000/4b6tyP6VtLz4x6CZ

> In subsequent commits we are going to determine KSM eligibility prior to a
> VMA being constructed, at which point we will of course not yet have access
> to a VMA pointer.
> 
> It is trivial to boil down the check logic to be parameterised on
> mm_struct, file and VMA flags, so do so.
> 
> As a part of this change, additionally expose and use file_is_dax() to
> determine whether a file is being mapped under a DAX inode.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  include/linux/fs.h |  7 ++++++-
>  mm/ksm.c           | 32 ++++++++++++++++++++------------
>  2 files changed, 26 insertions(+), 13 deletions(-)

All looks good to me.

Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>

