Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBD214257
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 02:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGDASv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 20:18:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59867 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgGDASv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:18:51 -0400
Received: from host86-157-102-29.range86-157.btcentralplus.com ([86.157.102.29] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jrVtJ-0009yP-AV; Sat, 04 Jul 2020 01:18:49 +0100
Subject: Re: [PATCH 09/16] initrd: remove the BLKFLSBUF call in handle_initrd
To:     "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Cc:     Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200615125323.930983-1-hch@lst.de>
 <20200615125323.930983-10-hch@lst.de>
 <514b0176-d235-f640-b278-9a7d49af356f@zytor.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <e60b1977-2e1d-75ee-e934-207658145098@youngman.org.uk>
Date:   Sat, 4 Jul 2020 01:18:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <514b0176-d235-f640-b278-9a7d49af356f@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/07/2020 04:40, H. Peter Anvin wrote:
> On 2020-06-15 05:53, Christoph Hellwig wrote:
>> BLKFLSBUF used to be overloaded for the ramdisk driver to free the whole
>> ramdisk, which was completely different behavior compared to all other
>> drivers.  But this magic overload got removed in commit ff26956875c2
>> ("brd: remove support for BLKFLSBUF"), so this call is entirely
>> pointless now.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Does *anyone* use initrd as opposed to initramfs anymore? It would seem
> like a good candidate for deprecation/removal.
> 
Reading the gentoo mailing list, it seems there's a fair few people who 
don't use initramfs. I get the impression they don't use initrd either, 
though.

I don't know too much about booting without an initramfs - I switched 
ages ago - so what is possible and what they're actually doing, I don't 
know.

Cheers,
Wol
