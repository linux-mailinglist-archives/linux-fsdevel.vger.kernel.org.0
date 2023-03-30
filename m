Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACC6CF82C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 02:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC3AWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 20:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC3AWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:22:46 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911711B
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 17:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680135765; x=1711671765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4h+q1+sLFPfIhFkXZTCt2Yg6H5yBq7qiSSRd+yLjaxM=;
  b=NcqLfftC9aMi30h4Ln1fM1OVibpw2FrjNyDFzc5KlaHOPR1qv1YSvUuZ
   V0OgWGu2lxaWe2bVX1HpSqJaguhBBwRz0B+PZj23UYsXDfTYOSYC0WnkJ
   bnHKyzk+DCRMTZf5IHtVROw+eaWRSXeMRBRGQQgceZwLDFhwdcB7NZ8um
   d3QnoUUA+5Pqb/rgvQfUQ5T2bonwvX3ASevXzqdpGZ736F7ZuCjVND16R
   6u4VC9lnzkzBzTulvrLFj7GZjfbar4jYWJLfk5BW+W4DEFYRMZIFYTRuq
   kpjBWp+QAiGzi5vKVMuAUdeTYVZFYEcAr4uOFdAF65oIcsOvJINMkhUSZ
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225116393"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 08:22:45 +0800
IronPort-SDR: ux3R1sDZo/ZCXOblHjH2jx82dE1DUXHcp4tjGuK3EBefLnOhGW/Sjunj7j9fv73I6mB40Q3QQl
 03iKvfuKlIFj8ppEgCjAHmUZZza97doJsYyqk8DA/XbPoNB/FtKuCpDdd2AdGQ5CI6qGc/iFaY
 DtcFeOe7zyD5tcKZdGMB6J2o2IWys4aQgkNWtYgPd+44Pkyj1dPWFc1Z1F9ALtaaSH6bISka9A
 0ye7tJv2x8t+hy5jVqx54VbGUuUHELxn5+7FljtrWjN0RWG7unuF8UYIl2L98RhzCwTOa8H1t+
 gJs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:33:13 -0700
IronPort-SDR: /wcKwBNKfDgk/f0RzfU+Aj6TAk9xLGVKcZHdC5tf+WzWgbFOx9ayoBQ+gaydcdepUyItjB71Jn
 yJWkAjw8MmfW2tHyDMV68uJ7Vc8sdw9SDVv02Hfo66asjItcXjcZFEq5TB5YBNQNsmFHBhWB2s
 6iFwbqlnU1od6AkZWqCtF5ITRX78x0ZFrV6WYnxqCz5f6nb7UVwu0iaS+ED3UhRpDCUqdGV2H2
 zATwzdqjLxV82tS8+pec3HkMCgx4Adyaofh/5CY1ohoCNi8Et+3gKc84ALrgkqG/uOivR73ASL
 Icw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 17:22:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn3z8634yz1RtVq
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 17:22:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680135764; x=1682727765; bh=4h+q1+sLFPfIhFkXZTCt2Yg6H5yBq7qiSSR
        d+yLjaxM=; b=Dja7VFDTNeh374a7nX24OKKMYRtV6J4dboQCNaQmV8O17JvAg6S
        r9foOucWyB8ufy8jZsnHdxoYE3fqLzhUtlH++f4ypL7Rttn9PzQh9e8MHqOWBD9e
        g1eOJjcNjNdTif9iy+IP1700qIa0AhexAnFPtbrtTdLoOlnhWRFyNhdQxtYnVPTt
        Kj/TjnATq0s6aksUEGZxG9ObrYngdGbjGVrPGKZPjdJLdG3p7mhzQXLawqBisjhs
        Kee17b165m4YuUzB6668ZiK8gXMEUz43rc5LFeERdhCOtOF5bgVenUzlsHdxOA70
        aRKWET0J45G9x/MP+BzHw1IQ12ss/fXe+pA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IT35glaK46ou for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 17:22:44 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn3z75jVMz1RtVm;
        Wed, 29 Mar 2023 17:22:43 -0700 (PDT)
Message-ID: <b7aa1853-853b-c6cd-6c2a-960ab02aa7b8@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 09:22:42 +0900
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
 <dbfe808d-1321-b043-6904-2d1c87575908@opensource.wdc.com>
 <ZCTSyqspQ9bEGA15@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZCTSyqspQ9bEGA15@infradead.org>
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

On 3/30/23 09:07, Christoph Hellwig wrote:
> On Thu, Mar 30, 2023 at 08:57:56AM +0900, Damien Le Moal wrote:
>> Not sure what you mean here. "iomap-using path fix" ?
>> Do you mean adding a comment about the fact that zonefs does not fallback to
>> doing buffered writes if the iomap_dio_rw() or zonefs dio append direct write fail ?
> 
> Making sure that the odd ENOTBLK error code does not leak to userspace
> for this case on zonefs.

OK. Let me check that.

-- 
Damien Le Moal
Western Digital Research

