Return-Path: <linux-fsdevel+bounces-36224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E259DFA01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 05:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBEA281CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 04:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815D1F8AEB;
	Mon,  2 Dec 2024 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W7XOb6hX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999741D63CA;
	Mon,  2 Dec 2024 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114395; cv=none; b=F1EA1KbRjTu/EBmHgK/YGp8r7VflmXSrScF4PnDD8r6R45j8IIx+tqZqrPG7gryJSWq0kpMehBIhA2UD/qVm3pwGVtR2mLnkmVCXS45Ht4rsAQrFedWHkZ682VlJkV6QOzqX7Gl/Y4D1AiwDKRFqwG3XO98abi/YEJvpJnU/H5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114395; c=relaxed/simple;
	bh=EeXd3pdBfyAIdV/scjMjR1fHCqoj5o006OLksD7RJeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYnPdaJQ05XBVE2Ze7xGzCiQSxrah5rz0ft/fPpcWX68bQ+QureQ4GVzKA7ZmFmIaCxq+ruzmcvD+tTdPCuqQHjd1vI25b36JpAfZpMGy155ifefwCCcrdrEJ8EAWnUoAcSkagj1R3AEEB15MZXtt8uzPj97lR5Qkt+t/3uW9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W7XOb6hX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eEss/czmG5x64ONZAYiAhE8zkz3AWGDgZGMZf60+daU=; b=W7XOb6hXPMUJEHB03+0WXc1VkB
	rS9wz+DDWHh24wmuHE+BgPkLs5Cw5OUDNI1E2HXVzSSFRB5tAClCj8xy45+K26YKBhyFE5FkvF7hZ
	M7BWaFUEoS5XgqnRJykwR3IrEoM9JC2Smp169/DHnq0EKo/DxdKTyM8IDUFAmrdUt8zUxz+ahzvm5
	0WVbrGbtUat2PJm1JA3yGr9i7ToDgUKS1t1eHR6knasEUnM7pzMhF9ZwKuPif5vFtio/7xFr/pGpm
	rw13GyKAV/EXp3z8b9jH5D2UU+WZ50b8k2++u/K4Rs6hL+CFqodYjxsJktEOZa0W0rKA/6cdr+iNJ
	M0se4+4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHyDw-00000003vEu-0y5C;
	Mon, 02 Dec 2024 04:39:52 +0000
Date: Mon, 2 Dec 2024 04:39:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?B?4oCcQlVHOiB1bmFibGUgdG8gaGFu?=
 =?utf-8?Q?dle_kernel_paging_request_in_anon=5Finode=5Fgetfile?=
 =?utf-8?B?4oCd?= in Linux Kenrel Version 2.6.32
Message-ID: <20241202043952.GP3387508@ZenIV>
References: <CAKHoSAtp6Eu3HoUvdGuaHxt21zoHkVWmmGrRK9mw2T+-r-fEYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAtp6Eu3HoUvdGuaHxt21zoHkVWmmGrRK9mw2T+-r-fEYw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 02, 2024 at 12:31:22PM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 2.6.32, specifically on the PowerPC architecture.
> This issue was discovered using our custom vulnerability discovery
> tool.

Sorry, I'd need to rebuild the memories of the state of kernel 15 years
ago to do anything useful with it (such as, say, check if it's something
covered by subsequent changes).  As it is, you are rapidly training
everybody to ignore your postings; presumably that is not the desired
effect...

