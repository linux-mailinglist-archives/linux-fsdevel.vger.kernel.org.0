Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3704353FB22
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiFGKZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiFGKZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:25:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EAE5DE41
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654597528; x=1686133528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IohJlUVBbww9BRzKL6ekExpWZ8jHkfLIPPI0IF8XQaI=;
  b=YS57uOx34pViAtbA6ZeQ6MCmzQL36tTOqWUO9iDB0sVnVRTy4+5Zuex8
   HgjrqgVy/WTy1nqADz21BEqsmlRHM7RaBrIJ7+Ip2TOzzqh+DJ6oEeyfR
   tGZeMWKqf1u3NBPCE5Hrf6McFTMb4dDBJIm9roYJZmWfsIO4OlKUqQa4z
   /4kP4mV87m1NvI3+hUfKvgGdcd8IrAKRYHjfJPYBb/PC+O7aMJKDYcK3B
   SJYom837wliJxxBfxf6gkDpLqcohWb07pChA/+UQ7T8uSmjM9gZrUjPqA
   8y6NmuCeg9TpOGJVvpAUIg37MtBZ9hk/4lobLl31/3jn6Cx5q0g1TvPrv
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="314520266"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 18:25:27 +0800
IronPort-SDR: AnEcOdrnkn7gD06XQdZYiF7LoJ1qxttLi3gETFz6jRKgohC9N8TgAZ32gvqoB3CRvHDyjtvjZr
 U33NUs1NOFkJyT1QvBTc2LIMEu76jgETGqaHGSJ4jyVg8BN+8EWymNNaIxSiJ/kawZAuMUtwRk
 1y7gbTBrS/Afa7hzdeQl/j33MET2N9u49IKRuSO0m1b+hmkFQ5TNODBc6l6l//A74441K75VAU
 2N1SQdNaERsem7xEZTfdC8NO2AN/0PCQSo7U4xlnRbUxt32b6TwhPTMUNV65q2RLLpKxMXoHE9
 jnmA9Edpbq++JvPDI0/fSiXQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 02:44:17 -0700
IronPort-SDR: SDbLhE6uOZ2aTmCzs22oKEtoGaev3iUIy0zmGv8mggf5zkk0nWxkRoXKdI+5Yne4bFB0zQpQny
 4KMGxPcFoJnHSSnch64ulHMc5B/2CikN4OoQ/52zwSH1I4yzo3XWWIGa16hVamAuVZqKzSu/51
 vHIZgtvsnYLNKDrgEYVDO+wVk/f54BJYliaf5SjN9+vDHy7qiqcWX/8vZrVR3ShuvPw6WT53ui
 WKto0B1RebJD+uS8U6n7PG0uda7b92lfkHOpgt/G2q9hKgEJW49I0EtrvMHkJVxogFEWSFDR7p
 VdU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 03:25:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHRMC1CT2z1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 03:25:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654597526; x=1657189527; bh=IohJlUVBbww9BRzKL6ekExpWZ8jHkfLIPPI
        0IF8XQaI=; b=tpnCtYejexmM9J7MadfZdH0D2M8ZsQqY0aJmYAndFVI+SHoOlpH
        fUPEt8WN0wcSZU9R54YGnLR8oaubpF0dGFjEuoXcSEwevVU3XSRbJ4dADwVSRp/Q
        2gE6ZybvujrpJcyyJT0yvDllKQwPFamxDo/2p55A55oegqmr0crDDxAMjT7yWRls
        xBF71VHOLTP5d+psPfYv+XepZKlwpPDP+n0evYVDY6reZMRHOFvbthWAn2X//5gA
        VSn9CFVN5Fn2ksLKZsQhQqLVS+Q9BltmqreGfD6mx7HWIcu7LJ5VXvSQYwGsoHXd
        7hQlyHJ6ugIb+4eR+HqJXcyjMv1tUT+2IWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1dhQitQE38pc for <linux-fsdevel@vger.kernel.org>;
        Tue,  7 Jun 2022 03:25:26 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHRMB1gwcz1Rvlc;
        Tue,  7 Jun 2022 03:25:26 -0700 (PDT)
Message-ID: <ebd62517-28d9-0063-ce75-ef2bd7741965@opensource.wdc.com>
Date:   Tue, 7 Jun 2022 19:25:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] zonefs: fix zonefs_iomap_begin() for reads
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-4-damien.lemoal@opensource.wdc.com>
 <Yp7rox7SRvKcsZPT@infradead.org>
 <48ea1d34-6992-f85d-c763-d817cd32cca4@opensource.wdc.com>
 <Yp8j53irZalw6mlH@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yp8j53irZalw6mlH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/22 19:09, Christoph Hellwig wrote:
> On Tue, Jun 07, 2022 at 03:53:35PM +0900, Damien Le Moal wrote:
>>>> +	else if (offset < isize)
>>>>   		length = min(length, isize - offset);
>>>
>>> So you still report an IOMAP_UNWRITTEN extent for the whole size of
>>> the requst past EOF?  Looking at XFS we do return the whole requested
>>> length, but do return it as HOLE.  Maybe we need to clarify the behavior
>>> here and document it.
>>
>> Yes, I checked xfs and saw that. But in zonefs case, since the file blocks are
>> always preallocated, blocks after the write pointer are indeed UNWRITTEN. I did
>> check that iomap read processing treats UNWRITTEN and HOLE similarly, that is,
>> ignore the value of length and stop issuing IOs when either type is seen. But I
>> may have missed something.
>>
>> Note that initially I wrote the patch below to fix the problem. But it is very
>> large and should probably be a cleanup for the next cycle. It separates the
>> begin op for read and write, which makes things easier to understand.
> 
> I much prefer this more extensive fix.

OK. Will resend with this change. It does make the code a lot cleaner.


-- 
Damien Le Moal
Western Digital Research
