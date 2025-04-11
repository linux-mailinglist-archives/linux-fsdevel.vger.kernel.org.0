Return-Path: <linux-fsdevel+bounces-46298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0072A862D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F7B3A676D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543AD215771;
	Fri, 11 Apr 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="1Kt3ffmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC91F4634
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387608; cv=none; b=qUTvf9oi4tmQx631JsfiRAY183MYlr11PXA4Fz55TYG24Km0EJD7i3bkYNAFIWJDwfTzT9z3wSGMS96ihLA25IY+7b9WSaItcWw2ljE01fWLkZWZuoA3yBrHZh9Kvp+7wxH/Sg7qmiSaouCFtJgoFjhdBKRMHqCA15QePZnPwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387608; c=relaxed/simple;
	bh=kfZgL0m3AafBK5CZjTJrmuOv9gK7z4C1RVXhv9VlsKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucX2anjKnicN73yZlJiQF+p7JHvWEHN3lw/oNWRqrrlbh/A4eUleVtSSlowrwaFuRl/ngFmJiQ2UAYWW6uHlPg2x1Ow9FOzbMo6HdvienwBGjs7XqPMYiEBBXuDbJlC92kSpa6oUENbixq9Ymaja09zUBqMcSgNpr+hscBgJ8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=1Kt3ffmY; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=j6WNP9/kuuB7031EOEuW1ZIf0HGeyJeottKmwzGT0DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=1Kt3ffmYjIr2AtuE7d+f00D+7dphbfnTHzbYaWhVqvKzXreisfnoGPsDh9lPfwCdd
	 aO9+VxN6udk5HCgD0Qi4/Fl10da05EAWB4LGK06MqdKow4UJ7TN07chbEzGINdj3m2
	 A8yNLhX7czNky3A3Ee4pZsTm9uENSBVFQcYfV9dJ/sUE9cQeLKr74RBnEMhX5/4VKI
	 FdGPxU4KFOLDyR2a5OT0F71Cl85IU4er4f0H6EsVr23ie3G6elICn12FtDHTlWXDK0
	 GCpZ/cH2+jHxOn8NA9NQP30mU9VivRE/xVIw2Eg+4eNkYfmZTv19w6H6oJTwMJuJtK
	 Wi/MNf1Uiz+YQ==
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPS id 97B6244257B;
	Fri, 11 Apr 2025 16:06:44 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id E9839442627;
	Fri, 11 Apr 2025 16:06:42 +0000 (UTC)
Message-ID: <a9bea6ae-27b1-468d-b895-f65189658abe@icloud.com>
Date: Sat, 12 Apr 2025 00:06:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs/filesystems: Fix potential unsigned integer
 underflow in fs_name()
To: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <2425260.1744385645@warthog.procyon.org.uk>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2425260.1744385645@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qSZh5R0oHeM7dlS_LC7AgGF4PurinCuv
X-Proofpoint-ORIG-GUID: qSZh5R0oHeM7dlS_LC7AgGF4PurinCuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=913 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504110101

On 2025/4/11 23:34, David Howells wrote:
>> Fix by breaking the for loop when '@index == 0' which is also more proper
>> than '@index <= 0' for unsigned integer comparison.
> There isn't really a risk.  The list walked by "tmp" and the checks that this
> is or is not NULL will prevent a problem.
> 

no fixes tag is added and just improve code logic a bit since there is
no reason to continue the loop when @index reach 0.

> I also feel that breaking out of the loop with "<= 0" - even if the variable
> is unsigned - is safer, on the off chance that someone in the future changes
> the signedness of the variable.

for parameter @index representing filesystem index. unsigned integer
type may be better than signed.

