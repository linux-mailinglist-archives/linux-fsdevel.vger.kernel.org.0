Return-Path: <linux-fsdevel+bounces-71965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B0CD8735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75B0730022E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875D31C562;
	Tue, 23 Dec 2025 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JO4P0RhA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E72B2DA;
	Tue, 23 Dec 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766478708; cv=none; b=H4oEFIGI96NVWHLqHFmmmnHYk0hiFqQ4tgb4Nn1CMbKJypuUIhmGTJDfxFsODY/9A+Q+fJYWtNex5WbBFCbx/MvtpRnzoutRJ2aTjzGw+Iysamw9A7z4SYlRYIkBFJ05umAR2KEMSW0WUElSMpoMyKMeh2oLA5N/7I5iq3ZjLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766478708; c=relaxed/simple;
	bh=ykGDQCSJ9XGA/4GWYP2glmDLZ1AnpuTUrnuz1969ddM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4lucF6tVinxUFcFlWe1amCqNJVpv390OUT61EDhfPMGJ1xAvOTkxN3MdzIiNJZcuOdgdEmFyj2JCSb4bIzLQgnWAgBNzdsB/lyNKbt8tEowR2990M4pYN0vPZjw4cc7YdO4+JOygsvNHURJehLSCmQY3V32UCQuSfp6IbXV+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JO4P0RhA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766478703; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QDHZ4gEUp+iF2Zx/V1T92i7/2FBuX9i2CFTDzZA/ECA=;
	b=JO4P0RhAqRM48h+VPHOpk5Qho1gwxqBVud+SCuavqBtNDpfD4BAcMfvY09ZdJJysKIGW02GJVDabm9c8ZzU+641acZd+ZKsxLHIDqYbkM6Y/Xf50yM4hi4aPRhy7jqP40fO9UsyHtxCsPkV5MIL0kzhEveFjkttJz3UmpgihPco=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX.job_1766478702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:31:43 +0800
Message-ID: <e143fe52-d704-46d3-9389-21645bb19059@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:31:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/10] fs: Export alloc_empty_backing_file
To: Hongbo Li <lihongbo22@huawei.com>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-4-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-4-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> There is no need to open nonexistent real files if backing files
> couldn't be backed by real files (e.g., EROFS page cache sharing
> doesn't need typical real files to open again).
> 
> Therefore, we export the alloc_empty_backing_file() helper, allowing
> filesystems to dynamically set the backing file without real file
> open. This is particularly useful for obtaining the correct @path
> and @inode when calling file_user_path() and file_user_inode().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(I hope Amir could ack this particular patch too..)

Thanks,
Gao Xiang

