Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA163CBF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 00:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiK2XqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 18:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiK2XqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:46:05 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5931FBC
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 15:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669765563; x=1701301563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ycxaYLjYb+ma8DDHfOmlnxZ6kUuyag3iWhXxhAoI4Bs=;
  b=iR3pJzHttn2plnDBWBJhTrV0gQI/hlcIzPftu+P+29WWuUTuB1iLo/Fc
   tFKavw/2+Kxw2/6ar89PGtginwObr9uFaeyOtSpyP3tSSEqO0c6M9fC3M
   7vnPWBVvm4XDuWb4jPz8O+YR3opntZ1g/VruFS0sRBqNwHSAnJHTCFp6+
   zfTkOIy6J4B0+kJlHqHE118pWrhh1v3V/reF3yFrN7nZdPBOm20YeBnl7
   2urx1TVEwLW3UgY1iZwXN1XeB+K5Jhv6JaTRpyhIzQHJYFOp7ezNQ9ZJo
   y/i8v1WdfeRqyzoDGmcCX7S4bwwFyaO6n9nDxkRlUbxmsBVVw6J+oSCjz
   g==;
X-IronPort-AV: E=Sophos;i="5.96,204,1665417600"; 
   d="scan'208";a="217494469"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 07:46:02 +0800
IronPort-SDR: Hmaw6xNY87knbpwOcu5HACy2g8O+9PMwjWfvOsoqwxzxG66BxevSlOQs0UXLOs7QYdHs056XTN
 g3FqmLsXNn0C2cptj+4Ftwv7Ar3qYaGKXTP3NqFNNq2vxDjaKzFiOo7MBObTd3qZhQmF+CHeLb
 ZPXh7Z5UEJ4V34Fx6pc3Az+KqbcYafBrQbeHl7ir75Gzp+hK5U8RRT/SsGT+GVDSS0Kk0EzK4L
 8r8XHMH1dUEs/fx6A5+ndUjkYv4Rd1SO+JD0bSAH5vzIsi/Ij5lPGffjoBuuuvFdOr7SgQsWY4
 gpY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 14:58:58 -0800
IronPort-SDR: Z8jVkn7PVDmG7WMEFlqS+qa+1PrTkx3A+MqGe71V/JP6BzdOcBzQrZBU7TpqueBWLt7kzf/h08
 jPtjHk/Cd8ZPwVMICWsc8l0DgHnTBTeVTg0XfmhnBHaumQZA3gsRDpYeRAp2F/V4g8FfWT8+IU
 LhkVr2dAlKYkKgwKAAO1amB8mpj+U20AxA8/4U+5RAEtAtUWBUrmIOIDV5pCzVoNXqN/CYEMwI
 PSJ2tk9OChU7hkXaioUTkXb3vIITS/Rr6stgH/Iaea4ygc0JVJUbR1NpW5+iRhkaZVEawHlWTY
 FLg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 15:46:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMJrB1fXWz1RWxq
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 15:46:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669765561; x=1672357562; bh=ycxaYLjYb+ma8DDHfOmlnxZ6kUuyag3iWhX
        xhAoI4Bs=; b=qHUBIFsDit9tB+442wqkn8FnslJgjothH93jBEv+p37QzdcVqT7
        JfyO2rDEUbUFU9ySIb6ZZMnZBkjX7o0IfKCBh9VF3scGsxJdsvMdYhmob3Tpcuab
        QG6jHaofPY0hzIb5TbUHsCGPOi6edYL/y4fqu2zn4hilxMkcewsJd7eFcQmVvb7b
        41/WHvDf10VLkoY2+XPdKEsfCgSclP6hWS1nxiADYM69SXCQQsVgN48gtFRUhqDm
        CsGxlhrpkpqISWqICcXfGp/oz1v4MaTTkLG3r0YCNvoZm6NCTsx0miQge60XpbWC
        vDK9OwTwLp1OVSbohBFP1cwtZh8aadUIFVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QDS6vBzD9ehO for <linux-fsdevel@vger.kernel.org>;
        Tue, 29 Nov 2022 15:46:01 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMJr51fc7z1RvLy;
        Tue, 29 Nov 2022 15:45:56 -0800 (PST)
Message-ID: <b22652ee-9cca-a5b1-e9f1-862ed8f0354d@opensource.wdc.com>
Date:   Wed, 30 Nov 2022 08:45:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        naohiro.aota@wdc.com, jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
 <20221129122232.GC16802@test-zns>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221129122232.GC16802@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/29/22 21:22, Nitesh Shetty wrote:
> Acked. I do see a gap in current zonefs cfr implementation. I will drop this

cfr ?

> implementation for next version. Once we finalize on block copy offload
> implementation, will re-pick this and send with above reviews fixed.
> 
> Thank you,
> Nitesh

Please trim your replies.


-- 
Damien Le Moal
Western Digital Research

