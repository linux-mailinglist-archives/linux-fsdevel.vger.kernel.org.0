Return-Path: <linux-fsdevel+bounces-131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2AE7C602B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE5282619
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 22:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3FD3FB36;
	Wed, 11 Oct 2023 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="tOT9/3rg";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="biLKBP9H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F71BDE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 22:09:44 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF45A9;
	Wed, 11 Oct 2023 15:09:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 58F4360152;
	Thu, 12 Oct 2023 00:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697062179; bh=6wUwXu3t7Gckky7HKI6eDTMXYXcs5vo82bMnXb4UUDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOT9/3rgnQy2W+sBb84pIL0YB4w8yoiYcM9WVtH7NEYQ4DdALejQZ7qCo4B/+4qbJ
	 Vqw6JsXyKn9Mdo5fY8+4K8C+GFkIVg+MywibbMDHjWBSp+zTJS6eCxmDWAXm3Wgt5b
	 xp7iAaZGIZajSjXnA3a99QgEh2SAX2gq/2zRd0FaE59fLWwKGvbyzSJyvYfXSGnzlj
	 Vx2S+pYnuvUC14/jL5AHV3ke1c6/m86wk5EJi8pGxprtDxdgYhyUBPrmDZSuJcDk3A
	 s0CjruKh8CqBJrEw2AFkPkYKosMRzbb0a3Jag8nH+/4vsBqhGNgLCvvbIqD6n3KF61
	 /5ZzpIVqOI04Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4l_w5DQCLSvN; Thu, 12 Oct 2023 00:09:28 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-43.adsl.net.t-com.hr [78.1.184.43])
	by domac.alu.hr (Postfix) with ESMTPSA id 626836013C;
	Thu, 12 Oct 2023 00:09:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697062168; bh=6wUwXu3t7Gckky7HKI6eDTMXYXcs5vo82bMnXb4UUDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=biLKBP9HXaDMesiqXKMQ1wGqgqWMiK6K1If429I6H6BQCn9P+WCn+S1a9RSZZapHk
	 pu/UmowjnY0vcFVuiwF6oKp4bY6TQ5vO5Vv0gqT+ykAiYNRsA9lrCVn5Xkp4p5KV2R
	 T1TQetSPl3RCHRbS9pWsU3rakQKNfPXck3MxeQL5Iwk4IWjQgRPb+yK5rKcEo6o9SX
	 YRsOmov5bFm4lWjSmcN+ecxqbYyjgL9muredba5uRwHceLJWJXw2CFniQPLBfjxoaf
	 eFgJlhyYh1yDEZ0u79UDCcfXTzm4JroW2/4SanwLNyesnQpsvgDNqj/MMLoW6eYpAE
	 1KQG/ivzQhOSA==
Message-ID: <1b030e7d-1d8d-4c77-a6a0-870794090661@alu.unizg.hr>
Date: Thu, 12 Oct 2023 00:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc: Matthew Wilcox <willy@infradead.org>, Yury Norov <yury.norov@gmail.com>,
 Philipp Stanner <pstanner@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org
References: <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad> <20230918155403.ylhfdbscgw6yek6p@quack3>
 <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
 <ZQidZLUcrrITd3Vy@yury-ThinkPad> <ZQkhgVb8nWGxpSPk@casper.infradead.org>
 <2c7f2acd-ef37-4504-a0e3-f74b66c455ec@alu.unizg.hr>
 <20231009101550.pqnkrp5cp5zbr3lr@quack3>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231009101550.pqnkrp5cp5zbr3lr@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/9/23 12:15, Jan Kara wrote:
> On Fri 06-10-23 16:39:54, Mirsad Todorovac wrote:
>> On 9/19/2023 6:20 AM, Matthew Wilcox wrote:
>>> On Mon, Sep 18, 2023 at 11:56:36AM -0700, Yury Norov wrote:
>>>> Guys, I lost the track of the conversation. In the other email Mirsad
>>>> said:
>>>>           Which was the basic reason in the first place for all this, because something changed
>>>>           data from underneath our fingers ..
>>>>
>>>> It sounds clearly to me that this is a bug in xarray, *revealed* by
>>>> find_next_bit() function. But later in discussion you're trying to 'fix'
>>>> find_*_bit(), like if find_bit() corrupted the bitmap, but it's not.
>>>
>>> No, you're really confused.  That happens.
>>>
>>> KCSAN is looking for concurrency bugs.  That is, does another thread
>>> mutate the data "while" we're reading it.  It does that by reading
>>> the data, delaying for a few instructions and reading it again.  If it
>>> changed, clearly there's a race.  That does not mean there's a bug!
>>>
>>> Some races are innocuous.  Many races are innocuous!  The problem is
>>> that compilers sometimes get overly clever and don't do the obvious
>>> thing you ask them to do.  READ_ONCE() serves two functions here;
>>> one is that it tells the compiler not to try anything fancy, and
>>> the other is that it tells KCSAN to not bother instrumenting this
>>> load; no load-delay-reload.
>>>
>>>> In previous email Jan said:
>>>>           for any sane compiler the generated assembly with & without READ_ONCE()
>>>>           will be exactly the same.
>>>>
>>>> If the code generated with and without READ_ONCE() is the same, the
>>>> behavior would be the same, right? If you see the difference, the code
>>>> should differ.
>>>
>>> Hopefully now you understand why this argument is wrong ...
>>>
>>>> You say that READ_ONCE() in find_bit() 'fixes' 200 KCSAN BUG warnings. To
>>>> me it sounds like hiding the problems instead of fixing. If there's a race
>>>> between writing and reading bitmaps, it should be fixed properly by
>>>> adding an appropriate serialization mechanism. Shutting Kcsan up with
>>>> READ_ONCE() here and there is exactly the opposite path to the right direction.
>>>
>>> Counterpoint: generally bitmaps are modified with set_bit() which
>>> actually is atomic.  We define so many bitmap things as being atomic
>>> already, it doesn't feel like making find_bit() "must be protected"
>>> as a useful use of time.
>>>
>>> But hey, maybe I'm wrong.  Mirsad, can you send Yury the bug reports
>>> for find_bit and friends, and Yury can take the time to dig through them
>>> and see if there are any real races in that mess?
>>>
>>>> Every READ_ONCE must be paired with WRITE_ONCE, just like atomic
>>>> reads/writes or spin locks/unlocks. Having that in mind, adding
>>>> READ_ONCE() in find_bit() requires adding it to every bitmap function
>>>> out there. And this is, as I said before, would be an overhead for
>>>> most users.
>>>
>>> I don't believe you.  Telling the compiler to stop trying to be clever
>>> rarely results in a performance loss.
>>
>> Hi Mr. Wilcox,
>>
>> Do you think we should submit a formal patch for this data-race?
> 
> So I did some benchmarking with various GCC versions and the truth is that
> READ_ONCE() does affect code generation a bit (although the original code
> does not refetch the value from memory). As a result my benchmarks show the
> bit searching functions are about 2% slower. This is not much but it is
> stupid to cause a performance regression due to non-issue. I'm trying to
> get some compiler guys look into this whether we can improve it somehow...
> 
> 								Honza

Dear Jan,

First, I am not an expert or an authority on the subject, this is only
my opinion.

IMHO, 2% slower code is acceptable if it gives us data integrity. If a
16-core system manages to break and tear loads without READ_ONCE(), 2%
faster code gives us nothing if the other core changes half of the location
in the midst of the load, just because the optimiser did some "funny stuff".

If I had a pacemaker and it is running Linux kernel, I would probably choose
2% slower but race-free code.

Please allow me to assert that this is not a spin lock, memory bus lock,
or a memory barrier that would affect the other cores - it will only slightly
prevent some read reordering/tearing.

I think you are on the good track, and that this patch is a good thing.

Low-level functions have to be first safe, then fast.

A faster algorithm, like replacing spinlocks with RCU, can certainly more
than make up for that ...

Sorry for a digression.

Best regards,
Mirsad

