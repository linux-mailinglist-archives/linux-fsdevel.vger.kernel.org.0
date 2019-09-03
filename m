Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FDA5FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 05:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfICDv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 23:51:28 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1843 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbfICDv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:51:28 -0400
X-IronPort-AV: E=Sophos;i="5.64,461,1559491200"; 
   d="scan'208";a="74742095"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Sep 2019 11:51:26 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5C39E4CE14E1;
        Tue,  3 Sep 2019 11:51:25 +0800 (CST)
Received: from [10.167.225.140] (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 3 Sep 2019 11:51:33 +0800
Subject: Re: [PATCH v3 0/15] Btrfs iomap
To:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <darrick.wong@oracle.com>, <david@fromorbit.com>,
        <riteshh@linux.ibm.com>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190902164331.GE6263@lst.de>
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID: <4d039e8e-dc35-8092-4ee0-4a2e0f43f233@cn.fujitsu.com>
Date:   Tue, 3 Sep 2019 11:51:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190902164331.GE6263@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 5C39E4CE14E1.AD2D3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/3/19 12:43 AM, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:08:21PM -0500, Goldwyn Rodrigues wrote:
>> This is an effort to use iomap for btrfs. This would keep most
>> responsibility of page handling during writes in iomap code, hence
>> code reduction. For CoW support, changes are needed in iomap code
>> to make sure we perform a copy before the write.
>> This is in line with the discussion we had during adding dax support in
>> btrfs.
> 
> This looks pretty good modulo a few comments.
> 
> Can you please convert the XFS code to use your two iomaps for COW
> approach as well to validate it?

Hi,

The XFS part of dax CoW support has been implementing recently.  Please 
review this[1] if necessary.  It's based on this iomap patchset(the 1st 
version), and uses the new srcmap.

[1]: https://lkml.org/lkml/2019/7/31/449

-- 
Thanks,
Shiyang Ruan.
> 
> Also the iomap_file_dirty helper would really benefit from using the
> two iomaps, any chance you could look into improving it to use your
> new infrastructure?
> 
> 



