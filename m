Return-Path: <linux-fsdevel+bounces-46373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A59A881E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2977AA683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5AD129A78;
	Mon, 14 Apr 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TAWOW2ID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097E279902
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637098; cv=none; b=KMWBUXb8EAwjh4WUTsACl13Fc7SPEuvbgmhJoEFosqEdYaiMH0EaceRdHXUIaOxU0GwxKwggE2AyJ/mvTQFDQajliCtgrV2KHfyFa14ti3SSu4CUjpbVPMeoh0C1Ry2smYpaCQsAAPgK2K7xmfmWwbN6aZ3ZsR+Dm4MAqhUvttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637098; c=relaxed/simple;
	bh=uSczamGJoJKbGvV0A8rmuxq4WURqfp+pw4w7uxYDPZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuZNkB3DjqYULurQyC8xzFk0ZvO+Y39GEt8Wmvm0UbwFeWmmZ+GlnqW4GfwtVTE94Y8EI4oKSG0p4fFbkQVimtfce+JTTY+qyaLFLJJieqLHy7Jy3kmym9V5lGfITeJeG70psRG5rwYYPGD5Xes+6K8ZQ2MQipAIj9sEIkU513c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TAWOW2ID; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=uSczamGJoJKbGvV0A8rmuxq4WURqfp+pw4w7uxYDPZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=TAWOW2ID6aTTvU+2MgRsbja7BK3I6WCve1CEcTJdzcuVylzCmnxH51hkvXlnJUDQW
	 NN5lKvFdU5YC64bkyNn7WvK8siqEibla7THc0XjaD7zu1HFDaSTdrJSSZA7aolMKaU
	 dMsR223FEqx8/giBGj4YiCi5AFdphjWH02Q67639CeDHtMweGU+1kxlrE5IwHCsk1U
	 YtplErG4FcFBUnp+mjdKzotOjXFVMbjtb0YdrK3ZZU4awXHuLkC+unzgpXK8fw+bOe
	 O7j6pAvdpxg6y8amQtYDOhjyvW5LNE3ML7swuaMoD4JSjCWhiAQG2xE0asiW9IOUDn
	 56eEyGr1LFBXg==
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPS id A9AD19600F8;
	Mon, 14 Apr 2025 13:24:54 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 5F754960248;
	Mon, 14 Apr 2025 13:24:52 +0000 (UTC)
Message-ID: <c6c5ab5d-8895-4c16-9f74-ad311cd8ac14@icloud.com>
Date: Mon, 14 Apr 2025 21:24:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
 <20250411-fix_fs-v2-2-5d3395c102e4@quicinc.com>
 <pgxiizhnhcuaol2vhwikrtqfcp6b3g4cxs26rwxzdxuyjnadtv@smpxafscsxod>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <pgxiizhnhcuaol2vhwikrtqfcp6b3g4cxs26rwxzdxuyjnadtv@smpxafscsxod>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Oe2BybD7vv3eR5YIj3SuH323SYG7yc6E
X-Proofpoint-GUID: Oe2BybD7vv3eR5YIj3SuH323SYG7yc6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxlogscore=937 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2504140097

On 2025/4/14 21:17, Jan Kara wrote:
>> Fortunately, the function has no caller currently.
>> Fix these issues mentioned above.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> As discussed, I'd rather drop this function since it is unused as well.

thank you Jan for comments.
will drop it in next revision (^^).


