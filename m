Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2777B6397E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGIQhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGIQhr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:37:47 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13781208C4;
        Tue,  9 Jul 2019 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562690266;
        bh=pWkEe167WbQ442zTlFI4Y3F1p4RvsuiGLSHIBQKeshs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSyvIkqznH1WlovJsD6MlNU3vQ2Ji0uMayXarPnw61MDn+d/e4OSQ2ML34vrJRrUQ
         LbA04BEPvfWB1SiBzqsJupyaw+8nQhqI0P2XRYpJqVgNybheVpIhb9X30QPwgvV/IG
         M9a16F6dTB6YYhRxZrYqzfliKgEKI12jdC/OkYnk=
Date:   Tue, 9 Jul 2019 12:37:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com
Subject: Re: exfat filesystem
Message-ID: <20190709163744.GS10104@sasha-vm>
References: <21080.1562632662@turing-police>
 <20190709045020.GB23646@mit.edu>
 <20190709112136.GI32320@bombadil.infradead.org>
 <20190709153039.GA3200@mit.edu>
 <20190709154834.GJ32320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190709154834.GJ32320@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 08:48:34AM -0700, Matthew Wilcox wrote:
>On Tue, Jul 09, 2019 at 11:30:39AM -0400, Theodore Ts'o wrote:
>> On Tue, Jul 09, 2019 at 04:21:36AM -0700, Matthew Wilcox wrote:
>> > How does
>> > https://www.zdnet.com/article/microsoft-open-sources-its-entire-patent-portfolio/
>> > change your personal opinion?
>>
>> According to SFC's legal analysis, Microsoft joining the OIN doesn't
>> mean that the eXFAT patents are covered, unless *Microsoft*
>> contributes the code to the Linux usptream kernel.  That's because the
>> OIN is governed by the Linux System Definition, and until MS
>> contributes code which covered by the exFAT patents, it doesn't count.
>>
>> For more details:
>>
>> https://sfconservancy.org/blog/2018/oct/10/microsoft-oin-exfat/
>>
>> (This is not legal advice, and I am not a lawyer.)
>
>Interesting analysis.  It seems to me that the correct forms would be
>observed if someone suitably senior at Microsoft accepted the work from
>Valdis and submitted it with their sign-off.  KY, how about it?

Huh, that's really how this works? Let me talk with our lawyers to clear
this up.

Would this mean, hypothetically, that if MS has claims against the
kernel's scheduler for example, it can still assert them if no one from
MS touched the code? And then they lose that ability if a MS employee
adds a tiny fix in?

--
Thanks,
Sasha
