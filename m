Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA79631E807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 10:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhBRJ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 04:27:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40611 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230303AbhBRJBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:01:21 -0500
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800"; 
   d="scan'208";a="104601999"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2021 17:00:03 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 2F5E34CE72E3;
        Thu, 18 Feb 2021 16:59:58 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Feb
 2021 16:59:57 +0800
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <agk@redhat.com>, <snitzer@redhat.com>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
 <20210210133347.GD30109@lst.de>
 <45a20d88-63ee-d678-ad86-6ccd8cdf7453@cn.fujitsu.com>
 <20210218083230.GA17913@lst.de>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <9edffa8e-faf8-3d29-6ec0-69ad512e7bb7@cn.fujitsu.com>
Date:   Thu, 18 Feb 2021 16:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218083230.GA17913@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 2F5E34CE72E3.AE2D0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/18 下午4:32, Christoph Hellwig wrote:
> On Wed, Feb 17, 2021 at 10:56:11AM +0800, Ruan Shiyang wrote:
>> I'd like to confirm one thing...  I have checked all of this patchset by
>> checkpatch.pl and it did not report the overly long line warning.  So, I
>> should still obey the rule of 80 chars one line?
> 
> checkpatch.pl is completely broken, I would not rely on it.
> 
> Here is the quote from the coding style document:
> 
> "The preferred limit on the length of a single line is 80 columns.
> 
> Statements longer than 80 columns should be broken into sensible chunks,
> unless exceeding 80 columns significantly increases readability and does
> not hide information."
> 

OK.  Got it.  Thank you.


--
Ruan Shiyang.
> 


