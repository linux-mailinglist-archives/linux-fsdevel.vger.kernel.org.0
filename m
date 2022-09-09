Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF15B33C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIIJ0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIIJZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:25:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2F136CC1;
        Fri,  9 Sep 2022 02:24:03 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-102.corp.google.com [104.133.160.102] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2899Nkfv031889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 05:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662715429; bh=3Karl2D5yBt1fAJz2O8TVJIdIGYpnRMjqsVd1Gq0PRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JTX0pwGqDy9opQsOYLpuITJObx23uKVjCGPOG9LQsmm9pRlhTKXDWekZqp670V/9y
         Y2ErFfWWEPzBH7+pIpxY5Qbz8y1LQsa2VAWsillsnJqQRsWOLqffbLBzzkD5/LfOCn
         FoTnixc38CkJ5mHkLYoDiH+Vg/TOs9xLUymEQW7dBz6IxFC2ylu90nXHQ2e/+61a2T
         QSrezewJjBNRm9lHiSCBn08XMKhrUbdWby7YtqGIEjbtD/D7nvuM4wBoOStWi28f9b
         ooqZVeJ9GKnPuKCADQ88sz7lgr8iOLpksS9aNNVzDN37RvTW56kePgPkVD+kUISWU+
         E5gmGPdjshhNQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 4BC818C2B47; Fri,  9 Sep 2022 05:23:46 -0400 (EDT)
Date:   Fri, 9 Sep 2022 05:23:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Does NFS support Linux Capabilities
Message-ID: <YxsGIoFlKkpQdSDY@mit.edu>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:24:02PM +0000, Chuck Lever III wrote:
> I'm not sure how closely other implementations come to implementing
> POSIX.1e, but there are enough differences that interoperability
> could be a nightmare. Anything Linux has done differently than
> POSIX.1e would be encumbered by GPL, making it nearly impossible to
> standardize those differences. (Let alone the possible problems
> trying to cite a withdrawn POSIX standard in an Internet RFC!)

I'm not a lawyer and I don't play one on TV; I haven't even stayed at
a Holiday Inn recently.  :-)

However... please note that at least in the US, copyright does not
extend to *interfaces*.  This is why we can replicate interfaces such
as openat(2), which first appeared in Solaris, not to mention things
like the read(2) system call and the options to fsck, which first
appared in Unix systems encumbered by the AT&T Copyright license.

(And some of these licenses even had AT&T's claim that Unix "methods
and concepts" were trade secrets, although MIT had always refused to
sign any such license agreements, since they didn't want to encumber
the brains of their undergraduates.  So I've looked at BSD source code
as an MIT undergraduate without any kind of "Methods and Concepts"
taint, although trying to claim that the Unix methods and concepts are
a "trade secret" are kind of laughable at this point.  :-)

> The NFSv4 WG could invent our own capabilities scheme, just as was
> done with NFSv4 ACLs. I'm not sure everyone would agree that effort
> was 100% successful.

Indeed, what the NFSv4 working group could do is to take a survey of
what capabilities are in use, and more importantly, how they are
defined, and create a superset of all of those capabilities and
publish it as an RFC.  The tricky bit might be there were multiple
versions of the Posix.1e that were published, and different Legacy
Unices shipped implementations conforming to different drafts of
Posix.1e as part of the ill-fated "C2 by '92" initiative.

(The US government was trying to get all Unix systems to have the
minimal Orange Book certification so the US Military could use them in
classified systems, and they hadn't figured out that US procurements
for the computer industry had transitioned from being the body of the
dog to being the tail.  For more details, see Steve Lipner's "The
Birth and Death of the Orange Book" published in the IEEE Annals of
the History of Computing, 2015.)

In any case, what this means is the exact details of what some
particular capability might control could differ from system to
system.  OTOH, I'm not sure how much that matters, since capability
masks are applied to binaries, and it's unlikely that it would matter
that a particular capabiity on an executable meant for Solaris 2.4SE
with C2 certification might be confusing to AIX 4.3.2 (released in
1999; so much for C2 by '92) that supported Orange Book C2, since AIX
can't run Solaris binaries.  :-)

> Given these enormous challenges, who would be willing to pay for
> standardization and implementation? I'm not saying it can't or
> shouldn't be done, just that it would be a mighty heavy lift.
> But maybe other folks on the Cc: list have ideas that could
> make this easier than I believe it to be.

... and this is why the C2 by '92 initiative was doomed to failure,
and why Posix.1e never completed the standardization process.  :-)

Honestly, capabilities are super coarse-grained, and I'm not sure they
are all that useful if we were create blank slate requirements for a
modern high-security system.  So I'm not convinced the costs are
sufficient to balance the benefits.

If I was going to start from scratch, and if I only cared about Linux
systems that supported ext4 and/or f2fs, I'd design something where
executables would use fsverity, and then combine it with an eBPF MAC
policy[1] that would key off of some policy identifier embedded in the
PKCS7 signature block located in the executable's fsverity metadata.
(The fsverity signature would be applied by a secure build service, to
guarantee exact correspondence between the binary and a specific
version checked into source control, to protect against the insider
threat of an engineer sneaking some kind of un-peer-reviewed back door
into the binary.)  The policy identifier might be used to provide some
kind of MAC enforcement, perhaps using seccomp to enforce what system
calls and ioctls said executable would be allowed to execute, or some
other kind of MAC policy.

[1] https://lwn.net/Articles/809645/

Speaking totally hypothetically, of course.  A bunch of what I've
described above isn't upstream, or even implemented yet.  (Although if
someone's interest is piqued in implementing some of this, please
contact me off-line.)

    		     	   	 		- Ted
