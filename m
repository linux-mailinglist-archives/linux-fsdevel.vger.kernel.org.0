Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283E76C05B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 22:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCSVmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCSVms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:42:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF91CF47
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679262167; x=1710798167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ng7kfezo8hw0LOeKsPNHr3k1ksn89DrIOwEfRACFEbw=;
  b=TX06MnRxYTbc2yyj8BeD6EoE9dQWDASlaQLkAlaYbMfxl0B1h69c49mP
   bAbAWOYM+pqGQif7/nMtG4Yloa0awPuNWm/ebEesSKoF1ZslGdFes6F15
   UHikhRbk2cHbXPcblRTe5KsUGq2jmvm71AoCxIVkV3haO4QWQXAH7Wvvr
   Km554zPFedAFEGKmhFxOgq488ziWRsYCUQgIdvFAk9q+XS0CLt6hJxEAm
   lznERowNg00WIPAT1Hn7PIVNPGUkTSpnIFW0hVeosHW/VlI3AxTkcYlYb
   VBrLB1WhPr9OoQYt5yk4clBM17ocPa2HCMbAbmmPg7iT6uRgEuYYiPL20
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="224272762"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 05:42:43 +0800
IronPort-SDR: QeGiFK/XzG/2vxtnj5sMgrgYayvOp/qTPxzkVzFOraqdrE+EKi5VTGY4//rCugtUuM2DLi0HBd
 qvtq99CQCGRrs5q1c43OjwR6stnXd1JhQzUWYKxDETFmbgb5i5yQtNyOHe150RtrS94utfdzpq
 pa/aBYmPMYh8Ain2V3TeuRvu2iTNnjuD8Z+8SUohSQEZ+WGZf1mGP6LR3/w6r9hv+Db23Mr0q2
 09Lh/2RZ4GPKvAZQ/8Cx8SVEMNk9w8MIJJImAsleqMJ7lTa4c1U3GiLG1PLv6SsQPIXv614OOu
 f+g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 13:59:01 -0700
IronPort-SDR: RxOaDLQuTcRV6p09sbi4I54I1TKy1K+P0ddTE5t5X+yqvkHdWowAwuYmjtdgxYxlGdWRgMwxP8
 NycXaSKX0VHEKHmMio1WBm1ZAy8mdA9OkiO4ma5khoZMY20Xg314KEBG4ygJLSa2C4noBX7qWf
 e1GDVmnw1bZy5rDASozl6EJD7bVh5WjJv66MDhi1nPwspSIDfcJIIaVFAFGv8MzphcN7KJRQfx
 rmLsHxwBDziz0DXInf5C6NWdKwg1/zZACbux7dI4gLOkfWLWGcbe5+bgIGE9VcMOUNyPCI6de6
 r6A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 14:42:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pfrv41GrMz1RtVp
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 14:42:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679262159; x=1681854160; bh=Ng7kfezo8hw0LOeKsPNHr3k1ksn89DrIOwE
        fRACFEbw=; b=r6QvF7zuIXNpXW1h0bPUFVDrbFYPWJdYpnvcZY3PpIIiTte3pNM
        W1yzPtCNolIWrBUwh1Kt7CHq61FKn4X7ceZtPOTH/muaSQDhVSxGauL1eMquK506
        h9b7LRsfic9X34KmvFfUq9t5WsC+PR2Nh9VoY7iXcTkYWf1TLhVgDYkZWq51J/5a
        SBXzCMRtyipdj0uTnwsE6SKNQZE499kXrNCqLf4OH7XK06sqHZcvj1xjjRv+Ngs/
        4ss+HZYD33FhE0AouSwRKE5QKE2eT+iwSd+RgjQDLv73jdp8mTIXn3jFCuyvouJC
        RKGXM2msoWQwWPtrzur37eDmQ52uD85QwGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j-KHNlKdqgCv for <linux-fsdevel@vger.kernel.org>;
        Sun, 19 Mar 2023 14:42:39 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pfrv21Jkyz1RtVm;
        Sun, 19 Mar 2023 14:42:37 -0700 (PDT)
Message-ID: <e98525c5-9420-63f8-a1f3-009601d02f2c@opensource.wdc.com>
Date:   Mon, 20 Mar 2023 06:42:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 04/10] zonefs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230319092641.41917-1-frank.li@vivo.com>
 <20230319092641.41917-4-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230319092641.41917-4-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/19/23 18:26, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/zonefs/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> index 8ccb65c2b419..5e117188fbb5 100644
> --- a/fs/zonefs/sysfs.c
> +++ b/fs/zonefs/sysfs.c
> @@ -113,8 +113,7 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>  	if (!sbi || !sbi->s_sysfs_registered)
>  		return;
>  
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> +	kobject_del_and_put(&sbi->s_kobj);
>  	wait_for_completion(&sbi->s_kobj_unregister);

There is no function kobject_del_and_put() in rc3. I guess it is introduced by
this series but since you did not send everything, it is impossible to review.
Please always send the full patch series so that reviewers have all the context
that is needed to review/ack.

>  }
>  

-- 
Damien Le Moal
Western Digital Research

