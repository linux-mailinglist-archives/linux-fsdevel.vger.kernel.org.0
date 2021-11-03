Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423C44447D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 18:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhKCSCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 14:02:11 -0400
Received: from sandeen.net ([63.231.237.45]:58262 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCSCK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:02:10 -0400
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 2B0BF14627D;
        Wed,  3 Nov 2021 12:57:54 -0500 (CDT)
Message-ID: <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
Date:   Wed, 3 Nov 2021 12:59:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211018044054.1779424-1-hch@lst.de>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: futher decouple DAX from block devices
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/17/21 11:40 PM, Christoph Hellwig wrote:
> Hi Dan,
> 
> this series cleans up and simplifies the association between DAX and block
> devices in preparation of allowing to mount file systems directly on DAX
> devices without a detour through block devices.

Christoph, can I ask what the end game looks like, here? If dax is completely
decoupled from block devices, are there user-visible changes? If I want to
run fs-dax on a pmem device - what do I point mkfs at, if not a block device?

Thanks,
-Eric
