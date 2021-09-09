Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735C9405860
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356342AbhIIN7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 09:59:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59256 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355967AbhIIN6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:58:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C15F222E3;
        Thu,  9 Sep 2021 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631195815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxvD3VYxgAmEFJrbpKXDUC5Hlh3sSqjZLh0ECwo+YvA=;
        b=qqV/WfhApYICtUejI+rskFfKZfCApJzQzOisZXwoKgzChGKNse919bsDOJUTxcvnTNIxlo
        0afhcaUf3mfXfiULfkonC5WkbT7zR+RLKKAUauXx5JSDPTfxRBvK0fP59da4trZIy1epRF
        wz7KuR8/8E6u78HD3LfVNj+1G4uWWbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631195815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxvD3VYxgAmEFJrbpKXDUC5Hlh3sSqjZLh0ECwo+YvA=;
        b=HXmrE7hYY4j6xlrBPE7e6ETRbqPW8Uw5XHbz7nsWCpI4Mv5TQ2xHx9teXV/FRkY9jhCU3f
        Xwj+iDyM5iwSBMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0365213CB1;
        Thu,  9 Sep 2021 13:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w9MfAKcSOmFLJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Sep 2021 13:56:55 +0000
Message-ID: <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
Date:   Thu, 9 Sep 2021 15:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] Memory folios for v5.15
In-Reply-To: <YToBjZPEVN9Jmp38@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 14:43, Christoph Hellwig wrote:
> So what is the result here?  Not having folios (with that or another
> name) is really going to set back making progress on sane support for
> huge pages.  Both in the pagecache but also for other places like direct
> I/O.

Yeah, the silence doesn't seem actionable. If naming is the issue, I believe
Matthew had also a branch where it was renamed to pageset. If it's the
unclear future evolution wrt supporting subpages of large pages, should we
just do nothing until somebody turns that hypothetical future into code and
we see whether it works or not?


