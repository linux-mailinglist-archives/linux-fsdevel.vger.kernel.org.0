Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C239F16B999
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 07:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgBYGV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 01:21:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBYGV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=4iYPOTp2LZ1qIzMj4QQw8cQncxOOfZ4aN2TcrdSKwNU=; b=U7O9xh0p50CZcLpe6IkVglT4y7
        CXTs2/Or/AlPTvsZXEVAg9mZJIX7NrIHsjuCDFszKGvphtM8OiTDv1vIPxyPGIhzJOH+SkuyXC4kr
        Z5IJKIoiuVK90MXmvcn0NKCtG+CBiczhRwivuIycD4SPDElBzdt64fT8Uu7MepAvupQEWOmvU7785
        X4MyAaosxybvjMD+nHIxKdI9Hx08CwXR9OMMYZB3l5OP3vhEirsbmwkDhC5MfVEF08/G+QgKS3Taz
        U/os5C2cGzPE3hZwSgT0MehKj0Uwp9rtPLIDT9OGxP10NJfW9/gb+uQ3fij3+ulXXpaeQbb1vbQZg
        gcSTfE3A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Tat-00062D-Hw; Tue, 25 Feb 2020 06:21:23 +0000
Subject: Re: mmotm 2020-02-24-19-53 uploaded (init/main.c: initrd*)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200225035348.xf9KRK471%akpm@linux-foundation.org>
 <ba775044-c408-23d3-998d-38fd59d4face@infradead.org>
 <fb37122d-c787-fb1f-10e6-a0795ef91b71@infradead.org>
Message-ID: <3f5ec5dd-8388-13b9-3f22-43505922c561@infradead.org>
Date:   Mon, 24 Feb 2020 22:21:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fb37122d-c787-fb1f-10e6-a0795ef91b71@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/20 10:18 PM, Randy Dunlap wrote:
> On 2/24/20 10:16 PM, Randy Dunlap wrote:
>> On 2/24/20 7:53 PM, Andrew Morton wrote:
>>> The mm-of-the-moment snapshot 2020-02-24-19-53 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>
>> (I don't see what patch is causing this)
>>
> 
> It appears to be related to BOOTCONFIG.
> 

Argh.  My bad.  This build error happens in linux-next-20200225, not mmotm.


>>
>> on i386:
>> # CONFIG_BLK_DEV_INITRD is not set
>>
>>
>> ld: init/main.o: in function `start_kernel':
>> main.c:(.init.text+0x7c8): undefined reference to `initrd_end'
>> ld: main.c:(.init.text+0x803): undefined reference to `initrd_start'
>>
>>
>> Full randconfig file is attached.
>>
> 
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
