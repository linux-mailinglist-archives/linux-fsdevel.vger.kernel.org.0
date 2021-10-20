Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE54434DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhJTOiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:38:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhJTOiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:38:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A92A21A5F;
        Wed, 20 Oct 2021 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634740562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rt8IMD23NfglKpF4Y3kMxnmZauRQpZcHXKdvOD/pnYk=;
        b=UR4x8keYTomAT/Jibe3UaIrr0CWtMacIHRx0hs9qSWJFnAFAy4rgn07cqY7iwSqqUjdZCW
        BIW7+noE2e9aeTZLhTtm42P95FCJaBKi7SZm+bCp438aVpby3nywDRAxq105l1ULsw+KW2
        dN0BezS3jfiiV5SxbMylJiawFcUL4J4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 368E113B55;
        Wed, 20 Oct 2021 14:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KEa4ClIpcGG8HwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Oct 2021 14:36:02 +0000
Subject: Re: [PATCH v11 03/10] btrfs-progs: receive: support v2 send stream
 DATA tlv format
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <0240e4ddc8c47d6074a3ffeba5933169ce5690f8.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b1c33a06-29ca-9bc0-8491-ac388fa5ea8e@suse.com>
Date:   Wed, 20 Oct 2021 17:36:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0240e4ddc8c47d6074a3ffeba5933169ce5690f8.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <borisb@fb.com>
> 
> The new format privileges the BTRFS_SEND_A_DATA attribute by
> guaranteeing it will always be the last attribute in any command that
> needs it, and by implicitly encoding the data length as the difference
> between the total command length in the command header and the sizes of
> the rest of the attributes (and of course the tlv_type identifying the
> DATA attribute). To parse the new stream, we must read the tlv_type and
> if it is not DATA, we proceed normally, but if it is DATA, we don't
> parse a tlv_len but simply compute the length.
> 
> In addition, we add some bounds checking when parsing each chunk of
> data, as well as for the tlv_len itself.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
