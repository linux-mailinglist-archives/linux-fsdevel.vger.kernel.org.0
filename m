Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528D64EBB1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiC3GvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbiC3GvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:51:18 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 254C51A394;
        Tue, 29 Mar 2022 23:49:33 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ApRIUU6zKP5o0Vfxdkx96t+dIxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGgmgzxSm2RLWz2BafeMZ2P2KtBzPY/ioEJVvZPXydE3HQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeWceSjh6JTJp6HBWz62qxl0N2k6NJMZ9s55G2Z?=
 =?us-ascii?q?L8uYSKSxLZReG78q2y7KTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+Agnj5bi0drVe9prQ+6GuVyxZ?=
 =?us-ascii?q?+uJDrLtbUf9miQcROgl3eomPA4nS/DhwEXPSfwjqt9mmwwOPC9Qv5UYQfUra46?=
 =?us-ascii?q?9ZtmlSYwmFVAxoTPXO/oP+kmguwQN5SNUEQ0jQhoLJ090GxSNT5GRqirxasuh8?=
 =?us-ascii?q?aRsoVEOAg7gyJ4rTb7hzfBWUeSDNFLts8u6ceQT0sy0/Mj93yLSJgvafTSn+H8?=
 =?us-ascii?q?LqQ6zSoNkAowcUqDcMfZVJdpYC9/8do1VSSJuuP2ZWd1rXdcQwcCRjTxMTmu4g?=
 =?us-ascii?q?usA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcJ8cWqulWiGSYbbGKlIs1Bwy7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123086102"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Mar 2022 14:49:33 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 47D3F4D17163;
        Wed, 30 Mar 2022 14:49:32 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 30 Mar 2022 14:49:32 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 30 Mar 2022 14:49:32 +0800
Received: from [10.167.201.8] (10.167.201.8) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 30 Mar 2022 14:49:31 +0800
Message-ID: <eb7c0403-1d1f-5de4-8cdd-52a8de148fbe@fujitsu.com>
Date:   Wed, 30 Mar 2022 14:49:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 5/8] mm: move pgoff_address() to vma_pgoff_address()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-6-ruansy.fnst@fujitsu.com>
 <YkPuooGD139Wpg1v@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YkPuooGD139Wpg1v@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 47D3F4D17163.A0D9B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/3/30 13:46, Christoph Hellwig 写道:
> On Sun, Feb 27, 2022 at 08:07:44PM +0800, Shiyang Ruan wrote:
>> Since it is not a DAX-specific function, move it into mm and rename it
>> to be a generic helper.
> 
> FYI, there is a patch in -mm and linux-next:
> 
>    "mm: rmap: introduce pfn_mkclean_range() to cleans PTEs"
> 
> that adds a vma_pgoff_address which seems like a bit of a superset of
> the one added in this patch, but only is in mm/internal.h.

Yes.  The function in this patch handles more cases.

So, let me rebase onto this patch and move the function into 
/include/linux/mm.h, so that fs/dax.c can also use it.  Is this ok?


--
Thanks,
Ruan.


