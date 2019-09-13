Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1DB252E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfIMSXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 14:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387802AbfIMSXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:23:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52ACE10C0515;
        Fri, 13 Sep 2019 18:23:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-105.rdu2.redhat.com [10.10.125.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C6FC5C1D4;
        Fri, 13 Sep 2019 18:23:44 +0000 (UTC)
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
 <b7d7d109-03cf-d750-3a56-a95837998372@redhat.com>
 <87ac9e4f-9301-9eb7-e68b-a877e7cf0384@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3d98ea00-ea0d-a9b1-9e1a-e78a731c20a5@redhat.com>
Date:   Fri, 13 Sep 2019 14:23:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87ac9e4f-9301-9eb7-e68b-a877e7cf0384@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 13 Sep 2019 18:23:46 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/12/19 5:43 PM, Mike Kravetz wrote:
> On 9/12/19 2:06 AM, Waiman Long wrote:
>> If we can take the rwsem in read mode, that should solve the problem
>> AFAICS. As I don't have a full understanding of the history of that
>> code, I didn't try to do that in my patch.
> Do you still have access to an environment that creates the long stalls?
> If so, can you try the simple change of taking the semaphore in read mode
> in huge_pmd_share.
>
That is what I am planning to do. I don't have an environment to
reproduce the problem myself. I have to create a test kernel and ask the
customer to try it out.

Cheers,
Longman

