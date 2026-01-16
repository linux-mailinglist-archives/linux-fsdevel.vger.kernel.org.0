Return-Path: <linux-fsdevel+bounces-74062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690E9D2CE34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E41630255BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D41346799;
	Fri, 16 Jan 2026 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XyKpRjEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22812517AA;
	Fri, 16 Jan 2026 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547104; cv=none; b=Tnjxfgo5JDl9hsfW65o3hWoqFeqBYwBClADNFr3p5+Dt1diH4v9eBfiUdFa1m/khmnOO/FzF6ztd/Qewetn4Gz0FDC1Z+2eVR+WRnOjKx+8LZ0iO5nb4QTqnsa2g4E1L/LRmXQ6kuyN/XFodSAnTyntvBo9PV8CY0YBmJntoA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547104; c=relaxed/simple;
	bh=c0VolWpFczF5GzIa8WmoPIaO/8RTiFl+3y3367Ltbs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNeOdKQFgnhhhIdBU/hX1el7F+q32REezWdOyDFHTEiCOqVjsoVr2I0znzekYjN+IsOWlxDq6J4Hq9ryqZDoCV1wcR5vjwgfOWnpuFjFOlY1I9nd7eK5UwCUtYxuhhVNofrax9Uv2hFgdu8bNn0GBgqReBsxZiB18mT0CyS3FAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XyKpRjEH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3e04144-0a92-4074-80db-64b6d4d77e85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768547100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBUTCOHFjbFGpfKIPNZ2x/MSES1mwdUxF31wOjAIzrY=;
	b=XyKpRjEHuKwIO6PNRzLYAWpGy5vGQP9lcppuSgOF1NyIk31hvVH+PEEWHZyLiQMXE8+UMf
	p8OElZYRzAkMIy5hD7SXVsg5bS4sGKO0nXS1QstdZu9vexDNycLIPCHk82upj0Of3GUSMH
	zSvx9E82pSILt0fMqUYe+AnmE8DfETc=
Date: Fri, 16 Jan 2026 15:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/37] cifs: Scripted header file cleanup and SMB1 split
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Paulo Alcantara <pc@manguebit.org>,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, henrique.carvalho@suse.com,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <CAH2r5mtgC_s2J9g0smr5NDxSp1TO7d+dtZ7=afnuw9hMxQ4TYQ@mail.gmail.com>
 <20251222223006.1075635-1-dhowells@redhat.com>
 <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc>
 <320463.1768546738@warthog.procyon.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <320463.1768546738@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

I have resolved the conflicts based on cifs-2.6.git for-next. Please see 
the other email: 
https://lore.kernel.org/linux-cifs/e6e34879-cf33-4e94-a31c-aa1c66254184@linux.dev/

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 1/16/26 14:58, David Howells wrote:
> Chen's patches will conflict with mine.  Do you want be to base on top of his
> patches, or would you like his patches on top of these?


