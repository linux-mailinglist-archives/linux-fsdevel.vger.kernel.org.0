Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D044B5EC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 01:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiBOAH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 19:07:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBOAH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:07:28 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B897B9A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 16:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644883638; x=1676419638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=no1vTKpzUgCwKxOTRf2OpHRqjB4QlJaghxZ9PHaSUIc=;
  b=qLBSBsoDD68/MqkCvUG3P0tboYiMgNZANTeVW3QeaItWoEfgkFKx/2MK
   8I4VT+6k/MH++pYyfUXpDK6EiXT3IloKq6CWZJ6Uf3HX/tY3ptF2ollq7
   XwtRcnE5sEWSOw5s/STc/rlctQlQ7iuehCrg3tg+wbLumRpweASmSzi1g
   lbc3f16dcw2yVBi6Yl60uVtAHuE+6zdYQg2PP8MBvFE7gRbzhJ0AvGIfM
   U+3rcsIrf7ss/aak2Nt080A9up4uJd5Hi1UkgVVLsuG6q6kaatoTkZ/nG
   JOUVIXPkgZhJTKScb72NybPaTCnxKrVg64XFo6pwuEzSP8yToK/k4G0GG
   A==;
X-IronPort-AV: E=Sophos;i="5.88,368,1635177600"; 
   d="scan'208";a="297009703"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 08:07:18 +0800
IronPort-SDR: VxoyPRYlS2qj4l9/pKnFqhUAOZ1v8wz8cRkBgrqABrdTstze/jS+JK0uRacb6YtZcxltwoOSCS
 ipAknGr6e8O0oU2z4skolvxPeYGEDAiXMSrpjopPgs5tyD+ssSFMcog725s/6inL1pZxhMdrT/
 n1fVREY2Nr4TvfXXUNfGoGXxoXx1u68W39ZACQBqlvNdbpdCs1W3CNyWxUI0pLLV7Ip2oOtPUO
 GtJGW1yC0E5Hix/wY5iEXwovAIL8rZwW2OyAffomfwiwmHiwcnTb7uYQTd1D25/AjX+QDPcxBo
 iHA9ObrugZQ8JCJ/NR/Ft6nn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:38:59 -0800
IronPort-SDR: G2k1vJaLArt8nRC9FBum4HdA18xJ4aCwVEDzNlTakFLLf4v3z642cS25jXjGOWAf93NCS5Zmww
 TKl2Y4tNzN1Kqt/7X3etx74Jrt++0xhd3oanadfep1HGwM5qz+/+wW0rfFwbbmaq/7cbepvXr+
 yt4wjiecVNGKd8sgo3Y2dQpD4yOBbfXmzp2t4g3YQzppRnuybC/F2C0NPL1lR3qWWQxJDNu0lI
 LQ+uFYFXN7vttJjyM04qx0sysQsk6UDlXT1c8Xtx15vL7fZXJE9NTBb82mfTzFy31Qq6Bd3yt/
 kg8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:07:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JyLxd6WB8z1SVp0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 16:07:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644883637; x=1647475638; bh=no1vTKpzUgCwKxOTRf2OpHRqjB4QlJaghxZ
        9PHaSUIc=; b=k3CXZgKpRZEtWRHs1pIKLyD/9luafP6XxEzFJXkYGRwm8brySSG
        11JAiynNIzbowVgMusFwVj2RB/xfmdEymqtYsmZzQVvb7Jwv1WasOnQig3uTnSOB
        0t2EFTFL+5zxil/JSbBKTG8WfX8t5wkTDTFgf1kgcUCWuxdirlq/QX7Bv9VD7ohS
        r0UKzCJL0WjNmRSOD4DQD3FRHvh2NHb6CABabqPAwn5P173S9laOmBi8LotgPu3p
        bCyFdhPcbtfkDEZwCL8t5sa9u+2oyO0ap30zWIhUXPZ1kmAj2fNWJLwCwrr/gQ1q
        V2rOWx/iY1OVwiTvpEcMUihO28/49BKGRew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SHBbxovHQG7B for <linux-fsdevel@vger.kernel.org>;
        Mon, 14 Feb 2022 16:07:17 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JyLxc1NGBz1Rwrw;
        Mon, 14 Feb 2022 16:07:15 -0800 (PST)
Message-ID: <c2366bd1-6478-554c-14c0-36c58928aa83@opensource.wdc.com>
Date:   Tue, 15 Feb 2022 09:07:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] fs: add asserting functions for
 sb_start_{write,pagefault,intwrite}
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <cover.1644469146.git.naohiro.aota@wdc.com>
 <40cbbef14229eaa34df0cdc576f02a1bd4ba6809.1644469146.git.naohiro.aota@wdc.com>
 <20220214213531.GA2872883@dread.disaster.area>
 <159d58f4-2585-7edf-7849-1a21b8b326f9@opensource.wdc.com>
 <20220215000515.GC2872883@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220215000515.GC2872883@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/22 09:05, Dave Chinner wrote:
> On Tue, Feb 15, 2022 at 07:49:27AM +0900, Damien Le Moal wrote:
>> On 2/15/22 06:35, Dave Chinner wrote:
>>> On Thu, Feb 10, 2022 at 02:59:04PM +0900, Naohiro Aota wrote:
>>>> Add an assert function sb_assert_write_started() to check if
>>>> sb_start_write() is properly called. It is used in the next commit.
>>>>
>>>> Also, add the assert functions for sb_start_pagefault() and
>>>> sb_start_intwrite().
>>>>
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>> ---
>>>>  include/linux/fs.h | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index bbf812ce89a8..5d5dc9a276d9 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1820,6 +1820,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>>>>  #define __sb_writers_release(sb, lev)	\
>>>>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>>>>  
>>>> +static inline void __sb_assert_write_started(struct super_block *sb, int level)
>>>> +{
>>>> +	lockdep_assert_held_read(sb->s_writers.rw_sem + level - 1);
>>>> +}
>>>> +
>>>
>>> So this isn't an assert, it's a WARN_ON(). Asserts stop execution
>>> (i.e. kill the task) rather than just issue a warning, so let's not
>>> name a function that issues a warning "assert"...
>>>
>>> Hence I'd much rather see this implemented as:
>>>
>>> static inline bool __sb_write_held(struct super_block *sb, int level)
>>> {
>>> 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
>>> }
>>
>> Since this would be true when called in between __sb_start_write() and
>> __sb_end_write(), what about calling it __sb_write_started() ? That
>> disconnects from the fact that the implementation uses a sem.
> 
> Makes no difference to me; I initially was going to suggest
> *_inprogress() but that seemed a bit verbose. We don't need to
> bikeshed this to death - all I want is it to be a check that can be
> used for generic purposes rather than being an explicit assert.

agree.

> 
> Cheers,
> 
> Dave.


-- 
Damien Le Moal
Western Digital Research
