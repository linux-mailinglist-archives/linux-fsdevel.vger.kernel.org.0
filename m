Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78523344C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgG3OZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:25:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50298 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgG3OZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:25:36 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6E69220B4908;
        Thu, 30 Jul 2020 07:25:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E69220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596119136;
        bh=iQD4oMx1vXbV5tj3ST9M8eMgC4Qkots35Kpu1EaisYA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hKwd9y4uik37h5AXO9wYYs/IAI7QSFqMmQrGXxVcsc7Zj8tY598SJwC87D8DnDzCT
         oNB/IY35bqDRkvJr9zK4x/HZCTMj9yJelgItkU+vGout2ADwPWSIJ5OvDqFtemhKEt
         ZIQoOyX9muMMkl7kDsT0vI3YDhumgFIjTlZDd61s=
Subject: Re: [PATCH v1 2/4] [RFC] x86/trampfd: Provide support for the
 trampoline file descriptor
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200728131050.24443-3-madvenka@linux.microsoft.com>
 <20200730090612.GA900546@kroah.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <f8a8c7b9-43b9-35de-343d-a1deeee2b769@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 09:25:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730090612.GA900546@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yes. I will fix this.

Thanks.

Madhavan

On 7/30/20 4:06 AM, Greg KH wrote:
> On Tue, Jul 28, 2020 at 08:10:48AM -0500, madvenka@linux.microsoft.com wrote:
>> +EXPORT_SYMBOL_GPL(trampfd_valid_regs);
> Why are all of these exported?  I don't see a module user in this
> series, or did I miss it somehow?
>
> EXPORT_SYMBOL* is only needed for symbols to be used by modules, not by
> code that is built into the kernel.
>
> thanks,
>
> greg k-h

