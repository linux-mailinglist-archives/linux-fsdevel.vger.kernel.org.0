Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254C150B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfFXMp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 08:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfFXMp2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 892E35F793;
        Mon, 24 Jun 2019 12:45:28 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA739600D1;
        Mon, 24 Jun 2019 12:45:27 +0000 (UTC)
Subject: Re: [PATCH] quota: honor quote type in Q_XGETQSTAT[V] calls
To:     Jan Kara <jack@suse.cz>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
References: <0b96d49c-3c0b-eb71-dd87-750a6a48f1ef@redhat.com>
 <20190624105800.GD32376@quack2.suse.cz>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <c5b47955-4771-e883-4e72-11810141eb19@redhat.com>
Date:   Mon, 24 Jun 2019 07:45:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624105800.GD32376@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 12:45:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/19 5:58 AM, Jan Kara wrote:
> On Fri 21-06-19 18:27:13, Eric Sandeen wrote:
>> The code in quota_getstate and quota_getstatev is strange; it
>> says the returned fs_quota_stat[v] structure has room for only
>> one type of time limits, so fills it in with the first enabled
>> quota, even though every quotactl command must have a type sent
>> in by the user.
>>
>> Instead of just picking the first enabled quota, fill in the
>> reply with the timers for the quota type that was actually
>> requested.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> I guess this is a change in behavior, but it goes from a rather
>> unexpected and unpredictable behavior to something more expected,
>> so I hope it's ok.
>>
>> I'm working on breaking out xfs quota timers by type as well
>> (they are separate on disk, but not in memory) so I'll work
>> up an xfstest to go with this...
> 
> Yeah, makes sense. I've added the patch to my tree.
> 
> 								Honza
> 

Thanks Jan - if you'd like to fix my "quote" for "quota" in the
subject line, please feel free.  ;)

-Eric
