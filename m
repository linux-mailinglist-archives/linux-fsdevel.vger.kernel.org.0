Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F66A8984
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBTgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBTgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:36:04 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE74391A;
        Thu,  2 Mar 2023 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oy5NwhJ1usehLrxTN3JdpEvzAa2XK/JvvxER7QZDFT4=; b=uJY5rJO/xkco+CXqR0Q9O9+t0I
        TJckrQ6owK+9xlb6GrfAi9WLai/K+aHe9S0As19e4GhsiW8zWssAIx7FOU/d9lTm+5hHFujJQcL0t
        V+5Vvfb8Lvx9Yi3SBjwEJtcQ229tldotke6TBZu6c81PVT+4qWHle6Oc8RMaVzA6pG3YfdL7H0GCL
        WhQ1Jf3WZ/JVG4WkSF2vRujDjEVD/I+T91jHrwYH3V0DMfV8yNYh5RLXSHMJbKhdmQ9UA1+O2QRTj
        rINf1QGuA4Pr7OSkiyk6h52LM8bi66CskLUZMD5xNRf681q6OjXw3EQa8s+bugausalB17XjbxlLg
        XzoWeX1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXoid-00DNnT-0g;
        Thu, 02 Mar 2023 19:35:59 +0000
Date:   Thu, 2 Mar 2023 19:35:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <ZAD6n+mH/P8LDcOw@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV>
 <Y/9duET0Mt5hPu2L@ZenIV>
 <20230302095931.jwyrlgtxcke7iwuu@quack3>
 <9074146.CDJkKcVGEf@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9074146.CDJkKcVGEf@suse>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:31:46PM +0100, Fabio M. De Francesco wrote:

> But... when yesterday Al showed his demo patchset I probably interpreted his 
> reply the wrong way and thought that since he spent time for the demo he 
> wanted to put this to completion on his own.
> 
> Now I see that you are interpreting his message as an invite to use them to 
> shorten the time... 
> 
> Furthermore I'm not sure about how I should credit him. Should I merely add a 
> "Suggested-by:" tag or more consistent "Co-authored-by: Al Viro <...>"? Since 
> he did so much I'd rather the second but I need his permission.

What, for sysv part?  It's already in mainline; for minixfs and ufs, if you want
to do those - whatever you want, I'd probably go for "modelled after sysv
series in 6.2" - "Suggested-by" in those would suffice...

> @Al,
> 
> Can I really proceed with *your* work? What should the better suited tag be to 
> credit you for the patches?
> 
> If you can reply today or at least by Friday, I'll pick your demo patchset, 
> put it to completion, make the patches and test them with (x)fstests on a 
> QEMU/KVM x86_32 bit VM, with 6GB RAM, running an HIGHMEM64GB enabled kernel.

Frankly, ext2 patchset had been more along the lines of "here's what untangling
the calling conventions in ext2 would probably look like" than anything else.
If you are willing to test (and review) that sucker and it turns out to be OK,
I'll be happy to slap your tested-by on those during rebase and feed them to
Jan...
