Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94714EA51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 10:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgAaJ66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 04:58:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50700 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728240AbgAaJ66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580464735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=pM0c0LfCmKVDajSmt5fafYF9h1wpifXzFg1uGepQ6zc=;
        b=V6bi58ab168P1qAWqS4/zgVs1R1JMZNiwMReUG0bHYu/sXnkGErdH/1WHDZ12Dpixlg50M
        Ti4qYu8HQkvMYuy+nGEt54kxgzr0LlwpJgvazOf3jrjqyMyfilr5HDsHVpJdLqNClruk2W
        f77lTAzaeLrUX8+sceb+/1TypwcNrYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-gcltkZgOPJKRkg8LHAmksw-1; Fri, 31 Jan 2020 04:58:50 -0500
X-MC-Unique: gcltkZgOPJKRkg8LHAmksw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72D9A0CBF;
        Fri, 31 Jan 2020 09:58:49 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C18C45D9E5;
        Fri, 31 Jan 2020 09:58:48 +0000 (UTC)
Date:   Fri, 31 Jan 2020 10:58:46 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.35.1
Message-ID: <20200131095846.ogjtqrs7ai774tka@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux stable release v2.35.1 is available at:
            
  http://www.kernel.org/pub/linux/utils/util-linux/v2.35/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux 2.35.1 Release Notes
===============================

build-sys:
   - add --disable-hwclock-gplv3  [Karel Zak]
chrt:
   - Use sched_setscheduler system call directly  [jonnyh64]
lib/randutils:
   - use explicit data types for bit ops  [Karel Zak]
libfdisk:
   - fix __copy_partition()  [Karel Zak]
   - make sure we use NULL after free  [Karel Zak]
libmount:
   - fix x- options use for non-root users  [Karel Zak]
po:
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
sfdisk:
   - make sure we do not overlap on --move  [Karel Zak]
   - remove broken step alignment for --move  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

