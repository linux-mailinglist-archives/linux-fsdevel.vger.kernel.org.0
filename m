Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4134FB7E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiDKJnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiDKJnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:43:00 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F6633337C;
        Mon, 11 Apr 2022 02:40:45 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A6M8a2qgnGd7WypjXg+Mv9q4IX161cREKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVTm2cdXmmHOfbZM2qhftkgatuzphsG6JSAxtJnTFRv/Hw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl6pDMlxyYKBMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTVeBqicYiJc/pPYoZ4Vlg0DjGAPdgSpfGK43K7t9w3?=
 =?us-ascii?q?TE+nMlCEP/SIc0DZlJHYB3GJR8JJVYTDJM3mfyAh3/jfjkeo1WQzYI74XfUygN?=
 =?us-ascii?q?Z07X3NtfRPNuQSq19mkeeu3KD+mHRAQ8TP9/ZziCKmlqqmOPOmCbTXIMJCKb+8?=
 =?us-ascii?q?v9snU3VymENYDUWXluTpeKlzEKzM/pdIkoZvCEusIA17kWgStS7VBq9yFaAvxg?=
 =?us-ascii?q?BS59eCOE39gyJ4rTb7hzfBWUeSDNFLts8u6ceQT0sy0/MnN7zAzFrmKOaRGjb9?=
 =?us-ascii?q?bqOqz62fy8PIgcqYS4CUBtA89f4iJ88gwiJTdt5FqOxyNrvFlnNL5qixMQlr+x?=
 =?us-ascii?q?Ly5dViOPgphaa6w9Ab6PhFmYdjjg7lEr/hu+hWLOYWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AovHysay6vMSIezTU5dK2KrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SL37qynIpoVj6faUskd2ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2l?=
 =?us-ascii?q?HFEGgK1+KLqFeMJ8S9zJ856U4KSchD4bPLfDtHZIrBgTVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123470963"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Apr 2022 17:40:45 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 689E24D16FCF;
        Mon, 11 Apr 2022 17:40:39 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 11 Apr 2022 17:40:42 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 11 Apr 2022 17:40:37 +0800
Message-ID: <b4731bc6-39d5-a11e-0ea2-49b768b785bb@fujitsu.com>
Date:   Mon, 11 Apr 2022 17:40:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 5/7] mm: Introduce mf_dax_kill_procs() for fsdax case
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
 <20220410160904.3758789-6-ruansy.fnst@fujitsu.com>
 <ad34d938-6131-d48f-b14b-6c1e3280b3f7@huawei.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <ad34d938-6131-d48f-b14b-6c1e3280b3f7@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 689E24D16FCF.A317E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/4/11 14:40, wangjianjian (C) 写道:
>  >> This new function is a variant of mf_generic_kill_procs that accepts a
>  >> file, offset pair instead o a struct to support multiple files 
> sharing a
> typo, instead of

Thanks for pointing out!


--
Ruan.


