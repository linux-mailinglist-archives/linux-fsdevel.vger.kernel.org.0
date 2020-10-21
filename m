Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3E294B38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392269AbgJUK0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 06:26:41 -0400
Received: from mx4.veeam.com ([104.41.138.86]:35840 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390048AbgJUK0k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:26:40 -0400
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id B5A348A76E;
        Wed, 21 Oct 2020 13:26:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1603275998; bh=/p6v/6SAhY5h2ewrJ9FDQ7iNuIivMlmHNS95z40vB54=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=jrDBfzIYLZTU18COuJMG0YH/YRmu3Q2RULo8V7nTZTWqSfnco57Gjh+9xOeIo3NaI
         DD/wJhV5nzj4GgE0Gu4lUnVWX35iD1GJuqg39VSgVYIWx4tn/xt9ulFjk+JltEEkS1
         opM1cZ9QZI/RTdxiEPExGJcHHduM+DtFPWfA6B5o=
Received: from veeam.com (172.24.14.5) by spbmbx01.amust.local (172.17.17.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3; Wed, 21 Oct 2020
 13:26:35 +0300
Date:   Wed, 21 Oct 2020 13:27:24 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Message-ID: <20201021102724.GC20749@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
 <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx02.amust.local (172.17.17.172) To
 spbmbx01.amust.local (172.17.17.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A295605D26A677560
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXPORT_SYMBOL_GPL - ok.

#ifdef CONFIG_BLK_FILTER or IS_ENABLED() - It's a matter of habit.

> double blank line
Ok, I did.
Looks like a candidate for ./scripts/checkpatch.pl.

> Separate into multiple patches: one that introduces the filter
> functions/ops code and another that changes the block layer where needed.

I'll think about it. Personally, it seems to me that this separation
does not make it easier to understand the code. 
It is important for me to know immediately where the function is called,
and this determines its behavior.

-- 
Sergei Shtepa
Veeam Software developer.
