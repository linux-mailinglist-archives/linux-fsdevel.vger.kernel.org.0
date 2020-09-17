Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E1F26E053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgIQQJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 12:09:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgIQP7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:59:49 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0C12120B7178;
        Thu, 17 Sep 2020 08:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C12120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600358241;
        bh=gUfIqFqpkrN0miyEH74CDfja3bpQECkvCujVL/Nljqg=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Bap21mAvyeJKL22S4sguYInURgSgiXufpOk5kqSzqijlzRcX3iHUIe82IA0u8e5iF
         HUp6Jh7UtZquNUVfdaJKc5R07sTADe2RHBpUNCP9wEbiLC2OnHb/EKxDlG4YI6Xwcj
         FLLh69Sze7efG1K6kw3QGbPypJvP6/2ulwQipahs=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
Message-ID: <d96b87ed-9869-c732-9938-a1c717a065f3@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 10:57:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/17/20 10:36 AM, Madhavan T. Venkataraman wrote:
>>> libffi
>>> ======
>>>
>>> I have implemented my solution for libffi and provided the changes for
>>> X86 and ARM, 32-bit and 64-bit. Here is the reference patch:
>>>
>>> http://linux.microsoft.com/~madvenka/libffi/libffi.v2.txt
>> The URL does not appear to work, I get a 403 error.
> I apologize for that. That site is supposed to be accessible publicly.
> I will contact the administrator and get this resolved.
> 
> Sorry for the annoyance.
> 

Could you try the link again and confirm that you can access it?
Again, sorry for the trouble.

Madhavan
