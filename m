Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900904B047B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 05:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiBJEbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 23:31:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiBJEbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:31:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2913C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 20:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644467496; x=1676003496;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XyxZX5L/XiQIWlv0huUn8HZdudNz38ex4lZoPJKqjCs=;
  b=Ldka7oatHkT7V3le/+HCjWNhyv1jWK/J5n0PuCyKi3SQ089Nj9ABmEtI
   16wBtNet9ukYOCgQEFgjKMSJ0bkFpY7z9DJ76XLnbn+XO4pN7LFX2ECh6
   Cpr6YYxkWVmxRPc+3OOJrJYYOZ+yKvVtmx+k9e1EmT9TZ3tksoTULqjPq
   2q35uDORRgQ7WBGMpKugSMQ0+Gx8OUSH2JcWHK6jsXjIo1g2FPeKOdpdn
   uj3txARY3s6yIbtqCWLfG1jZLFvMXACH044MryRPfrj7vCU1Wf/ZunwkT
   qWd7mG4c+lpMDzQqA23IKM7utLkIO7ElfFsIGJLcqPAwz18T91HH2C8lX
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="192566477"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 12:31:35 +0800
IronPort-SDR: 8xyxDa5X7r4QQzAlKg9emLRbznQmBWgyXAiVaPiVuR4U1/XknhRgwWMSg8rfJ5ufTRRB/OxpdA
 VlAdB5w3sMFSJmhbUT4yEUPIqmDYYwP0O/mq5vyD/Ak/QZz8h+CWcqdUBueGsE0dKU/J4vWcEZ
 K1nLLXsYkgDBL4vPpMOnQqvtoytdY+MUFqHRHmyZOIh6p6g5sonEUYgwilqR25zkjQGlvtVs9v
 0fnvrHfrBUrsfcYgm+HexOJ+rnizWNUs91dQJoX1g2WGz6RNaUx4Zn1/4iW3F12f5hUssD3EwW
 hCBwEfELow7Zt/a+wfrtuHhM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 20:03:23 -0800
IronPort-SDR: LjudikjFL1StTNAYbQbaieyvd4X/1HLmAmMb5DDGKkkzrGvv80ihIIdIBeMeUrf6P4nsRFreJE
 f+c13k+wYmxTN+JK+ocHEKnb3zPgPEuRPS1z/SOZzmItz4Q2vhXwinbT7bs2sR97qmhepOQ+gt
 Hc+tZ+vz2xS54d1TeHK6xWoirDLqsT3vMpoo5lm3kZjADXESby4NhyHfcfp4tC02/nSYoHlGk+
 xfeDe66iIdaLN1nw9cGpvTbTqJ6crxPyO74ZjObIiCnJ9KxuZsOfVh+08VtgXfmyh/TGt+g246
 /cM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 20:31:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvP2v2sV2z1SHwl
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 20:31:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644467495; x=1647059496; bh=XyxZX5L/XiQIWlv0huUn8HZdudNz38ex4lZ
        oPJKqjCs=; b=sKvzjHcYobSCd62T+g4XlusFh+7FZmu9CmXdD8/IpqKkqdR/vXr
        8Ul9S5IGq0XjjdQ3OjFmLUcTi66X6vc6pEjN3ucsFtGm1BDJB43dDlBvJTD9r6eL
        wlEuJtSlA7Uf3or6S9gUgu5uT+CI0FRi4L8AniWxGQW3ySanYHi5L44VoJGKNH2w
        h6gNbOnxQfQmJAWDfLGKirymZJomqgfA3hTw9UHIiR9xM6FYXHklDAXdTRAtc+j5
        JmsHFQ3M6haNYMr1+dwMKTBIEXmlFEg5OdaAOkw1w3e7Du8mEE2RZ4b84ABl7DJl
        jh9GlO7Asy7F8fVkK0qonfUkN1ReR4W9n2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GEzgD8b-UEez for <linux-fsdevel@vger.kernel.org>;
        Wed,  9 Feb 2022 20:31:35 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvP2t3J8Qz1Rwrw;
        Wed,  9 Feb 2022 20:31:34 -0800 (PST)
Message-ID: <390248e9-c647-aa88-09f8-af7748f9b808@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 13:31:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/56] Filesystem folio conversions for 5.18
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20220209202215.2055748-1-willy@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/22 05:21, Matthew Wilcox (Oracle) wrote:
> As I threatened ;-) previously, here are a number of filesystem changes
> that I'm going to try to push into 5.18.
> 
> Trond's going to take the first two through the NFS tree, so I'll drop
> them as soon as they appear in -next.  I should probably send patches 3
> and 6 as bugfixes before 5.18.  Review & testing appreciated.  This is
> all against current Linus tree as of today.  xfstests running now against
> xfs, with a root of ext4, so that's at least partially tested.  I probably
> shan't do detailed testing of any of the filesystems I modified here since
> it's pretty much all mechanical.

For zonefs, tested on top of today's 5.17-rc3. Feel free to add:

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
