Return-Path: <linux-fsdevel+bounces-39008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82FA0AF8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 08:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B97A1887124
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5C23237B;
	Mon, 13 Jan 2025 07:00:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F201BEF98;
	Mon, 13 Jan 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736751609; cv=none; b=HOANHqwb/vFsjYQWzcpiFphiKjiKq3TMqPtKdFxw9lWIk5U7qAtaAXWCegFmvNazdjstqpGKBZIEODMUiYnBbfVAatPC+q+TBFl+TpDxUHPYpMiWZh0WsAs24BDo5XLbFHDlQRdnC3X7bbatqucip2Om+UxWKjcslc3Z4Ad3+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736751609; c=relaxed/simple;
	bh=zyTJryMb4Pwvm7MW308t5mbQy9Y4vwlSaVb3uyc6/oI=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CvoLbbVEJpWoRJ0V/cz3m3BhWo+PX7ww7xZifDQWFwVBf+heIJaUickKNTGiD2Hvw+6G2rd3IPM7Xj+axTixzmhNH42T7c3fOf9oDe4ctZsblJ93gj0XixS2GhR1HjeBE/glyFLPj4BRbc1a70j6eFxs9jVFxkujDkx5lpJYI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YWjjS0n7Wz1V4Mt;
	Mon, 13 Jan 2025 14:56:44 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A6E41402E0;
	Mon, 13 Jan 2025 14:59:52 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 14:59:48 +0800
Subject: Re: [PATCH v5 -next 16/16] sysctl: remove unneeded include
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
 <20250111070751.2588654-17-yukaixiong@huawei.com>
 <CAH-L+nMzferXh=P0brckqWGLo06Rg+XG-3ToLZqA5TBObRZimQ@mail.gmail.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<joel.granados@kernel.org>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <d6875a12-d5d8-2040-1653-c2d927e17273@huawei.com>
Date: Mon, 13 Jan 2025 14:59:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAH-L+nMzferXh=P0brckqWGLo06Rg+XG-3ToLZqA5TBObRZimQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100002.china.huawei.com (7.185.36.130) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/13 13:10, Kalesh Anakkur Purayil wrote:
> On Sat, Jan 11, 2025 at 12:49 PM Kaixiong Yu <yukaixiong@huawei.com> wrote:
>> Removing unneeded mm includes in kernel/sysctl.c.
>>
>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>
Thanks for your review!

Best ...


