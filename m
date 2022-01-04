Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2948442F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiADPFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 10:05:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43326 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiADPFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:05:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6086212B8;
        Tue,  4 Jan 2022 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641308745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YyemQGmPQISjhWhCFgIYhlUvtjrM7czIpaHRc8cgQo=;
        b=smnA9MKLKMEJkx726j0XwTzYkchrKORY2pnuhjBEKHB8W2gGfPkkjbjb+wA1GR69gH62Uv
        554+WZ4joFakTzsiljVkb8yyC7ilNNm2snUleY8RJjGULeetjGwzWHFfQEMxDib0TrkLTt
        JTMSY82fmbtRXB8tzDFjrF6nvXUxnA8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89E8413B16;
        Tue,  4 Jan 2022 15:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ioNGH0li1GH+IQAAMHmgww
        (envelope-from <mwilck@suse.com>); Tue, 04 Jan 2022 15:05:45 +0000
Message-ID: <8bcc53097ec596bf91097aca9120dae6fcf0ef9f.camel@suse.com>
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
From:   Martin Wilck <mwilck@suse.com>
To:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>
Cc:     Ted Tso <tytso@mit.edu>, mwilck@suse.de,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 04 Jan 2022 16:05:44 +0100
In-Reply-To: <20220104145511.u4sfkid4ltgrqlqg@quack3.lan>
References: <20211115125141.GD23412@quack2.suse.cz>
         <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
         <20211115145312.g4ptf22rl55jf37l@work>
         <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
         <20211116115626.anbvho4xtb5vsoz5@work>
         <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
         <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
         <20211122135304.uwyqtm7cqc2fhjii@work>
         <ad5272b5b63acf64a47b707d95ecc288d113d637.camel@suse.com>
         <20220103185940.z5dnjj2shquz7yvg@work>
         <20220104145511.u4sfkid4ltgrqlqg@quack3.lan>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-01-04 at 15:55 +0100, Jan Kara wrote:
> 
> So I think the conclusion is that we go with my original patch? Just
> I
> should update it to return computed minlen back to the user, correct?
> 
>                                                                 Honza

Yes, that's my understanding.

Martin



