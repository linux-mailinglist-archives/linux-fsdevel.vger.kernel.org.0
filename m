Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBE541593E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbhIWHpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 03:45:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42362 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbhIWHpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:45:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F71A22258;
        Thu, 23 Sep 2021 07:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632383015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhjAOoJjKMCJh+8Yc3S0Spa0Fk9A0raNfcPeI53Jbh0=;
        b=1UUP2Pn+zIApCOgDoEXcMuJnMTFkF9DBGZgTbHJu8acWrW5p82su3c3WdrNHfs3Xv9Tr77
        AHd2jGgXRWPCkoDePmAUBR4SzJvKPYbELFjsP+CYIyGNt2o3GxPoZzzqT6XqXdVSAjGT5D
        wGtV8NlIij0AVgv51Ra/J6TTsfWivKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632383015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhjAOoJjKMCJh+8Yc3S0Spa0Fk9A0raNfcPeI53Jbh0=;
        b=0ADUah0Gf7Kt3qdD5MgT1nwZpNWLZaeS4TuIYwO36w1IUSbdRGEp4YkNF32jPGv6KXBoMw
        i5wEa0cQxfS3FUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4798F13DC6;
        Thu, 23 Sep 2021 07:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rvHKDycwTGGXBAAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 23 Sep 2021 07:43:35 +0000
Date:   Thu, 23 Sep 2021 09:43:08 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Message-ID: <20210923094308.7081edec@suse.de>
In-Reply-To: <847a413f-dc6e-cbdf-4e0b-6a9512ac69a5@nvidia.com>
References: <20210922115222.8987-1-ddiss@suse.de>
        <847a413f-dc6e-cbdf-4e0b-6a9512ac69a5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 22 Sep 2021 23:28:04 +0000, Chaitanya Kulkarni wrote:

> A cover letter would be nice for such a series, unless I missed it.

I didn't bother, as they're pretty minor changes. I'll add one next time
if another round is needed.

Cheers, David
