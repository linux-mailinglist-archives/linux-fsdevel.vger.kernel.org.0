Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC92425AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbhJGSa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243663AbhJGSa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:30:56 -0400
X-Greylist: delayed 324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Oct 2021 11:29:02 PDT
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54DC061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 11:29:02 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HQKbH6sXZzMq0pQ;
        Thu,  7 Oct 2021 20:28:59 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4HQKbF323jzlhNwp;
        Thu,  7 Oct 2021 20:28:57 +0200 (CEST)
Subject: Re: [PATCH v12 0/3] Add trusted_for(2) (was O_MAYEXEC)
To:     Kees Cook <keescook@chromium.org>
Cc:     bauen1 <j2468h@googlemail.com>, akpm@linux-foundation.org,
        arnd@arndb.de, casey@schaufler-ca.com,
        christian.brauner@ubuntu.com, christian@python.org, corbet@lwn.net,
        cyphar@cyphar.com, deven.desai@linux.microsoft.com,
        dvyukov@google.com, ebiggers@kernel.org, ericchiang@google.com,
        fweimer@redhat.com, geert@linux-m68k.org, jack@suse.cz,
        jannh@google.com, jmorris@namei.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        madvenka@linux.microsoft.com, mjg59@google.com,
        mszeredi@redhat.com, mtk.manpages@gmail.com,
        nramas@linux.microsoft.com, philippe.trebuchet@ssi.gouv.fr,
        scottsh@microsoft.com, sean.j.christopherson@intel.com,
        sgrubb@redhat.com, shuah@kernel.org, steve.dower@python.org,
        thibaut.sautereau@clip-os.org, vincent.strubel@ssi.gouv.fr,
        viro@zeniv.linux.org.uk, willy@infradead.org, zohar@linux.ibm.com
References: <20201203173118.379271-1-mic@digikod.net>
 <d3b0da18-d0f6-3f72-d3ab-6cf19acae6eb@gmail.com>
 <2a4cf50c-7e79-75d1-7907-8218e669f7fa@digikod.net>
 <202110061500.B8F821C@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <4c4bbd74-0599-fed5-0340-eff197bafeb1@digikod.net>
Date:   Thu, 7 Oct 2021 20:29:31 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202110061500.B8F821C@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 07/10/2021 00:03, Kees Cook wrote:
> On Fri, Apr 09, 2021 at 07:15:42PM +0200, Mickaël Salaün wrote:
>> There was no new reviews, probably because the FS maintainers were busy,
>> and I was focused on Landlock (which is now in -next), but I plan to
>> send a new patch series for trusted_for(2) soon.
> 
> Hi!
> 
> Did this ever happen? It looks like it's in good shape, and I think it's
> a nice building block for userspace to have. Are you able to rebase and
> re-send this?

I just sent it:
https://lore.kernel.org/all/20211007182321.872075-1-mic@digikod.net/

Some Signed-off-by would be appreciated. :)

> 
> I've tended to aim these things at akpm if Al gets busy. (And since
> you've had past review from Al, that should be hopefully sufficient.)
> 
> Thanks for chasing this!
> 
> -Kees
> 
