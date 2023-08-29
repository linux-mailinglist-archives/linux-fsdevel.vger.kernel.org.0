Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55EA78CEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbjH2Vju convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbjH2Vjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:39:36 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC48E9;
        Tue, 29 Aug 2023 14:39:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 520956418DB5;
        Tue, 29 Aug 2023 23:39:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ncfp1MIsF_90; Tue, 29 Aug 2023 23:39:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F21426234895;
        Tue, 29 Aug 2023 23:39:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IFp88w5xPKFi; Tue, 29 Aug 2023 23:39:10 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CB4DC6418DB5;
        Tue, 29 Aug 2023 23:39:10 +0200 (CEST)
Date:   Tue, 29 Aug 2023 23:39:10 +0200 (CEST)
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
Message-ID: <300010998.1870230.1693345150665.JavaMail.zimbra@nod.at>
In-Reply-To: <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
References: <20230829205833.14873-1-richard@nod.at> <20230829205833.14873-3-richard@nod.at> <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: user_namespaces.7: Document pitfall with negative permissions and user namespaces
Thread-Index: jYaPnZbASese77STm8QcfkgrfxyPfA==
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
> $ unshare ‐S 0 ‐G 0 ‐‐map‐users=100000,0,65536 ‐‐map‐groups=100000,0,65536 id
> unshare: failed to execute ‐S: No such file or directory

Well, maybe your unshare tool is too old.
AFAIK it uses newuidmap only in recent versions.

You can achieve the very same als using podman in rootless mode.
e.g.
podman run -it -v /scratch:/scratch/ bash -c "cat /scratch/games/game.txt"

Thanks,
//richard
