Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905EE2BB7F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgKTU4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 15:56:31 -0500
Received: from www2.webmail.pair.com ([66.39.3.96]:44996 "EHLO
        www2.webmail.pair.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgKTU4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:56:31 -0500
Received: from rc.webmail.pair.com (localhost [127.0.0.1])
        by www2.webmail.pair.com (Postfix) with ESMTP id A37201C0109;
        Fri, 20 Nov 2020 15:56:30 -0500 (EST)
MIME-Version: 1.0
Date:   Fri, 20 Nov 2020 14:56:30 -0600
From:   "K.R. Foley" <kr@cybsft.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: BUG triggers running lsof
In-Reply-To: <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
References: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
 <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <eef2b7bb87e45c0b03e434316cb32c51@cybsft.com>
X-Sender: kr@cybsft.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



---
Regards,
K.R. Foley

On 2020-11-20 13:42, Randy Dunlap wrote:
> On 11/20/20 11:16 AM, K.R. Foley wrote:
>> I have found an issue that triggers by running lsof. The problem is 
>> reproducible, but not consistently. I have seen this issue occur on 
>> multiple versions of the kernel (5.0.10, 5.2.8 and now 5.4.77). It 
>> looks like it could be a race condition or the file pointer is being 
>> corrupted. Any pointers on how to track this down? What additional 
>> information can I provide?
> 
> Hi,
> 
> 2 things in general:
> 
> a) Can you test with a more recent kernel?
> 
> b) Can you reproduce this without loading the proprietary & out-of-tree
> kernel modules?  They should never have been loaded after bootup.
> I.e., don't just unload them -- that could leave something bad behind.

I can try to reproduce with a newer kernel and without the modules.

