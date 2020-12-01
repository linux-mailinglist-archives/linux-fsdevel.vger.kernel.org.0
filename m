Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7E02C9616
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgLADvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 22:51:03 -0500
Received: from sandeen.net ([63.231.237.45]:33174 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgLADvD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:51:03 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id D30E9EDD;
        Mon, 30 Nov 2020 21:50:07 -0600 (CST)
From:   Eric Sandeen <sandeen@sandeen.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20201125212523.GB14534@magnolia>
 <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <1942931.1606341048@warthog.procyon.org.uk>
 <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
 <20201201032051.GK5364@mit.edu>
 <f259c5ee-7465-890a-3749-44eb8be0f8cf@sandeen.net>
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <56d406b1-b013-7711-2aa6-1ef9d3d5f5d4@sandeen.net>
Date:   Mon, 30 Nov 2020 21:50:21 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f259c5ee-7465-890a-3749-44eb8be0f8cf@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/30/20 9:37 PM, Eric Sandeen wrote:
> On 11/30/20 9:20 PM, Theodore Y. Ts'o wrote:

...

>> We should be really clear how applications are supposed to use the
>> attributes_mask.  Does it mean that they will always be able to set a
>> flag which is set in the attribute mask?  That can't be right, since
>> there will be a number of flags that may have some more complex checks
>> (you must be root, or the file must be zero length, etc.)  I'm a bit
>> unclear about what are the useful ways in which an attribute_mask can
>> be used by a userspace application --- and under what circumstances
>> might an application be depending on the semantics of attribute_mask,
>> so we don't accidentally give them an opportunity to complain and
>> whine, thus opening ourselves to another O_PONIES controversy.
> 
> Hah, indeed.
> 
> Sorry if I've over-complicated this, I'm honestly just confused now.

hch warned us, I guess:

https://lore.kernel.org/linux-fsdevel/20170404071252.GA30966@infradead.org/

At this point I guess I'll just set the dax attribute into the mask
unconditionally for xfs, because xfs "supports" dax, and stop navel-gazing
over this.

-Eric
