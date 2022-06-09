Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076B15448CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiFIK0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiFIK0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:26:36 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0A31D8712;
        Thu,  9 Jun 2022 03:26:35 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 7F5B0520171;
        Thu,  9 Jun 2022 12:26:33 +0200 (CEST)
Received: from lxhi-065 (10.72.94.24) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 9 Jun
 2022 12:26:32 +0200
Date:   Thu, 9 Jun 2022 12:26:27 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
CC:     Rob Landley <rob@landley.net>, <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Mimi Zohar <zohar@linux.ibm.com>, <viro@zeniv.linux.org.uk>,
        <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <zohar@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <arnd@arndb.de>,
        <james.w.mcmechan@gmail.com>, <linux-kbuild@vger.kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20220609102627.GA3922@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
 <541e9ea1-024f-5c22-0b58-f8692e6c1eb1@landley.net>
 <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.24]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Roberto,
Cc: Yamada-san, linux-kbuild

On Mi, Jul 24, 2019 at 05:34:53 +0200, Roberto Sassu wrote:
> Is there anything I didn't address in this patch set, that is delaying
> the review? I would appreciate if you can give me a feedback, positive
> or negative.
> 
> Thanks a lot!
> 
> Roberto

Some of our users have recently asked for this patch series.

Could you please feedback if this is the latest revision available or
maybe there is a newer one developed and potentially not shared on LKML?

Appreciate your time.

Thanks and Best Regards,
Eugeniu
