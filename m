Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5C26E036
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 18:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgIQQDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 12:03:47 -0400
Received: from albireo.enyo.de ([37.24.231.21]:53170 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgIQQDH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:03:07 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kIwLq-0001jb-Tk; Thu, 17 Sep 2020 16:01:38 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kIwLq-0006JJ-P8; Thu, 17 Sep 2020 18:01:38 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
        <87v9gdz01h.fsf@mid.deneb.enyo.de>
        <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
        <d96b87ed-9869-c732-9938-a1c717a065f3@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 18:01:38 +0200
In-Reply-To: <d96b87ed-9869-c732-9938-a1c717a065f3@linux.microsoft.com>
        (Madhavan T. Venkataraman's message of "Thu, 17 Sep 2020 10:57:20
        -0500")
Message-ID: <87y2l8xuhp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Madhavan T. Venkataraman:

> On 9/17/20 10:36 AM, Madhavan T. Venkataraman wrote:
>>>> libffi
>>>> ======
>>>>
>>>> I have implemented my solution for libffi and provided the changes for
>>>> X86 and ARM, 32-bit and 64-bit. Here is the reference patch:
>>>>
>>>> http://linux.microsoft.com/~madvenka/libffi/libffi.v2.txt
>>> The URL does not appear to work, I get a 403 error.
>> I apologize for that. That site is supposed to be accessible publicly.
>> I will contact the administrator and get this resolved.
>> 
>> Sorry for the annoyance.

> Could you try the link again and confirm that you can access it?
> Again, sorry for the trouble.

Yes, it works now.  Thanks for having it fixed.
