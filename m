Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F37B2E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbfG3THl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:07:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387619AbfG3THl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:07:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44DD93082A8B;
        Tue, 30 Jul 2019 19:07:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC7B660922;
        Tue, 30 Jul 2019 19:07:38 +0000 (UTC)
Date:   Tue, 30 Jul 2019 15:07:38 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     dan j williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com,
        jencce.kernel@gmail.com
Subject: Re: dm: fix dax_dev NULL dereference
Message-ID: <20190730190737.GA14873@redhat.com>
References: <20190730113708.14660-1-pagupta@redhat.com>
 <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Jul 2019 19:07:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I staged the fix (which I tweaked) here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e

Also, please note this additional related commit that just serves to
improve a related function name and clean up some whitespace:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=f965f935a89bb174fd3f6d6b51bba91c1ed258c5

I'll likely send these to Linus for 5.2-rc3 later this week.

Thanks,
Mike
