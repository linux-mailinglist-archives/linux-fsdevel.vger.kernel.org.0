Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FD52CA05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 05:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiESDIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 23:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiESDIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 23:08:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE52D410B
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652929713; x=1684465713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJSBsvKlJE=;
  b=TL0K2fnuYvkbL2ct4iET4g0HNYu2ZHwXU9uLCcnoYv4a/k+QUPg6+FDE
   JEWLgL4BtPXlQXbwqWlbgII0a4WCFLOHaBubjBXl8tvvZHYGLdvkN6lUH
   zjG9lol1cg99WsVb+2oWGjQTipT4l0KjJfrjX42tW8g0e10ZqPPl2plSN
   EOq7j1v9SX8XlILpUTalTQXgc1aPLlmwbZBAf8dHEn3Zz1QuHbE62kLEL
   dj2PCFDonxsJdG59aOUH3sc2PT8PhZgg7oFImFdukI1D9DA5p/mXr8a03
   W2BsQEwnO1tgvnzYz9UxurISpRDM9F1R6SGS7zYINm46S96Jq/fxzPIq0
   g==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="199556796"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:08:32 +0800
IronPort-SDR: +Hm146F8WlqHnNgV/xIsPIskkkjmbRj9BN/DmBRzJZaDRXlUF2nLAgLz7qnVTVCYsDcWkIl6rP
 OWoYRNNWgoMyI+mCqXMW76nROaJYNElh2VgAHMBNieefH57d2Xto1lr/wBGwpEZHLg0Nrs3uB1
 QgLju4LUDbClJoL6ut4xwjmTC6fqfg6WCCvqNWJCcxAcM4nq4BAsW/JFxMuP+koavkzAq2IulR
 +TO6/vdZL9Bj2wILec3lVZz43sPyBxZSDKj8+XZxtra7jWTnMWEE2aanTWtL3vUGfyxe6B8RtU
 DPIyhDTa/o6+nw8DJpug+k9o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 19:31:34 -0700
IronPort-SDR: DjNITPQFMJId65LBydNvpBvpRQORQP6aJ/BIPobgQwh2A+WQfhgE8qtwLbjUUVxe/PMdmMqPaa
 DV0CHFzYzJpm8r7Wtys/K6F9f0KZYISG9R+iXHwyhhfJK9hSAb7KRxN+1Rq12kPLQJi54wW+hq
 XkJ9vnve/kvIpcwqWcqNfvJ5A8DA8we4HNqWyx8kfKJ8+h1FLG4c6akG0xM/JSioNULf3GJNOk
 ApJNr/ynzJGFnki6s7eIEZnU+C4PCwvMdQKXwfVqxuZN6QdHeXwb/MZFsQY9ymsY+6iQL60Afi
 uHk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 20:08:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZYq6W9Mz1SVp7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 20:08:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652929710; x=1655521711; bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJ
        SBsvKlJE=; b=Wz9R8/72j7o0/HjkO54/uNZ7vziwLqXBQOx2WZe1qEsSDBmqYAY
        oMOjpxPnGBnz+q+koTOKO3drn7FOj/jhxR0PTW1FJ7YLYdFtlYLeLGGN3yqvtwdr
        uts4LUP4ysOxN9iynlkWmhdkEs1tc1G3KNFA528x+jtAzYhfzX3F8jTjGnXp//sA
        rsE8C3oCVAzXP+CvDtHdo8BS4Oa1/JBePKnEcjfmBeFehBxoE9CWKq1Q/U6ExkMw
        hH5S6Kmi+EQY3sVzRRp11jv54IT+de7lJq7eYYN/WT35dSgh82O8SztxjP5NqAI5
        lf5E1L/acuF281Lj4heVeUrWlZG2K+SHppA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z5PsbOwPzkKM for <linux-fsdevel@vger.kernel.org>;
        Wed, 18 May 2022 20:08:30 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZYm2BJDz1Rvlc;
        Wed, 18 May 2022 20:08:28 -0700 (PDT)
Message-ID: <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
Date:   Thu, 19 May 2022 12:08:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoPAnj9ufkt5nh1G@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/22 00:34, Theodore Ts'o wrote:
> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>> I'm a little surprised about all this activity.
>>
>> I though the conclusion at LSF/MM was that for Linux itself there
>> is very little benefit in supporting this scheme.  It will massively
>> fragment the supported based of devices and applications, while only
>> having the benefit of supporting some Samsung legacy devices.
> 
> FWIW,
> 
> That wasn't my impression from that LSF/MM session, but once the
> videos become available, folks can decide for themselves.

There was no real discussion about zone size constraint on the zone
storage BoF. Many discussions happened in the hallway track though.

-- 
Damien Le Moal
Western Digital Research
