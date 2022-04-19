Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BF506A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 13:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbiDSL31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiDSL30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:29:26 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E624F33
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650367604; x=1681903604;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=bv1tQez+k/eBrpPJulhybP0533RPoK0vWJlDE9Azgc8=;
  b=K8ikVA8GfaojtbJ3r3sEX85g4hE4fvO2tXATDENyJ1r+DR+QftCsFq6K
   yXQMGNHARJVMKzzEPB+Yjft85IbOnF1ZCSLmG7nOumgjEOmx4zrOmFW55
   +5TSEacApdPtdQhKSkSjzpqpi68Utr+Y0cJacbME9N/1G4/TjTdOpdrSn
   RjQtQW1sr3cNbR4ORvJGmGO4LAOtEGMuxL6TepSkpiu/sP3H+hsjgAkKo
   VFGelv0eIZq2BVvSzND1opP5cuJbv+oSLFfIR0hi52TjXC/U6AiiGjAst
   mXXD96KJGUyBVPPbkoKL9K7WVvjJwFUe0uqJIl7QzHLKVDxkxHfpWD7AK
   A==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="199151949"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:26:44 +0800
IronPort-SDR: qruNXlo6K0DsfcWJ6JjDc/eK+EAMaw2Zwc7kYf1MZnRujDiyGz7Vri+NqMSOPy9ZdkrVgvNj91
 /rAVOVB5QsaIwrGjCUJ3fKDtGVc8SKRsJAcTuGrUpsCyPB5feLVQrl7jt/u2s2GZF3ORl4EaRU
 mIgi5chT6+8UE0+FJMtBLQrHAZWVxwN3lxjI+YUJ0P9PJM4pbsYHYJs/0o5xbVEQ6QHu5rTskR
 aJqlaz7zvBUAaiH9tpZ+bnAJiZ7VuLi+X9hFoeabXvHtDK1xvOra1jQEXbOhfNce9xa80tO7ps
 0UMsAdR4LBZbSu0l2eLBJDcb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:57:03 -0700
IronPort-SDR: fmsEML3nzYiqcbPQfR5R4oWcg5TfIM0UhTz8yVGYcx6ZY3TiLy1MwjyzesGrHSoCNT1EJd7LsR
 VnuZI8mdvI1pVfARDSfBCg1qZQCWAialczI7aGxPToADLuSD4xbqF+Hjd6AjNJiRoKz/L2y3pD
 8REFs6WUSMfJSLjqD0Nx5VUzzwfZjcn92NJNfz//8rtBCaUb2HlLkjFvQ8Z+MeKdCZHS8m7cUk
 cIzqPODhv2V5L/9yPXAdTEwCufeJFeQxWxNRWu6evoLRXLQTSqEiphoDbKmTzi6yP1k0oRsJnq
 dlM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:26:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjM2W3Ypvz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 04:26:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650367603; x=1652959604; bh=bv1tQez+k/eBrpPJulhybP0533RPoK0vWJl
        DE9Azgc8=; b=Pv9Kdchyz5LswGcCaqPejq1iOxoperpJPkciW8nVRdNG7veIpUK
        +J19ZjIsjhTrODhqrmohrsnXaW3SkGSJIOFKQfFllaJNWOa1vRlSpZRR8pWsAq7S
        Jm5CVCK02JsMT+99DH9DKCBIBfvFf3FZEypgD12lxgBZeBH6H+SmtEg9XdA4kh2J
        d8St9YSaUR2Uft64rw5etw/YTsaVg3EL12yHiwuQhjailgwvXMeHR3sGOht9SbpQ
        fJc9fosYdDfRTZkpagfJYUUWC8lPYh7Sn9CwR/uunELYWEFPB48mNKttDIc2GTlL
        TS+GHs19Zsy+oRU60CeTBm7fPCMflcm0TMw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1kan07IBqJDj for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 04:26:43 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjM2V4Rh2z1Rvlx;
        Tue, 19 Apr 2022 04:26:42 -0700 (PDT)
Message-ID: <38720285-3f18-dcee-fcee-f2c223b1d52a@opensource.wdc.com>
Date:   Tue, 19 Apr 2022 20:26:41 +0900
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
 <58c3d966-358c-b7e1-e2a0-8425f783383c@opensource.wdc.com>
 <PH0PR04MB741645F790D210401E2CD2EB9BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <PH0PR04MB741645F790D210401E2CD2EB9BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On 4/19/22 20:06, Johannes Thumshirn wrote:
> On 19/04/2022 13:03, Damien Le Moal wrote:
>> On 4/19/22 19:59, Johannes Thumshirn wrote:
>>> On 18/04/2022 03:12, Damien Le Moal wrote:
>>>> +/*
>>>> + * Manage the active zone count. Called with zi->i_truncate_mutex held.
>>>> + */
>>>> +static void zonefs_account_active(struct inode *inode)
>>>> +{
>>>> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
>>>> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>>>> +
>>>
>>> Nit:	lockdep_assert_held(&zi->i_truncate_mutex);
>>
>> If I add that, lockdep screams during mount as the inodes mutex is not
>> held when the zone inodes are initialized and zonefs_account_active()
>> called. We could add a wrapper function for this, but I did not feel it
>> was necessary.
> 
> OK, but then the 'Called with zi->i_truncate_mutex held.' comment is invalid
> and should be removed.

Not invalid. When mounting, nobody but the mount process can touch inodes,
so not holding the mutex is OK.

Will see how to clean this up.


-- 
Damien Le Moal
Western Digital Research
