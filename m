Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F70D1701
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfJIRpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 13:45:45 -0400
Received: from mout02.posteo.de ([185.67.36.66]:43923 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbfJIRpp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:45:45 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 98ED82400FC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 19:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570643142; bh=+uRbnUgYwcwwURmsSaZ0MP0p0roiK0PTgjhoSU3rLOE=;
        h=Subject:To:Cc:From:Date:From;
        b=kZFfrumak9gujpYsfe9XtPIjfJAmNJDKEHDvD3hyW1QLzGKkrnrrgGrfRbGLDWnk4
         W/ptXMm+y9C4TdPSpaMWg9uc71+0lXBQ2VeRerWy7ZdDO5PmPWJ71nJ0UDSKAGMifn
         uaU0fJb2zZRqidcdb3H0xAG92q4Utq4a/ajgCOXbzls5FSHJskCxvqMx6EBoyBhJMX
         fzHcrTpuGmtPXfBjKu7hoXFFIY4NV5auypvPar9BpO9X4KbJF6/I6nB3ZtSNxfUUem
         04xPtegvFVgLJh4wfVcmwRsQine8jDCMrZ0VzBwk+rFWm+aLchdJU+54DUp4VlQyWL
         P3GnTgG0NwhmQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pM7l64mpz9rxM;
        Wed,  9 Oct 2019 19:45:39 +0200 (CEST)
Subject: Re: [PATCH 3/6] Check that the new path while moving a file is not
 too long
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
 <20191009133157.14028-4-philipp.ammann@posteo.de>
 <20191009150034.GA31739@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Philipp Ammann <philipp.ammann@posteo.de>
Message-ID: <99efdcb3-c5dc-bb2b-647b-9e27c3c59f4c@posteo.de>
Date:   Wed, 9 Oct 2019 19:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009150034.GA31739@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 09.10.19 um 17:25 schrieb Gao Xiang:
> Maybe sort out what original problem here is better and
> not blindly get patches from random github repos...

That's kinda hard to do given that Samsung doesn't provide a history of 
the code...and my lack of knowledge of FS drivers ;-)
I just posted Bugfixes that probably originated from Samsung and somehow 
haven't made it in the initial mainline exfat commit.

Do you know where the code originally came from?

Regards
Philipp

> 
> Thanks,
> Gao Xiang
> 
>>   	ret = resolve_path(new_parent_inode, new_path, &newdir, &uni_name);
>>   	if (ret)
>>   		goto out2;
>> -- 
>> 2.21.0
>>
> 
