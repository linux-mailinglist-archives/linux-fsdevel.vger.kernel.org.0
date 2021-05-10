Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE3378B5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEJMGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 08:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242244AbhEJLlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 07:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620646819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=c2EMITgh/9rv6FOZ12NnHFSXYVvMF0DZkdWIA47bYTc=;
        b=AaRxPmVe4xsCQqTDTxvd8nvUzYnFkXUIPkk3sBNvPSoNSPhoxTbP4sQ4yWmQ4FM3vAe7Hk
        P+QrpcuhEfHrkEEt1WqQqaP1qpzcLN4tjKCOhD4PbiePnz2WXa9TRloG5+o3MPcQbLRT+W
        ffE8nUJD/PZ9qJcV1Ty8bqQ898fdLPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-KiWip6bgN-GIVK0iq1VKsg-1; Mon, 10 May 2021 07:40:16 -0400
X-MC-Unique: KiWip6bgN-GIVK0iq1VKsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D26C801817;
        Mon, 10 May 2021 11:40:16 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3306460936;
        Mon, 10 May 2021 11:40:15 +0000 (UTC)
Date:   Mon, 10 May 2021 13:40:12 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.37-rc2
Message-ID: <20210510114012.ggmuwudv3sel4w3m@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.37-rc2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.37/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

