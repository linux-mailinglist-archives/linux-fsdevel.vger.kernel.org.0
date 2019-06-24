Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62E0519D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFXRnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 13:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfFXRnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB82A13AA9;
        Mon, 24 Jun 2019 17:43:13 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F92A5D9C5;
        Mon, 24 Jun 2019 17:42:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Date:   Mon, 24 Jun 2019 13:42:17 -0400
Message-Id: <20190624174219.25513-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 24 Jun 2019 17:43:24 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of this patchset is to allow system administrators to have
the ability to shrink all the kmem slabs in order to free up memory
and get a more accurate picture of how many slab objects are actually
being used.

Patch 1 adds a new memcg_iterate_all() that is used by the patch 2 to
iterate on all the memory cgroups.

Waiman Long (2):
  mm, memcontrol: Add memcg_iterate_all()
  mm, slab: Extend vm/drop_caches to shrink kmem slabs

 Documentation/sysctl/vm.txt | 11 ++++++++--
 fs/drop_caches.c            |  4 ++++
 include/linux/memcontrol.h  |  3 +++
 include/linux/slab.h        |  1 +
 kernel/sysctl.c             |  4 ++--
 mm/memcontrol.c             | 13 +++++++++++
 mm/slab_common.c            | 44 +++++++++++++++++++++++++++++++++++++
 7 files changed, 76 insertions(+), 4 deletions(-)

-- 
2.18.1

