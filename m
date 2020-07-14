Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82A21E7DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 08:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNGG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 02:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNGG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:06:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC2C061755;
        Mon, 13 Jul 2020 23:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UIXDCXwJB/3NeMqMWfWT3V3jqZ15kLhlWyDghMyaIz0=; b=JMzCTAEtA44frARh4Fspuz2L0T
        LccTR8Ea95W2ZujXKz28LnB2wK0cgNkGXSUFT+Az8bsG2vQ9Zjqg7OYeQLqmOwvmWWBjz6rO2Nwfy
        7mNzELT3rwdoF6BY1R/7GzwAbyetPecUoa9kHiE35jnSfpPERVE8o08NA4wsj8ZSPFWf6D1kZUl19
        r/DYvFiIqkHF4SaCtikLURLQEdcarDG51WagosW6HLAaFh9c4S+cdvdrGkyUT9w0D2oNPE04B0e4a
        6u2Ccqd8TuhQJ9gBXv4ofE+r6nQn7/Ut0AmgNirCcA0Hd4YWNa1Q5e9JM4J1cBcsvYORWE18JLITP
        MD5J27Uw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvE56-0003wr-27; Tue, 14 Jul 2020 06:06:20 +0000
Subject: Re: procfs VmFlags table missing from online docs
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <8abafee9-e34b-45f6-19a7-3f043ceb5537@alliedtelesis.co.nz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ee41c18-934e-26c2-a875-3d9e4c700c6c@infradead.org>
Date:   Mon, 13 Jul 2020 23:06:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8abafee9-e34b-45f6-19a7-3f043ceb5537@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/20 10:11 PM, Chris Packham wrote:
> Hi,
> 
> I was just browsing 
> https://www.kernel.org/doc/html/latest/filesystems/proc.html
> 
> The "VmFlags" description seems to be missing a table. It's there in 
> Documentation/filesystems/proc.rst so I assume it's some sphinx/rst 
> problem. Possibly the table is over indented?

Wow. It skips the table completely.

I tried a couple of things that did not help.

> Anyway I thought I'd let someone know.

Thanks.

> Regards,
> Chris


-- 
~Randy

