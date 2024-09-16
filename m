Return-Path: <linux-fsdevel+bounces-29537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BD997A9B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 01:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97C81F2163A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839B158874;
	Mon, 16 Sep 2024 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lhmtCyxd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB05258;
	Mon, 16 Sep 2024 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726530363; cv=none; b=ra1/c1c6sT/Qbrdm8bXGja/kxfVlpiRyS7un0yXSWs0BYlHonUxDINISIPKBRLXPF6g+AJL5CFuIwLzw+oHIBV6LO1lesD9VcMjVBZ2wRcmEPrg4frbt26s75R3Lj8WFsiKi0IPZB98zYe8K8dGBIOMCbyN6z0tPT5WKhcgXl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726530363; c=relaxed/simple;
	bh=r42L6UXOT+vU5jSITTLDO85zvSoqYuh+K+N6qykrg2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh+S+LlyydHg0s4+iSA4jhwTxGQSbWqg3nzt9yqr2GvGIJuvoAcVVF8BePyO7dkhSmZhOkkH792fxCeVokKTAOrrstoTkkrINpmTsJyWIYKV2MM8a/Dn81hdTxVrJSxJD/0M5+lhGpn4qjXM5KrNee5xU9pqaIi76oC0U+OWkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lhmtCyxd; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726530352; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B4rNWlBdjfL9smwu9MlwgNfDAPiZe3aLTcpYgp1odwM=;
	b=lhmtCyxdXfBp0bpQdJmjzHzw9f+mvRS5lPNPaJ5vMYBvJyU0HgFWFNry5Yx/o9oVcbiUxqZ/atTxdJ1XF3IgULR4b9l6L7rvjjApsif/WadSgxgBQV5G7BojatxvRYhnO0cHGMwiembqDys4ZiFiRON2eUPO9hngpOyp8bUDUpg=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WF9HTgY_1726530350)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 07:45:51 +0800
Message-ID: <2948509e-f250-4723-b618-d737de5ddb56@linux.alibaba.com>
Date: Tue, 17 Sep 2024 07:45:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Greg KH <gregkh@linuxfoundation.org>, Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <2024091602-bannister-giddy-0d6e@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024091602-bannister-giddy-0d6e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2024/9/17 01:51, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:13PM +0800, Yiyang Wu wrote:
>> Introduce Errno to Rust side code. Note that in current Rust For Linux,
>> Errnos are implemented as core::ffi::c_uint unit structs.
>> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
>>
>> Since the errno_base hasn't changed for over 13 years,
>> This patch merely serves as a temporary workaround for the missing
>> errno in the Rust For Linux.
> 
> Why not just add the missing errno to the core rust code instead?  No
> need to define a whole new one for this.

I've discussed with Yiyang about this last week.  I also tend to avoid
our own errno.

The main reason is that Rust errno misses EUCLEAN error number. TBH, I
don't know why not just introduces all kernel supported errnos for Rust
in one shot.

I guess just because no Rust user uses other errno?  But for errno
cases, I think it's odd for users to add their own errno.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h


