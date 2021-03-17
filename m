Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15333E61C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 02:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCQB2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 21:28:22 -0400
Received: from sandeen.net ([63.231.237.45]:57966 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhCQB2L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:28:11 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 6B6B348C691;
        Tue, 16 Mar 2021 20:27:34 -0500 (CDT)
To:     David Mozes <david.mozes@silk.us>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     "sandeen@redhat.com" <sandeen@redhat.com>
References: <AM6PR04MB5639492BE427FDA2E1A9F74BF16B9@AM6PR04MB5639.eurprd04.prod.outlook.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: fs: avoid softlockups in s_inodes iterators commit
Message-ID: <4c7da46e-283b-c1e3-132a-2d8d5d9b2cea@sandeen.net>
Date:   Tue, 16 Mar 2021 20:28:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB5639492BE427FDA2E1A9F74BF16B9@AM6PR04MB5639.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/16/21 3:56 PM, David Mozes wrote:
> Hi,
> Per Eric's request, I forward this discussion to the list first.
> My first answers are inside

ok, but you stripped out all of the other useful information like backtraces,
stack corruption, etc. You need to provide the evidence of the actual failure
for the list to see. Also ..

> -----Original Message-----
> From: Eric Sandeen <sandeen@redhat.com> 
> Sent: Tuesday, March 16, 2021 10:18 PM
> To: David Mozes <david.mozes@silk.us>
> Subject: Re: Mail from David.Mozes regarding fs: avoid softlockups in s_inodes iterators commit
> 
> On 3/16/21 3:02 PM, David Mozes wrote:
>> Hi Eric,
>>

...

> David > Not sure yet,  Will check.
>> 5.4.8 vanilla kernel it custom
> 
> Is it vanilla, or is it custom? 5.4.8 or 5.4.80?
> 
> David> 5.4.80 small custom as I mantion. 

what is a "small custom?" Can you reproduce it on an unmodified upstream kernel?

-Eric

