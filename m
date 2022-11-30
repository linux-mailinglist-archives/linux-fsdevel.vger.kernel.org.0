Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0610B63D291
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 10:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiK3JzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 04:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiK3JzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:55:20 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688A2B18F
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 01:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669802119; x=1701338119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PfmM6a5gkT8LDyP+3VBEQwikCCOkyxOtDnm2zOUOXHY=;
  b=bOhdPQo4aTmglXEoxSAw7wTg6UBpLbEWU14/x7zPqZ/kB8hQwDNrLZo1
   Qi40r/E41n4iJO78Cp1WUXOGSSAtq/SjwICAB82ARefY1sNnEuX8ys+AN
   QRDfWWc5gd78lau3vrGINrCRwIrjgvo0Dx5wR6QVptqB4iE635+rupNx8
   TJQ931wuflHVvCh2B+sZGDdbthilRdANNtCxklj709S0diiaEOnNWaV5C
   B6kesr6ZPWaDRV1La+pTd+MWqC/BIV8cfdlTkRtKMpQGv1aMai9RzLs3w
   UajDD2472XR9a7aOWRvUoecYHO7JHRTnkOl8nHnXmsWUM5de6iaOnm3EU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="329640822"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 17:55:17 +0800
IronPort-SDR: SdeAOMw5EeihEPdorBVRlDvxcDeXejd02GNbKYTFUtX3HrPTpagxOacsOwx7QL6ehLyYaD2W+w
 JbAP28NmsHk/gQkiaqPybX0clZGX1ysJlIUP0lRxzFRnPnk2AdO9WS1Jr1+UXbEfGq4fPOJeOd
 7IRNTStpvb7pSDHSmHwqVGK2TiUd1L6II0M+V2NC44I3If49oeSykv4CcwWMsDmq6P6Npv9UnU
 tUzWB0Z4FD+QcJb+ig3FoHmJHeeUYk59AahZqEZo/eTDr6J3TPIUegbgHm7iuGhKX9W1oE6sEO
 vsQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:13:57 -0800
IronPort-SDR: U52Hr3nOqfm89fvoia+DLMUZVaE5doP/h4VU7i+5NHisImBnh/EV8Kycw0IeDcAkIEOR7cMLgH
 j0mitxhxUk86n9x74+QzYYvFOfU8MN7blMBFZemBaqy7dASv6HquwG3YwTqAP+toThJCPslPDH
 2VB5FzeiK9rm6WKYPq+xzLDfjMVwNLFHmDqXds0KnaAn6V0G/JLVxDRQ2n4AGPoYpzghNn0Cxj
 GjMoImYjOxjLclCvZBJHobd30AkFwOtmrVuQukH+8yD1eR57Dm4hKRYl5eaHV+zCR+b8FlIOk9
 QEk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:55:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMZM90ddhz1RwqL
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 01:55:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669802108; x=1672394109; bh=PfmM6a5gkT8LDyP+3VBEQwikCCOkyxOtDnm
        2zOUOXHY=; b=WO70GxcfoJkaidzfqKTpf6XdrSJR92gGBcqtVjjWImgnNKJFA3C
        1qQ9Pac2+l9iEMRSkNYcb3YtQr2CmP64cVFOL1AzWKkAattcadn9VRgdDzzu3sYw
        a+b7n0DmPMTxgPx0L+moOK5KuWtWefFwiMikDVPA+Rm9ccaiG+TK/Gt1Nscesz8s
        zfjKvyMMqoH4tmasBu11mn7xan6xxRBhghlPHoQ+BCXda+WI3SAj0t1z+JF5L3w+
        lOZ1r/wbs/0FcsfgTQXKDer3VH0RggQmo59VaOB/EpQKyYPqFr39FgByPQi74sIu
        yFIjzvJNf44Tp2JxaVnhNqH5C0oypUoGLzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I1zpF2-hqBKa for <linux-fsdevel@vger.kernel.org>;
        Wed, 30 Nov 2022 01:55:08 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMZLx09szz1RvLy;
        Wed, 30 Nov 2022 01:55:04 -0800 (PST)
Message-ID: <1ef5747a-9469-4365-ffc9-05daa6f69288@opensource.wdc.com>
Date:   Wed, 30 Nov 2022 18:55:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Content-Language: en-US
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
 <b22652ee-9cca-a5b1-e9f1-862ed8f0354d@opensource.wdc.com>
 <20221130041728.GB17533@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221130041728.GB17533@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/30/22 13:17, Nitesh Shetty wrote:
> On Wed, Nov 30, 2022 at 08:45:55AM +0900, Damien Le Moal wrote:
>> On 11/29/22 21:22, Nitesh Shetty wrote:
>>> Acked. I do see a gap in current zonefs cfr implementation. I will drop this
>>
>> cfr ?
>>
> 
> yes, will drop zonefs cfr for next version.

I meant: I do not understand "cfr". I now realize that it probably means
copy-file-range ? Please be clear and do not use abbreviations.

-- 
Damien Le Moal
Western Digital Research

