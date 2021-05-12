Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7537BA0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhELKKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 06:10:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELKKV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 06:10:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09DDDAF3B;
        Wed, 12 May 2021 10:09:12 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id aa6435b1;
        Wed, 12 May 2021 10:10:46 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
References: <871rae24kv.fsf@suse.de> <87czu45gcs.fsf@suse.de>
        <YJPIyLZ9ofnPy3F6@codewreck.org> <87zgx83vj9.fsf@suse.de>
        <87r1ii4i2a.fsf@suse.de> <YJXfjDfw9KM50f4y@codewreck.org>
        <875yzq270z.fsf@suse.de> <2508106.1620737077@warthog.procyon.org.uk>
Date:   Wed, 12 May 2021 11:10:45 +0100
In-Reply-To: <2508106.1620737077@warthog.procyon.org.uk> (David Howells's
        message of "Tue, 11 May 2021 13:44:37 +0100")
Message-ID: <87pmxwz2hm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Luis Henriques <lhenriques@suse.de> wrote:
>
>> +		if (data->inode < inode)
>> +			node = node->rb_left;
>> +		else if (data->inode > inode)
>> +			node = node->rb_right;
>
> If you're just using a plain integer as the key into your debug tree, an
> xarray, IDA or IDR might be easier to use.

Yep, xarray actually crossed my mind but rbtrees were still fresh in my
memory.  I'll look into the xarray API next time (which is likely to be
much simpler, I know).

Cheers,
-- 
Luis
