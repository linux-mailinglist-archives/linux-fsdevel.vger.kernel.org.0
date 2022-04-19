Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE050695D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349171AbiDSLFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiDSLFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:05:37 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4211BE91
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366175; x=1681902175;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=W495Y2DRejlmTkUtNFbxkwW3U1dxuBLVQtP6TzceSjo=;
  b=rOuRTSQYYaho2lSb59A4GbrAE7t9SXfRoPgsNnU+6AT+IZP4oSNPSNV8
   CZJVi5QdN9lBZbX8uZUhebx2GyfseuUCU+t3N1r3NUQN/p6vTSSJkyYGU
   sNrgmgjDCZ/9cTg41y7eaX3Or6wdqbmZDR5ouW8vPDKHocAX6Ol3gxWGw
   3xZwLIgfYuMInylZAtEPoNsjugN/1W/qfy33ab85WMbdk+hL2QUqm2Tlm
   lpg/KCzYf1Ec3q9bAmM5FAihF9c3ZAqof5K2na9qb+bzrXL5WZuXpnzNk
   yUg6GsVD3gw2xrtynFnsHP6TKhSOO6Yf0FzihhY1LoRjE4SGxXe5eOZ9s
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="199150505"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:02:55 +0800
IronPort-SDR: WOZLa+yD9ItrvKL6zsHhv+CLGZuDsc979PIszYyF81C8C9dW7XkpfC2TLqZbYzlNrC1J1ypFrm
 6bfAulVF8D4q6CQ5e+o64Dxqz70L3YN+9ztZcWmgEp8LF9lZmmh/yrslEnxYgXAPKHUYav9zy7
 V0Vj5gFiIgiQdp9/y1dsu92ncuoDJ5XRi3kBPCP/SdPhqVRHcQlKkXJRNpJPpYgiDBbbtq3DaK
 9dYCmfpZAYYB4or68AEk7+nl3rrKl1qrQYXjqdwz+40NkH1y40k190PPdFYS4t2G/wyFMdj608
 OoBib2Fn+hA+c/1OabaCUjar
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:33:13 -0700
IronPort-SDR: PZ6Jv5oNSUAUOloohaoTg3ymqUcUCvxg9ATSSQbS1YdlRAnsovkV72PQXin1kvT1HA1j1Aem3+
 TT/hms0OvOa6anf0OBnpDbKPiBgfKjneUFo2tIUofWKx0vzuetPwmHkPFeXw4blnsDOvxIOYVO
 clBCYEgpEOaAiAQ/52bmovGm9mnwlZ/V4EqQ0Kc2fEnonXDOhkn1jSroxKBK2gLkOc4nAN2x2T
 uSK34POXd3YIHJ1mwqKLbzoTNsDAcQeXg9UiUdn0tba/liuyQwm75pNxyDrz+9hz6DGsqrsX9J
 nX4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:02:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjLW15mPRz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 04:02:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650366173; x=1652958174; bh=W495Y2DRejlmTkUtNFbxkwW3U1dxuBLVQtP
        6TzceSjo=; b=j3qfwOUtxm3TiXUZPGLvrsPy30jk2+/yikTPC1zpK3uvcM1QS6V
        gW4diDyNVBmA3YS+MttnY29Ps0jiRP3dnCX868YzWGF9sCA8IY84c2umZl1DIqPG
        VkO5y7AO+R+xbMaLgqEA/fPQH5Nfg8a2ze22bVObCzEJsMVVBgfORGJrzFOXt118
        4SVk+QLSTZFM9fl/0bxL9kjPuVt98NSbA2Xr9s8uRIVdHXxoqdRJYJBMCmMRGf+u
        ywM4ijru2/RzcYUYp2WIWNmzpprGdw4c78OtJyc/BxP3ebsCKaM0rysDh/mcbnjs
        8njtxBl4ezkIXl0dJrAgw4/gz8GNon4pSAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0c_l25mZQ3HV for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 04:02:53 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjLW06HyTz1Rvlx;
        Tue, 19 Apr 2022 04:02:52 -0700 (PDT)
Message-ID: <58c3d966-358c-b7e1-e2a0-8425f783383c@opensource.wdc.com>
Date:   Tue, 19 Apr 2022 20:02:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 6/8] zonefs: Add active seq file accounting
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-7-damien.lemoal@opensource.wdc.com>
 <PH0PR04MB741681FE45A964154D2C4F359BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <PH0PR04MB741681FE45A964154D2C4F359BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/22 19:59, Johannes Thumshirn wrote:
> On 18/04/2022 03:12, Damien Le Moal wrote:
>> +/*
>> + * Manage the active zone count. Called with zi->i_truncate_mutex held.
>> + */
>> +static void zonefs_account_active(struct inode *inode)
>> +{
>> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
>> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>> +
> 
> Nit:	lockdep_assert_held(&zi->i_truncate_mutex);

If I add that, lockdep screams during mount as the inodes mutex is not
held when the zone inodes are initialized and zonefs_account_active()
called. We could add a wrapper function for this, but I did not feel it
was necessary.

> 
>> +	if (zi->i_ztype != ZONEFS_ZTYPE_SEQ)
>> +		return;
>> +
> 
> Otherwise,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


-- 
Damien Le Moal
Western Digital Research
