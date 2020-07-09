Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D321A12B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGINuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 09:50:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59095 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726772AbgGINuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594302601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wU/IYW624cTJ+phT8QcHfdGdebh3N/uM3T5RVMhvW8A=;
        b=brbz+Ad7T8EOeKhL4IGH6aopE7Zt4vTtc/qc2sW+g6Wb9P3DYLsEooI/78gtbGL7/gdfkZ
        XmPTiHfA6Xq28CXZud1c8TYspBWs1suzZXSg2xs/6SN7LF3p00YOYy2eQf5bekpJw9tgXX
        HE8SaDKt5sYtEzgH6GZZGKzWA2lB/24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-wK33q6onO3WVT8WIpOKZrA-1; Thu, 09 Jul 2020 09:49:58 -0400
X-MC-Unique: wK33q6onO3WVT8WIpOKZrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F455100CC84;
        Thu,  9 Jul 2020 13:49:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7098C5D98A;
        Thu,  9 Jul 2020 13:49:56 +0000 (UTC)
Date:   Thu, 9 Jul 2020 15:49:53 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.36-rc2
Message-ID: <20200709134953.ist5schagi3hjhs7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.36-rc2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.36
 
Feedback and bug reports, as always, are welcomed.
 
  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

