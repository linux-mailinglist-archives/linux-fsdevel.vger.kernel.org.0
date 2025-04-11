Return-Path: <linux-fsdevel+bounces-46274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D24A86084
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A58B16F572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0C1F3BBE;
	Fri, 11 Apr 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KbV08rHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DB18B47E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381566; cv=none; b=ofixe5eW0pXKElgNa8ye/NyRNHHpjkVFjwzPP+gmgy3DZqXZhtKNFwBPJNs2fAJO1s3tyvbdQa5yft7umjL94YCK+w1mNmu2E/gXycJXb9p4db2beXRFbRLRd/wpyvAdWmeLohjKlM3o3il29XuSnU5N9z80ve5P8f1YcDx2Q3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381566; c=relaxed/simple;
	bh=py5nY1Mhc97RH09qk8e1ussZlC5PZ99XMBxs4NEvgXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7U3foKQhKn62tnZEeHGzp389aVFp2wiRloBYO6W7xrIlfa79XibXqiL9MOXh84DpMS/WDHajRlJ5g/5mX+7gD8cN7Dkq8JbQ3OgWiTNYUQY7ehlTs9nvkSADg8v2vIceHsVgZCo1pu5KpOMJ2gM7hc0w6uojdaLgjPCkLUPp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KbV08rHa; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=CL+5TqY/OhkzQpgXfA4Y+dzWdR4qzfqIBAmqr6bDZao=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=KbV08rHaAqjd1qwQZNy3wxHZWWAq9iGm9on1KCkkxV70mIxakGExhMEIe89Y+yqw8
	 gnELHg4077ULarr2+j0MfigCetPCPlfcr1r3VCMNXofnFrT8vJV1y+og+7AZraOPn2
	 k3pRZdMVuH8Ml3c6zWxtUmVHpBKQkhp5T0RDZPAQGfOZLEmP/KzRhaOG1RLWN4Rj+r
	 eA1gzILM/EAgR4rCrHsewuRyAyVAbtLx+10/FQY23SaCuN0mhhG+ilTEa2nW7m9Y9n
	 sDzyrq8Sfa73gswMVhH5yl9NI7oPsk5WysqNH1g+e2A/M7grZi8i9e+4+4hEN4lJzz
	 bXoR+TydpGTJA==
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPS id 6DA4844268A;
	Fri, 11 Apr 2025 14:26:03 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id BA913442662;
	Fri, 11 Apr 2025 14:26:01 +0000 (UTC)
Message-ID: <c67dfd96-ae7c-4c10-8e80-70b9df566ccf@icloud.com>
Date: Fri, 11 Apr 2025 22:25:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] fs/fs_parse: Fix macro fsparam_u32hex() definition
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-2-7c14ccc8ebaa@quicinc.com>
 <20250411-kinokarten-umweltschutz-6167b202db91@brauner>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250411-kinokarten-umweltschutz-6167b202db91@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x1U0BH9FYF8aofNNgP3bEkzhDHbFa-OU
X-Proofpoint-GUID: x1U0BH9FYF8aofNNgP3bEkzhDHbFa-OU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=918 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504110091

On 2025/4/11 22:17, Christian Brauner wrote:
>> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
>> index 53e566efd5fd133d19e313e494b975612a227b77..ca76601d0bbdbaded76515cb6b2c06fa30127a06 100644
>> --- a/include/linux/fs_parser.h
>> +++ b/include/linux/fs_parser.h
>> @@ -126,7 +126,7 @@ static inline bool fs_validate_description(const char *name,
>>  #define fsparam_u32oct(NAME, OPT) \
>>  			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
>>  #define fsparam_u32hex(NAME, OPT) \
>> -			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *)16)
>> +			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
> Remove that define completely as it's unused. There's no point keeping
> dead code around.

sure. will do it. (^^)

