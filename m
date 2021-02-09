Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDE314C33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBIJz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 04:55:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8552 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229963AbhBIJxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:53:49 -0500
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; 
   d="scan'208";a="104368304"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 17:46:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 7E31B4CE6F81;
        Tue,  9 Feb 2021 17:46:13 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 17:46:12 +0800
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
 <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
 <20210209093438.GA630@lst.de>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
Date:   Tue, 9 Feb 2021 17:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209093438.GA630@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 7E31B4CE6F81.AEF5B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/9 下午5:34, Christoph Hellwig wrote:
> On Tue, Feb 09, 2021 at 05:15:13PM +0800, Ruan Shiyang wrote:
>> The dax dedupe comparison need the iomap_ops pointer as argument, so my
>> understanding is that we don't modify the argument list of
>> generic_remap_file_range_prep(), but move its code into
>> __generic_remap_file_range_prep() whose argument list can be modified to
>> accepts the iomap_ops pointer.  Then it looks like this:
> 
> I'd say just add the iomap_ops pointer to
> generic_remap_file_range_prep and do away with the extra wrappers.  We
> only have three callers anyway.

OK.


--
Thanks,
Ruan Shiyang.
> 
> 


