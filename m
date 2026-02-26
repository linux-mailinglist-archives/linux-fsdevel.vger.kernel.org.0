Return-Path: <linux-fsdevel+bounces-78433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iICcHkC3n2mKdQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:00:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4E1A0455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C112306147A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE9385531;
	Thu, 26 Feb 2026 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2EJNt8fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB09385512
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074802; cv=pass; b=AMA317PEJHbhsFXOCYDngb4jfOoNmdP5k1rTRmvU7+ufpm2OCMv7Vo2AY94RswB1FcDm4Chz2IxrruFX7SkF76CqdO2W7yyQ/vmDTV/ELUblOIboswFZVDWxMbd4fJt1x150yLfSpFdqc4CkZ6YmxgZNi/BVn5HWI6jxp7hd5dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074802; c=relaxed/simple;
	bh=/aZyyGLLkO7o9RiI3yBwvqEMpXbBUdrnEXILdc8vy+c=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=jN4BcCNwWe8OCnwsgJsCXRZ55CxPbNveJaY+MtLWmxx9Ku8dL8yTpJHtygVIR5g6+SbkpAdX53f0Ih/E037qgDpS5MgYS5avAKsreit5u7WZydddmM1Jo/INWL2blS+bZ+t+TyGo541JERycbWTe8uYal/cbmUJZq3D7ftvHjzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2EJNt8fv; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso295503241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 18:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772074798; cv=none;
        d=google.com; s=arc-20240605;
        b=UJnBtQfrwZ36lslz5/aWlgBdAPuTi3ebnnnhB9Vkt7hvRC0YtiVvcC7PSditV0UvQe
         UG6t9JaFrUZtxe/Va0EaVHFd/+pfOl7iImtb9dMIyEwPn5ptKqaK1b1kbADPk7xs5cy+
         bo44MjFObGpYEOo0MEZVuGoXVJAM1zlP+UXvnIEVAWhUZ7rBKcwb03L1DgDSNJYImzy6
         m7HFf97eSabuzW/mFvLJyEtKvP5rYT2shNsytkCIfqVWdhfUOGzRN/5SnRIOR0k/QLBB
         Koj+FNc1pxA9d9pXxTZkrommtO9qOUtz1N31W48DrmTO1Y5Q/t0x0s0RYrifFAuSl2/v
         6MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=8F8DPv1+8kXX8FrzoNjsuCyL9jUTbkIPz4J+MH2Hlts=;
        fh=Vs/oAIaEoq/jewLmkz3VoscL8LXnl5Zb3e737rSY9vw=;
        b=jH3N8VzusdLyDh0fkjecySiq5uD/2rcjhGBI8sayycgQHjG7uhD+jV46+dJOq99GQx
         dyFx/9fa0cWRBn87UPPYTz/uQ0uCptf+vB+gI5lXXE8/u7kRBAh9kYDxU0cOhvkgDYhv
         ygBEIiKg1DHaBLYr3bbSdHmJZ94jhwy2al/W8ac+t1TNCbltInawyR4dFOmslT1SxhWv
         q+relsr0U6cGN6mmx8WwRas8tObmg0ym3rD5MFeXhPhBiv/Ju6ldtvxziMh00u8HyFkI
         VKkYPGJPgbK1HdP6ApFBDaZwTSI1ZEO91ibyz8QUhYHpLu1aoZzgq/fl5viUiV+3tjRG
         7MLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772074798; x=1772679598; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8F8DPv1+8kXX8FrzoNjsuCyL9jUTbkIPz4J+MH2Hlts=;
        b=2EJNt8fvakyf0B/QwyyYAdILk9OZtTQTnRWc0U+8b6Q9FSP04XwF2uJOiMOSiOtxnk
         qM5ROx5mM/u8V/US/+LnnLLbkrH2JRyORCs6UPPBC27/SfNMMHsuCLee6QSprPQibgjK
         NUcVDzmx+FjUpPx0n6WWOR5e3I1kOZEfQNh8tcToV/nQUj1W5W8hfUn3FJEExgLlAbF3
         CkPP2wzmADaDMNLrPKWIRTCbcV6X3ajelzgTE1ws3NfQk4gSFC1Rxmyi4yG7A5VRJdvF
         KxEGv0xLOB/7hSpArEQa/lVY8i/1d2EPM4rwNrMoGoRNQgXruaD1GNQtkL8sIv/1oYPk
         dHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772074798; x=1772679598;
        h=to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F8DPv1+8kXX8FrzoNjsuCyL9jUTbkIPz4J+MH2Hlts=;
        b=SRKOPAdCQ4/1PlzehhM0OCgkbXdthstAycxuYkhP9Th7JzhTMVEP5mUDIGW6oft0dc
         giEFE3cc2MrlLAkNTfuNICUKC7alqOLDWb9GogPYLPKaIs+nz+a1CqfVAwFB1mC2W1nk
         AOIAcgyKD25qoSAcRQFhZ60aS+k3A2de7TyNWM7a9ctm1rOZgUIS8CVnH4btyNDGfRhF
         YVyRECIeQSHZiUgAKXGzqYKYEMiQWJE9VxUauFSrr010lBljx8vJvSOOc7PU5hkOmhzy
         VlvVxB7kTINGWQ5cODPId0X6XPgE10Otr/mRSYA3aJRmIbaX1UUXYgNdt0XScXdKVkOh
         GQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjblTSsU0SRxBagUccTUzk525KGef+0WYqnFMLf8irTUEKhtsSJv8pgxUGs5uRlcuffAoduSkN3jkJ90Qh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lVaQekbVFIp6WQHQFNorJN79vbzn2OK4BnTgTONo53GIY/oz
	FgFH4G8VexgoI7sg/r/03FvG41RsZLQDoGK9j7daQnrS/8mfuY+/QcKnfqJ6JQ4POYn+utFjRuU
	ubWoehOBZNYLQMIt/MTOCR7A9KRcja+Nb5GPVTPhtseLaUzwJDK9Bk+3XuCk=
X-Gm-Gg: ATEYQzz16oH7+ePeG5VAQCcdyjreGWK7dwTr+JuLynLiWotkbolqgHBMHyqxQgMBWSu
	anoxvaXjF+T5443Htast/Sbvuc7rt9pmCnxxtbP8kxPcRrX2HQUFctyHGiRR39fxiaTVRySI4tZ
	1g3lpmGkSmLWcIHOIESvSu3bCD2b+jvuYfgDqNR+0Akdwd+0N5FCxQCbpovfcueaP5PfDEC5TTW
	dDxnwLqskVFrtR6uQVzVw2BVgP71ShJuUVgLfuQPylKpXh9um/JFOFoEpe4QMUxKJhXXSsjRJBL
	aoYWDVzhDU2exl6R2y0Bjr0wn+P2sPqEew6JxAfTvWoFktEPsJhG98p4HBIKBHMoS3NdYA==
X-Received: by 2002:a05:6102:418d:b0:5f1:bcb3:5577 with SMTP id
 ada2fe7eead31-5ff20c30c12mr353313137.32.1772074797488; Wed, 25 Feb 2026
 18:59:57 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 18:59:56 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 18:59:56 -0800
From: Ackerley Tng <ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2026 18:59:56 -0800
X-Gm-Features: AaiRm50M8XWgDMJ9cOTMEwCcIKXEzhH3SzAKiIj_3KCzzjf8AvWJgkzJ68SfaSI
Message-ID: <CAEvNRgFvHNH6GwuY5yLYD+0OK19mC3pRJKDBR=HsKgym=rghWA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Opening HugeTLB up for more generic use
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78433-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECA4E1A0455
X-Rspamd-Action: no action

Hi all,

I would like to propose to open HugeTLB up for more generic use.

Motivation
==========

This proposal was motivated by guest_memfd needing to provide huge
pages. guest_memfd wraps existing allocators to provide memory for
backing KVM virtual machines, and wants to use HugeTLB as a source of
huge pages.

Proposal details
================

The proposal is to (re)think the in-memory filesystems as memory
providers around memory sources:

| Memory Provider                | Memory Source            |
|--------------------------------|--------------------------|
| Anonymous (mmap(MAP_ANONYMOUS) | Buddy allocator          |
| Tmpfs/shmem                    | Buddy allocator          |
| HugeTLBfs                      | HugeTLB                  |
| guest_memfd                    | Buddy allocator, HugeTLB |

While working on HugeTLB and exploring HugeTLBfs vs HugeTLB, my
impression is that these two are overly coupled together and could
benefit from better conceptual separation, as well as code separation
between mm/hugetlb.c and fs/hugetlbfs/inode.c.

Status
======

I've been working on guest_memfd HugeTLB support for a while now, and
Google is in the process of qualifying guest_memfd HugeTLB
support. Here [1] is an earlier version of what's being qualified.

Here [2] is an RFC patch series, split out from [1] and updated, that
refactors the HugeTLB allocation routine for more generic use. I hope
this will serve as a starting point for this discussion.

Goals of the discussion
=======================

+ Find out what the community thinks of opening up HugeTLB as a more
  generic source of huge pages, not coupled to HugeTLBfs
    + Get feedback on guest_memfd using HugeTLB
+ Find out what the plan is for HugeTLB(fs) testing
    + Is the plan to continue maintaining tests in libhugetlbfs?
    + Should the tests be migrated as kernel selftests?
+ Gather key components that would need refactoring

Requested attendees
===================

+ David Hildenbrand
+ Muchun Song
+ Oscar Salvador
+ Peter Xu

References
==========

[1] https://lore.kernel.org/all/cover.1726009989.git.ackerleytng@google.com/T/
[2] https://lore.kernel.org/all/cover.1770854662.git.ackerleytng@google.com/T/
[3] https://github.com/libhugetlbfs/libhugetlbfs/


Thanks,

Ackerley

