Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1AE725A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 14:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfJ1NF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 09:05:59 -0400
Received: from albireo.enyo.de ([37.24.231.21]:37754 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfJ1NF7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:05:59 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iP4iW-0007eV-DQ; Mon, 28 Oct 2019 13:05:52 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iP4iW-0008D3-8w; Mon, 28 Oct 2019 14:05:52 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
References: <157225848971.557.16257813537984792761.stgit@buzz>
        <87k18p6qjk.fsf@mid.deneb.enyo.de>
        <d7e76bee-80c3-d787-b854-91e631ab29cd@yandex-team.ru>
Date:   Mon, 28 Oct 2019 14:05:52 +0100
In-Reply-To: <d7e76bee-80c3-d787-b854-91e631ab29cd@yandex-team.ru> (Konstantin
        Khlebnikov's message of "Mon, 28 Oct 2019 15:55:19 +0300")
Message-ID: <87ftjd6mvj.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Konstantin Khlebnikov:

> On 28/10/2019 14.46, Florian Weimer wrote:
>> * Konstantin Khlebnikov:
>> 
>>> This implements fcntl() for getting amount of resident memory in cache.
>>> Kernel already maintains counter for each inode, this patch just exposes
>>> it into userspace. Returned size is in kilobytes like values in procfs.
>> 
>> I think this needs a 32-bit compat implementation which clamps the
>> returned value to INT_MAX.
>> 
>
> 32-bit machine couldn't hold more than 2TB cache in one file.
> Even radix tree wouldn't fit into low memory area.

I meant a 32-bit process running on a 64-bit kernel.
