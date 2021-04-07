Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6BC35771A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 23:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhDGVqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 17:46:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40791 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234143AbhDGVqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:46:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A3655C005D;
        Wed,  7 Apr 2021 17:46:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Apr 2021 17:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=r69jFNtPYMJmCAhPcCZ3L+qjCl
        ChR6gNTOq2XMQYtQQ=; b=OqQIvQ1uZKwgHjj/kcphq7iaZ7o9yTt9CctVAeDj6+
        hTF6QX1cHj6JHh87LQGCi0dqRyry8cLpLbERV6D1b1eK4g8E+WgYi2eT27OhO3uD
        RzhryrfCxH6gxMBE2hwPAxaSsscfWIGgvdquY8uG98jJJ1kCSZllT1z0MYyAu3O2
        hwlEqRXIUXokV7s/ZyvzE4OXj8DPS3G8iA0iX6nq1Xkdrh6yti0dt2qBSOPIxjQN
        5fNtwF6P7sgGitE31umRXXEvh+8ilR1sN/nb2xvQxtzsE1w9exHDTwg56gFdYVqI
        qqpERmBSR4KkFaIP8ogzBGtfzUauFkfiYlZ6oqXQSAbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=r69jFNtPYMJmCAhPc
        CZ3L+qjClChR6gNTOq2XMQYtQQ=; b=lLc4lLXaLNeqrRCFt5Pso8k9QTg8KQYrS
        bodqzIjYCxBsY4IvSyEbOLopro7UhqXyKNjcUyBGAejGk5JYsvWhW/va+HQsm/Jx
        j0HdwXrNZDlEd+EqQvZiAlwELfR0hwvJ06zqx5mfekVEEgcSOiamPhQ2GaOz0SKt
        4jnzSIV3nAtl8p64DVl94nFic9fF80gJvVR5EWDwREf6lmLcgW5ytXjR+uQF/rZW
        wCPNU9opn/QnVI+iKFPaeobKkleBRuC3//dQjIBV0wBTl8FeEG3F4uRsbXC9KuhE
        tOxItTX6p4fiQz9TyhTSY0py2kZwo8xTffT4DmUUOPpFejfjf4XNA==
X-ME-Sender: <xms:OShuYIdl7otXIPPxEF_bCMFdEEjcQd1XOMHPXbZm-xjEuQjz4tBcHA>
    <xme:OShuYKOgIrakxBlSWq9SyqNCmApjYVPKrQVnaMM_B75rwxkUq-w7HMvcdfs5F4VeG
    -ZJWNIPUzKG3gH-xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucfkphepudeifedruddugedrudef
    vddrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:OShuYJgvtRB1COqJ7NeuHRqjw580JpVqzl0dOWcTfN7vi5yIWXU3Gg>
    <xmx:OShuYN8_69oDFjoWb0xBfH5nf1bIZ4yGIBx6LlThBYV1IHGwKs3zhg>
    <xmx:OShuYEtQZBEKgSgXGAZZT8flBiHC17L0GdbJqTO5tFK8NtwLvDa_xA>
    <xmx:OShuYIg67LADkOcavzQmxLDA9p5x2pU5XMvPIBphZ04gNzAfd4MUjg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4484124005A;
        Wed,  7 Apr 2021 17:46:31 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: [RFC bpf-next 0/1] bpf: Add page cache iterator
Date:   Wed,  7 Apr 2021 14:46:10 -0700
Message-Id: <cover.1617831474.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There currently does not exist a way to answer the question: "What is in
the page cache?". There are various heuristics and counters but nothing
that can tell you anything like:

  * 3M from /home/dxu/foo.txt
  * 5K from ...
  * etc.

The answer to the question is particularly useful in the stacked
container world. Stacked containers implies multiple containers are run
on the same physical host. Memory is precious resource on some (if not
most) of these systems. On these systems, it's useful to know how much
duplicated data is in the page cache. Once you know the answer, you can
do something about it. One possible technique would be bind mount common
items from the root host into each container.

NOTES: 

  * This patch compiles and (maybe) works -- totally not fully tested
    or in a final state

  * I'm sending this early RFC to get comments on the general approach.
    I chatted w/ Johannes a little bit and it seems like the best way to
    do this is through superblock -> inode -> address_space iteration
    rather than going from numa node -> LRU iteration

  * I'll most likely add a page_hash() helper (or something) that hashes
    a page so that userspace can more easily tell which pages are
    duplicate

Daniel Xu (1):
  bpf: Introduce iter_pagecache

 kernel/bpf/Makefile         |   2 +-
 kernel/bpf/pagecache_iter.c | 293 ++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/pagecache_iter.c

-- 
2.26.3

