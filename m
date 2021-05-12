Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77C737C35B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhELPS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 11:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233747AbhELPOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 11:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620832409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6sJq4rMRAbxgIvmyJB2sV6vJPLFDz17fSE25ZSwMnj4=;
        b=GO76lTVsNgDJG1LYc8xM9CuO9rCLMTdMxrJrSgfrR+xchshmItZp706mu9vRJ/6Tp11E7C
        IEQv2dh8nM/p9bVesr5yysu+KlzZBtaOv/iq5Sz/LYAiTq8hEd1GYwMcNHkiS7kxL6/iuB
        IE2lyM65nclPuM/USMpCb9WEDl5rKAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-HwFQ6Z3JPZma1LzSSDSjFw-1; Wed, 12 May 2021 11:13:27 -0400
X-MC-Unique: HwFQ6Z3JPZma1LzSSDSjFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23CB410B0AC9;
        Wed, 12 May 2021 15:12:57 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F2BB1037F59;
        Wed, 12 May 2021 15:12:25 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com, synarete@gmail.com
Subject: [PATCH v3] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 16:12:22 +0100
Message-Id: <20210512151223.3512221-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2 -> v3:

 - Call truncate_pagecache_range, same as for hole punching.

 - Tidy up the tests of flags in mode.

 - Changed the test / example in the commit message to something
   a bit simpler to understand.

 - Retested it.

Rich.


