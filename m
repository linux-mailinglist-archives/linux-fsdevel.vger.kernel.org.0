Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5736F0AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhD2TrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 15:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237781AbhD2Tqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619725550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46vr6MOxvMx7EcNeLrQPCFzx6v2cxfIGSgLQQ+snNgQ=;
        b=dEvGNPfHCVP1XUi6b0tgVv5pCcMSMGAYn2O78d7MpfX4RzlrvEBayEStQQHtUknsy33Jb/
        6HDcQIj7wnYWComQFwrimoxfhi1zHILt13FOUt7u/0g0dBfc+Aqe8IWuD3K3dN59WJFkaB
        hm1//v1AoeYLBatp6cMt2vok7K49Xyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-2E-ZcLmyNSmk8WkXdFT6MA-1; Thu, 29 Apr 2021 15:45:48 -0400
X-MC-Unique: 2E-ZcLmyNSmk8WkXdFT6MA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 349D5818411;
        Thu, 29 Apr 2021 19:45:44 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DA6110016FC;
        Thu, 29 Apr 2021 19:45:40 +0000 (UTC)
Date:   Thu, 29 Apr 2021 15:45:37 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     "Chu,Kaiping" <chukaiping@baidu.com>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3]
 mm/compaction:let proactive compaction order configurable
Message-ID: <YIsM4UtV9UqKhsNB@optiplex-fbsd>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
 <YIYX22JLVHN1PhGs@t490s.aquini.net>
 <f355248969f14e5897ad6dcfe3834297@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f355248969f14e5897ad6dcfe3834297@baidu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 01:17:40AM +0000, Chu,Kaiping wrote:
> Please see my answer inline.
> 
> -----邮件原件-----
> 发件人: Rafael Aquini <aquini@redhat.com> 
> 发送时间: 2021年4月26日 9:31
> 收件人: Chu,Kaiping <chukaiping@baidu.com>
> 抄送: mcgrof@kernel.org; keescook@chromium.org; yzaikin@google.com; akpm@linux-foundation.org; vbabka@suse.cz; nigupta@nvidia.com; bhe@redhat.com; khalid.aziz@oracle.com; iamjoonsoo.kim@lge.com; mateusznosek0@gmail.com; sh_def@163.com; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-mm@kvack.org
> 主题: Re: [PATCH v3] mm/compaction:let proactive compaction order configurable
> 
> On Sun, Apr 25, 2021 at 09:21:02AM +0800, chukaiping wrote:
> > Currently the proactive compaction order is fixed to 
> > COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of 
> > normal 4KB memory, but it's too high for the machines with small 
> > normal memory, for example the machines with most memory configured as 
> > 1GB hugetlbfs huge pages. In these machines the max order of free 
> > pages is often below 9, and it's always below 9 even with hard 
> > compaction. This will lead to proactive compaction be triggered very 
> > frequently. In these machines we only care about order of 3 or 4.
> > This patch export the oder to proc and let it configurable by user, 
> > and the default value is still COMPACTION_HPAGE_ORDER.
> > 
> > Signed-off-by: chukaiping <chukaiping@baidu.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Two minor nits on the commit log message: 
> * there seems to be a whitespage missing in your short log: 
>   "... mm/compaction:let ..."
> --> I will fix it in next patch.
> 
> * has the path really been reported by a test robot?
> --> Yes. There is a compile error in v1, I fixed it in v2.
>

So, no... the test robot should not be listed as Reported-by. 

