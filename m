Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC3588EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiHCOp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiHCOp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:45:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9171145;
        Wed,  3 Aug 2022 07:45:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E939B1F891;
        Wed,  3 Aug 2022 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659537921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkbL0+MF4js/8wzojn/qVhmYhYuKUOoXosItyBD0QhE=;
        b=JTMcD0EuIrrKTpDrRNLmlwcArLYgjCWdLkjaPkVbhl6/g/xrGiJfnJVslDctmdJxRoV5Cc
        3do8kLhx1PA2rSyC/6YhgATmd+gP3nqjxRLH53LN7S+0/tSahkYw6lbKvbJoFziNP+5QQX
        sh+RKpM+3bQpTbe79dKkhuqBBWAAu38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659537921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkbL0+MF4js/8wzojn/qVhmYhYuKUOoXosItyBD0QhE=;
        b=hTau6IJBrMfyCZjgjyrNzoVWfeTky9WgOxIm/h+29yjm+ddGuAriRfuCLbQ0HqedZ+rTyb
        HA/xx5VYu2dklKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7143313AD8;
        Wed,  3 Aug 2022 14:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 63aZDf+J6mKbIgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 03 Aug 2022 14:45:19 +0000
Date:   Wed, 3 Aug 2022 11:45:19 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tom@talpey.com, samba-technical@lists.samba.org,
        pshilovsky@samba.org
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
Message-ID: <20220803144519.rn6ybbroedgmuaie@cyberdelia>
References: <20220801190933.27197-1-ematsumiya@suse.de>
 <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
 <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
 <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/02, Jeff Layton wrote:
>If the concern is "branding" then I don't see how this really helps.
>Very few users interact with the kernel modules directly.
>
>FWIW, I just called "modprobe smb3" on my workstation and got this:
>
>[ 1223.581583] Key type cifs.spnego registered
>[ 1223.582523] Key type cifs.idmap registered
>[ 1230.411422] Key type cifs.idmap unregistered
>[ 1230.412542] Key type cifs.spnego unregistered
>
>Are you going to rename the keyrings too? That will have implications
>for userland helper programs like cifs.upcall. There's also
>/proc/fs/cifs/*.
>
>These are a "stable interfaces" that you can't just rename at will.=A0If
>you want to change these interfaces then you need to do a formal
>deprecation announcement, and probably a period with /proc/fs/smbfs and
>/proc/fs/cifs coexisting.
>
>There are also a ton of printk's and such that have "CIFS" in them that
>will need to be changed.
>
>These costs do not seem worth the perceived benefit to me. You could
>probably hide a lot of what users see by just renaming (or symlinking)
>mount.cifs to mount.smb3.
>
>I think if you guys are serious about this, you should probably start
>somewhere else besides renaming the directory and module. This is going
>to impact developers (and people who make their living doing backports)
>far more than it will users.

I was thinking about the possible issues of a rename, and my
perspective/assessment of the impact is this:

For devs:
- from running userspace/upcall tools with "cifs" name for a while until
   everything eventually catches up
- not much else, really (enlighten me here please)

For backporters/distros:
- this might *look* like an issue first, because of the name conflicts it
   would arise when backporting fixes to older kernels, but these are
   _just_ a rename, without any functional changes whatsoever. It could
   be backported just fine as well, and customers/end users would still
   see no difference in behaviour

For customers/end users:
- at first, there should be no impact. "cifs" and "smb3" modules aliases
   are kept (and will be for a long while) and nothing else changes
   (procfs entry, idmap/spnego upcalls, mount.cifs, etc stays the same)

A note on backports: I myself (and Paulo) do the backports for our SLE
products, sometimes down to SLE11-SP4 (based on kernel 3.0) and I
could not see what other issues could appear given if we backport this
rename to released products.

Of course, I don't know every process for every distro vendors, so if
someone could provide feedback on this, I'd appreciate.

@Paulo I'd like to hear your opinion on possible issues of future backports,
if we backported this rename patch to SLES.


Cheers,

Enzo
