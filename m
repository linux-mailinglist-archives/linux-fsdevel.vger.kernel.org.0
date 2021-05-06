Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA70375A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhEFSop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 14:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236510AbhEFSo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 14:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620326607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0DdCSc/lnUMdN2Old8KPS4mogM9XH4GyxeLrhNgeswc=;
        b=Xsg2MwQPsFydObfzRqgHgVzCfh8OiMXsSkdzcJukyEdSwitB/PGHxXrwbxwR5nFLICCxmJ
        2YJLKkVnDukcreEpK7tf39TLkDNT430plYs4BsNH7kXFUMfFAleK8YdC4JZe02KH2vNBrz
        B8ZQqYM2wqE3WC/cqiY1Ab35Y8Ri1Rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-3qKEFOo8Mt2tJc_7AmJIPQ-1; Thu, 06 May 2021 14:43:25 -0400
X-MC-Unique: 3qKEFOo8Mt2tJc_7AmJIPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 903A91009623;
        Thu,  6 May 2021 18:43:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-166.rdu2.redhat.com [10.10.114.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C59DE51C35;
        Thu,  6 May 2021 18:43:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 459FA22054F; Thu,  6 May 2021 14:43:19 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, dgilbert@redhat.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: [PATCH 0/2] virtiofs, dax: Fix couple of smatch warnings
Date:   Thu,  6 May 2021 14:43:02 -0400
Message-Id: <20210506184304.321645-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Dan Carpenter reported couple of smatch warning in fs/fuse/dax.c code.
These patches fix the warnings.

Thanks Dan.

Vivek

Vivek Goyal (2):
  virtiofs, dax: Fix smatch warning about loss of info during shift
  virtiofs, dax: Fixed smatch warning about ret being uninitialized

 fs/fuse/dax.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.25.4

