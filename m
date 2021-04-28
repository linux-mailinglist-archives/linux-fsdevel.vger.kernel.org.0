Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45736DF54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbhD1TEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 15:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243696AbhD1TES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619636613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MLrGc/XGIkKevghVxu7iMDBjiIgG5ql+h/MHMCYHiOM=;
        b=Y5aIegwwrb3C5kvrWuzQdU/KjG4sDPu2NW5WbRLqoQmLWRjnMQWVhCfsU3L2UOOEmlzuv4
        wY1Jl2JiuVxScb6JBlIETzxiEVDoc3/XrUaFf3H6Uzr9LlWZcJjLGRH7QWNBmOg+0I7gXI
        2deN1iiJXjFFlpJxUh1OVs95U1o5Xic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-rjo6gzNJMYSjlXBdKxL2Rg-1; Wed, 28 Apr 2021 15:03:29 -0400
X-MC-Unique: rjo6gzNJMYSjlXBdKxL2Rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 924BD106BB3B;
        Wed, 28 Apr 2021 19:03:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DCEC10027A5;
        Wed, 28 Apr 2021 19:03:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2A155220BCF; Wed, 28 Apr 2021 15:03:24 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, willy@infradead.org, jack@suse.cz,
        groug@kaod.org
Subject: [PATCH v6 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date:   Wed, 28 Apr 2021 15:03:11 -0400
Message-Id: <20210428190314.1865312-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V6. Only change since V5 is that I changed order of WAKE_NEXT
and WAKE_ALL in comments too.

Vivek

Vivek Goyal (3):
  dax: Add an enum for specifying dax wakup mode
  dax: Add a wakeup mode parameter to put_unlocked_entry()
  dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.25.4

