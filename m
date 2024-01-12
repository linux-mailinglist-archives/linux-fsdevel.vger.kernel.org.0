Return-Path: <linux-fsdevel+bounces-7842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7482B945
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 02:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF191C24C97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243E111B;
	Fri, 12 Jan 2024 01:57:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FC1108;
	Fri, 12 Jan 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="125205560"
X-IronPort-AV: E=Sophos;i="6.04,188,1695654000"; 
   d="scan'208";a="125205560"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 10:56:46 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E9B9DD9D8F;
	Fri, 12 Jan 2024 10:56:43 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 180EDD6041;
	Fri, 12 Jan 2024 10:56:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A6791200A80D9;
	Fri, 12 Jan 2024 10:56:42 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B80201A0070;
	Fri, 12 Jan 2024 09:56:40 +0800 (CST)
Message-ID: <23cf9c72-c81b-4c8d-950c-a745172c97cf@fujitsu.com>
Date: Fri, 12 Jan 2024 09:56:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org,
 djwong@kernel.org, mcgrof@kernel.org
References: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
 <ZaBqqwKuLj5gINed@redhat.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <ZaBqqwKuLj5gINed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28114.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28114.003
X-TMASE-Result: 10--20.504300-10.000000
X-TMASE-MatchedRID: qeYWT+AUEkGPvrMjLFD6eI2qS/2TwQUc2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bpT/tp3lSZtfds6WtD+l5Ngx38j2cF8Y5xDiakrJ+SpkxXH/dlhvLv6fDpVD78xj9HxK
	csbaQWi9Z7eVi3CkHD9aml2+cEqVbyEWUXyOwgqG9POB463xQEmpiq4KsutXCaOWLD7G8i109dx
	qDxQNRxYQy2IsHC2z9qOroA3r2rtSvgkLMDorez7nHu4BcYSmtTnSpwnlY4yGbKItl61J/ySKve
	Q4wmYdMJgb3dwKNrjq/v0UhTKC9nMRB0bsfrpPI6T/LTDsmJmg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/1/12 6:24, Bill O'Donnell 写道:
> On Thu, Jun 29, 2023 at 04:16:49PM +0800, Shiyang Ruan wrote:
>> This patchset is to add gracefully unbind support for pmem.
>> Patch1 corrects the calculation of length and end of a given range.
>> Patch2 introduces a new flag call MF_MEM_REMOVE, to let dax holder know
>> it is a remove event.  With the help of notify_failure mechanism, we are
>> able to shutdown the filesystem on the pmem gracefully.
> 
> What is the status of this patch?

Hi Bill,

This patch has just been merged.  You can find it here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa422b353d212373fb2b2857a5ea5a6fa4876f9c


--
Thanks,
Ruan.

> Thanks-
> Bill
> 
> 
>>
>> Changes since v11:
>>   Patch1:
>>    1. correct the count calculation in xfs_failure_pgcnt().
>>        (was a wrong fix in v11)
>>   Patch2:
>>    1. use new exclusive freeze_super/thaw_super API, to make sure the unbind
>>        progress won't be disturbed by any other freezer.
>>
>> Shiyang Ruan (2):
>>    xfs: fix the calculation for "end" and "length"
>>    mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
>>
>>   drivers/dax/super.c         |  3 +-
>>   fs/xfs/xfs_notify_failure.c | 95 +++++++++++++++++++++++++++++++++----
>>   include/linux/mm.h          |  1 +
>>   mm/memory-failure.c         | 17 +++++--
>>   4 files changed, 101 insertions(+), 15 deletions(-)
>>
>> -- 
>> 2.40.1
>>
> 

