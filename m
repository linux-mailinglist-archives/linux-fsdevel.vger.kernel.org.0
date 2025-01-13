Return-Path: <linux-fsdevel+bounces-39010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188AA0B02D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1537E1661D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA0232369;
	Mon, 13 Jan 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="RrtVxu6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657414D29B;
	Mon, 13 Jan 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754121; cv=none; b=a0OPOlvzRfExF9qLEUBzCg2mN9XZIOyoXGB3JlPcZqa1IvXN5U69OmTRjg5kEEs+sSeTKfd2oHcH6jrcjPrUo0AJp2t/r4Md5vVSZIa5yVC2tybYU+L2tJKcXi+xW2f85Qbcf7NzYTPqdPTfTkm+K7cYOgYgdzVcer3lK1FUU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754121; c=relaxed/simple;
	bh=erV4qocinVfq88RGwRYxwpGSQtB+UbXtz3wHVw0D+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQmoB0LydjYvWlBX+fqjUH5GYjrBvMcoIxfZlOg6mI3/wagVA6MzPOCeK8g6m6TmNqDNAQ9kdNvL7hijA0azgGr/nJkNTpLtLt5u/IpTphO/ZUVB2sjtYWQNtrE3mUH/iLQ6Wke3kGXYb/gi9ge1I++b/xRTH+P+5r4PsjtEPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=RrtVxu6X; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736754116; x=1737358916; i=aros@gmx.com;
	bh=mnDnv5YGQylu2gHiqNx1u2i1OY/up+5AHicDsgBNVyI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RrtVxu6XSv0K269IUtHZEYTuDEm36sBHvkDdILgw41KsjN72nhuGIwzGq935J/4t
	 BL9j4YmUljBfTqI9AK7TYESASODNSc5BptApver7qeFVsJ8AhpWPsAwzYt4iR1aS5
	 +4KcgecivzSFIFz1NBAIylxYxeR7dn7GOmpYH6UhbqI96EIQgWLiRvVpkD6zT/mKp
	 aeiMPOe/bbKEBK9DID5p2apLrfpX7qUh+mQIyyjg5cFyBibCzL8RIidGx09gaEPH1
	 ZzPJvrCZ565+N79ASz2OR3WE7nRCqgDO3WlVA68V2LF+FFTk2zE6xfp9l1Yg3ceHh
	 edg43ssJVPMAxRoVtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.22.12.51] ([98.159.234.105]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UUy-1tXn300fI2-009DkJ; Mon, 13
 Jan 2025 08:41:56 +0100
Message-ID: <8a395f69-ce4a-418a-b4a9-30ed83e0fbef@gmx.com>
Date: Mon, 13 Jan 2025 07:41:53 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
 <20250112052743.GH1323402@mit.edu>
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20250112052743.GH1323402@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:76J1IVpNbBrR8J6hWRMWlzilMn+0NqLwCu1OFQ5xo/WdhUoZqRN
 /B4Ql40GXxYLNfUeopHXhyJAWBdbOKiasmkfuH3vucIrgRpXcPjI/dyinCWgz4qifwY80QO
 BYQmudiaxYMDIHEiiuj/hA6PxdvRk2SnEwt9gBF4wMqryVAxO58bjB8I4NzKOfjk+IJjzxq
 IX2kRz27p45pZz6Q5yJbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLHJL3AkpXA=;hKTJjR2X8HHf0OCwhBMGVlZFwcg
 IOyhcax6zDqT3OZtGRKfWC5E0yK1zKaD5eMCBwRSBrKWMH5nsfE99QWT4zOFg+CSG7V3myOcQ
 BVBoEEXeDaGuVAbtxWqREEK2jkfKIqpB/fu+C5NGKkmSXnjqkDbZtK4xp7BD50aC8uJi82LmF
 8X3KdQf7mJarqZcGnv1u539f4Nd1Wjl4aZCiMQeN6tMQ+Pg58EcKHqjBxWck1zlw/AqibE2oM
 Mz8kQ/UQv7ErmT72KH2BHtISyFRGj6NA2m9XZzzcVeB9OSWXroNKl3PeBmr14LR7V1+YFjSxZ
 rszDU5oxWDg461HMGqur/i+Scw4Llu4khCPVMEVeIkm2fXsDJ8KMTUcJeHDi/qCcA56vHoeN7
 w4f/rOx9bmYFgpzF1h6eWFp/gMHCkcBcTFEJl9IpGtPjbzRz7UeAPCHr9QvXqm7p+W5kkHM/E
 CbPKW8y7gzdp3LLjBd4K/zkRDHtY3w3jlRZ4DPv9yfkdenKqMKRKcB6v4/+s5vljAAAMOhP2A
 KYm+19HB5XwfzrHwocjKd4t3jYoWUtckQ9nFVCRaQ7WRxB/MsX3R1Iu+BtHn2vjc0ag0Irqpb
 jwM96H85c2ZkywJ0Mh4NC1L0maqR31+m4hMQKovnNyydowz7A6WpVfz6126VQU5RURnzQBq9S
 4zpGihXZPsRvM+mcLISGD1geLqv9GxiuzscGz/7W8XFxVhFIYI8i++rfBIXhzxFm6RP8fWRR7
 E5+6619JOj4s+8o5Y8DETvF8BbG+aTi45rOtuaeO/arg/OFw4KsvG+I5F5NJDe22Llrd2jydI
 bvIxgzCWGFA/8LNqYgmM9xTB7XKpg66qvVMxhlA1qJnXli4ewBE0DZaKRlRr398L8K02X9jX5
 2OQCIaARuAk42cWnTH/HxgS/ECtGK/vvy7Wv9McXp7cn+aUYIGvtJ200v1f5r8RBovG8pMVD0
 i3j5BxAGxkQ7kk8zzECTdmomRN3Ojqmo9oFuwrAazcDjlVo6WlVz5o3Ph7CPA4FYB9Og5LfyL
 ndCyb5FyHDBL4E3JFB9Ia52ULW71IVqR9zp9PtTlcJJ3krpqCvoUTfpbY3YI70Vdw/IM5ieKp
 XuK2xntHE/KKyIShcpHFF9XRkBg1zV

My use case wasn't about the journal per se, I'm not using it for my
ext4 partitions.

Correct me if I'm wrong but I was thinking about this:

=3D=3D Issue number one =3D=3D

Let's say you chmod two files sequentially:

What's happening:

1) the kernel looks up an inode
2) the kernel then updates the metadata (at the very least one logical
block is being written, that's 4K bytes)

ditto for the second file.

Now let's say we are updating 10000 files.

Does this mean that at least 40MB of data will be written, when probably
less than 500KB needs to be written to disk?

=3D=3D Issue number two =3D=3D

At least when you write data to the disk, the kernel doesn't flush it
immediately and your system remains responsive due to the use of dirty
buffers.

For operations involving metadata updates, the kernel may not have this
luxury, because the system must be in a consistent state even if it's
accidentally or intentionally powered off.

So, metadata updates must be carried out immediately, and they can bring
the system to a halt while flushing the above 40MB of data, as opposed
to the 500KB that needs to be updated in terms of what is actually being
updated on disk.

So, the feature I'm looking for would be to say to the kernel: hey I'm
about to batch 10000 operations, please be considerate, do your thing in
one fell swoop while optimizing intermediate operations or writes to the
disk, and there's no rush, so you may as well postpone the whole thing
as much as you want.

Best regards,
Artem

On 1/12/25 5:27 AM, Theodore Ts'o wrote:
> On Sat, Jan 11, 2025 at 09:17:49AM +0000, Artem S. Tashkinov wrote:
>> Hello,
>>
>> I had this idea on 2021-11-07, then I thought it was wrong/stupid, now
>> I've asked AI and it said it was actually not bad, so I'm bringing it
>> forward now:
>>
>> Imagine the following scenarios:
>>
>>   * You need to delete tens of thousands of files.
>>   * You need to change the permissions, ownership, or security context
>> (chmod, chown, chcon) for tens of thousands of files.
>>   * You need to update timestamps for tens of thousands of files.
>>
>> All these operations are currently relatively slow because they are
>> executed sequentially, generating significant I/O overhead.
>>
>> What if these operations could be spooled and performed as a single
>> transaction? By bundling metadata updates into one atomic operation,
>> such tasks could become near-instant or significantly faster. This woul=
d
>> also reduce the number of writes, leading to less wear and tear on
>> storage devices.
>
> As Amir has stated, pretty much all journalled file systems will
> combine a large number of file system operations into a single
> transation, unless there is an explicit request via an fsync(2) system
> call.  For example, ext4 in general only closes a journal transaction
> every five seconds, or there isn't enough space in the journal
> (athough in practice this isn't an issue if you are using a reasonably
> modern mkfs.ext4, since we've increased the default size of the
> journal).
>
> The reason why deleting a large number of files, or changing the
> permissions, ownership, timestamps, etc., of a large number of files
> is because you need to read the directory blocks to find the inodes
> that you need to modify, read a large number of inodes, update a large
> number of inodes, and if you are deleting the inodes, also update the
> block allocation metadata (bitmaps, or btrees) so that those blocks
> are marked as no longer in use.  Some of the directory entries might
> be cached in the dentry cache, and some of the inodes might be cached
> in the inode cache, but that's not always the case.
>
> If all of the metadata blocks that you need to read in order to
> accomplish the operation are already cached in memory, then what you
> propose is something that pretty much all journaled file systems will
> do already, today. That is, the modifications that need to be made to
> the metadata will be first written to the journal first, and only
> after the journal transaction has been committed, will the actual
> metadata blocks be written to the storage device, and this will be
> done asynchronously.
>
> In pratice, the actual delay in doing one of these large operations is
> the need to read the metadata blocks into memory, and this must be
> done synchronously, since (for example), if you are deleting 100,000
> files, you first need to know which inodes for those 100,000 files by
> reading the directory blocks; you then need to know which blocks will
> be freed by deleting each of those 100,000 files, which means you will
> need to read 100,000 inodes and their extent tree blocks, and then you
> need to update the block allocation information, and that will require
> that you read the block allocation bitmaps so they can be updated.
>
>> Does this idea make sense? If it already exists, or if there=E2=80=99s =
a reason
>> it wouldn=E2=80=99t work, please let me know.
>
> So yes, it basically exists, although in practice, it doesn't work as
> well as you might think, because of the need to read potentially a
> large number of the metdata blocks.  But for example, if you make sure
> that all of the inode information is already cached, e.g.:
>
>     ls -lR /path/to/large/tree > /dev/null
>
> Then the operation to do a bulk update will be fast:
>
>    time chown -R root:root /path/to/large/tree
>
> This demonstrates that the bottleneck tends to be *reading* the
> metdata blocks, not *writing* the metadata blocks.
>
> Cheers,
>
> 				- Ted


