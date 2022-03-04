Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4744CDB49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 18:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbiCDRux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 12:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCDRuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:50:52 -0500
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 09:50:04 PST
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33501E1B56;
        Fri,  4 Mar 2022 09:50:04 -0800 (PST)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F2F3B3F631;
        Fri,  4 Mar 2022 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646415791;
        bh=WxSWF1u2NPQKV+mi5AwufCkMafXQxphZH+krw9eVlJg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iOZQpLU2Kog2FFFczm/WOXK3VGs2BHDCCJ7Jx1rXTZRSnHpYhh0qHZxR8ADLHWS/x
         sn6yq8n3cKQj0kpJ4mMqowvWl2hfqroGWZs204Be6okedQpp8nAjRxYQS0UEoxjhOp
         RKxWUEMbyMYEgse21OGfxxdOmHDsAR3SeC2q6dG0XhqvXnYQs5oCsgIfSjJApcfx8n
         pGLgEV6vNE8Y14w/sITMeNYOTcPnNuQvylzuwdeP3R9BzRtJLON/IaX+vQA2+Pbu17
         gbicBOBLcuk0L9HYqjL5Ei0HIuh9Jhe2hP1vbo5VpfHKcJ/nKdQRoqy9cp4GFlz6HD
         i270LoNHFlsNg==
Message-ID: <0ea7559b-8e9f-5c85-87eb-0bcf5fddef10@canonical.com>
Date:   Fri, 4 Mar 2022 09:42:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: mmotm 2022-03-03-21-24 uploaded
 (security/apparmor/policy_unpack.o)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Cc:     apparmor@lists.ubuntu.com
References: <20220304052444.C157EC340E9@smtp.kernel.org>
 <217ec524-7ade-7e1f-b81a-4a9a3ff90397@infradead.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <217ec524-7ade-7e1f-b81a-4a9a3ff90397@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/22 09:32, Randy Dunlap wrote:
> 
> 
> On 3/3/22 21:24, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2022-03-03-21-24 has been uploaded to
>>
>>    https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
> 
> on x86_64:
> 
> ld: security/apparmor/policy_unpack.o: in function `deflate_compress':
> mmotm-2022-0303-2124/X64/../security/apparmor/policy_unpack.c:1069: undefined reference to `zlib_deflate_workspacesize'
> ld: mmotm-2022-0303-2124/X64/../security/apparmor/policy_unpack.c:1075: undefined reference to `zlib_deflateInit2'
> ld: mmotm-2022-0303-2124/X64/../security/apparmor/policy_unpack.c:1092: undefined reference to `zlib_deflate'
> ld: mmotm-2022-0303-2124/X64/../security/apparmor/policy_unpack.c:1122: undefined reference to `zlib_deflateEnd'
> 
> 
> 
> Full randconfig file is attached.
> 

yes thanks for the report,

the fix is already baking in apparmor-next
c2489617b3b9 apparmor: Fix undefined reference to `zlib_deflate_workspacesize'

this happens when CONFIG_SECURITY_APPARMOR_EXPORT_BINARY is not set and hence ZLIB_INFLATE/DEFLATE aren't selected and the kernel is configed without them. Basically some blocks of code need to be wrapped in #ifdef.
