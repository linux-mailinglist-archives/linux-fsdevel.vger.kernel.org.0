Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECC027606C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIWSsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:48:38 -0400
Received: from namei.org ([65.99.196.166]:59120 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgIWSsi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:48:38 -0400
X-Greylist: delayed 2230 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 14:48:37 EDT
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 08NIAiwu027177;
        Wed, 23 Sep 2020 18:10:44 GMT
Date:   Thu, 24 Sep 2020 04:10:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     madvenka@linux.microsoft.com, kernel-hardening@lists.openwall.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
In-Reply-To: <20200923081426.GA30279@amd>
Message-ID: <alpine.LRH.2.21.2009240409130.26225@namei.org>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa> <20200922215326.4603-1-madvenka@linux.microsoft.com> <20200923081426.GA30279@amd>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Sep 2020, Pavel Machek wrote:

> This is not first crazy patch from your company. Perhaps you should
> have a person with strong Unix/Linux experience performing "straight
> face test" on outgoing patches?

Just for the record: the author of the code has 30+ years experience in 
SunOS, Solaris, Unixware, Realtime, SVR4, and Linux.


-- 
James Morris
<jmorris@namei.org>

