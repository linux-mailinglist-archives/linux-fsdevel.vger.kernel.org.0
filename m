Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2740CCCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhIOSuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:50:12 -0400
Received: from sandeen.net ([63.231.237.45]:37700 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhIOSuM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:50:12 -0400
Received: from liberator.local (h114.53.19.98.static.ip.windstream.net [98.19.53.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 99924877;
        Wed, 15 Sep 2021 13:48:39 -0500 (CDT)
To:     Dan Williams <dan.j.williams@intel.com>,
        Eric Sandeen <sandeen@redhat.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
 <CAPcyv4gZqnp6CPh71o621sQ5Q9LZEr3MhkFYftW9LpuuMtAPRA@mail.gmail.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 0/3 RFC] Remove DAX experimental warnings
Message-ID: <cb13be1c-66f1-8452-e7ab-c1278c8e51e0@sandeen.net>
Date:   Wed, 15 Sep 2021 13:48:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gZqnp6CPh71o621sQ5Q9LZEr3MhkFYftW9LpuuMtAPRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/21 1:35 PM, Dan Williams wrote:
> On Wed, Sep 15, 2021 at 10:23 AM Eric Sandeen <sandeen@redhat.com> wrote:
>>
>> For six years now, when mounting xfs, ext4, or ext2 with dax, the drivers
>> have logged "DAX enabled. Warning: EXPERIMENTAL, use at your own risk."
>>
>> IIRC, dchinner added this to the original XFS patchset, and Dan Williams
>> followed suit for ext4 and ext2.
>>
>> After brief conversations with some ext4 and xfs developers and maintainers,
>> it seems that it may be time to consider removing this warning.
>>
>> For XFS, we had been holding out for reflink+dax capability, but proposals
>> which had seemed promising now appear to be indefinitely stalled, and
>> I think we might want to consider that dax-without-reflink is no longer
>> EXPERIMENTAL, while dax-with-reflink is simply an unimplemented future
>> feature.
> 
> I do regret my gap in engagement since the last review as I got
> distracted by CXL, but I've recently gotten my act together and picked
> up the review again to help get Ruan's patches over the goal line [1].
> I am currently awaiting Ruan's response to latest review feedback
> (looks like a new posting this morning). During that review Christoph
> identified some cleanups that would help Ruan's series, and those are
> now merged upstream [2]. The last remaining stumbling block (further
> block-device entanglements with dax-devices) I noted here [2]. The
> proposal is to consider eliding device-mapper dax-reflink support for
> now and proceed with just xfs-on-/dev/pmem until Mike, Jens, and
> Christoph can chime in on the future of dax on block devices.
> 
> As far as I can see we have line of sight to land xfs-dax-reflink
> support for v5.16, does anyone see that differently at this point?

Thanks for that update, Dan. I'm wondering, even if we have renewed
hopes and dreams for dax+reflink, would it make sense to go ahead and
declare dax without reflink non-experimental, and tag dax+reflink as
a new "EXPERIMENTAL feature if and when it lands?

-Eric
