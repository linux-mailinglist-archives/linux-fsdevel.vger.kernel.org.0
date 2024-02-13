Return-Path: <linux-fsdevel+bounces-11429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE931853C2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE89287996
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011860BB7;
	Tue, 13 Feb 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BMVTDFy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32C260B80;
	Tue, 13 Feb 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855914; cv=none; b=b7HnL9eHUOhs2LhHC14iOkG4hEzkanxmoIpVu9sznxKFkb9oENKCEbCY+7mua1VZAhcw0dk73apOwzNBop0+oVKfooWnTXJ/7F8CxQ3lMvaqAyDplSf54DpMIyNG6RwbDrfPiP/H5Pc9vg1MwNjmvQ9orTD18XDwNhExZtdWnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855914; c=relaxed/simple;
	bh=P9vMmHmk4NQr49aA6KTl5XBWw5rmaRyY/3LRJfNYz/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZr3wf8VwCkDJa1b8TZ0aICWWpEdK7YU/VkHtHiDSm3EDEjmQ8BrCo79kmqXw5eQJ2LSe+kkzfmpQPneJDSkNtue7SQKVw/EuLG+KvPZZMZCx0qZydi3EuNfEYMev+m7Q4Wl5AFa2Jscun4rbdlXH9l21W0BKaJPdI6SWRQL3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BMVTDFy4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707855912;
	bh=P9vMmHmk4NQr49aA6KTl5XBWw5rmaRyY/3LRJfNYz/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BMVTDFy4P2KoGWV1cFjgJk/Z2iwbE9COqomLBtRzciQn4MOcdMZxH4Yx4H+N6rFct
	 75b1ouPchajvOCIzq/urVZEiaRNjBhwJkFVRd08p93Ts8T/Qhw05GqtP4Ap58OVFoR
	 kXpHWlDZBMuKtvoCEwQhycVscvhcJ3A7tEGbH3Pn/Xl7YoJ+IowPnL8nO6SRXILUOP
	 dUnaIV4NdTQirgC9eQbZAAl5ZwsVm8HyvB4C92mcosjuigmXBPzX7tkNi1ZRX1c5pN
	 JbgKlwiEm/CePGQksZS8s05mBYMfkWxcBCZFHyGxrFh85UrZk4QLm2dZqXEgBXJ2aA
	 d1iYF7K9nxa9w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TZCVv5CSJzYVb;
	Tue, 13 Feb 2024 15:25:11 -0500 (EST)
Message-ID: <df41559a-ac4e-4daa-b3b2-e34783496be3@efficios.com>
Date: Tue, 13 Feb 2024 15:25:11 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 lukas@wunner.de
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
 <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
 <65caa3966caa_5a7f294cf@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65caa3966caa_5a7f294cf@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-12 18:02, Dan Williams wrote:
[...]
> ...and Mathieu, this should be IS_ERR_OR_NULL() to skip an unnecessary
> call to virtio_fs_cleanup_dax() at function exit that the compiler
> should elide.

OK, so I'll go back to the previous approach for v6:

DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))

and define the variable as:

struct dax_device *dax_dev __free(cleanup_dax) = NULL;

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


