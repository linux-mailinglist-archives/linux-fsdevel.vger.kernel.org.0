Return-Path: <linux-fsdevel+bounces-66461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A5C1FE9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EC424EA55E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231AB311960;
	Thu, 30 Oct 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AhlBi3vu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24001B983F;
	Thu, 30 Oct 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825765; cv=none; b=FAEmQ52LZUteVJe0rlx7QEIU2QdcbM0VM2rhmcysuUytVKQbsZ2jRDg4A4Qv0cyHtUdVGX+C1iiBsspCTopX3MkqhOa/5zv3GQupbK369AKdjz6CuyYBJTA5QJIFYbiYeUgdxZ7rX3X7tymVcgVW2vGVWO1KSBb314u3KybIYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825765; c=relaxed/simple;
	bh=JgOekl1fRNVOXXQ08UJNGNM+VVxeO4ryqVPOneeNllw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EomWDlW9bhvlhcQCq3JvssCN2GlRdZDPQ0cce3eHPvzfckdKUAp2F7hg6Mtrwa5KOTyWkzzTCzvCA4jPVDw+Fgkmp7nh7HZeeYr/LEttBqbqsVcHqk5oVho+US4AgFEnu0VCuWSWjIlOiU5iIKL+CjnrEzvB1w4gJOWBtko7JP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AhlBi3vu; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1F4bKlogCSdJhbXuKbxSuX7GvQDCu2l6WO7cEZ+I/rI=;
	b=AhlBi3vuwTuvlHKVsPyoRDWnzjbzXi7d9/ewCnESowJHxtRvlj/DDl6wY7MXLFXRcoA7PzqNf
	4d0NR8obvadoHPq1vEbHRxrA4mzVMaL0s+5x+TQmen0eNam9hmksKvYlIwh5dUPrNk4GL55Np+i
	KO+6HO75rVJl2G0KMINtofg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cy2m21JqxzRhRF;
	Thu, 30 Oct 2025 20:02:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 06B0C1401F2;
	Thu, 30 Oct 2025 20:02:40 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 20:02:39 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 20:02:38 +0800
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
To: Zi Yan <ziy@nvidia.com>
CC: <kernel@pankajraghav.com>, <akpm@linux-foundation.org>,
	<mcgrof@kernel.org>, <nao.horiguchi@gmail.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, "Yang
 Shi" <shy828301@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <david@redhat.com>,
	<jane.chu@oracle.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-2-ziy@nvidia.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dcd66748-4449-22ec-70ca-1b14b0582437@huawei.com>
Date: Thu, 30 Oct 2025 20:02:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/30 9:40, Zi Yan wrote:
> When caller does not supply a list to split_huge_page_to_list_to_order(),
> use split_huge_page_to_order() instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

