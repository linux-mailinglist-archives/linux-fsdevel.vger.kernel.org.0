Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEBDD13F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfJIQ0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 12:26:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:51280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731417AbfJIQ0o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:26:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C45A5ADCC;
        Wed,  9 Oct 2019 16:26:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Oct 2019 18:26:42 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     hev <r@hev.cc>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: add epoll selftests
In-Reply-To: <20191009121518.4027-1-r@hev.cc>
References: <20191009121518.4027-1-r@hev.cc>
Message-ID: <05a68675068aefd836751e9ef3ef5ef8@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-10-09 14:15, hev wrote:
> From: Heiher <r@hev.cc>
> 
> This adds the promised selftest for epoll. It will verify the wakeups
> of epoll. Including leaf and nested mode, epoll_wait() and poll() and
> multi-threads.

Nice! The only thing I doubt this suite should be a part of 
filesystems/,
maybe one level up, i.e. selftests/epoll?

Reviewed-by: Roman Penyaev <rpenyaev@suse.de>

--
Roman

