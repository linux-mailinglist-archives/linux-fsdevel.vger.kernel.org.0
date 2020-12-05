Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221C52CF9D5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 06:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgLEFrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 00:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLEFrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:47:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B253C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Dec 2020 21:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=DsXoveua35cz9aAyjL0EkTco8yBzgWXfiwCdcc+U9xU=; b=sHVGgyaN47cgQYoHAxu87SjT/s
        fNTAA44QzRw7ej9ObaUUgOKFn1xIVhlylsaHMPBxBhUxhuuvKdOGedm5DjcUQyGPhCov7/gBTKW+a
        leKowWwJUp2liIl/oDua8FPR0PwWiSO51+waahnSdRq693ioPVHdV9hX7zgKBJwn5y3whfj9O0psc
        tErarhVI8V3Wk4t9HTUTATr/MpR9VlZVWObBib4RvRLlsKPOKGo3WFqHcKr9ZWfOo0m0oLQlJWZG4
        Jli4AeUAG5h9kqLUHcA9PbnSe6l+HANMUYEqsXz098EK5CrL+UlfUhU+9KbPYanmm4egCx2RHHHrH
        b37nzp5w==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klQOw-0007tr-6s; Sat, 05 Dec 2020 05:46:35 +0000
Subject: Re: AFS documentation
From:   Randy Dunlap <rdunlap@infradead.org>
To:     David Howells <dhowells@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <f77d3d67-ea63-4cce-fa6f-2977db078b74@infradead.org>
Message-ID: <de7da229-e0ea-6263-9dd2-e534cf49aaee@infradead.org>
Date:   Fri, 4 Dec 2020 21:46:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <f77d3d67-ea63-4cce-fa6f-2977db078b74@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/4/20 9:35 PM, Randy Dunlap wrote:
> Hi David,
> 
> I was browsing Documentation/filesystems/afs.rst and fs/afs/super.c
> and had a few questions/comments.
> 
> 1.  afs.rst says:
> 
> <<<
> When inserting the driver modules the root cell must be specified along with a
> list of volume location server IP addresses::
> 
> 	modprobe rxrpc
> 	modprobe kafs rootcell=cambridge.redhat.com:172.16.18.73:172.16.18.91
> 
> The first module is the AF_RXRPC network protocol driver.  This provides the
> RxRPC remote operation protocol and may also be accessed from userspace.  See:
> 
> 	Documentation/networking/rxrpc.rst
> 
> The second module is the kerberos RxRPC security driver, and the third module
> is the actual filesystem driver for the AFS filesystem.
>>>>
> 
> so that above mentions 3 modules but only lists (modprobes) 2 of them.
> Or am I missing something?
> 
> 
> 2.  fs/afs/super.c seems to be willing to parse "source=" (Opt_source).
> 
> Can you tell me the format & meaning of that mount option?
> and maybe even add it to the doc. file?

Ah, I see that source= is a general fs mount option.  Never mind on that one.  :)


-- 
~Randy

