Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E616B992
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 07:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBYGS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 01:18:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYGS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Avrag3WHiJ0M+TIAj8catOsI408yOOvZ5zAOR+bpUmo=; b=q7is5W4PXOCXGjemBc3bRj3EW/
        8v89DYZsZFBx3f/mU3OmkTv9eEhvZEoVAWl8BFTNOrPkHBLOctbIG1SRSDIedkqWcwblyZEICNdbX
        QiabNU6GPESBisu1Uplq1d+0QQ8WnDJ7HPzaRs62XbdxblMlvFJ3evUCrXlh6f521O1m5hJ8jRw+y
        caWdL6ec8YtT1MW6KrPYJ5XSjJV0YdIFjwDhr0SVQKgJ6aUatusTKaBx1DVlBThh/R1vKX8tgtsj5
        JTDS5JmFN6DZudpzkHqWVpS4E2qb5DFvp1xFqybnDVtIPU2ROI9pEfKmuCFq8K1zEkim89L86UaST
        MVSpQrDQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6TYS-0004k4-LV; Tue, 25 Feb 2020 06:18:52 +0000
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
Message-ID: <fb37122d-c787-fb1f-10e6-a0795ef91b71@infradead.org>
Date:   Mon, 24 Feb 2020 22:18:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ba775044-c408-23d3-998d-38fd59d4face@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/20 10:16 PM, Randy Dunlap wrote:
> On 2/24/20 7:53 PM, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2020-02-24-19-53 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
> 
> (I don't see what patch is causing this)
> 

It appears to be related to BOOTCONFIG.

> 
> on i386:
> # CONFIG_BLK_DEV_INITRD is not set
> 
> 
> ld: init/main.o: in function `start_kernel':
> main.c:(.init.text+0x7c8): undefined reference to `initrd_end'
> ld: main.c:(.init.text+0x803): undefined reference to `initrd_start'
> 
> 
> Full randconfig file is attached.
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
