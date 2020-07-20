Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E8226BC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbgGTQoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:44:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58650 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbgGTQoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:44:02 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 67F2E20B4909;
        Mon, 20 Jul 2020 09:44:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67F2E20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595263441;
        bh=nVS7jCr7TtH0s+xECHlFLv3RxB/Jg83Xyq+HejB+z+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mt+5ZjgXoD9wsbbmtci8gB4Spuw5ucQOlhg9/T2qOK/crXVa/KtdfGLxdaGaP7gkv
         L2MayJCd55GAsv3Ar/xQZ1dkZaw3EeoNvbBBEDHlJZ5IwEfc6dOEy+oFYBVDI4vTaz
         zbOxCEK2VWZ3x2BUxWszSo1csdFfG+xB5+f70u+A=
Subject: Re: [RFC PATCH v4 02/12] security: add ipe lsm evaluation loop and
 audit system
To:     Randy Dunlap <rdunlap@infradead.org>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, eparis@redhat.com, jannh@google.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatshin@soleen.com
References: <20200717230941.1190744-1-deven.desai@linux.microsoft.com>
 <20200717230941.1190744-3-deven.desai@linux.microsoft.com>
 <4b0c9925-d163-46a2-bbcb-74deb7446540@infradead.org>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <f7cda924-a14d-35bf-7c00-f12e2be9844c@linux.microsoft.com>
Date:   Mon, 20 Jul 2020 09:44:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b0c9925-d163-46a2-bbcb-74deb7446540@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/17/2020 4:16 PM, Randy Dunlap wrote:
> On 7/17/20 4:09 PM, Deven Bowers wrote:
>> +config SECURITY_IPE_PERMISSIVE_SWITCH
>> +	bool "Enable the ability to switch IPE to permissive mode"
>> +	default y
>> +	help
>> +	  This option enables two ways of switching IPE to permissive mode,
>> +	  a sysctl (if enabled), `ipe.enforce`, or a kernel command line
>> +	  parameter, `ipe.enforce`. If either of these are set to 0, files
> 
> 	                                               is set

Thanks, I'll change it in the next iteration.

> 
>> +	  will be subject to IPE's policy, audit messages will be logged, but
>> +	  the policy will not be enforced.
>> +
>> +	  If unsure, answer Y.
> 
> 
