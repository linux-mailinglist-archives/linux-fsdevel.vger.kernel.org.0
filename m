Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3D2CA2D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 13:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgLAMhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 07:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgLAMhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606826165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=493pPRQ1cbcXG7JuRF1/JbMIArV86P0mGsjOr36MtbE=;
        b=J7GV2szf8w97Y6Jmc8u0Hcbw81ZNUF+tGCWovg3fLYCYR3QGB67xZ3wR1NRpsLTUJkLXm2
        ZPdQ2jiGeim+ViRhD3oyfcTeRRJI0+JRYNvEzHTYxcPCXeiuvctyNCt5WO8cqPZtJx1225
        ACx5P/sKY+AUsUZuOSlVL08zbTS/p0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-5ZRgk0Z7N4-aZFRnblE5pw-1; Tue, 01 Dec 2020 07:36:01 -0500
X-MC-Unique: 5ZRgk0Z7N4-aZFRnblE5pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F921E7D2;
        Tue,  1 Dec 2020 12:36:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id F12E760BE5;
        Tue,  1 Dec 2020 12:35:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  1 Dec 2020 13:35:59 +0100 (CET)
Date:   Tue, 1 Dec 2020 13:35:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: add locking checks in proc_inode_is_dead
Message-ID: <20201201123556.GB2700@redhat.com>
References: <20201128175850.19484-1-wenyang@linux.alibaba.com>
 <87zh2yit5u.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh2yit5u.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/30, Eric W. Biederman wrote:
>
> Ouch!!!!  Oleg I just looked the introduction of proc_inode_is_dead in
> d855a4b79f49 ("proc: don't (ab)use ->group_leader in proc_task_readdir()
> paths") introduced a ``regression''.
>
> Breaking the logic introduced in 7d8952440f40 ("[PATCH] procfs: Fix
> listing of /proc/NOT_A_TGID/task") to keep those directory listings not
> showing up.

Sorry, I don't understand...

Do you mean that "ls /proc/pid/task" can see an empty dir? Afaics this
was possible before d855a4b79f49 too.

Or what?

Oleg.

