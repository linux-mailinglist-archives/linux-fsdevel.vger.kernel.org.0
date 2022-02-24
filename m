Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A894C242D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 07:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiBXGqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 01:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiBXGqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:46:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740C26A3A2;
        Wed, 23 Feb 2022 22:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5Nvi5N/h8QfPcwBE20KmmMMAuPRvtYOEhdDCUIz+bVY=; b=KOnwr/oj6KMEdAcxyzOz0NgHFi
        d5ZDg7ZlnAhgAtvw0tI17c/NsyZ5OdJev1+0srWAf7oK9kBUREkd5G/paIk48BeK/ILV2AFTZNzBP
        SO3TdB605qVQnMHvxsMblvYIMBlLm/rJhQgDh7b5f2ZH2IonYNfwXnW2soFH6DvilOBEt3TtLFR0F
        U16DQpn1hV2uBh2HYYkwmhjLQue/s6IA8Reo1ZyViRyOWcp31r5rTX/Nv2hLpvju2hPtS+9/BZtmY
        2Ut551AvT/29lAlDo0MrHyRL4p9hHNf0vOaBpHZrv7GtJZk/rm5l+ZPRYkDyjYvUpMlgkgg1etyNq
        DlX8ai4A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nN7sj-00CXJe-DE; Thu, 24 Feb 2022 06:45:41 +0000
Message-ID: <4820dc3e-6c4d-58f4-701a-784726f6c786@infradead.org>
Date:   Wed, 23 Feb 2022 22:45:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20220223014135.2764641-1-broonie@kernel.org>
 <5ef34a6f-c8ed-bb32-db24-050398c897a0@infradead.org>
 <EEADAF6A-04D6-42C8-9AAE-7D4EFB2FA507@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <EEADAF6A-04D6-42C8-9AAE-7D4EFB2FA507@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/23/22 07:58, Chuck Lever III wrote:
> 
>> On Feb 23, 2022, at 1:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/22/22 17:41, broonie@kernel.org wrote:
>>> Hi all,
>>>
>>> Note that today's -next does not include the akpm tree since it's been a
>>> long day and the conflicts seemed more than it was wise for me to
>>> attempt at this point.  I'll have another go tomorrow but no guarantees.
>>>
>>> Changes since 20220217:
>>
>> on x86_64:
>>
>> WARNING: unmet direct dependencies detected for NFSD_V2_ACL
>>  Depends on [n]: NETWORK_FILESYSTEMS [=y] && NFSD [=n]
>>  Selected by [y]:
>>  - NFSD_V3_ACL [=y] && NETWORK_FILESYSTEMS [=y]
> 
> Thanks, Randy. I think I've got it addressed in my for-next.

Hi Chuck,

I'm still seeing this in next-20220223...

-- 
~Randy
