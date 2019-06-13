Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BF4379C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfFMPAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:00:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbfFMOt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WMyyxODgsxZ/XkDr48HWA7aTA4P32ySnPu90ZE1usUA=; b=SvRYAM6V25RdXhhsF2XFD/myCy
        xb90MjFff+RemiPe/zmVRTwQhoIo5cqAF2taZi8MUOejdLT1cBDi4MzIr/OkvNaoWh9WPy78Y9iGa
        km6RgOwE7MG8qQFY13YKdOYFyn6V6JWac8/2o05TV/mDxP5THfZdU34j/GMH7AaMmOqeVG5aDRGck
        dbH6tYpypSW4SkNfYadSbfEYCHgblPGISG5mOtez1Wu92EQCQWKUOcaDGfrR2/Ic2uOjlu72PANeR
        IrYhaIbx5gzo/xLXBtkiC/5kXhTzhv1AERPNvZZ0goFmnYWMrfD555r42SloB+Sv1bvNB2b5jQhg3
        MQHwsJRQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbR35-0004ea-Lj; Thu, 13 Jun 2019 14:49:55 +0000
Subject: Re: [PATCH 02/13] uapi: General notification ring definitions [ver
 #4]
To:     David Howells <dhowells@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6b6f5bb0-1426-239b-ac9f-281e31ddcd04@infradead.org>
 <20190607151228.GA1872258@magnolia>
 <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
 <29222.1559922719@warthog.procyon.org.uk>
 <30226.1560432885@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <575fa290-961f-8dcd-3b76-4608daa5ee0e@infradead.org>
Date:   Thu, 13 Jun 2019 07:49:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <30226.1560432885@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/13/19 6:34 AM, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> What is the problem with inline functions in UAPI headers?
> 
> It makes compiler problems more likely; it increases the potential for name
> collisions with userspace; it makes for more potential problems if the headers
> are imported into some other language; and it's not easy to fix a bug in one
> if userspace uses it, just in case fixing the bug breaks userspace.
> 
> Further, in this case, the first of Darrick's functions (calculating the
> length) is probably reasonable, but the second is not.  It should crank the
> tail pointer and then use that, but that requires 
> 
>>>> Also, weird multiline comment style.
>>>
>>> Not really.
>>
>> Yes really.
> 
> No.  It's not weird.  If anything, the default style is less good for several
> reasons.  I'm going to deal with this separately as I need to generate some
> stats first.
> 
> David
> 

OK, maybe you are objecting to the word "weird."  So the multi-line comment style
that you used is not the preferred Linux kernel multi-line comment style
(except in networking code) [Documentation/process/coding-style.rst] that has been
in effect for 20+ years AFAIK.


-- 
~Randy
