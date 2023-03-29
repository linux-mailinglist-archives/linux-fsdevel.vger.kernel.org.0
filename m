Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A06CD48F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjC2I1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjC2I1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:27:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB96B2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680078466; x=1711614466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V4/44FwlOHTVUIjkQDrxFjvKsJ6ghHm018e5VlJKHUY=;
  b=kvk9f508jEUJw/99HBVN/2yHuDc5ZeVKaSpEHpX00/AvJthHNUyephWT
   PDrh8UaVA3tJ7HVF/tGPNFLPG/WXLE+u9M3KqCgDx/8J9pqK/asPsUAr8
   KkxrdnMzdX0Yh+F1U7LIt4xXkXptc19bnD3GRUVX+v2gm6b7uZNX6Tlzq
   xJVjvlalO4PZ515FWYEJPRssgUBBRMnR50oEV0YpqYEsbxxCzeCA+eNA1
   xntGuRI3/lyle2v1NfWct7iIotHCEMBninVpLkUD8rloTPxHME5VolWLr
   LfGsBPhKZjmNYGPkZQfVkpHUg2PBZw5Orhy5fb7YISzFEcjbfMFvH32ED
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="331212629"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:27:46 +0800
IronPort-SDR: uJ0ZzTv2KmxKlk3EjE7y9EZkWI7osHo/1wEB4FmJGsG+gvw28ZcNVbbdj9XvqgoOprPeS7/Awf
 8+z3Dqa9TKCMYq3oJ2rVeTu009TG78+Tmmh0a1hvBcLeYpFj3nGyIuo10yZmuy+c81xvKqGIWD
 enWYj/xHsoeYDapWDHYzplsSKiOnrSaoJlZki1WMyjbja4bmnME73qxVngOK3BPbNPkLdijuni
 BSBJGPI7vpe6xOVlG9f3GVquKly5nUFPxS1utF56QN0UO3rCeVA2DUcxTgsvwVu3JXoS+iD/nA
 NuI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 00:38:15 -0700
IronPort-SDR: YTYqmUHjv1lb+J2CPtjsj5bh1YDsUmxjN6i8E6k0KaQBQEyfk/J6Mdfizis2H+ZJW0Lip6qjNI
 FGSalIbIu3QoKomk0gheIaEmjI9T99SQL6TiCKBJWr5hEJLEL6HiSV1hkXpruTO4HfMLaAG6IJ
 xm++/QlvODWsPnsffTbZZZXwrX5qNXNnFeEyKIofWyE1XhL/AoGNCHwZvo6HaZBBGRihQj+Yr7
 NUJXrfr9LR2DEVyCiVq9aR7EtmwRjgVQbEtlu1iQXvGf/8hDi3qWAK9gdIy4bLVeY8V+ZHF4+F
 VH0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:27:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmfnG0ydlz1RtVq
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:27:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680078465; x=1682670466; bh=V4/44FwlOHTVUIjkQDrxFjvKsJ6ghHm018e
        5VlJKHUY=; b=byH580Dr27O7QjSk9/QmNLJVKKQHbuNFcqXBsCZKDmQH5RHAViR
        gi/0SQeuTPaXACOxNZ5DKPs5/3cOcDumcSGI5LoOYo34ifP5W9n1Y546pu1rVMmp
        gxhFx4Ali+Kch6mhOyKHlQz4dftHjeqMKN+HDrZSOtuW/RdbwotOm24dbkdt+1b9
        8fS+7RfXs4sYqFNVFjTC0wxyEQYnuZILChMS9mzB4UBs4hA++vG9bR2dIoA5zlRG
        wafFSPzetE4zlkIQno2WYcZUst93ziD8hpEldqtyW762uJvcLZKBVaajkdGFPAmU
        ECwiCoNPu8eWTKdqR6SGgaKBU8b3D8KYdww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uq8IjVkc61Pa for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 01:27:45 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmfnD6nw9z1RtVm;
        Wed, 29 Mar 2023 01:27:44 -0700 (PDT)
Message-ID: <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 17:27:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
 <ZCPzbFzjFyiOVDdl@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZCPzbFzjFyiOVDdl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/29/23 17:14, Christoph Hellwig wrote:
> On Wed, Mar 29, 2023 at 02:58:23PM +0900, Damien Le Moal wrote:
>> +	/*
>> +	 * If the inode block size (sector size) is smaller than the
>> +	 * page size, we may be appending data belonging to an already
>> +	 * cached last page of the inode. So make sure to invalidate that
>> +	 * last cached page. This will always be a no-op for the case where
>> +	 * the block size is equal to the page size.
>> +	 */
>> +	ret = invalidate_inode_pages2_range(inode->i_mapping,
>> +					    iocb->ki_pos >> PAGE_SHIFT, -1);
>> +	if (ret)
>> +		return ret;
> 
> The missing truncate here obviously is a bug and needs fixing.
> 
> But why does this not follow the logic in __iomap_dio_rw to to return
> -ENOTBLK for any error so that the write falls back to buffered I/O.

This is a write to sequential zones so we cannot use buffered writes. We have to
do a direct write to ensure ordering between writes.

Note that this is the special blocking write case where we issue a zone append.
For async regular writes, we use iomap so this bug does not exist. But then I
now realize that __iomap_dio_rw() falling back to buffered IOs could also create
an issue with write ordering.

> Also as far as I can tell from reading the code, -1 is not a valid
> end special case for invalidate_inode_pages2_range, so you'll actually
> have to pass a valid end here.

I wondered about that but then saw:

int invalidate_inode_pages2(struct address_space *mapping)
{
	return invalidate_inode_pages2_range(mapping, 0, -1);
}
EXPORT_SYMBOL_GPL(invalidate_inode_pages2);

which tend to indicate that "-1" is fine. The end is passed to
find_get_entries() -> find_get_entry() where it becomes a "max" pgoff_t, so
using -1 seems fine.


-- 
Damien Le Moal
Western Digital Research

