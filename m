Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23256524580
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbiELGSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 02:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350229AbiELGSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 02:18:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE031356A7;
        Wed, 11 May 2022 23:18:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 564D968BFE; Thu, 12 May 2022 08:18:08 +0200 (CEST)
Date:   Thu, 12 May 2022 08:18:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     axboe@kernel.dk, hch@lst.de, torvalds@linux-foundation.org,
        mingo@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 1/1] =?utf-8?Q?fs-writeback?=
 =?utf-8?Q?=3A_writeback=5Fsb=5Finodes=EF=BC=9ARecalculat?=
 =?utf-8?Q?e?= 'wrote' according skipped pages
Message-ID: <20220512061808.GA20448@lst.de>
References: <20220510133805.1988292-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510133805.1988292-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
