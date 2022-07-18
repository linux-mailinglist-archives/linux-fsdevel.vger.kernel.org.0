Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC15787AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 18:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiGRQnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiGRQnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:32 -0400
X-Greylist: delayed 243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 09:43:29 PDT
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285802B1A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 09:43:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,281,1650960000"; 
   d="scan'208";a="79810792"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 18 Jul 2022 08:36:16 -0800
IronPort-SDR: RTjfIgzc+dEN6kC/wiahZ34aDq4N/lz4wt2gOaf3gyvKgbBgy7GQpdrAGz0TSAiEUWi+ya5Unr
 gmkYsvQK+ohtMCEWFgUOpyY66f9X39W1vVK02qBI1H5onSYK75Pc/1vMoVCUJxGv33IMPq9bQ2
 oVXSpXODQ6Og1foDv+s8GFj50phjddzVPBJt2HR23rxJmXRZiaFdLlzC1jNdr2lwwmR5DNHLGX
 AK5/7yyQ++vhwU/PHSyXdo4u6nIwJuPb8F93oY3w+emM9L4h04z8oSkrSns1WQE8vNYUpZYkVK
 UJM=
Message-ID: <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
Date:   Mon, 18 Jul 2022 17:36:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Content-Language: en-GB
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
CC:     Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
 <4bc349a59e4042f7831b1190914851fe@huawei.com>
 <20220615092712.GA4068@lxhi-065>
From:   Jim Baxter <jim_baxter@mentor.com>
Organization: Siemens Digital Industries Software
In-Reply-To: <20220615092712.GA4068@lxhi-065>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-13.mgc.mentorg.com (139.181.222.13) To
 svr-ies-mbx-12.mgc.mentorg.com (139.181.222.12)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/06/2022 10:27, Eugeniu Rosca wrote:
> Hello Roberto,
> 
> On Fr, Jun 10, 2022 at 03:38:24 +0000, Roberto Sassu wrote:
>> I would be happy to address the remaining concerns, or take more
>> suggestions, and then develop a new version of the patch set.
> I face a number of conflicts when I try to rebase the latest openEuler
> commits against vanilla master (v5.19-rc2). Do you think it is possible
> to submit the rebased version to ML?
> 
> In addition, I can also see some open/unresolved points from Mimi [*].
> Did you by chance find some mutual agreement offline or do you think
> they would still potentially need some attention?
> 
> Maybe we can resume the discussion once you submit the rebased series?
> 
> Many thanks and looking forward to it.
> 
> [*] Potentially comments which deserve a reply/clarification/resolution
> 
> https://lore.kernel.org/lkml/1561985652.4049.24.camel@linux.ibm.com/#t
> https://lore.kernel.org/lkml/1561908456.3985.23.camel@linux.ibm.com/
> 
> BR, Eugeniu.
> 


Hello,

I have been testing these patches and do not see the xattr information when
trying to retrieve it within the initramfs, do you have an example of how
you tested this originally?


So far I have set the xattr in the rootfs before creating the cpio file like this:
$ setfattr -n user.comment -v "this is a comment" test.txt
If I access the data here it works:
$ getfattr test.txt 
# file: test.txt
user.comment


Then I package it and try to verify it with this command:
$getfattr /test.txt

Which returns to the command line without the data.



I believe the cpio is working because I see the file /METADATA\!\!\! in
the target root filesystem, which shows the following when viewed with cat -e:
00000028^A^Auser.comment^@this is a comment

This matches the data I fed in at the start, so I believe the data is being
transferred correctly but I am accessioning it with the wrong tools.

Thank you for any help.

Best regards,
Jim
