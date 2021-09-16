Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7700C40D145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 03:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhIPBhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 21:37:53 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40492 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232068AbhIPBhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:37:52 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AQUX/BaAjjTIk4RVW/zniw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBwa802si12cBmDQdWjiAPPqKNmX3eNh1bo219UIDu56Ax9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkExcwmj/3auK49SgliPnULlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPEbpOCacCjXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRg+Cg+an6LO9RPNliskqII/sJox3kn1py3fbS+knRZTCSqDRzd5ew?=
 =?us-ascii?q?Do0wMtJGJ72a8gGbjxgRBfNeRtCPhEQEp1WtP2pmnTkcz1wrFOTuLpx4mLWigd?=
 =?us-ascii?q?21dDFNsTZe9mPbcFUhVqD4GbH+XnpRB0XKrS3yTGF2na3mqnDkEvTQo0VELGn5?=
 =?us-ascii?q?/hCm0CIyyofBXU+UVq9vOn8hFWyVsxSL2QK9Sc066s/7kqmSp/6RRLQiHqFuAM?=
 =?us-ascii?q?MHtldCes37CmTxafOpQWUHG4JSnhGctNOnMs3QyE6k0+HhPv3CjF19r6YU3SQ8?=
 =?us-ascii?q?vGTtzzaETYUN2gqdyICTBVD59jlvZF1iQjACMtgeJNZJPWd9SrYmmjM9XZhwe5?=
 =?us-ascii?q?Iy5Nj6klyxnif6xrEm3QDZlddCt3rY1+Y?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/IP3/qkyQcrg23AZVPtrV8UvnSLpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,296,1624291200"; 
   d="scan'208";a="114547598"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 09:36:30 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8FD7F4D0D9CE;
        Thu, 16 Sep 2021 09:36:28 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 09:36:27 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 09:36:27 +0800
Received: from [127.0.0.1] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 09:36:26 +0800
Subject: Re: [PATCH v9 1/8] fsdax: Output address in dax_iomap_pfn() and
 rename it
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <hch@lst.de>, <linux-xfs@vger.kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-2-ruansy.fnst@fujitsu.com>
 <20210916000914.GB34830@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <212112d3-8b4d-1539-f133-22b321934b87@fujitsu.com>
Date:   Thu, 16 Sep 2021 09:36:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916000914.GB34830@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: 8FD7F4D0D9CE.A6461
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/9/16 8:09, Darrick J. Wong wrote:
> On Wed, Sep 15, 2021 at 06:44:54PM +0800, Shiyang Ruan wrote:
>> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
>> CoW case.  Since this function both output address and pfn, rename it to
>> dax_iomap_direct_access().
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Could've sworn I reviewed this a few revisions ago...

Oh, sorry, Maybe I missed that.

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!

--
Ruan

> 
> --D
> 
>> ---
>>   fs/dax.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 4e3e5a283a91..8b482a58acae 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1010,8 +1010,8 @@ static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
>>   	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
>>   }
>>   
>> -static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>> -			 pfn_t *pfnp)
>> +static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
>> +		size_t size, void **kaddr, pfn_t *pfnp)
>>   {
>>   	const sector_t sector = dax_iomap_sector(iomap, pos);
>>   	pgoff_t pgoff;
>> @@ -1023,11 +1023,13 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>>   		return rc;
>>   	id = dax_read_lock();
>>   	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
>> -				   NULL, pfnp);
>> +				   kaddr, pfnp);
>>   	if (length < 0) {
>>   		rc = length;
>>   		goto out;
>>   	}
>> +	if (!pfnp)
>> +		goto out_check_addr;
>>   	rc = -EINVAL;
>>   	if (PFN_PHYS(length) < size)
>>   		goto out;
>> @@ -1037,6 +1039,12 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>>   	if (length > 1 && !pfn_t_devmap(*pfnp))
>>   		goto out;
>>   	rc = 0;
>> +
>> +out_check_addr:
>> +	if (!kaddr)
>> +		goto out;
>> +	if (!*kaddr)
>> +		rc = -EFAULT;
>>   out:
>>   	dax_read_unlock(id);
>>   	return rc;
>> @@ -1401,7 +1409,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>>   		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
>>   	}
>>   
>> -	err = dax_iomap_pfn(&iter->iomap, pos, size, &pfn);
>> +	err = dax_iomap_direct_access(&iter->iomap, pos, size, NULL, &pfn);
>>   	if (err)
>>   		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>>   
>> -- 
>> 2.33.0
>>
>>
>>


