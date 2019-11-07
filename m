Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4989CF38DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 20:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKGTm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 14:42:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726019AbfKGTm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573155745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z8s+/o9fKO8+Q0RAqw1ZIHuCdxl2SlwI1ZLCvKr+9Y4=;
        b=Q3tOqo3SFekbVD7CYlp3LVp1V5e5VQ75vPg0uK150A+abYVpKqwHPJOn/7hSaO2XOXiZid
        UFHb3FjnVA3VLES2r6NIhkJmcs6WFHa0AIHB5dcCUMAkgd8O8IF0ag3z3y2n5dWKSO4T3K
        n2O7qFg8MZ7p565d4ty0oWgMP8Hn7Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-NP7UO9TzMBGw2qzZNdg3dQ-1; Thu, 07 Nov 2019 14:42:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62284477;
        Thu,  7 Nov 2019 19:42:22 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5C2210016DA;
        Thu,  7 Nov 2019 19:42:21 +0000 (UTC)
To:     fsdevel <linux-fsdevel@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2] avoid softlockups in various s_inodes iterators
Cc:     Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <cb77c8d5-e894-4e9d-bf6f-fc1be14c5423@redhat.com>
Date:   Thu, 7 Nov 2019 13:42:20 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NP7UO9TzMBGw2qzZNdg3dQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2 patches to make sure we either schedule in an s_inodes walking
loop, or do our best to limit the size of the walk, to avoid soft
lockups.

-Eric

