Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772377B85A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 05:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfGaDuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 23:50:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGaDug (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBFF5309175E;
        Wed, 31 Jul 2019 03:50:36 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0FD360BEC;
        Wed, 31 Jul 2019 03:50:36 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id AD39841F53;
        Wed, 31 Jul 2019 03:50:36 +0000 (UTC)
Date:   Tue, 30 Jul 2019 23:50:36 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dan j williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com,
        jencce kernel <jencce.kernel@gmail.com>
Message-ID: <1887039269.5822356.1564545036201.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190730190737.GA14873@redhat.com>
References: <20190730113708.14660-1-pagupta@redhat.com> <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com> <20190730190737.GA14873@redhat.com>
Subject: Re: dm: fix dax_dev NULL dereference
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.109, 10.4.195.28]
Thread-Topic: fix dax_dev NULL dereference
Thread-Index: t64YiHL2yO3dmKpuGShiDkq8uuDxtg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 31 Jul 2019 03:50:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 
> I staged the fix (which I tweaked) here:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e
> 
> Also, please note this additional related commit that just serves to
> improve a related function name and clean up some whitespace:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=f965f935a89bb174fd3f6d6b51bba91c1ed258c5
> 
> I'll likely send these to Linus for 5.2-rc3 later this week.

o.k

Thank you,
Pankaj

> 
> Thanks,
> Mike
> 
