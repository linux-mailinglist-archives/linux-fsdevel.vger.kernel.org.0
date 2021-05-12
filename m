Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD25F37BACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhELKiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 06:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhELKiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 06:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620815835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QCLzW8Yk++bJyAj34mvA1DmCasqmhv52I/3gH8ALD5U=;
        b=DXOiM0EOcd2nxIgg8pxStF1bdXXC5luOFzGo6Cgtpohn05dDuiHs2TgNPXPwh911wkivP+
        cfabNWeu2YNPBGzF2732myKjfe0MInhgl2GCJKT+o65nAQuIDG2oigYRgqKSa4sA+evFuO
        DexujwVXwNm3xrRDyZtZkdUpcJnMvwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-8rz8ZZZWMEWzuAwoekPQuw-1; Wed, 12 May 2021 06:37:13 -0400
X-MC-Unique: 8rz8ZZZWMEWzuAwoekPQuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D391B802958;
        Wed, 12 May 2021 10:37:12 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526C16E51F;
        Wed, 12 May 2021 10:37:07 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com
Subject: [PATCH v2] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 11:37:03 +0100
Message-Id: <20210512103704.3505086-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Version 2 restores the #comments in the script in the git commit
message.  The patch itself is identical.

Rich.


