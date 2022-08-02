Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7858827F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiHBT2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiHBT2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:28:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365932ECA;
        Tue,  2 Aug 2022 12:28:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 722FD1FD18;
        Tue,  2 Aug 2022 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659468489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bg9h887C8gVWobrXRdOT9+x2p3w/uvq6a0lh9g6ugdw=;
        b=sPQYvAQERl6eWHdAPuPNsyhfaVCEmkC9r8nSCcKD4psu/To3u5G33OiKMg8Ee+at+kjS46
        lY21UGgRR9gRSNkgmOd1CZ9ZVjw8h/UYU/VgJYTubmxycxMqNdzEp5hcoWkCXJEg3OXQXL
        b2fRFFAs4LcTotsP2QVkgkgV65An0P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659468489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bg9h887C8gVWobrXRdOT9+x2p3w/uvq6a0lh9g6ugdw=;
        b=gHBnpQbwmKAesnR9qkEQagwr1eS9+zywFq4ADlHcZMXXXuLNNmJJAeNUfpu2sHUUhVE1Y5
        fffmCIMNujceztBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1C1913A8E;
        Tue,  2 Aug 2022 19:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ok4kKMh66WI/aQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 02 Aug 2022 19:28:08 +0000
Date:   Tue, 2 Aug 2022 16:28:06 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tom@talpey.com, samba-technical@lists.samba.org,
        pshilovsky@samba.org, jlayton@kernel.org, rpenny@samba.org
Subject: Re: [RFC PATCH v2 0/5] Rename "cifs" module to "smbfs"
Message-ID: <20220802192806.6ryronlqvus2ua26@cyberdelia>
References: <20220802190048.19881-1-ematsumiya@suse.de>
 <Yul5hBFmwoOQ0cxG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yul5hBFmwoOQ0cxG@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/02, Matthew Wilcox wrote:
>On Tue, Aug 02, 2022 at 04:00:43PM -0300, Enzo Matsumiya wrote:
>> Hi,
>>
>> As part of the ongoing effort to remove the "cifs" nomenclature from the
>> Linux SMB client, I'm proposing the rename of the module to "smbfs".
>>
>> As it's widely known, CIFS is associated to SMB1.0, which, in turn, is
>> associated with the security issues it presented in the past. Using
>> "SMBFS" makes clear what's the protocol in use for outsiders, but also
>> unties it from any particular protocol version. It also fits in the
>> already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.
>>
>> This short patch series only changes directory names and includes/ifdefs in
>> headers and source code, and updates docs to reflect the rename. Other
>> than that, no source code/functionality is modified (WIP though).
>
>Why did you not reply to Jeff Layton's concern before posting a v2?

Hm, I was pretty sure I did. Sorry about that, I got confused on how my
mail client organized the replies to the initial thread.

Replying to Jeff right now.
