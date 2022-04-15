Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204950238C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbiDOFNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349935AbiDOFMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:12:51 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240375C02
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649999310; x=1681535310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fza98p6Hk/Oo3R5YjAQC2Nws92s1JhenlM6js5zQuBI=;
  b=lFo5ui/mlJZtRzVbE9ro1pF4slqM/hjI3wqO//de6KfsJ10rjL848v2v
   VSo3Bfe3rjdUa3243pUARlrjsndjFlGDr3p4h1SLaz0FdCCIEpjBf4ezm
   CQ+ecfdyJ0VT8W1QzWPGLHAjEJRuIvFp4BSOSiHyzICKXKG8lyADgOvIM
   rlD6SV01CIApFt4WIY3efPGTtFelGksjKdAdG/yqHP4dMeUeFleoODpLH
   tNbS2a9J5ldNG62+lrH/Ml/XubyeT1dro+gd1s7LJ9TAxLQ4ISDkPHTyT
   9kR1mb72iUCuiQzfraZD8TJpuToiCSrfvhkB4A2JCNVuoMjt/PMcY5c39
   g==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; 
   d="scan'208";a="198866562"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 13:08:29 +0800
IronPort-SDR: eOQlmOWnFIeBjCBeOv6TEPSruloG6esaWAfjGCQfk5Pq3V1zk0j1dfFd0QCjoj8FwAShg9Nt3l
 gBBb0RinKmJC8mQilY/fe4lAfyNwcGm7P2X02Vb16EepNxudABhVtrTB0E3Elp7aXV5iNdeV6O
 DA5KPXEfMQaaakIn7YFcf8/ns0LpYoR0BiODS08Of8QECK48OXC/p7oLWxpRmik6mQVaPdamMX
 9N+qUFtwWfyAvP8q9LowaP+FrFi7KXiyL0rTjTAlCh+odk1in5FUNGhoVCC2XZ+BpmLNILozTZ
 C03Bv9lqaLDEDvCrcD67XPup
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 21:38:53 -0700
IronPort-SDR: GgPo8Mx6rGocne0yx5bKTKlyLG5jgGzryHN+z8/OasQi1izwubYEd9AxZ+whNvwiSzUnEO0FvH
 /npfb1cBcOGXMqIGPMxucQczrWrpnsfb23QC0bCwa6aXxOw1SYBRx6KJwWR0DQLgmeXd588Qf4
 BssRHKkTMGzWzofCzfNGSc3B81Ks3wM2+aUNZh8EN5acdoHDty+xo654CGvVMgQouDvjcLPBJM
 3m+myRIgnY0E2AM5A4JT/DJsmR6oKZsNS3eLqACcEK9XNBu25qxM4SqEyPEmp2OuLRoxaVOj2k
 cbc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 22:08:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kfkqv50HSz1SVp3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 22:08:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649999306; x=1652591307; bh=Fza98p6Hk/Oo3R5YjAQC2Nws92s1JhenlM6
        js5zQuBI=; b=ImgmXK0ljefxmjcwwGCZe/P1ZAiYRfxiStEm0q2wFeKQMvkTL85
        MoEiv1WWngR6yiDdywhy6m6c7CHetStsP2KPL7aGmRBSEDoQ0BBkWf7uSl7GctxX
        seFLiVHTqharLpAbcplk3yzDBSQpNNHnyTWqCGnT6SDEQPGGz4njOldB2JpZjV0c
        Fn1jBi13ZsAeHMQyLgImvLHIeNwH3xSreGo+kohOYlio/FQU9mPmWWTRsJd3G6Vg
        s7uGQ1kCv0yoS1gOWClHM7ArPs0jj6m4kJVcJWYcgsITqalXpkzGP3XvQ+R3owbL
        r+qmM2ogk4tvzMNidepDhru5fT38QuGd/Yg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ESHz5Ht2248N for <linux-fsdevel@vger.kernel.org>;
        Thu, 14 Apr 2022 22:08:26 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kfkqn6sCZz1Rvlx;
        Thu, 14 Apr 2022 22:08:21 -0700 (PDT)
Message-ID: <d7a39cfc-9b28-f0d6-bf62-4351c55daec2@opensource.wdc.com>
Date:   Fri, 15 Apr 2022 14:08:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 27/27] direct-io: remove random prefetches
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-28-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220415045258.199825-28-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/22 13:52, Christoph Hellwig wrote:
> Randomly poking into block device internals for manual prefetches isn't
> exactly a very maintainable thing to do.  And none of the performance
> criticil direct I/O implementations still use this library function

s/criticil/critical

> anyway, so just drop it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research
