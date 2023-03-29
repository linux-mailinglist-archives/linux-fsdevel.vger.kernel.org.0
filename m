Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691396CF7D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjC2X6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2X6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:58:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB335B5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680134279; x=1711670279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EBmElNeAYgokFOHFGcB6L9926A4jmrXRZ3p4EMNkEVo=;
  b=n7yAzOSe3jocTf4S0CZiJFRjsO4IDrZfpv9vRlYI3ZlphrnP9Qt+SUCv
   vC7+Y3LMxj4XuU+NUBjDHTftSmYdrJA1wcUexHVozWMxVMXUuQukdJING
   81V0CsVPebCRy8cZUcHZZh4SI/W065qH+ON0aqd03/N+X0tenCWRVpZNh
   tmvtwAA2f5iyC5Ci3i17I5rAzbYmnOBIZlCpufAUFDYiujSJSJDtCWUIP
   0bDJ1mTE1ifYcFHp0qA86DcpkdyKFLCiQuKyb8BLeKZ8+Vphoeh8IgxwE
   cajXMmmQA3yN97VWgkBkBMU2AONE99e2yYCaQ84TQvB/N/Pax5iw5H3p8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226829723"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:57:59 +0800
IronPort-SDR: IgRCbW3vf7dAodzaGJ2y0+5bHGTWkL2wPlD07bt0oI5+cKxEQigfpfp2qK2Ahbs2Dy1JnCKB1r
 nQkuCfmDldiiEhuzyEAUVNTDFAbLCetntSG1pPBj4peeHJZsvPI8MH0n37KFFAktVPITIo9zPT
 fekC3R4gv4miiGk9Hxq2CYrn4TFcy+jLgctPCZ39KJGhxRT60UakubVxpM9adoPV3I+CLz2lxc
 /8z46b4cDd8enlGnLcpusfcG9N8feAKch97gg7J1LxElZfzkZfFZMu+4oEqhz47YDjK4E8kdcf
 0Ds=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:08:27 -0700
IronPort-SDR: UiE5urCEcJS3McnH7Q5TPZwYFK3fzISLd5S7cwsyAKqiavr9E8b2bBNh90zrqFfJTk+yr2wJqR
 QIk7QNatKeQhTM5SDUlA75vnPFe5keEP1VwPaSrMD8MiLOSRQq1fyXqrCB1DJlUBa7Bv2Bv2AQ
 Hh/TDpxp7nGNz8tu+Q1KOfNGNpGiTPN0qheMSPom1VmnPk0yAhW59zyTIEL/9fiNy+GjRWBMqb
 HBIU2fvz65mpUGjdqlHwBCzS7Ad2miEUZvxB4rTqwROw/IxLi5QpmNNjrtB9Kw9ujbcz1YsZET
 47Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:57:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn3QZ6VfBz1RtVt
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:57:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680134278; x=1682726279; bh=EBmElNeAYgokFOHFGcB6L9926A4jmrXRZ3p
        4EMNkEVo=; b=JP3H4/aexwmfYqedBvs1Pj6bfAQozRYxwD2FcgbFYUqVrxoEMva
        9hOw3LNZKB1KfoK4uPAygPDyBfIe0k51QlJPnRYZ4SwLDACSy+Nz1T3Q03ojLMZT
        vMIfuJ5urcaMyC4ckcmM9JztEtlKH3N1yOn55vuilzUGXQbST+aPTUTsrdhFDad0
        NggFprHSIaCwtAE0M6CjCWNSQfcrwJFIdjdj20JtsAvCVHvzJ3tTF74Lbrxih/1+
        za+ySjeBTbUsrFnO2kEgcj0oTU4gwdvZrVZwnb8SEJjWMem+0y8zsSbGC5PxN612
        8dyQAHKlrzNTlKTlzl2ZONv8IWpGwYW1ceg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BBgh_6EpT9jz for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:57:58 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn3QY5G8rz1RtVm;
        Wed, 29 Mar 2023 16:57:57 -0700 (PDT)
Message-ID: <dbfe808d-1321-b043-6904-2d1c87575908@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:57:56 +0900
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
 <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
 <ZCTLi+TByEjPIGg5@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZCTLi+TByEjPIGg5@infradead.org>
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

On 3/30/23 08:36, Christoph Hellwig wrote:
> On Wed, Mar 29, 2023 at 05:27:43PM +0900, Damien Le Moal wrote:
>>> But why does this not follow the logic in __iomap_dio_rw to to return
>>> -ENOTBLK for any error so that the write falls back to buffered I/O.
>>
>> This is a write to sequential zones so we cannot use buffered writes. We have to
>> do a direct write to ensure ordering between writes.
>>
>> Note that this is the special blocking write case where we issue a zone append.
>> For async regular writes, we use iomap so this bug does not exist. But then I
>> now realize that __iomap_dio_rw() falling back to buffered IOs could also create
>> an issue with write ordering.
> 
> Can we add a comment please on why this is different?  And maybe bundle
> the iomap-using path fix into the series while you're at it.

Not sure what you mean here. "iomap-using path fix" ?
Do you mean adding a comment about the fact that zonefs does not fallback to
doing buffered writes if the iomap_dio_rw() or zonefs dio append direct write fail ?

> 
>>> Also as far as I can tell from reading the code, -1 is not a valid
>>> end special case for invalidate_inode_pages2_range, so you'll actually
>>> have to pass a valid end here.
>>
>> I wondered about that but then saw:
>>
>> int invalidate_inode_pages2(struct address_space *mapping)
>> {
>> 	return invalidate_inode_pages2_range(mapping, 0, -1);
>> }
>> EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
>>
>> which tend to indicate that "-1" is fine. The end is passed to
>> find_get_entries() -> find_get_entry() where it becomes a "max" pgoff_t, so
>> using -1 seems fine.
> 
> Oh, indeed.  There's a little magic involved.  Still, any reason not to
> pass the real end like iomap?

Simplicity: we write append only and so we know that the only cached page we can
eventually hit is the one straddling inode->i_size. So invalidating everything
from that page is safe, and simple.

-- 
Damien Le Moal
Western Digital Research

