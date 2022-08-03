Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B2588590
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 03:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiHCB5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 21:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiHCB5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:57:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD903342B;
        Tue,  2 Aug 2022 18:57:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C172388B5;
        Wed,  3 Aug 2022 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659491818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wh75L2JsVC1g81tvfqGvYtL7ba9GfSXXnDr3TvdiG8Y=;
        b=W5I15y8WWes3gGdcZFkcLTH3E2+GgV6LMxURgLk7fTyTu6Ydjcf6Vm1EA0WSizcrkO/pkE
        //A+lu+gzaZvyWF/WAAs7gF4A6Hm0OQhtxCbpNAGo6FWRnkqjYzlNLfsPdQQik+hOQB0fl
        BEXndnuHTx+OnOYgdGdo5fTIBN1vkxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659491818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wh75L2JsVC1g81tvfqGvYtL7ba9GfSXXnDr3TvdiG8Y=;
        b=itYdiCYy4kINUIGYcNd2PMJbHJVLBwsb6mzIMJbVKx2v/s59ZfR6YXrbA7CLv7oBu2J+DB
        cL9ps0bCXB6ZYdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFA5813A94;
        Wed,  3 Aug 2022 01:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sRmZH+nV6WKdYwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 03 Aug 2022 01:56:57 +0000
Date:   Tue, 2 Aug 2022 22:56:55 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Tom Talpey <tom@talpey.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, samba-technical@lists.samba.org,
        pshilovsky@samba.org
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
Message-ID: <20220803015655.7u5b6i4eo5sfnryb@cyberdelia>
References: <20220801190933.27197-1-ematsumiya@suse.de>
 <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
 <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
 <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
 <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/02, Tom Talpey wrote:
>The initial goal is to modularize the SMB1 code, so it can be completely
>removed from a running system. The extensive refactoring logically leads
>to this directory renaming, but renaming is basically a side effect.
>
>Stamping out the four-letter word C-I-F-S is a secondary goal. At this
>point, the industry has stopped using it. You make a good point that
>it's still visible outside the kernel source though.
>
>It makes good sense to do the refactoring in place, at first. Splitting
>the {smb1,cifs}*.[ch] files will be more complex, but maybe easier to
>review and merge, without folding in a new directory tree and git rm/mv.
>Either way, there will be at least two modules, maybe three if we split
>out generic subroutines.
>
>Enzo, you're up to your elbows in this code now, is it too ugly without
>the new directories?

Having things in separate directories and code appropriately distributed
in coherently named headers/sources certainly makes things easier to
work with.

Of course this patch is not important, by far, but from what I
gathered, it was some people's wish to move away from "cifs" name.

Answering your question (IIUC), Tom, I'm ok with postponing this change.

>Tom.

Cheers,

Enzo
