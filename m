Return-Path: <linux-fsdevel+bounces-46283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D06A86104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C5C1BA8610
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA051F7575;
	Fri, 11 Apr 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lkAjPoUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE41F4168
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382929; cv=none; b=JzvgDCECsh/00ot+jnjzCRzNB+3Uxqk1KVQto3Ly0CUZut80gcXFY0ySmPqR3kU4v1tgf6iue+4XKG3aEmTUBsv0c8POVV8ED9mLbXBcd7R2A8+o0nB+lckkDrz+wjFQkwUWQhwYFWYMFDzi+fBwFQW+skY9I8Fghjx58GBg8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382929; c=relaxed/simple;
	bh=zzHzazriqKgtPFPYlBvq0tf2k7riQfwZaS1uIVL5icg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgCh10sgTwiWL6OyBKCHh5iYZYtO+ZGOl8LQ+N4Cyp6IyLBc2DzFfUKjUDOWEcJT9NjuYBVMmfAnH5YOkDQknD41jU5x7XsSjVLT5oy4mjoT9Y+URh4tOc3mPJSYwJgBUtvd7PDCZBNkd7K5Rz96kLxkumnfdXnUM0iNaEZ8DDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lkAjPoUz; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=18Is6h9HNJ9vmFioSxZvkOl0vsi2ABC8O9wcMCqnzQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=lkAjPoUzgQr9wvQag4l4gxVD04EhP6VwNQ1dYYnTr2+KCcT5GhLKWORezGAiX980w
	 89LfHN8yN3XWLNd60SO64C1UJYu24EeCJfx2UeJVq65eyExGS7ozY8cb6OjJTc4edZ
	 eIgAB2jJDBUDqjLFz7Hh9pI4Z34+D1GLGtWQ201MPYGW5vCsAj/N1evqIpyyV/xVlr
	 +bnlFyDJyVbLblcAydhdn/NXZ3mpyspIXWlHYdUviAX/8WsBwStAOxI0j6LM3kJulS
	 sqIn8xwyZwJewv6GOAdwGwdRPQ0BzT43iplKlQboGJQpK9Aboa1HLkx1nhUoEjQJ1x
	 Xr9tn6VRUnUOQ==
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPS id 5EE83357B09F;
	Fri, 11 Apr 2025 14:48:46 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 1D6D5357AC5B;
	Fri, 11 Apr 2025 14:48:43 +0000 (UTC)
Message-ID: <1d59d38a-5674-4591-a866-27dfbc410b93@icloud.com>
Date: Fri, 11 Apr 2025 22:48:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com>
 <20250411-beteuern-fusionieren-2a3d24f055d0@brauner>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250411-beteuern-fusionieren-2a3d24f055d0@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: P68mtjX63jAgQ060WWDBHM9gJhRLriVm
X-Proofpoint-ORIG-GUID: P68mtjX63jAgQ060WWDBHM9gJhRLriVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504110093

On 2025/4/11 22:37, Christian Brauner wrote:
>> - Potential NULL pointer dereference.
> I really dislike "potential NULL deref" without an explanation. Please
> explain how this supposed NULL deref can happen.
> 

okay.

>> Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  fs/fs_parser.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> index e635a81e17d965df78ffef27f6885cd70996c6dd..ef7876340a917876bc40df9cdde9232204125a75 100644
>> --- a/fs/fs_parser.c
>> +++ b/fs/fs_parser.c
>> @@ -399,6 +399,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
>>  	}
>>  
>>  	for (i = 0; i < tbl_size; i++) {
>> +		if (!tbl[i].name && (i + 1 == tbl_size))
>> +			break;
>> +
>>  		if (!tbl[i].name) {
>>  			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
>>  			good = false;
>> @@ -411,13 +414,13 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
>>  				good = false;
>>  			}
>>  			if (c > 0) {
>> -				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
>> +				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>%s\n",
>>  				       i, tbl[i-1].name, tbl[i].name);
>>  				good = false;
>>  			}
>>  		}
>>  
>> -		if (tbl[i].value != special &&
>> +		if (tbl[i].name && tbl[i].value != special &&
>>  		    (tbl[i].value < low || tbl[i].value > high)) {
>>  			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
>>  			       i, tbl[i].name, tbl[i].value, low, high);

for good constant table which ends with empty entry. for original logic,
when loop reach the last empty entry.  above pr_err() may access NULL
pointer tbl[i].name.


i find out this validate_constant_table() also has no callers.
fix it or remove it ?


