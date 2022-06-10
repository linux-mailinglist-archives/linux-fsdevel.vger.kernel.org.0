Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF09546982
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbiFJPik convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbiFJPi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:38:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70126D925;
        Fri, 10 Jun 2022 08:38:27 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKQ3K4K7hz67KPP;
        Fri, 10 Jun 2022 23:33:33 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:38:24 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Fri, 10 Jun 2022 17:38:24 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bug-cpio@gnu.org" <bug-cpio@gnu.org>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "takondra@cisco.com" <takondra@cisco.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "james.w.mcmechan@gmail.com" <james.w.mcmechan@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Thread-Topic: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Thread-Index: AQHYe+tsPH1HC/8x8Uq7oovD5MPpKK1G5r2QgAG+ywCAACILEA==
Date:   Fri, 10 Jun 2022 15:38:24 +0000
Message-ID: <4bc349a59e4042f7831b1190914851fe@huawei.com>
References: <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
 <541e9ea1-024f-5c22-0b58-f8692e6c1eb1@landley.net>
 <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
In-Reply-To: <20220610153336.GA8881@lxhi-065>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.21]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Eugeniu Rosca [mailto:erosca@de.adit-jv.com]
> Sent: Friday, June 10, 2022 5:34 PM
> Hello Roberto,
> 
> On Do, Jun 09, 2022 at 11:05:45 +0000, Roberto Sassu wrote:
> > > From: Eugeniu Rosca [mailto:erosca@de.adit-jv.com]
> > > Sent: Thursday, June 9, 2022 12:26 PM
> > > Dear Roberto,
> > > Cc: Yamada-san, linux-kbuild
> > >
> > > On Mi, Jul 24, 2019 at 05:34:53 +0200, Roberto Sassu wrote:
> > > > Is there anything I didn't address in this patch set, that is delaying
> > > > the review? I would appreciate if you can give me a feedback, positive
> > > > or negative.
> > > >
> > > > Thanks a lot!
> > > >
> > > > Roberto
> > >
> > > Some of our users have recently asked for this patch series.
> >
> > Hello
> >
> > thanks for your interest in this patch set.
> >
> > > Could you please feedback if this is the latest revision available or
> > > maybe there is a newer one developed and potentially not shared on LKML?
> >
> > Yes, it is the latest revision available. There might have been few
> > fixes in the final code. You may want to have a look at:
> 
> Many thanks for the links to the updated patch revisions. It looks
> like the new versions added a couple of bugfixes and refinements.
> 
> With more users now using this feature, do you think there is a higher
> chance for upstreaming, compared to 2019 (original submission date)?

Hello Eugeniu

I would be happy to address the remaining concerns, or take more
suggestions, and then develop a new version of the patch set.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Yang Xi, Li He
