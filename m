Return-Path: <linux-fsdevel+bounces-46284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A8A86111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC91B85923
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DEA1F8BD6;
	Fri, 11 Apr 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kPRirKAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB313B2A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383174; cv=none; b=jUVtwmXnMXs3gCBAdqD/twYeOflnK2lbzh0YHD8z+bFImMaTiYY2mr0NhAaQaz9c1gdY2OmD4ytxc5Sm1bXnvM3YcAhJuQPYczaPUQ4mFAHO8q9l9J1lDJCWuEs4ouxKdjukio9n1qtf2TCtZvwxUYgKwGAUcxx4dJevOkF6Fqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383174; c=relaxed/simple;
	bh=+0oWcU2F0Py3hmqgfjsjt/5LDdkKhmPW/eMZ/yB3ZwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KON+0Yfb8TwdyuSm/hija3AXuFAY2xIgZ/N8IuADwJtx/heE8C0bbHr9LCh90bwRhoEHPfZZVjie5wD3QU/QdPAg4vsxXuQTG5Imlxo4YARRkZ0R/E86HPhKvjPGz1/Oh3Ul3T2GmdF+HYj32Z9cdSj0bXyLysqprbxNM6bVGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kPRirKAb; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=+0oWcU2F0Py3hmqgfjsjt/5LDdkKhmPW/eMZ/yB3ZwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=kPRirKAbJPLxnXIpXmgXUki/wruTa4R8puIWQa00EQiXJFLHJGmA1f8vWaKHkS9DM
	 Ug3BS04ho+pMtAdmCRqC9FgqYKS2nx5IQPhtFQfcs5NINcQSKmmohWrBpW4uBP7EsT
	 F/AkLMDTgSSdj9i2a2IPSG1PSSFtQZCVoHVOifsRiDYYu5LOK6lIjuKZsq0FrZJECn
	 Dz64CRve3bvYX1CofEqLB8GWJCVX0rZkYiW1rTYG77ibaqLN3k758QZTHlr98Yg0eE
	 a6coooZQLTGp8W5J9DpDwiMK8ntfPhPQLlXIzO/CoCn9Rx7Dc5D6dxVXw8aJyrAbqi
	 7sOyHinzg1Kzw==
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPS id 5ACB01349E9A;
	Fri, 11 Apr 2025 14:52:51 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id E90351349AF0;
	Fri, 11 Apr 2025 14:52:48 +0000 (UTC)
Message-ID: <6cf4c137-10cd-4d4c-b109-d87e03bda4f7@icloud.com>
Date: Fri, 11 Apr 2025 22:52:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs/filesystems: Fix potential unsigned integer
 underflow in fs_name()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
 <20250411-kaiman-bewahren-bef1f1baee8e@brauner>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250411-kaiman-bewahren-bef1f1baee8e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: y6FGHfjpYIHQQxC7hikPGYDCffZ95P8d
X-Proofpoint-ORIG-GUID: y6FGHfjpYIHQQxC7hikPGYDCffZ95P8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=898 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504110094

On 2025/4/11 22:35, Christian Brauner wrote:
>> Fix by breaking the for loop when '@index == 0' which is also more proper
>> than '@index <= 0' for unsigned integer comparison.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
> This is honestly not worth the effort thinking about.
> I'm going to propose that we remove this system call or at least switch
> the default to N. Nobody uses this anymore I'm pretty sure

Sound good.

i just started looking at FS code (^^).


