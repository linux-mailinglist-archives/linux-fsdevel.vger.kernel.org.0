Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469BC78CEE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbjH2Vk5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbjH2VkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:40:20 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A1CC5;
        Tue, 29 Aug 2023 14:40:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 14AC36418DB5;
        Tue, 29 Aug 2023 23:40:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T15fzfizWr_R; Tue, 29 Aug 2023 23:40:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B9F0A6234895;
        Tue, 29 Aug 2023 23:40:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RLg-BfgEuY4p; Tue, 29 Aug 2023 23:40:13 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BD946418DB5;
        Tue, 29 Aug 2023 23:40:13 +0200 (CEST)
Date:   Tue, 29 Aug 2023 23:40:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        christian <christian@brauner.io>, ipedrosa <ipedrosa@redhat.com>,
        gscrivan <gscrivan@redhat.com>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>, acl-devel <acl-devel@nongnu.org>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ebiederm <ebiederm@xmission.com>
Message-ID: <1440169338.1870238.1693345213391.JavaMail.zimbra@nod.at>
In-Reply-To: <34cb77d8-6513-138e-506e-82f4c66d7813@kernel.org>
References: <20230829205833.14873-1-richard@nod.at> <20230829205833.14873-3-richard@nod.at> <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org> <34cb77d8-6513-138e-506e-82f4c66d7813@kernel.org>
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: user_namespaces.7: Document pitfall with negative permissions and user namespaces
Thread-Index: zULDpyr32gAO6KEDzSUYLMlKPoFQcQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Alejandro Colomar" <alx@kernel.org>
>> uid=1000(alx) gid=1000(alx)
>> groups=1000(alx),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),108(netdev),115(lpadmin),118(scanner)
>> $ unshare ‐S 0 ‐G 0 ‐‐map‐users=100000,0,65536 ‐‐map‐groups=100000,0,65536 id
>> unshare: failed to execute ‐S: No such file or directory
> 
> Ahh, now I see it.  You should use \- to produce pastable ASCII 0x2D.

Sorry for that. My troff fu is weak. :-)

Thanks,
//richard
