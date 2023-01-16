Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195666BDA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 13:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAPMSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 07:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAPMRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:17:51 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB161CF7D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673871449; x=1705407449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bfK7Pk7RI2y8HPJQLK5bOXs/ZMMSIUYByy0hKWhE3CE=;
  b=LPzHA9/azh1q+fqwvM71bR7mVz/mln0K53jnI88rqzMk/xwFGK0NrUec
   EFbcHJObhRdsF9rA/3v3G0WpjawBUuJiv7iIy8Ir9HIzcnZU18/NH3+n9
   ed0LE1UWtmsxZTQK7hWmUkoRoEtyzsb2JEXQnt3fhH+YZ7aHuiXHWOF2V
   u6iry1Nb7p7lcyd+7tuqf94+cp+JKGeOHI2uhRIi/n2naqZvlFNfmhNhs
   gtmvGF5QwIGXmWazW4j72txKpBiuR9YOumspeVw5Kw8d765f2ELzA9tUt
   NwMuXLVNnKtmJy9tmEeyAK+hzizAnauUKOeQL2e0eB+iowTKBDSmd7iLS
   w==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="220757140"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 20:17:28 +0800
IronPort-SDR: REsAYc3jutLvcokIJp6teWWaZExl5xdES9yUH328b8S7WVggkBOHGw/tkfWKhoZbNtP5Yet6P4
 x7OdJBJe22O3uIjG7LeS5rkTZg/70okd+Nf7ylKtNnS5jirJLp9Y54oLhwPcaoMGa+LTF0rBPQ
 NHeah8SFHuKKHE5iUw8vWAX1FnrHRtmI92l9cX+qCiu9s1R8+HHqCZjVcBGaHI4YmVn2dXwb5h
 xroj6LJ9WpMmGX1hEdsQquLPQ6LA1+n198TfPliZ+7YJ3TcZzrmZvcf+DxTv21smPpbZg3nRfh
 0Go=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 03:29:27 -0800
IronPort-SDR: wLwqydJWLc63oeRf0+sEFYcvn/bxxkoShXrLmZXplh1aqZUKDzr/AbWt47QGm+htQANQor+MpU
 tY9evdbP8gmlnPbIg8iNPJGMKCXTEubaH+gFVJrCZaBWRxrqn0mxyjw+HhyFsit8Wk+yax/kSK
 Ei47VmHB3TvhfD/WTZGAkS3Tw0uKk8QPR9zobEbniHYJp9/NIB5HxF6wiNXs1FFAwzhPVZ/p2L
 F+r07exb/nRKkQ8xJLDhXIxUhHfe6v+ehjbnLbDU3H0CTnJoQ4EFxQcOm1Uijkm3PLXbkqRBqA
 5DE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 04:17:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NwWHX2t81z1RvTp
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673871448; x=1676463449; bh=bfK7Pk7RI2y8HPJQLK5bOXs/ZMMSIUYByy0
        hKWhE3CE=; b=togqD0d9SrGX+swcLwt3zFjaqjihzLorYUMaun7j9Fp2BoDNGo0
        fpUbj/cL8fRZ3O2fmqSbrBdi/dv4EK3ZVnETrzxLV+vNDSjH2r0YUVCSrNE+ZmJg
        s6UAeBBepBuF82SMWA61X7O3F8TcTiUyXjsR/Znsk5AZh9vGWhhTST0HgPlDfzhH
        mvVrVrMolS/Z52+2V9N5oETRJUSZy2VJdgKCe5pyODEArwawhNR1MnqemainNUhO
        yi0D3iZEQDveuqIJrgHOJCf2ER2PsXErnSPxnBwEVqzqdUyw1RGUBDPdM2bMW+G4
        yKxxEBlCa0eWkBbfDyKA6t5HB0Xi5YIHA2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5L0vEm9SDFWG for <linux-fsdevel@vger.kernel.org>;
        Mon, 16 Jan 2023 04:17:28 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NwWHW3lMrz1RvLy;
        Mon, 16 Jan 2023 04:17:27 -0800 (PST)
Message-ID: <942fd2d1-112c-f10d-0592-8fc2ac303d33@opensource.wdc.com>
Date:   Mon, 16 Jan 2023 21:17:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/7] zonefs: Dynamically create file inodes when needed
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?J=c3=b8rgen_Hansen?= <Jorgen.Hansen@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-7-damien.lemoal@opensource.wdc.com>
 <18550dcc-41c9-f417-c0aa-b28bd5695ffc@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <18550dcc-41c9-f417-c0aa-b28bd5695ffc@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/16/23 20:46, Johannes Thumshirn wrote:
> On 10.01.23 14:08, Damien Le Moal wrote:
>> Implementation of these functions is simple, relying on the static
>> nature of zonefs directories and files. Directoy inodes are linked to
>                                 Directory ~^

Fixed. Thanks.

> 
> Otherwise looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

-- 
Damien Le Moal
Western Digital Research

