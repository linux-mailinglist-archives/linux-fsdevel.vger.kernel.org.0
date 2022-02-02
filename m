Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3A4A77F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiBBSaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 13:30:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiBBSaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:30:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DAA3B1F37C;
        Wed,  2 Feb 2022 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643826620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofv7V/MQVvyAB2zyifMmag7SP5keFFOIeiBWbFRtzaU=;
        b=JNMlzSCbec767vPRfVpOmFvG5C2r21R69LEV1Qn56i6rTVQ3Lwth4L9j7j0MV/VkVj8srM
        5MskiOlqBcuDF6khSSZt32NSIcnX+jKC4Mkav605vBUWT7M4YwbHu9GRqTJzO3nc5H9Gkt
        uZSpqMnA6eOZMJ7PzgqTzom0CvVqYXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643826620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofv7V/MQVvyAB2zyifMmag7SP5keFFOIeiBWbFRtzaU=;
        b=7+W85VwULlaftlUvRleNHXP3k2CPXLAWirjTWTR285341BYHOdCH9dRQqyfdO3p5IuWxO/
        o45sC6oCwTlXfOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5419C13E25;
        Wed,  2 Feb 2022 18:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2dCVBrzN+mG6awAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 02 Feb 2022 18:30:20 +0000
Date:   Wed, 2 Feb 2022 15:30:17 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for
 in-kernel consumers
Message-ID: <20220202183017.ryv43nebh4ane42u@cyberdelia>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
 <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/02, Chuck Lever III wrote:
>[ ... adding NFS and CIFS ... ]
>
>> Required attendees:
>>
>> Chuck Lever
>> James Bottomley
>> Sagi Grimberg
>> Keith Busch
>> Christoph Hellwig
>> David Howells
>
>Anyone from the CIFS team? Enzo? How about Dave Miller?

I'll be attending representing the CIFS side. I hope to have my
prototype more solid and public by then.


Cheers,

Enzo
