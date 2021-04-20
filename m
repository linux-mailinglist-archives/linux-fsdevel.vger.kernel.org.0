Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F73653F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhDTIXN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:23:13 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:7221 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230082AbhDTIXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:23:13 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Feng Tang <feng.tang@intel.com>, <linux-doc@vger.kernel.org>
Subject: [PATCH 0/2 V6]Add dma-buf counter
Date:   Tue, 20 Apr 2021 10:22:18 +0200
Message-ID: <20210420082220.7402-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=3YhXtTcJ-WEA:10 a=QyXUC8HyAAAA:8 a=6icRsfec0oETIK1Ck8AA:9 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dma-buf counter is a metric for mapped memory used by it's clients.
It is a shared buffer that is typically used for interprocess communication
or process to hardware communication. In android we used to have ION,. but
it is now replaced with dma-buf. ION had some overview metrics that was similar.



V1
	initial version. Add dma-buf counter

V2
	Fix build depencendy error suggested by Matthew Wilcox
	Extent commit message sugged by Köning

V3
	Change variable and function names.

V4
	Fix function name in code doc
	Reported-by: kernel test robot <lkp@intel.com>

V5
	Removed EXPORT_SYMBOL_GPL suggested by Muchun Song

V6
	Made it a patch set, Adding a addional patch for
	printing dma-buf counter in show_mem.
	Suggested by Michal Hocko.




	

