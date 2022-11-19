Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3923E6308F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKSB6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiKSB5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:57:50 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B979932
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668822529; x=1700358529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=17+mM9jMghIogLXFADG+Y1Yb7zdB+kxoFDNSvjLGhyw=;
  b=HygaQHMZXSZzzsW+prI/UUpTFT+NphgFF46o8CQAHRhBD/pFkoRE1wNI
   JAi9dD3aQIp+MX4iS/nruyIDwDtl7QwKXvfMEvgmCEyjK6dq1W4JIHe9n
   wFLUSlOWLP4DAYYmSYdL8arLUEyskaMdltHFw2kR7cgNjGYq+Rb4flRgB
   jXxylJc4qT0Os2ha/yDq7hnyKav5CmNgsU++Q5F1rKBR2SO6R9KfIEI3B
   BB4ImcmOk4Nc73yvQVyGuX1dF6LEF6+0mcPco7I6C2cc/SDrG5T1OyTnz
   nPhE/+pSY3UJICESfYR/ru6c3YHpO3owqAAj+E96g3mnulvO9Ofkd1iFK
   w==;
X-IronPort-AV: E=Sophos;i="5.96,175,1665417600"; 
   d="scan'208";a="328753532"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2022 09:48:49 +0800
IronPort-SDR: WwFs26MHoMYaTPyzNrS5aGb6Kmn3jfgnHDIAwPQMmYEaQpCv2qqlEfCyeVzBlbp8cdZdBH3mC7
 G8vchFyUJ+9+0xK6SgtUhuedF473SODZvlcvTXZ+/L5LAWjcFv52iiXtThwQlj/a1LKxeKe0q+
 259CcWhJH5FJhSw5BvqTmBOH1/gMvMvowmp3cAtiLtL/7Ab/8uHDxkOLJxFWUEFNWVU1zKrqge
 H9+cmAx0oHbWDYea+ObvSBbAWhyKXfElbVQkm/VDjYmy5CHO7En/caE7VJ6nbd7XAno3L64jP6
 Bpc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 17:01:57 -0800
IronPort-SDR: 303t96eYkqeWrrijfk7kotqTLG3F2KLODDY4drs7Ll2LUhDT+hYHPUk+o2sEgAyYvGnGqoEcsv
 zJqSlgj0nfuM86E1EjBfJtR7E8wMgTkdUzw6g9bJbhC6p1yuANo3F5Tq2Lfmb9omh6ORcxtPtQ
 HAybMYEXIZuG/IB65SixeEKlGraM8zxinDt3O7HlDjIL9nyH6vRxRy2d37QZB5PCdMHqdkHwMF
 VvxrA0GyidAL0gyccRQo1zCifAkyBsvmdy7KabiyTG/PMs78Qc49JSQy22cZKF6sMZHizYVK9z
 C7U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 17:48:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NDc4w2wScz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:48:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668822528; x=1671414529; bh=17+mM9jMghIogLXFADG+Y1Yb7zdB+kxoFDN
        SvjLGhyw=; b=oypBeGxAyNnDZbJqMa7o51xjIUsdbTu43DXs4H21bnVQ2XgSEHf
        ZsjthnOxct57ssvRaudBmE5wq+p1Cvui43CaOodh+M8SwiNrN9ZO+fVPo7VteJ/h
        slv9fqyHvTOJqXE/2Noa8R6nFbBBz84dNpjBjyRUllDuYpOX5SEpWePvpoghQ0e0
        LrgoMZM7UdcElRDb/cHaD+3V0FBFhGQiEy82oaAyHZ1Mpi1ewXn5qRK4tPfeBu84
        K53RBMrgpbzAa4rF0i4y+i1oEY0SF8xDaY8CeCf/0fgBwg5QjT/cCtsu1pNEcsv4
        +QMnMwQYpx/460JbMfnmouDogoE+mvC4jZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jfdCqsroZGNa for <linux-fsdevel@vger.kernel.org>;
        Fri, 18 Nov 2022 17:48:48 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NDc4v5Mqlz1RvLy;
        Fri, 18 Nov 2022 17:48:47 -0800 (PST)
Message-ID: <f66fadb2-335e-b9d2-5df8-6178692bab5d@opensource.wdc.com>
Date:   Sat, 19 Nov 2022 10:48:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] zonefs fixes for 6.1-rc6
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
References: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wiUq50yc7MavtZXcFiv9VxW9YyJDMB2ht1sHnDBieVB5w@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wiUq50yc7MavtZXcFiv9VxW9YyJDMB2ht1sHnDBieVB5w@mail.gmail.com>
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

On 11/19/22 10:38, Linus Torvalds wrote:
> On Fri, Nov 18, 2022 at 5:09 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> zonefs fixes for 6.1-rc6
> 
> Hmm. I'm not sure why this one didn't get flagged by pr-tracker-bot.
> 
> It does seem like it never made it to lore (your pull request also
> doesn't seem to show up in the web interface), which is probably
> related.
> 
> Maybe it's just some random delay and you'll get the automated
> response in a few hours, but here's the manual one...

Thanks. It looks like it was some random delay. I can see it in lore now.

> 
>               Linus

-- 
Damien Le Moal
Western Digital Research

