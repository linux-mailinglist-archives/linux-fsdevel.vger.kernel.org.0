Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96D81571F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJJny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 04:43:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJJny (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:43:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D776B15D;
        Mon, 10 Feb 2020 09:43:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Feb 2020 10:43:47 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Max Neunhoeffer <max@arangodb.com>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
In-Reply-To: <20200209215916.15640598689d3e40aa3f9e72@linux-foundation.org>
References: <20200203205907.291929-1-rpenyaev@suse.de>
 <51f29f23a4d996810bfad12b9634ee12@suse.de>
 <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net>
 <549916868753e737316f509640550b66@suse.de>
 <20200209215916.15640598689d3e40aa3f9e72@linux-foundation.org>
Message-ID: <55c054e4c52c1e659cfa5f38a5e37571@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-02-10 06:59, Andrew Morton wrote:
> On Tue, 04 Feb 2020 18:20:03 +0100 Roman Penyaev <rpenyaev@suse.de> 
> wrote:
> 
>> On 2020-02-04 17:32, Jakub Kicinski wrote:
>> > On Tue, 04 Feb 2020 11:41:42 +0100, Roman Penyaev wrote:
>> >> Hi Andrew,
>> >>
>> >> Could you please suggest me, do I need to include Reported-by tag,
>> >> or reference to the bug is enough?
>> >
>> > Sorry to jump in but FWIW I like the Reported-and-bisected-by tag to
>> > fully credit the extra work done by the reporter.
>> 
>> Reported-by: Max Neunhoeffer <max@arangodb.com>
>> Bisected-by: Max Neunhoeffer <max@arangodb.com>
>> 
>> Correct?
> 
> We could do that, but preferably with Max's approval (please?).
> 
> Because people sometimes have issues with having their personal info
> added to the kernel commit record without having being asked.

Max approved.  I've just resent v2, no code changes, comment
tweaks and 2 explicit tags with Max's name.

--
Roman

