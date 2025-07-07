Return-Path: <linux-fsdevel+bounces-54133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E20AFB650
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6653AF783
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F62BDC00;
	Mon,  7 Jul 2025 14:46:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D2199EBB;
	Mon,  7 Jul 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899565; cv=none; b=R3LRyxNmURBXWSE41C6eA3TdGOfrUUVN3uKEDBrc7Hbnj+o84wmoPn7YXNUd4o0QoGhA5KaEgD5pDOGQo69Xt8I4aup5jGS+/z9ZhN7iufCgxj6OWjn5gnWGN6vwd9cHPkVGTsVS+dg4ldcNaD5pLuOqZIMg28TdVlUCQOGapC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899565; c=relaxed/simple;
	bh=7xzVqZi645TCX7lclST/aTyZcndDNHRWtb2vZTPv+ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvL/I2QoPE2MFqIBk9gJq/nuOOVGRxcGuz+6u4KdC0fuZ11Tn4UExCLmD8lu478tSkXb3SeGu12iJV6eoWVTwLG4n380M9rCYaMA9ha3JerifKXNXU4PuEdWWPBWepTq+OHorFjMbL6z//rI5wbMS0FyJeEatYTaY2fd3ybtofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 567EjUw1011678;
	Mon, 7 Jul 2025 23:45:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 567EjTqH011675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 7 Jul 2025 23:45:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
Date: Mon, 7 Jul 2025 23:45:26 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
To: Yangtao Li <frank.li@vivo.com>,
        Viacheslav Dubeyko
 <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/07 23:22, Yangtao Li wrote:
> 161         case HFSPLUS_VALID_ATTR_TREE:
> 162                 return 0;
> 163         case HFSPLUS_FAILED_ATTR_TREE:
> 164                 return -EOPNOTSUPP;
> 165         default:
> 166                 BUG();
> 167         }
> 
> I haven't delved into the implementation details of xattr yet, but
> there is a bug in this function. It seems that we should convert
> the bug to return EIO in another patch?

I don't think this BUG() is triggerable. attr_tree_state is an atomic_t
which can take only one of HFSPLUS_EMPTY_ATTR_TREE, HFSPLUS_VALID_ATTR_TREE,
HFSPLUS_FAILED_ATTR_TREE or HFSPLUS_CREATING_ATTR_TREE.


