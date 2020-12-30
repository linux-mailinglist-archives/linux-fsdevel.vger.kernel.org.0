Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578642E7684
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 07:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgL3G32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 01:29:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33821 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgL3G31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:29:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 13D615C019C;
        Wed, 30 Dec 2020 01:28:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Dec 2020 01:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm3; bh=PSUMEHHqwnwguq8Haku3EVH3D6D0Gt/lLRo2eiPEe0o=; b=fuKuekFK
        cF/8jEQv8NF5on28Z871ZPMKXLp+ZXcLLu00fvBCjDnv+n/SJgFe2pd++vniJBxN
        2QbtNDtahBPPIl8ryDxc7k9awzhvSdGTWSQWs6e62+WegeTbBnvAQErBVA/wf5jq
        DxsdL3mT0ltj/WlNIaGzYQI/jO099rWzu9V1iR1LFYOy6fgqXV5TaeevVvn27+bg
        Q9g1R8TYrB7xflo8vt2rapZmN3KnNI6pW/DpXqV2XfmhYKQWw/3jE90qnRqg22JA
        QEjNPcss//4wista67VxEt6pozqoLobosAceSABieftnichlpGKb9HGpqOEdl1DW
        W8ei38apZc272Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=PSUMEHHqwnwguq8Haku3EVH3D6D0G
        t/lLRo2eiPEe0o=; b=I0OlXwWsmBDeTTNcPsdFVhAeIK8NN0j1UauJbqrmf5KzC
        2gKECnphBp2jXNv0fIntsuLc4u5N9AaHc5YxghWhJSSaRhvZI8CE2GwacAOCMMyW
        FBlE2+slketILpz9psOgdWdcb54ox5iwJGajIMuXS1fvTowD4xRmm0u1gA5Z01Se
        CgItG60tKAuKQdfxmyjipL4EemHjzp7Ii5kqE/HssD+ZNqG1LCAtAer7CVbFbdXi
        K2/PfXU0Db+KNw/MQ1jjQDgKdpWPQFQrzYH/H1sf3RIHXjPkiS3mxi5dlUxj+a6D
        VkDBpEeECSvt01mh76q5mV+hAauJSIZ/kxsL3sXIA==
X-ME-Sender: <xms:BB7sXxUnK5Zzf5wujRTYGtL9qYIQu69ib7Ub8gVVBTulW_DJYRkrHA>
    <xme:BB7sXxmezjpN-rVBTABnCSEETb4qC0GxjRX2UllR9P1RHXFcL-ebjX4XN7hhkjy3b
    1kJR9v-mzsIDYFv7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghr
    rgiivghlrdguvgeqnecuggftrfgrthhtvghrnhepiedvieelgeeuuedtfeduhfefteehhf
    evvdeljeetgfeugfdtledtudetvdehkeffnecukfhppeeijedrudeitddrvddujedrvdeh
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:BB7sX9YecBCwvVMo-tZAhFK20KMo4cnymrxtmhZxEKaGuaGtAoHLaw>
    <xmx:BB7sX0XRnAFwaurnjiZqrk3TGQQczic3lbksC6CgRmp0B4NQqbKqDg>
    <xmx:BB7sX7ncqJEqlX3apBiIi8z1kPRPmN891tR-c_37jzMc8FOp-bICpg>
    <xmx:BR7sXzvggNA85j3J6J4ZjUuROXnuPAgoiVGcsUlHHNVSs9spzz8KGg>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id B79F824005C;
        Wed, 30 Dec 2020 01:28:20 -0500 (EST)
Date:   Tue, 29 Dec 2020 22:28:19 -0800
From:   Andres Freund <andres@anarazel.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

For things like database journals using fallocate(0) is not sufficient,
as writing into the the pre-allocated data with O_DIRECT | O_DSYNC
writes requires the unwritten extents to be converted, which in turn
requires journal operations.

The performance difference in a journalling workload (lots of
sequential, low-iodepth, often small, writes) is quite remarkable. Even
on quite fast devices:

    andres@awork3:/mnt/t3$ grep /mnt/t3 /proc/mounts
    /dev/nvme1n1 /mnt/t3 xfs rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0

    andres@awork3:/mnt/t3$ fallocate -l $((1024*1024*1024)) test_file

    andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
    262144+0 records in
    262144+0 records out
    1073741824 bytes (1.1 GB, 1.0 GiB) copied, 117.587 s, 9.1 MB/s

    andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
    262144+0 records in
    262144+0 records out
    1073741824 bytes (1.1 GB, 1.0 GiB) copied, 3.69125 s, 291 MB/s

    andres@awork3:/mnt/t3$ fallocate -z -l $((1024*1024*1024)) test_file

    andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
    z262144+0 records in
    262144+0 records out
    1073741824 bytes (1.1 GB, 1.0 GiB) copied, 109.398 s, 9.8 MB/s

    andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
    262144+0 records in
    262144+0 records out
    1073741824 bytes (1.1 GB, 1.0 GiB) copied, 3.76166 s, 285 MB/s


The way around that, from a database's perspective, is obviously to just
overwrite the file "manually" after fallocate()ing it, utilizing larger
writes, and then to recycle the file.


But that's a fair bit of unnecessary IO from userspace, and it's IO that
the kernel can do more efficiently on a number of types of block
devices, e.g. by utilizing write-zeroes.


Which brings me to $subject:

Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
doesn't convert extents into unwritten extents, but instead uses
blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
myself, but ...

Doing so as a variant of FALLOC_FL_ZERO_RANGE seems to make the most
sense, as that'd work reasonably efficiently to initialize newly
allocated space as well as for zeroing out previously used file space.


As blkdev_issue_zeroout() already has a fallback path it seems this
should be doable without too much concern for which devices have write
zeroes, and which do not?

Greetings,

Andres Freund
