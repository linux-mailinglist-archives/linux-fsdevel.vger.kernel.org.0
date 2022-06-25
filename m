Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2C55A889
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiFYJbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiFYJbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:31:45 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2752F000;
        Sat, 25 Jun 2022 02:31:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VHKru9h_1656149498;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHKru9h_1656149498)
          by smtp.aliyun-inc.com;
          Sat, 25 Jun 2022 17:31:40 +0800
Date:   Sat, 25 Jun 2022 17:31:38 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, hughd@google.com, ran.xiaokai@zte.com.cn,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] drop caches: skip tmpfs and ramfs
Message-ID: <YrbV+gb2QIUDDCob@B-P7TQMD6M-0146.local>
Mail-Followup-To: cgel.zte@gmail.com, viro@zeniv.linux.org.uk,
        hughd@google.com, ran.xiaokai@zte.com.cn,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220624182121.995294-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624182121.995294-1-ran.xiaokai@zte.com.cn>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:21:21PM +0000, cgel.zte@gmail.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> All tmpfs and ramfs pages have PG_dirty bit set
> once they are allocated and added to the pagecache。So pages

minor,
                                                    ^
                                   Chinese full stop here..

Thanks,
Gao Xiang
