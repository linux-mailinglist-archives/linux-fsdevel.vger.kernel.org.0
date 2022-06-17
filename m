Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3845554EF57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 04:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379591AbiFQCcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 22:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiFQCcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA564D3F;
        Thu, 16 Jun 2022 19:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7062761CFB;
        Fri, 17 Jun 2022 02:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461E1C3411A;
        Fri, 17 Jun 2022 02:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655433118;
        bh=yr183iOvk+HdFa3z7/JDTOiLDCCurogTDkzDeVddOSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Az2aWTtaqCX0BGv63R8jEMtiSVAvAmWp4MtuC4x9IwlDA0o7Ckeb702oMsgk2xTJ2
         Wx9CGMKxOYja1upuOBnWPsp2lpevfUNZw1b/Xe1/ZeXKTGkqki+IqvTQ848Ue61/DC
         98QJMZqkU5cxQ+Z5NEdFYoxB5I2q7VM+GDq+wk2A=
Date:   Thu, 16 Jun 2022 19:31:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>
Subject: Re: [PATCHSETS v2]  v14 fsdax-rmap + v11 fsdax-reflink
Message-Id: <20220616193157.2c2e963f3e7e38dfac554a28@linux-foundation.org>
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Unless there be last-minute objections, I plan to move this series into
the non-rebasing mm-stable branch a few days from now.
