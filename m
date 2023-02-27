Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4C6A3C0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjB0IMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 03:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0IMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:12:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74E1A485;
        Mon, 27 Feb 2023 00:12:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1070E219EF;
        Mon, 27 Feb 2023 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677485562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcgAXzXSoK8lfZ2Q0tT7Y4O4C0mAQjamcfy1c/PA2qg=;
        b=g+yGbFjtIntCFPETS37JSMGFXVPZ1lofYm84or4aLruEDKzUHiqHJqfzuYasNMol+unNoP
        iq5t7rpxmqAjTsCUrQbsKQ37i2y+Fzkw09i5ZREP/Bh5VvxYIdhxGFZlXosjFAbenuIcOB
        1ivJWLdiWAFeamFcMfmo7TXZT4CBLzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677485562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcgAXzXSoK8lfZ2Q0tT7Y4O4C0mAQjamcfy1c/PA2qg=;
        b=lk53eJfT8LAZmjqvmVc141vFqj7qEFjbFqugvC1CKOrp6VORUDEKJtgbc4gAcpTXMJwZmk
        8YRBrN5Y7g022iDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B42F913A43;
        Mon, 27 Feb 2023 08:12:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vmw1K/ll/GOcLwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 27 Feb 2023 08:12:41 +0000
Message-ID: <5ca0ebcb-b714-81fe-ee24-adbdcb830320@suse.de>
Date:   Mon, 27 Feb 2023 09:12:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [dm-devel] [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-block@vger.kernel.org, David Howells <dhowells@redhat.com>,
        dm-devel@redhat.com, Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
References: <2896937.1676998541@warthog.procyon.org.uk>
 <96463a32a97dc40bc30c47ddcdf19a5803de32d8.camel@HansenPartnership.com>
 <CAH2r5mtLFW3x46rTACqk0XsjdHq_UMG-bLgQJx0LtyF9DF9cwg@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAH2r5mtLFW3x46rTACqk0XsjdHq_UMG-bLgQJx0LtyF9DF9cwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/23 22:37, Steve French wrote:
> I did one on network fs security at a security summit before that would 
> still be relevant to both
> 
> On Tue, Feb 21, 2023, 16:16 James Bottomley 
> <James.Bottomley@hansenpartnership.com 
> <mailto:James.Bottomley@hansenpartnership.com>> wrote:
> 
>     On Tue, 2023-02-21 at 16:55 +0000, David Howells wrote:
>      >
>      > Since the first day of the LSS is the same as the final day of LSF
>      > and in the same venue, are there any filesystem + security subjects
>      > that would merit a common session?
> 
> 
>     I've got one:  Cryptographic material handling.
> 
>     Subtitle could be: making keyrings more usable.
> 
>     The broad problem is that the use of encryption within the kernel is
>     growing (from the old dm-crypt to the newer fscrypt and beyond) yet
>     pretty much all of our cryptographic key material handling violates the
>     principle of least privilege.  The latest one (which I happened to
>     notice being interested in TPMs) is the systemd tpm2 cryptenroll.  The
>     specific violation is that key unwrapping should occur as close as
>     possible to use: when the kernel uses a key, it should be the kernel
>     unwrapping it not unwrapping in user space and handing the unwrapped
>     key down to the kernel because that gives a way.  We got here because
>     in most of the old uses, the key is derived from a passphrase and the
>     kernel can't prompt the user, so pieces of user space have to gather
>     the precursor cryptographic material anyway.  However, we're moving
>     towards using cryptographic devices (like the TPM, key fobs and the
>     like) to store keys we really should be passing the wrapped key into
>     the kernel and letting it do the unwrap to preserve least privilege.
>     dm-crypt has some support for using kernel based TPM keys (the trusted
>     key subsystem), but this isn't propagated into systemd-cryptenroll and
>     pretty much none of the other encryption systems make any attempt to
>     use keyrings for unwrap handling, even if they use keyrings to store
>     cryptographic material.
> 
>     Part of the reason seems to be that the keyrings subsystem itself is
>     hard to use as a generic "unwrapper" since the consumer of the keys has
>     to know exactly the key type to consume the protected payload.  We
>     could possibly fix this by adding a payload accessor function so the
>     keyring consumer could access a payload from any key type and thus
>     benefit from in-kernel unwrapping, but there are likely a host of other
>     issues that need to be solved.  So what I'd really like to discuss is:
> 
>     Given the security need for a generic in-kernel unwrapper, should we
>     make keyrings do this and if so, how?
> That's one where I'd be interested in, too; for NVMe-over-TLS we'll be 
using keyrings, too, and have the same issue as to how and where keys 
should be decoded (eg for X.509 handling).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

